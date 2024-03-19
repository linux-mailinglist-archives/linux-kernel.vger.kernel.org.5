Return-Path: <linux-kernel+bounces-106939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFD87F5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5B1F22132
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B67BB0F;
	Tue, 19 Mar 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ3f/wy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA7F46B;
	Tue, 19 Mar 2024 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816547; cv=none; b=lLJo+LG91pAR2aBaaKu9h0xw2jZtm4TCY6X7NrPb4FjdcdOfqB1Hz00P1jbOIUcduA337pTqrRv7eBRHt914QtLp2vWiKS3Nu242naofpV/upsddNuDjpH41lGcCjjD6qYYXQ1supib95NXQKS8L+NOsnpKE/3bJj/7SzN2VbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816547; c=relaxed/simple;
	bh=UdyM8K4GzjIHSMUUdauDrVIa/8xlFArGKMGdPI/IAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pvq1j5WFnzTCIpBw5QVt6RmD4zwmD7nBFN2BExBQ8tb++uhfXrHiZ7XkKKT/iMPJgsRRFGqbi8eX5Q41OZ1uFs5CxD859YqQXzlEqDCxoNZOYWY+sYELPZL+wIN7ufpKeohIabtia8WoLCzpu0rt8vw8hUCzSXFhsMgfuN0PVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ3f/wy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8174CC43399;
	Tue, 19 Mar 2024 02:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816546;
	bh=UdyM8K4GzjIHSMUUdauDrVIa/8xlFArGKMGdPI/IAbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQ3f/wy1v35B1z5wdNVAsmaNguQghmCIuXBr21qzdES+uv6bDRF+hwPgDlEbn9gHX
	 oudAIydwn4fEwIRKw3PqPKe3FGPB69xOH0+RAXK/sBRosmZYFqsF/El3eEeB5ungmJ
	 FKPrBAcB59+9Wd6KolhbAvl8HHAgi4HOjafO88iNH3nH/S2bRNjlFbAsB2KZMAADI/
	 i/0/gJ5+zVI1BHrGMsvOI1TTT8frCTdwATpe/ZSw0jdJtUMsL/j8yL33aVRc2D4RL0
	 LderRT3GVMkV7OmVjLO7FUQ9i2pCoS93gGhFRBFBDxD5b6L+BCpWmUPsnwB8uCHmCi
	 Jpsv9NC7rzpGw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Fairphone 5 PMIC-GLINK support (USB-C, charger, fuel gauge)
Date: Mon, 18 Mar 2024 21:48:37 -0500
Message-ID: <171081652647.198276.12432944971969961855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-fp5-pmic-glink-v2-0-4837d4abd5a4@fairphone.com>
References: <20240208-fp5-pmic-glink-v2-0-4837d4abd5a4@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Feb 2024 10:52:31 +0100, Luca Weiss wrote:
> This series adds all the necessary bits to enable USB-C role switching,
> charger and fuel gauge (all via pmic-glink) on Fairphone 5.
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 compatible
      commit: a5b150af2c6ad2749aee51edc36f9f9883869f5b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

