Return-Path: <linux-kernel+bounces-57829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76284DDEB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1CFB28C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF86D1AD;
	Thu,  8 Feb 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNwS4JPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9616BB43;
	Thu,  8 Feb 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387364; cv=none; b=ncwQ/kIJQCdy/Yu2VJyFhJok41pk3lTCNqmFdxHgq+083mD26w6UFcj1c6XJeKKqp8crM2QrSIVk8i4l1SfYUgaUXLZj8zuvxP7F9UAX1JJ7h6R6PhbiFDUfV2EzAi17DEBW7Ty0WT/0Iw4Kdp+CDfvfIr0b5zsukhHC1VM6zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387364; c=relaxed/simple;
	bh=gXxa/8eWfzI0WLrRkb+8Y0SEJQbJpXLVSLSK+aSqhu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ocXDd6Frr4YtTadoHvIJYC2gH51OMW3gJT/SemWKdiE0+oSgY+DMSFxP6i+UfCOpjb9X0Ur2IxlvEwOW/JhtOKHObLGTWaYa1CQaLU6WT8DlCGO15o9JRGY+vtF3W1iKhp7VeyExK9g/5Vww17asvHtaINrOrIYeW8xjy5P852o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNwS4JPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3DC433F1;
	Thu,  8 Feb 2024 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707387363;
	bh=gXxa/8eWfzI0WLrRkb+8Y0SEJQbJpXLVSLSK+aSqhu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hNwS4JPODis3ymOGwGZwU41NQ4N9wYn68KNaCvk3nUmD3vvw1UDEcptwx5KTSiC7W
	 ZVE6oA8V07MLr38fSqurC6II2W6YdSgWsg2q9NmpfZ8iyPIoXzW47jwlxJuubYqrzV
	 RU3S6LrKYafo5h0tDFp/iQlUOxQ/vvG2ngIKqrWW+UtDaAwFnuCYqFjKjxYMhKkziP
	 ESaeFJ7+wq7eVNHykWQ0E4NmdVtzrowTrn4SBYTAyll/hqmM3J+QZG7bN1HqWvSofZ
	 U2hS+PVgb813QTthOErOJO/FxBrS7zHVdp7J4qy98h85poHLyyhwu3PWs17soFIsDO
	 TIf+XQpmGssXA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, broonie@kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-Id: <170738736196.904064.7729211182384063971.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:16:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> Including some missing headers.
> 
> 

Applied, thanks!

[2/6] mfd: cs42l43: Tidy up header includes
      commit: a5bc1c6c93853fb1026fb5feb6c36c9cd9512724
[3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
      commit: eb40e181cc480c89b906aca1f29ff6f6df6b66b9
[4/6] mfd: cs42l43: Add time postfixes on defines
      commit: 43a94a8cf0fa136d5fc726121ff7a602754c9680
[5/6] mfd: cs42l43: Add some missing dev_err_probe()s
      commit: 104c68194edbe0e8c3036ce283a3f69434415be2
[6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()
      commit: 8716f2c79eb82bd4dc5d7f9523a560e35efe0795

--
Lee Jones [李琼斯]


