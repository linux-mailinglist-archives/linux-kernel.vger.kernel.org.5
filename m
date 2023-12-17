Return-Path: <linux-kernel+bounces-2730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED69816115
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0157280F6D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A458AC3;
	Sun, 17 Dec 2023 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q20MECnA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1865811B;
	Sun, 17 Dec 2023 17:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA1C433C7;
	Sun, 17 Dec 2023 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833732;
	bh=16e/5NoFt5Q8BZx8/ZPAEbmWxW2cLO9nvWPhWYBzpP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q20MECnAvID0Nou/bf9yeqbFoO5C5emBNWz3tj35wN2Z/uuOYZVk7N4tY25wQULWJ
	 0kSAULl/7UNKh9BLyF8dHytt+Nk/ytLaiUeWyvK9nVwrOBqnwBcCv0EgNC/qnQwPgV
	 C4X7o/4y7YCtaptx09sqL7axHY0PNKP6QK5de3TK6qqz7tnU/oNIMzVPIOb0nPo0BQ
	 UfEvtMTc/qUornMLvgIQwWMJOrySk2yOB4ZoAh57oUU/a0P83ADzqwF8wcGDGIfOOr
	 hNTIHdua/KdL5PTJwQs8FaSccDH6AIyHOcLIN1a+heTxzIc9Jx+kFnE99gRgWDU3BU
	 MSjPV07mxql2Q==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atul Dhudase <quic_adhudase@quicinc.com>
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
Date: Sun, 17 Dec 2023 11:21:24 -0600
Message-ID: <170283349417.66089.10497643268198986274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <1701876771-10695-1-git-send-email-quic_mojha@quicinc.com>
References: <1701876771-10695-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Dec 2023 21:02:51 +0530, Mukesh Ojha wrote:
> Commit c14e64b46944 ("soc: qcom: llcc: Support chipsets that can
>  write to llcc") add the support for chipset where capacity based
> allocation and retention through power collapse can be programmed
> based on content of SCT table mentioned in the llcc driver where
> the target like sdm845 where the entire programming related to it
> is controlled in firmware. However, the commit introduces a bug
> where capacity/retention register get overwritten each time it
> gets programmed for each slice and that results in misconfiguration
> of the register based on SCT table and that is not expected
> behaviour instead it should be read modify write to retain the
> configuration of other slices.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
      commit: eed6e57e9f3e2beac37563eb6a0129549daa330e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

