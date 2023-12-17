Return-Path: <linux-kernel+bounces-2789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F68161E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8F51C2207B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787DD481B9;
	Sun, 17 Dec 2023 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIy5gh//"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E5481A0;
	Sun, 17 Dec 2023 19:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6DC433C7;
	Sun, 17 Dec 2023 19:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702843173;
	bh=qy8668IHMiBnsf/vjnuSRDLSJJimOnnJOAjf1zI6zZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIy5gh//oidfPpzTcjRhQCDJfCx6zmRrbV724Eiur2cP8EUsQkW7Nq///EPE009dp
	 UjRnRepNzhiaigR8itqQn26vSyIsF+UEeC3/nQRVsgY0Y12KEerbx7ENlih9p6UZL0
	 j35PRwWWs1GpNDhIWLhEGMsuo5K6n0PWdxnGhCW72TK0z/YSnfuVBC0uUuGIWjUMbr
	 YKtT59SlO7u51i9159IbrEKqj5HrQBX6Uh+4xrFZssSFwhzjKEh9qEsFzbg1DsHlVG
	 AWMOUsLKhVbDVEUF91cgoaue110Q/pWx5JZSHthdZ+lWU28/3WhCzpkt0AC6q7+A2T
	 OoVy+pqS+0OrQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/11] Remoteprocs (ADSP, CDSP, WPSS) for SC7280
Date: Sun, 17 Dec 2023 12:03:54 -0800
Message-ID: <170284338637.3551047.8886362127846527500.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
References: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Dec 2023 16:07:56 +0100, Luca Weiss wrote:
> This series adds support for the ADSP, CDSP and WPSS remoteprocs found
> on SC7280. And finally enable them and WiFi on the QCM6490-based
> Fairphone 5 smartphone.
> 
> The first two patches are fixes for the MPSS to fix some dt validation
> issues. They're included in this series to avoid conflicts with the
> later patches and keep it simpler.
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280 MPSS PD-names
        commit: 9d598fab9731055638c6e9333c4f21aa0d174a48
[05/11] dt-bindings: remoteproc: qcom: sc7180-pas: Add SC7280 compatibles
        commit: 11eff1020440060c53d2261531432927c9fb4ee3
[06/11] remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS
        commit: 300ed425dfa99f6926299ec196a1eedf05f47b21

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

