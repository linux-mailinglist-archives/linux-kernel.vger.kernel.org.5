Return-Path: <linux-kernel+bounces-27345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5D82EE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C14D1F23BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B631B957;
	Tue, 16 Jan 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UIG8OtDP";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0EJVCbmx"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6C1B940;
	Tue, 16 Jan 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 01564C01F; Tue, 16 Jan 2024 12:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705405545; bh=llWEJift9hG+PhTtYMT2BAlP7/BtTae1YaCfwTT4lSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIG8OtDPdO34qke2DxeKfNbivqe4eK3afyYrqIanitu/NK3qLhzZCqX8IC91suI2j
	 LHe/0LHNK7hHBXSp9C5vZxJlkXUMyG9wzG0c2hpP1iSzUq4d8v9yZAX4Pdrh3hsQrQ
	 bBgHbYLIltOSSoEjb/mK9XYZ7AuX1ppezJUVLqX/5uzyNAzclhr1gPqczu0KL/iq47
	 4+j0kJxV4FhbcQHum/NqVhLOpKKgVq8431z7SZgpciGhobuhwXCYi7gHagiyJRNb5u
	 AAnRx+EB0j865+5h9uQcR15kpy8xrAkHD7T/3pOqzNu6H4VOai/cWW7s2avgPhr4qi
	 8THsD3GH10+GA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 0C184C009;
	Tue, 16 Jan 2024 12:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705405544; bh=llWEJift9hG+PhTtYMT2BAlP7/BtTae1YaCfwTT4lSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0EJVCbmxJmwC5o1TbiRdk9xHCyiMY3STNGUCu4xeo0TRrWdaL0L1lZEb1QyL5Qz1M
	 bGe8mcMaHJSXUh4Mluor0TqYJkqW7xrKZGCpn3K/K+AefamrFh+fkiPbVCsUn74yAz
	 X00SejH8nWOV+qeoPfTrCQvvZbAfBLdtGMjXXV+PuFyp39u7i/nXvSbBAWqmflP5yl
	 cFH5rUo6E+utAaA/l2/wBCreoSZMZyPh6xvWPyQwISrj/Ep9K/zTJL0j9ccJ1v1+eb
	 71EDh3AFsajp+SRMuykPpc+ikE0NJqbhopumdjTdcnbMGOjoqmwAl+MXye/NU8rpXE
	 tP6HH498btVLg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8e92cd28;
	Tue, 16 Jan 2024 11:45:36 +0000 (UTC)
Date: Tue, 16 Jan 2024 20:45:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/3] usb: gadget: 9pfs transport
Message-ID: <ZaZsUQUhSlMPLJg0@codewreck.org>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>

Michael Grzeschik wrote on Tue, Jan 16, 2024 at 02:49:40AM +0100:
> This series is adding support to mount 9pfs exported filesystems via the
> usb gadget interface. It also includes tools and descriptions on how to
> translate an tcp 9pfs and use it via the usb interface.

So I didn't have time to look at everything through, just want to make
sure, this series allows sharing data from an usb gadget (e.g. some
device with storage) over 9p as an alternative to things like MTP ?

I don't quite understand what the forwarder and diod have to do with
this; you're emulating a fake usb device with the forwarder that just
transmits requests to diod as backend implementation?
But 'usb.core.find(idVendor=0x1D6B, idProduct=0x0109)' looks like it's
searching for a real device not creating one, so that doesn't seem to
match up...

If you have any background information on where you're coming from and
where this is headed it'd be great to include in the cover letter.


While I had a quick look I'll spare you a second mail for the first
patch:
Michael Grzeschik wrote on Tue, Jan 16, 2024 at 02:49:41AM +0100: 
> +static struct p9_trans_module p9_usbg_trans = {
> +     .name = "usbg",
> +     .create = p9_usbg_create,
> +     .close = p9_usbg_close,
> +     .request = p9_usbg_request,
> +     .cancel = p9_usbg_cancel,
> +     .owner = THIS_MODULE,
> +};

This is missing a MODULE_ALIAS_9P("usbg") if you want the module to
auto-load on `mount -t trans=usbg` -- assuming this can build as a
module.
                     
I'm also a bit worried that this net/9p-centric code is now also split
with drivers/usb/gadget/function/f_9pfs.c and I'll bet you the build
will break once in a while when we update global 9p client.c or
similar -- I'd be more comfortable having a net/9p/trans_usbg.c or
equivalent if possible.
Is there a reason this has to be in the usb gadget tree?
(Well, I assume from the usb gadget point of view, it's reasonable to
similarily prefer this code to stay close to drivers/usb/gadget..)


Thanks,
-- 
Dominique Martinet | Asmadeus

