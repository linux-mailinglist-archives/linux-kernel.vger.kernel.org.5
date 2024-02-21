Return-Path: <linux-kernel+bounces-74786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E371B85D9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FD12833D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8D7E58F;
	Wed, 21 Feb 2024 13:24:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025A77655
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521871; cv=none; b=j8H4Y9I7PtymwP/M8aSqToChZermgupS0FQ/F0CFcqgxAQhZ0VArvIXeblLMscAapGvORMOY3U8z9wTi/xgAI+8AdeutGJSMqQNblG1nX1fRoAdXLHGtZX1eOuwfF4UGUCW2rkZQLxXsQdN6Mzdh1SXIgvI4OdsmVZanhZkHmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521871; c=relaxed/simple;
	bh=qEJkDHFlcaMCT3yh6MM8qc2RcuGT84nKmTLuSreRygo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKNQFd9xyQp0fCh1LSHj7DfUpXalwSXFL1U6rur2LNV+dyXydBS+3Uu0TaxXE/hd/XDmQP6P8Chn5WKxBYztDRhp3EGkFG20BW9P5h+OWgwpL/BuRMCjvNYoCAGSY7CA5oDosNrG0iXCfAa5wDI434/CdIxFod38So2fY9+p5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmaB-0002t3-7t; Wed, 21 Feb 2024 14:24:19 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcma8-00238N-Vr; Wed, 21 Feb 2024 14:24:16 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcma8-0009Is-2z;
	Wed, 21 Feb 2024 14:24:16 +0100
Message-ID: <13e6d73ec0db159e4f34b8dbc7c7305f0131db84.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] irqchip: Add StarFive external interrupt
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
	 <jack.zhu@starfivetech.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 21 Feb 2024 14:24:16 +0100
In-Reply-To: <20240221022647.5297-3-changhuang.liang@starfivetech.com>
References: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
	 <20240221022647.5297-3-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-02-20 at 18:26 -0800, Changhuang Liang wrote:
> Add StarFive external interrupt controller for JH8100 SoC.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

