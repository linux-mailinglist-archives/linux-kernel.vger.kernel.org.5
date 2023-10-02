Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C297B5110
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjJBLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjJBLTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:19:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B999B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:19:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406553f6976so7477005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696245541; x=1696850341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IBk2yQCgJNwrSQBrXRJII+6gdKdvDeECA4pHuU8zrw=;
        b=0DB7v07gF3fiVWtT5/JUgFgrsJJB3nEY4hkh0d6UIdN0To6uX/4KIchNASF/jBf9DF
         ITdpoFKBlh/AAqwYnUjsF2i+3pjOao1RHae+dM2Sn25krfAEtNqU4kV+lAjIV4krn9Fv
         0ns5nQ+VkbgDbrhPYjizzs8rkBa1YfEp0TDy9Gp02rG9M2lnkw3gDeSFIB6IavzL2a60
         my57qp2XADXWNIwfwNiY0P+MJY6E8Zihg2sQLNYD+Ri5K7dktH975cLNSjRtqkXyP+Nj
         s7Sp1CifsN6yt69p0Wae48fP4sPvJwiPbOq6QlWoi+WK9w+NFV10+IFCOzsFNmajGjyY
         0PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696245541; x=1696850341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IBk2yQCgJNwrSQBrXRJII+6gdKdvDeECA4pHuU8zrw=;
        b=BBV+KE2lemTIeDsxP6/Mhk4bBdSQRto17EWS8GQYHe1HjnFSyqV+yCeozHFAliLP8r
         nCEJQT2CZVPCJtOoB6ILxbRZczqAsUtaNT2f3M0zY4WFHhltNsgXADBiXhzOVQ/0xpmV
         kKQL969PwxpDJ5oEUGMkyFEsQ6BV6w6qz1pOGZBzznBWQ3Hbc+6gAMv6eFgo9ugC6J7j
         tz3z+LJA7P13sAe42TfFl3mmgGOUDpDgiltU0oLNPq1sz0/TLw/Wl9VFjupZagEvl+Fs
         yamRNDFPSwR81MWtR+nf/madwxQqsxt9Mn4qQ8Gu4y5aLD0TpdjllJ5RbKg9qTLrCo+X
         vIAg==
X-Gm-Message-State: AOJu0YwP8FMfHtm7H+IFRNvN7Jp/Gn04pZNQ0yymmzVPpg9LTRko6FoD
        BBPLrnbL4PV3fPwBZ24QQl40SQ==
X-Google-Smtp-Source: AGHT+IGIH+t0eT2hy6BdihJbHdiZvxDZ0vJ8nw1AF1rd0+u1rWe03U4mwOM2KFr/MtA2vRH1iydH5g==
X-Received: by 2002:adf:e950:0:b0:317:7238:336a with SMTP id m16-20020adfe950000000b003177238336amr8806165wrn.5.1696245541298;
        Mon, 02 Oct 2023 04:19:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:2dc5:b516:f0fb:7491? ([2a01:e0a:999:a3a0:2dc5:b516:f0fb:7491])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm13880009wrn.114.2023.10.02.04.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:19:00 -0700 (PDT)
Message-ID: <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com>
Date:   Mon, 2 Oct 2023 13:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
 <20231002-spearman-doze-70cc026ac13e@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231002-spearman-doze-70cc026ac13e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2023 12:49, Conor Dooley wrote:
> On Mon, Oct 02, 2023 at 09:40:04AM +0200, Clément Léger wrote:
>>
>>
>> On 30/09/2023 11:23, Conor Dooley wrote:
>>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Clément Léger wrote:
>>>> Since commit 61cadb9 ("Provide new description of misaligned load/store
>>>> behavior compatible with privileged architecture.") in the RISC-V ISA
>>>> manual, it is stated that misaligned load/store might not be supported.
>>>> However, the RISC-V kernel uABI describes that misaligned accesses are
>>>> supported. In order to support that, this series adds support for S-mode
>>>> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
>>>>
>>>> Handling misaligned access in kernel allows for a finer grain control
>>>> of the misaligned accesses behavior, and thanks to the prctl call, can
>>>> allow disabling misaligned access emulation to generate SIGBUS. User
>>>> space can then optimize its software by removing such access based on
>>>> SIGBUS generation.
>>>>
>>>> Currently, this series is useful for people that uses a SBI that does
>>>> not handled misaligned traps. In a near future, this series will make
>>>> use a SBI extension [1] allowing to request delegation of the
>>>> misaligned load/store traps to the S-mode software. This extension has
>>>> been submitted for review to the riscv tech-prs group. An OpenSBI
>>>> implementation for this spec is available at [2].
>>>>
>>>> This series can be tested using the spike simulator [3] and an openSBI
>>>> version [4] which allows to always delegate misaligned load/store to
>>>> S-mode.
>>>
>>> Some patches in this series do not build for any configs, some are
>>> broken for clang builds and others are broken for nommu. Please try to> build test this more thoroughly before you submit the next version.
>>
>> Hi Conor,
>>
>> Thanks for the feedback, I'll check that.
>>
>>>
>>> Also, AIUI, this series should be marked RFC since the SBI extension
>>> this relies on has not been frozen.
>>
>> This series does not actually uses the SBI extension but provides a way
>> to detect if misaligned accesses are not handled by hardware nor by the
>> SBI. It has been reported by Ron & Daniel they they have a minimal SBI
>> implementation that does not handle misaligned accesses and that they
>> would like to make use of the PR_SET_UNALIGN feature. This is what this
>> series addresses (and thus does not depend on the mentioned SBI extension).
> 
> Ah, I must have misread then. Apologies.

No worries, maybe I should actually remove this from the cover letter to
avoid any confusion !

Clément
