Return-Path: <linux-kernel+bounces-123403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10989080D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FBA2902B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722F7D074;
	Thu, 28 Mar 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkrW4yMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FA12B76
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649618; cv=none; b=Espd/FfQu2xITCvGrACBJNQdM6sOHLgv4Y5tgCqgpTt5LUSP+tWuzS81bImNfC9jPBcd/B535zrT2crUwYWEpGY8ecPXmVoTv2iq7/qaoqs/ltmCNGubNmHiJSSzFQu8XSiufcp2ou22GhJzIMPPONuCaMpyCGw0MryD/VZ+ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649618; c=relaxed/simple;
	bh=hCHdpwkQBt9D0yMTx2ID7nt+cY5d0EFBST40naks2r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rSLHogVf0zsei1fvNfaOp7KhWu1grBWN5uIBRlfLbt3SWjcl85C8kEd36bOZh1/InrKV9Pb9vmVrWAvC/FkxOLg6GefhNSt4Iu6Q4jQVPnc8qUKdq9CExpUdQVZgofwwSmxHbWTh1VcSvjTV+tWzPW4tJJy/jvM5pP5PvQvarRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkrW4yMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B029C433C7;
	Thu, 28 Mar 2024 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649618;
	bh=hCHdpwkQBt9D0yMTx2ID7nt+cY5d0EFBST40naks2r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rkrW4yMpNKammkh6VnlYoGTSI61Cf/DYDWVzq+ebUOmLNBMtLw9emfbc8Xa+N0Nm5
	 KbWJPXrNm08wgzy9C4y4W53WRCmIVOIf+W+S/b0bum8RABA3KJtrJPvF4VGUGLNFA5
	 H8b+Dmsx94qVa4Wk27ghS1hivKX6jcPD168PXb96jW1ooJk+8ax1g2ilCTlj1tlL2i
	 rGjgR9INYVy2Q6FyLfmBCdQyRKWUZTeuYc1xF0AIMgAI5g1z8VoknMuqQfarH3AIpb
	 JG1FKiag+LpQuvEiuIYSEtHhUi/WixnPUhJoM+J4glc9rjMF6Yvb7alT+oo/2Z7+7w
	 uVBe3/IG0+6ig==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, 
 pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240327063143.2266464-1-Vijendar.Mukunda@amd.com>
References: <20240327063143.2266464-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/2] soundwire: amd: use inline function for
 register update
Message-Id: <171164961371.128029.7404950092235266679.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 23:43:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 27 Mar 2024 12:01:42 +0530, Vijendar Mukunda wrote:
> Define common inline function for register update.
> Use this inline function for updating SoundWire Pad registers
> and enable/disable SoundWire interrupt control registers.
> 
> 

Applied, thanks!

[2/2] soundwire: amd: fix for wake interrupt handling for clockstop mode
      commit: 63dc588e7af1392576071a1841298198c9cddee3

Best regards,
-- 
~Vinod



