Return-Path: <linux-kernel+bounces-41860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C784083F8C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623841F225B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B27B4CDE0;
	Sun, 28 Jan 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEBq7nZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6204EB23;
	Sun, 28 Jan 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463973; cv=none; b=NAtk7VvKqe/mNdZ+41/POtatExCCDdEj/bnoHcVRm9LlrmVIOvhFLWtHc2cR46z85QyGuzD5CsWwDZGMG9DVJig6+bvtm6ZMJUJpqjQVEI4piHy5tUnKjQNqn3cuNPdtPr+0U3gioJOk8yOM1YeRUkBOKgl5Z+pHB4c8XLzgFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463973; c=relaxed/simple;
	bh=GeW2iZTyx8U6PVvy7n7jeCs4L2w5m4dx73ca22QZE+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR+HsZfEAqymCR9aUJma28gZ6L3gzpHQu76jO3dh2L2S/m6nHaGuiMlWoz7xDaVWlmhtICmhltuoNrcQLq1brLQl1SSwgRj5m/WPD/F4t8k4/YB3WYGt7w1yg19ey7iMthJ1d3XAmHpDs3xaSsdccXt/agNiS/vGj4280gzYcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEBq7nZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2293CC433C7;
	Sun, 28 Jan 2024 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463972;
	bh=GeW2iZTyx8U6PVvy7n7jeCs4L2w5m4dx73ca22QZE+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEBq7nZVC1z6qLOq/HaWHifYAGQV4Og+sjoYlQ17lPAmcA+DuaBBTlydB0T2wswor
	 T8apGDX24ehH3Knj+RTTJbR43SHq72irQRMdRPY8kQsZhZ0eLhR3CazPPLrl5OwaER
	 LQIWC//BNUGIMJUruuUGTR3qn6FE9xMCxgMJTcTUfpMeGb4t4eMyVjN440nVhvg8zV
	 tSGTwOLnNAk1EuTX/P0thySFEmmZhRg8nKf5aaSUpXB+56br//l0ZtKbYUcEDjEU6r
	 vpzs+btsbbd3rru5ilc9H/YClLJRTNpopy1Nfi4rQ7HAs23kcnRDyWCNmqHQqUDVTL
	 gKp4iWOVwbH0Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay
Date: Sun, 28 Jan 2024 11:45:55 -0600
Message-ID: <170646395036.64610.14333204830178417809.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Sep 2023 17:11:55 +0200, Stephan Gerhold wrote:
> Follow the example of the recently added apq8016-sbc-usb-host.dtso and
> convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be
> applied on top of the apq8016-sbc.dtb. This makes it more clear that
> this is not a special type of DB410c but just an addon board that can
> be added on top.
> 
> I also prepended a patch that cleans up the node names a bit.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
      commit: 0f893a2cb1ab7af6c88cfa1034debb6a790fb6c6
[2/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay
      commit: ea689ec32bf0d885277d3f58450a85df5149c98b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

