Return-Path: <linux-kernel+bounces-93164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A02872BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB61F25482
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC27D518;
	Wed,  6 Mar 2024 00:24:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C363CF;
	Wed,  6 Mar 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684670; cv=none; b=av/p9Ydwv/+H84MF9PMNZpaZ36n3cGa0aLkGulL2TyhI0ND6wITmDiGFbB1KL1SbMDlKpEo03QiUs1K7M5hCjpmAL52vwg18ha8j9DG0oAYxfi8AvGu20jtSCTRKAxzV8cWKu7/XvwvmRgy5g7mugTA1oZvk1PgcU+FwF/UUKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684670; c=relaxed/simple;
	bh=TgRBiYCHdeXZfja/DASlXzVoEa/qu2KTviAC5jDbs34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IqKBAfuFKmh3dE0MpseZdXBfvLd2l8hrnwm1VeG89xcYwGUeeUWOcP+eBgYxGcRcD/chx22/qcARJcrZuzgMZgXzbVpeNrgyZfNvulXtD1IZa8E11bVmStbeHEXJtw+XuORayzPKy8zKIEzFeJjW8Y7roStiimBYp2V/hT62vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56957C43390;
	Wed,  6 Mar 2024 00:24:29 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3A95F1061BCB; Wed,  6 Mar 2024 01:24:26 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Sebastian Reichel <sre@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
References: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
Subject: Re: [PATCH 0/2] power: supply: core: class cleanups
Message-Id: <170968466618.645753.8043316178585971724.b4-ty@collabora.com>
Date: Wed, 06 Mar 2024 01:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 01 Mar 2024 23:58:25 +0100, Sebastian Reichel wrote:
> I noticed some further possible cleanups when reviewing
> and applying Ricardo's patch to make power_supply_class
> constant.
> 
> 

Applied, thanks!

[1/2] power: supply: core: add power_supply_for_each_device()
      commit: 68ade0976df7979eac5f1d46320ff798f5043af6
[2/2] power: supply: core: simplify power_supply_class_init
      commit: ea1ec769d1f01a9900127e83e63dfdd77d096c8a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


