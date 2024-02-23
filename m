Return-Path: <linux-kernel+bounces-78542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37E8614BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5141F250C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6754839E9;
	Fri, 23 Feb 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTvL5YBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294282883;
	Fri, 23 Feb 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699832; cv=none; b=foaEu8v2MFkpIh+Ec5YhigI0i2IhlBZEuJxA4a/TfgAH7rx3nfd/sYQ8cLukBdxur7LP6+K/SwS/VLOSzRdAqFwckmVqdNphRIbRwQsgaBVn2VZjNjNrIyIFYX2MSdSb0JP4rTAcpBmh6IAZIffxPdUq7WWUyA2yd1MR1dzz4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699832; c=relaxed/simple;
	bh=uTDFI3qXOS3f4GpeIF/0ruRqhLbU5D7lTlLgmM2NO8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=do5NCwg5nUW14Z6LFG88Mvgjo+xzb93u9H1l1w0QOA4dHNuyw/LNOO6BQpdYxGzdQNyfhsLwyK9Knrof98eZTsreUDPFCYSBC/K99lla8tXQ4M9ko6n+ykDKBDU9Zz3IdzzEMiOmbO7HqBPOSBbSvvgz/hmzUQjuXtSM5/Iiq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTvL5YBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0A9C433F1;
	Fri, 23 Feb 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699830;
	bh=uTDFI3qXOS3f4GpeIF/0ruRqhLbU5D7lTlLgmM2NO8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iTvL5YBJSskBOLBGMDEhZ7s7Pf4O0ymZO6zF9fbdIw2+1L2vU31g94wp3QbyS4EFN
	 xabHX4yt8L/M8rMef6156JtTh1SLGUXN7wqblmmHLo1o4qLos20Lo72WOrQIqET+VE
	 7l2jGYbq0cvJGTceZbuvwhXin9jfVaEhju0d2B3zvDFCwg0qZAZd/rrSdyTzxqzNxq
	 VY1ZtN5Df83RZeb2wBKNmzgboZdAG3ySD+FwHT11TxSPz/xx3psIs4kd4wEBdvkS/a
	 TvaZ+v6ao78nwp1ocYINZztYgwdfMwolRS/DhS1ilaeCjeR+FXgeA0XXiAfKG9WANU
	 q1zbYllLWpUzA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Karel Balej <balejk@matfyz.cz>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240210-ktd2801-static-v1-1-90ad2e2e8483@skole.hr>
References: <20240210-ktd2801-static-v1-1-90ad2e2e8483@skole.hr>
Subject: Re: (subset) [PATCH] backlight: ktd2801: make timing struct static
Message-Id: <170869982803.1679597.4693204509792498409.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 14:50:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 10 Feb 2024 17:16:17 +0100, Duje Mihanović wrote:
> The struct containing the KTD2801 timing can be made static as it's not
> referenced outside the KTD2801 driver. Do this to prevent sparse
> complaints.
> 
> 

Applied, thanks!

[1/1] backlight: ktd2801: make timing struct static
      commit: ed2ac75acf99d33444a5d440fcad4261ad6f0d5c

--
Lee Jones [李琼斯]


