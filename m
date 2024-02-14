Return-Path: <linux-kernel+bounces-65756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C777855134
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF03D1C24D18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1912F376;
	Wed, 14 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwBTzaDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B512EBFE;
	Wed, 14 Feb 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933490; cv=none; b=ZJ4v4tQA9MrZ5eSLYfJncuU5ffkD5pbNAjYW2oX8uQct16o9faUekuHzdeZVvdsFDKkfIRb9PWGPn0okO2ctkHUa0SMRNVfqQjJ7g0AIoq4w7JBHh7Tsxk4+1LJwGlAlTDE0BWGhBKe1dMk0+ZC+O9eWkhGgXKQgPL3fBA8iqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933490; c=relaxed/simple;
	bh=jMrPnTQTKhmPGsqwrrcW8eXdyj+2Ygq9BMpe0jyLIZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH0p88LPrCXc4gjATGUKSWgszpumDqPCpRoZgKDOD9XPxDrpEpXzDiY3Z3V9uXjR5JTlXjOBWhCypF8tSEGo2D3MybF60AppXU2qDbumY/CtvOE/MdbB4Pmq7OnVlznvS3qSCiryMdiPq5Dlo20fSKAjavwBptm2yetMzBtIYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwBTzaDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D2C43390;
	Wed, 14 Feb 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933489;
	bh=jMrPnTQTKhmPGsqwrrcW8eXdyj+2Ygq9BMpe0jyLIZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwBTzaDtEMzO1joIGQkeKmKmt0ORNWQYvdvAY6KM9jA273Ti3dlv8lhd4KzPhz4Ck
	 lJNlFjs9o8CVtkuaK80UM58xSSsn6Ei9qsu+gmKJ6NuMsBFrsILWmpGhco9UlDqlpb
	 t6z5q1JOwqdRfUxGwcyTteN7j5w3xuSdonNPLYqhrYw/G5xI2eIfV9ecaHxSX50K7A
	 wMZSFKmrNQ+UdXa1WV6KD2AEKcfwseyIu3yLiiQMcDiODZBNyJgXgl8ea7RymX+IRK
	 YDjUqvrW8IHOOYjs8mmNdlQc1dhBiQhhardzENbtPfpAitWxHVbj6chH8j3KUwtTWq
	 S14mw3Y61P/6Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected
Date: Wed, 14 Feb 2024 11:57:37 -0600
Message-ID: <170793345801.27225.1462005277982698945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209-qcm6490-gcc-protected-clocks-v2-1-11cd5fc13bd0@quicinc.com>
References: <20240209-qcm6490-gcc-protected-clocks-v2-1-11cd5fc13bd0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 09 Feb 2024 15:21:48 -0800, Bjorn Andersson wrote:
> The SC7280 GCC binding describes clocks which, due to the difference in
> security model, are not accessible on the RB3gen2 - in the same way seen
> on QCM6490.
> 
> Mark these clocks as protected, to allow the board to boot. In contrast
> to the present QCM6490 boards GCC_EDP_CLKREF_EN is left out, as this
> does not need to be "protected" and is used on the RB3Gen2 board.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected
      commit: 7c6bef576a8891abce08d448165b53328032aa5f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

