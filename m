Return-Path: <linux-kernel+bounces-134711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5989B5DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1846AB212FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DEC1851;
	Mon,  8 Apr 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff4S64A1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC215A8;
	Mon,  8 Apr 2024 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542643; cv=none; b=fZZwLE6cgGi7h/4L4uUIeeL4Z4398yEkCwBRRxSf9FXaS7lxsXcSnq0eVvdONwf2HyzDbOQhg/wK6Y7R3swHoIDkjIsSRhbQAN5DONuiwnPbyvbYE3XNtyVv/jRhHtfkN1flXCP26LmuL3kBcwSFjAIoJVGk8Iuzy4hYfz4Wuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542643; c=relaxed/simple;
	bh=yJuepVpMjUwLu6XbshdhD5Hzhlu9+k7u+KmtjHp3Y3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PT0ZSe4JTYmlf/a8iXqjgsBcw/El3+Cd5IlFuyjBO7etW6rNadRLPzDaZW1qEjLjXD15Gw2cKRJHMFqxhYyrPityBSDGhJ6lsB/pXb+7sRIcRjM4kslAXUmjaQmDcP1XKSSsuMbUdEHVpnzcY8PgbLbbOKrwW/iFwFvFXQ+fKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff4S64A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B8C433C7;
	Mon,  8 Apr 2024 02:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712542643;
	bh=yJuepVpMjUwLu6XbshdhD5Hzhlu9+k7u+KmtjHp3Y3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ff4S64A1+qGX78fzVSVvdgfRWdfpuO4uFpZhcfcFgAMz/VIea1PCuKUuC7cKL7c3t
	 C0X5/l4Ul0TJs+svDA3xOIDcHMK4PqaqoGi+2neDoc2LADNYnx4dYi5ZiyWMm/9ivn
	 9e5oj+3O9reW0uSB2cp34mflyRpbbCvpREioFNBio7UXlUsZ22B5a92Xy6hd2z33xs
	 iqdLU3IcphT2iRXLK0i2KXE/VPUGLC9T6zzx9hSFFxTgc7sd31midwFUat2z1Nwgyz
	 ku9J73WYZibOQMLQecHdUpVldLjgIHDlvG/1qTDicAwp15jhG8qJomcuQggHoWCsBH
	 38GM9a95MRcdQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	manivannan.sadhasivam@linaro.org,
	davidwronek@gmail.com,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] phy: qcom-qmp-ufs: Fix PHY QMP clocks for SC7180
Date: Sun,  7 Apr 2024 21:17:19 -0500
Message-ID: <171254262028.648987.14757754032979156647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401182240.55282-1-danila@jiaxyga.com>
References: <20240401182240.55282-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


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

[2/2] arm64: dts: qcom: sc7180: Fix UFS PHY clocks
      commit: 32198408f825a8ca3da4784d4c280847075990e9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

