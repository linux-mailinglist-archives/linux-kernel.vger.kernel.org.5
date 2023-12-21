Return-Path: <linux-kernel+bounces-9131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5F81C114
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AFC287CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F078E8D;
	Thu, 21 Dec 2023 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQmpAzbQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007217691C;
	Thu, 21 Dec 2023 22:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227AAC433C8;
	Thu, 21 Dec 2023 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703197774;
	bh=3olSdqCH1RJ2MPrPxBn2yqWGIxPoGVfij5wrm0E4WBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQmpAzbQVhum7pt8MnB5a/VRcUcuMzWWOygOildljSPEjspTWsN83Xs3do5JEyt4B
	 wOCQgDpqhdFiW0WB/4sfRaIcd+qt5e7eTZSHRVCWTIFXFmZWl3uUc4gJ5glMTBM9pC
	 8opfAwrvBB5vm3T4T6bfmRyk3L3xtHbGRrKQgs+ztgCeb9W7qwzwX0LS/nQOPDFmk/
	 1J9++p45KKmNAvXL4jeQgaDDYSYHdw4nnmacHwrGB/e20j87aqa572TAD0p2q4cdB8
	 Q8cHuXjlwkKXyyGPSr03UR34eKjWumho6+z1zy94B2cm6b2v72lysJKg8LDsDKrji0
	 zqwj9JXTs/AeA==
Received: (nullmailer pid 205437 invoked by uid 1000);
	Thu, 21 Dec 2023 22:29:32 -0000
Date: Thu, 21 Dec 2023 16:29:32 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Moudy Ho <moudy.ho@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 02/16] dt-bindings: media: mediatek: mdp3: merge the
 indentical RDMA under display
Message-ID: <20231221222932.GA196757-robh@kernel.org>
References: <20231220100853.20616-1-moudy.ho@mediatek.com>
 <20231220100853.20616-3-moudy.ho@mediatek.com>
 <250fead9-868b-4063-a054-4cb966dc4ba3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250fead9-868b-4063-a054-4cb966dc4ba3@linaro.org>

On Thu, Dec 21, 2023 at 10:28:52AM +0100, Krzysztof Kozlowski wrote:
> On 20/12/2023 11:08, Moudy Ho wrote:
> > To simplify maintenance and avoid branches, the identical component
> > should be merged and placed in the path belonging to the MDP
> > (from display/* to media/*).
> 
> Combining bindings into one bigger meta-binding makes it usually more
> difficult to maintain and review.

Yeah, but these mediatek blocks appear to be used for both display and 
video codec pipelines. So having different bindings was probably wrong 
to start with.

Rob

