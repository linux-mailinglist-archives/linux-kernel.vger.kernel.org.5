Return-Path: <linux-kernel+bounces-29587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A583107A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F554288F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059020FB;
	Thu, 18 Jan 2024 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="COkt9DOm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9615AE;
	Thu, 18 Jan 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537625; cv=none; b=bYmqsghoUQBakT+xoNlF5GtS4Y6COVlG2fbxBFwP3JipS9KPCq5RIPn72zzVbyTEg6+O4qY5Ffjyw+Mthja7oR7BbjlJeQ04ya8xK5/VA0lIblrNgFCxf7fqNvxWiQVb3B/vavtElUl24XczUwdAMqjBm1cLKyvMKq8vwAiIC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537625; c=relaxed/simple;
	bh=RdDvEPiIXKnKbugI6nPGUDIoOTxGfWQJZu0ZJfQETbM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-GND-Sasl; b=BY/9KBZVnjcV/MLc7zSzeQDSeI8H6bIMNszGhWSPpOhvhnRgINhIC+L2DBtgpHG6B6lvDb7fFzB3g5SVmYEiSmDVXw+iG/10vPoZkSDAJonMTKWrNJWqLShk4f4/LTRu6n4TWGeT+moyPu4z2kAW1SAe0DV5RGFuEUO1HudBlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=COkt9DOm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C3ED1C0003;
	Thu, 18 Jan 2024 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705537615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKYFGoUuIzNOJs0li/eVN3iRdyzoeA5zFjlLReuI070=;
	b=COkt9DOm7yPAOILdqq4JT4XuNiK1UeLzrSc3Ss/hUtOThdk6Yz5eO8SUOlbBgVjvE05ne5
	zRURc3ykJX7UAa4bIt8/0o5oC6uNaBhfwrEIdrsbkTpOApgHkADg0LslLe72c1PVDCNXQM
	PVskoI3FBimfFzutxrKaRKmlEk647/YNYbeLGqV8gl8bjO9rpibZYlC3PC6p0J0PA0vGIV
	uAroepxkwN6m61e26Usgv985Yy3lBtpcRIuPMRPfEH5PIN71O9lNEoXLmJ6c5KabnkV/o5
	sYq1Y02xl1CrBI0YA9YF/8WrhCHfq9Uskqu/K4Hi+9oN77al+C5Xvqr/3JcCuQ==
Date: Thu, 18 Jan 2024 01:26:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
	KFLIN@nuvoton.com, mylin1@nuvoton.com,
	Mia Lin <mimi05633@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Message-ID: <170553758518.493564.2240744858359002334.b4-ty@bootlin.com>
References: <20231113103807.1036978-1-mimi05633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113103807.1036978-1-mimi05633@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 13 Nov 2023 18:38:06 +0800, Mia Lin wrote:
> Changes since version 7:
>   Fix the part number parameter checking issue.
> 
> Changes since version 6:
>   Move the part number parameter to struct nct3018y.
> 
> Changes since version 5:
>   Add global parameter to store part number.
>   Remove unnecessary changes for easier reading.
> 
> [...]

Applied, thanks!

[1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
      https://git.kernel.org/abelloni/c/14688f1a91e1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

