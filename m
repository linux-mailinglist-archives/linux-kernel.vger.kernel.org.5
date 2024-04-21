Return-Path: <linux-kernel+bounces-152638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC88AC1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D731F21004
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65753815;
	Sun, 21 Apr 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRkg5aiy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AB535B8;
	Sun, 21 Apr 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738591; cv=none; b=NF3Fb9AW5C7NrGVSAODz7fHJAu0OwitzeM/CvAAMU+aMR0r/28/Nih59KbsBgWNVF04cqhryJjgjQA8UbRmQaM6g/b8UqbkS4Wv3DsXMW4bkUnPh4D29zATrLSwSXwtpKu/Q8y7xTN7qKSeC7FjgQRndFhgLJyxVLzCXU5Lt9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738591; c=relaxed/simple;
	bh=EUoxTsamOCo66SH/7zQy0RIHDfmyzMqYgK3TQW0Zu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJAEdLuLuFreuQjNmaaFLsV9kuroMoDcyCqVVz+k7RjcwFN20e7ok/oiMcTYoHiI45at/f4ZlqfimU6B9hUwn68Q+9zbTynWHYo59hHhnqJJF07FfehOo6rtzpgEDG9cNHxMKy8ghU3RRMulblSDiusUbsDWG2J9miMucidVLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRkg5aiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3DBC32783;
	Sun, 21 Apr 2024 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738590;
	bh=EUoxTsamOCo66SH/7zQy0RIHDfmyzMqYgK3TQW0Zu3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRkg5aiyE3zufg+I35+rWLGXF4l4DsnO9VnJx2vh6IguqVXux0HxcCvOUGtWXCbMU
	 mhZy+kLgkD768Oh6mEPgttPrGHYPlDM/JiZ4571OYyJaIjyCFLqRfnkTMUQgnOKjt+
	 CBr1+umzcakvOwJ7T9yBAKaWcBVrFuFV5shpQ7UJysYY+QEl50Jp4e92TGMhd+Fyi4
	 LE58bL6thuj61X4OoLdQ+RZGDVik11im6LIH6vgGzcSA2c5E/yJQbQPVZ5FvxfnBZQ
	 9p3IcHyh5jUUk0Jm8v6gar4Av8IygLaPYt+SHQM8so3OrBJYOMcYfvGOEl6IbUyAiM
	 GFsCN0GoA5DEw==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>
Cc: quic_ekangupt@quicinc.com,
	kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes
Date: Sun, 21 Apr 2024 17:29:24 -0500
Message-ID: <171373856768.1196479.14779642234944924935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319032816.27070-1-quic_lxu5@quicinc.com>
References: <20240319032816.27070-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Mar 2024 08:58:16 +0530, Ling Xu wrote:
> Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes
      commit: dae8cdb0a9e18f0cc7bda75e42d0da750e05ca77

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

