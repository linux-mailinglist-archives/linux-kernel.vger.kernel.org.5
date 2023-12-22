Return-Path: <linux-kernel+bounces-9551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C763281C76F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ABE2877A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F2FBF6;
	Fri, 22 Dec 2023 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="KUeJEFF8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253FF9ED
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail2; t=1703238029; x=1703497229;
	bh=RvFPmQYSXCW++H17F3FBSpFjPOkodCCqULNpYKx/X4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KUeJEFF8cS8NbUYEe1YI7C9RCUnb22uQFIsHpP6jjSohQf0y1mWvISCZss2RSG0cE
	 FpFbc+rRNMpRZSb13C1ahONUfnCzGKxUsUUXSsR5C+1R9ci2C5g3By5Mb251Zs9fVi
	 YFv/UAC1f8dJ2Vd22XeC0cShQ3exgbgm9qAvG5p0ggzE7Kr1Y++nvPWpA9zuiSt7oR
	 JeJvwrdg3px1mpjFK/Pb0+sldHag3128mqywcYp+5f8irYQA4y3n4J7ElJxPnbAZiR
	 03F5CEcznFJEOCNtxpJk+MYxgpv1yuAr1WVgq6nUByVZdezLQspZZ6YpOL8YNsVtZb
	 E9NXLgPNEemwQ==
Date: Fri, 22 Dec 2023 09:40:18 +0000
To: Pekka Paalanen <ppaalanen@gmail.com>
From: Simon Ser <contact@emersion.fr>
Cc: Joakim Bech <joakim.bech@linaro.org>, Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jeffrey Kardatzke <jkardatzke@google.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Vijayanand Jitta <quic_vjitta@quicinc.com>, Nicolas Dufresne <nicolas@ndufresne.ca>, jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, ckoenig.leichtzumerken@gmail.com, linaro-mm-sig@lists.linaro.org, linux-mediatek@lists.infradead.org, tjmercier@google.com, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] dma-buf: heaps: Add secure heap
Message-ID: <9m8eC1j8YSwxu9Mr8vCXyzF0nfyCSHpFbfc__FtUjjKppew65jElBbUqa-nkzFTN-N_ME893w0YQRcb3r3UbIajQUP-Y5LxnHKKFoiBepSI=@emersion.fr>
In-Reply-To: <20231213161614.43e5bca8@eldfell>
References: <20231212024607.3681-1-yong.wu@mediatek.com> <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr> <20231213110517.6ce36aca@eldfell> <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain> <20231213133825.0a329864@eldfell> <20231213132229.q3uxdhtdsxuzw3w6@pop-os.localdomain> <20231213161614.43e5bca8@eldfell>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 13th, 2023 at 15:16, Pekka Paalanen <ppaalanen@gmail=
.com> wrote:

> > > It is protected/shielded/fortified from all the kernel and userspace,
> > > but a more familiar word to describe that is inaccessible.
> > > "Inaccessible buffer" per se OTOH sounds like a useless concept.
> > >=20
> > > It is not secure, because it does not involve security in any way. In
> > > fact, given it's so fragile, I'd classify it as mildly opposite of
> > > secure, as e.g. clients of a Wayland compositor can potentially DoS t=
he
> > > compositor with it by simply sending such a dmabuf. Or DoS the whole
> > > system.
> >=20
> > I hear what you are saying and DoS is a known problem and attack vector=
,
> > but regardless, we have use cases where we don't want to expose
> > information in the clear and where we also would like to have some
> > guarantees about correctness. That is where various secure elements and
> > more generally security is needed.
> >=20
> > So, it sounds like we have two things here, the first is the naming and
> > the meaning behind it. I'm pretty sure the people following and
> > contributing to this thread can agree on a name that makes sense. Would
> > you personally be OK with "restricted" as the name? It sounds like that=
.
>=20
> I would. I'm also just a by-stander, not a maintainer of kernel
> anything. I have no power to accept nor reject anything here.

I'd also personally be OK with "restricted", I think it's a lot better
than "secure".

In general I agree with everything Pekka said.

