Return-Path: <linux-kernel+bounces-51210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C78487CD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF76283548
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F35FEF8;
	Sat,  3 Feb 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXjTks0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477B5F864;
	Sat,  3 Feb 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979988; cv=none; b=aaZeB2bufah/ZwY2ceIopiPfav9dXGEWF/yYN1TTRmjN9mhzFkmfvtmdEuZhiycFTo+RdPh65kuhOyxhcIApSdockOMcOq6Pl3Ahh+Adb+NAh/wGFvLtc+XKM0gVSp1i2sbvlL56np61WiHc7tnPz9RC9xowJ2Z2rPgEpCcxyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979988; c=relaxed/simple;
	bh=FakqdJXd18gGr7bkp1XDgzpchugoRG2ljapRrBM/XIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt9wl7B+gXX+VwbyLPjtf/vzXSUSONIwpdfNoKlnPEGkce4eM/3P20IAQ0V7rYSI/A7RCI2X6VWgMSeYGoeeP6OU3KK7VUGRvsCfQFRG0iRSNm5YlMYXA4VhtUzVwSCUAS0PXONWebBvjczc2olQYDWv2WenMFoyzOdXZjFwxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXjTks0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A1DC433C7;
	Sat,  3 Feb 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979988;
	bh=FakqdJXd18gGr7bkp1XDgzpchugoRG2ljapRrBM/XIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXjTks0xg4k2R5ZUiyQMgaX8LDL/q3SJfcMpFXFeiKHMqYT2PbW4Z5cBQq6mGMp7y
	 O4dxZJjlJpK5ByTZSvsZOhMNKiROjqmpjern9GhUoWh9WfnTMaRuSIyo4nOt08q9vE
	 C++iiA31PkRSCXyTHv5C+8imx6O4/VCQQLxYcFbtlECHh3RoZ/jWiTsZLIH7j1iSjJ
	 DpKhu3nOrpJrOpM70SIxQe6FfFZh3KYdy1Bxc0D5L1BzM82wjZph5iJQNfwkwHji48
	 VIOF1M6EOlzG7r0IeAmgDxj5fmHb8cxy5vYhSCj89JIrwW8y9Xk/4Gf4PgOFn7U30A
	 CjywDC1n4scGA==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnect providers
Date: Sat,  3 Feb 2024 11:06:19 -0600
Message-ID: <170697997761.332807.15662247521680250940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201-enable-icc-8250-2290-v1-1-8ded02750521@quicinc.com>
References: <20240201-enable-icc-8250-2290-v1-1-8ded02750521@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 13:31:19 -0800, Bjorn Andersson wrote:
> With interconnect providers built as modules Qualcomm SM8250 and QCM2290
> platforms launches init without /dev/console being backed by the debug
> UART.
> 
> Build there drivers into the kernel, to make sure the dependencies for
> the UART driver are available and thereby give userspace access to the
> UART without having to re-open the console, once the deferred UART
> driver has probed.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable Qualcomm interconnect providers
      commit: f2eace2b4db5037c617168152c9bfc5421026d3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

