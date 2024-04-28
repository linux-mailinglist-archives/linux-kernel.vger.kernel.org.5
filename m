Return-Path: <linux-kernel+bounces-161352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357A8B4B0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB891F215D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562856B6A;
	Sun, 28 Apr 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="uZwkVbrQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87954FAB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298066; cv=none; b=fBfydWeCXyW7Ik2G6O3H1q0RnSuSy3no5TDtwVgJAOz2XXCTaQmwp+Zj3lqafqm3xF+ePaQG4fX5vUHZETiYTdXrNFQCHsey8n5e9aF6QhLchncjeZrP32D+7fCZ1bOb8yFFT2nxOZ/wleSLm/qjsbKdJAjB4G03je+RdJEJSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298066; c=relaxed/simple;
	bh=XfwPvtFVa37rQ9j0JNfy5Q8xawgeFhod/zhdXWAvcW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUbtOuE6t5OInrx5ijljPo1qD4tRzuwQS170h3DEV7/BUrZ84f9PX+FJgVQAcFkN2/sQJEmrr+YJ4TPl93UU9sJepUKsnadl7k2FUnuJK3ZdbHWNiaodcqtHt2+DOb8Sk+DYEq/pqZlwOKxTa5MMmJ2BxKOmg7sPkkQ4NMtk4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=uZwkVbrQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d2600569so4239997e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714298063; x=1714902863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMrhY6/jdHr+5rbk2vYpIblfqORgrZnbq6o4kFL2leY=;
        b=uZwkVbrQlvguK8Wt+X9Ta4u9WiSuOKwvIgRL4/CiWxXVEke52BTXTXSIemT64bhvpC
         d6XYuSg+af72JcIQ3uE6oKGT8E/pX8fhgU1NQUGYUAytvvZzePh6+UiizmfVRQg/Sj4b
         /6Nqrd1U2CkFqSv2cdwXsigAX83Uj9/42SetQazhsqg/9Z5rJYrVV6J6m5iZv1vLuLgD
         4srN3znNw7yh2lCcUfQ9pHMP3qFrNmQ/TqBYtrQcYUM+YBRYTVm9DdPCISsKPymw4nRP
         RrBy1CTaRvEzJdc36zwjDjFRRnsuH+qa2NWk7jFKViEYZjxELTplcuGbbg8MAdNd4Hzv
         GP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714298063; x=1714902863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMrhY6/jdHr+5rbk2vYpIblfqORgrZnbq6o4kFL2leY=;
        b=w8V9QftcQl2ga9ZrAJNfgkpPhGmrCUNUk9/CsKO3NuOKqno4gKNaKRgMVh6a5sOrAi
         oPkiCOFpQj/JGNlU2dTqL2AmBC9SvlIZn4u5Pgy0HHvhhk0JfVc445xiwbG15AAmwBxI
         cmqGuey9JopFW6FZ2lylLbOW4/68AU8FN+FrsXvufkq/KdDeqU9OhtBiVB/CaHUKJJFa
         se7ZosLCqGw+tkQppRKvA5cWTHmi1sW/E87zIG4P9em7dr40MJ5j9igwRD1WTcWHsmLQ
         AQJXEQNQqmpz6xD403pwZ7eeet+PgQDMJYJzbvNJ1Ixs8nEgSI01z4/lZDjJnZibKMEt
         COrg==
X-Forwarded-Encrypted: i=1; AJvYcCU5UEBygAkrVDFeyR3Ky3eIVUW5IomA+BIQ/WdB8kvVFugbjG3H3MbcHXqeTeYa1qFSol7wElEt4Zji8DalFOdkZ63XwefNt8ht7XRv
X-Gm-Message-State: AOJu0Yy0DtBVCLldrn/UmjDKTlEV6RrRDlJJN5wvnj2hnRBU7pO+5/6R
	JQ5rhXh9NEW4E8TDMS8AnXalQJNpTrEPCVR3qUk9T7t/+f4VNWKm/6oja1gcE/I=
X-Google-Smtp-Source: AGHT+IGn32KqwhwvFwaFNH1nncKg1jRLmaHfbV2LvHlzEopH2e+yZMzEFTLRlpSlHe3WAJQd/h2+Lw==
X-Received: by 2002:a05:6512:46c:b0:518:ce4b:17ef with SMTP id x12-20020a056512046c00b00518ce4b17efmr2768833lfd.60.1714298062439;
        Sun, 28 Apr 2024 02:54:22 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id l17-20020ac24a91000000b005196e3e8a84sm3719795lfp.177.2024.04.28.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 02:54:22 -0700 (PDT)
