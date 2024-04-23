Return-Path: <linux-kernel+bounces-155445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26078AEAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437AB1F2480B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F113DDC6;
	Tue, 23 Apr 2024 15:15:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548413BAFE;
	Tue, 23 Apr 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885348; cv=none; b=gxB0Dy88/WaTu0PSlKCSTHOQqQHee+G07zxZbGjhndCWOT8uIPrLyIO00FQjCM+3NjSOGNx9Qtn9TzXPIT7jkmGwhGCh/SRqwyXVuMDTRWVd1FnlY6J1BGJyqriy0IKM1V2kxN7mNUQm6ef3p55IuGj2HdGXI6XX2J+OYtamhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885348; c=relaxed/simple;
	bh=XxcTd7LqaCigdDlq4y6hHS87KzLDSmMSLLvaSA1v7Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN0hMr8CIlHYBXFuQwpjXKj0K1O3oS9zoTbxg/H735xQewz2FIsxXFg3tuYWTxeq4JDdPJ/78VONiny2elg5SSRd4+7mORm1TUINzY+qzYi8UXaZwelbM+hGN1NPOq6hHNyTReJFhuFrhDfLic/5PozRmHFa9QSJ+jtp/Q7ciwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrv-0007PZ-QB; Tue, 23 Apr 2024 17:15:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marek Kraus <gamiee@pine64.org>,
	didi.debian@cknow.org,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for Pine64 boards
Date: Tue, 23 Apr 2024 17:15:32 +0200
Message-Id: <171388532521.2652222.18024517612743377604.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
References: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 02:43:43 +0200, Dragan Simic wrote:
> Correct the descriptions of a few Pine64 boards and devices, according
> to their official names used on the Pine64 wiki.  This ensures consistency
> between the officially used names and the names in the source code.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Correct the descriptions for Pine64 boards
      commit: 433dafc7b4f9f9a1011d72b32e138b598faa4807
[2/2] arm64: dts: rockchip: Correct the model names for Pine64 boards
      commit: adbc5e6b457e773f1afa11fdb9b667cd492a7f82

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

