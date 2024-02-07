Return-Path: <linux-kernel+bounces-55962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A584C41E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B495B2A588
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67C33080;
	Wed,  7 Feb 2024 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTWNHZwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E22E85D;
	Wed,  7 Feb 2024 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281240; cv=none; b=QGYcsc+t8w2jRzO2lf95z3IY3yvjitl/KVy4TtX0iiJWkXyRMVPFToSHxHvaf3NLG/Zp3T1X1bETIVXQX31FVHvWPPrUd1Y1EVrIuAAzxd0DQ0UilHttFJ6UdZ650bQLs3g7fpozNoiehUx6pzHqNtuQw1aNIhh68g/G0fKK7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281240; c=relaxed/simple;
	bh=akD9fi+uU51SgzNlzw+tT7qmbTTv9OhaRe+6mXu6Nrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkyzTjbkF3Lyq50aGYZQJ+amtozN0zqFdNbhvO4mo80S72fj2ATUIZ71UbmDfw+Zh54Q2oQN0q9ZhOXQ7prvNja3I3TncJqdf0HvkAI7kZT6ZKU2y3NWycbA89RmDC4k+xPHSJ42uVkBlrg3WYUIlLgRWEiQzo7YkDfI7aE0y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTWNHZwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6046AC43399;
	Wed,  7 Feb 2024 04:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281240;
	bh=akD9fi+uU51SgzNlzw+tT7qmbTTv9OhaRe+6mXu6Nrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTWNHZwx8DFR2YFrCYbZsJzw/zRHp3YP5YlToCpS4O2/pJEcb6kzC5xM0tBVCKuA7
	 HrjI/ZyP2wtMJFrlTBNIsZHo4CVcl9hYpwpzgUcQQwjES19ZdOzG5M6i9SJ0BXBxjS
	 OpOqO1nuX/m+bxkg8WG76HuecOA/nmr77IW55snngXtsqN7+TfFmZ6O4Wp/BzG8fNc
	 L6tzMCzGE3jE7lnqLu4/IFdeEoIhlBTnJr/3sKOwocoi5vH6Xe8Kv4uLaUEBDqTKSM
	 bzFY7ghP5SEDr/P5foDmDBqmuiTcVJm82ir0vIztaaxepWEEBVSUvC383EuBXQV6z1
	 31oLx2dL7iong==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>
Cc: quic_kuiw@quicinc.com,
	quic_ekangupt@quicinc.com,
	kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: Add dma-coherent property on
Date: Tue,  6 Feb 2024 22:46:37 -0600
Message-ID: <170728117684.479358.15525440812586627141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125102413.3016-1-quic_lxu5@quicinc.com>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 15:54:11 +0530, Ling Xu wrote:
> Add dma-coherent property to fastRPC context bank nodes on sm8550 and
> sm8650 dtsi files to pass dma sequence test in fastrpc sanity test,
> ensure that data integrity is matained during DMA operations.
> 
> Ling Xu (2):
>   arm64: dts: qcom: sm8550: Add dma-coherent property
>   arm64: dts: qcom: sm8650: Add dma-coherent property
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: Add dma-coherent property
      commit: 4a03b85b8491d8bfe84a26ff979507b6ae7122c1
[2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
      commit: feed0507688b7e77755c4cf507d02223137fb8c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

