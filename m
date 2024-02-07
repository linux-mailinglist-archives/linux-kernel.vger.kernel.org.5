Return-Path: <linux-kernel+bounces-55942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BE84C3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5953B1F270A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34EC1C2B3;
	Wed,  7 Feb 2024 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7VWesWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23F15E97;
	Wed,  7 Feb 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281209; cv=none; b=KJKGAcVzWAp4XN0zSQfrAPk91JaB3H/Zr1rK8FjnYq6KZVnvRF9m87UoXtgp1Sl6vc9NUJLz6nMf1S1UvI/HiDtrY9+8nkstS3FvF7bnl6dmzSS39ZsrxJCf2GbQTQVPiHra2cQwX+CMds6AJRZPUbGPyob85NGChV71WFQJCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281209; c=relaxed/simple;
	bh=6fbZVOwABetUGb5a/NZQgm2JZ2KJdafRHvchKS6jNik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9uMUTUQo8r1RLuymM+BNTlRmSvI6WnLdOjUV5UGayVFp1yVnn/MhaoHRNg/PZkuX2CRqAG2rPi8XwCeAAWrAab2yfF2+gTnsivDqZ9jlBCa/dR1PpV9/ZUAdVu1PdzsgkiQ4/LBprunIrAv3NXy8ni59d1dUGxzco8VbSvMjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7VWesWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C9C433C7;
	Wed,  7 Feb 2024 04:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281208;
	bh=6fbZVOwABetUGb5a/NZQgm2JZ2KJdafRHvchKS6jNik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7VWesWN8Nok2/5ilyTyC6HsjhCmyShKiXN+dPs+bTVh/dxOqJT1TmZUJzbCiEjTs
	 ehdVE4duyiZRHGFteyY3kmfME7MbTJ5W6EgpepgGBqoyP7LcCtWWwVNMYhzEg06wXY
	 5jymxKh5Yjlz+8IKY5Widfcxmp6WIpmgWaiZoTI56Dzf0mzGDC0jUC43fYku7mjXAw
	 JG1/izIp4LkMCSXE77BsCasBqz978mUE9V2UshBTAhFqyiGo2WrsKrhCpmp/710eRb
	 X5mVdL1IUvvO+c3pZ7HUHtCAv3UGKdCwaBSvrhHOCC6PsgLNz3+jmBrhgRR9ASyVSA
	 DhRzFKn43sYlw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] arm64: dts: qcom: Add more support to X1E80100 base dtsi, CRD and QCP boards
Date: Tue,  6 Feb 2024 22:46:12 -0600
Message-ID: <170728117663.479358.15605215562911387052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jan 2024 12:00:11 +0200, Abel Vesa wrote:
> This patchset adds every node necessary for both the CRD and QCP to boot
> with PCIe, USB and embedded DisplayPort.
> 
> This patchset depends on the Disp CC and TCSR CC bindings.
> 
> 

Applied, thanks!

[01/11] arm64: dts: qcom: x1e80100: Add IPCC node
        commit: 6a07a4f3f509c370c4f2644c2f576d1e8029354c
[02/11] arm64: dts: qcom: x1e80100: Add SMP2P nodes
        commit: 0b6ae7364b1133f55eec027e358eec09d3bdc2ff
[03/11] arm64: dts: qcom: x1e80100: Add QMP AOSS node
        commit: 2661646f5934c9e6a4067ac325ef023eef611423
[04/11] arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes
        commit: 5f2a9cd4b1042ade3824cfe324aa02a3c17430a8
[05/11] arm64: dts: qcom: x1e80100: Add TCSR node
        commit: 8b6e2bf94b278c69746358425daae2a75041f7dc
[06/11] arm64: dts: qcom: x1e80100: Add USB nodes
        commit: 4af46b7bd66fa3ad9bd87e2ded26599d11562d52
[07/11] arm64: dts: qcom: x1e80100: Add PCIe nodes
        commit: 5eb83fc10289db0c13ceaea601151883c0da43f4
[08/11] arm64: dts: qcom: x1e80100: Add display nodes
        commit: 1940c25eaa63f65942e6149715e17a61438e2162
[09/11] arm64: dts: qcom: x1e80100-crd: Enable more support
        commit: d7e03cce0400cb42d79088a3bb0a59f63bdf50b3
[10/11] arm64: dts: qcom: x1e80100-qcp: Enable more support
        commit: f9a9c11471da32133ea6ee8763f932b91018e256
[11/11] arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
        commit: 7eac281cbedbd71d777eabca3a52d97983c61692

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

