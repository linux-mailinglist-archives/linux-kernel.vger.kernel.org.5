Return-Path: <linux-kernel+bounces-16802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228D824417
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14491F2287F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A02375B;
	Thu,  4 Jan 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPlcMVr2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044223748;
	Thu,  4 Jan 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704379623; x=1735915623;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AgNpe/rQhXH4s/zrVu4O6NOZqlKS54MKFZBPb9+vKyQ=;
  b=dPlcMVr2hjex705BPBxtdxY+dPlW18/Ezfq2Y+Gf/Bklt9mQDB9NPdYq
   e62DRDhuO8OoxmfrS9G8T+alzrRnX4VZ05nL7jYu/BuB8c20OMnjPqF2D
   GkrGWTbGofB65Gmt/q7wxNk9XtDPf3L9XEY90WXBwCiMPQPGmuWOlxgqR
   YrDuA3gbCnytS/RcKV2TdylGTRGFG0XDPRqbHfddwViXZLKbGBTDmZncJ
   9XZaojziSZs38fXvgvjsecLJa2AU2EYW8iisvQ7qgPA98rpB5VDk1hgNw
   XKVH6QrNBRXi6pao4dcKO1taAtwaboCEJ5oKJg9BabegH42AxSOZtI9J+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="15895923"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="15895923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773536659"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="773536659"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2024 06:46:52 -0800
Message-ID: <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
Date: Thu, 4 Jan 2024 16:48:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 konrad.dybcio@linaro.org, Thinh.Nguyen@synopsys.com, broonie@kernel.org,
 bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org, agross@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240102214549.22498-5-quic_wcheng@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v12 04/41] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
In-Reply-To: <20240102214549.22498-5-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2.1.2024 23.45, Wesley Cheng wrote:
> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
> pending events in the secondary event ring, it is observed that the xHCI
> controller stops responding to further commands upon host or device
> initiated bus resume.  Iterate through all pending events and update the
> dequeue pointer to the beginning of the event ring.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
...
> +/*
> + * Move the event ring dequeue pointer to skip events kept in the secondary
> + * event ring.  This is used to ensure that pending events in the ring are
> + * acknowledged, so the XHCI HCD can properly enter suspend/resume.  The
> + * secondary ring is typically maintained by an external component.
> + */
> +void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
> +	struct xhci_ring *ring,	struct xhci_interrupter *ir)
> +{
> +	union xhci_trb *erdp_trb, *current_trb;
> +	u64 erdp_reg;
> +	u32 iman_reg;
> +	dma_addr_t deq;
> +
> +	/* disable irq, ack pending interrupt and ack all pending events */
> +	xhci_disable_interrupter(ir);
> +	iman_reg = readl_relaxed(&ir->ir_set->irq_pending);
> +	if (iman_reg & IMAN_IP)
> +		writel_relaxed(iman_reg, &ir->ir_set->irq_pending);
> +
> +	/* last acked event trb is in erdp reg  */
> +	erdp_reg = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
> +	deq = (dma_addr_t)(erdp_reg & ERST_PTR_MASK);
> +	if (!deq) {
> +		xhci_err(xhci, "event ring handling not required\n");
> +		return;
> +	}
> +
> +	erdp_trb = current_trb = ir->event_ring->dequeue;
> +	/* read cycle state of the last acked trb to find out CCS */
> +	ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
> +
> +	while (1) {
> +		inc_deq(xhci, ir->event_ring);
> +		erdp_trb = ir->event_ring->dequeue;
> +		/* cycle state transition */
> +		if ((le32_to_cpu(erdp_trb->event_cmd.flags) & TRB_CYCLE) !=
> +		    ring->cycle_state)
> +			break;
> +	}
> +
> +	xhci_update_erst_dequeue(xhci, ir, current_trb, true);
> +}

Code above is very similar to the existing event ring processing parts of xhci_irq()
and xhci_handle_event()

I'll see if I can refactor the existing event ring processing, decouple it from
event handling so that it could be used by primary and secondary interrupters with
handlers, and this case where we just want to clear the event ring.

Thanks
Mathias


