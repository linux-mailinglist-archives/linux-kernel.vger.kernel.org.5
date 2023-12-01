Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F3800AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378859AbjLAMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378804AbjLAMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:31:23 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644F13E;
        Fri,  1 Dec 2023 04:31:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9b5c12898so25523161fa.2;
        Fri, 01 Dec 2023 04:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701433887; x=1702038687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiunD3rGt4P6HEz12hNIUnkO3H4wWSc2YPfZTqYm9yc=;
        b=OuPedNNG78RzU62X1kd/mrtQ/FU05FSlFkFU/+HUVPxqiKiGsQowLjltmlLk4tANt5
         33ZEh0pTcYACiU3rqUVLBLUpTqGMHtuMSeVdSpEapdJLgdggM/QhNEkho7zIpOQy5AO8
         OvX+UEUyBvzs3P9IZ5jBH9HuoA/0zgLUNpAEoWxXYSXoOHYTBUPPP/lBeJYoXZbWu7W+
         P5QOxyzEOSPcwEFJStSnW9S/YI1LuxiBDQ62SQU++FYxVYr7FMYNjGr4OmK59k/pm7YB
         h8/WYFkBNbntfOGY+BdIkyR8ZIDJDES1FIGZ1grFlildCk+cKgHX0VJ+gewduZdF8Du7
         gNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433887; x=1702038687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiunD3rGt4P6HEz12hNIUnkO3H4wWSc2YPfZTqYm9yc=;
        b=RcBXaamozFMeQXV/rokYx1Yi21weySFtEHeB8SPxNoG1O4i/rExkK683coeVjgJHx9
         pU9EucoLcAO7yMkCVZ3Zs1q9YMEpsnErAMyBYQCAvuA8Lic1HUuohiy347qRcfFucONm
         UlccliGJzy4IqphhrHKlAChY4GwnkT70l+1TE/s0dPgvRYM+VpxTnEehShx4JXixsl0H
         xQyBrJN7Rk97+1mf+ElNuMMgpieoB0pcI2uNPhhpNPY36zI9jxGtlekff6YAhMW4iNKe
         VXCjNZjCTGQxMq28dsVP02pkYENQNE2Nfb2s6Vy7qi00ZFcoJPIpv1jJLEmglsJCEAqT
         Rhrw==
X-Gm-Message-State: AOJu0Yw4RNEKOqCmCG9CvdjL4aNw/XFaL/lXRp00U8z7ANOlXtSH6wJL
        kXM7ZBGdx0LQiyhsUDFACP4=
X-Google-Smtp-Source: AGHT+IG8rR0U5EKN7BCgxTGQgipxfo/JHWvXxTZ2FEZ/VetQGkryte+h9ijQaxKv7SNun1rNkxmIOg==
X-Received: by 2002:a2e:97c1:0:b0:2c9:c51c:5b68 with SMTP id m1-20020a2e97c1000000b002c9c51c5b68mr653304ljj.39.1701433887242;
        Fri, 01 Dec 2023 04:31:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a14-20020a2e88ce000000b002b6daa3fa2csm382483ljk.69.2023.12.01.04.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:31:26 -0800 (PST)
Date:   Fri, 1 Dec 2023 15:31:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 15/22] dt-bindings: mips: cpus: Sort the entries
Message-ID: <ldsl5czjvfx6s5j3sniyriidzkspncuatfk5qrwmrvje5we7i6@kbafgbwxwnfc>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
 <20231201111512.803120-16-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201111512.803120-16-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:14:58PM +0100, Gregory CLEMENT wrote:
> The entries were nearly sorted but there were still some entries at
> the wrong places. Let's fix it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  Documentation/devicetree/bindings/mips/cpus.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> index cf382dea3922c..9bc47868d28b6 100644
> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> @@ -23,22 +23,22 @@ properties:
>        - brcm,bmips4380
>        - brcm,bmips5000
>        - brcm,bmips5200
> -      - ingenic,xburst-mxu1.0
>        - ingenic,xburst-fpu1.0-mxu1.1
>        - ingenic,xburst-fpu2.0-mxu2.0
> +      - ingenic,xburst-mxu1.0
>        - ingenic,xburst2-fpu2.1-mxu2.1-smt
>        - loongson,gs264
>        - mips,m14Kc
> -      - mips,mips4Kc
> -      - mips,mips4KEc
> -      - mips,mips24Kc
> +      - mips,mips1004Kc
>        - mips,mips24KEc
> +      - mips,mips24Kc
> +      - mips,mips4KEc
> +      - mips,mips4Kc
>        - mips,mips74Kc
> -      - mips,mips1004Kc
>        - mti,interaptiv
> -      - mti,mips24KEc
>        - mti,mips14KEc
>        - mti,mips14Kc
> +      - mti,mips24KEc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.42.0
> 
> 
