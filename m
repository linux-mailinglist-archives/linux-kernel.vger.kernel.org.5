Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BF7BA4EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjJEQNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjJEQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:11:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29920667;
        Thu,  5 Oct 2023 07:39:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50337b43ee6so1400550e87.3;
        Thu, 05 Oct 2023 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696516751; x=1697121551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGNfD0ANNnBmUiU0TDuI3FeSNbeY1NQQ1JkN+VqFBKE=;
        b=h7VwM6Eq4/O+w8lerrGzJ1zhOss6vqsSlEySLGRWzpwWuXe+WVOnR4fHPqnOgjv4Fd
         FS3As0n2V9pvw/GN7y0TiJDUDpFW/5UGsVz/isxtEC6JdlGdXUt+SJM7/FZRqMViQF1L
         ck9LRDlw0XSyOzI0WKs0rg6ab3XRPqJzhRbHLal0R3YwhmsNBl23MgP38xKe9f2Sd8Bf
         2Shzb44c4fYGBnlav8FyQ4Z/JetJLc7dZe6ZYwMilRUu6CRcV1SIn9z8tFP9oGgeZeS2
         CbkuFcMyVGD3SwQRIu1yiSDxdhWnObuDlDrh/L21kXmdgZDyxbbBX5kWFkfBeLE2+Bbd
         DBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516751; x=1697121551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGNfD0ANNnBmUiU0TDuI3FeSNbeY1NQQ1JkN+VqFBKE=;
        b=RWtUGb638T5ZxbJN2zU3KO8SWoE7ShRGVdMk2GVIz7t+50RQnhPeUTzkV04zX4M/Zk
         TDkMSs1/Aaknih0VMqYC+MRViti3XLxX5cFDGPMRxCB9uCLnGokhO9oOtFHqXZNbPPqF
         ympXNVkyD3odJATqZRcPm6LtAAWedgtwsPOBmjQtAgE+wwtr8B4b9hnGfTct5a7hhPu2
         MTUQVlC97kMyVYQOolOJf6QDObxdmjPmRw1EWzhAOwdFz3UGjWiLqsLOBlUxpNrdT0wn
         R6tUc2uKq0TILnbOOi6GdBMLqTYbXGZSuUBWnGvbWklsuGgE0Q3bBJQLVcAehEWOvtoK
         Sy0w==
X-Gm-Message-State: AOJu0YzDLFw4p5VQ9SApPe3n/r2t7/M01u3Nsi/lbTsaWjSBE+s/w2ex
        MMnSGjLmp8MqRslxn34aHm8=
X-Google-Smtp-Source: AGHT+IEh0pnmAvKyDaygo9z9NA2bdWYsV4Bzph7beWZxyBJK7KkdPwvO3fLAgDtE/L3/BA0+gcA/Fw==
X-Received: by 2002:a05:6512:1307:b0:500:7f71:e46b with SMTP id x7-20020a056512130700b005007f71e46bmr5118440lfu.1.1696516750850;
        Thu, 05 Oct 2023 07:39:10 -0700 (PDT)
Received: from mobilestation ([95.79.192.17])
        by smtp.gmail.com with ESMTPSA id g19-20020a19ee13000000b00502d7365e8fsm319864lfb.137.2023.10.05.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:39:10 -0700 (PDT)
Date:   Thu, 5 Oct 2023 17:39:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
Message-ID: <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161038.2818327-6-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
> The MIPS Warrior I-class I6500 was announced by Imagination
> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> index cf382dea3922..87fd2842ba68 100644
> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> @@ -39,6 +39,7 @@ properties:
>        - mti,mips24KEc
>        - mti,mips14KEc
>        - mti,mips14Kc

> +      - mti,i6500

Since the CPU core vendor is Imagination Technologies thus it would
be more appropriate to have the "img," prefix. Wouldn't it?

-Serge(y)

>  
>    reg:
>      maxItems: 1
> -- 
> 2.40.1
> 
