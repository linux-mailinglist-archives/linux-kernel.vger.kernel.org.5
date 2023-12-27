Return-Path: <linux-kernel+bounces-12183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEE81F102
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01BC1F230B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4C46546;
	Wed, 27 Dec 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+k+3EUT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7C4644F;
	Wed, 27 Dec 2023 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698822; x=1735234822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dErD4TBWCprBJyD9UF9opetoam1CYE1CQ+c0zqbUmpA=;
  b=e+k+3EUTIh1OSz+TZKmTBaiBASQelrwBZROHcJJNE0oJ/Jjv2ezV9IXz
   lWJI2f2Pblx7PaC5ORa8n8pkXWLS65s94T+oaLpoNjjZW2K3l0i0cJ97k
   YjFXhjaXLIGcpB8w321T6LXUJ/vMEeUMStyTeEjSCKKZKVOhpEU5GvJv8
   36Tk85QBOSbeLQVdw99N6VUHuXrK80Vjo7jh6RCbI0dhO91/K00LaDv29
   7xMpWOnRrwFHJGrYi8lFu0uCZaWvqJqznxyz/g3zFtvT19lMOuCQF8XIn
   4eGK2RqykIrDw9fZi4E3GBFV5dNBw4EQmMDRBovR4yTPoTTy+291D37ul
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="395355618"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="395355618"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="771485823"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="771485823"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:40:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXt7-00000009Tfi-1pRq;
	Wed, 27 Dec 2023 19:40:13 +0200
Date: Wed, 27 Dec 2023 19:40:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Lukas Wunner <lukas@wunner.de>,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"brenda.streiff@ni.com" <brenda.streiff@ni.com>,
	Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <ZYxhfVxv6xb4LF7C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 24, 2023 at 10:11:17AM +0000, Christoph Niedermaier wrote:
> From: Lino Sanfilippo [mailto:LinoSanfilippo@gmx.de]
> Sent: Saturday, December 23, 2023 2:41 PM
> > On 23.12.23 13:49, Christoph Niedermaier wrote:
> >> From: Lukas Wunner [mailto:lukas@wunner.de]
> >> Sent: Thursday, December 21, 2023 4:53 PM
> >>> On Thu, Dec 14, 2023 at 01:41:47PM +0000, Christoph Niedermaier wrote:
> >>>> I will summarize the current situation from my point of view, maybe it helps:
> >>>>
> >>>> RS-232:
> >>>>   - Full Duplex Point-to-Point connection
> >>>>   - No transceiver control with RTS
> >>>>   - No termination
> >>>>   - No extra struct in use
> >>>>
> >>>> RS-422:
> >>>>   - Full Duplex Point-to-Point connection
> >>>>   - No transceiver control with RTS needed
> >>>>   - Termination possible
> >>>>   - Extra struct serial_rs485 needed if termination is used
> >>>>  => RS-422 can be used in RS-232 operation, but if a termination should be
> >>>>     switchable the RS485 flag has to be enabled. But then also transceiver
> >>>>     control will be enabled. Not a very satisfying situation.
> >>>
> >>> Well why don't we just allow enabling or disabling RS-485 termination
> >>> independently from the SER_RS485_ENABLED bit in struct serial_rs485?
> >>>
> >>> Just let the user issue a TIOCSRS485 ioctl to toggle termination even
> >>> if in RS-232 mode and use that mode for RS-422.
> >>>
> >>> Looks like the simplest solution to me.
> >>
> >> Sounds not bad. The termination should only depend on whether the GPIO is
> >> given or not.
> >>
> >> Irrespective of this, I think the Linos idea of an RS-422 mode is not bad.
> >> This allows you to take care of special features that were previously
> >> overlooked. For example, hardware flow control can be switched off so that
> >> this does not cause any problems.
> >>
> > 
> > Also note, that RS232 and RS422 may NOT always be the same from driver perspective.
> > Take a look at 8250_excar.c for example. That driver has to configure the hardware
> > accordingly when switching from RS232 to RS422 (see iot2040_rs485_config()).
> > 
> > While a SER_RS485_MODE_RS422 flag set by userspace could work to switch to RS422, I
> > still think that the cleanest solution would be another ioctl TIOCSRS422 with a
> > parameter like
> > 
> > struct serial_rs422 {
> >        __u32   flags;
> > #define SER_RS422_ENABLED              (1 << 0)
> > #define SER_RS422_TERMINATE_BUS        (1 << 1)
> >         __u32   padding[7]
> > };
> > 
> > The SER_RS485_MODE_RS422 flag could still be used internally as a hint to the driver.
> > That solution would also be expandable if needed. I planned to send a patch that
> > implements this
> > as a RFC to the mailing list (maybe in the next few days).
> 
> Having your own ioctl is a nice distinction, but when I think about it for a moment,
> questions come to mind:
> 
> From userspace perspective then there are two termination flags
> SER_RS485_TERMINATE_BUS and SER_RS422_TERMINATE_BUS?
> How will they interact internally?
> 
> What about the devicetree property?
> Will there be rs422-term-gpios as well?
> 
> Could the user enable RS422 and RS485 at the same time?

Exactly, if you are going for this, just make a new entry into union, and
use flags for that. So, you probably will have the same IOCTL, but which
will serve RS422/RS385 purposes excluding odds of the use of the pieces.

-- 
With Best Regards,
Andy Shevchenko


