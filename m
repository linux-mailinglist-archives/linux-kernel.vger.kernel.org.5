Return-Path: <linux-kernel+bounces-163816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C018B71F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED43281471
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494CE12D750;
	Tue, 30 Apr 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTB81+gS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD112C462;
	Tue, 30 Apr 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474952; cv=none; b=Cg3pjy03eHypY9L+33IytRi98BCiesoLwLYopIfhx+wZXQJL+k/s5MDlXmn2fOAAmfjbUjfIgqg3rbtNzVEXxZF4QuD6Ypxq1ul4a//Dqsf0kR2uxqVQWh//NNWwPT9fsjPAmMGVoyvoJFuG8pUvJRmOh4o0aR1+/N+8waFcJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474952; c=relaxed/simple;
	bh=WEpGkinjP85gZ1yikgGfZHLhlM9a1u3AEgisLuq7IPY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=dvDw0F53e8hLvl1pGtesd2dXDauSzpM+a0MYB+CHz8BX7ETs6OF6XfNkQ5a0k7MEL/CvOQQxqTwSul1OpUTar7B6FpjWVZaAZgDIez7zTKL2IqSAYX7+aNJKPQjcuCLDlalDjtJkKLkTm77lAmH4sd5zGZavPG1kMRwLSKWOdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTB81+gS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714474951; x=1746010951;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WEpGkinjP85gZ1yikgGfZHLhlM9a1u3AEgisLuq7IPY=;
  b=MTB81+gSBOPHRCY/n+gU9oAE3jzVEJYmeuL9V4EOVHhR26gehE5bjIlm
   nDnhoyvASW9mChFvo3jaxC1FxVpq9f5716mprcLyojB7deF2n5pStrqoI
   8nTuD7lGTXzc4cyLRyAvcoe0GEkMfPLyA09I0Yh+oTY/PU9ZznCX47XyG
   4BG6jRJ/hVeesZGa87Vh0JNVW7rIrevlWG4X7IUfWTPek9b0eAFQhIjvS
   /bDmbJkpxlWgUy3Ui7/WlrqAl+eOF4pOWsjq9bkOs5faP9knSu1kDdE+N
   Z51+rCpfzA+/OhvCvrkhFRDqgOIAtlDF/FfxWk0z3UkuEaPFamd8A/DxV
   g==;
X-CSE-ConnectionGUID: wLlspz5DSoeJZfcAAs8nDg==
X-CSE-MsgGUID: RE/jgmcVQGmm2Vo71IS6qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10049968"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10049968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:01:14 -0700
X-CSE-ConnectionGUID: ZYP4FPMyTz+USEUyCE9qJw==
X-CSE-MsgGUID: 7E29hnIZQbuS2emcfSjQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26845804"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2024 04:01:07 -0700
Message-ID: <12d29c54-c005-7112-0933-d9d28f11abd6@linux.intel.com>
Date: Tue, 30 Apr 2024 14:02:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-4-quic_wcheng@quicinc.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v20 03/41] usb: host: xhci: Repurpose event handler for
 skipping interrupter events
In-Reply-To: <20240425215125.29761-4-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.4.2024 0.50, Wesley Cheng wrote:
> Depending on the interrupter use case, the OS may only be used to handle
> the interrupter event ring clean up.  In these scenarios, event TRBs don't
> need to be handled by the OS, so introduce an xhci interrupter flag to tag
> if the events from an interrupter needs to be handled or not.

Could you elaborate on this a bit.

If I understood correctly the whole point of requesting a secondary xhci interrupter
for the sideband device without ever requesting a real interrupt for it was to avoid
waking up the cpu and calling the interrupt handler.

with this flag is seems the normal xhci interrupt handler does get called for
sideband transfer events.

> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci-ring.c | 17 +++++++++++++----
>   drivers/usb/host/xhci.h      |  1 +
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 52278afea94b..6c7a21f522cd 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2973,14 +2973,22 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>   }
>   
>   /*
> - * This function handles one OS-owned event on the event ring. It may drop
> - * xhci->lock between event processing (e.g. to pass up port status changes).
> + * This function handles one OS-owned event on the event ring, or ignores one event
> + * on interrupters which are non-OS owned. It may drop xhci->lock between event
> + * processing (e.g. to pass up port status changes).
>    */
>   static int xhci_handle_event_trb(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
>   				 union xhci_trb *event)
>   {
>   	u32 trb_type;
>   
> +	/*
> +	 * Some interrupters do not need to handle event TRBs, as they may be
> +	 * managed by another entity, but rely on the OS to clean up.
> +	 */
> +	if (ir->skip_events)
> +		return 0;
> +

I think we need another solution than a skip_events flag.

To make secondary xhci interrupters more useful in general it would make more
sense to add an interrupt handler function pointer to struct xhci_interrupter.

Then call that function instead of xhci_handle_event_trb()

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3098,8 +3098,8 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
  
         /* Process all OS owned event TRBs on this event ring */
         while (unhandled_event_trb(ir->event_ring)) {
-               err = xhci_handle_event_trb(xhci, ir, ir->event_ring->dequeue);
-
+               if (ir->handle_event_trb)
+                       err = ir->handle_event_trb(xhci, ir, ir->event_ring->dequeue);
                 /*
                  * If half a segment of events have been handled in one go then
                  * update ERDP, and force isoc trbs to interrupt more often

The handler function would be passed to, and function pointer set in
xhci_create_secondary_interrupter()

For primary interrupter it would always be set to xhci_handle_event_trb()

Thanks
Mathias


