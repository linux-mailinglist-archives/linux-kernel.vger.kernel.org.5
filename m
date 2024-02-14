Return-Path: <linux-kernel+bounces-65757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B1855138
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAAE1C292D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2612F594;
	Wed, 14 Feb 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK9CKoh3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28212DDB9;
	Wed, 14 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933491; cv=none; b=EpfSg4LQ8/hwOhpclar5plqORiIOKmhJJX5jCaM/nJqRaOLf1KWvadnkoLLLRYmTkE1U79Kn7tgsmJnYaJ/Id+68lyzTB1XO1IA0RarHust1CqgDY1XuWkWmc0He/UkUPiGcQyfuhNC2cV+9cRlXnSA8Sz5clXzDosMjAPhab0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933491; c=relaxed/simple;
	bh=lainH4+fT3LkrZck9TWGdKri7vzk4EHpYtEjsHflg/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqVn0IV3hixTS19lLPDkAyLvGFrGuDajY7EiID8p1qn1h8Og+mTh6+JDfiugwtzApVMZhvWaLWo53QgLSstiS3yVvUSHAnBMfTB0FTUDt+NfbUuku9XNrIMxAxqpniKSRWprrgvsvMgYnkpqvkVxSSDmNA1X4wBp+9MRT1EWYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK9CKoh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A3C433F1;
	Wed, 14 Feb 2024 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933490;
	bh=lainH4+fT3LkrZck9TWGdKri7vzk4EHpYtEjsHflg/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK9CKoh3e51oHR4K6ygIKvRxQ6tKiCIU0syqurxHo5aV/51sgqv7M3j1OGuZK+F6k
	 9lZ8u8xUXt8B9Z6ahjjbf55nLgN1uKyltldJsvhbnvkSw3p/82fSMZPpyX3CcafznF
	 G8NfeSUoqGjEaWbuyZpWxBRXCzDkl7O023GyFE8QoG6uKigrvkdQPfqDvxcR3/5aIU
	 53sLA0joLwBUOzVZt+rD+FWkd20EWtwkTx37QXMeSGFZzfa79UDTp5hA+H87Ow7hmm
	 UFr8NOIvcoQDg4XttiWhoNmjdDYz8SUd5ZmtUsOF+P5Q/InNzJy/WHUZLbJSk3XioC
	 jw6gHY5krO1SQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable GCC and interconnect for QDU1000/QRU1000
Date: Wed, 14 Feb 2024 11:57:38 -0600
Message-ID: <170793345822.27225.4479785108702422116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213095459.18402-1-quic_kbajaj@quicinc.com>
References: <20240213095459.18402-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 15:24:59 +0530, Komal Bajaj wrote:
> Add the QDU1000/QRU1000 GCC and interconnect drivers as built-in.
> These are necessary for the Qualcomm QDU1000/QRU1000 platform to boot
> to shell.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable GCC and interconnect for QDU1000/QRU1000
      commit: 0b76fc39b7d8ad012a6ae2e39094ca7cf00c33dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

