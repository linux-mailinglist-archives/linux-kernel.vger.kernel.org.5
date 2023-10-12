Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07287C6863
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjJLIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjJLIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:25:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43CB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:25:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso2470295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697099117; x=1697703917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6Cp4djRUeDiEy4xZu86ZIvejwMtz2L6/IM29LKj8uQ=;
        b=QmoF2smy0daSDAlVrqBLDzs+dbYfM8bMnITEUKXAbs1WkSqqGAu4XcHFDvq7EM2k+M
         RN5WaXDzReUA1JxnRkVIO+CK/2mHDJ8C7Mp20qAlxYlQd9nRGGd1qgeaQ6NIda2c9K/1
         aLKz0ZzDlcue2h5Zu4utZxyP5UWDWq79BQQD8y2/V6Lat1Kybe9E/D5G841oL05Zu+tD
         RC74htkqRSoMzoGvKVX3KT58YjjfO82MFub0B2AKRD2MRPodo7P7Fa6GSTjysYnSzWir
         wXIQsqfKbo5GbKKt6UaHwpw4GEghcIdrq0/BG/HsvIV2irt7P6cLTVKE7dQnInYLGNp3
         rfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099117; x=1697703917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6Cp4djRUeDiEy4xZu86ZIvejwMtz2L6/IM29LKj8uQ=;
        b=w22mhqwkT0hgJNLO1LkZb07+6Dsozn85KsovbQiK5s35t4thSOGSQKqWLvOJPKHExb
         AoaGiXzQMCiz5Oz/NohWNudVlCVfCeSBY9AEcN1TF0l/G5TKGlxaJJ1E/8oii6G6RHNi
         hTA6CoSsYFxAm/5dMIou5Nu0csXQSHSqh4/aIRXgy7cH3ji4/HD+BiM+057qsSn2nd9s
         1/vGVPL5e6jC15OQ9a1Xg3Ro6YYGUSfBE9LiWgxsjcwaGdyGNTzCPUTJG4STAmk9/UGo
         hCNbol8XfePe30HtZvS54L12+gFaV6E1Aey4KTT0VX3lABiKgYv/kGZ2G5Crz3ywuIkK
         dAWw==
X-Gm-Message-State: AOJu0YwqVNAoEQhg3Jn7YH+So3bCXqBZjwl7KdaHOm8O0v0WGMBNEmZ4
        QEAbgxQXPtUYKev93wsGGOgsuBkYv786WhvxGM8vHg==
X-Google-Smtp-Source: AGHT+IHmcKJuJlt+r5jebp/RgAKP2nkKAOCLCYajd0uJf4+i35/c+xqERVY+pbY3bOhPGrRVc9HHoQ==
X-Received: by 2002:a05:600c:214f:b0:406:513d:738f with SMTP id v15-20020a05600c214f00b00406513d738fmr21048700wml.2.1697099116857;
        Thu, 12 Oct 2023 01:25:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fed:c1e5:145f:8179? ([2a01:e0a:999:a3a0:3fed:c1e5:145f:8179])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4004000000b003197c7d08ddsm17766352wrp.71.2023.10.12.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:25:16 -0700 (PDT)
Message-ID: <8a4e0424-5bdb-4011-a7dc-8506c609384f@rivosinc.com>
Date:   Thu, 12 Oct 2023 10:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] riscv: report more ISA extensions through
 hwprobe
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <11d6a463-4e00-4407-9d93-2f9d190c4be3@rivosinc.com>
 <20231012-clanking-imagines-150a7c05f3f8@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231012-clanking-imagines-150a7c05f3f8@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2023 10:21, Conor Dooley wrote:
> On Thu, Oct 12, 2023 at 09:15:46AM +0200, Clément Léger wrote:
>> On second thought, maybe it would make more sense to squash all logical
>> commits together (dt-bindings, hwporobe, etc) with all the ISA
>> extensions in each. Tell me if you think it would be better.
> 
> I don't think there's anything wrong with the current approach.

Hi Conor,

Ok then, let's keep like this if there are no objection, I thought it
was a bit "too many" commits just for a few lines, but at least it's
unitary.

Thanks

Clément
