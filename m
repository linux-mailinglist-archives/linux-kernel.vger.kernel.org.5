Return-Path: <linux-kernel+bounces-133863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B834489AA11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C441C2115D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D22B9D5;
	Sat,  6 Apr 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5s7UWv/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3F2B9C0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395124; cv=none; b=HdLEPnoe5ZyM0NolpU7fR9d97wJaNfC1WrR1HvJdafj8enUc8dJJ0HOG528UbkM0ftkRnHx5SnBHzSqrNVG4FvjVCetFUZaYFxlggsJ2oFmCsa4NNZNbU9abiwJWyknLSNZmQ8tkycxcji+R6a76uGIqM342OOeLd6Fhz/Myuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395124; c=relaxed/simple;
	bh=YyCtD5bY6qKKre4mnsu4Pdof0IXCK0AKuOli174B4NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LrIOficCw9AR9oTLqTOtxeQFcT5tRONcEOEAXoC2N3Brr1zUyrRWTHl61+Q2ExhH/Cn+yp8z1epxkORBvzVrWwSIkk4RpnuC6svRuzkhk2zgyAyUgLedSnUod3mk0A5CJgdHa8x8H1ZDqqdo+r+2MT80xOKPuZcL0qmaZC5Q4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5s7UWv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D55C433C7;
	Sat,  6 Apr 2024 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395123;
	bh=YyCtD5bY6qKKre4mnsu4Pdof0IXCK0AKuOli174B4NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g5s7UWv/UWJVuBFCUSzT+7pId1kAojSHZo0FCo7V6USxrTQLz0CuiwIYRTwWH54GL
	 X5lgnPM5SP5Z+bkH+Gl/IhL9xmGDXCBouMoxS05J2eyIUDtYKPNsS+jpFgnFazbEdN
	 Wu6QKmWvuolOK+cgHc0ZgtzgaixUIoavwyYdhXXfRqi3vhY+qlNqknhvqfctmVX1/j
	 Kzds3NO251uJ3Klv9Y+lbsn4zcYyt0RVSwmevLrmGmR03V5RmRA9SfU/f5i3SpvMeU
	 KIBpP8qV0zJpbNuVhsN91/AodDkyLkNu18fo4cY/Y0YFvqGQ062v5HgBHOcixkgCex
	 PTwdVggZwCSNw==
From: Vinod Koul <vkoul@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
In-Reply-To: <20240325201254.54445-1-m.kobuk@ispras.ru>
References: <20240325201254.54445-1-m.kobuk@ispras.ru>
Subject: Re: [PATCH v2 0/2] phy: marvell: a3700-comphy: Minor fixes
Message-Id: <171239512055.352254.16901134806366326703.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:48:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 25 Mar 2024 23:12:48 +0300, Mikhail Kobuk wrote:
> Changes in v2:
> - Replace hardcode and ARRAY_SIZE() with definition
> - Link to v1: https://lore.kernel.org/linux-phy/20240321164734.49273-1-m.kobuk@ispras.ru/
> 

Applied, thanks!

[1/2] phy: marvell: a3700-comphy: Fix out of bounds read
      commit: e4308bc22b9d46cf33165c9dfaeebcf29cd56f04
[2/2] phy: marvell: a3700-comphy: Fix hardcoded array size
      commit: 627207703b73615653eea5ab7a841d5b478d961e

Best regards,
-- 
~Vinod



