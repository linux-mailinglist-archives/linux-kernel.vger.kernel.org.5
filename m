Return-Path: <linux-kernel+bounces-52845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE4849D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15F11C22194
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61B2C6AF;
	Mon,  5 Feb 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PqK4/Lod"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD232C1A7;
	Mon,  5 Feb 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144617; cv=none; b=KDwZ/CCLaYssu/whb6earDoqksK2VsciRFo94OgyL41N4qjo1p8w/6BXNBM9wrMUVlisVa4F3nlOfC98kIMZPuhATiuGIMo9q5ul5JV70bPcDuumD1b22vObcDJuQg0DAMSueLsM191prNohbERVj/Ue9Mv+Yc4TbvS770I7QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144617; c=relaxed/simple;
	bh=szSX4nok4T5M1dZHExL58oIlt3D3tU6XnloloWMMbjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkJmlw2+OaBb6JdWpV/YLBBvM/nMvg6HIczCGPkSXm9qP6ivM6U31+6NNmeeuchAmKwnMjxqaPyXVGOZ5HeP7wXlNzrpeOuqj/MRIcpjPbWk+zGdW6vZHhpHDhXOmnD9BBW4afyteJkcitpnVbk9loEyHUevCheW9yKvnv47b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PqK4/Lod; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3E7DC0006;
	Mon,  5 Feb 2024 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707144612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxnkPK0aYtgTS6nZQaM0kMaiEPc4+MnQQKy76Kr6FOw=;
	b=PqK4/LodabUEXbS6Myk3Orf5lht8ZLXJGWRu6g0ykzgaOQMp4uCpI81FMC9+Zvhqe5BNc4
	rQoUNsnQ+Bs8y2Bo3Hw4B/KbC+qWMiqzo0it0850nG1+HUTjVGoLkzJrMjjBj5zb/ElK7P
	Wl9n50Cn/SPY57v8EBxJuK2HN8omD6mUauW3iENYAAUWmOZAV6QdN66RzO+8mzlt2TzsHf
	4DoxKvH0AVXd4cupwHbzKDcKVupzUlfHrX3OF0IkqTBj7ZGBhCov88UtggZ0XWStfxCNj9
	BS/kBo9XXFcOBS+g1U11IHMkZFQip8EoWs0KIM25jBxZiflSRLO/l9NRUrAy8g==
Date: Mon, 5 Feb 2024 15:50:11 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 krzysztof.kozlowski+dt@linaro.org, quic_tingweiz@quicinc.com,
 richard@nod.at, vigneshr@ti.com, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 quic_bjorande@quicinc.com, devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: mtd: avoid automatically select from
 mtd.yaml
Message-ID: <20240205155011.7f27bb07@xps-13>
In-Reply-To: <170542500495.126061.10553621105906619365.robh@kernel.org>
References: <1704885705-7486-1-git-send-email-quic_zhenhuah@quicinc.com>
	<170542500495.126061.10553621105906619365.robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

robh@kernel.org wrote on Tue, 16 Jan 2024 11:10:05 -0600:

> On Wed, 10 Jan 2024 19:21:45 +0800, Zhenhua Huang wrote:
> > The mtd binding is always $ref'ed by other bindings, default selector
> > should be from other binding files which ref'ed it. Now, "$nodename" in
> > mtd.yaml turns into a "select" automatically such that a few binding ch=
eck
> > issues reported because it conflicts with sram devices(eg, qcom,imem.ya=
ml,
> > rules in folder sram/*)
> >=20
> > To avoid the automatically created "select" in mtd.yaml, adding:
> >=20
> > select: false
> >=20
> > Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic defi=
nitions")
> > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > ---
> > Hi Bjorn,
> >=20
> > As the idea is from your comment, I added "Suggested-by" you.
> > Please tell me if that's not suitable. Thanks.
> >=20
> >  Documentation/devicetree/bindings/mtd/mtd.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >  =20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Applied to mtd/next, thanks!

Miqu=C3=A8l

