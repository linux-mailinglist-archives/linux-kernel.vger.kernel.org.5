Return-Path: <linux-kernel+bounces-106949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B4F87F5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56260B208C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FF8173D;
	Tue, 19 Mar 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtjhOhWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B481729;
	Tue, 19 Mar 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816559; cv=none; b=cs81602dMuA+aE3hua8KGH8etkGfYS2Fl28L991/9S6kMNTf/nQmD2G38re4UdqOU+G6OVq1l2GQEIyxUQx1sQ22UtM2NAZ70cSQWz/+IkCk9kAMPpwbBRPPPaKrQ04l59Qt6RG7gnU/FYIqPIrQeVR9HCwIpADIli0NaDsxUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816559; c=relaxed/simple;
	bh=wC2U1BuUk2JS8ZhwmCRf/ShpV2KeoyYM45pg5frMRBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4djpQRy6frtUMJfqWPr4/Od173Vh2lYz9gQtsCSmUFzvyI7F1E+JcECkFy/eJB7nnrQE82Ty3mbuYMTNV4mUrzoniqd6VwRnutX7lkTYcDwjhrjMnffw6f4FWcGVzMRNzkMLqav9G5NoRkCQ/x49JH5tm3XjH5XRiH+E+QCc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtjhOhWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A0BC43390;
	Tue, 19 Mar 2024 02:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816558;
	bh=wC2U1BuUk2JS8ZhwmCRf/ShpV2KeoyYM45pg5frMRBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtjhOhWyG53umYAQs8frvhEEf/QaWEM2lh0EDe20NrBNLFgTNPHH6AYjlqvaivvbe
	 xV4T37DdsW/PvOeEJZYlWvErINtDbbY9CH3pjNvzU62y3IaCyTtDYGvLUqGWJ2SoyD
	 wg9g6TVOPiuYeb5GiUX5tJMxtVh7Tce/L1fPfOcoTJMhWYjTWTbwqoI6fM/oqlnB/j
	 Q8N6Vo7+VymYCB4LzZX0/GWN+6YyANGPuccBCMqsQ3MHL4lxBhUiOVlvss7pEWUSA/
	 gFg2ky1fpvafcIIuf40nXq1NYth7KpOgM2OYF64VUx/5/hBVRJXnDAcfkHHCOfxnG0
	 bSSoxuC0Tp+Ng==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com,
	m.szyprowski@samsung.com,
	Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	quic_abhinavk@quicinc.com,
	quic_rajeevny@quicinc.com,
	quic_vproddut@quicinc.com
Subject: Re: (subset) [PATCH v3 0/2] add display and panel on qcm6490 idp
Date: Mon, 18 Mar 2024 21:48:48 -0500
Message-ID: <171081652631.198276.17540934790721436352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215103929.19357-1-quic_riteshk@quicinc.com>
References: <20240215103929.19357-1-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 16:09:27 +0530, Ritesh Kumar wrote:
> Build the Novatek NT36672E DSI Panel driver as module and enable
> display subsystem on Qualcomm qcm6490 idp board.
> 

Applied, thanks!

[1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel driver
      commit: 55ca24e5f9f432e27499ce5baa85f233931901c1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

