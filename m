Return-Path: <linux-kernel+bounces-133869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C791889AA1C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664F81F21A89
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92F381B0;
	Sat,  6 Apr 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjSDeR6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8268376F5;
	Sat,  6 Apr 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395178; cv=none; b=pPmjXsiKObXS7eWOcgXFeS4cKZjBKsrUnwW+lhUmgdmiS3zSx/WU307a28vNvzHqjr1JAYJNcSVg0G31VAL2riBEfHhqo8W2WVlFySXYwZu9yal7SpfzMyc7Ltpm4jhD13ive/1vAv1weUMZC4Y/v4L++hEsddMIC4D/vNHdMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395178; c=relaxed/simple;
	bh=R2YpeVd3fp6cSDv7naiL1ODEdKUfOG1zEJc13M0NeYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tMZi4zAhU93qRTWKGJEfDqvbI/d98uGXTbQzRKy+S1SvcLSgNSr1r0G/6affbOWrXLX7evop4QtbNOPI2H5fGZ0IV9z/syW7GnFhP7uxd0IpCKADIiTtj9biajzunAvSVA39VF2qmaUTGG6APrO6NAw2Y6MOv507Lelqh37B6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjSDeR6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF7BC433C7;
	Sat,  6 Apr 2024 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395178;
	bh=R2YpeVd3fp6cSDv7naiL1ODEdKUfOG1zEJc13M0NeYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UjSDeR6bvGAw4Vd/Tp5OWTGDiDQB1RNTQxxSXSljaNYwjyo9dY/SRTA+6WhXrfx2l
	 HQzbNAgMj1sRNTgqj4wGsctaELnLAuPLA/O7eVncW7+KbvILgFWQVYN/mbG/mTNN7p
	 b1s7KgUEaNWSf0x3by4mH01KvKAFtruy84JYWPg1QoCSvfNe9rEe1wG0VQC2UFLTzD
	 7/mwyDJTH7REZK8qJiyP49L8uBIFhwAiP35m9JyDLZk5fm2Jg5zBc59fOe8KxBfTM1
	 e1kaE79w1qaXD1XO4I8W/UOpm4No+tAqjhs8BCO75TXFG64k8IOiYxcyCscKA1KeA/
	 8ES2RaHtZfxVw==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org, 
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 cros-qcom-dts-watchers@chromium.org, manivannan.sadhasivam@linaro.org, 
 davidwronek@gmail.com, Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240401182240.55282-1-danila@jiaxyga.com>
References: <20240401182240.55282-1-danila@jiaxyga.com>
Subject: Re: (subset) [PATCH 0/2] phy: qcom-qmp-ufs: Fix PHY QMP clocks for
 SC7180
Message-Id: <171239517351.352396.6743656953443079463.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:49:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 01 Apr 2024 21:22:38 +0300, Danila Tikhonov wrote:
> This series of patches is based on the series from Manivannan:
> https://lore.kernel.org/all/20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org/
> 
> Patch from David adding a UFS nodes for SC7180(SM7125):
> https://lore.kernel.org/all/20240121-sm7125-upstream-v4-6-f7d1212c8ebb@gmail.com/
> 
> The patch submitted by David and a series of patches submitted by Manivannan
> were both applied at approximately the same time. As a result, David's patch
> did not include this change.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
      commit: 7c1f42967b75bdcd0640c52d37d58d8dd122989b

Best regards,
-- 
~Vinod



