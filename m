Return-Path: <linux-kernel+bounces-21288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCD828D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD03B23102
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613303D0C8;
	Tue,  9 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjZtUgOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAB3D0A0;
	Tue,  9 Jan 2024 19:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E7C433C7;
	Tue,  9 Jan 2024 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704827179;
	bh=0imiBNAmxYdjFrN91N+Gr3Ke3cIJ1Iq7tWli0ojzx6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjZtUgOZvQGQl18Kb0i7Od4ej24M4wYIlxaH3LHBBFvTzGYNOw6xpBm4TpJdQoQtd
	 wLZdd1rRiOeaoJQeODjChVJsIFYNZaAXWN4WDynOjY3SXqXmk+KadiXhwOjDsb17OE
	 lM4J/qEf/5jJ73PruB6olUaSOe/d0bT7x9I1QCdL22G4nvlziD0r2mkzEB6HTdzNI1
	 VPQBPqg4Ef7Zyn8cLC/5PORvB0QsKep7Ux6AF6PEQX/1e77Eo/nY4Yuy2+9FtzXDE0
	 Bl2rn15DbWRbYZD5sx0lvPiS+/ouRgipB7YdjwWZX/Qz0XfFlhS/Y7z9FsY6rinf3a
	 QWLXkvSz2YvPA==
Received: (nullmailer pid 2960236 invoked by uid 1000);
	Tue, 09 Jan 2024 19:06:17 -0000
Date: Tue, 9 Jan 2024 13:06:17 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, bin.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com, kernel@collabora.com, matthias.bgg@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max iommus count
Message-ID: <20240109190617.GA2958445-robh@kernel.org>
References: <20240102103801.268647-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102103801.268647-1-eugen.hristev@collabora.com>

On Tue, Jan 02, 2024 at 12:38:00PM +0200, Eugen Hristev wrote:
> MT8186 has 4 iommus in the list, to cope with this situation, adjust
> the maxItems to 4 (instead of previous 2).
> Add also minItems as 1 since iommus are mandatory, to avoid warning
> on the example.

maxItems alone means minItems is the same size. If IOMMU is required,
then 'required' is where that is defined. Is there a case where 1 IOMMU
is valid? If so, what h/w has this case.

Rob

