Return-Path: <linux-kernel+bounces-106082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E889287E8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5A0283647
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96BD37162;
	Mon, 18 Mar 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="G3/PGZ+e"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E6364A4;
	Mon, 18 Mar 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762098; cv=none; b=KeTh6QiitmxNTtCW4hp2/phT3eJ+164ImvM64w4WWVukHQfHt2tIUPjmQHeMNPSaycGC8yFSPcBK6fnzNv9V9GC7CtLXcXewRqeyS4RKR7Vpr4//F2nqsiWQYjWUhICuiWToQTDSLO98hKLkc5C9SjWd4ewEJbLIL96Sw86o4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762098; c=relaxed/simple;
	bh=qW/yCs7VHd6TxBtdV7sUo/1MSWHIPbqNVftyIqwqeTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx8M2TFWG7eSNzpxm30tKOqUeuWFIwj21Bsd0w1nPT3pr2i/by+00XIqjp/Ay8E4LaqHA+aR+hxSV5ZDPLoRJ04yDZGDYCla8miRPkH0WEgvsnsD565TOmxlJDEBP133M/0TJuniWr64DQ8iS0EtKw37CnOK1OrZx0fqaw0x3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=G3/PGZ+e; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1738D2067D;
	Mon, 18 Mar 2024 12:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710762093;
	bh=M1lFj/8COh+zHyLKRGim78FeBrFBeFtLgvjufT9nJgw=; h=From:To:Subject;
	b=G3/PGZ+egKVVznvxItvmFYbHPlJIFnXPyDyZNy6vABtrZXOMFK6CjLkw/AQo/bk6G
	 ct38+CWji4abwrJzHM3y1PAUq5+pDl6uHW0izDfD5kakv7pv6a12zMvIKEbK3Vk1T2
	 NeurXrPHQilwL+7H338te7NpKQmmeQnYW2XU9gRXcf13e+rSzQHK7MFpen7n64Cri2
	 HyODm9Kh3wibOS5QPagoCAp1un6wS4v2DBPfUxu7y+m6V1zsIec8auRnIDjGx4w9iT
	 33rADSU4kBUSDulBs+TDaffAIGRsGSJuBFC7mk0ubjimwhfXy7K0MgCpDr4PjLMX3O
	 VfrIOjNvbPFiQ==
Date: Mon, 18 Mar 2024 12:41:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 1/2] wifi: mwifiex: add host mlme for client mode
Message-ID: <20240318114131.GB9565@francesco-nb>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-2-yu-hao.lin@nxp.com>
 <ZfThCwGj-P5Owlsn@google.com>
 <PA4PR04MB9638F2586DF7E8A41330C8C9D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638F2586DF7E8A41330C8C9D12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hello David,

On Mon, Mar 18, 2024 at 02:00:35AM +0000, David Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>
..
> > >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
> > >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> > >  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
> > >  15 files changed, 671 insertions(+), 14 deletions(-)
> > 
> > (Per the above, I'd normally consider whether ~671 new lines is
> > worth splitting into multiple patches. But I don't see any great
> > logical ways to do that.)
> Francesco suggested to use two patches for this host mlme new feature
> from previous many patches. I knew it is a lot of changes, but I think
> it should be the best way to add host mlme with two patches (one for
> client and one for AP).

What I explicitly asked was to not add code in a patch, and fix the
newly added code in a following patch. What you are supposed to do is to
just amend the original code when you get review feedback.

Splitting a big patch into multiple patches is welcome to easier review,
and this needs to be done breaking down in logical pieces keeping in
mind also bisect-ability.

This [1] is an example of the addition of a relatively big new driver,
and you can see that the series is broken down in smaller patches like
"Add skeleton PowerVR driver", with intermediate steps that were
non-functional, but they were building fine, they were correct and they
were enabling more effective code review.

Unfortunately, as Brian agreed here, there was no easy way to do it for
this patch.

Francesco

[1] https://lore.kernel.org/all/cover.1700668843.git.donald.robson@imgtec.com/


