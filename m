Return-Path: <linux-kernel+bounces-24649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE082BFB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8166CB23B18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCC6A331;
	Fri, 12 Jan 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SD9oSjC6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EE6A32B;
	Fri, 12 Jan 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705062029;
	bh=i8hxiZtStqbbjhK8/jOTH1x0pnQ0MfzuFS4C3hHq9Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SD9oSjC6pMipZ5XcLfnAjzmwaDrWiehIl98MAk5QfY84ZmVKwATxN87MyJAZODQm0
	 fQycGjGiYLi4Rowc5HVHH/mDXF8rb6d1vDTWLSQgITwC4mNd2lKh1nKhuQ9t/kcLTL
	 7Y3jcbnrIKmhXTzUcHyalJ6Y7b50maKTJUBMTLp5dpRfyXtzkT1vuaMWwRb+vfHNv/
	 BWuT2y2dfkj16gvvThNTcTqPYaQTSjgzYdV/gFrExrT5q7z4TjknGBgir2j0AN9C9q
	 KJgLLs15Wx0Pa7xVtCJPkqvgfmCu2kCXE+L3ss6LxSa4xj5QjoD0PypOfNPUjC8x/p
	 yttkbbWUvm0hQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C9F873782017;
	Fri, 12 Jan 2024 12:20:24 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:19:52 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ikjoon Jang <ikjn@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mt8183: juniper: Remove CrosEC base
 detection node
Message-ID: <cfa39af2-936d-470e-93ea-adc2a632849f@notapiano>
References: <20240111195335.871096-1-nfraprado@collabora.com>
 <CAGXv+5FKHX482+QjYP=jWKWz2HD=Af6x9Cahi+fc4EKNmM-MMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FKHX482+QjYP=jWKWz2HD=Af6x9Cahi+fc4EKNmM-MMQ@mail.gmail.com>

On Fri, Jan 12, 2024 at 03:10:12PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 12, 2024 at 3:55 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > The cbas node is used to describe base detection functionality in the
> > ChromeOS EC, which is used for units that have a detachable keyboard and
> > thus rely on this functionality to switch between tablet and laptop
> > mode.
> >
> > The juniper-sku16 machine is a convertible, meaning the keyboard can be
> > flipped but not detached. The detection for the keyboard getting
> > flipped is handled by the driver bound to the keyboard-controller
> > node in the EC.
> 
> We could do this for the whole jacuzzi family, which are all clamshell
> or convertibles.

Ah that's great info, thanks! I suspected so but since this unit was the only
one that I could actually test the change on, I decided to stick to it.

I'll send a v2 removing the node at the jacuzzi dtsi level then.

Thanks,
Nícolas

