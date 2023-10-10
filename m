Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCA7BF840
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJJKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJJKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:13:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE099F;
        Tue, 10 Oct 2023 03:13:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so64868731fa.1;
        Tue, 10 Oct 2023 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696932791; x=1697537591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRHELaZLgBSh0LGg1duwhZy3BbADXLxMR96EJLdeViE=;
        b=NkaIBSzGQlLfQXRREuxgnxyfaoN4IrWk0fL+PBiJreRzz0/F3EyDktLFi/0CSUM0da
         6gPy0F61ENgVUZ6EmSMP6EtBccAQakH/H3N8a+YYw/V2vIabdntH0EtQ0OZNBkVXrc/M
         5FEaOS3fJlj+H/eBQy/EUqzqlL3pPRVNPuueUOD7Ig3VY2YnnTOJwbpAW/ikpYAFJKOt
         JPDmiHOKroJy1lYAdwvcTrrL+mzZOzhkX8i+hl6eFPsHgq09eAovfX384nkefM9jVLB7
         IE7uWQ3KyyHjAvaS/nt8jBAI1CxLYSO9Z2o7sNGOvzAR9F4own0R0fZTnuROsaeXxFSq
         Mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696932791; x=1697537591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRHELaZLgBSh0LGg1duwhZy3BbADXLxMR96EJLdeViE=;
        b=nTt8tohAyHessF2WH3EXEmlPBSOd+M8MfWH2YbJiOkbx9yw4Ai5KCKLQKfsIufT+fq
         oxsrNj/8mXQRJVVFHL93Bro/udeNZtrfvanRDQ6+oR0ZJmx0RThFFPzsoM9yQBs4xtoZ
         YipdhdEtPboqJN5vVwaQ9yTwVLK1wXPu2/7El92EOGMo0zLeE1UW4eD12c+z2HX6StWQ
         dvSJQVsN1nVlcf/Qu3x22SEhkaPY9+q8uBXr7c+mytP/eF1pcqt/TnDWcEh6Yl4/K93L
         nL4vMnxeN0k5PBPIHB+cCfOPn2nPJOqgXrMiZaG4p7I3iSFcyzdxh/EG5tqLJwDho3Qi
         cP2A==
X-Gm-Message-State: AOJu0Yz8es+xRagfqNpPUqevU7eYzghkcdtchMq7Y29FYo/OzNoZT/vN
        WPyFjrbu213idgzKxR/seBU=
X-Google-Smtp-Source: AGHT+IGfuAkOgUiuAPUH4QZBQ5IrZ3zSWA4/SELweuR50ESCFxP6mrYGFgybNS3/I+y4ddntBArrnA==
X-Received: by 2002:a2e:7e04:0:b0:2c1:6ede:de20 with SMTP id z4-20020a2e7e04000000b002c16edede20mr13801560ljc.6.1696932791248;
        Tue, 10 Oct 2023 03:13:11 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e9794000000b002bce87faca9sm2399954lji.57.2023.10.10.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:13:10 -0700 (PDT)
Date:   Tue, 10 Oct 2023 13:13:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
Message-ID: <oyimp3535zlayzdyulqup2iverfseqy4owhzfzuo4aglcz4f5d@4rxqsinj6mur>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
 <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
 <20231006164019.GA4040344-robh@kernel.org>
 <87jzrvbyl2.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzrvbyl2.fsf@BL-laptop>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:32:57PM +0200, Gregory CLEMENT wrote:
> Rob Herring <robh@kernel.org> writes:
> 
> > On Fri, Oct 06, 2023 at 12:48:03PM +0200, Arnd Bergmann wrote:
> >> On Thu, Oct 5, 2023, at 16:51, Gregory CLEMENT wrote:
> >> >> On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
> >> >>> The MIPS Warrior I-class I6500 was announced by Imagination
> >> >>> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> >> >>> 
> >> >>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> >>> ---
> >> >>>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
> >> >>>  1 file changed, 1 insertion(+)
> >> >>> 
> >> >>> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> >> >>> index cf382dea3922..87fd2842ba68 100644
> >> >>> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> >> >>> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> >> >>> @@ -39,6 +39,7 @@ properties:
> >> >>>        - mti,mips24KEc
> >> >>>        - mti,mips14KEc
> >> >>>        - mti,mips14Kc
> >> >>
> >> >>> +      - mti,i6500
> >> >>
> >> >> Since the CPU core vendor is Imagination Technologies thus it would
> >> >> be more appropriate to have the "img," prefix. Wouldn't it?
> >> >
> >> > According to Documentation/devicetree/bindings/vendor-prefixes.yaml
> >> >
> >> > "^mti,.*":
> >> >     description: Imagination Technologies Ltd. (formerly MIPS
> >> >     Technologies Inc.)
> >> >
> >> > So I think it's OK.
> >> 
> >> I don't see any good solution, they changed their name and
> >> ownership too many times. I would actually revert back the
> >> description here to "MIPS Technologies Inc" instead of trying
> >> to keep track of what they currently call themselves.
> >> 
> >> Since we already have both the 'mips,' and 'mti,' vendow
> >> names for the 14Kc, 14KEc and 24KEc parts, maybe we can
> >> just go back to 'mips,' for all cores past the mti era
> >> rather than trying to date and geolocate each of the
> >> classic cores as one of 'mti', 'img', 'wavecomp', 'tallwood',
> >> 'mips' 'cipunited' etc.
> >
> > I would reserve 'mips' for anything common. Much like 'riscv' is only 
> > for things based on RiscV specs/standards.
> >
> > I would use 'img' here if we know this was designed/implemented by 
> > Imagination.
> 
> If there is no objection I will use 'img' then.

Sounds good. Thanks. Feel free to add then:
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Gregory
> 
> >
> > Rob
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
