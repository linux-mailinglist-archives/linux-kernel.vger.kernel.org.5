Return-Path: <linux-kernel+bounces-98770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48907877F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0181F21D24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7073B78B;
	Mon, 11 Mar 2024 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SrUb7nx6"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D911187;
	Mon, 11 Mar 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156973; cv=none; b=eo7Poqpk1orI0I7Sa3dprpkZrXlyYrRbTbgBtp4+g5A8L0PRPynUZF7xODq0mHyGV8LZAxR0zqBO+iEsRDEAZO/7TWjBYfQr45l9t9leYPLsPVCG/wDWtT1KIHaZS1b9CG125PmxEngeGipFQW6SgWlx5Q0KNwsnCX8f16W7Eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156973; c=relaxed/simple;
	bh=Fa/ucm725FyyWh4vLGlZ8mVa9jvhTNbD3PEA+Vj5CXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2dESqIs8YGaFAjhbumgaNh3YZLM9zSVSmjSnzCAWsTWW9XWXOKEj7xYg36fe7OUCvbv+yOxuDCcEAWIDmxIfkB/9knEPVgU5FG/rSPugEAnNx8EOx13xJhFcp5pZcsBQaoJdjh4dAf/Ogya9/J9hkNRZ9I/8+KYeDfFSuW0VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SrUb7nx6; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8LeEh004167;
	Mon, 11 Mar 2024 06:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=B2yXBVF4yQav2XX
	ZoUDETCycEZxy7aTCa2+3bNy7YGc=; b=SrUb7nx6GggKJSCf02xDbS3N0IZmvY5
	GcrKqlxgI4PFKruRejF25HGkejPxu9v5FMx/77l3yDhOgjWARu0iT3LmZxjVLPDy
	txFaeao0HVzCNHEhjeI5han+pXvmPxCgFFSPsamijmH3PFtQBji3xAhMJIXq724k
	ISGEiWVh3aAEFzYxqtcP+xlRSka/OQqFFI2qRmjxpJU6HSSenaBwJcpZGawdvpg5
	oRKKW3U8QFxNJl8UWO/bclJI6HzN6bnIsj22xqeLgqvkUKe+LAHpyOpZ4VktSDLc
	MfAEOsvAjduMBCpR+08ORWU8y6yhNNh1cdddcj+zp9CNY5uc2taJsYQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wrn2psv51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:35:56 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Mar
 2024 11:35:54 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 11 Mar 2024 11:35:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 7AACC820270;
	Mon, 11 Mar 2024 11:35:54 +0000 (UTC)
Date: Mon, 11 Mar 2024 11:35:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai
	<tiwai@suse.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [RFC PATCH v1] ASoC: wm8904: enable fll with fixed mclk
Message-ID: <Ze7smWSeoCVIcxIo@ediswmail9.ad.cirrus.com>
References: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
X-Proofpoint-GUID: jZaxHSgbLbEIBShIBsJsTeVhjz7k_AtH
X-Proofpoint-ORIG-GUID: jZaxHSgbLbEIBShIBsJsTeVhjz7k_AtH
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 08, 2024 at 04:58:31PM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Dear all,
> 
> This is an attempt to change wm8904 for a scenario when reference clock
> supposed to be fixed to a particular frequency, but is not configured as
> a fixed-clock. While this change is working fine, I'm struggling to
> finalize it, not being able to find a proper solution of adding a check
> whether we want to use fixed MCLK with codec's FLL or not. I could, of
> course, introduce a new device tree property, but do not feel this would
> be a proper way forward. Hence, I'm sending out this RFC patch to gather
> your valuable feedback.
> 
> DUT: Dahlia carrier board with Verdin TI AM62 SOM.
> Audio card configuration can be found in ti/k3-am62-verdin-dahlia.dtsi.

At some point one really starts to question if this is really a
"simple card" any more.

> On systems with a fixed reference clock output rate it
> is impossible to use this clock for all audio frequencies.
> 
> Following is an example of playing a 44100Hz audio on a system
> with a fixed 25MHz reference clock applied to wm8904 codec,
> in combination with simple-audio-card without mclk-fs:
> 
> [   27.013564] wm8904 1-001a: Target BCLK is 1411200Hz
> [   27.013601] wm8904 1-001a: Using 25000000Hz MCLK
> [   27.013611] wm8904 1-001a: CLK_SYS is 12500000Hz
> [   27.013654] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [   27.013663] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> [   27.013671] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
> [   27.013680] wm8904 1-001a: LRCLK_RATE is 35
> 
> This leads to a distorted sound and this configuration is unusable.
> 
> On the other hand, configuring simple-audio-card with mclk-fs will
> force the system to change MCLK frequency, which supposed to be fixed.
> 
> This change forces to use wm8904 FLL while keeping SoC's MCLK
> frequency intact:
> 
> [  234.108149] wm8904 1-001a: Target BCLK is 1411200Hz
> [  234.108304] wm8904 1-001a: Using 0Hz FLL clock
> [  234.108722] wm8904 1-001a: FLL configured for 25000000Hz->1411200Hz
> [  234.108794] wm8904 1-001a: CLK_SYS is 1411200Hz
> [  234.108835] wm8904 1-001a: Selected CLK_SYS_RATIO of 64
> [  234.108875] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> [  234.108913] wm8904 1-001a: Selected BCLK_DIV of 10 for 1411200Hz BCLK
> [  234.108955] wm8904 1-001a: LRCLK_RATE is 32
> 

Hmm... the driver already provides an option to automatically
configure the clock. Is the issue here that in your fail case the
machine driver never calls wm8904_set_sysclk? Or if it does call
it, when and what parameters is it passing?

Thanks,
Charles