Date: Sun, 28 Apr 2024 11:54:20 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
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
Message-ID: <Zi4czGX8jlqSdNrr@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>

> It could be the performance increase comes from two places:
> 
> 1) Spending time and bus bandwidth dealing with the buffer overflow
> interrupt
> 
> 2) Printing out the serial port.
> 
> Please could you benchmark a few things:
> 
> 1) Remove the printk("Receive buffer overflow error"), but otherwise
> keep the code the same. That will give us an idea how much the serial
> port matters.
> 
> 2) Disable only the RX buffer overflow interrupt
> 
> 3) Disable all error interrupts.
> 



Test setup
- Server side - 
PC with a lan8670 usb eval board running a http server that serves
a 10MB binary blob. The http server is just python3 -m http.server

- Client side -
iMX8mn board (quad core arm64) with lan8650 mac-phy (25MHz spi)
running curl to download the blob from the server and writing to
a ramfs (ddr4 1.xGHz, so should not be a bottleneck)

Below are a collection of samples of different test runs. All of the
test runs have run a minor patch for hw reset (else nothing works for me).
Using curl is not the most scientific approach here, but iperf has
not exposed any problems for me earlier with overflows.
So sticking with curl since it's easy and definetly gets the overflows.

n  |  name     |  min  |  avg  |  max  |  rx dropped  |  samples
1  |  no mod   |  827K |  846K |  891K |      945     |     5
2  |  no log   |  711K |  726K |  744K |      562     |     5
3  |  less irq |  815K |  833K |  846K |      N/A     |     5
4  |  no irq   |  914K |  924K |  931K |      N/A     |     5
5  |  simple   |  857K |  868K |  879K |      615     |     5

Description of each scenario

1 - no mod
So this just runs a hw reset to get the chip working (described in earlier posts)

2 - no log
This scenario just removes the logging when handling the irq state
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -688,8 +688,6 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
        if (FIELD_GET(STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
                tc6->rx_buf_overflow = true;
                oa_tc6_cleanup_ongoing_rx_skb(tc6);
-               net_err_ratelimited("%s: Receive buffer overflow error\n",
-                                   tc6->netdev->name);
                return -EAGAIN;
        }
        if (FIELD_GET(STATUS0_TX_PROTOCOL_ERROR, value)) {

3 - less irq
This scenario disables the overflow interrupt but keeps the others

--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -625,10 +625,10 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
                return ret;

        regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
-                   INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
                    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
                    INT_MASK0_HEADER_ERR_MASK);

+       regval |= INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK;
        return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 }

4 - no irq
This scenario disables all imask0 interrupts with the following change

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 9f17f3712137..88a9c6ccb37a 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -624,12 +624,7 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
        if (ret)
                return ret;

-       regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
-                   INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
-                   INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
-                   INT_MASK0_HEADER_ERR_MASK);
-
-       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, (u32)-1);
 }

 static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)


5 - simple
This keeps the interrupt but does not log or drop the socket buffer on irq
Moving the rx dropped increment here makes it more of a irq counter I guess,
so maybe not relevant.

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 9f17f3712137..cbc20a725ad0 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -687,10 +687,7 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)

        if (FIELD_GET(STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
                tc6->rx_buf_overflow = true;
-               oa_tc6_cleanup_ongoing_rx_skb(tc6);
-               net_err_ratelimited("%s: Receive buffer overflow error\n",
-                                   tc6->netdev->name);
-               return -EAGAIN;
+               tc6->netdev->stats.rx_dropped++;
        }
        if (FIELD_GET(STATUS0_TX_PROTOCOL_ERROR, value)) {
                netdev_err(tc6->netdev, "Transmit protocol error\n");


- postamble -

Removing the logging made things considerably slower which probably
indicates that there is a timing dependent behaviour in the driver.

I have a hard time explaining why there is a throughput difference
between scenario 3 and 4 since I did not get the logs that any of the
other interrupts happened.
Maybe the irq handling adds some unexpected context switching overhead.

My recommendation going forward would be to disable the rx buffer
overlow interrupt and removing any code related to handling of it.

R

