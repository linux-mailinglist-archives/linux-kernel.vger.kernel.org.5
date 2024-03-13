Return-Path: <linux-kernel+bounces-101327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2089987A592
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603E2B22107
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4939867;
	Wed, 13 Mar 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qwx0mRY4"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86E39860;
	Wed, 13 Mar 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324555; cv=none; b=tBK+fOMm5Uaoz+PM8pAO5GwhyUK5P2nj7pxSw8p1f6UEFkqpTEyXr14yojFNcs4EgqvyibbXs44zCSMt9N/TV/fp2WRcBiCqdlJ7n9p5E1cLww9l1l0jTnm2EMt8L9je1TZAukTgraCLZpsqWFw8Mg1ckzqH9nnczsPFBECT4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324555; c=relaxed/simple;
	bh=fWGLhnxLEh7eGyNf4dii+sqAe5pXpPJ9tpcuMouGdHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq9XIrJU30oLPkxgMFH4ruGfb0ppsCvtASm00Dn0fRG8GSmIhXNhmijq9TS04EZmyKlZRhyAsAl7qERinbpaTWtbJ2b5ewOZwVPI+7dSi2eFYc/cde3kJvX8d/69AVCOq4Qru0iLaRZ2kWlwHz418/bi3jFRqi1bKx25iLOje4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qwx0mRY4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dqscFof3UIk2f9tQdsmkjOVmktSh5/Fa3QHjZqZqyQQ=; b=Qwx0mRY4Q4QHwU75DoBroYRY8q
	FFLCzsbtgdqoG2GoFm/PbyH3Aln5E+hgpBN9cgAGb39bcabXs7J5s6EMJsitA6hoHC7tC7pu1YAyB
	geD/7sVzA9qXD/MV3lHiHuNJVY4aa5ziK69BPhnPqfo4f6BRNe/HOKpDUrLnsKbdcGf0/tuaLXvYl
	vpIV/Id/Y1CHel5mzYm69GJrHkODL0iQ4URqFUWdLPWStVbIyER+OUwzBrxpsCPI+uvynp15Ogv9W
	at6YrOyQxED8ZiPO5pp9XZF+/QcjsI1QDPwyeUZ/Gdh8s1ApS4pEvkqnR60Y4DW+22GAoAME911Gl
	+Vaoi/Ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33378)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkLXn-0007X4-1k;
	Wed, 13 Mar 2024 10:09:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkLXk-0004Pg-F8; Wed, 13 Mar 2024 10:09:04 +0000
Date: Wed, 13 Mar 2024 10:09:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH clk] clk: clkdev: add error messages for name exceeding
 maximum length
Message-ID: <ZfF7QE0Jqok2uKrL@shell.armlinux.org.uk>
References: <20240313064252.50233-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313064252.50233-1-duanqiangwen@net-swift.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 02:42:52PM +0800, Duanqiang Wen wrote:
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index ee37d0be6877..620dc1e80b48 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -158,6 +158,9 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
>  	va_list ap)
>  {
>  	struct clk_lookup_alloc *cla;
> +	struct device *dev;
> +
> +	dev = clk_hw_get_dev(hw);

Sorry, but no, clkdev should have minimal dependencies on CCF (it was
designed to be completely independent). I'd prefer not to add this.
Just print the formatted dev_fmt+ap and the con_id when reporting
errors.

>  
>  	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
>  	if (!cla)
> @@ -165,11 +168,19 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
>  
>  	cla->cl.clk_hw = hw;
>  	if (con_id) {
> +		if (strlen(dev_fmt) >= MAX_CON_ID) {

This is wrong (uses dev_fmt not con_id). Also, use sizeof(cla->con_id)
to test against.

> +			pr_err("%s:con_id string cannot be greater than 16 characters\n", dev_fmt);

Cleanup?

> +			return NULL;
> +		}
>  		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
>  		cla->cl.con_id = cla->con_id;
>  	}
>  
>  	if (dev_fmt) {
> +		if (strlen(dev_fmt) >= MAX_DEV_ID) {

This is also wrong. The length of the format string does not give any
information on how long the resulting string actually is.

> +			pr_err("%s:dev_id string cannot be greater than 20 characters\n", dev_fmt);

Cleanup?

> +			return NULL;
> +		}
>  		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);

Using vsnprintf() here and checking whether the return value is larger
than sizeof(cla->dev_id) would be better.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

