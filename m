Return-Path: <linux-kernel+bounces-161153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FD8B47B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B0A2822DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49D1419BA;
	Sat, 27 Apr 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="FRhWZwZV"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863A17C96
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714247541; cv=none; b=FO2Ruz3zDEI3QzmxWgJ9CpLX2TnL0875nQ6wL6iXeCy2ZSeSckDtRXW6/EhOBU3Nt9RavGUrMp8L4cPh2mEnG2uehvUoWNVlnvmaq4ScoRvVVDOapGwagzCjtvH5NSntGDbym3unwvhDsEqNvi0Sl5ZSuOXLau6utC2hdTGDNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714247541; c=relaxed/simple;
	bh=3Ewxc+4EgRTu35ocuTGFRfxCwRUphjR2/d2GK3x8Ya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVT/tO2vgLlzmawM8lm8sEaSbFswG6XveWA8/JAEJvYngAkUY9R6tnu06LuPHpj5NgX0zHZ/UPwcyuj8Ja64gwHp/oU5g9AcPWw3tgwo3Lgz8/irgax8TsqnAnKZtMy3zUkyDJSvv1aw1xObIJopleBR4BHXMORfemNETIUAkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=FRhWZwZV; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso3817052e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714247538; x=1714852338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C717sy7HESzTqC6PBBXuac04TnVTsFe4RZ+aECuy0tM=;
        b=FRhWZwZVbKbR+hD6aMOMqY+f/Z2GJ3QXcyCkFvaLm/qhpfFiS9u59pg+E1Vk3DSqSP
         XvAtNil0q2KJrmGZ75X6G+FnmlHLTis4z5DeoAIY8Ytp3m6riaYlI4uCaWFU8XWQZ7rX
         35vD5xIHTJxSx25FT3NkM8Uitc80iBoeN3v6tAgPYrMnUR3EC8XqyqZOuq47/XadqJ5D
         myImJC5JirpaMjpKNXwI08poPjSIYcCYFI/z5gSjm2hkFhZFo4S24GAvO8KVtD5+EInm
         9gpXoSB8q1Ovi2EJ/Vuvc9/KpSG21SJsUXjGZYAclLOA0a4QJNp3cyinmfIyf2q5nder
         QJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714247538; x=1714852338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C717sy7HESzTqC6PBBXuac04TnVTsFe4RZ+aECuy0tM=;
        b=A7ONN9wdfKsohHcxPoAloZRGZvQZlQ7nbn4TkVg4pDdxjNWd5hNmk0obKAHOmsVXi2
         GGyu3MWVfc6wGaPwYbNG8iFSkfzbI5s0XPjxE7DBEjXvkm2ElRRikAqUOTZ44i+0m6Cj
         RKEIe9zjWYAnzFww9ceprdXqLlR4VZipkj0uOnh/AfW2s3WToPjIJkFBb5KS08olf6Hz
         TpHVqCaw3PNmBh+JMUCQJSzGo0Z5sjiy0O38tUcSbExzgoCv4DIOZKo6EMjrvbQMmkj2
         VRgVJykr4El7Y5MJAveATTtdMr6uOfVrYF0DBWOc166v1Z2YnYhH4d2asxHBJ5luwzrE
         CqLg==
X-Forwarded-Encrypted: i=1; AJvYcCVEM8r+58PHT1GxAK4+QSYrG+g5L2HWn3qx4PXeiFFRlC9LkMjNBgrCTo2ybi6+eFGv6eBbpgGaPNnW0JrrF8Ks2O7Q8vuGJMF2UUjS
X-Gm-Message-State: AOJu0YwfLpCOIG/8+E39kaBDdtH6/o5q+YHA+Lib+BZSkHoUNihCKXHk
	fhKQlljxXYB9xJtY2XGJiosdeaA9FbmCToCEFCcRK04iSqC8l1YUULZFSbLwhBQ=
X-Google-Smtp-Source: AGHT+IFR3li6z15el7O63+H4A3ZvNHaqReGolVtftw20ytT2TAbbVQWnQhcBqmUbcnr5fRasmGCj3A==
X-Received: by 2002:ac2:5f1a:0:b0:51a:cafd:3830 with SMTP id 26-20020ac25f1a000000b0051acafd3830mr3734547lfq.7.1714247537635;
        Sat, 27 Apr 2024 12:52:17 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id p20-20020a05651212d400b00517626d22d2sm3521446lfg.83.2024.04.27.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:52:17 -0700 (PDT)
