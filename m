Return-Path: <linux-kernel+bounces-78426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4777861354
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FE61C214E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454497F7EB;
	Fri, 23 Feb 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz5W91Ur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5B22EF5;
	Fri, 23 Feb 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696318; cv=none; b=mtEc5C328EpcedZ4H0lUFx+mGxaweoEtHwHVMP7TqTWaRm363KXM1Z1JcoqFAAZzCqroAbYWiAMAWib4kBUTxGiRyXZbGlk7N/cF2Kr0w8bnbrAgu3BhTCdbpfbytH4NWagI9ikOAt3xtDiQ+UbnT7LeDs0ID2U4MAv2HS9nANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696318; c=relaxed/simple;
	bh=brFEKOvi0EIScwnYNvoawOX3R+vzeMi5uQ5Wxtmsoqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X5We+amcDmuOxCKyW7KfxqbH70iPFftN+VUDoxrt3gbtEVI6CQSS0DMJt+nKKe1y2vbdy3SkFRW2gRfWTPt7GHBptnQ9jlGSo4GzXBhkmB2S/nn1jlRxpRSMK0JqtgUYNiRqbM1Oe54gzefcyyCELjUIGY7NLQBGMbZY0lYM/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz5W91Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FAFC433C7;
	Fri, 23 Feb 2024 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696318;
	bh=brFEKOvi0EIScwnYNvoawOX3R+vzeMi5uQ5Wxtmsoqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nz5W91UruIY79lJSQcEshWCmARAYPf4pjTDyeZwCe6tbPOvy13e0Q90Cipe/h8rL8
	 P+rrq5+MraU8z68zbXATnX4CImx9aosh2IWne3beqbdTQsQTm990R9PhUnSuCm+2At
	 kKOqZpDH7azDVWQH4DM0KzmFSRxAJuPiRSADrNNY2SX6QO0t9Zw0HwYMY0mAEjAG9Z
	 IGqeLEVCEo2hh+Li1He9YydksX0Skieu5wjqlsAXUHdy4HE2Dg+VXQfE+JhuKgPHI1
	 URnPDGKuwHR/GiLFoCuYb1MWdbAkdABVoZYlyjvfU9f7n5RTIA9/u+RjDHD33KMWl5
	 5d0TRfusjkrbw==
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
Message-Id: <170869631511.1650917.2831695765682192504.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 13:51:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

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
      commit: b6fc7e62a7afc3709b31f6779665c7fc4a7755d7
[2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
      (no commit info)
[3/3] backlight: mp3309c: Utilise temporary variable for struct device
      (no commit info)

--
Lee Jones [李琼斯]


