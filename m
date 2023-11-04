Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4917E106B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKDQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjKDQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:32:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8E136;
        Sat,  4 Nov 2023 09:32:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084de32db5so27183005e9.0;
        Sat, 04 Nov 2023 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699115541; x=1699720341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfkribfW8lFVQFkA2m3aoMWTIooxLiD28rL0TM3MjF8=;
        b=CvQwZYe/TayC9HIeI6vb6LsLyxj6KusIZrYZ65zBQvfOkKJbUzq9V45079Girm6X97
         lMeLmUArzvdmVzp02WHkdyBKd80PS0m8NpB7hZDveKoPxHepO1Z9inHxU1S1t3j0xggQ
         Gjf55/7PkW705R16SDo/c5Iai9Y47/6O1VNOUKW270DNyzWsYZoNxbtDrJU+Z4o684aU
         e95qm33MFnJt5y/6vK7xJA9OCH7PsQQqRQ9XObQgRQ75E3vth1dIOXMeNNwOWTmvI1iK
         hQAwTwx99vvH8Vrlheau1j2D3/Z5n/r/Or2kVfbPyVi1OZDTU2KcD0cEghAACqemFMLr
         f2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699115541; x=1699720341;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfkribfW8lFVQFkA2m3aoMWTIooxLiD28rL0TM3MjF8=;
        b=Wr6Ik3mwRVMISXfyaOsQYe/+iLrm+l5X35Qdmz5vMXYK8muemHaCDISQbmNtK+Oy2S
         gMySODbhUUdZSEFVb58s9FBbzbphKJqtG6pufSGpLSO95cwaVlziqzgFFIxzc/S3ONDY
         3rHZDpixfwOYvxyM2Jm+IA0MG+Vw19EdntY5JOPD1FEKyA9dyWKq7mvAvSCsZ1GoKGeQ
         /YlkfKqu8YRgtdOIC6v6wDj4skAnOneHocNQGdKL/d/2FOD9ZceoEGGOTVZ+dzSLj9Uf
         y6GhmRsZc1UUtdqRU9LJ/CJvOKAhmy8AkJ7ByCJY6cL2klpvCoXt92bKCuXPVd1B6A5K
         5HGg==
X-Gm-Message-State: AOJu0Ywpzpgu6YkqPMAOrujojOYHUgyKeErj+UiOdQk/ITetrR5ZmLAz
        Cj2i3Jk1QnTQEwdKZPQFPDo=
X-Google-Smtp-Source: AGHT+IFVW0fJ7SJKV8BjfP7HCtmHAqYsB57NI6d9fwIJtSI4ijotKfFHuCdFkLDh6wSNfEqwUaMMPA==
X-Received: by 2002:a05:600c:2811:b0:408:5bc6:a7d with SMTP id m17-20020a05600c281100b004085bc60a7dmr20097643wmb.19.1699115540965;
        Sat, 04 Nov 2023 09:32:20 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:e018:7b08:28f0:78c5? ([2a02:168:6806:0:e018:7b08:28f0:78c5])
        by smtp.gmail.com with ESMTPSA id n26-20020a1c721a000000b0040849ce7116sm6149510wmc.43.2023.11.04.09.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 09:32:19 -0700 (PDT)
Message-ID: <970325157b7598b6367c293380cace3624e6cb88.camel@gmail.com>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is
 up
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 04 Nov 2023 17:32:19 +0100
In-Reply-To: <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
         <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
         <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
Autocrypt: addr=klaus.kudielka@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-04 at 16:27 +0100, Klaus Kudielka wrote:
>=20
> phylink_start() is the first one that does netif_carrier_off() and thus
> sets the NOCARRIER bit, but that only happens when bringing the device up=
.
>=20
> Before that, I would not know who cares about setting the NOCARRIER bit.

A different, driver-specific solution could be like this (tested and workin=
g):

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5690,6 +5690,7 @@ static int mvneta_probe(struct platform_device *pdev)
        /* 9676 =3D=3D 9700 - 20 and rounding to 8 */
        dev->max_mtu =3D 9676;
=20
+       netif_carrier_off(dev);
        err =3D register_netdev(dev);
        if (err < 0) {
                dev_err(&pdev->dev, "failed to register\n");


Would that be the "correct" approach?

Regards, Klaus
