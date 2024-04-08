Return-Path: <linux-kernel+bounces-134712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803989B5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA29B1C20DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AF74A2F;
	Mon,  8 Apr 2024 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw31DAgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3731869;
	Mon,  8 Apr 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542644; cv=none; b=MEvqzDIvcSyRNvUW010O7UCwELqvZ4E1AA1hFowZ7B8ky0tIjBBpcCG0qkftFL7kt7JkdYwrXA9oMX5gRgwxU2wfV0Y2fDHIxpGA5S1wsagtbEkuVocxtnv2dOsCwXJuy+AG544Vcz7BJ7J+9tmw4mu31WVNNkyQSeoIthblVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542644; c=relaxed/simple;
	bh=WtDgvDlc+GbWPmB0QumOcolOX2UmdmYlul8RYNISVpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shNQm0AHHKmu/PEShUjP++saPknjB1lPPuqoLtc1MCLPh4txnfHnEc0AnZ6PSKfr2tZkxfGzspKvfkQ1KBCBaSLpEtffEFfUEdbT6Ns3GN4vBXpxE/T658HujGaYFw05UR9LxX9r1TK0xzWTNr2I+AtCmtpQZn5KNAHcHmssEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw31DAgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A4C43399;
	Mon,  8 Apr 2024 02:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712542644;
	bh=WtDgvDlc+GbWPmB0QumOcolOX2UmdmYlul8RYNISVpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw31DAgPanrT9nhvRsg0hn1X2EkGJU3ITfExpWCi7zbB1Vz2IQLY9JHisrUjk+Wkt
	 q3DC1/JfrfkoifnpctylGBu/v5gHEK4XwPb8K3JKDrywovGGWou2vznQBS9MtSwFyN
	 LDWCu2QBaxNknniJUBW8JcKf+bYot2fTkHalxl3Yfltp9lydflvtixF1/da+OaYPTV
	 il0ESQRwU+NHBUbAbTTMIzbY8tfLTVofP+N/R6ciq3/EDOkX9lRNaSvP+sSyhX/DZc
	 wfFDU2SOoM+3iZ93ZBRc1uIIJFNid0MwRcndz1S8aIsUrglwiOpj4Tv2M6t/1joSli
	 Wn47U3+ZUTgig==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: Fix the msi-map entries
Date: Sun,  7 Apr 2024 21:17:20 -0500
Message-ID: <171254262026.648987.5589442883549909128.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
References: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Mar 2024 12:49:02 +0530, Manivannan Sadhasivam wrote:
> While adding the GIC ITS MSI support, it was found that the msi-map entries
> needed to be swapped to receive MSIs from the endpoint.
> 
> But later it was identified that the swapping was needed due to a bug in
> the Qualcomm PCIe controller driver. And since the bug is now fixed with
> commit bf79e33cdd89 ("PCI: qcom: Enable BDF to SID translation properly"),
> let's fix the msi-map entries also to reflect the actual mapping in the
> hardware.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8450: Fix the msi-map entries
      commit: d6c0602429490ff90d3f79a431aec1be779650b7
[2/3] arm64: dts: qcom: sm8550: Fix the msi-map entries
      commit: 398b7c7dda6792c2646a2208a6cbab02da97d6e5
[3/3] arm64: dts: qcom: sm8650: Fix the msi-map entries
      commit: 3ac680a514b6e63428481b1e6fb069383e5b7add

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

