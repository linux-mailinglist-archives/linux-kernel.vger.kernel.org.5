Return-Path: <linux-kernel+bounces-131106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA1898326
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2760284033
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62B6CDCA;
	Thu,  4 Apr 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OC3+P/km"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D56E61E;
	Thu,  4 Apr 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219302; cv=none; b=IVMhin9TBCw5PPbV3vjHb6ZzJyS+V6cqnmdM3VFLp+45fQV3t35bWWEXbxIYOCrLrf1WT8NhRalP7y61fej1PTdzA1W76gUMElgHhfuFLm+lPpKOER5i/Z5F0SkrY8410j5RuRimI5UdfDnkzC3/YHnVwR1u8nLndbSnD5AUhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219302; c=relaxed/simple;
	bh=m97YoINjiwQ3cExQML/3dSxCuCMvCT7E3eyBOPUhUnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+9xL1b1Gy0guk+iYcGwcdWyK1jAktrd2eMC9xOzeeSMXVypyOVPZRTJcHAL5twKKslxaN2AV1XzWJbXq9+QQlaKELV7g/KtdB57ddtihnfODl4qoaYmIguertUdpw7qWKLDjjufvbU6J4Qs9nYTiBZd0IGI8JnwaFWUeBQ4Bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OC3+P/km; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 36A591F91A;
	Thu,  4 Apr 2024 10:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712219298;
	bh=m97YoINjiwQ3cExQML/3dSxCuCMvCT7E3eyBOPUhUnk=; h=From:To:Subject;
	b=OC3+P/kmGcZK4wtJSI1mwXZJ7nyzCDLoXgz45yFAv0p66/KW1TrggOsuDitTCa4el
	 q/O7e/ngB+UZpNJihiIkv9SshxIWBQIkNAmzOdyGHeIn1yegIgrSCpu241xtANP3fn
	 d2bmH3+tfIr02fwihawepjbHLSLPUqPAnjb6JFzosK4Ad5HzavuchdrV6FulSVaYr6
	 ryZQoqpN99q/gdFZtnGCSPYcNkIBGGhRruvwHgIDRVTANEqzPQWZBMiHJNx0ieaXpy
	 sdv2IS389XSnC6+lwyVQdT2dTI43cSIuOj314DdXzlmYmYysm+/Vxx2fEd1G8ZuRNN
	 UdC+90xTJCWmg==
Date: Thu, 4 Apr 2024 10:28:14 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
Message-ID: <20240404082814.GA8722@francesco-nb>
References: <20240403212426.582727-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403212426.582727-1-jm@ti.com>

Hello Judith,

On Wed, Apr 03, 2024 at 04:24:26PM -0500, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window
> is open. Fix min_hw_heartbeat and accommodate a 5% safety

Fix => Add Fixes tag + Cc:stable ?

Thanks,
Francesco


