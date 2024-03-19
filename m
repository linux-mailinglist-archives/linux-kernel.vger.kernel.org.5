Return-Path: <linux-kernel+bounces-106929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88787F594
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB471F21E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0F7C08E;
	Tue, 19 Mar 2024 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1QBqrHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188D7BAFD;
	Tue, 19 Mar 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816534; cv=none; b=OTf+oX5q4ZfA/RiwEuXXQrXaU6uDvT6yL9vmaw47202m6a5LHc3wDBrTMfOUmCtNPVslt+upOujcRKTmxs03A9cxybXDh98rGX5m5zTX0MUWEbVvJB1nw/3tlAVZbOua2mRznQ4hB9IARKh0ckfi/KGHWGaOj67tRCn+cHGlNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816534; c=relaxed/simple;
	bh=KaweszFIYhSU0mfWgLFa8HYlsUy3gXUKrPRhZAchwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HagO0o+DXKS8nTWg8SxAr/x420QsWgkBdd90AhwKD2TRsq6bf/H3Ir3B9RIYOq+oxTvQyVChQZiUNDpCtur2NKX6CEm4CjTnwDyWifkLttEVULBLXXM4OpdwKe8TzmE3ue7W1s6DOwEHb5BzFa8Kxc5ree3tc4JvcVWSqU26twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1QBqrHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F25C43399;
	Tue, 19 Mar 2024 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816534;
	bh=KaweszFIYhSU0mfWgLFa8HYlsUy3gXUKrPRhZAchwXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1QBqrHJUU+jVPIB3GZFd6L/nSrrshNnkyg7sYmqIG75AKXa7GpOpqPbZhajqQCoE
	 j923KQdj+SwXcRkp1nhbXgV6rcXn3Yn8sN3Hj9PPqQuH1ctIGha5A4Qh2eNnR2AAuW
	 5Qgx5+yBpoE+VVpBAcSProc56Y91DRecJfEd+YI8zSCp3y4jrxqATo7ezIUJiqkFZm
	 BTnbtb50PPfzUQdODI/WIwrMmeNRhxOZiMYCfNVB+daf+LgiGfF6h8WvFag6A9UCsK
	 isbDPR+D/HECs12pvqPd8TA6Z7zND2Ix5beg/n5R7Wcxysp64yTm7yzYY6P9lsY9Bz
	 9VrADH2tzsg2g==
From: Bjorn Andersson <andersson@kernel.org>
To: bryan.odonoghue@linaro.org,
	konrad.dybcio@linaro.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: qcom: pm6150: Add typec support for PM6150
Date: Mon, 18 Mar 2024 21:48:26 -0500
Message-ID: <171081652653.198276.7754636791518335777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220202147.228911-1-danila@jiaxyga.com>
References: <20240220202147.228911-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 20 Feb 2024 23:21:45 +0300, Danila Tikhonov wrote:
> This series adds typec support for PM6150. Was tested on SM7150
> (xiaomi-surya).
> 
> Changes in v2:
> - Drop the patch 1 (from v1), since it has already been applied:
> [1/3] dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150
> compatible (commit <ec29a4d9b7c7>)
> - Add Reviewed-by: Krzysztof for patch 1
> - Add Reviewed-by: Dmitry for patch 2
> - Fix typo in commit msg for patch 2 (Quacomm/Qualcomm)
> - Fix IRQ flags in patch 2 according PM8150B (Bryan && Dmitry)
> - Link to v1:
> https://lore.kernel.org/all/20240217163201.32989-1-danila@jiaxyga.com/
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: pm6150: define USB-C related blocks
      commit: 601feafa7dad3a1de094ea524b6c2e1315a738d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

