Return-Path: <linux-kernel+bounces-77532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9008606EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDA01F24917
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EC13BAEE;
	Thu, 22 Feb 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiqQjQXk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474D17BDC;
	Thu, 22 Feb 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644089; cv=none; b=gw82owJN3IHfm1+bSXLmM/+ZkPwd7C7WbFViOGnVsx5MVaiSS4QOjHnTiPpO5isNLrEb1/Q/Gafdlue/I9SY/izQ95oPLOhs1ktiFeOSDR64MEJHOv0ErGYYQzVjXel0NVBZ1dApNpCDoe29OjF1TIIlGU7RMB5Dtt5c3vriE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644089; c=relaxed/simple;
	bh=pZp7Cq133hnhkzb3KGXJsaA22cEGiiFZa+XYZJG7R0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ4SuLVbcrPPf8r8qUTF035IoHXwxITnHSSet96NAkLq1cqIkm+S9KOz5xO/48eRETWZOtptMpn6WMRA31QMP4cXShEf3B3NUbwclXhMdC3lYtGPfWMCzGwN3Btb7V8AnloDTDJoFW3v8cZLIwE0+KsL0FfcZ3xs/E4Fkp8l+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiqQjQXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A9C43390;
	Thu, 22 Feb 2024 23:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708644088;
	bh=pZp7Cq133hnhkzb3KGXJsaA22cEGiiFZa+XYZJG7R0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiqQjQXkvHAkwxOmbJpU/abDHDhqW3BwbtLiBlgGnSHmmZHS6Cml46j5by8cofClW
	 c768ET0gPfKlPrjPx8SXhB7Rlq1omIIPJ88tumE7/aratGKS802tl6DdD5e1aLwtVu
	 kLEiApQYynPdY7bwyROSOpZeEXL5FRcTNDxsWNBAqxl554eNKJ5IyRt2WtiHtIfv9F
	 BEZBqCBDAXIRG0Jkutn59CK+sZWSplR4L+mIFfRlkLYznSEN+LHrVNOjW3Q4xhzZxZ
	 FOhsFCpiU/aybRtAHvC0uc6eCuA3xjgwY47D+7ZPp3Mm3jUSZwsD5epm49NMfA/4sb
	 0vXssyHoN2gNQ==
Date: Thu, 22 Feb 2024 16:21:18 -0700
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: lee@kernel.org, alexandre.belloni@bootlin.com,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Conor.Dooley@microchip.com, thierry.reding@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@tuxon.dev,
	Hari.PrasathGE@microchip.com, airlied@gmail.com,
	Manikandan.M@microchip.com, sam@ravnborg.org,
	u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
	conor+dt@kernel.org, tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org, bbrezillon@kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
	daniel@ffwll.ch
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <20240222232118.GA3786028-robh@kernel.org>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
 <20240220082026.GG10170@google.com>
 <9dbfbeac-3a00-4571-95c0-83e4d47737c5@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbfbeac-3a00-4571-95c0-83e4d47737c5@microchip.com>

On Tue, Feb 20, 2024 at 08:30:38AM +0000, Dharma.B@microchip.com wrote:
> Hi Lee,
> 
> On 20/02/24 1:50 pm, Lee Jones wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:
> > 
> >> Hi Krzysztof,
> >>
> >> On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 08/02/2024 11:43, Lee Jones wrote:
> >>>> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> >>>>> Convert the atmel,hlcdc binding to DT schema format.
> >>>>>
> >>>>> Align clocks and clock-names properties to clearly indicate that the LCD
> >>>>> controller expects lvds_pll_clk when interfaced with the lvds display. This
> >>>>> alignment with the specific hardware requirements ensures accurate device tree
> >>>>> configuration for systems utilizing the HLCDC IP.
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> >>>>         commit: cb946db1335b599ece363d33966bf653ed0fa58a
> >>>>
> >>>
> >>> Next is still failing.
> >>>
> >>> Dharma,
> >>> You must explain and clearly mark dependencies between patches.
> >>
> >> I sincerely apologize for any confusion caused by the oversight. I have
> >> organized the patches according to their dependencies in the patch
> >> series, but unfortunately, I neglected to explicitly mention these
> >> dependencies. I understand the importance of clear communication in our
> >> collaborative efforts. Please feel free to provide guidance on how I can
> >> assist you further in resolving this matter.
> > 
> > If this continues to be an issue, I can just remove the commit.
> 
> There won't be any issue if both pwm and display binding goes before the 
> mfd binding.
> 
> Could you please pick the display binding as well?

As this is still not resolved, I've applied the display binding. Not 
ideal, but should fix next.

Rob

