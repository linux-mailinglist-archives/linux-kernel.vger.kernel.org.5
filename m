Return-Path: <linux-kernel+bounces-42288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133883FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB241C2253F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3684EB3E;
	Mon, 29 Jan 2024 07:41:36 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CC1E883;
	Mon, 29 Jan 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514095; cv=none; b=PkYUEWrDgsM1twxnbjwp2uDqggH+8sEZtb9K/7jfN4k2dsf5t97u/jEpVtJRTqL1oLK98XwF30rgceQ1zVjd6jgnJurBjn01xDMItNn6xBvIpKz93h1OcqTMJAR/xskZHZXBlvle72jRh5vNAWlChjuPIR5he0VZEnzCvz/pZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514095; c=relaxed/simple;
	bh=o53DGPsZNF0srMPMs10WqrNlKTGfDjfzdCuAXKKzAmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JZZ2a8bx4CBARQxUw2XIsrzdzuRQXqoBWrT+nbv5oarBLAsxuY/JaAm6logetqT2iG1QQig2AbaEXzk6uSmDDXinwX2oOZhM7pkt4i+7SWsEWrKH838yFqjKXkr2XfY5y37d95cmWEnjcmY0t5+zxy83xaUxhWIwrCjO2uIHGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aec51.dynamic.kabel-deutschland.de [95.90.236.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DF9761E5FE01;
	Mon, 29 Jan 2024 08:40:45 +0100 (CET)
Message-ID: <f3074467-09d1-4768-96a7-1f42d068ea81@molgen.mpg.de>
Date: Mon, 29 Jan 2024 08:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] bluetooth: ti-st: Add GNSS subdevice for TI
 Wilink chips
Content-Language: en-US
To: Andreas Kemnade <andreas@kemnade.info>
References: <20240128173352.2714442-1-andreas@kemnade.info>
 <20240128173352.2714442-3-andreas@kemnade.info>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?Q?P=C3=A9ter_Ujfalusi?=
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240128173352.2714442-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andreas,


Am 28.01.24 um 18:33 schrieb Andreas Kemnade:
> Some of these chips have GNSS support. GNSS support
> is available through channel 9 whilst FM is through channel 8.
> Add a platform subdevice for GNSS so that a driver for that
> functionality can be build. To avoid having useless GNSS

be buil*t*

> devices, do it only when the devicetree node namecontains gnss.

… name contains …

This could be re-flowed for 75 characters per line.

Also, I believe, you should capitalize the commit message summary prefix 
Bluetooth.

