Return-Path: <linux-kernel+bounces-133400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC46C89A345
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C329B26F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D3173341;
	Fri,  5 Apr 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niema7Rp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0A17333B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336953; cv=none; b=LhYUBRNUquMi5hp/vZBKJfkp/ceBX22W5WSyI5XxdThf95qpZaKWAmRdR4j1f9u0WWcf+/MQZYLqJIqacHbUTU0IOGktOXuQj1qH37pEKm+lAe9biXzDMGlZQdcim+0+ubPbGOSpURbIgAFBAVkS2iB8i/c9m5I10ye+jL1B+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336953; c=relaxed/simple;
	bh=8t2H8FLs/1/uH2aIckaTpiaoX1z48XV57VOz781Bu7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MGrKE/NtQNlpiE5FtSXR1bSzOBT3v6JzTguj+c7dR1Wks7oBcsZvmWl3LLf2KQewejH2/vt31ashcf3N5QYWrI7eb8RNapRUsP7fgQ3iMOptKmqNpY6U+M5oefOeGmZpagZPK0KNwgQwEaBhOL56MtwDEToXIQsdRySj1NGaZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niema7Rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCAEC433C7;
	Fri,  5 Apr 2024 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336952;
	bh=8t2H8FLs/1/uH2aIckaTpiaoX1z48XV57VOz781Bu7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=niema7RpOjQRX0mF+8zXga2Ek+PXt1OT186fSnAwFgJXx5m56RbEDz2AQzOuFCPXO
	 B1Rjhqxglpl/8njLO+brFP7Nm4bQ99DEryCK14l2WyKQOdChnNV/wlagvXHfBkzNKJ
	 LcMNZyJpB1/F+tzpl2o/FXDar2XfD3pWio41vU1ut5/l87110O3pzTw65KScN7a3A9
	 DinCApdIb4i4q5IVEOxIC+O/L03m7gx9QID9sHgFNv7+0zkA6AVevQHt22iOYkOIZ7
	 Cbieh3HznQg4oxU2+8VT+LJamzPUGsrPTYVjwtsq0bJ8PFoTAc+70xKz/OpzegpfPk
	 pIiNh8qqf4Sbg==
From: Vinod Koul <vkoul@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
In-Reply-To: <57a3338a1cec683ac84d48e00dbf197e15ee5481.1709886922.git.u.kleine-koenig@pengutronix.de>
References: <57a3338a1cec683ac84d48e00dbf197e15ee5481.1709886922.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] phy: xilinx: Convert to platform remove callback
 returning void
Message-Id: <171233694977.304553.16769485052582751352.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 22:39:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Fri, 08 Mar 2024 09:51:13 +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied, thanks!

[1/1] phy: xilinx: Convert to platform remove callback returning void
      commit: 7dcb8668aedc5603cba1f2625c6051beff03797d

Best regards,
-- 
~Vinod



