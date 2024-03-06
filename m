Return-Path: <linux-kernel+bounces-94513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D08740E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9904B1C219CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39938140E42;
	Wed,  6 Mar 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hHBK/PQJ";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vsuUZWPA"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67013BAF4;
	Wed,  6 Mar 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754890; cv=none; b=tKjk5+aNBnFjGe/IRBTpYMR8U12zLHolQVyOkKYBXwjVPyJdrXn1Kw9GhVZie9YDqmekYZV2j6RFqn+LZIvystnLr9LxLW/dryDlg9S/6wk+q7eHprOov8Wf5abCGjFGYs59hl8OtfZM530Oo/mogy30vHHJ/0BWV1XMbULBJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754890; c=relaxed/simple;
	bh=xI7TPdfaJh9c0jfLQMhlGytKcdh3yS9fkAl7t5GvxjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQLjUGgg/Wdf8uZkN6mza3KL9FQGO7sooWn+4mSVa0lbF1MdaMpUVUK8MpV2AjKTy3KLXyLmrSvjqzuyep5YbI4lKBvE6Dr418lINr8IifsohQ6MVF0oqvgpirdLJvwlQZPFPlGzY00EVT6XGx2Zkq5p/PqhyJKSAGMUjiwLgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hHBK/PQJ; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vsuUZWPA; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 0720CC01A; Wed,  6 Mar 2024 20:54:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709754886; bh=fo5mwjEgwLizlp9QJ9Xrr1GYd1WkhnXCPfwsqkjnlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHBK/PQJ6plFEoNZ07LNp3KjQr3kjGSc+l87Sre6iLewUg7aC25NZ0elHEX7Z1TY8
	 NQxteBQu8YqMByOFi0h/9cJa9TQmkBm2q3zF0koSBE7NexKJki1n2OFeSv8v4G1cyH
	 yWZWxEa4Wcm+lVV9cPPJDeZSVUSycMJP9T3bmsxOC2dTyTBmrTjAYSIUpDQWZq+Aeh
	 Rx3VZmiNx9kz2noPnFi5nKNFTHE/y52U9/rA+pWCkt3qhEoXGY6sPXcO6JIPRo0kMv
	 jPRt+9wYAypYuwmJqUai627isiLz2MVzaXm0OLXnKZFC9M16AIA3erMMZDU3EnDfOF
	 Iln8cAiwEbzOQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C86ADC009;
	Wed,  6 Mar 2024 20:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709754885; bh=fo5mwjEgwLizlp9QJ9Xrr1GYd1WkhnXCPfwsqkjnlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vsuUZWPACzLRO5Ug0FK4IbtulE0XQDChom7n/QBCf7YU4t6eXiGtillaPfH7aZenK
	 93IWiVE5vunHl9hK1StXbTA+Od4LirUoFek+uPuRmQRm7nNs3S/zozag5+uQJhdJGy
	 yaCKdtsdYJzk+dG49TU/JlUcdR05KJBaY8S8YTXauD2madD/eV+HcShUsFECWHnajB
	 4QVaqsZ88yk9/VplhZ38QWoRvtRwO7LTuJBVOk/+uuLEHJEE0ojVEn8eYQzJDNf7uR
	 0myW0GcwPO47DiqgbMvTWVsqGPfxFRFbu6qz6174H7Bd60yLECPfSw8MxDTcG3F3m3
	 kUXM6FX3jL2BQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b9697cf9;
	Wed, 6 Mar 2024 19:54:36 +0000 (UTC)
Date: Thu, 7 Mar 2024 04:54:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 2/3] net/9p/usbg: Add new usb gadget function transport
Message-ID: <ZejJ7W_yUMBtqi70@codewreck.org>
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
 <20240116-ml-topic-u9p-v3-2-c62a36eccda1@pengutronix.de>
 <915890fa-e763-470a-a82b-eda97c47c0c8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915890fa-e763-470a-a82b-eda97c47c0c8@collabora.com>

Andrzej Pietrasiewicz wrote on Wed, Mar 06, 2024 at 04:18:54PM +0100:
> Reading the earlier discussions on v1 and v2 I was somehow under the impression
> that what you submitted here does not contain configfs support.
> 
> But once I started reading the code I realized it does.
> 
> It worked for me, both as a legacy gadget and when composed with configfs.
> 
> I noticed that when you stop the forwarder at the host side when 9pfs remains
> mounted at the gadget side, umount hangs at the gadget side until the forwarder
> is restarted. I know that once the host-side software dies, not much can be
> done, however, unmounting a dead filesystem seems a reasonable thing to do
> and the way usb9pfs worked for me it is not possible to unmount in this
> situation. Any ideas on improving this?

If the trans_usbg code can detect the host device is gone it should mark
client->status as Disconnected then wake up all pending requests
(something like p9_conn_cancel in trans_fd.c)

Sorry I haven't found time to test/review either; I'd still be
interested in running this in qemu for non-reg over using a real device
so need to spend a few minutes figuring out the exact command line
required.. I'll try to find some time this weekend

-- 
Dominique

