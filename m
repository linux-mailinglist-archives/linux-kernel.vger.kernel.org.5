Return-Path: <linux-kernel+bounces-2704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FE8160C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10411B22405
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508C47763;
	Sun, 17 Dec 2023 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Laj3/np3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007A46BA3;
	Sun, 17 Dec 2023 17:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E1C433C8;
	Sun, 17 Dec 2023 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833698;
	bh=i7Tllg3LK46/sfXTwk/xUDabBU4LK2sVvyoeHHw5Z2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Laj3/np3r1u3hK98+BlNrvlYSz8FXlwVqaaGxJqBr5QTnO6Gp24PTcnCV0USL/Tve
	 fqycyHB9/jsXWqpHr3TFv3vm0wdk5eU2hrPlqIXH8EOufF+dQJxQnUbvzAHAOhxRkb
	 AUfb7Xlr947m2GVF9rDPhEEVR2jfG9Tdl1qgeq1KuJsDK/YHeLVHF0JaJ9dG31f63g
	 KvCv/HAQEIi/ZNPMDZQB3x6HkYq97xnL/Vrmijw5o7vVXI7EbPf3KjteC2L93SehPx
	 VrjXl3H9JxvJeOMLNNWK4JPi0jQrsV/nId7FWo1spsbQW4g032fqnUfcN1vB4D+5tM
	 2evplu4Gv7sPg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/3] soc: qcom: pmic_pdcharger_ulog: Fix compilation
Date: Sun, 17 Dec 2023 11:20:55 -0600
Message-ID: <170283349416.66089.3636615166880488440.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 17:05:08 -0600, Andrew Halaney wrote:
> I ran into a compilation error on -next today, and while at it I ran
> into a few other little things I wanted to squash.
> 
> 

Applied, thanks!

[1/3] soc: qcom: pmic_pdcharger_ulog: Search current directory for headers
      commit: 4d2b810f44f1c7b65d374b0128dabb15f1fd6c09
[2/3] soc: qcom: pmic_pdcharger_ulog: Move TRACE_SYSTEM out of #if protection
      commit: a74ebfcd60c649f1bff7c369e432c322ae0a0d6a
[3/3] soc: qcom: pmic_pdcharger_ulog: Fix hypothetical ulog request message endianess
      commit: fbfd1f55ad34be14e52b39a1b83ae1f0d29b890c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

