Return-Path: <linux-kernel+bounces-90618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF787024E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D81E281C60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37C3DB91;
	Mon,  4 Mar 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KS8rKyFk";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DnWsJ5MP"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5E3D3B4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557789; cv=none; b=SvmIsx3U0svzA+onNn0VtMh1q+VUKt6a18Zdv6xIOatP+Gia3RjWnzP3c0lrUqb8Lnq3JPQX2w5VUE5xx5DRmSfcyiiU26f0GJjJvnTxhok8gOd/DZIlC32qLPZXEzC2Tmd5qgRxIYrCZ4t/M8PAIEqBdmMbikz52qzuSLgJ/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557789; c=relaxed/simple;
	bh=RR2NSLWwbVW4/3Rvbk2rFQ2Ov8AclpNWaKYE0SK02wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTe8h/qWeP1NH06FNqQD6d7Q0V2dyxc6WmX39DWmebYYz5q/717tMYZWh0i9iXWpBheGAdDidblyp+YFtiYluENJMQUPjB9c96xvIpGGYq6s+ZhUm6px+WSptCW3811mnOQ3ZlOsyZphshTwUGFXcXjOAwZy6fyDlPQoI15SGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=KS8rKyFk; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=DnWsJ5MP; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 8AEFCC021; Mon,  4 Mar 2024 14:09:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557786; bh=s0PGTHwpKytd1sDB5eULtOYAf6TaSfVYWh98iQ/exoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS8rKyFks8qka7PDdM4gKUeuoX/J15GeZC6j86CDoVYo319zNvyv4zJMi99gXneZI
	 rQ4VhyVKNDfpSk9ADuxjDO3tTyE5O1dBnSz/y3d1Md0H4aVMUyQsGiiIrebyOwE7P/
	 xnMxaNMjFJmzRcTtgqrG/drO2CZITGmrbXfD8XhxPWDQOXRNH29zSNGaU4bIVqggCr
	 pkb2wygNlPq0Ey0e8CcVwpaxVebStpt+h1X2r3hUmE5Khxkm5fyAS7L4sQV/mIXjZ3
	 E+qrAml0Pp2h17ZIZ7t9qLDEvOVDMFBL0d/Uuh2VZzu+Mmk1xGL1CAX9zlgKzRf166
	 XbrlAQzBOm19A==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 3F2A9C009;
	Mon,  4 Mar 2024 14:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557785; bh=s0PGTHwpKytd1sDB5eULtOYAf6TaSfVYWh98iQ/exoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnWsJ5MP/7YQwdz2XJKyblT78LnUgcyimuioPR7RDmw93HExCrRM8PySPELnvxrdt
	 CYuPioAOyAFZnzUCnIgrMopnIwsfbdTSHxeYqR9g5pYBIr0GHB1um2aJ8zaTmTvqxe
	 MT8RqRmOMnyTMCkQQ4e5F4HOT1DcvbyX3ugSn998ugqIHy0VSDDTQJUnUpvLFeqLrG
	 DPkWFJFbwdEQNVICUghXbswq3fehLxDLy+v4Z8mRxHCGJbEvw5cIAsUUPkzI5om0wf
	 ltl8wkIQ99AdAe2UThj0C2ycDYkbwZtzrNaDqAbuZeGz45fdNDER6bIPSM4A9aFaDG
	 dJw7ZB62oRLHw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id de9c5528;
	Mon, 4 Mar 2024 13:09:37 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:09:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com,
	syzbot+a83dc51a78f0f4cf20da@syzkaller.appspotmail.com,
	Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH] fs: 9p: avoid warning during xattr allocation
Message-ID: <ZeXIAmbZmENoKr2f@codewreck.org>
References: <20240202121319.21743-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202121319.21743-1-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Fri, Feb 02, 2024 at 03:13:17PM +0300:
> An invalid server may reply with an xattr size which still fits into
> ssize_t but is large enough to cause splat during kzalloc().


Ah, sorry for not replying to this earlier.. and I had forgotten about
it when something similar came up just now.

I've submitted a patch to limit such allocations to 64k:
https://lkml.kernel.org/r/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org

Would you agree this makes this patch obsolete?

I'll go ahead and add the reported-by/closes you cited in this mail to
my commit.
-- 
Dominique Martinet | Asmadeus

