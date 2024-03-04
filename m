Return-Path: <linux-kernel+bounces-90699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88A870388
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DA2282572
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B0F3F8F4;
	Mon,  4 Mar 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JeEeUmW6"
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE07E573;
	Mon,  4 Mar 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561051; cv=none; b=R5S8KXXsUq/q9vyR0sFaVYHo2Rkc4AwRUXlRzmXfPYk7wxJOTnkoY/o8+8BY4p/lqkQiAU/crTDuUfaDUUsHUBWT3mwKh+D+DeXwk2EWj47qrFbNo77GFdCPre+/ipt/lu8x1819CDf2tIoI9kS6Np+/hXo030MiFKYK0yhBYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561051; c=relaxed/simple;
	bh=BN1qJJlQBEneDE5OhSeQi8WrX1WlkPPOaXCeqBKB/Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQGTo23gYaSGroxm7Gxp79ttZg9qfppXKeR7jetQXB7Zv16F+MZt3sm53obFf+Vp38/gk4kIF7Yw6ssorO9u8rG1hNDLC4bg1KecEvNstIjZShItwhXCazvdrS0kPqm8c5yR4e4U6XqPGHTOtpHkI8G515B4gZFdJyD96nARjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=JeEeUmW6; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=BN1qJJlQBEneDE5OhSeQi8WrX1WlkPPOaXCeqBKB/Mw=; b=JeEeUmW6yS3b0M2jxbz5eX0Ptb
	/S3Bg8Xr5m8qJrPNyfXb2/+bpar5mjnygP7r+7qfZuJZLSKr1Hat7PFq2yzTKYte/g5hvlHXgOCe1
	dN63joAHhU0kvRcQchlR33vYaCQqOYinw+LFzrVo7O3jRo9c7x5YufTXSPs5mtWDtyquVwt0KcQmc
	4bZWhn1CumKwZZBJnhp9XLikC4lU3k/uVwP/f5CpFD3tKhU/dGNnfkJ1OHT4dhdRY9VfwlCH93qfO
	wYKYy+sRgG0/cyu+RAT/PCkdqN0yYKh9+pvwSC/Duity1vzTZ3IMZz0jgVm2CicOqtS71F9N9qLMQ
	lWb8QQynwYE0Rin/fS5Q+1ocjvmAL7wPUX4KLjT9sb3p+BGXM3mthinULXMK8s66Kkid8+i5dBpxT
	0TrytdotK0m6WwFo9wAUa2bsHHHJg6jfgkCiHIk71aJouwkVPGfjMhEzzMC4MWD/R5dsOj79e9JHq
	hB63+kz5lJOPRWW0hCX3ZVaoQeYBcnuFG4bmrPt8CqxcvhnI7juKmKepRoUK7VtbVOeI8ey+39+Rr
	/50anNLpIxMo5Q3vMOAS4fsiug4SCeAbuo2fVoSJbLlN663x7jEWdTOaeXF/yJQMjlvmnMeC7yC7M
	UAfRpxgPQDYpa4rzZ2ObGYZrfIcy/72Y2dPTmvq0U=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, xingwei lee <xrivendell7@gmail.com>,
 sam sun <samsun1006219@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Date: Mon, 04 Mar 2024 14:35:07 +0100
Message-ID: <4091309.WcpKHNDlqE@silver>
In-Reply-To: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
References: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 4, 2024 1:42:43 PM CET Dominique Martinet wrote:
> We probably shouldn't ever get an xattr bigger than that, and the current check
> of SSIZE_MAX is a bit too large.

Maybe, OTOH e.g. ACLs (dynamic size) are implemented by storing them as xattrs
on 9p server as well, and this change somewhat expects server to run Linux as
well. So maybe s/XATTR_SIZE_MAX/KMALLOC_MAX_SIZE/ might be more appropriate,
considering that this patch is about fixing a potential kmalloc() warning?

Worth to mention in the commit log BTW what the issue was.

/Christian



