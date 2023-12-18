Return-Path: <linux-kernel+bounces-3964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F168175D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C471B28434C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C0760A9;
	Mon, 18 Dec 2023 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpJFPLnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C085A86A;
	Mon, 18 Dec 2023 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702913940; x=1734449940;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=chMB5GRwuFwlFnA1mbL/H7timbEewlCfwN5PbZeKMEw=;
  b=GpJFPLnupirRi8yrxRnA3wk1epftXEd7jfiuLs/dcp303jV1Afc2U4hq
   clPqhMZsfZuLUkMMH/MdTOAIBz73vL3uNyFDpV1ivKtiNhRTp23jI7NCx
   m4H/d4NQr9ukZAkEU2Vf1yi5Vs7VNvJ0E6KfvciuIvvr0Tb/rhpdcYO0o
   vqD+06IDEY75a3MvQKW0vXXnQpdikGWkI3MTlJ+yO+h5HxvhAfpUeBEgZ
   y+24v1Oil2wF3kAIlwBNdBrVDj50k2z4lyqm8wrj6HvO4gxo/zoYEMVnR
   /upMPRi2steOzuBwaLtlOwIPTFjlCgu6+3mflQSJMMT44HPXnVYG0+65M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14208202"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="14208202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="768874367"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="768874367"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2023 07:38:57 -0800
Message-ID: <f3342e07-4d35-7714-ad85-5c5c9ed9b25b@linux.intel.com>
Date: Mon, 18 Dec 2023 17:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Sam Edwards <cfsworks@gmail.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <7fdd62c6-f492-1f7e-9eca-9f965cdd73ef@linux.intel.com>
 <edf15619-8f31-2a30-d92e-997bc1464c58@gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 0/2] Allow disabling USB3 ports in xHCI/DWC3
In-Reply-To: <edf15619-8f31-2a30-d92e-997bc1464c58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.12.2023 23.59, Sam Edwards wrote:
> Hi Mathias,
> 
> On 12/14/23 04:05, Mathias Nyman wrote:
>> I don't think this will work as a generic xhci driver feature.
>>
>> Even if we ignore all USB3 ports in software they will for most xHC hosts be powered
>> and enabled in hardware by default after controller reset.
>>
>> This means they perform link training, generate all kinds of events with interrupts
>> (connect, over-current etc) that driver now can't handle.
> 
> By this do you mean that having the xHCI driver ignore the USB3 ports isn't enough to ensure that PP=0 (and the driver would need to do a little bit more to make sure that the "parking brake" is on: e.g. initialize, but not use, the ports) or that the xHC's PP=0 signal isn't sufficient to keep the PHYs from trying to bring the link up and generating those interrupts (PP=0 really isn't enough, and there is no general "parking brake" to be found here)?
> 

Yes, in most cases PP==1 after xHC reset, here's some old debug output during boot:

[    2.571057] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    2.571061] xhci_hcd 0000:00:0d.0: Host supports USB 3.2 Enhanced SuperSpeed
[    2.571065] xhci_hcd 0000:00:0d.0: // Turn on HC, cmd = 0x5.
[    2.571067] xhci_hcd 0000:00:0d.0: Finished xhci_run for USB3 roothub
[    2.571093] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    2.571095] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.571097] usb usb2: Product: xHCI Host Controller
[    2.571098] usb usb2: Manufacturer: Linux 5.15.57-06982-gf7339f7585d8-dirty xhci-hcd
[    2.571099] usb usb2: SerialNumber: 0000:00:0d.0
[    2.571197] xHCI xhci_add_endpoint called for root hub
[    2.571199] xHCI xhci_check_bandwidth called for root hub
[    2.571224] hub 2-0:1.0: USB hub found
[    2.571230] hub 2-0:1.0: 2 ports detected
[    2.571279] xhci_hcd 0000:00:0d.0: set port power 2-1 ON, portsc: 0x2a0

Note that portsc: 0x2a0 entry above has PP=1, and it shows the portsc register value
_before_  port power is set to 1 (ON).

Port Status: 0x2a0
	Disconnected
	Disabled
	Link: Rx Detect
	Powered
	Unknown port speed

Forcing PP=0 could possibly prevent any events from those ports.

>> Sound like the setup you are using has a very specific issue, and it would need
>> a narrow targeted quirk to solve it.
> 
> I infer from this that you're against having a DT property added to xHCI? What if the property were to be narrowed in scope to "ignore the USB3 PHYs, they're disabled/absent" vs. this iteration's "disable the USB3 ports" meaning?
> 
> If this quirk ends up landing in the dwc3 driver (since, arguably, DWC3 is the real misbehaving hw block in these circumstances), what would be your preferred mechanism of signaling to the xHCI layer "the USB3 PHYs have been disabled; please ignore"?

I don't have a good solution in mind for this so I'll just throw some ideas:

What happends if you in some RK3588 platform code disable USB  ports via those
syscon registers, but let the xhci driver be, and USB3 roothub enumerates normally?

Or if this is about a misbehaving USB3 PHY, how about adding the USB3 PHY driver that
describes reality and fails when usb_phy_roothub_init() or usb_phy_roothub_set_mode()
are called by for USB3 hcd during usb_add_hcd(USB3).
xhci driver could then continue without the USB3 hcd. turning off USB3 ports.
      
Adding the 'maximum-speed = "high-speed"' entry could also be one option.

Thanks
Mathias