Date: Sat, 27 Apr 2024 21:52:15 +0200
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
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <Zi1Xbz7ARLm3HkqW@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
> +		    INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
> +		    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
> +		    INT_MASK0_HEADER_ERR_MASK);
> +
> +	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> +}
> +

This togheter with patch 11 works poorly for me. I get alot of kernel
output, dropped packets and lower performance.
Below is an example for a run when I curl a 10MB blob

time curl 20.0.0.55:8000/rdump -o dump -w '{%speed_download}'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  U[  387.944737] net_ratelimit: 38 callbacks suppressed
pload   Total   Spent    Left  Sp[  387.944755] eth0: Receive buffer overflow error
eed
  0     0    0     0    0     0      0      0 --:--:-- --:-[  387.961424] eth0: Receive buffer overflow error
  0 10.0M    0  2896    0     0  13031      0  0:13:24 --:--:--  0:13:24 12986[  388.204257] eth0: Receive buffer overflow error
[  388.209848] eth0: Receive buffer overflow error
[  388.240705] eth0: Receive buffer overflow error
[  388.246205] eth0: Receive buffer overflow error
[  388.360265] eth0: Receive buffer overflow error
[  388.365755] eth0: Receive buffer overflow error
[  388.371328] eth0: Receive buffer overflow error
[  388.396937] eth0: Receive buffer overflow error
 32 10.0M   32 3362k    0     0   826k      0  0:00:12  0:00:04  0:00:08  826k[  392.950696] net_ratelimit: 84 callbacks suppressed
[  392.950711] eth0: Receive buffer overflow error
 41 10.0M   41 4259k    0     0   840k      0  0:00:12  0:00:05  0:00:07  878k[  393.009785] eth0: Receive buffer overflow error
[  393.016651] eth0: Receive buffer overflow error
[  393.121278] eth0: Receive buffer overflow error
[  393.126876] eth0: Receive buffer overflow error
[  393.204983] eth0: Receive buffer overflow error
[  393.210590] eth0: Receive buffer overflow error
[  393.248977] eth0: Receive buffer overflow error
[  393.254575] eth0: Receive buffer overflow error
[  393.352949] eth0: Receive buffer overflow error
 77 10.0M   77 7903k    0     0   870k      0  0:00:11  0:00:09  0:00:02  906k[  397.956674] net_ratelimit: 88 callbacks suppressed
[  397.956691] eth0: Receive buffer overflow error
[  397.967182] eth0: Receive buffer overflow error
 86 10.0M   86 8837k    0     0   877k      0  0:00:11  0:00:10  0:00:01  915k[  398.048630] eth0: Receive buffer overflow error
[  398.054171] eth0: Receive buffer overflow error
[  398.092858] eth0: Receive buffer overflow error
[  398.113975] eth0: Receive buffer overflow error
[  398.177558] eth0: Receive buffer overflow error
[  398.209782] eth0: Receive buffer overflow error
[  398.272621] eth0: Receive buffer overflow error
[  398.278306] eth0: Receive buffer overflow error
100 10.0M  100 10.0M    0     0   877k      0  0:00:11  0:00:11 --:--:--  921k
{%speed_download}
real    0m11.681s
user    0m0.117s
sys     0m0.226s

I tried this patch

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 9f17f3712137..bd7bd3ef6897 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -615,21 +615,9 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
        return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 }

-static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
+static int oa_tc6_disable_imask0_interrupts(struct oa_tc6 *tc6)
 {
-       u32 regval;
-       int ret;
-
-       ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
-       if (ret)
-               return ret;
-
-       regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
-                   INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
-                   INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
-                   INT_MASK0_HEADER_ERR_MASK);
-
-       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, (u32)-1);
 }

 static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
@@ -1234,7 +1222,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
                return NULL;
        }

-       ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
+       ret = oa_tc6_disable_imask0_interrupts(tc6);
        if (ret) {
                dev_err(&tc6->spi->dev,
                        "MAC-PHY error interrupts unmask failed: %d\n", ret);

Which results in no log spam, ~5-10% higher throughput and no dropped
packets when I look at /sys/class/net/eth0/statistics/rx_dropped

Wheras when I did an equivalent run with a 100MB file I got 1918
rx_dropped with interrupts enabled.

When I dig through wireshark I can see some retransmissions when
interrupts are disabled, but the network stack seems to handle that with
grace.

Maybe the decision on wheter to enable interrupts or not should be on
the mac driver level, not network framework level?
If this really is preferrable for some reason, could a module option be
added so that it does not require running a fork to disable interrupts?

There is also a interrupt mask 1 register that is not touched in this
patch series, and since things started working better for me with just
touching reg0 I didn't bother tweaking anything int reg1.

BR
Ramón

