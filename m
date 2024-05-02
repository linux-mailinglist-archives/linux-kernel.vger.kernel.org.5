Return-Path: <linux-kernel+bounces-166278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0AE8B9864
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E57B2577C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7657314;
	Thu,  2 May 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH/7RyzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56E56B79;
	Thu,  2 May 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644144; cv=none; b=k2em0TgUaFZwLVcwbsa7esBMeKF/VDqDYRGqoLUctlOzQOytlAMSK5z2TrsTN0NM1fKl/nTCaMkNb+55Yim5Z9+TClGMEhIOCs0tM+UEwebyoFQHEAfwwAJ3vn2fPfeI1e4VAxfSDAqey0vsk29qdGbpjmS++5zAOAzAL4sftMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644144; c=relaxed/simple;
	bh=hUIfTQBhCxf+2q+K2cclO1376bXKdlTXiObnQCwR1Bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GYA6/XsyyHjIN7uzlOszljjs2+xktFcw6DV6MjvTmQpQhg62e+TVYRQ4aaQNjt8fEc17F/NQNogpQS/UHAtJOn9oPlSBkBMN0Hy+9OqnC/VTWJVN7v1TGZObrQKQ8lhSyASAtPCJ95PYffM6KbVbj7C5oHIlq/R2CDGQCxTjzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH/7RyzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B26C113CC;
	Thu,  2 May 2024 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644144;
	bh=hUIfTQBhCxf+2q+K2cclO1376bXKdlTXiObnQCwR1Bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YH/7RyzEDNL5kqdgyrSrJ5qnA6Sji/yXxoHgRvpGr9JdDdbhQvEV2bBNkxyJecWpv
	 KHvgIg0aJl9JmQL4WsPe/wwkMU3IB78KHpA1hOr2owZTXLbC17pUd8mzQDDKMywrb4
	 Q9vwVJ3ngxiSmMOlAYyT7qtb+qc2g+ogVUa2qpFICs4ac2khDMOJzLn3QYOuzBAY/p
	 SYjbmbsUQE3MdDViIKm9sywpGCr28x9KlH3lgSGDBE+WitWC7cLnqRegm/n9J1xOAe
	 IuMXnOe8+0HOLZ3sXEVapqtIPTrWvD14RsAKOoX0405V9EbEi2ftE09YMPNPhFQb0R
	 74S0PCJYRBa5A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240402105708.4114146-1-s-vadapalli@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add
 ti,am62p-cpsw-mac-efuse compatible
Message-Id: <171464414196.1144273.11589923765175802872.b4-ty@kernel.org>
Date: Thu, 02 May 2024 11:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 02 Apr 2024 16:27:08 +0530, Siddharth Vadapalli wrote:
> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> contain the MAC Address programmed in the eFuse. Add compatible for
> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> registers within the System Controller device-tree node. The default MAC
> Address for the interface corresponding to the first MAC port will be set
> to the value programmed in the eFuse.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse compatible
      commit: 6269045670d79c1632480284a65be253ecd02ef5

--
Lee Jones [李琼斯]


