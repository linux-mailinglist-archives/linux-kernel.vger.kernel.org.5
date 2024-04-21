Return-Path: <linux-kernel+bounces-152637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ABE8AC1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F399B20A09
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057B46537;
	Sun, 21 Apr 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYsJhC/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146852F6F;
	Sun, 21 Apr 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738589; cv=none; b=dG1WUEsXCkbtMC66EWJxPhVcmHcQtmGJNs7eiYg8b8LCJ9f1W8PF9Rui+NfFosQPgXclXazRByVEtJwsYIwDoAMEV66Mpg2mFrjTsI8lQrkYNDqVZnR4RbtsNl6e0Ih42aRLmbINDJ/wBVCbRgB8VgS9hgiSL+Re4gEg6HPLxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738589; c=relaxed/simple;
	bh=olrsgF7Dn+ws60qlOgluTbXHbynaKtUWc/0LKSCam7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eovEcUnfu8KWPPL3ucOX2ZzkSCOZqAmKYlKbUmD2/hLCMhAYVRmfBKub5EPE0Qqu2IWIJqI1k0E/ErFtQyIkDaedZTtH4nysmhOCcj2GRVaIZImeub2wZRTa+1F//DhkfjEKpNvbXiFHx6OpYoJK6fRzDDMt09inFbK4EaTYljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYsJhC/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8606C2BD10;
	Sun, 21 Apr 2024 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738589;
	bh=olrsgF7Dn+ws60qlOgluTbXHbynaKtUWc/0LKSCam7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYsJhC/B3Sy6LsZxe8rh3Rdu6eEDM6KtEjOFHS4RH0T/kCyaZd9KwLaI8a3Om4Fu4
	 PpDzSQ+IoO2honKPS7aTZzAvxouzJ/nBCpy+6j3ImF7amznzZi9XwBRja6pVhHAeR7
	 Fixzi1bly5DBc8V5enobP0n3afz9l8JuY/QMjrkPQbh4fYWuZz0PPOnpNPaz3vbTcw
	 eTRDLe1D7pCdYJ/X0pCvETU4fMx3GogREYFL9gZYn5AEYksCql27olgJJ1hscIKHGJ
	 VUZ20OQdHleWveFilTFaBt5oh5hU6bmuXgEPlm2+F2m+/Zn/72lnq2SPsxHCKgFwBk
	 BanCGu93txfGg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_tsoni@quicinc.com,
	Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Enable various remoteprocs for qcm6490-idp and qcs6490-rb3gen2
Date: Sun, 21 Apr 2024 17:29:23 -0500
Message-ID: <171373856754.1196479.8348340567259271476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
References: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Apr 2024 17:39:26 +0530, Komal Bajaj wrote:
> Enable various applicable remoteproc nodes for qcm6490-idp
> and qcs6490-rb3gen2.
> 
> Firmwares are not shared at linux-firmware.git, it is under legal approval process.
> Meantime, submitting the DT node changes for FW for review.
> 
> --------
> Changes in v3:
> * Rebased on top of linux-next
> * Added firmware path for modem for rb3gen2 board for GPS usecase
> * Link to v2: https://lore.kernel.org/all/20240402090349.30172-1-quic_kbajaj@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
      commit: 99a1c9eedf6098826c0f9dcbda2c23e5dad20244
[2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
      commit: ac6d35b9b74c113753bd266e01d6b853618a1e37

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

