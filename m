Return-Path: <linux-kernel+bounces-33755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE6836E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D4D28BB51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AC4A99D;
	Mon, 22 Jan 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="L+GO/3uS"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D44B5A5;
	Mon, 22 Jan 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943526; cv=none; b=jEfGRw0BBWmRMbQOD9g/usGNnujADEQ1BLLQxT9AGU4vYxlLPPND3ycQ58XB3VwGPCF4FcmK5ui0WvgrXyQGNo0Q0/gC/36sk2/DDjE+a9SDkrs94ztCNv8i/BdpX733wW11otHwPPBq2VHnXcKxGbJEU4jLDVRReP2vgEray5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943526; c=relaxed/simple;
	bh=a8vk6hZ3TOAkzn/ackfXsaq39NTBfLHYum8B7uhs3mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqIP/m2r/yiZKEl6sXdzWSWXNF6aVFiQ+QtUC/bBHUI9WpthmghIP3Xnqa1u2ZbXp+ljg/73/I5S1WqflY3BGV7404+y4UCKsVmbF1iEQ0Oa7e2KHrpcIbumeEGaTdkpwjLS74csQgWy4yGDQ2kIl8hEoT9ypEEHrkD4PpAANCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=L+GO/3uS; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705943514; bh=a8vk6hZ3TOAkzn/ackfXsaq39NTBfLHYum8B7uhs3mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+GO/3uS3c16vczNT28Ht/QB0UoI9Lsp6ivS59/FsmIngripMJe9p6CjPKDogNDNF
	 8feWcbEEenUneCg6blD6o9Nr3Ma7CqrGOrC8vzeOlPZtDMe+tpumKx2b4cUCQmlulP
	 GmZqLEVSv2BXkDDHPf1I3pg021odHjAbWDjQp9R0=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
Date: Mon, 22 Jan 2024 18:11:53 +0100
Message-ID: <12366609.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <e57f3274-46a8-4c42-af29-ff2009127886@linaro.org>
References:
 <20240121-memul-rmtfs-v1-1-e9da29b1f856@z3ntu.xyz>
 <e57f3274-46a8-4c42-af29-ff2009127886@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 22. J=E4nner 2024 11:53:33 CET Konrad Dybcio wrote:
> On 21.01.2024 11:21, Luca Weiss wrote:
> > Add the rmtfs-mem node which was part of one of the "unknown" memory
> > reservation. Split that one, make sure the reserved-memory in total
> > still covers the same space.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
>=20
> Could you please test dynamic rmtfs alloc, which should be possible
> on some (most?) boards after 9265bc6bce6919c771970e5a425a66551a1c78a0?

To be honest, I'd like to not continue to experiment with reserved-memory o=
n=20
this board, I've already spent way too much time figuring out how to not ma=
ke=20
the phone crash under some circumstances, and now it seems relatively stabl=
e.
I might've even put my eMMC into some weird read-only mode where any write =
to=20
it just weirdly fails (also original software) by writing to random locatio=
ns=20
in the RAM (or well, what Linux thought was non-special RAM).

Regards
Luca

>=20
> Konrad





