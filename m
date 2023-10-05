Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56167BA64E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjJEQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjJEQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C513B75;
        Thu,  5 Oct 2023 08:24:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c007d6159aso13028671fa.3;
        Thu, 05 Oct 2023 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519439; x=1697124239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+J+a00kO012Mx5a121MCNe5VDW7fPYb1FirqG31nHBU=;
        b=mD+2cadWaPWtxxlYOumhe99SN7YZqMJPjQkrC5BX86Ea1z63WrMa6sLR8jBKrAPQAl
         fM+EP+Ifjen+iXpmlwHBLH2m8Oe6JhcNQKvAvBQuwx1Q2Z9MepyTQQoo0L2l+tvwVEYb
         SoDS22+hnKxOwbGYFxaF2nr3a3P7+fWpAlzx8kG4IIasTniYumYyRLh8MnIx+2zmHiin
         7ejHeEW6h4AbaJfAooXgPAy/qrUrFN/yf7EVL6f4xYOqjv611SpTjoMNjnkg///q+n5Y
         aUfmIrU7l0p2VYS4prVY2Tlre+3ypLfnKw7+pFqS99/Z/ggrnjiZGilMTwUE3xuWfA+5
         VG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519439; x=1697124239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+J+a00kO012Mx5a121MCNe5VDW7fPYb1FirqG31nHBU=;
        b=a3joramQJzffD8Jhb8CWTz2TTW/zjatlhRUGBNLB3JTh4qcoW2YpjnW2Y23q4x6CEG
         bOIJk11towMqFlVCtY0hcHdx8P4eZL533tvnX9mirUzACLaECfeFnD4Ck0Uxiup10iwD
         TEMwC8rSjM3T0BCGfxevgR6eyWhLHWEvx1YD9WaaZPW9pusW/PYMYMsNr/N+sQd33Blj
         Rc6Z98F77kZh7moU4+TN3RHFFkv9cEgAe6zPTUn2ZBvtX6/bNc5khCKtc5uxPyJ4fJKF
         +a5bDd0irykxAX/qzxF0pgsHAgfMX4ibKrkBmmnbXzV4gvXAGMmNGm/zyTrZ9FKjPrUM
         x1Aw==
X-Gm-Message-State: AOJu0Yx6y3Q6Kyeg8hIc9jScOkGuoM9tbSF72L4d/LclwBEaTEIRZJs/
        Sa0ljzJNoGeAxHlNl+4G4XI=
X-Google-Smtp-Source: AGHT+IHf+Q4L5AI5yo6154StviwwuGxNEU2iyw5xYFFIAXimxL1dh0wkqaiS25mJpQNKEzO2bSNvCA==
X-Received: by 2002:a05:6512:b99:b0:503:2623:7cfa with SMTP id b25-20020a0565120b9900b0050326237cfamr5901658lfv.35.1696519438734;
        Thu, 05 Oct 2023 08:23:58 -0700 (PDT)
Received: from mobilestation ([95.79.192.17])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b004fba82dde47sm336909lfg.123.2023.10.05.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:23:58 -0700 (PDT)
Date:   Thu, 5 Oct 2023 18:23:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
Message-ID: <iq4t7uyi4jw4j5kymaolgstzjdlgw6y4ncptt4nsrd4gktwomc@t7ujciysz6q6>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf6pcebd.fsf@BL-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:51:50PM +0200, Gregory CLEMENT wrote:
> Hello Serge(y),
> 
> > On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
> >> The MIPS Warrior I-class I6500 was announced by Imagination
> >> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> >> index cf382dea3922..87fd2842ba68 100644
> >> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> >> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> >> @@ -39,6 +39,7 @@ properties:
> >>        - mti,mips24KEc
> >>        - mti,mips14KEc
> >>        - mti,mips14Kc
> >
> >> +      - mti,i6500
> >
> > Since the CPU core vendor is Imagination Technologies thus it would
> > be more appropriate to have the "img," prefix. Wouldn't it?

> 
> According to Documentation/devicetree/bindings/vendor-prefixes.yaml
> 
> "^mti,.*":
>     description: Imagination Technologies Ltd. (formerly MIPS
>     Technologies Inc.)

Yes, "mti" is also marked as Imagination Technologies Ltd, but I
doubt we should use "mti" prefix for something what has been developed
after Image Tech acquired MIPS Tech. What is the point in having the
"img," prefix then?

Rob, your opinion?

-Serge(y)

> 
> So I think it's OK.
> 
> Gregory
> 
> >
> > -Serge(y)
> >
> >>  
> >>    reg:
> >>      maxItems: 1
> >> -- 
> >> 2.40.1
> >> 
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
