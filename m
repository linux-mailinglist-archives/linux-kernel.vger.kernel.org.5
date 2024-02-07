Return-Path: <linux-kernel+bounces-55943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B884C3D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC5B253BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAB1CD3C;
	Wed,  7 Feb 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJe3/qHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAB1CD1F;
	Wed,  7 Feb 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281210; cv=none; b=l9PCYTnRLKZqS7sjqfAG2kLNwZRH3uJhTGvgdb/+vTThfPvrSHwkiL9v0MivoZVD7dtJTslK1y2mRGa1mqSkCOZCxjaxsvgb/u2K4h3YkfOGhyRIwZxDmys9eVZG6ZHZDLjEboJr2U73trTzc/yq516VrnDkmLJBLQh7DdGoVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281210; c=relaxed/simple;
	bh=jfBEI9izQ/4StDHOizecRZUt87ar8+s3N5lEcZ/oTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oefy3bfYQgK5SSHNQFHg4EIwCidtUNpIYJUHiPpvvIBJCb1/DYXhoShYAeRR2EmGUm0WFh3IpzsixZ28dIyiIK9s84i77w6lpMtAB7kBJ9C+o2AgbFqVUZgPjF2y7jHJXuFSrqhP6OperMDN7uN0gUX2FRks4gSzqjUNxytN0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJe3/qHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E35C43399;
	Wed,  7 Feb 2024 04:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281210;
	bh=jfBEI9izQ/4StDHOizecRZUt87ar8+s3N5lEcZ/oTig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJe3/qHGEnYEVpaK/oayG8DLA3YUPvYmgMa+dAdFl69+45BnTN6PPT2vlzEPE4Mgl
	 Dkmz3AvksHGByqPb8k6ji51WmiT6OPz2GJmZwmBJRvQz8qSb09B41UY+YtxuWoQUap
	 m8Ph1NkfWhJYMdiuu8zeFtg8jVPZJZG07SYCXlJFQC6x3LkxJFg0sTqqBPyksZCleN
	 QOqZ5JZlKEPLS9j940zoFBJI6sYZvsX/obUU/6A/bjlfWuBSYnZUz7ePuFr9sn3R14
	 fhHtrColhKeRU1I4/zdmfXL7K4oYaZGf2OM2WkLI20E6Vnf9ciUTK8yWvjLsqAPrgM
	 sDHNuCwuZg5HQ==
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
Subject: Re: [PATCH v6 00/11] arm64: dts: qcom: Add more support to X1E80100 base dtsi, CRD and QCP boards
Date: Tue,  6 Feb 2024 22:46:13 -0600
Message-ID: <170728117668.479358.10402005735189028817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
References: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 29 Jan 2024 14:45:32 +0200, Abel Vesa wrote:
> This patchset adds every node necessary for both the CRD and QCP to boot
> with PCIe, USB and embedded DisplayPort.
> 
> This patchset depends on the Disp CC and TCSR CC bindings:
> https://lore.kernel.org/all/20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org/
> 
> 
> [...]

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

