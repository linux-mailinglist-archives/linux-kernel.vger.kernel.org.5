Return-Path: <linux-kernel+bounces-41859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4783F8C5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA3A1F2248B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE454EB47;
	Sun, 28 Jan 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVCyu27U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB54E1C5;
	Sun, 28 Jan 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463972; cv=none; b=jL6pIzhT14PjSvFrZ0bhdfJlya8JwrQPf/NBOwY1U/4yj6s9P06qAoEtr3y9/JKw0Q6apzGXBf+3qO/ro4Mr8pv12bAeLR/anYdnddWCJvs6vkK8ZfVC7SLHoQPtF0j7oof4PKD4/MBt1Ja5fEsWJrqgNDIHHRhrQASFK1XmgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463972; c=relaxed/simple;
	bh=udHoe7X6stkdmI2HgOE/k4D4U6BdSRfFo1zqaoAHxl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gC4BgqsefN3UE9Hif8P8897EL1TQj9qc89tHSF+uJDnBaytEQt3khCBEIE4NUujOivj7k4kXBykxPkFh3ksAceQ7iPCWmiX/Nah7W3FQ4xdK92M+9EAfBZ+BPRM4AtNsXklO1bZuU2tE3CvHrrBc1uld0A/ms2ATmcHyVSSUhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVCyu27U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4CDC43399;
	Sun, 28 Jan 2024 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463971;
	bh=udHoe7X6stkdmI2HgOE/k4D4U6BdSRfFo1zqaoAHxl0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rVCyu27Uyci6xi3ZxLfETZLmflVkGHzTWICIn+ap17lztS0XfVqbfNLehgCKlHlpp
	 1IvL2VPRyHWs1LyZNsv/dA+36K2uCp/cmdL8Gg5wDjtq+o8RR2asgZo2Ec1qMbk9Ea
	 FjwXPE0g8I37SUEsRbFJLbhHFsN6dXW1eqwqF8m3bmrNdIXVuqToilzMNN9Vp1O69P
	 Ho+AO11KNEex44eqsJZkYw+XKFpcy8XS21s9YyCGLrP6aJeLHYTUR8kx2ElmES3mic
	 NmtUyS7VpY8bfH/fTYnG27V7kFFVkzKeJ7nmqteN5JmlXetxeFaLcBj3xmaHd3Z3em
	 2z2AWBcF/TPPQ==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: ipq4019-ap.dk01.1: use existing labels for nodes
Date: Sun, 28 Jan 2024 11:45:54 -0600
Message-ID: <170646395034.64610.3948006426118965763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230811210142.403160-1-robimarko@gmail.com>
References: <20230811210142.403160-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 11 Aug 2023 23:01:02 +0200, Robert Marko wrote:
> All of the nodes under soc already have existing labels so use those
> instead.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: ipq4019-ap.dk01.1: use existing labels for nodes
      commit: 54850df251cb88ba9a32b6371c8cd5908efa3ec6
[2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node with bindings
      commit: 111bc3710caa7e55bc0040ffa57cec83e09dac07

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

