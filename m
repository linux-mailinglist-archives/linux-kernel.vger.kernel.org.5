Return-Path: <linux-kernel+bounces-5879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F48190E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A01C24F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8063EA75;
	Tue, 19 Dec 2023 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKkNEKhA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633C3D38C;
	Tue, 19 Dec 2023 19:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AD4C433CB;
	Tue, 19 Dec 2023 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014429;
	bh=fsDwJefKUaGeNrH37K4pO/qCC8GFtYcBJA1T/Fm8oYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKkNEKhAESrgPbrQhkfuqiJ+3dzP14N6D22IlofvNClPihwvJxeJ+Vn3vmXeY42hj
	 LsjQ6MYv2ukhvKLfgRcvlxeZgiNJxyUNfBh2Ey5LZebpTqYJMZM5dIl45kAK75/yyR
	 Da1xFcTKCLHmqIU8LKGeUGyYEOS9Nf6qg+Skv4HoOSCD3MHzaiSEChfRWv6jM1zESV
	 EElMDKhb9lxyRZnoOrylhNGltoo1bzjGuLoXQ8uK0YmHWSBP8s3VLgpALLb43wbbCi
	 0qsLyu/QBosA19o7/LSzD7dlBT/sAadwWqcK8seQaUH+1iuvkvZYK0squKgKuzM34W
	 h0Jdlas1Sakug==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
Date: Tue, 19 Dec 2023 13:33:34 -0600
Message-ID: <170301441255.365364.14445701590452510370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
References: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 22:54:11 +0530, Manivannan Sadhasivam wrote:
> While convering the binding to new format, serdes address specified in the
> old binding was used as the base address. This causes a boot hang as the
> driver tries to access memory region outside of the specified address. Fix
> it!
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
      commit: cc6fc55c7ae04ab19b3972f78d3a8b1be32bf533

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

