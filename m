Return-Path: <linux-kernel+bounces-58231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32C84E335
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5B51C22D78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A178B75;
	Thu,  8 Feb 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fys1Wb9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD578B69;
	Thu,  8 Feb 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402660; cv=none; b=ZGm2laxfsSbKpnxKnlXOmhjFAPyNQl0cRXLpGMC7l9TSjnXPvV6V8mgqgxh43+cAybrBk4U10gkOy3Ml3sS7UAEQghNfzaZfzdYrlVdte0trT1sA/0TqWR0u9NzT3lk0Q19OgXOBC86omso87iTTBsUEtskiOdY/IVD+qw7KekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402660; c=relaxed/simple;
	bh=ak9JMX8tijlCPP56ze53dnYiQcO/R64y/Q97h9/U+Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KM53dxZk9zJXAUbGSfYAqvmIoa5JcDlyWv95B1m5V5XC4YuOvCxQ2zheuUiR7/EoJMCcC8Pxy4XA+xPN3ldYbY/s9/mobIs2XCalJogD5az0fXXvE+a3eHYvJrwsX2Kvm6Hs9EwEP0ryH9GOJi698FPCYfMxSpE21CFWAR7U2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fys1Wb9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB73C433F1;
	Thu,  8 Feb 2024 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402659;
	bh=ak9JMX8tijlCPP56ze53dnYiQcO/R64y/Q97h9/U+Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fys1Wb9+k3KI+hyqCXMqcMkJ3Qq6guby6WgO1DmWUzTIsqu2M7b61wlVZt5UHyIHU
	 21wP0jNDw8aZ3YIeNqFOxvSLWJRuzo2nU0dB++pF5H1WDyjzQFlgexhPWZLP3MVG02
	 LDUoFlCeKiLGKv07ru/VT7kVMYPcXa399hgCZdKr2nwl71OMKwUVJ9DYNeWXcmujFP
	 MRwSoTmikxoCzoVq1YdXwLdI2Z9T5u8m+Kv61xyQ32isBC23eB+r7UEulvheduvBtr
	 /X4yTWKNl0aLQpezfprwjZnbjT2pkhX2YZ1O1dEreCnp9Prm28KG5AQ2aepiM8iYUM
	 cfj3mJC4FjEwA==
From: Lee Jones <lee@kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
In-Reply-To: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-Id: <170740265768.1071907.16480464735034223971.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 14:30:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 01 Feb 2024 17:14:12 +0200, Andy Shevchenko wrote:
> Allow to use driver on non-OF platforms and other cleanups.
> 
> Changelog v2:
> - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)
> - add tags (Daniel, Flavio)
> - new patch 2
> 
> [...]

Applied, thanks!

[1/3] backlight: mp3309c: Make use of device properties
      commit: e531c279ddee738260a94b2121836549ea167f63
[2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
      commit: d991269f64928051c895151a8589dce806a92d9e
[3/3] backlight: mp3309c: Utilise temporary variable for struct device
      (no commit info)

--
Lee Jones [李琼斯]


