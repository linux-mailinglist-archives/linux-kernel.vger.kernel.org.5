Return-Path: <linux-kernel+bounces-141478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8308A1EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F41F2A27A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74C3E462;
	Thu, 11 Apr 2024 18:30:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57896FCC;
	Thu, 11 Apr 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860228; cv=none; b=SvdHKNYpmD58KRuHITY7C3uZI20+fKUDgulisjrOsxEkVLot4QeawgzEBaJdZ9hcYPVvG0JKiJGFrDpXDPQYfmvWrjsaCW4scuBF5i9095rSFSEpS13xpc+ZF2EHGBjsR8s78uFcgKmiNJ7qDHshjSDf3i/UycmyIkYf+k1woiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860228; c=relaxed/simple;
	bh=4xKizWaImvpEfRZO1V8w4R7fh2e28QmzQEfkzm9jmsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noaWx9E0Vd0mU0D/s7vhxweFQHdlccaCRHtQ+Po7qZLmUO8VT0sOcbCupb81n21Bk0foJh60nNtdpOkJ+jqZoaNlnlbZE1RvN8b52R8hxhDjK8DmTuJiiai3zwfPOAl8SDeYAks8vCbmNi1AALRvmk33QSdEu2GiZLpTNUAZTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-67.ptr.icomera.net ([185.104.138.67] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruzBf-0001so-KS; Thu, 11 Apr 2024 20:30:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: david@ixit.cz,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	cristian.ciocaltea@collabora.com,
	linux-rockchip@lists.infradead.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro
Date: Thu, 11 Apr 2024 20:29:51 +0200
Message-Id: <171286007462.1886699.13358284260488650181.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305143222.189413-1-jtornosm@redhat.com>
References: <20240305143222.189413-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 5 Mar 2024 15:32:18 +0100, Jose Ignacio Tornos Martinez wrote:
> With default dts configuration for BPI-R2Pro, the regulator for sd card is
> powered off when reboot is commanded, and the only solution to detect the
> sd card again, and therefore, allow rebooting from there, is to do a
> hardware reset.
> 
> Configure the regulator for sd to be always on for BPI-R2Pro in order to
> avoid this issue.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro
      commit: 433d54818f64a2fe0562f8c04c7a81f562368515

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

