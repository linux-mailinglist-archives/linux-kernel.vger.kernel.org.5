Return-Path: <linux-kernel+bounces-20323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D1827D55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92889284325
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66758468B;
	Tue,  9 Jan 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEQoqncy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD18259D;
	Tue,  9 Jan 2024 03:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CFC433C7;
	Tue,  9 Jan 2024 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704770852;
	bh=oadwz3FDt1BgkOoIeSZJAkWVz6I1yACFQHKwE2eF30s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEQoqncykXWh5WhLRGHRsF4KdRp0/hgkzb36kwTxhoIsKZQkDBjOwmCcMSnAhYYIw
	 OpmAkvLPdNpHsZqkOQ1/38boNFVVUzs7iIEGwLvYegjuTZ4NiX2R0kgsR93uQUYHCW
	 Sw8rxDrS5qGUvFDgGZvw3BBcMKnNMiiWJ25f5QHBFRT/FbF0mhQp4tZ8jKUVl/Wldi
	 M0E52nYIpRGH9nzQecsLjll+KG4+9/sTW1K2E5CMFJ0K6N+bWgYi8QxFo1TavVEvHD
	 xKpZOGhR7YCBNkmLJsBqc/VQC7j6kqnPcZctbb7DB/WjMOaB0GgzWLlodAallz48gW
	 Y7UzFn5Z9hMYg==
Received: (nullmailer pid 2583107 invoked by uid 1000);
	Tue, 09 Jan 2024 03:27:31 -0000
Date: Mon, 8 Jan 2024 20:27:31 -0700
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: bin.liu@mediatek.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max ioomus count
Message-ID: <20240109032731.GA2578937-robh@kernel.org>
References: <20231227130812.148914-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227130812.148914-1-eugen.hristev@collabora.com>

On Wed, Dec 27, 2023 at 03:08:11PM +0200, Eugen Hristev wrote:
> MT8186 has 4 iommus in the list, to cope with this situation, adjust
> the maxItems to 4 (instead of previous 2).
> Add also minItems as 1 since iommus are mandatory, to avoid warning
> on the example.

maxItems alone means minItems is the same size. If IOMMU is required, 
then 'required' is where that is defined. Is there a case where 1 IOMMU 
is valid? If so, what h/w has this case.

Rob


