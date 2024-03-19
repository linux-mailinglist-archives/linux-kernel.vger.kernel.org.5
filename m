Return-Path: <linux-kernel+bounces-106930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C387F59C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0E41F2214B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE97CF28;
	Tue, 19 Mar 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hczt2IN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6347C6DB;
	Tue, 19 Mar 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816536; cv=none; b=rs6rDz2Th7Fxj1FlBdte0UcdDkpfY/SRjCXHmj0tkUgunanYYdSE0PyiC+uDxViYC3emkjbVMS+/MwI9q00m9ApZWs729TXN0B20KuPZbk/MysJ8Akv7Xs7PMAOm1eiYm+Nm7dUYyFflw/pADGpfJ0aMSyklNMl2M1TqMt1YiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816536; c=relaxed/simple;
	bh=VMpm2c+NVqWWZRJh22+IiWz80+ulwqAxd/qXJog20Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSsLiMHRSD8SeJ92AtF04kWpTpeJs9yCTB96fsp450F1E+DRcFEGJAjF/YtWS99riDdGbY+owXK8JPoB/RPqVYdRonby8M+8Da/xK14KYWii7f5CW34JfIgCEj8+8RaWiDXn7oLzmVt2rvaBajKxiomY7vyiuTmk8g4ow3Wok+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hczt2IN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA5C43601;
	Tue, 19 Mar 2024 02:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816536;
	bh=VMpm2c+NVqWWZRJh22+IiWz80+ulwqAxd/qXJog20Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hczt2IN9fZzuhv9V/FSA3WcG56wYOsIvkfhIf83IF5l0nUN8IgCBPR1fIfTvw/zPh
	 r6BLzzTjEz4bM1Q6AB3Y0v+H2ZDlGITe/2Ijajj9ybAFinrEj9BX34uqj642Z6zgXp
	 N+uLlHLLEDnl9I2dm0EHxbeLWFriuvYy5DpR3g0kMbbl4klFcs4Ztw3DoOsnC3QOk0
	 nM20pkO0wEZS98ddxFi+5uTW7hQ6ON3ZmxCxeDjV8z3g1MnbFlQsFVQ90Rv9h6mSuy
	 ab1C/9hLM2gbyAThuAqww7vHPsf7g1u6qqDumLdDmx1MWtHC1cQMnWe6PgqStpWdgt
	 9zZspHpGtwuCQ==
From: Bjorn Andersson <andersson@kernel.org>
To: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Add QUP UART6 node
Date: Mon, 18 Mar 2024 21:48:28 -0500
Message-ID: <171081652655.198276.15270831465247977615.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229205426.232205-1-frut3k7@gmail.com>
References: <20240229205426.232205-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Feb 2024 21:54:16 +0100, Paweł Owoc wrote:
> Add node to support the QUP UART6 controller inside of IPQ8074.
> Used by some routers to communicate with a Bluetooth controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: Add QUP UART6 node
      commit: 08429b4ef46080c79534c4eee427ee2e6012877c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

