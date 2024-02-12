Return-Path: <linux-kernel+bounces-61300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC08510B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996261F239BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EF18643;
	Mon, 12 Feb 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCZKvqPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5232208A1;
	Mon, 12 Feb 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733480; cv=none; b=PxEBqolMGlqGsMjLv4h/UgRoHirWDHdU1TSvDlfi6eYBuwwzvc3zItCJKKZ/5Bv6yu6RtZBYTh6v9Vvwq7bpSGSQGDyMcJHmehCWNw5HSmmHO0hcV2c9k8zqIEmrmxaxcPDDJvEtXz3/JY6p7rdVAmWOgNmNWxc22fKRa5jtNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733480; c=relaxed/simple;
	bh=OApYkGg25CGtTurxm1VIKUgdxbO6Np5VXQc0RbFGgw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=D8y5LOOEz348uvQO9Ne5x/Mm7X6JJDDDAJqvxGj4g3WWy0NhcCTNom+4YxqZi5agK3h8tQq1AOZn3M3uze/pTUN3xrPQidZtvEnm+BdPC7DcuiqBafC+/Uwj330xmKjPRKSrxHZxIBtvhNuL+M7Oha1YNBwwbEyHDk+GtVU2Pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCZKvqPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC151C433C7;
	Mon, 12 Feb 2024 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707733479;
	bh=OApYkGg25CGtTurxm1VIKUgdxbO6Np5VXQc0RbFGgw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nCZKvqPIm8CDlFuo0UlnnqqemTZx3DK7vgsPkqR3Vgl96gu0NAE1GRNrfqtdpv37i
	 SbsQ8dpYqhsIZwA5K3DNw0QH+BMbVt4qg2uBZU20uBKj1YnRq1RwugzhkGRlqUwXMu
	 2pvRJ8a0tFoetYoD13o+HkTo8Hg9hKjRU7UDRW68qxROw/1qmjWVZpRKvN7CnlAFRC
	 w+vCPMHUHdBAl+7gRmvxlr9QiFm08hPaFESmsKX9xb0scM/39PF6JwvPw97SkFswN5
	 vHx1Ggll/bsPcAfkaOczC8FCBlXF75T6TJweePhr/JpgzTD+V4kf82MOgqa0FCdnjD
	 p6nX3dfNcywVw==
From: Kalle Valo <kvalo@kernel.org>
To: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,  Felix Fietkau <nbd@nbd.name>,
  Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  linux-wireless@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] dt-bindings: net: wireless: mt76: add interrupts
 description for MT7986
References: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
	<03d80cad-b72b-44d7-b726-cd8e3d4f81a9@gmail.com>
Date: Mon, 12 Feb 2024 12:24:34 +0200
In-Reply-To: <03d80cad-b72b-44d7-b726-cd8e3d4f81a9@gmail.com>
 (=?utf-8?Q?=22Rafa=C5=82=09Mi=C5=82ecki=22's?= message of "Mon, 12 Feb 2024
 08:20:56 +0100")
Message-ID: <87o7cmou8t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> writes:

> On 21.12.2023 04:26, Peter Chiu wrote:
>> The mt7986 can support four interrupts to distribute the interrupts
>> to different CPUs.
>
> Can we have this patch picked up, please? Felix? Kalle?

Felix has applied this to this tree:

https://github.com/nbd168/wireless/commit/26b98d08fda9ebef33c5eb3e1a6a14be6=
4358caf

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

