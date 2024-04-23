Return-Path: <linux-kernel+bounces-155783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53838AF710
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0728F0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187113FD75;
	Tue, 23 Apr 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQnH4L4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68513E8AA;
	Tue, 23 Apr 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899541; cv=none; b=Q9KXyPL/5ne18Yn+0aTt7DNrDvCpe7Sh2nFlcn5ZfrSoCZ+Lj5ru5/qdOq2IHce/kvgBiJS7Vkg/5ELDvOzcfARhQIlDcj84VwPvude8sR+8arIz8d2BWSRoJlLebnG1j+Wifclj33u3FRf++Emc9J+tvANL1j2WEB0D6qb4GHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899541; c=relaxed/simple;
	bh=A4v0iVTRQGov4eLAy/8gY4d9Gh2C+rxIC2azW69wrp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoZNpeCWNttsstSiEq2RV7ucEd5AyTqLw3qMmVEpN4j4UT+bTwYly6CND22SLsEbwUoDDamSWNViHoBf9NTpoyxF2+K79KxiK5EJQQ0CpA6kXoyWzdAr0WNP/UUocbYax0GyqJsYYmWa4S84Jbm/bhX8Libc33NIwHn4xanW2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQnH4L4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFCEC116B1;
	Tue, 23 Apr 2024 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713899540;
	bh=A4v0iVTRQGov4eLAy/8gY4d9Gh2C+rxIC2azW69wrp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQnH4L4u+fP8vH1xyVF4Rgcq/Z0Cu/cnMDY7C4CBUjqX23mzRIrPjD8zE17lFis+5
	 rY1WCr01R5HMMqOjvRUbu6Zgx0uKVkfvYL4nLVUMo5s+z4XaNukEuN8tR8Z9QXJSG6
	 SHwkp9cWXLWlgCbk5MdCnU/uqoPUworEeB3eKt+ez6lTEpfLMGe6xw8xQ4agERWE8l
	 1ZQQ2gnsDiYyq/zKewRNoZvnYNR4mdQAS1etrKR/p8Ds9QXElH9px18dKevM0sUdFb
	 LI6g+MDbMlTaeKepTbfFRRXXdlTry2Bqi0fmN1ajMVI26e4XahP+uBJW25lwTGg+9V
	 FtFzwGQFV/lKQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] arm64: configs: enable REGULATOR_QCOM_USB_VBUS
Date: Tue, 23 Apr 2024 14:12:17 -0500
Message-ID: <171389947417.1267776.11344166654266361329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325-arm64-config-usb-vbus-v1-1-d14601f81d08@linaro.org>
References: <20240325-arm64-config-usb-vbus-v1-1-d14601f81d08@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 15:46:52 +0200, Dmitry Baryshkov wrote:
> Enable the VBUS regulator used on Qualcomm platforms (RB1, RB2, RB5) to
> supply VBUS voltage to the USB-C connector.
> 
> 

Applied, thanks!

[1/1] arm64: configs: enable REGULATOR_QCOM_USB_VBUS
      commit: fefda685ec0846a1f1c2b13af2cce4cea580a768


That's "arm64: defconfig: ..."

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

