Return-Path: <linux-kernel+bounces-23439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B0B82ACBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66558281A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0814F7B;
	Thu, 11 Jan 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEUpUzez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941614F60;
	Thu, 11 Jan 2024 11:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836AEC433F1;
	Thu, 11 Jan 2024 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970868;
	bh=ek4PxqeXi6+5JE2gQJYYYaHorBklbYrUuvk5Bj8FijM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEUpUzez37Pi9tyzq+bSf4Z0tg2obqnLBDl74pTUG1GUxQR7h14D/NDW9Tk4NQBi2
	 jrkVsYMtr5YY2m5EwO9wBg8r8dt1sXCZXYi9jI/olVVZjf/PMgOJ83v8x4c31r/XaB
	 hWN8fupNIQ7aHouAc9j5OJb7zYN6po8TQZMYmz+qPrt/GZBr4VojtJ5vqYdm6xQQMV
	 yjcc6vNt5jREUSb1wYJbcCJ+f9cpY+MEwWCEGQOXwX8X1nBL708r74d/wiyPgpiH3h
	 spBhqMOTTsbLd2KOY5noXM2L0cTyAOMOyC+ePjnuGEuuRVlINt836xFIZxh2xt0KXP
	 Tz3qsaRnShM0w==
Date: Thu, 11 Jan 2024 11:01:04 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20240111110104.GC1678981@google.com>
References: <20231220145917.7076-1-lnimi@hotmail.com>
 <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231221161604.GP10102@google.com>
 <OS3PR01MB6593208C1466417EBFF2F878BA672@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20240108171710.GC7948@google.com>
 <OS3PR01MB6593FD73A1C98CAA6E8BB5BDBA6B2@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB6593FD73A1C98CAA6E8BB5BDBA6B2@OS3PR01MB6593.jpnprd01.prod.outlook.com>

On Mon, 08 Jan 2024, Min Li wrote:

> 
> > > Hi Lee
> > >
> > > The reason I put them here is we have another driver under misc that
> > > also needs to read/write the device and parse the firmware. We haven't
> > > submitted the misc driver to linux yet but we maintain it through our
> > > linux repo and do need the interface like this. Thanks
> > 
> > When are you planning on submitting the misc driver?
> > 
> > --
> 
> I was trying to submit it while ago but was rejected by the reviewers since they
> don’t like the everything-through-ioctl design. We are currently redesigning it and
> planning to re-submit in the near future

Where is the parent MFD driver for this device?

-- 
Lee Jones [李琼斯]

