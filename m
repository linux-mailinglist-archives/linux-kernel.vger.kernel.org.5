Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633BA7754E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHIIQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjHIIQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:16:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C41FD0;
        Wed,  9 Aug 2023 01:16:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so8436955a12.2;
        Wed, 09 Aug 2023 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691568964; x=1692173764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SsMnenAL2XwJ0YGncKUNQOfBNyYjVIIZqLk1J5TzuGA=;
        b=arzzc1jKJBkATQwIpDm3Kc++X1xrfcvQ2jcjRNyVjP6f9dVhuXoeVZs6RbOynGXlAe
         bmNe2NN9Aj3IahSgPGllWFZMjNWTsIhmhTCZ3+D+gy0sZ2JU/aqjucK4A0dbp4OvsmEr
         9eZFqGS2tf1xSdegboD2fgvuXLFwtC5ZrFBDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568964; x=1692173764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsMnenAL2XwJ0YGncKUNQOfBNyYjVIIZqLk1J5TzuGA=;
        b=gARTl3XPvIEGLHDfKVGZC1cDQZFY2F4KFLU7c/BylilhJUMdsua4/3CByuIWiEiwuW
         5gvy8Z+xsAiDzvkhtc4vYwM6ZwMk4KmOhRmbPQss1QolJni7DLxJ42rB4GsH0KVI8e9i
         SO8HkuR1kxpN3PS79ZFJGybn7L3gokHEHy+rTR96kP8Vp+5ELeCcdYczOB1M4aYqtABE
         ZPfDHvmGaFWfm2dJL4Z3bSQvdJy0nQHKuR1yuSy1fy5G3hcjd9hDalzk7HAwqteY4DmJ
         iGvHXDv/nhi4opsYcNGvxliErkk/9cZS1HTbxK8j5EdXucmr8K4FDOj8R3Iaup4jt7VR
         yruA==
X-Gm-Message-State: AOJu0Yx+gXjHGVCqWfjFyzmOZ/3+BMN2ymDMptFAgEyPMrsV02FoTGre
        EplWFySRrMNPtO1rnpomsr2Xs5tBOub+FR0l+hM=
X-Google-Smtp-Source: AGHT+IGxc7yyRYTXwRGeQCujkNredm8KgAtkyiBFjjjrcfWcnHiAlPtRiEoyNV/Y8OkHrSV6ZAxEvyj4GFpNmfELezs=
X-Received: by 2002:a17:907:7614:b0:993:d5bd:a757 with SMTP id
 jx20-20020a170907761400b00993d5bda757mr1430906ejc.19.1691568963742; Wed, 09
 Aug 2023 01:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com> <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
 <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
In-Reply-To: <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 08:15:51 +0000
Message-ID: <CACPK8XeUbaMhST73UUT7BZzb2ajVU-M7yfQfEkmX2J=pzk=Tiw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 08:12, Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 9 Aug 2023 at 08:05, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
> > <Delphine_CC_Chiu@wiwynn.com> wrote:
> > >
> > > Add linux device tree entry related to
> > > Yosemite 4 specific devices connected to BMC SoC.
>
> There were also some of these annoying warnings. Please try to fix
> them up in your next version:
>
> ../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:460.4-14:
> Warning (reg_format):
> /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@0:reg: property has
> invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)@@ -450,6 +450,9 @@ eeprom@51 {

This silenced most of them:

        i2c-mux@71 {
                compatible = "nxp,pca9846";
+               #address-cells = <1>;
+               #size-cells = <0>;
+
                idle-state = <0>;
                i2c-mux-idle-disconnect;
                reg = <0x71>;
@@ -557,6 +560,9 @@ gpio@61 {

        i2c-mux@73 {
                compatible = "nxp,pca9544";
+               #address-cells = <1>;
+               #size-cells = <0>;
+
                idle-state = <0>;
                i2c-mux-idle-disconnect;
                reg = <0x73>;

And then this fixed the remaining one:

@@ -423,7 +423,7 @@ power-sensor@42 {
                reg = <0x42>;
        };

-       power-sensor@41 {
+       power-sensor@43 {
                compatible = "ti,ina230";
                reg = <0x43>;
        };


Please fold in these changes in your next version.
