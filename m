Return-Path: <linux-kernel+bounces-75733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4185EE28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4195C284232
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2585101F1;
	Thu, 22 Feb 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="lSE8qy8b"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD319F516;
	Thu, 22 Feb 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562289; cv=none; b=uxrKazymm+W/2dQYn5285JJ6N6K/oAjeTSbd6882Dli91lYCeldWD5H4TN/jMYxTsSAARFAY1m6AO+n/siJuMUaYQ1VaIT0wMSPGyNmEwNoMW4SEOBsMlUA8hhQfb2UHKuyJc/lpHNFVpw2aOdibxF5xUXl8o3QoCa6VeSOF/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562289; c=relaxed/simple;
	bh=/WaBnVmApAMNC9TJyt8WzAU6xorf2Zn0sOIoYNv1BUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POMsyRuXqMX2hwLUf8z9U9udYAPkBmbaSnJqvQ+GDjMaKpnmxkXK/fbEq54gEdexJ987V1MCC/sAMpgcih38BczqF7Rp8Prwyqa0FAue9YGzxKngdlWNmFJ/RUvMdpZ4HQTveZj/GZ9vN+a+yUE2e8OCdvCWQCzYKs7gBrNJz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=lSE8qy8b; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 00BB0C18E1A8;
	Wed, 21 Feb 2024 16:37:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 00BB0C18E1A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708562276;
	bh=/WaBnVmApAMNC9TJyt8WzAU6xorf2Zn0sOIoYNv1BUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSE8qy8bLzNBoj5sS3dbIWviWlGegkL2cnKpFvVdsjOWKsEYROESFs/6J8Q/EV21w
	 xnbcOkXcozq/YBb5j8H+Ey5Mj05BKGagnAJ85xgFXOfH/qzL/guy0jNKnLsqQr631e
	 d/s9Fb3OYifdznblLkcMRZkddNjcxmIvY9TFqBgo=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4D75F18041CAC4;
	Wed, 21 Feb 2024 16:37:54 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH v5 06/12] arm64: dts: broadcom: bcmbca: Update router boards
Date: Wed, 21 Feb 2024 16:37:55 -0800
Message-Id: <20240222003755.670359-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207202257.271784-7-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com> <20240207202257.271784-7-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Wed,  7 Feb 2024 12:22:51 -0800, William Zhang <william.zhang@broadcom.com> wrote:
> Enable the nand controller and add WP pin connection property in actual
> board dts as they are board level properties now that they are disabled
> and moved out from SoC dtsi.
> 
> Also remove the unnecessary brcm,nand-has-wp property from AC5300 board.
> This property is only needed for some old controller that this board
> does not apply.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

