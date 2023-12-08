Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133A809AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573135AbjLHERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjLHEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:16:59 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CF171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:17:04 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d3d5b10197so14461957b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702009023; x=1702613823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7vp8x0oDP3EbH3U6bJ7KDFrE+BpYL9j1ysozmjTXzU=;
        b=NFG7bdsfJisiJhA3W0tSbbCa6ZaM4CRSXGTa/NP4zW3laxUFzVh0/0IYrSQ2OtJa2S
         /W3iwU/FGCPVuEMay7PCv9A3XpVZBbC90pcp5OTMFV5e4t8Ja/nSVU1ctBE0B9nFeSv8
         A5CklTxZmrJPT+TgqSNbtqIDHCqXAImbyieH6kZXJZekZOa8m/h4++F1UFEELySkVnxe
         jU137n0fSOHH+FxdIU+Hpe05fpvlTlC1uERHCvBxyzGXiQKtNdLAstdDJc5vVAYdWi64
         L7tkQA3xc+eC83f2vdk43Ac43jsMknAmZLorRrPCLzg7inwuGxqS5f/lijS4OOE+wL/G
         gcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702009023; x=1702613823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7vp8x0oDP3EbH3U6bJ7KDFrE+BpYL9j1ysozmjTXzU=;
        b=kC7GNIT7NK0+/r5SWncplzpM5t4P9L56JwEICPDAa2byqwCcNzPJAtZWa+ISzIukR/
         wY2a6WkCEVqVb0+UnCY8KO+rNSSILgTFSv8dYUMNlMdBq381wMd1Jwerf6hW5M2qKZi+
         dx81w95fGBk+FScxCLfE1WtzGICr/jmxDfVVTm0IHKabeQEZP8rG85SloTGlqO7ELXr3
         v9m1EvBr+f1z575QYjqdk92rgmjWQwj98J1cG+gxgBz8ZXbp9PnQaISjKzKMUI0zXbtw
         eEOSHWlLTIKtp6l3KJa7trIYxY1sS7aHM+B96Sk2egqca4n1a5e+z7VcrlJQN/LPWwck
         K5BQ==
X-Gm-Message-State: AOJu0Yx0DT0WXZYSLLVQ4T5v1+4Ymqf5TBkU+AiQxX+gXzUfi3zgSq38
        YNNIx6HLpT99yQHth93zi1SruA==
X-Google-Smtp-Source: AGHT+IFJ7rl316vQtE3r+S2OEJohJzfcnMzp0IFjlp1x5P7qNhZsNS2qZXmMmO5ixQp4wMXH8QWNgg==
X-Received: by 2002:a0d:e690:0:b0:5d7:1941:abb with SMTP id p138-20020a0de690000000b005d719410abbmr3581208ywe.86.1702009023272;
        Thu, 07 Dec 2023 20:17:03 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:41c5:bf1:860b:1e95? ([2600:1700:2000:b002:41c5:bf1:860b:1e95])
        by smtp.gmail.com with ESMTPSA id q5-20020a0ce9c5000000b0067ac1c30e80sm468893qvo.120.2023.12.07.20.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 20:17:02 -0800 (PST)
Message-ID: <86d857bf-a833-4529-aba9-391c49a3550b@sifive.com>
Date:   Thu, 7 Dec 2023 22:17:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] riscv: Add support for kernel-mode FPU
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-2-samuel.holland@sifive.com>
 <ZV283NfE/K5zLXDD@infradead.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZV283NfE/K5zLXDD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2023-11-22 2:33 AM, Christoph Hellwig wrote:
> On Tue, Nov 21, 2023 at 07:05:13PM -0800, Samuel Holland wrote:
>> +static inline void kernel_fpu_begin(void)
>> +{
>> +	preempt_disable();
>> +	fstate_save(current, task_pt_regs(current));
>> +	csr_set(CSR_SSTATUS, SR_FS);
>> +}
>> +
>> +static inline void kernel_fpu_end(void)
>> +{
>> +	csr_clear(CSR_SSTATUS, SR_FS);
>> +	fstate_restore(current, task_pt_regs(current));
>> +	preempt_enable();
>> +}
> 
> Is there any critical reason to inline these two?  I'd much rather see
> them out of line and exported instead of the low-level helpers.

No, I will define them out of line in v2.

Regards,
Samuel

