Return-Path: <linux-kernel+bounces-132150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8589904B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4424B2430A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5A13D516;
	Thu,  4 Apr 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPUp4cQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7313D506;
	Thu,  4 Apr 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265821; cv=none; b=UPELj1VzsoglmdDgIF0K6UETH6iIYvbpZT0VAKeQ0XlIjmijlqiXF0khINCghPcz46dAOxGQjTC8gVmq7ckz02bQtOGk3FCeXrjHZmTRroTUVojU4wdrvCm4HZUbgawsF0FnWUJJdh/aPM0kG4rwtD6U8BwVCiNvIACDjljrbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265821; c=relaxed/simple;
	bh=/eo2ZVd98pAv/lB35hy8h+M8rr2wAoym77YV4GsnpLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDRdG2UhMs27sjCfrvJb/tMnEAwfIORRVOS8J+2u69iMXNJbPXv3YrbB5E3BXut+IslYHaN0lckZE84uZejORXYJUsDslq5MFI/l0fVEdP5rWnEMqAnjvtxq7Lb1cTgctZoSNamgPKSJDqEayza5H07s9KB94mDkCRKWgAtBwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPUp4cQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDC5C433F1;
	Thu,  4 Apr 2024 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265820;
	bh=/eo2ZVd98pAv/lB35hy8h+M8rr2wAoym77YV4GsnpLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPUp4cQ24jSABpcBto8bjFxv2iQ56bWTx/65Rsdl1PiiTLx49kgqyxV1AHGjjdi8N
	 yK1PCC3pT3e6RTz0mqTf9KeSrQNJcUt/O8t6s/XiSn27/1T4M4RX5NDqNzIQkbqQ09
	 W/oL1AQgVCguZXXyNCVlut9XNWGYrQLmPDfLI3K09H4ZHqvXsgt0QGk394/gmZmiiO
	 ef5FATnyNbJfdhlC4fWs8dZ5FGprY2rejpgsNUlgD7l88vPL8w9uBDHsakGtuKA4mC
	 LN+I6SiVO2NQzsQ8XuZNxX8g4GHkbYvqkPzc1kMmnV1r+vCKLoH0+jmLKRDIHyj7ZE
	 DoM2Gfcm6IF4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
Date: Thu,  4 Apr 2024 16:23:06 -0500
Message-ID: <171226578698.615813.14767718222160658348.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-rb3gen2-ufs-v2-1-3de6b5dd78dd@quicinc.com>
References: <20240327-rb3gen2-ufs-v2-1-3de6b5dd78dd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Mar 2024 19:01:13 -0700, Bjorn Andersson wrote:
> The rb3gen2 has UFS memory, adjust the necessary supply voltage and add
> the controller and phy nodes to enable this.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
      commit: 58dc9622d5de6ce0b80969b136e8e09a7645eca5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

