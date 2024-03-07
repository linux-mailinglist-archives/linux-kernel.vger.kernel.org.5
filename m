Return-Path: <linux-kernel+bounces-95332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94213874C65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B481C22D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC585280;
	Thu,  7 Mar 2024 10:31:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03B1CA84
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807482; cv=none; b=LNY0kvVrhMBOopbIl2DThG5QdGv5E7cl+bKTclnyIenBcDMGDhGmvPV+zYlpaojYWY9dc8oLKYFbXqN40BpkJuzqXKQ+7GEAO279nGUvDnHuY3/LHycorDGLs0bBTq1fvV49Zm+ln0wnshroXa/JNTR/4w6HzM6TMNxKAwZKG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807482; c=relaxed/simple;
	bh=kBs6qHhJ0G7M+CPsR37ZNywoGnTIbprhOR6e0TKJwxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oc/xy+TRiISeNY/Y1W5IBTrWh7hTG2cPd4yfbaLkWkoRt9XRGori6PcxDU+gXBiX/qRjLkz4tAyR72OMK3DVMNgZuYvFO+kR4L+uOVeehl/lW971FaSOyKnEB7/GWW8p5EY95SI1nTp2K7wkN8ptNYuNimN/ESzyJ4FDOq0DQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1riB1j-0002lJ-LP; Thu, 07 Mar 2024 11:31:03 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: rick.wertenbroek@heig-vd.ch, Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip: Fix typo in function names
Date: Thu, 07 Mar 2024 11:31:02 +0100
Message-ID: <13184309.nUPlyArG6x@diego>
In-Reply-To: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
References: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 7. M=E4rz 2024, 10:53:18 CET schrieb Rick Wertenbroek:
> Several functions had "rochchip" instead of "rockchip" in their name.
> Replace "rochchip" by "rockchip".
>=20
> Signed-off-By: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



