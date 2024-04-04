Return-Path: <linux-kernel+bounces-132153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EED899054
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C06428175C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8913D897;
	Thu,  4 Apr 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5ah/ndF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0913D638;
	Thu,  4 Apr 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265824; cv=none; b=U1Bh3VLkFdmSRyJyIAqicLRqv8HpqI+zV7sODR/CczUpZjK9P12lX8+Ft6tQEwUgTl4fjNVAHQQwbr8M+75h7kFX/SgfUjK2nkQe0KdC2jetL66/EkrsMBaTYlKY2LweBuxgs24G//H1PwPGRvXWFEDYqZVskL41MbtHE9595uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265824; c=relaxed/simple;
	bh=Wbdeo+s4154KEaKj5Vf+kpD1zfitTZU/LXo4NRc18D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChTyS2BwUSG45+pc/q+FNvKJr3YwhJg7VFZY9yTHbkHov4QaCLVaOTUVNYFXp6Re6XoCa9WQlNpSKbx9DIMAWEegktbygMDGoDaimGKHH+GpdiAGruOtTCZJH8uJsVMQf2yje/EwkhpMqNYkRqYyGdabROYJMe0xgkRCa6YoTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5ah/ndF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B2DC433C7;
	Thu,  4 Apr 2024 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265824;
	bh=Wbdeo+s4154KEaKj5Vf+kpD1zfitTZU/LXo4NRc18D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5ah/ndFTWRz5bJkaPMXLEpVZ3oAKH30DOJCfQMKd5h3O5B9kmUMsapPtb4Ng0FLI
	 cKa73+munUO7DTAsAn93C2TRXcnumz1EC9GH10000udmKgdyKvB2MepY6cZY9Qt6kf
	 nRth7ZU1Jn+JCbFjpmDHRgklMzMPSZmeeXEuPLdMv7z+iqOOkPH11pLKL4RxzJLtXf
	 eYaLyHNpXSZHu+oC7mwz0M3n77yRKina8F3petnOryKSPiI8Kdzap2sr1Ss7eK/rpw
	 0R1GBVU7vVFV/pMru0LXYNuOYstLxyrNdeKYnLAuLTdDZLDj8qhDhcZubgcQ4+FjjA
	 +0SRk+yzbfPBw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Disable DCC node by default
Date: Thu,  4 Apr 2024 16:23:09 -0500
Message-ID: <171226578671.615813.645518681165391356.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229013503.483651-1-swboyd@chromium.org>
References: <20240229013503.483651-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 28 Feb 2024 17:35:01 -0800, Stephen Boyd wrote:
> We don't use this device on Trogdor boards. If we did, it would be
> enabled in the sc7180-trogdor.dtsi file. Let's disable this here so that
> boards with t he sc7180 SoC can decide to enable or disable this device.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Disable DCC node by default
      commit: 9f618cdce29d7bef10c2f4c8cbf58bc5cb778d6a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

