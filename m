Return-Path: <linux-kernel+bounces-64011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F848538F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0432C1C267C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB3604D1;
	Tue, 13 Feb 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="o8Nj47xp"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0F5FF08;
	Tue, 13 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846630; cv=none; b=FtfTQq/ZGMgcz2OIcU8JboQdYKPAtxHMcc84MJj0de6gtCqYA7Nt0Dn88zoWI3Vfr55eJSqQ6cghFsHwe1zPrTCCbZiOU7da1n5ZxtnuqBDAovFfr9zPk9peKeSAR4oy6L/qqB8ZewmES50rHW6V3YPIuz0xt2Id+K4/lX9BS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846630; c=relaxed/simple;
	bh=Z2v6JGqCm50Cs7heCO5mmVfihgm9IBUemPTwI+gQtHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMFzmfgayOy6iKPiuTma29dw1ksCclz5PzQWQwViMaZgHlQ7Uv/IRcf1SH3R/NJiBU1GwLdNQLMX7fw4Soqe6S1K2JOQ3Hr/zDp7bq3d9rdbsGgSuWl7f1J81pp1Cx1Qyp+9CPXcqiCItX7vBhFEnKvY1bMdiXluCG/iG46qAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=o8Nj47xp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707846616; x=1708451416; i=wahrenst@gmx.net;
	bh=Z2v6JGqCm50Cs7heCO5mmVfihgm9IBUemPTwI+gQtHc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=o8Nj47xprO7JzvNpFp8Qh/Tt/2xD29REfdkhcLW3LglxPNdDQkYKqxmSAxNnNXfx
	 yq7cZP2TtpXoaaOBvdowQUYNmGdffC7qa5fHwX8a6zaZ5HxxRBbKAz+a8PEb0EyH3
	 1VHNVZsXy2QX98WDDwlhxHzE7RiP6oUCXqf0mWtt/dCKjt2NSoc93DkzfK8UE/+vK
	 MVadMoHPf3gHE2bP0x4vkvhTIsCQDqnxDxKuH5LW15A11yc02/0SGLGyUd6+VKASg
	 XTKEqy4IZs+3OCjpDp5DT1UvGZSCRrhuoGawq39VujQGy/1AlkubINmbGq3MdjsDc
	 OCMDB7w2zHdM7hF9gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1qgK453Hhq-00tier; Tue, 13
 Feb 2024 18:50:15 +0100
Message-ID: <95d56903-7893-4a12-a451-f1bcc1d5316e@gmx.net>
Date: Tue, 13 Feb 2024 18:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] ARM: dts: imx6ull-uti260b: Add board
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-18-sre@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240213010347.1075251-18-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nGPV/9A2970hb7rXmUZE6Jp+por/U2rqq2yjDR+mGXU9TOetXzV
 RRBdu07Ao5WXVF2gtPstOXmaiGRmHKF29VNw4e+Ww0RxfDOikuDs1Tp0ZPP38s9xfU3m1GX
 J+rMa50409QHCfoDWNn75E+g2Fhs5/mB722Uw+scyp3VrEwWvNx4y56ND15WvYu2lt/UDTE
 zqkWjkPUggtwalYOEtJEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AidHz1kBfT4=;rmh//cTf7dE7bIkfBFcQuoiMUuz
 odC7hu9oKns99OULhgQvW6nJ085KGGuobhxEE/c37TqAH89BjDOBbFjSDA9Grv4UDR+y3yiWq
 9PSVuPwXrIC264CJxqsQZHCaJmt1+/p8STmMvewUKRXtesO6XfGdTHUXbFw27nj3+/H3rmSLi
 GN390NI+s3ShGEIEXVkLlLuE1szWm8znesZSp2d3OJpzzS5u/RSPPD2V5yI6ItVX/Xqh3Va5t
 1K+CdF/eoLCgfAMu5hyA/WFQ1bDBPlS1hrv8OulNGi+aaFLhWe2W3K0+ODlqyLWsLjTRXW6AK
 vUIxwjJS44RgcLwTxGerzf4ReXlJ1Hc7gVVhwoJygMR0/wgLO9mmN+TIB16cFzj63uJs8hvyh
 FlxqKEn3VstidSgRlzjufAnNGkCXwvWhpRTzERR6uECjhuWh+ZCsorUq2yUxvDG5MCpiOGIAm
 x9q5G95RzpPDTexjMiU8S4c/WiyA5+UCa9XjWRiAcLezSQdkGnd9vDZzuoDS42VZgwf4S0/Se
 l/jtJmf3LgPDO4v4WmZPiTa3qjd+ssa25PhrR0kVs4UFiieYBbPGVFnROngXcSLEVx6NgONXA
 RgTlF45RbDHBLsQZuPv0a4WY3aNL/jx6TBnF8djVTh2agVIPLoSurhXdlahpvybAT2g8jY8uD
 RJTNjq8mX6SBlPjEmRDnfCyOASFUCR5ubdM5e1H990ZWSgSQt7d1980Hn+S2+aO6NiMrTjYMG
 kXAi5FyWNuqJ6P3C+bBEE0ZClPESkfXYjy/AxMqMry8Tk5Vw1PzS3rASPw0PgepMNp+gt9Sov
 im6hzTJCKtnsUafDHqehf2qDDMRJErTNuILNvjBztehPQ=

Am 13.02.24 um 02:01 schrieb Sebastian Reichel:
> Add UNI-T UTi260b thermal camera board.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

