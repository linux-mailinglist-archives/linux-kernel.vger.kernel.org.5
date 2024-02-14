Return-Path: <linux-kernel+bounces-65762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06468551A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF29CB2F7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF9130E2A;
	Wed, 14 Feb 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES9QI0tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799D12FF9F;
	Wed, 14 Feb 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933496; cv=none; b=o0duMjPkV7i8Mad9yrUePLCzk3kcLA8IQwYEUyzdO3Q/Pulrmd5Khd2tl7Trb4cATwfhqscSl1X6VGXxu5fCR4eteFGbx0VG+mqN6tihXd3XF6uniwRyEqIeT5ObLpIxQ+N+k60FQVTmyo9LuHMNqK01pl+VFI7I1G4LW2O8d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933496; c=relaxed/simple;
	bh=Ya63E65YcbVHL4uPFHoX6f2hfQp8l81yI8tgBeiUBTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRQ8DZL9WOuuTtm9IEEYqe7R6w4d/7TKd+gJShZ5d6Xs9IT/CnxekjaqhkQVst82hbWeFfrYXKocAOxhv7Qi9uh3m+/iuy4BAVo1MeZ6ZRcp0DoILDnnvLvnfTiAG06BYXttQWnzo+q5edgYAMuOhYQrC/uZu4Hu7vXqYTTKaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES9QI0tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D31C43399;
	Wed, 14 Feb 2024 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933495;
	bh=Ya63E65YcbVHL4uPFHoX6f2hfQp8l81yI8tgBeiUBTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES9QI0tvnxYax7I47IMhhicFTT2aMY48oIwFFHJ/Wijy4Hu3oYkVQnNoOqz3Xyvw/
	 lGX902/OBlx+wdojjI+nGnafPoODeJ4qjH9op4UFeGvIQR3nJQvUU+kCh3m2c5piXz
	 otLpUOiMEwdjItne7De007uN0ux4pTycKuSbsAPXcAHu9e7NXw59hqPHr6Qk7nfxJy
	 P+A1Gvcdba4N5ZrvNFjoQdQ4p6LugU/PydSs52AEKmLOXmxs5KqJlt3XbQqVgfGbSl
	 xItZI0kdF5G7oDUeMTuCyrHw4KQVvXvMZBmHIP1/pvcmjMcyM5EfXS1SXPP0lU1bnp
	 Yr52C31wK7jUQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Define UFS UniPro clock limits
Date: Wed, 14 Feb 2024 11:57:43 -0600
Message-ID: <170793345802.27225.14414738389431861403.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218133917.78770-1-y.oudjana@protonmail.com>
References: <20231218133917.78770-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 13:39:42 +0000, Yassine Oudjana wrote:
> These limits were always defined as 0, but that didn't cause any issue
> since the driver had hardcoded limits. In commit b4e13e1ae95e ("scsi: ufs:
> qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES") the
> hardcoded limits were removed and the driver started reading them from DT,
> causing UFS to stop working on MSM8996. Add real UniPro clock limits to fix
> UFS.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996: Define UFS UniPro clock limits
      commit: 68c4c20848d71b0e69c3403becb5dd23e89e5896

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

