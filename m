Return-Path: <linux-kernel+bounces-165746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEF8B9082
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF68F1F242DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980001635B6;
	Wed,  1 May 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfnkySor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA312F58D;
	Wed,  1 May 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594859; cv=none; b=NrT6F4rgYxPwrNDbSEWBX5qTM5CTf87nE+/2XQaHAfdYy52lB58cAt0Z0dCQccdJMDZUbDSbj0QJsomhJbXJK7i26PG8PlIE6jpDL3qlZsfq+sXdXTT9M4QjvO0xBz+QhPhtTAl6lt3l2K8tLrkI8qFzvFA3YoN2hJER6i8QmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594859; c=relaxed/simple;
	bh=2B32q39n62MJWQfTbbGHtmBJdAM510OKxgBBwXicTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iabEVBLom42tzvAqaZYzbngz+JD0aa+1PGuZHwf6X8g1Hl+ym1nfxHaNME/dMvgg1q5hGoRaOkktSxoNzUSUhx1mgOHhfKTXk0EPOWYtjfrqjy4JDaq4vq8WVM09/kPYfkTVVlfDa2B8l5QGt2O/QAaGmXOuqMzwGqCYPjNTs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfnkySor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63AFC072AA;
	Wed,  1 May 2024 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594859;
	bh=2B32q39n62MJWQfTbbGHtmBJdAM510OKxgBBwXicTxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfnkySoro7JPO6pMNkrzPeS9wAb66fJWBeMtX1m2ieeuzZR7+3AHN4XJlNpVEjCZJ
	 wAefq+7e60kZHzyvP7SUUPF5FOjo1qM/w5BcKys4OcDDteP1BZoFHWC5yFoF9nMrdj
	 DaDm0h91TNf5zB/LcxzoRky3zfDBgH3NzKIzQfJTKaHGbPit3R1DKN20yMud6YvdeK
	 b3RNgS9TaqPE43z/UpgJjXpuTPY/o0WUy6M200TGf3P/O01Uc8cNPQJ2zV1uUZxATU
	 lOXtGU2fatwL8+4IIdqKWxEP9KL0EPFHUuRfirBGg6U4WEdOPLsEomobrHUbyrC7hi
	 FseVH0J6ditvA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] firmware: qcom: uefisecapp: Allow on sc8180x Primus and Flex 5G
Date: Wed,  1 May 2024 15:20:49 -0500
Message-ID: <171459484210.41039.11983482027529258544.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430-uefisecapp-allowlist-sc8180x-v1-1-1a626ea9c5f1@quicinc.com>
References: <20240430-uefisecapp-allowlist-sc8180x-v1-1-1a626ea9c5f1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 19:33:12 -0700, Bjorn Andersson wrote:
> Testing indicates that qseecom and uefisecapp are working on both the
> SC8180X Primus and Lenovo Flex 5G, providing EFI variable access.
> 
> Add the two to the allow list.
> 
> 

Applied, thanks!

[1/1] firmware: qcom: uefisecapp: Allow on sc8180x Primus and Flex 5G
      commit: 4b34d4c25da289712d9a5bd5bac5888f099cbc5c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

