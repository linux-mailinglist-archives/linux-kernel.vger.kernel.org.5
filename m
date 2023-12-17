Return-Path: <linux-kernel+bounces-2810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC2816247
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13C4281013
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E4481DC;
	Sun, 17 Dec 2023 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSVU8scq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A945971
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A330C433C7;
	Sun, 17 Dec 2023 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702847169;
	bh=FEqWQOKEDrvpzw/e2igB/WDaW/GhDc1u0Hj1MEpXZno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSVU8scqdY5ObJ3ttzkHLGkVAUmIscqq3/S7S5ZASSO4FLKMTTnvYx/z2EWNjl8ON
	 kGuzk4MVnR0JNn6x8KMCz3zuaxFqrU6JkJYQbhffbuAZhRlm38aSgT8giEjefQudqk
	 nMdDFHPoryaLnip3ab9ngHQ17DPBqmPeyhX/BjHyS4A03eKTxo/SGQW+etvKFiO+Io
	 6/Z29+YGWfDc3SO0xD5/1GCxXictF+H9E6z+p6rcHndpgp7yv0akis9McWR+JLR1zT
	 SPmQHcNtU3tObTwSffH+wt9p8Rz7k4rqbMc1j4+u2/QAPPm++je9Snrrl+wvma1Ahl
	 CeR8k/ZkeCOSw==
From: Bjorn Andersson <andersson@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: defconfig: enable drivers for the Lenovo ThinkPad X13s
Date: Sun, 17 Dec 2023 15:06:05 -0600
Message-ID: <170284716296.78529.6640577574918372135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012080157.4616-1-johan+linaro@kernel.org>
References: <20231012080157.4616-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Oct 2023 10:01:55 +0200, Johan Hovold wrote:
> Enable some more drivers for Qualcomm sc8280xp based machines like the
> Lenovo ThinkPad X13s so that sound and EFI variables work with the
> defconfig.
> 
> Johan
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: defconfig: enable Qualcomm sc8280xp sound drivers
      commit: 223e8af324985de9e0b5b4cda2ec29783410f13f
[2/2] arm64: defconfig: enable Qualcomm UEFI Secure App driver
      commit: 48490899007ae98faf8a0071a602174502b8eefc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

