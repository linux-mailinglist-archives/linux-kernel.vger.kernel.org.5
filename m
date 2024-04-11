Return-Path: <linux-kernel+bounces-141232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9E8A1B22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7701C20D70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6534D59E;
	Thu, 11 Apr 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUq10IaI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905724A04;
	Thu, 11 Apr 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850664; cv=none; b=ah/Ic5LKpw4XW+oR3Bho9m5H+pugnAhjE2cBgjAnzVBnCuboLsxk4jhYiW1532+4sx1ykcLv598L2ACmWEPdr1BznRxkBDUVPoSbvb0TVY2+E4v/LhvdFQGF8o2vARP2BwzYk+pbW1EE7r4H2QjVj4rCXeCXfYI+p2wyOUUgA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850664; c=relaxed/simple;
	bh=1YmahG86pkXWt+wHdmPokf2CV2VkjHARgkggfWFuN0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HcjcmkN6RzLmCei7BZw7bG+xVOZZGltoel3nLTVrrs+1ybnSOQ4RfdR4GMw1ASlcmgq0KzbxHnfh2pE6hKijCHlvjJo/GiY1c1BaMyp67XcOZ/O2uNdi+lOvbCfUssy2rn2vUInBsv1xTdTjUao2JDSbsixa5Xix7Oz6vV8qSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUq10IaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6927CC2BBFC;
	Thu, 11 Apr 2024 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850663;
	bh=1YmahG86pkXWt+wHdmPokf2CV2VkjHARgkggfWFuN0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QUq10IaI+64mhh0l8TDQ4SYzkPd4f1A0OHcaMQeANtRr4nUEv3ZQszKBG5JQeWE+O
	 urCWndZGnjM71L4rSBEXTBd+RTzEae6td5NwsFT3zKf6CgBz1lNIuW3Zughr7hPVQJ
	 38N7wasCxE+FpLGVjqZR+n0EyadAbqYhS4Yla+GexfyZCvAJwfdPkBThKKymBJwM/h
	 IT622nWHV0rC5Wg1hDGEpxCKFwE3IvtLHka8BJ4C8gExJp+qX/CTADFKMMHtZYk7xq
	 BqaKoDibodzLyBiwHA7TP5bqYSAsgDEgp14JfTBRb+dIoW7FmQPzXXWxbJZwS7ZMAw
	 mf0e/jqDYc35A==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-leds@vger.kernel.org
In-Reply-To: <20240403080702.3509288-16-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-16-arnd@kernel.org>
Subject: Re: (subset) [PATCH 15/34] leds: apu: remove duplicate DMI lookup
 data
Message-Id: <171285066216.2464516.4448595917392110976.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 16:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 03 Apr 2024 10:06:33 +0200, Arnd Bergmann wrote:
> Building with W=1 shows a warning about an unused dmi_system_id table:
> 
> drivers/leds/leds-apu.c:85:35: error: 'apu_led_dmi_table' defined but not used [-Werror=unused-const-variable=]
>    85 | static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
> 
> Since the current version doesn't even do anything about the different
> implementations but only checks the type of system, just drop the
> custom lookup logic and call dmi_check_system() using the table itself.
> 
> [...]

Applied, thanks!

[15/34] leds: apu: remove duplicate DMI lookup data
        commit: 6e37e66058d9c0bfa13d32e2c6ff14439d5e62f9

--
Lee Jones [李琼斯]


