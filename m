Return-Path: <linux-kernel+bounces-49265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BCA8467F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021011C24A85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423417596;
	Fri,  2 Feb 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="o15p/M4Z";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G092jmu9"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092871758D;
	Fri,  2 Feb 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854729; cv=none; b=vEv8N4N+qrGMzagOw6Rjxz9rqa2alNHllrTk+8cZM4mPrMvaKFN07Wip2x2UHHgmqZOLg1gFA+tYRteohMUQLIJPYwBsuC0jfj60cXbxGZE4gK25Yro56/8grfwYAl4b95I5I7SeOBsi1VhPwgf1YZfVNQUXhVK8HnpDRr6tdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854729; c=relaxed/simple;
	bh=7aSFtMWxyruiW2XGYS9sj6ZEUHr9W1gcJK7SdJMgrQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxEwA7DkCvWR1QQd6GZ+tGa/ENRZj0mJnxVWUUjxUH69bEg4s9J+sozr8he1KA8HGNU5ISJqUqkblz8aXgJXh9oRFgJ/bTkCKu/DWPhoae3xyAyWcFYkNdzedERYR2AijO4j2VZU8J73fbb2jirYW5erP2J7RhoEgrJf3pA80T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=o15p/M4Z; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G092jmu9; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706854726;
	bh=7aSFtMWxyruiW2XGYS9sj6ZEUHr9W1gcJK7SdJMgrQc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=o15p/M4ZGbNijUsuVCmGazuJgcdZ88LsR5H3/8XZI5QftvAWt0FPekWPOFyd6ToHa
	 KYn3v3queevyDmuE2QgiMhZqTkZJlpnCuZGVao45brBP2PmdnQdLfZdLW3LujMau3D
	 +Uet+IP0Vpoly2IFBiKUM472QbHzSacVwFi3dkGk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F0931280599;
	Fri,  2 Feb 2024 01:18:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id neMQMEfg8vx4; Fri,  2 Feb 2024 01:18:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706854725;
	bh=7aSFtMWxyruiW2XGYS9sj6ZEUHr9W1gcJK7SdJMgrQc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G092jmu9zocnFxifE/41kZxZ7zu0Zfnz+5eXhGw2faFyNM/EJS0TN2KuidNi1GRj2
	 mwA+UYynkOmJbq2zaRez4TXIJD56Hiq2ZNEQjTCjIdrnvIkB37AQJai63h/iK5QfRD
	 Im1B4MEAklKAEXq222KRodq7U/C4faXfxWVqQoR4=
Received: from [172.22.1.109] (66.224-78-194.adsl-static.isp.belgacom.be [194.78.224.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B308C1280475;
	Fri,  2 Feb 2024 01:18:43 -0500 (EST)
Message-ID: <c291d11119295740b846a382ba6df4bd57bda03e.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 3/4] tsm: Map RTMRs to TCG TPM PCRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, 
 "Xing, Cedric" <cedric.xing@intel.com>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, biao.lu@intel.com,  linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 02 Feb 2024 07:18:40 +0100
In-Reply-To: <0c396883-6eb7-4ee9-955b-42e365a737cf@linux.intel.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <20240128212532.2754325-4-sameo@rivosinc.com>
	 <0c396883-6eb7-4ee9-955b-42e365a737cf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sun, 2024-01-28 at 14:44 -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/28/24 1:25 PM, Samuel Ortiz wrote:
> > Many user space and internal kernel subsystems (e.g. the Linux IMA)
> > expect a Root of Trust for Storage (RTS) that allows for extending
> > and reading measurement registers that are compatible with the TCG
> > TPM PCRs layout, e.g. a TPM. In order to allow those components to
> > alternatively use a platform TSM as their RTS, a TVM could map the
> > available RTMRs to one or more TCG TPM PCRs. Once configured, those
> > PCR to RTMR mappings give the kernel TSM layer all the necessary
> > information to be a RTS for e.g. the Linux IMA or any other
> > components that expects a TCG compliant TPM PCRs layout.
> 
> Why expose the mapping to user space? IMO, the goal should be
> to let user space application work without any changes. So we should
> try to hide this conversion in kernel and let userspace code to use
> PCR as usual.

There's also the question about use case: if we're going to measure
into RTMRs as though they were PCRs, they will need to collect the
kernel measurements as well, which means the mapping will have to be
fixed in early boot when the first TPM measurement is done.

James


