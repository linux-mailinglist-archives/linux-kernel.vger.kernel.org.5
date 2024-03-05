Return-Path: <linux-kernel+bounces-92156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188D871C06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07842852E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C756472;
	Tue,  5 Mar 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlk2GqID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B25B670;
	Tue,  5 Mar 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635246; cv=none; b=DeWBHx2goi2Mc128lrIwX/Uf9E8Tww7b4FD4kk5Zrbgz/ulU3WSApNdDFrgZ5OVpBWkcyXREiX3HgLJahc8cjsyJ/f++ABxpH0WOCSOYDw0ncVA3zvu10WHwmELXEv09CTCsEAJx5RkF1BJ+Pbb5omOvbgWMKQ3L3Memi7DG2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635246; c=relaxed/simple;
	bh=fDlN5HGLItWU94tsGbGVj8uU9vIMn50cMaUnHApy5eQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YuHZQ/P1A8gLJYF+XRZePS5fAn4SUWQTza6UtoRH9R5A3NyeDRGstmPocx9eDRwH2/uyu6Hr1fbqSdtBtnB9Uxa9v2d75E5gxWkHElZWvHaD1EdN+MfOhcGFjz4YFKv5Ir6aPVAuGjAmEsCI2AQ/MGjqVFTbgjGFl0F0yBYaQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlk2GqID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5BC433F1;
	Tue,  5 Mar 2024 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635246;
	bh=fDlN5HGLItWU94tsGbGVj8uU9vIMn50cMaUnHApy5eQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vlk2GqIDqBVE1UH49lZkW0JcOqudwvqlb34gphleBZOxNKjGqfEmVXqT9ztvSoRFj
	 wX3/kn/foaV9dvJq+cS2tCAF+0TPHitUaDsjrfxKpA6AaZLQJFEH+ql9J4KiLJKAhz
	 bI/1xkKPiAH2PG2HSyLVmhg7RxSnAf1F4JVUZyDkyP1dOICydaWnkWHL7A6zdlBoUF
	 gH7FFvSEwDIJgGYC+IlMThiN71WHgTMQE2K3qtv57n8XwSoSmPhbtk3mqKyX5sh97P
	 yKaKmNe60gkGEowdh8kYkKOGoLSTV7tFPWy9Ru9Bul8vzLBZmqdyvPuz+1PBNBlnXi
	 4iYkQeYvQH18g==
From: Lee Jones <lee@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20240301101547.2136948-1-mstrozek@opensource.cirrus.com>
References: <20240301101547.2136948-1-mstrozek@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Fix wrong GPIO_FN_SEL and
 SPI_CLK_CONFIG1 defaults
Message-Id: <170963524448.85157.8424824978966890082.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 10:40:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 01 Mar 2024 10:15:47 +0000, Maciej Strozek wrote:
> Two regs have wrong values in existing fields, change them to match
> the datasheet.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> 
> 

Applied, thanks!

[1/1] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
      commit: 78334c343bef528b911da83a6b041d15a1a72efb

--
Lee Jones [李琼斯]


