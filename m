Return-Path: <linux-kernel+bounces-166755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0288B9F13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819A1B20E91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0216D9D1;
	Thu,  2 May 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/pqJab+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBF1E894
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669063; cv=none; b=f2dROv/mrs2NrK8it2lRIKt8QREK/rr+yigdNOGJ0Y2VZzUF1E4bC36hBGJeSFJ4BncZqqHbd2h06I7w6+IxDaHSZXTS58sUZCknVttea7BChEq8AeAvBnSwAWJ/UescSDu4MKSqlAXCw3sHwiTLLazCqRZtyeI20YuBFgcBjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669063; c=relaxed/simple;
	bh=MeJONHaaVCoCJfQ52r8DqXIO1ZH1QEMXI3EQ/dVa0hI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fciBjQC/mdfOSplu4JDrphOGO2m1Lu/ZR+MNc79qsxzKgIZVgwLf3t5qCey2aY6I92QUmkHdd9jEZTfZ9SaE9e8hwPhhkJ4MI++kT/we1i6Nu7FA55YPdl0DBIqbcm/WHj0ntzvhayYkPUThLto/14TAkmUpytvNzvng8/teAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/pqJab+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E65C113CC;
	Thu,  2 May 2024 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669063;
	bh=MeJONHaaVCoCJfQ52r8DqXIO1ZH1QEMXI3EQ/dVa0hI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=C/pqJab+p+69JAoSaqocoMRCMRGS/VLUNsc03gB01YQLDzUC+wpqlVjhQM1F64xgh
	 TftLAJHg1sl1SpSASxSShUEpo3fwkaUbsd0VdjIebPcGd2cCG3kFMsp9IQa/kNoqGw
	 L7IxVQIjVlhd5yu7rhv/DAu+9WkzBd688EqWMqzcqZF0bT3RTwraHJ7qO05YgUSdYD
	 a1xWrwXRcxeeCCD0a4Q/4ORiJfAV1qbWeKdlj1rbfmPm3yWpNWR10+6FzW2gr/rNkn
	 GU9Dg/qccCVPknPRrdV11RFCDM8Vy1I3WsL/YVM0DsezQIOAD7UsYVdDJfbOcWFu99
	 15Oc2bTuIdiCw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240423210706.3709568-1-andriy.shevchenko@linux.intel.com>
References: <20240423210706.3709568-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 1/1] mfd: kempld: Remove custom DMI
 matching code
Message-Id: <171466906202.1211312.2246725106963631975.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 24 Apr 2024 00:06:44 +0300, Andy Shevchenko wrote:
> The ->init() open codes the functionality of DMI matching code.
> Moreover, all DMI quirks are using the same callback and driver_data.
> With this in mind, refactor the DMI matching code.
> 
> 

Applied, thanks!

[1/1] mfd: kempld: Remove custom DMI matching code
      commit: cc1d9001f1de0856bdd1ea04b6cfce06a81a077d

--
Lee Jones [李琼斯]


