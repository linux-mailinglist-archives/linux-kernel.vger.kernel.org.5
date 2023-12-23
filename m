Return-Path: <linux-kernel+bounces-10257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46481D1D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D6284C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2320FD;
	Sat, 23 Dec 2023 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBK7h/lG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F8917C8;
	Sat, 23 Dec 2023 03:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3278FC433C7;
	Sat, 23 Dec 2023 03:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703301804;
	bh=GLrQPLcmD+J12yAEPagkF2y+Z9oteBE5oeoXPgxmuCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBK7h/lGmwy+/dpLTm2vYYJ7+L6MzgjJfUgcYYZyrRYRgh+yIujbVO8O21KCl9A/8
	 AjUu4G7XgnH5hexyjV7E+L3sDO6XIkACVwm/AcvxMNiOBUvaXK3OjToMouMW2DtOuW
	 qqDPuWM/VMJQwhBb/pUpZp3leQ6k+hJPvO6ZmIUwCYhWjajZQF4EXpPzvK89jaPrbh
	 VpMlWAauFodo+z2AThCo/aRG2kLL6gwBRMvKal7lUkzTc6+EqsKKeQuG3v2K193JoB
	 10ObMFNvNT8vTP9kf1SBfn4c/ri0jZn7TBhmTlVwTGOV1UHMjfdIIoGViVg0y4R3I2
	 wqwp/ZWW3zIaQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP camera clock controller
Date: Fri, 22 Dec 2023 21:23:19 -0600
Message-ID: <170330179579.491992.7396004534427896998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221-enable-sc8280xp-camcc-v1-1-2249581dd538@quicinc.com>
References: <20231221-enable-sc8280xp-camcc-v1-1-2249581dd538@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Dec 2023 20:47:16 -0800, Bjorn Andersson wrote:
> With the camera clock controller added to the DeviceTree of SC8280XP the
> interconnect providers no longer reaches sync_state, resulting in a
> noticeable reduction in battery life.
> 
> Enable the camera clock controller (as a module) to avoid this, and
> hopefully soon provide some level of camera support.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable Qualcomm SC8280XP camera clock controller
      commit: 191fcf77e304392cc330fc19595cb90fd52d595f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

