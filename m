Return-Path: <linux-kernel+bounces-57555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C784DAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320701C25051
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35576931C;
	Thu,  8 Feb 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lcNZ7+7W"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA3692E6;
	Thu,  8 Feb 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377151; cv=none; b=DRAnvyPk2pkDLthuxvuwbgk+34nAobi3zmslo1MSdjK6Jhw0LppExceAi1F5kI1LY33b0N/idXBAA8Jcm+UHluF4coAar9qRLba2CGlNtQowDQfP1S7N0ZEIFna9pW1c51xkD4ipZb/Aoso///5Ytv+lJmHn4kS1DoalFN6rg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377151; c=relaxed/simple;
	bh=41KwG3vJADHMuHujGJyY2jjsxuWXKTjEMonTcvE50ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLRj0zZ0v3aK8uz7rr1twtp1T2QsCTsAHyKshYJrKHfFC4QTmUtDDmSMG+czD1Vo8wAXeqvTf8vElWuwANrpXuRo61/ok6jooCadQeaYtpEQZX/8MGDfBswND/tr+PFEyhaQDEfHAWoygW7z9ZmLtnLB4cihxGYV1ZBjPsovaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lcNZ7+7W; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9666B22B38;
	Thu,  8 Feb 2024 08:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707377137;
	bh=TNDCcfkk7812zjJTBuRizX3i5SwZAFC4qeTbhvgpvqU=;
	h=Received:From:To:Subject;
	b=lcNZ7+7W1Ah6LrSqZz7ISDobRfE5LIKYfi+pmjqeTkngTqVCCQkfyAc4SLqvqpfnb
	 XukL50J/4tQtjL1w570FKj45x/BUUd26e3e8AQFLeJRLiZPWE05HEjdNyIiC/e038O
	 pLvJozMXWbWpewjqcl220TCD9ZHz+mbWGk5pZa+pOOO3/qd0QuEwEfMktfAFHIktkK
	 7SWtBqKt6KO4y4E8N+EpiSvCWKbrKcM2ZE7om/ed0z+Tsd4uE+m2fvG8patee+Ga0x
	 EY/KS8jpgFKpHCgKL+H7r1s9JzIh1vL4yoJKe30GLJ5IW7uIzuetJhn+nNY81clnzu
	 y1NW3L1cB5aLA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id B4C527F9D7; Thu,  8 Feb 2024 08:25:19 +0100 (CET)
Date: Thu, 8 Feb 2024 08:25:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Rafael Beims <rafael@beims.me>
Cc: David Lin <yu-hao.lin@nxp.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>

On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
> On 30/01/2024 04:19, David Lin wrote:
> > > From: Rafael Beims <rafael@beims.me>
> > > On 22/12/2023 00:21, David Lin wrote:
> > > > This series add host based MLME support to the mwifiex driver, this
> > > > enables WPA3 support in both client and AP mode.
> > > > To enable WPA3, a firmware with corresponding V2 Key API support is
> > > > required.
> > > > The feature is currently only enabled on NXP IW416 (SD8978), and it
> > > > was internally validated by the NXP QA team. Other NXP Wi-Fi chips
> > > > supported in current mwifiex are not affected by this change.

..

> > > > David Lin (2):
> > > >     wifi: mwifiex: add host mlme for client mode
> > > >     wifi: mwifiex: add host mlme for AP mode

..

> > > I applied the two commits of this series on top of v6.7 but unfortunately the AP
> > > is failing to start with the patches. I get this output from "hostapd -d" (running
> > > on a Verdin AM62 with IW416):
> > > 
> > > nl80211: kernel reports: Match already configured
> > > nl80211: Register frame command failed (type=176): ret=-114 (Operation
> > > already in progress)
> > > nl80211: Register frame match - hexdump(len=0): [NULL]
> > > 
> > > If I run the same hostapd on v6.7 without the patches, the AP is started with no
> > > issues.
> > > 
> > > Is there anything else that should be done in order to test this?
> > > 
> > > 
> > I applied patch v8 (mbox from patch work) to Linux stable repository (tag v6.7.2).
> > Both client and AP mode can work with and without WPA3.
> > 
> I went back and executed the tests again. I re-applied the pach on top of
> tag v6.7.2 to make sure we're seeing exactly the same thing.
> 
> At first, the behavior I was seeing was exactly the same I reported before.
> Upon starting hostapd with our basic example configuration, it would fail to
> start the AP with the error:
> 
> nl80211: kernel reports: Match already configured
> nl80211: Could not configure driver mode
> 
> After some investigation of what could cause this error, I found out that it
> was connman that was interfering with this somehow. After killing the
> connman service, the AP would start correctly.
> 
> I want to point out that this behavior is different from the unpatched
> driver. With that one we don't need to kill connman in order to start the AP
> with hostapd.

Any idea what's going on in this regard? Is such a change in behavior expected?

Francesco


