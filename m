Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AE7636D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGZMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:54:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9310B;
        Wed, 26 Jul 2023 05:54:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55badd6d6feso747666a12.1;
        Wed, 26 Jul 2023 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376060; x=1690980860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRa1abBfxo1Pg9YOsHvIG4AqK9Ku0PLHwGWAar00XMs=;
        b=rsU15FHZVWihjbu5mzo4ea/1d1oixk8dXOl6V8+G1YDlww5hTeys+HTz5ZQ5Gm2vAL
         OBe1FaNVsrv+efjhPxvGzSn8dWMsm/P9F4MWXdz/j1TaqmDrh3FlDHQZngRDteclVbFb
         1q9xWDZpURDw/yUEOusJWL/vUGBBPC9BR6ei6wkqZCRfkX6d4zjxgC06OqdsXCXown8o
         VaktrGW1BGqmlx8svPDU2qSi8A4oJhEmCMLtOA98cdO71hRXIc1YCmbJW9kLQ6Zc0Cy1
         KYcS36rGcHOkiKnuYQPkS//yd7KmBaAKbD0iuqLDJzc31l4Op16lCcvwdOCmTK++nzgO
         NXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376060; x=1690980860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRa1abBfxo1Pg9YOsHvIG4AqK9Ku0PLHwGWAar00XMs=;
        b=M7SiO/pGkj+5u1qyQXQNr33ElqX0ttMmUNcvktG7zXs9VswkqE77FmksBc6eKEs6yA
         LrBgEW/aXAMrAGBSacN6Tiiz0sNfBF+B8UTm6kZPRS+Xjov2DLyu9oe53wbTTXUg8rbm
         AwnjyvcJbSUNhot8+J5u3+BJMoH2a7Y2PKE0zE/SodPXnTu9WL8WsvYcJ2o8+8yF6Pc7
         Meqt9rmEThhGzcJHQM9h2uU9/R2siwILGEAQqQB5A/xweXciHONXie4uAk4Uh3iHkaGV
         6nMSLgyZ6mCYXMZMigbZffGu9YI9+qcDXWkv6biCKDGoRNm5ikuQXDL03ljSXtWBQZ/p
         6qQw==
X-Gm-Message-State: ABy/qLalGJ7bISPS6ARMifK+e3pI5WaQsBMvRlmiOr+KOePyXGeN9f4p
        O8OVDjTe3tgb7frFZI4eis9aY+d19fMVRLHS8ug=
X-Google-Smtp-Source: APBJJlGi5dh+a9vsuWvfD9uoa/XAcaCjL1UJmluLteGcFADObaoOUs2KxXu+aXQSm/Df/32S32wrgUwMf25ESOr1P7g=
X-Received: by 2002:a17:90a:5648:b0:268:126c:8a8b with SMTP id
 d8-20020a17090a564800b00268126c8a8bmr1786138pji.3.1690376060170; Wed, 26 Jul
 2023 05:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230726123747.4097755-1-james.hilliard1@gmail.com> <20230726123747.4097755-2-james.hilliard1@gmail.com>
In-Reply-To: <20230726123747.4097755-2-james.hilliard1@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jul 2023 09:54:07 -0300
Message-ID: <CAOMZO5CDnsDTUVxiS9CkjXNJbwc=RFPct8tsGfGxeEoPdg4KEw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 26, 2023 at 9:38=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:

> +&ecspi3 {
> +       fsl,spi-num-chipselects =3D <1>;

This is not a valid property. Please remove it.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
