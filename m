Return-Path: <linux-kernel+bounces-8832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17581BCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAB42871D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B2651A7;
	Thu, 21 Dec 2023 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkHWrw6L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7E6519F;
	Thu, 21 Dec 2023 17:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32CBC433CA;
	Thu, 21 Dec 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178982;
	bh=TQnnNdN3bVLMWPQ/3nx5Jm2PxVjwduzfYNkah623D6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KkHWrw6LCm6KJQ2lAYoZbwoya1iZHkCBwZCaEcU/2jrJnU3ZOSNMUdR+zPXIrJ+qJ
	 dV1LOXgnRT9g5d173mqwDLA16Oge7ISzhMrUhk7h/4U4KVnWS2Qlra4g/jMdZsm+5F
	 c+jhIN2cuTbP0p48GfWfIvlTrTOdOwBhTgacu3vg70BWqGzcBjIaZzwjD0DkbwMBDc
	 QQVfaZ9zU+iEWbLz34ajdKSaPmXq0tL7mcWrldaKotWXwDsRkHZZBHrVLbkpcfCxfr
	 D8znULkEJfE2Wg8mhfAztEmNhoA2x4LTdbCyD+YdujYZKJccavzxKUiSFlB8gRvZ9s
	 twV78Cf8Eh0ow==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
Subject: Re: [PATCH v3 0/7] phy: qcom: Add register offsets for v6 and v7
Message-Id: <170317897954.712473.7478662557724121939.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 07 Dec 2023 14:19:09 +0200, Abel Vesa wrote:
> This patchset adds some missing register offsets for the v6 and v6.20,
> as well as the new v7 ones. These register offsets are used by the
> new Qualcomm Snapdragon X Elite (X1E80100) platform.
> 
> 

Applied, thanks!

[1/7] phy: qcom-qmp: qserdes-com: Add some more v6 register offsets
      commit: 2226ec072ed3f1bd3f8dbe0cbf0e6cad699aedc2
[2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20 register offsets
      commit: a40542507b9045da03f4e013ab8562f6e6fe8aad
[3/7] phy: qcom-qmp: pcs: Add v7 register offsets
      commit: 7b98cf0e9b5f8a05a7f0f0d06d3cfa130bb576e2
[4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
      commit: 8d4f9f801095b120e433d935b296baf0e3bdc6a0
[5/7] phy: qcom-qmp: qserdes-com: Add v7 register offsets
      commit: bc546cc85c1d92d9ba7b278b77016b7d4334fafa
[6/7] phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets
      commit: 762c3565f3c8105603089eeaa0501e5089922221
[7/7] phy: qcom-qmp: qserdes-txrx: Add v7 register offsets
      commit: ee6fcc0f337d6790b46838bab76c36e8bdd5658e

Best regards,
-- 
~Vinod



