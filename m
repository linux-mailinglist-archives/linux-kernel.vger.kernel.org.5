Return-Path: <linux-kernel+bounces-156862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B58B0962
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B68A289B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F715B54E;
	Wed, 24 Apr 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T+pZxPMT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F115ADB9;
	Wed, 24 Apr 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961509; cv=none; b=D+WaFE+t6VVyUbHUMtwmfQr4roEKlYlmUBkFE/6DuCUXkxJ8CXXQWrcMLsxUcs4UH1cvNm+6LYu9HLiKIL+8kd+7QSvTteQxp5SwKIW0MlWQ8v1Ko8ijtyfyqK9PrJAGFRpAm4sNRpUwKXwEd0ye06rRvtmbVVxNxOy+pfdEDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961509; c=relaxed/simple;
	bh=7N9zaq+fh6hkDAZtKbiYdRGTKyy5REZxp/vM+zQ6Oog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGv7dXKfLC+IcX4hn3A1GRVLk2SpOOucnTzx8HLKutaO7TmZa4FB7NJqp60CBIGRizHb0VE+AbwGENcjd3XLAjJxEj9DLlJfxr23kGCV8M84ITww1nswY5/n6MMIXp7A1hU+SxrR4ylO+cnX4iGbXf9gNqGj517fq0+V1WbtTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T+pZxPMT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m8alY3fa2sJa6yVCEcEPZwb9co2W5cHvOIKKJ6aN1ME=; b=T+pZxPMT6xPGxZuB/lBXI7ALq4
	9F8g+e+ZHRbwpmeSfjiyXhuusemOcPJm9Qq33awPEEz4SnbT0zTPi0egvGjBotn9vIHbkDQJytqNl
	NOZ6/vy8Llk60eeQFRCZuBdS5ITH61f5sl/XX68XjSQ6oyPy+ECXITtErt5ii+MBABX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzbg6-00DoNw-JI; Wed, 24 Apr 2024 14:24:46 +0200
Date: Wed, 24 Apr 2024 14:24:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: Ma Ke <make_ruc2021@163.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jtornosm@redhat.com" <jtornosm@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: Add check for
 usbnet_get_endpoints()
Message-ID: <fb62c1d9-02ed-4b39-9fcc-f7f69b5fc024@lunn.ch>
References: <20240424065634.1870027-1-make_ruc2021@163.com>
 <PH0PR18MB44743F344613BBD8D3E8398FDE102@PH0PR18MB4474.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB44743F344613BBD8D3E8398FDE102@PH0PR18MB4474.namprd18.prod.outlook.com>

> Nit: please include  patch change log, below link required info
> https://docs.kernel.org/process/submitting-patches.html

Also, please wait at least 24 hours before submitting new versions,
even when the previous version is completely broken and does not
compile:

https://patchwork.kernel.org/project/netdevbpf/patch/20240424011454.1554088-1-make_ruc2021@163.com/

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

