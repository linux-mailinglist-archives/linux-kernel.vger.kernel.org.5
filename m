Return-Path: <linux-kernel+bounces-157846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86D8B173F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1B1F22EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D5157473;
	Wed, 24 Apr 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FuLPnotF"
Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D313A3E6;
	Wed, 24 Apr 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001813; cv=pass; b=oV64p7uV21259rlzV3IaLb9Thfmdj/PSA4qk5p4B7OmuTL9r/+dk0v5nPk6HMODEcWYHlBEOhoWoyBOWH2HZIj2Y1bmU2j2zDXx4WWjbL2Yu/IPHRn7XsurxCin3eIDpEJcq1rqnE4jLeNmDF3nS+dtd0E2yqpELrAwHT2+m7V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001813; c=relaxed/simple;
	bh=y4/FDZgTiB7uZt+GrJ9Q84C8HZBCN12BEcR92P/kNjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp9wnCjkKN0tjQ6/rpG20cWvh1R8QLW/itfWRuG/ja68owoBm5jd5iLA1uvpU57zu5QGopBlxZU07osYz2dGTYkgp4e+iHmvG3ATURsrKvdDzJLWe7sfMZisQt+iYhCWGsmxjXlceHsbZvW1csmThQ66tC20PC29tW0vE7hhwJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FuLPnotF; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 94AD340929;
	Wed, 24 Apr 2024 23:11:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0CF724054A;
	Wed, 24 Apr 2024 23:11:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1714000306; a=rsa-sha256;
	cv=none;
	b=SiZT6pBBOImRsA7ydImmpPrikQ9KDKMZGK7IxCYd1dEVBMlFEaB4FpGlBy0+D6QZvsWZOT
	wVgMs2jigkMtNbAWXoZx9MoYyMmon6Hczo3t2TTl9HWPD3w7LY0kFheSI7tTdwu/AMr2r9
	SqV+3+XF7sH7K/hu5LRcKn0M540oy+nnmQO65J2oO2cRUnJCHi5vlv1O0PwZ6HSTauFZSL
	kVjuQZbtNwcf4M34U1C06wNOkX1Wiiz84c97XIiS1p+robK/Nn55yxdBins1PGkR57MkZX
	s5tWHzgtlfuYE7qMuOYbq2n4OWKrKjV6V8Ghb9e9vwEYAUef6du7FpbRR3uLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1714000306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y4/FDZgTiB7uZt+GrJ9Q84C8HZBCN12BEcR92P/kNjA=;
	b=3lAkrRL3I0TuHATFXkFiJQeqiI0p3NE5y//jBkBlwU6FNdtv3Y3I5MKHXdOwKy/4PQMLhk
	MEAj2kp+UUZ7VjJQiq8su9a0WwUz6ktIMWShSQlJ2sCTY3vYSQvNto68VjNAmjHdzCNazA
	Bww+rY/dLisDZS0XW6Mj3GP5pPcDFnlUbFxrxbsF7fbztU+ybJqyBkJsZkmK/CSlvXwCyU
	1YJaC9EqpCFUXB6JNcFj89zMsCvlEoIKmfiFoNSnnt/neq7Iz+Lka9gG8rgSJvn0kVadEO
	vjpKqdPNFrrPE5TQ1fcnBwaY4LWZBKtcLjo9HTq5HEF48H/dT9XXxgBLHL3sGQ==
ARC-Authentication-Results: i=1;
	rspamd-6f55c6f9dc-cds9h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Troubled: 4c82c1c54eb796ed_1714000306362_4070382946
X-MC-Loop-Signature: 1714000306362:3215447623
X-MC-Ingress-Time: 1714000306362
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.153.252 (trex/6.9.2);
	Wed, 24 Apr 2024 23:11:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4VPvrK2ZK6z8x;
	Wed, 24 Apr 2024 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1714000305;
	bh=y4/FDZgTiB7uZt+GrJ9Q84C8HZBCN12BEcR92P/kNjA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FuLPnotFRpjsr7YkpzdNz3BQ4FwnYher2PgVr1DLtEKGIh7tHXkEeGiUGnIYA+wy/
	 4fc5DtHLjld6qAJgNKHQFOqO7tlEYNQRis5c1s/MxJEOQ6o1PO1H8NKglRUjoNkjGJ
	 o5E2AfGPZlexLPcijqJauOUud1PEWKK7PTZE+6oetOY2+mMjmecwAfF8QWpb1tar45
	 x3lKipFeeTdPGgoQKaBcOdXRKH0GdOM79UdbYcjbiJ/4q2sPDE/fkY2Rk3XncWqeba
	 2E99aAc7u/oSeXJYOcAB6Rnm2PbXWJI0ilyf4X/AoU/IGeGsNkMDqTsINZfYelRrRY
	 D/7MBkxE0BW+w==
Date: Wed, 24 Apr 2024 16:11:42 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Robert Richter <rrichter@amd.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: Fix use of phys_to_target_node() for x86
Message-ID: <20240424231142.rytjmxfassu44vln@offworld>
References: <20240424154756.2152614-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240424154756.2152614-1-rrichter@amd.com>
User-Agent: NeoMutt/20220429

On Wed, 24 Apr 2024, Robert Richter wrote:

>The CXL driver uses both functions phys_to_target_node() and
>memory_add_physaddr_to_nid(). The x86 architecture relies on the
>NUMA_KEEP_MEMINFO kernel option enabled for both functions to work
>correct. Update Kconfig to make sure the option is always enabled for
>the driver.
>
>Suggested-by: Dan Williams <dan.j.williams@intel.com>
>Link: http://lore.kernel.org/r/65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