An what device were you able to test this?

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/bluetooth/hci_ll.c   | 81 ++++++++++++++++++++++++++++++++++++
>   include/linux/ti_wilink_st.h |  8 ++++
>   2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 4a0b5c3160c2b..09e5a4dbd2f8c 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -32,6 +32,7 @@
>   #include <linux/signal.h>
>   #include <linux/ioctl.h>
>   #include <linux/of.h>
> +#include <linux/platform_device.h>
>   #include <linux/serdev.h>
>   #include <linux/skbuff.h>
>   #include <linux/ti_wilink_st.h>
> @@ -68,6 +69,9 @@ struct ll_device {
>   	struct gpio_desc *enable_gpio;
>   	struct clk *ext_clk;
>   	bdaddr_t bdaddr;
> +
> +	void (*gnss_recv_func)(struct device *dev, struct sk_buff *skb);
> +	struct platform_device *gnssdev;
>   };
>   
>   struct ll_struct {
> @@ -78,6 +82,8 @@ struct ll_struct {
>   	struct sk_buff_head tx_wait_q;	/* HCILL wait queue	*/
>   };
>   
> +static int ll_gnss_register(struct ll_device *lldev);
> +static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
>   /*
>    * Builds and sends an HCILL command packet.
>    * These are very simple packets with only 1 cmd byte
> @@ -411,6 +417,13 @@ static int ll_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>   	.lsize = 0, \
>   	.maxlen = 0
>   
> +#define LL_RECV_GNSS \
> +	.type = 9, \
> +	.hlen = 3, \
> +	.loff = 1, \
> +	.lsize = 2
> +
> +
>   static const struct h4_recv_pkt ll_recv_pkts[] = {
>   	{ H4_RECV_ACL,       .recv = hci_recv_frame },
>   	{ H4_RECV_SCO,       .recv = hci_recv_frame },
> @@ -419,6 +432,7 @@ static const struct h4_recv_pkt ll_recv_pkts[] = {
>   	{ LL_RECV_SLEEP_ACK, .recv = ll_recv_frame  },
>   	{ LL_RECV_WAKE_IND,  .recv = ll_recv_frame  },
>   	{ LL_RECV_WAKE_ACK,  .recv = ll_recv_frame  },
> +	{ LL_RECV_GNSS,      .recv = ll_gnss_recv_frame },
>   };
>   
>   /* Recv data */
> @@ -677,9 +691,69 @@ static int ll_setup(struct hci_uart *hu)
>   		}
>   	}
>   
> +	if (strstr(of_node_full_name(serdev->dev.of_node), "gnss"))
> +		ll_gnss_register(lldev);
> +
> +	return 0;
> +}
> +
> +struct hci_dev *st_get_hci(struct device *dev)
> +{
> +	struct ll_device *lldev = dev_get_drvdata(dev);
> +
> +	return lldev->hu.hdev;
> +}
> +EXPORT_SYMBOL(st_get_hci);
> +
> +void st_set_gnss_recv_func(struct device *dev,
> +			   void (*recv_frame)(struct device *, struct sk_buff *))
> +{
> +	struct ll_device *lldev = dev_get_drvdata(dev);
> +
> +	lldev->gnss_recv_func = recv_frame;
> +}
> +EXPORT_SYMBOL(st_set_gnss_recv_func);
> +
> +static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct ll_device *lldev = container_of(hu, struct ll_device, hu);
> +
> +	if (!lldev->gnssdev)
> +		return 0;
> +
> +	if (lldev->gnss_recv_func) {
> +		lldev->gnss_recv_func(&lldev->gnssdev->dev, skb);
> +		return 0;
> +	}
> +	kfree_skb(skb);
> +
>   	return 0;
>   }
>   
> +static int ll_gnss_register(struct ll_device *lldev)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("ti-ai2-gnss", PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	pdev->dev.parent = &lldev->serdev->dev;
> +	lldev->gnssdev = pdev;
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	lldev->gnssdev = NULL;
> +	platform_device_put(pdev);
> +	return ret;
> +}
> +
>   static const struct hci_uart_proto llp;
>   
>   static int hci_ti_probe(struct serdev_device *serdev)
> @@ -757,12 +831,19 @@ static int hci_ti_probe(struct serdev_device *serdev)
>   	}
>   
>   	return hci_uart_register_device(hu, &llp);
> +
> +
> +	return 0;
>   }
>   
> +
>   static void hci_ti_remove(struct serdev_device *serdev)
>   {
>   	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
>   
> +	if (lldev->gnssdev)
> +		platform_device_unregister(lldev->gnssdev);
> +
>   	hci_uart_unregister_device(&lldev->hu);
>   }
>   
> diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
> index 10642d4844f0c..eccc2db004069 100644
> --- a/include/linux/ti_wilink_st.h
> +++ b/include/linux/ti_wilink_st.h
> @@ -381,6 +381,14 @@ unsigned long st_ll_getstate(struct st_data_s *);
>   unsigned long st_ll_sleep_state(struct st_data_s *, unsigned char);
>   void st_ll_wakeup(struct st_data_s *);
>   
> +/**
> + * various funcs used to interact between FM, GPS and BT
> + */
> +struct hci_dev *st_get_hci(struct device *dev);
> +void st_set_gnss_recv_func(struct device *dev,
> +			   void (*recv_frame)(struct device *, struct sk_buff *));
> +
> +
>   /*
>    * header information used by st_core.c for FM and GPS
>    * packet parsing, the bluetooth headers are already available

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

