Return-Path: <linux-kernel+bounces-105982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8A87E718
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0875282B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721EC36139;
	Mon, 18 Mar 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="40g/k9f2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAF31A76;
	Mon, 18 Mar 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757219; cv=none; b=HjrnUC45Lrowc7v1d7VVWCSxnx3+LM3KhsNfTf+/k5uBwuuWHnKJ1mgpALB+maylqmUtF45VcGDFpkfSMf2noO1TS3P6GF7TKeZVq5/KuLs+49Y52/U21iCNDtbknluNwpF/PEP7Rz/j0WN6gvJiSGC4WQKcbsxKT0eN5aj6lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757219; c=relaxed/simple;
	bh=m0pDcBwwC4vZIub9JwwCc5l2BmB8htEdkn9ngNhOfU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TboTFz2Np4ZSn97LBiBwE4cg3s4fFXRO4GyrbQPE3TO7a+vf+Bykl/u4rTXmgf/qbPdGVHStVtA9HXXqoLi0eC5aKqR546L1vjyJFSQEq7xPdMPR1Fe9PzOppwDWFOe7FPYmaaTTct+mA0MY46nrz/HqII+AMG8Nm8nDT0wybc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=40g/k9f2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757216;
	bh=m0pDcBwwC4vZIub9JwwCc5l2BmB8htEdkn9ngNhOfU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=40g/k9f2Ix1MzHzA4WReefE4pxXvdqrUC+xt46InFoq+rVF7jfiShisVoDuz9rAxl
	 qI52feKqPoBw5sfX8Nw254Q+ECXcJVa5NdUrRFDVmqTv0swdnAB+x7IkT2s9cyXRw9
	 oZvNJVyHKhdr65TYrtKroqJLZSuZuZw02Nm5/3Nh61r5DbigmI4wVry0u1GxUJL+eN
	 31CZ3P0sr2SOV+627Uv1kS9qAjXZeRQMBFhiFBAwjNpzQ8NJy7mDq3PRy1HLjRpHDf
	 dK5V0m/EoTUC9czqbjoYvJ9ti+4KzvP+R2WwXq3n9z2aAkA9661yHOHShj/40vLEmY
	 0iNGr6BDTIozw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0EA98378205B;
	Mon, 18 Mar 2024 10:20:16 +0000 (UTC)
Message-ID: <8e231a62-15d1-4b08-9c9b-340d30ab7630@collabora.com>
Date: Mon, 18 Mar 2024 11:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] mips: dts: ralink: mt7621: reorder ethernet node
 attributes and kids
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-12-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-12-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Rearrange attributes and descendents declared under the
> ethernet node, recursively, to follow the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



