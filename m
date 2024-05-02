Return-Path: <linux-kernel+bounces-166682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94C8B9E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F74288C77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4515CD76;
	Thu,  2 May 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icQpYnrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F815B969;
	Thu,  2 May 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665785; cv=none; b=cWwhs32q6uE7ZVn+DDuGApKthMtWlTMa8v0OLEO9WUw0EvsyFboHcWP8DzdNMDrN6mViNVPL2cqMjpkVLXUzII73pdWiu1M6GgpUmVpOCRHaKNhVDmxqd2QMGmdJdo1Qa49WU5nRKhKIRsLR9DxLaeVddI5Y/t1JLXAYxSWFfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665785; c=relaxed/simple;
	bh=ow1KC9SnQMQ7MKL0NI/nMglq9JDo0cCau3G6e2MnlDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jx0OsmYjFIv0bQdRmtb+dAbcXyno/HgVdikTHCurIqFAe4OpHb3YutJf3dJtbyy5g2Ioq7nNmhKePlBhEWRLZecRAVjchVbapuKAmRwsxj3d3bo0fH7JoJ1n0SW6g56ahpLRn2ojLMEoCEsX76wMzrm0SsBoW932a9YNFiwIFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icQpYnrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA13C32789;
	Thu,  2 May 2024 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714665784;
	bh=ow1KC9SnQMQ7MKL0NI/nMglq9JDo0cCau3G6e2MnlDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=icQpYnrAZKg4/VonjJUS6w8mwh2OFRmpACcphL5nNVygT69ke9ZrvMwtH7ts4JBbT
	 6EpxSiEsaNTDm8oGeEb16K7GRXJ4OPRNFGT3HKFe8Vr30x4YqTkecTjJYVhahirODG
	 EVx9sElJcoxiqBgwX8EV5WHRVPR5HIPJGsltLzefVOYjjBjIckfxPIjbZ6B88qrqJB
	 GQXGqByFqefiYFL09bxi3bTkOMqSa9H9/Vll7kMUYnrWmceuy/DDELIuetkJ6IFfTM
	 pF71PfC47S8+ENSECGkWkXobGKlp+/ENlIiUZp8jpdtOpmEcI+3/0/rslpBCT15oCe
	 Vl8m5wLSqCzhA==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240426135602.2500125-1-masahiroy@kernel.org>
References: <20240426135602.2500125-1-masahiroy@kernel.org>
Subject: Re: [PATCH v2] drm: move DRM-related CONFIG options into DRM
 submenu
Message-Id: <171466578189.2253884.109722255099962126.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 26 Apr 2024 22:56:02 +0900, Masahiro Yamada wrote:
> When you create a submenu using the 'menu' syntax, there is no
> ambiguity about its end because the code between 'menu' and 'endmenu'
> becomes the submenu.
> 
> In contrast, 'menuconfig' does not have the corresponding end marker.
> Instead, the end of the submenu is inferred from symbol dependencies.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next-fixes).

Thanks!
Maxime


