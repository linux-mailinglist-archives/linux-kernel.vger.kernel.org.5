Return-Path: <linux-kernel+bounces-118581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09488BCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A52E2D56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E712E71;
	Tue, 26 Mar 2024 08:53:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24642575B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443209; cv=none; b=tXkfAbn5XaXLFcxibM1A7rsI9m1L/nnJOr7Q7kUOowB8QPIZ0dZL/eeUrxxzbxYaVvMKkygWQ63z/jQoa8+Zm4YuTGm+pMeVEAK28dGvj8Ukgkf7h6aWGV9mm8rACrUMtZq8wwOVkO4NROFgLoe12u+nN8Xl89KDm9yj9Wxebl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443209; c=relaxed/simple;
	bh=cep+87orsEIpv7eETMf7AOlb/aiXLpVpjY10V6SaqzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PagUN6CVn5LoE9t8K9cmwHJnf57tLKXOnU19XCuQvohUS7fECqwJKuaOtamB1LRpzRd1WrnMhUcSbfQVVNXq6bZpYjk1V67jYkXEqmVBbQkvIicfM+1RUqWgEIygd9z0ONOZfGRdhOuqhlNmWiiSok18/9XwWjOJZ6Dk4Y+YLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rp2YQ-0000nO-2v; Tue, 26 Mar 2024 09:53:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop2: Remove AR30 and AB30 format support
Date: Tue, 26 Mar 2024 09:53:08 +0100
Message-Id: <171144316040.1076426.18341528146329962592.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304100952.3592984-1-andyshrk@163.com>
References: <20240304100952.3592984-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 4 Mar 2024 18:09:52 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The Alpha blending for 30 bit RGB/BGR are not
> functioning properly for rk3568/rk3588, so remove
> it from the format list.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Remove AR30 and AB30 format support
      commit: 905f7d53a1bc105b22d9ffd03dc11b6b42ec6ba6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

