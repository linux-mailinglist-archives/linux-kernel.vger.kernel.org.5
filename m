Return-Path: <linux-kernel+bounces-84627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C986A92A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2251F26D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B625566;
	Wed, 28 Feb 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="bdeH5c07"
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E324B2C;
	Wed, 28 Feb 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106307; cv=none; b=OWkkMlNfF+ckulCwttlZCQ+l7OLtSafLvBvvh6CES9YLB6FCpph0YbxQ17xEDP3UiBOHIfCrwqjMwhbM/TKpEY21hZj1agZEHfEVDDVaxaA4nWW/v6ayIOWvcX/0KplmGffTydZJwTLwjelEjh4I29Dmy7v/tFGdaL3aXEIRLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106307; c=relaxed/simple;
	bh=FMeFUbTzxUBWnl08fgMI12IYs5o6L20Op/JZ1/ut8aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di3b6FrjsplwYLIRJIZGDg4nVhpVWhZVXcGtvGvsSMuV5nozZ/2gkV+pZSFzwO5yKieFVdbDJfgt27OGTinm6tommXGhQdpvkVCByfyGatZh932ehoR7d34okCL0V61BxYvG2BSqyqy56eTK6JqzwYKc52tU+dLse5ciBoGGBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=bdeH5c07; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1709105797; bh=FMeFUbTzxUBWnl08fgMI12IYs5o6L20Op/JZ1/ut8aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdeH5c079EghS9BM4hdIEw1+OOxq0H1G984C2/9XnI3v5XfPDFNdH1XJzaq0Fi8Sw
	 LmZPf4yEwTgFH1rz6QNwDhvGNlTN+XatBU5LlrQgDci/cs/DF1CXHS8xbqYgpNdAg8
	 UHwk69PoPcRO3T+0npKq6KA609uno9gjzqEwnQQk=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 28 Feb 2024 08:36:37 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id A91D28029D;
	Wed, 28 Feb 2024 08:36:37 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 9D67318101D; Wed, 28 Feb 2024 08:36:37 +0100 (CET)
Date: Wed, 28 Feb 2024 08:36:37 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v2] kconfig: menuconfig: Make hidden options show with
 different color
Message-ID: <Zd7ihcWdm8ts__yQ@buildd.core.avm.de>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
	linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, Jesse Taube <Mr.Bossman075@gmail.com>
References: <20240228060006.13274-1-tfiga@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228060006.13274-1-tfiga@chromium.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1709105797-2E83FE5D-501D462F/0/0
X-purgate-type: clean
X-purgate-size: 1414
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Feb 28, 2024 at 03:00:05PM +0900, Tomasz Figa wrote:
> When hidden options are toggled on (using 'z'), the number of options
> on the screen can be overwhelming and may make it hard to distinguish
> between available and hidden ones. Make them easier to distinguish by
> displaying the hidden one with a different color (COLOR_YELLOW for color
> themes and A_DIM for mono).
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  scripts/kconfig/lxdialog/dialog.h  |  5 +++++
>  scripts/kconfig/lxdialog/menubox.c | 12 ++++++++----
>  scripts/kconfig/lxdialog/util.c    | 19 +++++++++++++++++++
>  scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
>  4 files changed, 50 insertions(+), 4 deletions(-)
> 
> Changes from v1:
> (https://patchwork.kernel.org/project/linux-kbuild/patch/20231228054630.3595093-1-tfiga@chromium.org/)
>  * Replaced A_DIM for color themes with COLOR_YELLOW, because the former
>    has no effect to black text on some commonly used terminals, e.g.
>    gnome-terminal, foot. Reported by Masahiro Yamada and Nicolas Schier.
>    I ended up with COLOR_YELLOW, as it seems to look comparatively dim
>    with mutliple light and dark color themes in Chromium hterm and
>    gnome-terminal.

Thanks, output looks good to me on my console as well as on all my
terminal emulators and in all themes.

Tested-by: Nicolas Schier <n.schier@avm.de>

