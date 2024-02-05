Return-Path: <linux-kernel+bounces-52071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582778493BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FD8B21CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570010A1E;
	Mon,  5 Feb 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GMS03Sv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJ5PHC0J"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62610A11
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113625; cv=none; b=RbXEdg209CDXT2pFG9aV7TaoUQCRkwph/iEIcE8NLlsws7uTdSMHpGAUd2Vr8hWXYYgU26JtAY/OyaEMsOtQmo0JJTLhdG51JpXjsHSTt6/lSaYMPuwsvzjfJo4bV+pxNUjLSqeHb9tpWy6TEs7NDUZ74uQaOmHtn1XeuH37EzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113625; c=relaxed/simple;
	bh=mat6tvfN2VYWHCTyPzL00RUBKgF4GODp9nO622GkJwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzBLO0ptndrYbFGVZ5iE/XbojE2D61obbNOHsqqy8rhqFO628fg2b+6ySsQBny3SzLoE1zuo6d9k3iLFHhZABXebrz4FntqYMJAgdOiXFtdsW8GTeReMmVV6dDkmtrQPUBGbPl//SvIcUadGi+na02loDckT6Pehlyqt6asmniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GMS03Sv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJ5PHC0J; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B13435C0111;
	Mon,  5 Feb 2024 01:13:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Feb 2024 01:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1707113622; x=
	1707200022; bh=l0YLavRaGfdAe61ZNAx9jIh3U3DFqLWnxZLRX5o/LIY=; b=G
	MS03Sv5fcgCGQVMaiYQbEOy7CQQOdbpyc1XHJ41PCoxIEmfOFRoU730TrC7kFvs3
	vB2m/0XC2Tih8HbNqwuYOix9I4Z+mO/tIvPl+PawKaT8GX46drin+JCmv8bUJYAl
	aFj8/e66beEAhX9clhpdzjo6UqXbkcN1HiK5jGJXgjjXK1YP0LmnaWZGNI7SroXp
	niNuNPXB14DGLhdXfh3LqEfbp2GF/+W3n0BBUkHaQYXTWu75G7S/cn5laoneFA1K
	Nqa/sVF9WC+IsAVfYRmwystU5RVpBgBOtNfZkNYFX2wptaRAGTbnOvlvQmaEN69H
	25EII46XFQ7RJqQNsXJZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707113622; x=1707200022; bh=l0YLavRaGfdAe61ZNAx9jIh3U3DF
	qLWnxZLRX5o/LIY=; b=XJ5PHC0JpC+agL2FqdJMdA42FDAakwTZ3+iKA3OeZvpo
	nxl7gPggKICywLwmlBdwlAk4QWQTEJ5C4luaJ6lJVuKnV64mGPJCiVrYeamTMdDE
	E0fVSZEYsfj4y6ayaHlyVki/lh4dJ+PIiP3w8Gy65Zf0K7ep+6pgOBuq78cxP92u
	ErKH1g5qQw+VxKW7KEMut497pdObulp4jvmx3Ix9L7A2s5UdlRqooRnzBVFw18fZ
	+tXuLwjSQfnn6Ed4czrfNklSpIeBSg6lZpZzd9FT76xGrj7qHPTVK8SMfIi9JI5y
	CiHybxORnnYsf41+CoLHIL3qJPBO1NaWjwLlbLwnqA==
X-ME-Sender: <xms:lnzAZXcgn4fnb0oc2mYVRF5-R-Hos04D_ldb9u5F9ZX7TZPR6C51Zw>
    <xme:lnzAZdPYlR3D23jmAU28M8Sa90JxdeSYBS272TctLZ2IY34JkymGCRVVoN-GpDVKM
    XJoIjblzGEi97Wl3Wk>
X-ME-Received: <xmr:lnzAZQg8fw0NS04dvwJdZvRwg6j5vvhhwZatCSgcOusGD4OUgkZYyjcgcfup5rWlp59FmCkWbxns8SafsV8wNTrXNt81BvkdyOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:lnzAZY8rX5v0QegujmCh9IV1Ie7fgHvxipUkOCnh-_uYhVO48Lmz8g>
    <xmx:lnzAZTvKvw5wgaG_gDC5YIbQOL9q3yeUKmk6aQNBAsh-Naa3NPDHGA>
    <xmx:lnzAZXG5pLBWGV-7bP2yoIBUSd3-Q0ZngrmgEzgh-2xO28HGmP1X8A>
    <xmx:lnzAZc7DpaGJxwr10LGg6sKpme2ywk2ajV1Z_7ZjKUJ---CfWkW1Jg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 01:13:40 -0500 (EST)
Date: Mon, 5 Feb 2024 15:13:38 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firewire: core: fix build failure due to the caller of
 fw_csr_string()
Message-ID: <20240205061338.GA14407@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
References: <20240205060448.13881-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205060448.13881-1-o-takashi@sakamocchi.jp>

Hi,

On Mon, Feb 05, 2024 at 03:04:48PM +0900, Takashi Sakamoto wrote:
> A commit 47dc55181dcb ("firewire: core: search descriptor leaf just after
> vendor directory entry in root directory") for v6.8-rc3 and a commit
> 67a5a58c0443 ("firewire: Kill unnecessary buf check in
> device_attribute.show") for v6.9 bring build failure in for-next tree due
> to the change of the name of local variable.
> 
> This commit fixes it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240202111602.6f6e2c1a@canb.auug.org.au/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402022343.NkgsMITA-lkp@intel.com/
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
> index a802c6d4f4fd..c0976f6268d3 100644
> --- a/drivers/firewire/core-device.c
> +++ b/drivers/firewire/core-device.c
> @@ -366,7 +366,7 @@ static ssize_t show_text_leaf(struct device *dev,
>  			// in the root directory follows to the directory entry for vendor ID
>  			// instead of the immediate value for vendor ID.
>  			result = fw_csr_string(directories[i], CSR_DIRECTORY | attr->key, buf,
> -					       bufsize);
> +					       PAGE_SIZE - 1);
>  			if (result >= 0)
>  				ret = result;
>  		}
> -- 
> 2.40.1

I applied this immediately to fix linux-next integration.


Regards

Takashi Sakamoto

