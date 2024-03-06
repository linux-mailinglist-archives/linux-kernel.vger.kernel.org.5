Return-Path: <linux-kernel+bounces-93946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF24873757
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C7D1F282ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317F2130AE0;
	Wed,  6 Mar 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLYabXxi"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296A5F566;
	Wed,  6 Mar 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730377; cv=none; b=cB8oWrHwP303updni9Z5eD3TUd1fvpZEzE+B+jw26hEdAS9RPUFSv3IICzNykymwPUYfF7Xt6ezBaj7UpuIGfnTDzlP3cnKj0b7ef9r5nV9VEGMc+H5FBtmCb/xMaOdU+w3Sx7KLEwSHcIgWXwW05cdMAG7428VG6blrHdhNJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730377; c=relaxed/simple;
	bh=ZaaYiFoVLdyewEKaT0gopyggjG7/3+GsnvfgJScPf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB6HpQArDr2C81wilUxr5ukH9FRH/ki9dnjb0LNhGltR+Iimj8FJ2wagCkhfytbCaVsKC0aWdp0H8xuH/jtl7y/DTza/Som2CGNhSE4HV2dG3dl1hIDPVHrpb8CoDTMQC+2fvVKmnYntldOxgjOkiFwCgI0YTCFj+Fqniogaa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLYabXxi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60978479651so64410407b3.3;
        Wed, 06 Mar 2024 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730374; x=1710335174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Oi3DIHf6RcVnBQ6jfEGvzGhX4KFvOXX/NtautGKE4=;
        b=aLYabXxiqWKPvyDsBD4iXIODM7CSwumQ7XGNUf5oBIodirPEg67Xi9yX2pc4pNZ23D
         OG5vo9pjzauPW2gQhJdMfYCIPPPxphHF4LT6AN6Ffd4IUbacZN9dkOU1JKuXP5R6/SQu
         YlFIZnnucrNirkgAdZD+G2dV8VTgX7Ev1ll5IiBnX4VToUN3UwZAToqGN30aFXrIrxhp
         heru7jrthCQgECDt06VRl4TCw0407+toJZzH//aR8dAW4X/brDkrJwE/5jaytmK0nmh9
         jdoKrxs00KZLY0IPwk7lzEI0aH/OXhlPIJgC416TEBmGC/iFAOGosv+0GgvqAYuKAHmg
         sNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730374; x=1710335174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0Oi3DIHf6RcVnBQ6jfEGvzGhX4KFvOXX/NtautGKE4=;
        b=m7/Vi2S8XN00fOwBTPBkY48GqQ+4/zZUfjvQEtMWvMZwgvjZFNkWpsuSsxo2USw+/t
         1ZhRCKjzznCttN9ucNHIyRGRh8/QeKKxlPQX9zhZV+/iZVDQ73shSs06ewA6W+P1NPO+
         Yxp0AVBloMpYEeIu7gKGFSPFKg90flIUtvOjNF0kAhGacQwdCwV2Yse4DJrwUU/hZfJE
         hcW29yUfQzO8qGYWY45U5QecGHdOaAG8fVJYh80JW4xdKE9iE+xe9uw9Vg6u9F0Hrf4N
         lXl8sOq8s/iE+bBVCPo/ec+sZNqQ/HOlA9y6N+ag7lC7qcitwGfnyMv/3E530xJFeJ59
         +6Og==
X-Forwarded-Encrypted: i=1; AJvYcCWags5BwvHwIWrsK6AhRRFSwHb9ABn8+Wivaq08eD69Yg+tbCNS8fBKZfJTccXBvvHq4/PTmiD7splWgno4jA4xZxz7F4DN96jxIHEZ7a6zg5xDPTdUsDqaNxGwscuUEpTaqd37
X-Gm-Message-State: AOJu0Yx4u8cCPNjStxJx3G/zI7uqwpaKncH3A3l97EbWjjUwhi8lQuAA
	BZnoyRRIX88NBXG0njRDU6vxexRTa551YIv6eCt+XC7GUjLyzQdm
X-Google-Smtp-Source: AGHT+IE+aoLOnpZkLP/3EfQ+xyS+L+4GWolxGYGRGD6QvHKeBWbWI3i1ajDfNqpm2ci7qFy0mSU4Mg==
X-Received: by 2002:a81:5b08:0:b0:609:bd7b:bb55 with SMTP id p8-20020a815b08000000b00609bd7bbb55mr7704201ywb.23.1709730374439;
        Wed, 06 Mar 2024 05:06:14 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:a708:4ac5:2d2f:c5bb])
        by smtp.gmail.com with ESMTPSA id s123-20020a0de981000000b0060968d94177sm3683591ywe.15.2024.03.06.05.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:06:13 -0800 (PST)
Date: Wed, 6 Mar 2024 05:06:12 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <ZehqRMZwtazTf6P6@yury-ThinkPad>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306080726.167338-5-herve.codina@bootlin.com>

