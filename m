Return-Path: <linux-kernel+bounces-69467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A252A8589EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51E91C21873
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524F14D430;
	Fri, 16 Feb 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF3Y680+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D014C5B1;
	Fri, 16 Feb 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125059; cv=none; b=ZiMVXMdCLvWYSY5VFTqrcvq1nI/cJyKVLpQv/rV2298tNqkSybGZYKYleQVWMEzaRB4vg+MhmG08osLJLKNmEDKpyWk2WztTFGpJJxeiqXN21kPKfi6rieLwUfWHQIErAvmoLnWAUxddAFNd3BNYRoT8ge3sUYRnCSMyfn1XSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125059; c=relaxed/simple;
	bh=htT7sHbL8qUuTypciKRHHCC140E3Pxqzt02b5htuv9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTH+l1xh60YzGZ5O73+NMUmCT1m1PrF068P85h8JdNaGX6o3Hk56eDFA3W/NBUnaGeoVMlhiZ8MyGQr1ktMeDuJ1flmK2PkLsXtFw36jSUpqL+OoJettO49PASwM36ONze12LqK6EvhaaJP3a7v797H8eWJTzkayJQMugH874GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF3Y680+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59729C43143;
	Fri, 16 Feb 2024 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125058;
	bh=htT7sHbL8qUuTypciKRHHCC140E3Pxqzt02b5htuv9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WF3Y680+0Lh+CqETIhq2lRbbVTG/aRjIVZRVn+W7X8k32OgXyLjAYkmm6kYCLeUUz
	 8yngs1FpBa4m/IDBr6MnPL6IPwVmvMZv8VI98mDA5UQBY3sfjuuK7TGDbXoWLWzaML
	 O7rf8pn7pqzjYuXFkP8SGkvpLO87tk0fcVkfgzgIyZ1a5JRew91V9ySN1N/qCy0oZ7
	 Z9F5cuFPYUnA8+rS4iS9QlI4PlZuMbovpj87Y7GIZ5keq8PIFjSkfabZeAs7gpLeD1
	 T6Jv2lWTILZlOOSPuuBWcFcz+TQbZrffB1CGn+gOb8HBhBHj7SGjrJZEQKaF4s/KlS
	 Q1fU29zVGAjeg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8226: Add watchdog node
Date: Fri, 16 Feb 2024 17:10:41 -0600
Message-ID: <170812504015.18043.2294852608737825089.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214-msm8226-msm8974-watchdog-v2-1-a6b2f27a7e28@z3ntu.xyz>
References: <20240214-msm8226-msm8974-watchdog-v2-1-a6b2f27a7e28@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 14 Feb 2024 22:46:28 +0100, Luca Weiss wrote:
> Add watchdog for MSM8226 platform.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8226: Add watchdog node
      commit: 9e9c906ede3b7dcf7bf7df61ac712613c7d6c2da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

