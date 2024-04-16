Return-Path: <linux-kernel+bounces-146872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E18A6C30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92C81C20D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598512A17E;
	Tue, 16 Apr 2024 13:24:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BE12BF25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273886; cv=none; b=dmZLHsF94d0JLTPSsC//oopiZcVV/oN6r1+PGc6zBvFBEHj/5i/cmuODbXBmkjIBIUy7moXx7k6Ooao9RFmPDqQke/BRYfpj6ZcLpsnABEPLhHqJFdNT1yMpZE407Ex+BXuaAdIMTWYoAof/jtBfXqw+H0TtQPDxRcLIM4kpfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273886; c=relaxed/simple;
	bh=cT3ohBAsCHwAas+oiEvZw/9G87J4V3yjv8xhQMMqeXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMVsLF3uhjZM4wCzyg98qcKFjeLeOus8f3QnnQqIbdXuXy2Cct5YI4ftAm6wygLSZYkIT0ZwQq0qU1pTLtifpxisj2Fy+H3xx3hae7Xnh+u8j9ADtSshlfpxyg3qD3Kz5vVGOipxiwBTW5SeuNyxzqOdHFvfEDnZ+eCCV/NGV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31580339;
	Tue, 16 Apr 2024 06:25:12 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13FBE3F738;
	Tue, 16 Apr 2024 06:24:42 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:24:39 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Message-ID: <Zh58F_TuQMO-swOU@pluto>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh2R4FZPmVOigfT9@pluto>
 <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zh5P2EtruMmTrgXM@pluto>
 <DU0PR04MB9417FFF8A9FB5018125C524688082@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417FFF8A9FB5018125C524688082@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Apr 16, 2024 at 12:34:14PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> > command
> > 
> > On Tue, Apr 16, 2024 at 07:01:42AM +0000, Peng Fan wrote:
> > > Hi Cristian,
> > >
> > 
> > Hi,

Hi,

> > 
> > > > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support
> > > > suspend command
> > > >
> > > > On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Support System suspend notification. Using a work struct to call
> > > > > pm_suspend. There is no way to pass suspend level to pm_suspend,
> > > > > so use MEM as of now.

[snip]

> > But, as said, I dont think there is a way to trigger a userspace suspennd from
> > jernel like we do for shutdown/reboot...I'll try to investigate a bit more.
> 
> Thanks for helping.

. also

scmi_power_control.c:95: warning: Function parameter or struct member 'suspend_work' not described in 'scmi_syspower_conf'

Thanks,
Cristian

