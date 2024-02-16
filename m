Return-Path: <linux-kernel+bounces-68635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F429857D94
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E861F267ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87D12A158;
	Fri, 16 Feb 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsjWmn3I"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86171292C0;
	Fri, 16 Feb 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089684; cv=none; b=GzUg5cHxuVE3ID/DAr/20OXvvFb8GEG45HxcrQhr6Q2Na2sRegbrgcVvF8vCm/O1tfFWOIMQij6DXdzmlAOSJz8zmDp4TVJYtSbfYcHvh2WDHb9Ewv07cTz5mWgy+3k0mZe8IFgdk6CWKSuFCYF10fthaBWjya9clJjAMW24moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089684; c=relaxed/simple;
	bh=x/3vrG9nda17m8L+3fb++8h+gBsjD4a7VisFEsFYkSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afGbiwCzpVGTzXL9O4jisGykX3/Hdno23Of1+5Gi4+t+3jiK8qzC38+F79PlIIctmXaCgB2VWa6sOHmyClMD/1JHKdOp13t1NtjN7CnuLWO3G7zOMX2qCrBfJIAMUConQt4mcX4JFofD9fbdkDfD9jbwkfeENr0A6ntFNs5YFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsjWmn3I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so115819066b.3;
        Fri, 16 Feb 2024 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708089681; x=1708694481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWSv/HmhGBg0kRCfTQuNOynwzv3tVN0eXsPreJCp1X4=;
        b=LsjWmn3I6m9ucKPFCpuBOUam5zuQLv6es3v4aHIxOzhY0+Oy8hB2zrkB3Za8qdafyW
         6OHqBBWqmB9CB0VAjrizBFURfoseLm37fpA+AtCJJo7MvPJf3HlOvQ6+lm2oy5xixXxj
         UoVCzedIdu2bvz9ix+E5SXlpaNQGfln8bWximEV3H5ZfD88XJAu9Z7qKV5S3ALCkLeSq
         k7mF4e/GowjtqzvPEV/eAgJ9BQpLdZQtX1FRhk5/2jIzR9NHjDq5PItOZtVJ4SKgmix7
         PtirfGuFYhLgZclodmxw4uxSoigsSNCwP3akE489yU3M2MywGANA47e52X6BrWMVQCyq
         mHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089681; x=1708694481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWSv/HmhGBg0kRCfTQuNOynwzv3tVN0eXsPreJCp1X4=;
        b=jPNNGDQD6m3BZYPfWE73HA7CLfF3WqTGYF6nxrsC7TPk0+eSgPRz4mzXlL5rgH4ssR
         IRxRQ+ZWnkJ5rY514dSrKj1DrNDzTYTckPq7/hwbdXBfrWrGPxUHlwhHmMJkgoAKYDW1
         Mzb7wVcKJoNtgY385RkewDkRJJdFe/Gb112ytpT4XKmP5Wbm8fy/WhEqaj8jd8bT/Bqo
         OxpLpwR7F14knxG3whQHT7B+D1dEDbmVNBqYByoOhFNQcD5sBRtLYxzXnMR709uHW5Bl
         n2SKDX/CG4uqfbewZx2C9d9qBPketDnmdXLOvopqgzA9t0g/+e8CCZQyEWpUMPCDeIlZ
         DAhw==
X-Forwarded-Encrypted: i=1; AJvYcCUnfQPcsXdBOoBVxGPyhVHn9oInaU+gjcGfHjgjw4MS9+ZdeB7aZbanRnBcik28shPQPrP16+azLmGt1jw0IAKV0I3/dPsoln/fLrzM
X-Gm-Message-State: AOJu0Yw45IDxAn7zou80F0M9z7jGblZpZmOCI7YlA7pjqMSugAi46NnY
	tSfxY77VTeyYdbUtuVzm6AXmKYYEKH93Ythsir8zzH/mmXKNoam3
X-Google-Smtp-Source: AGHT+IHS6t0+yz0DNbmIYBN7/I+Mse00vqFH2vC3TH0Ujs7kCiCWjyYbatSvL8XkSi1pAgZwA8n6sA==
X-Received: by 2002:a17:907:7658:b0:a3d:ec2c:676b with SMTP id kj24-20020a170907765800b00a3dec2c676bmr891599ejc.65.1708089680738;
        Fri, 16 Feb 2024 05:21:20 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709065f8900b00a389490cb21sm1536268eju.216.2024.02.16.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:21:20 -0800 (PST)
Date: Fri, 16 Feb 2024 15:21:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/15] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240216132117.ajxg3vyds4ffpbaj@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-8-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:20PM +0100, Pawel Dembicki wrote:
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool store_untagged  = false;
> +	bool store_pvid = false;
> +	u16 vlan_no, vlan_untagged;
> +
> +	/* The swap processed bellow is required because vsc73xx is using tag8021q.
> +	 * When vlan_filtering is disabled, tag8021q use pvid/untagged vlans for
> +	 * port recognition. The values configured for vlans < 3072 are stored
> +	 * in storage table. When vlan_filtering is enabled, we need to restore
> +	 * pvid/untagged from storage and keep values used for tag8021q.
> +	 */
> +
> +	if (vlan_filtering) {
> +		/* Use VLAN_N_VID to count all vlans */
> +		u16 num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, VLAN_N_VID);
> +
> +		port_vlan_conf = (num_untagged > 1) ?
> +				 VSC73XX_VLAN_FILTER_UNTAG_ALL : VSC73XX_VLAN_FILTER;
> +
> +		vlan_untagged = vsc73xx_find_first_vlan_untagged(vsc, port);
> +		if (vlan_no < VLAN_N_VID) {

One more that I've missed. There's a bug here. You don't mean "vlan_no"
(which at this stage is uninitialized), but "vlan_untagged".

> +			store_untagged  = vsc73xx_port_get_untagged(vsc, port, &vlan_no, false);
> +			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
> +						     vlan_untagged < VLAN_N_VID, false);
> +			vsc->untagged_storage[port] = store_untagged ? vlan_no : VLAN_N_VID;
> +		}
> +	} else {
> +		vsc73xx_vlan_change_untagged(vsc, port, vsc->untagged_storage[port],
> +					     vsc->untagged_storage[port] < VLAN_N_VID, false);
> +	}
> +
> +	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vlan_no, false);
> +	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
> +				 vsc->pvid_storage[port] < VLAN_N_VID, false);
> +	vsc->pvid_storage[port] = store_pvid ? vlan_no : VLAN_N_VID;
> +
> +	return 0;
> +}

