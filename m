Return-Path: <linux-kernel+bounces-19884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1704782762A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A459283064
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C854670;
	Mon,  8 Jan 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLf4fYkR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811654661;
	Mon,  8 Jan 2024 17:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D291C433C8;
	Mon,  8 Jan 2024 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704734234;
	bh=Pt18IiRNDtbh+dvxFEWq+gCG9YlN37cs8dyhnDwTJng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLf4fYkRhtg75L54eSBqXj+rt4RNvIW9AJZYN7YVSlyr3wsck3mTcX0Xkxoab4Bv1
	 z++NHny9EV3prQblsUvC0uVP/3Nr+VpctUBuJovj8boqqRKUWKZblsxarz0u4pj51a
	 YAytX3sEm4KYPL68xxPuvg6n0pVBHBn/z5fC4XZO3svE6TdR9UIZFV6JFihCp5t7pi
	 XKpmI1cO5L9d84EHN/MbUx5h8ro7TYUo8wWkgU+b5HD5RzgmZWNBk/+D9QuT+mAcgO
	 b5PXlAuiLymhLP4X19WhdrbN4r3UV6cPVWiBFxK5+7fH/0UNeWv8flw2m0LTrgBU7g
	 XzOrJtDMUyVsw==
Date: Mon, 8 Jan 2024 17:17:10 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20240108171710.GC7948@google.com>
References: <20231220145917.7076-1-lnimi@hotmail.com>
 <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231221161604.GP10102@google.com>
 <OS3PR01MB6593208C1466417EBFF2F878BA672@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB6593208C1466417EBFF2F878BA672@OS3PR01MB6593.jpnprd01.prod.outlook.com>

On Thu, 04 Jan 2024, Min Li wrote:

> > 
> > As above.  Why is this being shoved in here?
> > 
> > > +#endif
> > 
> > --
> 
> Hi Lee
> 
> The reason I put them here is we have another driver under misc that also needs to read/write the device
> and parse the firmware. We haven't submitted the misc driver to linux yet but we maintain it through our
> linux repo and do need the interface like this. Thanks

When are you planning on submitting the misc driver?

-- 
Lee Jones [李琼斯]

