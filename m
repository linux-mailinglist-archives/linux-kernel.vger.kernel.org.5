Return-Path: <linux-kernel+bounces-117508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089488AC15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3E532150C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E05C8EC;
	Mon, 25 Mar 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C1ida8Kw"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65198174F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385295; cv=none; b=pPvpLP7LO4KSyWreHHhnYf5ZWL1bQn2UiUoUT1ti+csZYczbtuqhgPDE1EzCWBxBl+uqTkfT3dcS8fccEh/6sgqvZ9fAcMuyKrO7BjVZNSFHwiFwD9FLSlmv/cHvMLbKxt88JliyQG3YPkaWrc4RyFd5rpTW+Y2OORS9UKrlNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385295; c=relaxed/simple;
	bh=iqd5OHPf33Dh5alJMaoDDA/B+/g9AZhWz6dwwQoYzH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7ujZSWXaQQVDbARljwzomZajp6zDHevgeYFPhuvAtL37OzS5H8HiNa8bgBmpYDd3SzLrHpd5aTzsp/urXeKHOJG5Hjw4jKNGVFTsLLkRBPGgGrQydiR85qJqdKXB/gaISTfVi8oh4J3wsYnnjrk2xIJvGibM6u1ZH2/HJifGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C1ida8Kw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iqd5OHPf33Dh5alJMaoDDA/B+/g9AZhWz6dwwQoYzH0=;
	t=1711385293; x=1712594893; b=C1ida8KwueC/hP9xiuLNV5EyVATbTgMKjQWz7O8yOpSIcmy
	X4DJR2x55vgyTX1Ifxqn4oti/I60HvZxtI3GL+T3R2CkGGf+kUKD2nyGneXxi6N9259HfvTkwu4Rx
	RV7FzmF4e9EDT1mITDOrqF1U2EfiHsd3E021BaCNg9HZqrXeEvwNd6HqrEJG46T99rXLakUsbvnMk
	0TGGGeKZeT354QTTLSh8Nsd2U9leQPJHU2QM7w+najst7113yhUIWVqrIWvYW04+dOzwoHdMBmxXM
	m+vgN6dxNZRwVIo3kZsLocUYeWERtYSxQAYS73F/VN6tIpXtSobr+lQFMVyV9VMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ronUY-0000000DxcA-1M7f;
	Mon, 25 Mar 2024 17:48:10 +0100
Message-ID: <4aa1f6ae3ac72a5eb3303740242d53d46a338d6b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Mukesh Ojha
 <quic_mojha@quicinc.com>,  Jonathan Cavitt <jonathan.cavitt@intel.com>
Date: Mon, 25 Mar 2024 17:48:09 +0100
In-Reply-To: <20240304143905.52740-1-jose.souza@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-03-04 at 06:39 -0800, Jos=C3=A9 Roberto de Souza wrote:
> It is useful for modules that do not want to keep coredump available
> after its unload.

Why not though? Maybe if this is a common case we should have devm_...
coredump functions? Dunno.

Anyway, I'm fine with this, even though I'd like to see a bit more
discussion than "do not want". Code looks good.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

