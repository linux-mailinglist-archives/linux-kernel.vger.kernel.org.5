Return-Path: <linux-kernel+bounces-90214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F686FC08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702F31F22E09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008711A29A;
	Mon,  4 Mar 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIha+gAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD519472;
	Mon,  4 Mar 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541650; cv=none; b=fsTyHO+pMVy9qlZbv8m0/xrhqvT/nGnsOlj05BjjflJWwZinFaYScJr5q4fJvkqlK6guwv6rG7ZKR98iyGFBYOiXLQd127clgYF23Pm9qHibE/01gtIzXGxxEEZ8V0tUUBNVJbwBnGrw+uapMw9askxwqLyXwpd7sEQHuGN98SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541650; c=relaxed/simple;
	bh=t1T3OPaWjo53wfG6TOrATqy44YsWokKu6HeHAougC1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Viip6tdYtwNQ+pwkD2Xzue4CVUcEedHdLUxtbKAKYMS/nleisHs7GV6pO5GIF4Rp4RHyCea8k/NPi5/r4z6WD2y14cq+r5/CBXIfYd4he8PUGgEL+r/76lRQTTWH6Q+mbIHzwTJn6VWL2fAlHbTb8EvLvBew2OkbkmkaIfr2jAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIha+gAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C71C433C7;
	Mon,  4 Mar 2024 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709541649;
	bh=t1T3OPaWjo53wfG6TOrATqy44YsWokKu6HeHAougC1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIha+gARcNYuhSwcukKIYg4p45pb6A8Eb1BoGaDioSXtNDt/XHo9+tu0OWSVMTEDA
	 TCdLZhy/DEYy3mXFG+TLdphs/qsaLNPSRkHtzvVQYJn2flmCpGyYwREyE7oQKo6+3B
	 ab1V4gnRlHvDLwrqCQ2HaaJ/uW1j7jwnDDI/78dkQiPBsu5gqoaWB8AVtadiHrg7Kw
	 weBRT0t9pBuAWt/8MA0WpUtAj0ffodEALaUXLIezNXPWFwitJn+nQL6uYga8eqMPRH
	 9CFfdeOxkoh47pFCQwDEodcKaXFs0+9NHo3NzvtQdxPprBAvT5REFms3RWYuvcrmdY
	 vOUUDcyUeUSFA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh3sW-000000006DZ-199L;
	Mon, 04 Mar 2024 09:40:56 +0100
Date: Mon, 4 Mar 2024 09:40:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v15 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZeWJGCsUiZFw6ECl@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-3-quic_kriskura@quicinc.com>
 <ZeBSp0EWnHo8Wbsv@hovoldconsulting.com>
 <c4607aa4-7af7-443f-8ccc-aa4fe3ede3cc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4607aa4-7af7-443f-8ccc-aa4fe3ede3cc@quicinc.com>

On Thu, Feb 29, 2024 at 05:23:08PM +0530, Krishna Kurapati PSSNV wrote:
> On 2/29/2024 3:17 PM, Johan Hovold wrote:
> > On Fri, Feb 16, 2024 at 06:27:49AM +0530, Krishna Kurapati wrote:
> >> Currently Multiport DWC3 controllers are host-only capable.
> > 
> > I already asked you to rephrase this so that it becomes clear that you
> > are describing a property of the current hardware (and similar
> > throughout the series):
> > 
> > 	https://lore.kernel.org/all/ZTI7AtCJWgAnACSh@hovoldconsulting.com/

> IMO, the statement is describing a property unique to current hardware, 
> that "If it is a multiport controller, it is then host-only capable"
> 
> I used the word "Currently" to indicate that "Today, the multiport 
> devices present...". Let me know if there is any ambiguity in the sentence.
> 
> In v13, I wrote:
> "Currently host-only capable DWC3 controllers support Multiport."
> You were right. It was ambiguous as it might refer to even single port 
> controllers.
> 
> So I changed it saying all the DWC3 multiport controllers are host only 
> capable.
> 
> How about:
> 
> "All the DWC3 Multi Port controllers that exist today only support host 
> mode"

That should be clear enough, thanks.

> >> +	/*
> >> +	 * Currently only DWC3 controllers that are host-only capable
> >> +	 * support Multiport.
> >> +	 */
> > 
> > So again, also here, rephrase the comment so that it is clear that you
> > are referring to a property of the current hardware.
> 
> I put the comment this way to indicate that we don't want to check for 
> existence of multiple ports if the controller is not "host-only" 
> capable. We should only check for multport support only if we are 
> host-only capable. I think the statement clearly tells that "check for 
> host-only" configuration before proceeding to check for xhci register reads.

Fair enough, this comment could be considered to apply only to the
implementation. Perhaps the following would be more clear though:

	Currently only DWC3 controllers that are host-only capable
	can have more than one port.

or simply

	Host-only capable controllers can have more than one port.

Both of these also gives a hint that this is a property of the hardware.

> I replied the same on:
> https://lore.kernel.org/all/279a54f2-7260-4270-83c7-d6f5c5ba0873@quicinc.com/
> 
> And since you didn't mention anything else at this part of code in your 
> return reply in:
> https://lore.kernel.org/all/ZTYyXhyZN3jBXEfm@hovoldconsulting.com/

I left in the following quote on purpose in that reply:

	> > Please rephrase accordingly throughout so that this becomes clear.

Johan

