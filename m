Return-Path: <linux-kernel+bounces-78647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A75861670
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594A41F25F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815782D95;
	Fri, 23 Feb 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1XxEo3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFC5D750;
	Fri, 23 Feb 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703655; cv=none; b=k3XFfSnYr56JRos7/MbxivsU5LEcRoUgvQbIjV+7Hb6gaaHNyy1m26lngMzLhVZ1NAifIAUq8/kfbpBzXNi8AyD7F89mYsjRDmKMki/tP4KqWQsgLE+S/EbYzbHqaTbAjQHv39Gx/w8X0zUV2jo2IJs6iMW8vkg+dcXvbjNgRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703655; c=relaxed/simple;
	bh=ZmMfeIezk17nGjdTO/Z3REthdAgXIK1fQj7QC6r47z8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QHgdpPGq3CypmbvO8Kr7adyD7fvuSigMCMZYD3tpHU0RVU5rFxKjleV4qA1+qA+q1BDM0xbb91K8WO9ti75NQhjIlOAAFb/apq4uBkZHYfKSm2VDTpnYPPTyuNBYrR5r7CsD4U61CG0mKGaL8FRj4niA9jJIHD9r04VEwsrksvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1XxEo3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C903CC433F1;
	Fri, 23 Feb 2024 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703655;
	bh=ZmMfeIezk17nGjdTO/Z3REthdAgXIK1fQj7QC6r47z8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r1XxEo3oy+d1t8vPKLoJbxuutY7k+6GhiI6iLMURCdwm2J55wvZpF8FXctsqgJf/X
	 PszC5HMV2RJ317DTqkdG9Ue1WYTFAF4X5/J3wTjfXMsd5tSY62MQwcAmP0gjIJ+6MJ
	 9oVTbOK25gsNcUomFTY4uk6iJ9MB9G3OLLPW5YjY+LgDWq1SMDm7be9ZLVf4dhYRDq
	 YTlrtexsTn5gNviFB+Q6Jv0wz5kYSXFS6bIfUccvx/3hdP1xqNZ3PXSD3ANbkA+cqO
	 WnFnUUMhm4n8SovhIje73o1m+Ko2Zmb/58vE0s5/byZEoODyRG3EOFzGT5sebBKdgm
	 a/ao45y3QGakQ==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
References: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
Subject: Re: [PATCH v2 0/2] leds: expresswire: Fix dependencies
Message-Id: <170870365155.1722159.6291358322517617428.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 15:54:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 16 Feb 2024 22:15:42 +0100, Duje Mihanović wrote:
> LEDS_EXPRESSWIRE does not depend on NEW_LEDS in practice but still does
> in Kconfig. Fix up its Kconfig entry to reflect this and fix a Kconfig
> warning.
> 
> 

Applied, thanks!

[1/2] Revert "leds: Only descend into leds directory when CONFIG_NEW_LEDS is set"
      commit: 7a28f9cf6b7c8cad760b4d4ee7f53231cd76d8e4
[2/2] leds: expresswire: don't depend on NEW_LEDS
      commit: 8cd0da0634222ceb434281f3034ad773ddfe0f4f

--
Lee Jones [李琼斯]


