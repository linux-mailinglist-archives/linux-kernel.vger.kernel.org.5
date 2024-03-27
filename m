Return-Path: <linux-kernel+bounces-120265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DB88D515
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7002C7720
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C322EF0;
	Wed, 27 Mar 2024 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TjUIK2c6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D1380;
	Wed, 27 Mar 2024 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510584; cv=none; b=Sz5q6se6ZZ++lIqqzvZNbDtoEQqkRgbtXPkNB94R9izka5uySqK0JQfcwdlcjTzBo1Xwgpw3aAOQabbCh70fO6M1GK8vK4+j/AxB6H+y2Enu8+M2wSoKS/pkUc8lgRxk7hVjgoU0BuJSZgX8V/Il3c1r9vKnp3KPyoRz6USRviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510584; c=relaxed/simple;
	bh=ELn58N+L0xZPkRNnH2tXMHqdiTIRFhrdZS8Co23GSYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4CPhQmT9KMxkjXEA/B7dJLwCkSEn+0LnDfEvbDzYm9Wa1C8f5BYe9JFTiVvfDyka3XDOqSu9CpxaiYwH6MY6KPX5VRQejXI3ie8qmlyiodzIx21PK3fklJac/Ino104gswMiO4E2VVrr101qy81niYO3/FFCFuRBpqwYczMcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TjUIK2c6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R2QxMh000777;
	Tue, 26 Mar 2024 20:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=/3g8+gcN/N/fkBBn2xX9Lb
	NNMGPt0xdxXZxOaqbWxH8=; b=TjUIK2c6AEnSxCK1i/ej+oHRMvHhCCtQsX0Hxh
	X9E0HOg3JIjh5Y67QTWFjwvAAh6Q0l20AUaqFg11o5cWEhzu+mkLpHKrP8hKV9nU
	U5Bjg+fWXTgmoIWlmLaXITIfVwr6jhsbuaks1XmJLeLWAjBIXzLdNRDh5XlpmKqN
	5mBwmjGegHFNgZa94k5BdYnsEmKtPx0EsMbPINQfNI48SJ9D6vI9DQkO/EODyDVn
	nBMSEzJ/v3EHplULRG2l2FfDqGrbSg9Yqq9Op3yU8QR7TqPpvKYAEpFFCGRKNQMU
	bJaW3KfisNl6xK6svMlaDZNbeY5aS7+Hlo9ATRQmT1y/IL0Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4ap806nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 20:35:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 26 Mar 2024 20:35:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 26 Mar 2024 20:35:19 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1CAB63F70C2;
	Tue, 26 Mar 2024 20:35:13 -0700 (PDT)
Date: Wed, 27 Mar 2024 09:05:12 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Lukasz Majewski <lukma@denx.de>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet
	<edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel
	<o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>,
        Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>,
        Simon Horman <horms@kernel.org>,
        Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>,
        Murali Karicheri
	<m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Shigeru Yoshida <syoshida@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240327033512.GA1371300@maili.marvell.com>
References: <20240326090220.3259927-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326090220.3259927-1-lukma@denx.de>
X-Proofpoint-GUID: TMpQI2rxpqqFpSpd-C4xTzuUy0S4KnaZ
X-Proofpoint-ORIG-GUID: TMpQI2rxpqqFpSpd-C4xTzuUy0S4KnaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02

On 2024-03-26 at 14:32:20, Lukasz Majewski (lukma@denx.de) wrote:
> --- a/net/hsr/hsr_device.h
> +++ b/net/hsr/hsr_device.h
> @@ -16,8 +16,8 @@
>  void hsr_del_ports(struct hsr_priv *hsr);
>  void hsr_dev_setup(struct net_device *dev);
>  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
> -		     unsigned char multicast_spec, u8 protocol_version,
> -		     struct netlink_ext_ack *extack);
> +		     struct net_device *interlink, unsigned char multicast_spec,
> +		     u8 protocol_version, struct netlink_ext_ack *extack);
>  void hsr_check_carrier_and_operstate(struct hsr_priv *hsr);
>  int hsr_get_max_mtu(struct hsr_priv *hsr);
>  #endif /* __HSR_DEVICE_H */
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 5d68cb181695..7c5a4bda1cca 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -377,6 +377,15 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
>  		 */
>  		ether_addr_copy(eth_hdr(skb)->h_source, port->dev->dev_addr);
>  	}
> +
> +	/* When HSR node is used as RedBox - the frame received from HSR ring
> +	 * requires source MAC address (SA) replacement to one which can be
> +	 * recognized by SAN devices (otherwise, frames are dropped by switch)
> +	 */
> +	if (port->type == HSR_PT_INTERLINK)
> +		memcpy(&eth_hdr(skb)->h_source, port->hsr->macaddress_redbox,
> +		       ETH_ALEN);
why not ether_addr_copy here too ?

