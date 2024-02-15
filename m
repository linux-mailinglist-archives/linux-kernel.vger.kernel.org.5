Return-Path: <linux-kernel+bounces-67604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C4856DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B005A1C236A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9E13A89F;
	Thu, 15 Feb 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="dFtui1+D"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BE13A252;
	Thu, 15 Feb 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026145; cv=none; b=hO3gA16k9BuoKtb3U5C00u0itsjfP8u1FMbz/c0QlqbIw2gTGhJQDGXmOvNVykgOz5B3vQ0n0F7Vyrk0uKxsZfoGHciq+ozVP4Ckghmx8sHfSdl8Wcy4Z712oQPWMRVGmc+/7es/KP2xRfEnmRaDTTOZsu4Em/hPOqg4hfwozZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026145; c=relaxed/simple;
	bh=4qLmN4QeIb1XHEXWSfCSf+PqwEjw73xNNLMKPiCBaOs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PvyupocbXxsMW+cDRVgL+pu3RTnKHcvolV+1LbsSt1Outa1Wax7aJKwvEEbuEMA0ulmlb2wI5B+G/F5gAgoBlotvqhoYWf3VT6udkGVFwpQZUiKzTm8nCcjSrNdTHQYTlFebwkddf7KgkQjYK5IcPfeymhdTMQ/ZLqab5DazdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=dFtui1+D; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D89459C2B79;
	Thu, 15 Feb 2024 14:42:14 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id czNSXTnX_0Np; Thu, 15 Feb 2024 14:42:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3A8219C45E9;
	Thu, 15 Feb 2024 14:42:14 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3A8219C45E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1708026134; bh=d0kaTdAspeMgz7/MP6qC8ExPvkrFjxSvhwBGjWMBF3c=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=dFtui1+D6xeFRwkukPMrjqdBh9H1FWX42dXfOVsL3fJ0JLhtKvMrf2xlZAyXrUYO7
	 Of6Fe547fJ+HFh8jqFkuU4O0Lngi9+u+5haXhB0M3LJsnVXjTChWSaq645ZG6obVwv
	 IXa/+eg3quyWkYhpCWCPotjPaPhtqQ2iwntABdkVVWRtzrg46hMrU1ZyTIai2WvyEo
	 Q3O4SbACYkH8W48o7nxJcwoH5wna0r3wguFkBw44ABlDfxuAJPuOwsCrZgl+FaBeou
	 5T32jxrRZIO046MTicgqygNWWuiqvHma1inGwCORA7JVJ4vgl48fSKy0plgDsgInmb
	 A/yhs+mk23fDA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P9_wQCFyOOFl; Thu, 15 Feb 2024 14:42:14 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 066379C2B79;
	Thu, 15 Feb 2024 14:42:14 -0500 (EST)
Date: Thu, 15 Feb 2024 14:42:13 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	kishore Manne <nava.kishore.manne@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <747282644.1027419.1708026133594.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20240215133240.GA4061942-robh@kernel.org>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com> <20240207180142.79625-3-charles.perry@savoirfairelinux.com> <20240215133240.GA4061942-robh@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: fpga: xlnx,fpga-slave-serial:
 rename gpios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC121 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-serial: rename gpios
Thread-Index: 8UFoOUIQo66Y04KiBhC3i+CHQF5HTA==

On Feb 15, 2024, at 8:32 AM, Rob Herring robh@kernel.org wrote:
> On Wed, Feb 07, 2024 at 01:01:25PM -0500, Charles Perry wrote:
>> By convention, gpio consumer names should not contain underscores
>> (prog_b here) and shouldn't contain active low suffixes (-b here).
> 
> Yes, that is the preference, but we are stuck with supporting the old
> name. It is not worth it to carry both in the binding and kernel.
> 
> Rob

Ok, I'll go back to "prog_b", "init-b" and drop patch 2 and 3 for v4.

Regards,
Charles

