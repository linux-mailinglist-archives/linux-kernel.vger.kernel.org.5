Return-Path: <linux-kernel+bounces-69460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287C8589D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AD21C238EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99681487ED;
	Fri, 16 Feb 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPcOPUlX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB41487D8;
	Fri, 16 Feb 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125049; cv=none; b=QI/CGXHC0vJTYRvDN4/DRcjlMS3q7zgIynRIDKBLV70A8M/l5Bob0xaPIGuQc/fge4PfMl+nJDgHOvQfqXFZOT8A/DQ+uYB+jWHixKzdapFmfYRBPo6d6RVq4XoRlscRWYVqdfKFZ7TYM+D1suw0tbTe5t+piw6xv/4fw/m1xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125049; c=relaxed/simple;
	bh=O1OpOHiJH5zAid7vlc60M8xCXnRul9XZwxmxl+Zq6Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3KWh+IXFFNrVVVuGtPEIIZwFgjjIOKWXtKvvtvD7Kom8WiwEBX+kyjh4qiG4w5CohQgBUJFQHcI87sVfoLjuBEPFkTpyM7zMfzle+a2G+lQIbtGloaCWrtd5tfO0GmfQACvs8nC3cKX2dJOveBhyZkTVfVHpW5vKMWXshCYXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPcOPUlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A1AC433C7;
	Fri, 16 Feb 2024 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125048;
	bh=O1OpOHiJH5zAid7vlc60M8xCXnRul9XZwxmxl+Zq6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPcOPUlXdd4/uI8/7fckkIg397L0BJnmzQRmWSzBrvenU4JTuB7fEicErRN0Bk1k4
	 WxYRfc0oYGAvgRG5kk22ltJnpDd2vCs/ZrITRhNYPK+2jyQt8cQI3TcvtJji52K2aA
	 zcEhdyY5K9ceUKNBfivobZGTLTl2D8j1HOavGxbzrj0kB+5kOd3RizYAKhYMtIlSrO
	 QAif2aWB1WhTfMSR8ddjxMkV71YLko8cNZdHpqbsl+FEoFH6NmWPEd4500dbgzrYEO
	 CAtJBaAEFcdP4p9LTIjH1H2m3Le8zXqWB72EVGsEppBvlolNjNUvWiipydf+usjEhM
	 chfFn6ayt4wzg==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v7 00/22] soc: qcom: spm: add support for SPM regulator
Date: Fri, 16 Feb 2024 17:10:34 -0600
Message-ID: <170812504022.18043.16483839903637850626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 07:17:20 +0200, Dmitry Baryshkov wrote:
> The apq8064 rework to use cacheinfo takes more than expected, so I've
> spanwed this series. It is an excerpt of the APQ8064 cpufreq series
> [1], so it it continues the version numbering for those patches.
> 
> The Subsystem Power Manager (SPM) / SPM AutoVoltageScaling Wrapper2
> (SAW2) are hardware blocks used on some of Qualcomm platforms to handle
> the voltage rails. It does this by bypassing RPM and directly
> interfacing the PMIC. Extend current SPM driver to export this
> regulator.
> 
> [...]

Applied, thanks!

[01/22] dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
        commit: c9491a16e571d7f33e1d00d1ec4ce9b035bb290c
[02/22] dt-bindings: soc: qcom: qcom,saw2: add missing compatible strings
        commit: 31ac56a59e7a8ed4ccd4831b73a1cc1ad9653b7f
[03/22] dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
        commit: aa4e327fbbf665e96701fa1f53a97ae86b646603
[04/22] soc: qcom: spm: remove driver-internal structures from the driver API
        commit: 57e2b067f19b8de616d1e849ce3786df602bfe7f
[05/22] soc: qcom: spm: add support for voltage regulator
        commit: 6496dba142f4461360cae263126965e4ac761ab9
[06/22] ARM: dts: qcom: apq8084: use new compat string for L2 SAW2 unit
        commit: 551d90275631a7dd2d290aa60aedabc597029216
[07/22] ARM: dts: qcom: msm8974: use new compat string for L2 SAW2 unit
        commit: c0fe5442b1e5bcfbfe5272896e4dab23e1dfcc19
[08/22] ARM: dts: qcom: msm8960: use SoC-specific compatibles for SAW2 devices
        commit: 9f77f78bd420ffddafe8c019c9e94097ef32c4d6
[09/22] ARM: dts: qcom: ipq4019: use SoC-specific compatibles for SAW2 devices
        commit: 8cad85bfe08f419ea57a8a395e4ab0dcf346d617
[10/22] ARM: dts: qcom: ipq8064: use SoC-specific compatibles for SAW2 devices
        commit: e6e2986a3d57a4d6590c3654d64cd417585c1c66
[11/22] ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
        commit: 3a3b949fd9555190f2a477271b79e6194f0a824b
[12/22] ARM: dts: qcom: apq8084: rename SAW nodes to power-manager
        commit: 07eb49b318000f8953c3de73f400b799215d6a32
[13/22] ARM: dts: qcom: msm8960: rename SAW nodes to power-manager
        commit: 34725e24f20d98a9bba2850934c2adef65b9ec0e
[14/22] ARM: dts: qcom: msm8974: rename SAW nodes to power-manager
        commit: e624dc495a425dc0598688c8c1aa5c028ca30750
[15/22] ARM: dts: qcom: ipq4019: rename SAW nodes to power-manager
        commit: 3ea06103ee40351dc4793e37c0e51e00753e3d26
[16/22] ARM: dts: qcom: ipq8064: rename SAW nodes to power-manager
        commit: 04e354e0b4dd409298c1909fdd8897055e9b3641
[17/22] ARM: dts: qcom: apq8064: declare SAW2 regulators
        commit: 893768803fa4ab7e5d75448980832b517d251a25
[18/22] ARM: dts: qcom: msm8960: declare SAW2 regulators
        commit: 378cc1b3e6cd3cab1f8c4a5e1891664545c2c7e9
[19/22] ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
        commit: 8c843db2bca12e911e0d0343c52a9e9a17704ae3
[20/22] ARM: dts: qcom: msm8974: drop 'regulator' property from SAW2 device
        commit: a560ff0acc0418e3c689ca2b050e00f964020b14
[21/22] ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
        commit: c169576dddff63be2108cb289a9ab1b7fc19ef53
[22/22] ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices
        commit: 4ad2506d5a17387dcbedbd24e60d33f6421e249e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

