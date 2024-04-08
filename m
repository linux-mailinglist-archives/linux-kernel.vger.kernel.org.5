Return-Path: <linux-kernel+bounces-135181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4D89BC55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4011F2272B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87124D5AB;
	Mon,  8 Apr 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GKv1ole8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6013838A;
	Mon,  8 Apr 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569938; cv=none; b=bUrjHEiClInC1tGhvwWr8oeQdGqAaWY4XQGbYSqWgcj3szZOnVtuYKVAwAiBEzI8K8gtcOLiipaM/FCu48C1zXGS5sIcJhR/as77bSk3pnZRZrUKcWz4GZsBza/ORP8f7tl3guP5qGr3tyUi2L7WQWCeSPGoyTgIVqS9ccoyio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569938; c=relaxed/simple;
	bh=h9u03pKB9im7wZojVwvS6T6rOtJZ1RtaIgT27riouQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhlzqUngN0U6RaGd2ohZOFSaiU2hZ6fd2buYx+fZTbb3o2boJ7ek7Px6fMuB9FKsREa5Q1Dey8MaQiV1Ch7lBTg7bETWNiAru9BLsxZ1wcTQzFudrlveMHY1zMt/kAnz/yrZWDEKYaTkLOQbedJDJ2yeAPFq+3lFb6LoIT58kAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GKv1ole8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 05E0F1F930;
	Mon,  8 Apr 2024 11:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712569924;
	bh=kRn+TEiL98Irs+PaKizAbAibCQXM1ve6O3O6LyKdnW0=; h=From:To:Subject;
	b=GKv1ole8KHs1GaBbGAS7IRjN0LdEzUfrrVbSvQSAWlKyxa0fcezHRyk1bTkk3Acbc
	 u+kySILnr+HfdlrOvf72CG4PYyplKczBAwmZU9TB4VbeGhyWt1EduWjSfiIrsHWG4F
	 mTSMKNdwJhYahHcr/0v0YnfSnlpk16l9fjg+qxDLBruU25BMo0p6we4vZgMctGcRMH
	 xsueJW2/KwdHenVt7Gn4SgMMLciqDWfRMmFgoJf9pNblav8zUwAL50SB0ODx8Eg6Du
	 fMgGncV0oiK0ZYl5eFhBmaGlIRFughvfoApuLPptwRT1FSTBKXSAAEkBjvCTzzzb59
	 K7lRlmC9ymjUA==
Date: Mon, 8 Apr 2024 11:52:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-am62*: Add PHY2 region to USB
 wrapper node
Message-ID: <20240408095200.GA14655@francesco-nb>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-6-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201120332.4811-6-rogerq@kernel.org>

Hello Roger,

On Thu, Feb 01, 2024 at 02:03:32PM +0200, Roger Quadros wrote:
> Add PHY2 register space to USB wrapper node. This is required
> to deal with Errata i2409.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

What's the status/plan for this? v6.9-rc misses it and therefore we have
this error in the logs (and of course, we miss the workaround).

[    0.583305] dwc3-am62 f910000.dwc3-usb: invalid resource (null)
[    0.589304] dwc3-am62 f910000.dwc3-usb: can't map PHY IOMEM resource. Won't apply i2409 fix.

Apart for the error message, the change here seems required for the
hardware to properly function (IOW IMHO it should be back-ported to stable).

Francesco


