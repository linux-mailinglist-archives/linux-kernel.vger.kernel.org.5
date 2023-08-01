Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7A76B6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHAOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHAOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:04:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876082718
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:04:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so32491025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690898680; x=1691503480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yEQ+0gFJ5msMJy9NJW+/6TCkt5+v4c6Eptgapu+lzY=;
        b=Pb2wnrMhG0utiyDoGj7AXhjJ6eresPqJkRtWlBEw+wBVwC1V55oNK7zVVofPMa7AC0
         +l1TlzjUi+VNKpMmMcQQihQo9crAt8/+YD0EvQ9QCOglo+dBdf05aqb3HL0eTyErHq6W
         5UHtXAzKbKDjittnA8cj1qk1pPzLJ/aIF+VnC+D1ZsPaYRZJKp0G0uLFYD5WPB/vqTjH
         ASynFelMK2x1P04BJPvrqxd/z6Gp6LD3JIxWqhF30DaZ60z2/t+ys8QtFBtDUWBDNZsW
         QQ1fGrulArH8gBg/B8cHfq4BgqZskC62ExdbFZNEKeV/Ay4Ty43ZEs28kCfswVvZsxo2
         eMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898680; x=1691503480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yEQ+0gFJ5msMJy9NJW+/6TCkt5+v4c6Eptgapu+lzY=;
        b=Z83zmsh3jRPFdLdZd2eDwrQz0W71hrIcWj0yhsLM52BiV0J0cSjUKZP3aI2/Hn0DlU
         SKnRmLdxuL33wOtUu5Z98i+p0VZwym6c2DhDPx8/NGqyd5TZb9TIxlgtv0sO1UBdkflX
         rsgI6EkITmrwLGLnGLQTwIZOeIEWwehtaJ/bRW1zXIPcBD0GFGcTVqJ+d+HXIAVh+Osl
         eagobG9XOe/kex7LsTHVm5MQ1TzhEjcNSINIfpPkNVYsZJw5PAC2glTS8yAf/mXIpFsF
         BN388sSdGfL6Sgo0awYKqkTjy0mpYorLxhtDlwr5vC85hYVfKBm03vzPFZVvlkEAB+/+
         qURQ==
X-Gm-Message-State: ABy/qLZhdED/iWcOUcwaZkSbekPsxJR2ZakoPih/HBVWEUkh1HVLS+MG
        +v/7vLEwe6JycFi4AoiDvcX+DFt3B2/rS85JQzI=
X-Google-Smtp-Source: APBJJlEF0gvE+UcX3ZFCigzEbUlN7kUqyuHbNc9ty/+wbP26Bh3V9tWUypYLu/ty5SN8se4Y5F3rCw==
X-Received: by 2002:a7b:c4d3:0:b0:3fa:991c:2af9 with SMTP id g19-20020a7bc4d3000000b003fa991c2af9mr2439194wmk.16.1690898679816;
        Tue, 01 Aug 2023 07:04:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003fe24681b10sm3999069wmq.28.2023.08.01.07.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:04:39 -0700 (PDT)
Message-ID: <8f2c1cf6-ae4d-f5fb-624f-16a1295612d7@linaro.org>
Date:   Tue, 1 Aug 2023 16:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/12] KVM: x86/mmu: Use BUILD_BUG_ON_INVALID() for
 KVM_MMU_WARN_ON() stub
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20230729004722.1056172-1-seanjc@google.com>
 <20230729004722.1056172-11-seanjc@google.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230729004722.1056172-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 29/7/23 02:47, Sean Christopherson wrote:
> Use BUILD_BUG_ON_INVALID() instead of an empty do-while loop to stub out
> KVM_MMU_WARN_ON() when CONFIG_KVM_PROVE_MMU=n, that way _some_ build
> issues with the usage of KVM_MMU_WARN_ON() will be dected even if the
> kernel is using the stubs, e.g. basic syntax errors will be detected.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 40e74db6a7d5..f1ef670058e5 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -9,7 +9,7 @@
>   #ifdef CONFIG_KVM_PROVE_MMU
>   #define KVM_MMU_WARN_ON(x) WARN_ON_ONCE(x)
>   #else
> -#define KVM_MMU_WARN_ON(x) do { } while (0)
> +#define KVM_MMU_WARN_ON(x) BUILD_BUG_ON_INVALID(x)

No need to include <linux/build_bug.h> ? Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   #endif
>   
