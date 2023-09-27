Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA37AFAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjI0GGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjI0GFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:05:54 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EDFC;
        Tue, 26 Sep 2023 23:05:52 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40528376459so105454115e9.3;
        Tue, 26 Sep 2023 23:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695794751; x=1696399551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzf3auFOPADoZEEKnwvAvKOmFmpAc1qrk78Z/GaSFMU=;
        b=m3zGMmg4egqI2BgHqSMFPi2xMDuaivHJvYPKiSw5qVswEIljK1JNciyV1RTSwdh6qX
         Xu0ZRMHCSu54ZxuMeZBnXpp5a1gl2HfSy06rdWQFh0WJaezJR485HE+POcbIujz7v9Qe
         BHo4butxjhYmh10XTGfX67ZlEKpDNTlfvp2sTI0P/s3cnMxcirAQsPQVCGqgjFEfzhek
         Twxr0SziWgPXQGXaBTnTfIRGXqv41wlNhWE753HJnjUGqt+0nIROxgzc6e//M7R9Els0
         IoZcA+W7Ih+C73uR46PlC/MuxUmgHGpM/O4ixzxRVUXNAzTRVpsDkUm57dzwcnhiLtqL
         eW9Q==
X-Gm-Message-State: AOJu0Yx7Paj46mRVPCjiT5aBiVwrabDtFqL0W/MRdO7XqHGD8Y4cfR7I
        u1Vt1ri2/XTyIeO1jQgYTT4=
X-Google-Smtp-Source: AGHT+IGKJGFGn4GVwZfT4SGNCkuVFhljd71lZh3+GhQ08MjmPhwykQ7MgIPHOLR2ikiXWikY/ceP4A==
X-Received: by 2002:a7b:c4cb:0:b0:405:a30:151e with SMTP id g11-20020a7bc4cb000000b004050a30151emr1008916wmk.12.1695794750977;
        Tue, 26 Sep 2023 23:05:50 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040550c20cbcsm12015055wmo.24.2023.09.26.23.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 23:05:50 -0700 (PDT)
Message-ID: <916aea7d-50ba-45d8-9b3c-0f507c922601@linux.com>
Date:   Wed, 27 Sep 2023 07:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH V3 RESEND 0/6] Power: T7: add power domain driver
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
 <169444496123.3944766.3763051739383485051.b4-ty@linaro.org>
Content-Language: en-US
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <169444496123.3944766.3763051739383485051.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-2023 16:09, Neil Armstrong wrote:
> Hi,
> 
> On Mon, 11 Sep 2023 10:52:17 +0800, Xianwei Zhao wrote:
>> First patch is that remove C3 some power domain ALWAYS_ON property.
>> Second patch is that add driver to support power parent node.
>> Third patch is that turn on power if initial power domain with
>> "AWAY_ON" property state is off.
>>
>> Other patchs adds power controller driver support for Amlogic T7 SoC.
>>
>> [...]
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)
> 
> [6/6] arm64: dts: amlogic: t7: add power domain controller node
>        https://git.kernel.org/amlogic/c/5355699dabac3c97492a30e6e01820fcaae11218
> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v6.7/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
I re-tested this today with Vim4 and works fine.
By works I mean, vim4 is able to boot without panics but drops to 
emergency shell as expected.

I was not able to find patches 1-3 and 5 at amlogic/for-next.
Is there a reason why amlogic/for-next only have DTs changes?

Tested-by: Lucas Tanure <tanure@linux.com>



