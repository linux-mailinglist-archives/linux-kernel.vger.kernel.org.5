Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD567754D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjHIING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHIINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:13:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB3A10CF;
        Wed,  9 Aug 2023 01:12:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so9078887a12.1;
        Wed, 09 Aug 2023 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691568778; x=1692173578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvmzhOT0wFGeuwQD5W6OcK5p6BUWlzFV8CC/4rBnjJA=;
        b=AMgXDFq7pjWEBU8dkhRBJbmyzqO0B7VOChoTNgi6+nIAXmwSG6nso3Rxos4XuMIfBl
         gwcPgZQE3nekC5ZpD0LEzQG4bVm7bbEvMxeRXaga66f+OVpDb2aUVSCnwVYRNPk1iUUd
         8QX3VfJ5rR4hJB1aewiTEoVwArTHPEOdxvZVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568778; x=1692173578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvmzhOT0wFGeuwQD5W6OcK5p6BUWlzFV8CC/4rBnjJA=;
        b=aqRDSmwXm7a1YJfnfeYB4LR24afIoAjFW9lGKe1QdfBg8ZwQKwGOLrYL0gR8exVI9k
         qo6sipOtmeL+4zg+24faALxw8/bl5m6hF2/LOLtdN3E6d9MJrrrf7uB2fAXm1LEkgsl2
         xq5r0PQsfoECGImWf9q3n8isTph5UQ8xN3GddGyQkqbMpxOha2b+s2EB6MywQkJJp//W
         dbpUHH/RWYAn2qGHPWKXja85K00FGTL8FBOHLYDalFcZP9AHmFjm1o0S+sSLevKH8t/y
         9NTSuWSa0Mm0LDco5MDD00XauZR8yRAyJjmfORfSzXMWtFd3VtSvdl2Sw/J1F+cUwbT3
         alHQ==
X-Gm-Message-State: AOJu0YxeH808Fss7Kt5SVnB5noSujkCvFhsA2Wau3cS9pjRBgPlnWYgz
        hER7G1G6FA9ml8L69LeZk5o7lIc8T7F3zRj9l1M=
X-Google-Smtp-Source: AGHT+IHcUqgd/upyc5Qjp4q1hsetXyRqL9GbYN9PhYyu2O4YkqPjbQELGDAbkFXJfWlqQ62KQIfeg7AyIXgmm6wkV/g=
X-Received: by 2002:a17:907:788e:b0:99b:6c47:1148 with SMTP id
 ku14-20020a170907788e00b0099b6c471148mr1620721ejc.3.1691568777601; Wed, 09
 Aug 2023 01:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com> <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
In-Reply-To: <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 08:12:45 +0000
Message-ID: <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
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

On Wed, 9 Aug 2023 at 08:05, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
> <Delphine_CC_Chiu@wiwynn.com> wrote:
> >
> > Add linux device tree entry related to
> > Yosemite 4 specific devices connected to BMC SoC.

There were also some of these annoying warnings. Please try to fix
them up in your next version:

../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:460.4-14:
Warning (reg_format):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@0:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:510.4-14:
Warning (reg_format):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@1:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:567.4-14:
Warning (reg_format):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@0:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:578.4-14:
Warning (reg_format):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@1:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:457.9-505.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@0: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:457.9-505.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@0: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:507.9-555.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@1: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:507.9-555.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@71/i2c@1: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:564.9-573.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@0: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:564.9-573.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@0: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:575.9-584.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@1: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:575.9-584.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@73/i2c@1: Relying on default
#size-cells value
