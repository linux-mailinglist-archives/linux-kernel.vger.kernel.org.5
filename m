Return-Path: <linux-kernel+bounces-16015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3939823709
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B571C24691
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF51D69F;
	Wed,  3 Jan 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GQXUn/Fy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD51D687;
	Wed,  3 Jan 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B612E1E55;
	Wed,  3 Jan 2024 21:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B612E1E55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704316765; bh=9FsdM+OiY9h0bwkf/RVVOio5mAWZiDpNqd/NG85a638=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GQXUn/FyrfclJPoljC1JUwsu3ET/NhghkWBW3xKOY5/VHYlTIX/7MDsjHcSXYIroU
	 uwEQB65pToWKF+tkvNA4nTzv3uuIEU5hdGksnDTwt6LYPLE9hF9d4SjdwiICfULYby
	 LP8QQpcO83DLhAs4h9Xc4Qvj6p5QR4W2bxwVxvb59fSSFflrBajRn3byHphVBmsO/q
	 qClA7e+IMGAgEstcKrgVTWIGGTSHOmbpJLY4ZK6powiirFhsbQk0KtSHxHOU6m5dVL
	 inN9DdRGPcTBe70eVZn5Vkz9JipKHWqRCRQqdDL/jDAAD3FRmwLFiPH0fzNIpfwcEc
	 8YKG4MylQtA1w==
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>, Jaroslav Kysela
 <perex@perex.cz>, Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Vegard Nossum
 <vegard.nossum@oracle.com>
Subject: Re: [PATCH 0/2] Move driver-api/{dcdbas,isapnp} to userspace-api/
In-Reply-To: <20231221124816.2978000-1-vegard.nossum@oracle.com>
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
Date: Wed, 03 Jan 2024 14:19:25 -0700
Message-ID: <878r56868y.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Hi,
>
> Neither isapnp.rst nor dcdbas.rst document driver APIs; rather, they
> document /proc and /sys interfaces, respectively, which are userspace
> APIs.
>
> I'm submitting this to the documentation tree -- Jaroslav and Stuart,
> is that OK with you? I suggest doing it that way since there is a tiny
> dependency between the patches (for the driver-api/index.rst and
> userspace-api/index.rst changes).
>
> Testing: ran htmldocs, didn't see any warnings related to these.

Applied, thanks.

jon