On Wed, Mar 06, 2024 at 09:07:20AM +0100, Herve Codina wrote:
> QMC channels support runtime timeslots changes but nothing is done at
> the QMC HDLC driver to handle these changes.
> 
> Use existing IFACE ioctl in order to configure the timeslots to use.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/wan/fsl_qmc_hdlc.c | 151 ++++++++++++++++++++++++++++++++-
>  1 file changed, 150 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
> index 90063a92209e..31c0f32474a3 100644
> --- a/drivers/net/wan/fsl_qmc_hdlc.c
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -10,6 +10,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bug.h>
>  #include <linux/cleanup.h>
> +#include <linux/bitmap.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -39,6 +40,7 @@ struct qmc_hdlc {
>  	struct qmc_hdlc_desc tx_descs[8];
>  	unsigned int tx_out;
>  	struct qmc_hdlc_desc rx_descs[4];
> +	u32 slot_map;
>  };
>  
>  static struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> @@ -203,6 +205,144 @@ static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> +{
> +	DECLARE_BITMAP(ts_mask_avail, 64);
> +	DECLARE_BITMAP(ts_mask, 64);
> +	DECLARE_BITMAP(map, 64);
> +
> +	/* Tx and Rx available masks must be identical */
> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> +	bitmap_from_u64(map, slot_map);
> +	bitmap_scatter(ts_mask, map, ts_mask_avail, 64);

We've got a BITMAP_FROM_U64() for this:

	DECLARE_BITMAP(ts_mask_avail, 64) = { BITMAP_FROM_U64(ts_info->rx_ts_mask_avail) };
	DECLARE_BITMAP(map, 64) = { BITMAP_FROM_U64(slot_map) };

> +
> +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %64pb -> (%64pb, %64pb)\n",
> +			map, ts_mask_avail, ts_mask);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_to_arr64(&ts_info->tx_ts_mask, ts_mask, 64);
> +	ts_info->rx_ts_mask = ts_info->tx_ts_mask;
> +	return 0;
> +}
> +
> +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
> +{
> +	DECLARE_BITMAP(ts_mask_avail, 64);
> +	DECLARE_BITMAP(ts_mask, 64);
> +	DECLARE_BITMAP(map, 64);
> +	u32 array32[2];

NIT. Bad name. I'd suggest slot_array, or something.

> +	/* Tx and Rx masks and available masks must be identical */
> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> +		return -EINVAL;
> +	}
> +	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
> +		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> +	bitmap_from_u64(ts_mask, ts_info->rx_ts_mask);

Same as above, can you try using BITMAP_FROM_U64()?

Thanks,
Yury

> +	bitmap_gather(map, ts_mask, ts_mask_avail, 64);
> +
> +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (%64pb, %64pb) -> %64pb\n",
> +			ts_mask_avail, ts_mask, map);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_to_arr32(array32, map, 64);
> +	if (array32[1]) {
> +		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (%64pb, %64pb) -> %64pb\n",
> +			ts_mask_avail, ts_mask, map);
> +		return -EINVAL;
> +	}
> +
> +	*slot_map = array32[0];
> +	return 0;
> +}
> +
> +static int qmc_hdlc_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface, const te1_settings *te1)
> +{
> +	struct qmc_chan_ts_info ts_info;
> +	int ret;
> +
> +	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
> +		return ret;
> +	}
> +	ret = qmc_hdlc_xlate_slot_map(qmc_hdlc, te1->slot_map, &ts_info);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmc_chan_set_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "set QMC channel ts info failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	qmc_hdlc->slot_map = te1->slot_map;
> +
> +	return 0;
> +}
> +
> +static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
> +{
> +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> +	te1_settings te1;
> +
> +	switch (ifs->type) {
> +	case IF_GET_IFACE:
> +		ifs->type = IF_IFACE_E1;
> +		if (ifs->size < sizeof(te1)) {
> +			if (!ifs->size)
> +				return 0; /* only type requested */
> +
> +			ifs->size = sizeof(te1); /* data size wanted */
> +			return -ENOBUFS;
> +		}
> +
> +		memset(&te1, 0, sizeof(te1));
> +
> +		/* Update slot_map */
> +		te1.slot_map = qmc_hdlc->slot_map;
> +
> +		if (copy_to_user(ifs->ifs_ifsu.te1, &te1, sizeof(te1)))
> +			return -EFAULT;
> +		return 0;
> +
> +	case IF_IFACE_E1:
> +	case IF_IFACE_T1:
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		if (netdev->flags & IFF_UP)
> +			return -EBUSY;
> +
> +		if (copy_from_user(&te1, ifs->ifs_ifsu.te1, sizeof(te1)))
> +			return -EFAULT;
> +
> +		return qmc_hdlc_set_iface(qmc_hdlc, ifs->type, &te1);
> +
> +	default:
> +		return hdlc_ioctl(netdev, ifs);
> +	}
> +}
> +
>  static int qmc_hdlc_open(struct net_device *netdev)
>  {
>  	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> @@ -326,12 +466,13 @@ static const struct net_device_ops qmc_hdlc_netdev_ops = {
>  	.ndo_open       = qmc_hdlc_open,
>  	.ndo_stop       = qmc_hdlc_close,
>  	.ndo_start_xmit = hdlc_start_xmit,
> -	.ndo_siocwandev	= hdlc_ioctl,
> +	.ndo_siocwandev = qmc_hdlc_ioctl,
>  };
>  
>  static int qmc_hdlc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct qmc_chan_ts_info ts_info;
>  	struct qmc_hdlc *qmc_hdlc;
>  	struct qmc_chan_info info;
>  	hdlc_device *hdlc;
> @@ -357,6 +498,14 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, -EINVAL, "QMC chan mode %d is not QMC_HDLC\n",
>  				     info.mode);
>  
> +	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "get QMC channel ts info failed\n");
> +
> +	ret = qmc_hdlc_xlate_ts_info(qmc_hdlc, &ts_info, &qmc_hdlc->slot_map);
> +	if (ret)
> +		return ret;
> +
>  	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
>  	if (!qmc_hdlc->netdev)
>  		return -ENOMEM;
> -- 
> 2.43.0

