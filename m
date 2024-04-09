Return-Path: <linux-kernel+bounces-136702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0BF89D73F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0505284FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AF83A07;
	Tue,  9 Apr 2024 10:49:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96E80603;
	Tue,  9 Apr 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659786; cv=none; b=F1VbmZ755IkcPjtwyLz3LI5l7iaPkDNdYR7RsvNveGZ4LRg6hFS0v2V7yZ64qVdfWlGkYOKT8cPDu/glp2RdSUlVapMciHigM0RN/Y/RR619NFgE0iP9YXHvfOsdSE6FfgLCzS91u5ww7SbjvtRiSIot4EXN/oDDb6h6Z2MQp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659786; c=relaxed/simple;
	bh=XXednxn3A2ELXwpsSYuPnlymvAJgKHfR1r+rrAGVfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxxFQ/kPxwEBUnXr3lzvjiTRSxGsuJDVUZoW1vzKJ0jvxnVDfwYnX+e3uXir5ndvy9jlFBnbSTN3JQG/CLxcEkLGISOMJZpWPkoRByWd0tlviSwYrs9RP8Tf8wSsQAzmZh+Epzvvf6wLlGK1VM0/Ppwv4dE8Q9rps6yzbDC/hyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07B01007;
	Tue,  9 Apr 2024 03:50:14 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486E73F766;
	Tue,  9 Apr 2024 03:49:42 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:49:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Message-ID: <ZhUdQ6M0GkL0do_l@bogus>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto>
 <ZhUDZGJilhczKlDD@bogus>
 <DU0PR04MB94175384AD9113AC6F60546588072@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94175384AD9113AC6F60546588072@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Apr 09, 2024 at 09:13:33AM +0000, Peng Fan wrote:
> Hi Sudeep,
>
> > Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
> > BBM protocol
> >
> > On Mon, Apr 08, 2024 at 07:04:43PM +0100, Cristian Marussi wrote:
> > > On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The i.MX BBM protocol is for managing i.MX BBM module which provides
> > > > RTC and BUTTON feature.
> > > >
> > >
> > > I appreciate that you added versioning but I think a bit of
> > > documentation about what the protocol and its comamnds purpose is
> > > still lacking, as asked by Sudeep previously
> > >
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Flinux-arm-
> > kernel%2FZeGtoJ7ztSe8Kg8R%40bogus%2F%23t&data=
> > >
> > 05%7C02%7Cpeng.fan%40nxp.com%7Ce92ff78b9126447afe9708dc587358d
> > 4%7C686e
> > >
> > a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638482499632395762%7C
> > Unknown%7C
> > >
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> > CJXVC
> > >
> > I6Mn0%3D%7C0%7C%7C%7C&sdata=7QP%2BkkjHA3Sa0CdcbbObGG4kgYYK
> > XAGA2r%2F%2F
> > > x0MogqU%3D&reserved=0
> > >
> >
> > I have decided to ignore all these vendor protocol patches until they have
> > some documentation to understand what these protocol are for, what are the
> > commands, their input/output parameter details, any conditions are the
> > caller and callee,..etc very similar to SCMI spec.
>
> Where do you expect the documentation to be put?
>

To begin with, we need all these vendor protocols in a directory say
vendors/nxp under drivers/firmware/arm_scmi. It can be a simple text file
under that. We can see later if we need any more formal version elsewhere
but that shouldn't be a blocker for these changes.

> similar as scmi_protocol.h, put in scmi_imx_protcol.h?
> >
> > To start with can you please expand what is BBM or MISC protocol is ?
>
> ok. Sorry for missing your previous comment in v1. Let me write here briefly
> first.
>

Thanks

> The Battery Backup (BB) Domain contains the Battery Backed Security
> Module (BBSM) and the Battery Backed Non-Secure Module (BBNSM).
> BBM protocol is to manage i.MX BBSM and BBNSM. This protocol supports
> #define COMMAND_PROTOCOL_VERSION             0x0U
> #define COMMAND_PROTOCOL_ATTRIBUTES          0x1U
> #define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U
> #define COMMAND_BBM_GPR_SET                  0x3U
> #define COMMAND_BBM_GPR_GET                  0x4U
> #define COMMAND_BBM_RTC_ATTRIBUTES           0x5U
> #define COMMAND_BBM_RTC_TIME_SET             0x6U
> #define COMMAND_BBM_RTC_TIME_GET             0x7U
> #define COMMAND_BBM_RTC_ALARM_SET            0x8U
> #define COMMAND_BBM_BUTTON_GET               0x9U
> #define COMMAND_BBM_RTC_NOTIFY               0xAU
> #define COMMAND_BBM_BUTTON_NOTIFY            0xBU
> #define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U
>

Hopefully description of each of these commands cover what GPR above means
really.

> For now in this patchset for linux, we only use RTC, and BUTTON
> for system wakeup
>
> For MISC protocol, it is for various misc things, such as discover
> build info, get rom passed data, get reset reason, get i.mx
> cfg name, control set(for gpio expander under m33 control and
> etc). The command as below:
> #define COMMAND_PROTOCOL_VERSION             0x0U
> #define COMMAND_PROTOCOL_ATTRIBUTES          0x1U
> #define COMMAND_PROTOCOL_MESSAGE_ATTRIBUTES  0x2U
> #define COMMAND_MISC_CONTROL_SET             0x3U
> #define COMMAND_MISC_CONTROL_GET             0x4U
> #define COMMAND_MISC_CONTROL_ACTION          0x5U
> #define COMMAND_MISC_DISCOVER_BUILD_INFO     0x6U
> #define COMMAND_MISC_ROM_PASSOVER_GET        0x7U
> #define COMMAND_MISC_CONTROL_NOTIFY          0x8U
> #define COMMAND_MISC_REASON_ATTRIBUTES       0x9U
> #define COMMAND_MISC_RESET_REASON            0xAU
> #define COMMAND_MISC_SI_INFO                 0xBU
> #define COMMAND_MISC_CFG_INFO                0xCU
> #define COMMAND_MISC_SYSLOG                  0xDU
> #define COMMAND_NEGOTIATE_PROTOCOL_VERSION   0x10U
>

And same here. Just as an example what BUILD_INFO ? There will be 10s if not
100s of different image in the system. What does this BUILD_INFO provide ?
And why is this important over version or release info ?

These are simple pointers, expect more questions like this if the document
is not self sufficient in explaining such details.

--
Regards,
Sudeep

