Return-Path: <linux-kernel+bounces-78427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61183861357
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F0CB25A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BC8061F;
	Fri, 23 Feb 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbGKZ+kv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474880033;
	Fri, 23 Feb 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696320; cv=none; b=nsC3u+1Cg7JW9VdP2bHr9YEQQ/8UR4mslqTxiPEUH6pIidxO/XsGJ4+buF0vKydmeAEJIop+uxGxraKOHhvtwQ5msYKiJoByiGa+WZh2Hn0mj9+L+ZVTevJ74GFWMSFqb2IEP46wQLGnXWpmX0bqd65Q2rgz9gQsBg/sxQpkpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696320; c=relaxed/simple;
	bh=or8i1puQGcDyy/qbuYUMEIgpfRe1YXEBx6rJkHnAbTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEoD/Xj6pWCtxRG0DqRkhTiuDAjPHn6ct7HIcT7igDkMzwUFrusGhBw8OWraucje/D/P3TWjfiv3pRqBAWd0i+XgrOFqyeOq526roHf5NpobYnmG7iX9GRhgW/n61Io9v5yKpvtPM7rhZDRC6e5LhdMXu1KQLqaHPllP82mOC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbGKZ+kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885F2C43390;
	Fri, 23 Feb 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696320;
	bh=or8i1puQGcDyy/qbuYUMEIgpfRe1YXEBx6rJkHnAbTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qbGKZ+kvfgUjj18GvB7b3ZFSa2af5pwwgaBQdbc+QBCJrQ0dfJqp4Kjky0Jk0Wk7z
	 4/A+n/96CO0dQV4IlgmKjPjTovUMjJiVjboNmK8fT37h0Un2uHizwhCZChtvETaPYm
	 JezQtVKCHStRMaYvW2wK6/BSLiD7IFiTovX7qu+OLgnR6Mh61vLmkugV45/qOwJcSk
	 pi1+9QRRzKNbC0xUAXvfy8Y3tkYSQebyJNipWGO4NapBjo8D8CRuB/Z/bsXXXoPNO2
	 djYrygZsWddbZTa8Q0be6Eu8IBCxUK1XLEldEfYfVqn76ThP0kXueXEjhAeblKmIbm
	 QIhKbo6frB63Q==
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>, 
 Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
In-Reply-To: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
References: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [resend, PATCH v3 0/3] backlight: mp3309c: Allow to use on
 non-OF platforms
Message-Id: <170869631829.1650917.5934790597869811002.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 13:51:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 08 Feb 2024 20:42:25 +0200, Andy Shevchenko wrote:
> Allow to use driver on non-OF platforms and other cleanups.
> 
> Changelog v3:
> - rebased on top of the last changes against this driver (Lee)
> - added tags to patch 2 (Daniel, Flavio)
> 
> Changelog v2:
> - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)                                             - add tags (Daniel, Flavio)
> - new patch 2
> 
> [...]

Applied, thanks!

[1/3] backlight: mp3309c: Make use of device properties
      commit: b6fc7e62a7afc3709b31f6779665c7fc4a7755d7
[2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
      commit: 73e209b9ef8743071e8a04aad48db6644f3c8ce0
[3/3] backlight: mp3309c: Utilise temporary variable for struct device
      commit: 2a93258e20bb03016347a2e27e5d21ead3bfd2e4

--
Lee Jones [李琼斯]


