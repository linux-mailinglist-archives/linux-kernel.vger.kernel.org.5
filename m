Return-Path: <linux-kernel+bounces-144309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661E8A446D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12B71C210AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C46135A64;
	Sun, 14 Apr 2024 17:40:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A01350CC;
	Sun, 14 Apr 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116458; cv=none; b=cgMbskeuRChO5TTK2XjM5XlUbvkV/yb7NvC6Wy8eyZfMs5q3Wv3oRgCz7l6esmLYDDcEJ2poXUXkM2pYombsNieCUibVJbfaNALEa2E9vlCOg9YylM8z64VD8ONxfSg7x0nv5eqrY5XNdrFq8ioIxFQ1aHdEcT1h3w2oy7bfdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116458; c=relaxed/simple;
	bh=2ynv8pq3YEVrzmyEWgp68jO26P5+AHTAu3DECKEEVII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5pd2M86vODaz2KnLgqO1dn8tsQAOlSsJRra+rcfdwMLe+KEy/uSw4ur8BLeSO4Fuw7V3fU5la5dYaM77H1ZtLdVEo4LcDTETZcCdgVxmPjGo08Dk2tFuJQ/snKVLwKDOEvf5/i1B7bXLFY1M1UGD0QEhyVhN1jtUecMyaI2ZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96864C072AA;
	Sun, 14 Apr 2024 17:40:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2871D106134A; Sun, 14 Apr 2024 19:40:47 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, mazziesaccount@gmail.com, gene_chen@richtek.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
References: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] power: supply: mt6360_charger: Fix of_match for
 usb-otg-vbus regulator
Message-Id: <171311644713.1234207.8096080431405648048.b4-ty@collabora.com>
Date: Sun, 14 Apr 2024 19:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Apr 2024 10:44:05 +0200, AngeloGioacchino Del Regno wrote:
> The of_match shall correspond to the name of the regulator subnode,
> or the deprecated `regulator-compatible` property must be used:
> failing to do so, the regulator won't probe (and the driver will
> as well not probe).
> 
> Since the devicetree binding for this driver is actually correct
> and wants DTs to use the "usb-otg-vbus-regulator" subnode name,
> fix this driver by aligning the `of_match` string to what the DT
> binding wants.
> 
> [...]

Applied, thanks!

[1/1] power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator
      commit: bcbdcffd94ce21c8aeaa43f223373848fd1202be

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


