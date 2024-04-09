Return-Path: <linux-kernel+bounces-137056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DD89DBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7176BB27ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCD130A6C;
	Tue,  9 Apr 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BI2WNaYJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2E12F37B;
	Tue,  9 Apr 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671494; cv=none; b=NGS0KCyyhthAnM+K1BILPHgifOBJaLGFfqZbxFsgfIdT8OeYLYCZ3WNLHjYFC7PLawmyYf0z3xvk686J+xR4ZWzLcuz5lVjyxyH1l9Tbkaa0YMqg6WEJ+uhBJ3JXCTHGgR7EKCdLrdLSfN+UVHCqA/U5YC9HJyWCwqP+e+f4oUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671494; c=relaxed/simple;
	bh=ZfJgQ+0Djfvx+LbeItuW7wp7/1+oMaOmn6GRrZla1GM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7EB/7vwM2hLzA9VannlojpTyJ4xr6awEtKmki4yfa5S7hOq++qf3+OkazUBRKBS9gev7YM4Bua3bwIu1JuSvK9/cTzp1xDOte5yBNChQ5rQqh/0n3pJyYzJ/vATzKG79UAdUwRin0iBiGccjSBewGj/p/KAyV+Qi2nSC71GskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BI2WNaYJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712671492; x=1744207492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfJgQ+0Djfvx+LbeItuW7wp7/1+oMaOmn6GRrZla1GM=;
  b=BI2WNaYJ+g1D7vfcQNkIcR4e1+VXAlsVgdoqYyHraXkCXtoyfLvLYVGI
   iS6vOK379BeQKu7pg3NCr3/gowCQqgoMkD2IyHRdPqKDLiS7/MYEY2IAh
   uf7q5Y0nLRXiVBkaNqgNZ92hy9ewCYUSolW7kwV0phMI5xfALWGyvm/rQ
   l8AtoryYRR/oWOVloaDtk8aUJ84aq7B2tm8MgOQnV73/6QX/jxEoqomz/
   AC2obpFYTb6vnwkIEav68YZxPso1qM0ZHOz3gAO0BbqKjne9DOi0kTz1A
   y+CWsGo5MOYVCKmNm5TRlsbdDypk+Frb/vPmUW+es/EOJy18p3XD5LtvD
   A==;
X-CSE-ConnectionGUID: VSAYxGtOTA60prrClmzs5Q==
X-CSE-MsgGUID: VOiVzVOcTsO5ka6CTTiuKg==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="20143798"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 07:04:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 07:03:54 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Apr 2024 07:03:50 -0700
Date: Tue, 9 Apr 2024 14:03:50 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, "Arun
 Ramadoss" <arun.ramadoss@microchip.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, David Ahern <dsahern@kernel.org>, "Simon
 Horman" <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v5 1/9] net: dsa: add support for DCB get/set
 apptrust configuration
Message-ID: <20240409140350.vgi52z75qygbwgid@DEN-DL-M70577>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
 <20240409081851.3530641-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409081851.3530641-2-o.rempel@pengutronix.de>

Hi Oleksij

> +static int __maybe_unused
> +dsa_user_dcbnl_set_apptrust(struct net_device *dev, u8 *sel, int nsel)
> +{
> +       struct dsa_port *dp = dsa_user_to_port(dev);
> +       struct dsa_switch *ds = dp->ds;
> +       int port = dp->index;
> +

This should be !ds->ops->port_set_apptrust, right :-)

> +       if (!ds->ops->port_get_apptrust)
> +               return -EOPNOTSUPP;
> +
> +       return ds->ops->port_set_apptrust(ds, port, sel, nsel);
> +}

