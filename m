Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D46805B79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjLEPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjLEPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:12:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B0BF;
        Tue,  5 Dec 2023 07:12:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c039e9719so38355535e9.1;
        Tue, 05 Dec 2023 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701789125; x=1702393925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUcSxC8faGB4FZX2kdFiPYxe1bP135Sgopto+d48cYQ=;
        b=dKDmUn7bUg4iwd36efaEf8ZQ+DSLJCKQUrXUW1vx4x1EFkA7O2mmONyRgTfoOfq3ZV
         gLlXlhp3aDMziw7SSLcoeVDxw8Kmjechgzbez8My0nIWjZUsBKVLEqdbX4SH2hkvBuba
         tzRAJvrX2QUusnjTa4eHqBpXmQtcLIixGXM+iQvEYege1TsvaE7KdFo8mEFFJ0yeODnz
         W1EwAjPnJl4dZ2UpKnKBlpa/apoqiypxxoyHkyuh2fjvALvwqoxh0FzrTbCxX0/rmlHM
         vZEsHdxgto/GyPQv9rLF7fDCjispm8HajOfyMATf3kDokOXyjTMTyGv/7PbC84T3U8Cu
         PTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701789125; x=1702393925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUcSxC8faGB4FZX2kdFiPYxe1bP135Sgopto+d48cYQ=;
        b=rQ1tSzXsi4m5ECnliJI77sHQWOnXZOGJqhLbkuMteNBtfgn1p5M4LOX3zdlkr8d5QE
         rBBMUOLXafqBii2GYwJ18ns7dupq038NhYrDE5RkyGio2SoxHbT0r7tDlz+vY0r6Z1sx
         58QoU6QT/Z4Uock441UknAw0ITARi+DyTXISg1AsI+9uw9iFFwNy3nN5UJvg3bfRsFoT
         70kUI/TgdUSQSJypX0prpuGQM62QGB0L3R1FKF80eT8kC9c3bEoxoM5JbC74bIKC8Lbw
         rYdMBR8a0sB8VpG1m+xW6Q1FYZ7qG8ZrohLgLlGuEF8fs+UkJYz/DdhcdGeX7vQHuDf1
         unbg==
X-Gm-Message-State: AOJu0Yy+PMvQLPVu4AEXC7h5zrAoR2sJR1e4kNqXgBaFew2/7ePvGU2T
        LJ5aXa6iE1wmVdpiNsJd50A=
X-Google-Smtp-Source: AGHT+IEtH6mWfRi7ZVm8iy2S1xPvAINqxyziVg7rwgW2Lh6yp7EcqUDqsxfeMDiKuOoiTb2H9ogJyg==
X-Received: by 2002:a05:600c:4f54:b0:40b:5e21:ec43 with SMTP id m20-20020a05600c4f5400b0040b5e21ec43mr541346wmq.117.1701789124489;
        Tue, 05 Dec 2023 07:12:04 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b003332ef77db4sm12924347wrv.44.2023.12.05.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:12:04 -0800 (PST)
Message-ID: <c029f2e5d49d8640fed59639224296e3479682aa.camel@gmail.com>
Subject: Re: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date:   Tue, 05 Dec 2023 16:12:03 +0100
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-12-04 at 11:33 -0600, David Lechner wrote:
> We are working towards adding support for the offload feature [1] of the
> AXI SPI Engine IP core. Before we can do that, we want to make some
> general fixes and improvements to the driver. In order to avoid a giant
> series with 35+ patches, we are splitting this up into a few smaller
> series.
>=20
> This is a continuation of the work started in [2] which has been applied
> to spi/for-6.8 [3]. This series must be applied on top of that series to
> apply cleanly.
>=20
> Once this series is applied, we will follow up with the 3rd series that
> implements the offload support. The offload support will also involve
> the IIO subsystem (a new IIO driver will depend on the new SPI offload
> feature), so I'm mentioning this now in case we want to do anything
> ahead of time to prepare for that (e.g. putting all of these changes on
> a separate branch).
>=20
> [1]: https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offloa=
d
> [2]:
> https://lore.kernel.org/linux-spi/20231117-axi-spi-engine-series-1-v1-0-c=
c59db999b87@baylibre.com/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/=
?h=3Dfor-6.8
>=20
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> David Lechner (9):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: return void from spi_=
engine_compile_message()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: populate xfer->effect=
ive_speed_hz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: remove spi_engine_get=
_clk_div()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: fix sleep ticks calcu=
lation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: remove xfer arg from =
spi_engine_gen_sleep()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: implement xfer->cs_ch=
ange_delay
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: restore clkdiv at end=
 of message
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: remove delay from CS =
assertion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: add watchdog timer
>=20
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 116 ++++++++++++++++++++++++++--=
-----------
> =C2=A01 file changed, 77 insertions(+), 39 deletions(-)
> ---
> base-commit: 8e6a43961f24cf841d3c0d199521d0b284d948b9
> change-id: 20231129-axi-spi-engine-series-2-5f0a6053dea0

