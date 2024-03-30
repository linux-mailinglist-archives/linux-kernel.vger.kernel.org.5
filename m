Return-Path: <linux-kernel+bounces-125807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B39892C6E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFE1F22202
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEF41C71;
	Sat, 30 Mar 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BAnkdZ4A"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE733BB3D;
	Sat, 30 Mar 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823330; cv=none; b=pkt9/JQFKD5yT/eWedL3QZ9c+uqVAZqGYuNCcBB49ddKQkGuWK3hnkqepaDMW57ccoh1yCEzSWmnMnJS4nho1515dWI8hFZ2qie8bfPXjGazjG+j0ldb94e738hQVfIlT6znKKQOzJUC6eshf8680VePV4B4tu1cYk93V9G3Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823330; c=relaxed/simple;
	bh=O/UyUM9ICeUerTlWR6Rtm1KUdN7PcCQaxk9upPhEBE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2g0unnO5O3FkBmdV8tpVpxy5OtrjWnb9UBbMKAon8l9GDs3xMlUBWShfaCQhW7aC2hcM6DOkA5VgkRadHobKSxcrgI8ggcB8YbMFcdmAin9pJPfbI/7xjAUIgmwyOgxx/fp8LrGIlVP0l5WXZB8wUqZC3uV2DeMEp2FqXUfWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BAnkdZ4A; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eOnCxHAyWMBBmrA31QsaFBeo10V11qo0IeZKOpN/ZkM=; b=BAnkdZ4AFLsdBYGg9hDj/OEdIB
	HObTuni4MRaU0PoKGPwlAtjY0tYlpgMLsFmzRL9YBoCKEH4/UCV1r6pmG2mzAY1aIiAV9Q+foy27C
	boy059PfyozEJxNJqHg3sgu4C5/93MuWxmhCB1fjhjGh1VNCjAMBOant8uIDY71Hko6LEOMcxLo2P
	KbP1AdeFuiUfyH+2LBbzXz8ISCUCipZd1annA3RPugiN3Ip/gLoLS9PLceY2K/4+VJUekek/WeVM4
	UyW2Z62ifqdIt0MXXFnB86WFCTZCnunl8WR9zrxOb2rvUqRdZauSKtpT8SswQTMG0Q+DAMvpzZWq3
	7iet8kkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rqdR9-00036h-00;
	Sat, 30 Mar 2024 18:28:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rqdR4-0003rW-Hn; Sat, 30 Mar 2024 18:28:10 +0000
Date: Sat, 30 Mar 2024 18:28:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: Julien Panis <jpanis@baylibre.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH net-next v5 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Message-ID: <ZghZur10+3WvZnDu@shell.armlinux.org.uk>
References: <20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v5-1-bc1739170bc6@baylibre.com>
 <SJ2PR18MB5635B9F20BB6CE1CC945F3B2A23B2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR18MB5635B9F20BB6CE1CC945F3B2A23B2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 28, 2024 at 12:06:56PM +0000, Naveen Mamindlapalli wrote:
> > diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-
> > cppi-desc-pool.c
> > index 05cc7aab1ec8..fe8203c05731 100644
> > --- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
> > +++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
> > @@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct
> > k3_cppi_desc_pool *pool)  }  EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
> > 
> > +size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool) {
> > +	return pool->desc_size;
> 
> Don't you need to add NULL check on pool ptr since this function is exported?

What bearing does exporting a function have on whether it should check
for NULL?

Given that this function returns size_t, it can't return an error
number. So what value would it return if "pool" were NULL? It can
only return a positive integer or zero.

Also, the argument should be const as the function doesn't modify the
contents of "pool".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

