Return-Path: <linux-kernel+bounces-101703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C187AACA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05681C22001
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D9481BE;
	Wed, 13 Mar 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzSum1Sc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A247F46;
	Wed, 13 Mar 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345348; cv=none; b=Ujf3fhc2zkBX46HpmYfn/Y4m2w0POWJoURvILOVhtemwYHYCIXEmDwjisSGkBlw0F87H9s1pvWCIJyPBi3DgVD88QghyVlitTjBg0lSln4iibUh7xMYtZlNP9jozUiB2+m+BxJwQzEnQHZgOTnBfc1jm3e6h6jGW1orte1olLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345348; c=relaxed/simple;
	bh=FiJ+R0V8x+iDU6ytEfCje6FfFVIFSI4Ytd3TAwhjQD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AosUPVDchGTaUcfDqhn6SxEghUwZiF+mW7S/BywoynNIpanTY0YPJcjgq4aUaTUd6+LXVg1zZYaKK773/+ddlmu1SwsC7uAaaPMjJqpPJUcEGDKVZ0/tT5ZA6GJ0yMfpVKnO6J8UclqZ0EYP1EtIiFYtdgipafsGsQGJnzK5XsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzSum1Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F10C433F1;
	Wed, 13 Mar 2024 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710345348;
	bh=FiJ+R0V8x+iDU6ytEfCje6FfFVIFSI4Ytd3TAwhjQD4=;
	h=Date:From:To:Cc:Subject:From;
	b=kzSum1ScGGvWkqjI0i2EWiz26fP3/TQ7CGCK3CH2Lgm6UgqWH1VdPAgdlbnSQJAMY
	 /Bor3LPUvjkJrYhe+Rv2FWImgdPxm8IaLpymjvNsOmn8BZYvMppIf6Ml5CXST6M+8F
	 hIilklsxSvv3tsEEajUbjuNyVHVlzzXp3rLV4dWt4dfsqzyrkrnu60JhL5A2/ijGof
	 f1h4uLz0yA8XMlIEVn89Cl2mAE7fd24vg6dyXIn3QiG1CVD12xnERPsnUXtlFBVN8o
	 qae8WKPkIIN6VhweNx/uS4zNvkRhDHLmkp9VLCU++ADewu3E2D+dKwFmzZdjzvO2Zw
	 3TkrK8qjUz1yw==
Date: Wed, 13 Mar 2024 08:55:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Cc: <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Landen Chao <Landen.Chao@mediatek.com>, Bartel
 Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Justin Swartz
 <justin.swartz@risingedge.co.za>
Subject: Re: [PATCH net] net: dsa: mt7530: prevent possible incorrect XTAL
 frequency selection
Message-ID: <20240313085546.710679b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 14:25:07 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Relay w=
rote:
> Reported-by: Justin Swartz <justin.swartz@risingedge.co.za>

That's way insufficient for the amount of diligence and work Justin did.
Co-developed-by, at least, please.

