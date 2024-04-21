Return-Path: <linux-kernel+bounces-152525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F168AC000
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A629281707
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A551BDE1;
	Sun, 21 Apr 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpX1VbLi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA714016;
	Sun, 21 Apr 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715630; cv=none; b=FyHLJbFRX8FrtexVo5QREeD7ba7KZg3ztD7qWsEH0CpWJfMqmIjOhowTCVWl/eP2A9fX/w08s7OkH9BKTJbFVkq3zq3KcxRpRFhwP72A/CNcmVsz+ZnB5vX6UrcMUAmwNZO71wmct6eEXZA8nPu+EHPl2jG/plbsgCdrhoxa4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715630; c=relaxed/simple;
	bh=ImHv/bG6shQ1Qj8+3ZcGmH84yLXalRxyRDI4k4x5UJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuVJoxZ3/7f4PiDVvWZm9StDA4rv9b6M40FQBaGMKEMLpn1kCDfwkgckS1T2C4Vgiqsvb+uI1/pZX21aJAheEz1/J1+/9K916od0SmEwnw8qsOg4N+H7CMMPouXi/LMf6V+vadoXwUg+4A+LI6SPsfII1vFAE+B5LDkFRK02gW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpX1VbLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2C0C113CE;
	Sun, 21 Apr 2024 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713715629;
	bh=ImHv/bG6shQ1Qj8+3ZcGmH84yLXalRxyRDI4k4x5UJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpX1VbLipDzGfEBxijgju5ugX5OAU1LUDgyDE1q0bJloo0AgH8IpahYGkaXrCLdUI
	 YQytPAwp9E5IcXf7GsZrOh5kaF3azxgG+Iu2fozxZ2GAQ5+Laj0zaRsOtssChWvh4d
	 rDi/RPlCno3HMakNPS1mkRtB15HzcTjGoKyY9t7rZOwIzOA19o75HWqaRfze9xy3ud
	 YkmYSbRtLw+NjFRIic7dVFQvaTf0LVGflCaUeCqvy26w4MJj/g2yGmDGXVJpb+eMXg
	 ixE9lFlbcb3YeG1NbsRApJ4gXDd/H7l0u0wB3reO3UNMofLbDw/T2LmvGdiPsnsk9s
	 IW013CV0jj5ng==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: rpm: Remove an unused field in struct rpm_cc
Date: Sun, 21 Apr 2024 11:07:02 -0500
Message-ID: <171371562477.1174524.10669986726753023382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f92330c717e6f2dab27b1307565ffb108c304a7.1713017032.git.christophe.jaillet@wanadoo.fr>
References: <9f92330c717e6f2dab27b1307565ffb108c304a7.1713017032.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 13 Apr 2024 16:04:04 +0200, Christophe JAILLET wrote:
> In "struct rpm_cc", the 'rpm' field is unused.
> 
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: rpm: Remove an unused field in struct rpm_cc
      commit: 3cb55215479f04940240792479c60fad53c2d202

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

