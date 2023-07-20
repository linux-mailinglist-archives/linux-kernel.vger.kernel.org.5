Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4475A3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGTBaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTBaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:30:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B32103;
        Wed, 19 Jul 2023 18:29:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-267711d2b43so32691a91.0;
        Wed, 19 Jul 2023 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816579; x=1692408579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQW65J+CLOk0J4Yl6UCvOr98eBkR2w5hxC1HptI7xbE=;
        b=qmGJPJ2hg3UjaBb2W5TUZiFm/1W8FIFAWWRL4+vZWUNaQPe5by1PuvGsitfJCarMpQ
         k6/eoWphUTqt8uMPfkWrXFjRGC/HCV7cQYWTKfZ+lvU3Vt+4DItUnN1GdPwjlLp6UHTY
         7yykYedyCHO1CwXJ1zJJR7FCDDZfKu7njtu6sByv1C8CNVFZNwnWuWyUpBKf13brOIVY
         tSN8eCYh2djTB/KS4hlWkRVw9gZa2lnKFpwYPVj0UZwF6TBYjUxyl+67Ua0DMrsluyxW
         W76GGIY9SVpUy8xHEd1jpplkpSXkYQtsg67UnDQJtD2yO+R5BXlM3UTxb2/OJ9krH5FM
         C0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816579; x=1692408579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQW65J+CLOk0J4Yl6UCvOr98eBkR2w5hxC1HptI7xbE=;
        b=NYKOQQFW9Pr2sNXiSKLHyaQVGlghYYmDjmK5Cf56l5D587kMXRO1MswYdaljSQyw+/
         8MaJAyAU7+2SlvjhxN5A/AOFJZdaj792KrBiUM12NE8jo1gkQfPtZvHuHRQnJ1eXIM7I
         Mbc46cD25Mav80sRBPEmSxUEoqoxXT0ehcOtO2kYG1iCXiI9f0p3K0XakNuEe4df8cel
         nUTv/JTiBx1aqGOlMWrTu62VSkDH34wPVMWjJUT6geEKLnwCwqc1A0xMpeE2myufPStj
         7RWPvuRqFG9Eu1YYqR+wOjGnp6mDwNmBE1WjKNJcjiiqUhIwsnxV77YaPBbQirMF4py9
         geKg==
X-Gm-Message-State: ABy/qLaxGLD0fAIvqULeW97uRN6gR7kMv9fdpdKGtrmp8DH9DGdCEAoK
        euDLltqLWzl5wo5VpGX8wNfIbLgx6P9ikICTWqFJOyO8elV8ZQ==
X-Google-Smtp-Source: APBJJlFv+Ur9HDVOEiYblOT9dwPa78OLAxG6dkjvRsIT7V81TNrbXhTP0WL6G7O/mCSDJQoOrQhBPasm0pmw7GlPTV4=
X-Received: by 2002:a17:90a:c9:b0:263:5c30:2cf8 with SMTP id
 v9-20020a17090a00c900b002635c302cf8mr927708pjd.0.1689816579453; Wed, 19 Jul
 2023 18:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
 <20230719160048.2737423-2-james.hilliard1@gmail.com> <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
 <CADvTj4piksWhua5W6CMr3ZpkRJcFvR=545hsQhW16KL4gQb4pw@mail.gmail.com>
In-Reply-To: <CADvTj4piksWhua5W6CMr3ZpkRJcFvR=545hsQhW16KL4gQb4pw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jul 2023 22:29:27 -0300
Message-ID: <CAOMZO5Cpf1ejTZTzBWhnchMQOJU6hcLot2Ca+78c2h6LWJNTDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:43=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:

> How would I determine what the value of these should be?
>
> The vendor device trees are using 0x80000000 for these values from
> what I can tell.

0x80000000 means "do not touch the pinctrl, use the value from the bootload=
er".

It's preferable not to rely on the value that comes from the
bootloader and explicitly describe the value in the DT.

For the MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04 pin: look at its
IOMUXC_SW_PAD_CTL register in the i.MX6Q Reference Manual.

It is called IOMUXC_SW_PAD_CTL_PAD_DI0_PIN04 and its reset value is 0x1b0b0=
.

So this entry would become:

MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04             0x1b0b0
