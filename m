Return-Path: <linux-kernel+bounces-36496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32583A1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911CC1C246F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E9FC11;
	Wed, 24 Jan 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn7m/JYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E1F9E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076049; cv=none; b=QHRtJxOTw0aYU0kh1UT3xXCFYRT3jP86Su3FXX/V1Wb3zO4SF6eKGt/tsT3WIAY59nIkEwbZyXvkkpYpt8L9+2Z0GjV2BldUK+lp4mk7GwYFssWzl1Kp8nLuPD/Wxue4JuImjL5lb9Eod7YjYNg4Uy6egAcFjxnJ6OKGh9+5zSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076049; c=relaxed/simple;
	bh=tP4wCTpxD5LTQUGD66ydQtCU3SDRUyqLZriPi9UhsWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l7u/Wjpdlg4eaXc14B9Kyp72G1QdZL4ianSynl1wGY0Sz51rZ6HbtU4ymlEfkG1x0BLh8ZZ3/0a+835Q/56YXsM8ouvq7WlTQs5hK16iCfW88k61DLQ7R0ZnozJG9jZte9eoZJvMh6GITTq1f/ZQpp/s17V89c6rzHCwRB9yXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn7m/JYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A6C43394;
	Wed, 24 Jan 2024 06:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706076049;
	bh=tP4wCTpxD5LTQUGD66ydQtCU3SDRUyqLZriPi9UhsWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tn7m/JYgRQk/T56XF8yGVShjwEH1+w/rvc7AUDTrf7pk+pel3uMqlVkzRx9zzwVLC
	 40dS8JU9lZqmmna3K8AWOzldMg0owYW5rEz5kO/7Q+eCJDnKMI9Ff/koxVWYVtzJgo
	 SDSB+iSpPtCurmHsatXRmetTUHXAAcnvv2X0s+vnZiQrn2jyH5yrHhC5X+PBMu92DX
	 WN+zh7T36q1xGL18Q1Szc/wGLYdLpmUCvdy6tTvBSC0mwPBCpywnikP5SJQOUYbawn
	 c7iyUYB5r1QmKhh8AlVbLO2FFsMS8/0j6huWjjjCC8QXtyv/7QIwusU0cvVdOQ1MoP
	 eu81GHKQ2En4g==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Josua Mayer <josua@solid-run.com>
Cc: rmk@armlinux.org.uk, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240106-fix-a38x-comphy-sd0-gbe0-v1-1-c7fd87272050@solid-run.com>
References: <20240106-fix-a38x-comphy-sd0-gbe0-v1-1-c7fd87272050@solid-run.com>
Subject: Re: [PATCH] phy: armada-38x: add mux value for gbe port 0 on
 serdes 0
Message-Id: <170607604745.409477.5557157299914031088.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 11:30:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 06 Jan 2024 15:56:33 +0100, Josua Mayer wrote:
> Armada 38x supports 3 functions on serdes #0:
> - pcie port 0
> - sata port 0
> - gbe port 0
> 
> Add missing entry for gbe port 0 on serdes 0 to the gbe_mux array.
> 
> [...]

Applied, thanks!

[1/1] phy: armada-38x: add mux value for gbe port 0 on serdes 0
      commit: f7c6249d76f1167f2fc9843311e54e2528666d11

Best regards,
-- 
~Vinod



