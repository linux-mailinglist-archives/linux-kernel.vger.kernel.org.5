Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF76A7798B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHKUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHKUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:42:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D91BFD;
        Fri, 11 Aug 2023 13:42:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31792ac0fefso2010594f8f.2;
        Fri, 11 Aug 2023 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691786552; x=1692391352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVgcqF1joq8W7y/WHDPKihNx0P7+CXJ0er9Adrk4nhI=;
        b=j06M97kCuVdhCBz4QvwEQlm1VcYTBlqMQs30dCEgWO9myAcXErgLvwAosWf7TTKWil
         6TGIl3m88tehK7vyqjWk9O+CZ+q+NJm9/cdZMZTu89nP/13Uj95hHnWoQ95X85f/AKfP
         wFa+sN6pyarE5oGh0BLezyAA/A/JzfrL9fPhgZwkFc5WSCOia1FWkFXgrf1lFxxZpYM0
         C59ow7bzHBZvLFFm+umsV4UhKV3z9jTVc/5E4H/l++jIRhoObcOWyxNfNC4sZzyHk7pY
         DpDC6M9Bwd4Cq6Fm5qJuMMR0D1RV+4hqmS0scn132IKCTEqUOPWwwXi68FupQ3Xi2xqh
         cAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786552; x=1692391352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVgcqF1joq8W7y/WHDPKihNx0P7+CXJ0er9Adrk4nhI=;
        b=M2aH27Nclm5oDP1WuTx5uMfGN6G5hTiGx3dZpdIqnQ9ruaf5lLq0m3Kr2toT9dxsy4
         kNwLVQSuXYVejkH055bCIzCju/QtlDsafLD9crlfFjQbsNIhzoGT/uaKLzMM4tyGs/LV
         Qgy1dYRUHeuJBs6gelR9MrwAv/vFfqkut6b2wHmQRgqZK0soak2oQW1E+cVg6MqJ2oVj
         siIrPe3wV+YYlVCg1MEC/bCTO+49lSf6+UuPu++UM0wyeKnlc6BYl4XOGR+xLa40dQ3i
         RVss6ErWEGHvD0hBzVgYc+YwKlGcDvMUS5DsnNNznb98bGML5Vr3yYtPI/gKJPlFdwhY
         /JZQ==
X-Gm-Message-State: AOJu0Yy/BAHwzMt2Rm95GNuPbMvMx/vH229nq5iPP5rnFD10W1pEH9G6
        AyVADpd/kgnI09pz8rPWMnMl6pqD8mhejA==
X-Google-Smtp-Source: AGHT+IFgjTyHdP3r3RZusqBKAtk/i94Fe1WWQFkyz05f9pqHaq6vRvDp80CVixreSNLlOXIlc6MZqw==
X-Received: by 2002:a5d:6b88:0:b0:317:67bf:3387 with SMTP id n8-20020a5d6b88000000b0031767bf3387mr2111773wrx.60.1691786551661;
        Fri, 11 Aug 2023 13:42:31 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003fc015ae1e1sm6347035wmo.3.2023.08.11.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:42:31 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:42:30 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openrisc: Make pfn accessors statics inlines
Message-ID: <ZNadNn6GsV6MyYxS@antec>
References: <20230811-virt-to-phys-openrisc-v2-1-3500d015bcc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-virt-to-phys-openrisc-v2-1-3500d015bcc0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:01:17AM +0200, Linus Walleij wrote:
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
> 
> For symmetry, do the same with pfn_to_virt().
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Cast around a bit in the pfn_to_virt() function so we don't
>   get pointer violation complaints.
> - Link to v1: https://lore.kernel.org/r/20230808-virt-to-phys-openrisc-v1-1-b2c16cf000a8@linaro.org
> ---
>  arch/openrisc/include/asm/page.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index 52b0d7e76446..44fc1fd56717 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -72,8 +72,15 @@ typedef struct page *pgtable_t;
>  #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
>  #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
>  
> -#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
> -#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
> +static inline unsigned long virt_to_pfn(const void *kaddr)
> +{
> +	return __pa(kaddr) >> PAGE_SHIFT;
> +}
> +
> +static inline void * pfn_to_virt(unsigned long pfn)
> +{
> +	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
> +}
>  
>  #define virt_to_page(addr) \
>  	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
> 

Thanks, applied to my queue of patches for 6.6.

Note, I did some C=2 builds and booted 6.5-rc5 with this patch with no issues.

-Stafford
