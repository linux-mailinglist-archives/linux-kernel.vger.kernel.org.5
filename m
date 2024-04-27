Return-Path: <linux-kernel+bounces-161151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43518B47B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52A11C20C8C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0051442F1;
	Sat, 27 Apr 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="JMy7jO/8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3B128365
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246511; cv=none; b=CM4CpzzNDHgOdgwbzmYi/toaRK4HhrRLDfdTBO5ArMngHkv7kad6CXrNnhUy/v/LK1fRRGrW3TTCo4qm2gNTQF0H1kpQ0FXldBiz0PsPS4GPx5Ppe1p7VHFzEXzdiuWl+fjjmtvG0E0oaQ7Cv5hm/JBbdEkNbdUX01U6vgve42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246511; c=relaxed/simple;
	bh=3z8Zh7U9QP1/ViV0+8coj4+NlZaD7ONwEi0b3r4n5cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM6hY9tvcMK3GNMMS2rekRpaqJYS2rQxWN6vWHV0kcL4sZXeOiE5MKnKQhzyejj27qah8Fu7TBO50pecrS/5qsrwAEgcq56ir0v4O2FdUTOKj4lM0AO7OICcxBNMUwMBtPB4vL7wRkv6wQSHVWfvVYzjD9PTnQrWOCxs7ZUawag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=JMy7jO/8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so43406901fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714246508; x=1714851308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Stx8L8fGNoLmhu7uwssiRKsIuNsvkM32vbRcX+64kfs=;
        b=JMy7jO/8UnXM2iKz4Iz7z7uztnzbYcpx2LcJ2QY9/v8mV4F2LEQXeAnnWrgr0loauo
         pkbGuNidlcvuMONqaUkjdCi+Bna3KIZqCV3GexZhv41nmDAv5tX1jaHQoQSSsSCBBpjP
         XhSZ23aq4Qwv1yQehsyiTsC+oB1R3Wlk6w9mSUtTBxSnX8JtIL+frnvt8RJN9RSOgOwn
         iSVr7zxzs/IhQ2ga5gcTvO/jQE0JLnDauh6aV5RXAET1vjAO7lunBJft14+lxu0myvZ0
         xXWOGD8toC+lqFzYahpTsMMvg2wlDGWz+FfK5GBUWa2dHv3+3RGHbelewZIfAKDmu+py
         rGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714246508; x=1714851308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Stx8L8fGNoLmhu7uwssiRKsIuNsvkM32vbRcX+64kfs=;
        b=mImKKHkPC22AFexNcQ+lQND2CaKX/PqOm3pXr9pKVJE6rWlX8Yf6QungnqNWXpG+0q
         WkUs8fKZnmK+5MjvkoIm4xZVHIJWEyoOqV4R1GkOCGcRWVUyUEFWT0kVHbBO7sOWqcrg
         +IpUKKfjtdSJDcpQGad/lOVqDPwZ6mSDAEmUbF26hpxOUItC+uyVkR1nvyd7sU83yw53
         3kp+l0UYhlcpA1j6UHZ0ONHqcaoo5o/pXZJnsNC5HpLYoNCz6e1zFW4gnFFXGAsr6QbP
         gNZpKdvJ9Z8dk+a7swxSaRMzlWR+sR66xxMjSu+0Zdv9s+KlLzEvJVQWS88c3l+mdqwD
         mb+A==
X-Forwarded-Encrypted: i=1; AJvYcCUbIcFwXB9yXi0XkjLkUHUWxlK9ZdJFvgMelh+xkLNPblH5+shCMe4ZzwljRuDPhXgXYp7QS7uoBWAS0VoAn+R5gjxv49ZScw8vtYAc
X-Gm-Message-State: AOJu0YyIaK0iKcb4CHQYP3gArfcFnL1AjafIXWLh3a1JSnyhF7WuYeEr
	ED1idXImKO/LyzBoj+IwSMX0HGvtuWka+GNUmd9dXIUQov5XfZE4joBykJqtudE=
X-Google-Smtp-Source: AGHT+IES5MUiJ9OraOakB9jf7NP4P4rHXIOSA7qspSCjNVFlnKT+Q6NTqcrIAU2hiEKur9kyJBoOOw==
X-Received: by 2002:ac2:5f62:0:b0:51c:d6c9:e964 with SMTP id c2-20020ac25f62000000b0051cd6c9e964mr1729562lfc.50.1714246508455;
        Sat, 27 Apr 2024 12:35:08 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id k2-20020a05651239c200b0051ba2fb069dsm1665427lfu.37.2024.04.27.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:35:08 -0700 (PDT)
Date: Sat, 27 Apr 2024 21:35:06 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <Zi1Tang5RQMmEFdx@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>

I'm running a dual lan8650 setup, neither IC passed the sw reset in the
oa_tc.c module, I need to pull the reset pin low to reset the pin before
the rest of the init stuff happens.

The datasheet recommends not doing a sw reset, excerpt from section
4.1.1.3 Software Reset
"Note: The SW_RESET bit of the Clause 22 Basic Control register will reset only the internal PHY, not
the entire device. This PHY only reset is not recommended for use. If such a reset is detected, by
reading the RESETC bit of the STS2 register, reset the entire device."

Doing a hw reset followed by a sw reset seems to work fine though. I
added the folloing patch to get things moving.

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 72a663f14f50..993c4f9dec7e 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
+#include <linux/gpio/driver.h>

 #define DRV_NAME                       "lan865x"

@@ -36,6 +37,7 @@ struct lan865x_priv {
        struct net_device *netdev;
        struct spi_device *spi;
        struct oa_tc6 *tc6;
+       struct gpio_desc *reset_gpio;
 };

 static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
@@ -283,6 +285,29 @@ static int lan865x_set_zarfe(struct lan865x_priv *priv)
        return oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG0, regval);
 }

+static int lan865x_probe_reset_gpio(struct lan865x_priv *priv)
+{
+       priv->reset_gpio = devm_gpiod_get_optional(&priv->spi->dev,
+                                           "reset",
+                                           GPIOD_OUT_HIGH);
+       if (IS_ERR(priv->reset_gpio)) {
+               dev_err(&priv->spi->dev, "failed to parse reset gpio from dt");
+               return PTR_ERR(priv->reset_gpio);
+       }
+
+       return 0;
+}
+
+static void lan865x_hw_reset(struct lan865x_priv *priv)
+{
+       dev_info(&priv->spi->dev, "resetting device");
+       gpiod_set_value(priv->reset_gpio, 1);
+       // the datasheet specifies a minimum 5µs hold time
+       usleep_range(5,10);
+       gpiod_set_value(priv->reset_gpio, 0);
+       dev_info(&priv->spi->dev, "reset completed");
+}
+
 static int lan865x_probe(struct spi_device *spi)
 {
        struct net_device *netdev;
@@ -297,6 +322,9 @@ static int lan865x_probe(struct spi_device *spi)
        priv->netdev = netdev;
        priv->spi = spi;
        spi_set_drvdata(spi, priv);
+       lan865x_probe_reset_gpio(priv);
+       if(priv->reset_gpio)
+               lan865x_hw_reset(priv);
        INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);

        priv->tc6 = oa_tc6_init(spi, netdev);

Since the chip does have a HW reset pin I think it would be nice to
at least expose this as an optional dt binding.
Maybe ignore the prints I forgot to remove :)

