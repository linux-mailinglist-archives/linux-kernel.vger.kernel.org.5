Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6277D4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjHOVPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjHOVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:15:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D6AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:15:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so1211932466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692134126; x=1692738926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFaPUM6OGKjL7heKdSNW4ylbvnWM2Tax9xH36Ej8xmI=;
        b=p8e0jbjVH5XAqy90r+q8Ggo5ZQbgRA90aMDTQVbJCe93sdd5qbcoKqLTjOAPzJkI2c
         f+VFUkJUG1dt981Sa2W1qtnfXf800u/TYahnWDh1VZNMRXDbwWvku/2asYWJ6Trw5dxW
         aPtQqUf4Y7+FapIjLVG4FzEMSCH0j5Z4YuM3RHgcMKTvjC9zuVJzltVruWCKtc7VSeAQ
         VZkLFVKgAakXLRcmDdPbPAr5gBwAwrYm7Myb0WROFW06va0c7MiWlX/fF2ehgnRfiBrV
         WPGSqwOttNcPiWHE7C6HFDkFNDPuw4t+IwRRIuCvRwtAEqIqHm8weao9A1xH+CL9lTFa
         KJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134126; x=1692738926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFaPUM6OGKjL7heKdSNW4ylbvnWM2Tax9xH36Ej8xmI=;
        b=S2+ynRUdosR9gAYt5rwXhvvBOODrv6LwcMVLEsVp0bsXJArDexFEhld6UBo4JyvN4G
         A6MP/9p7vVAhb1WlYQRCxq8uAia+rM754i7hlOmMv9D5MrwzJ7gfOEg0ht3ET+05MXi+
         tSOSsZUMoL+bQQb1rFvvV4ES9WXZfD8fPsjgvXAZ2h6Kfrz/cIpLi323mo2ZIK58XRNq
         np/1zzgEJc5YiF1c2zHtyZttFs0g32/5WFUbHSMA9niRP+S+3h0bfnUUx8zK7C5O4+Wr
         rvSSyyHPMxrgqIEjiuRMZHieDaUQh6Grp5zCMUcaVGfOMCKooSqz0VmyFn7xbTl0B2iQ
         OoIg==
X-Gm-Message-State: AOJu0YzGS26VLaaLOEY39mlvNvDzZEwyMutbdB3frEpTGVXqrucGgxSo
        BCLes98g9q2rFIPraOrSQ6XMsLl8XyZLjNax4Vw=
X-Google-Smtp-Source: AGHT+IFabPaVP5DLcR7BtAD/7NeRP9lI+iUrNDDK9QJZ/8aQeCjq4VfiMHtSwPjZfUeGEMTtx/nJFw==
X-Received: by 2002:a17:907:96a0:b0:99c:c8eb:51b2 with SMTP id hd32-20020a17090796a000b0099cc8eb51b2mr3483869ejc.2.1692134125829;
        Tue, 15 Aug 2023 14:15:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709064d8a00b0099364d9f0e6sm7441940eju.117.2023.08.15.14.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:15:25 -0700 (PDT)
Message-ID: <a7956e13-7b94-fb65-8b43-f2c9fd014353@linaro.org>
Date:   Tue, 15 Aug 2023 23:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
To:     Justin Stitt <justinstitt@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 23:11, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/mtd/maps/physmap-versatile.c:209:25: warning: cast to smaller
> |               integer type 'enum versatile_flashprot' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         209 |                 versatile_flashprot = (enum versatile_flashprot)devid->data;
> 
> This is due to the fact that `devid->data` is a void* while `enum
> versatile_flashprot` has the size of an int. This leads to truncation
> and possible data loss.

Cast does not solve truncation. This part of commit msg suggests that
you actually fix real issue... and that is an issue, because then
AUTOSEL will grab it. This is just compiler warning silencing and rather
coding standard correctness, no real fix, so please drop the sentence.

> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: There is likely no data loss occurring here due to the fact that
> `enum versatile_flashprot` has only a few enumerated fields, none of
> which are large enough to cause data loss. 

If there is a data loss, cast does not solve it.

> Nonetheless, this patch helps
> towards the goal of eventually enabling this warning for more builds.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>


Best regards,
Krzysztof

