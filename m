Return-Path: <linux-kernel+bounces-23375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E182ABC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399101F232A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858712E69;
	Thu, 11 Jan 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gulit7CF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69814A82
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704968220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvfh+d/PF2/QGoAtt0okJqQ5raTsSFhD1s6pDC9b/Lw=;
	b=gulit7CFMvLNiJpgOjIioRW7jFxcroYAaxo/8SjpqVCbSAIaTPl06riAU+N9R/SGa8PWRH
	Qh5JXvRG8ZTBAdx0v3mYTrNDnvgZns3Y0PN5v2lXTuQWuPjJ2vRfMEcdM4XP1yCZfQrlgr
	V0kvwBdT4huDA7lG9ojoiwX+RgSVnu4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Y-mL97mVM3GvpvNv8Q4v4Q-1; Thu, 11 Jan 2024 05:16:58 -0500
X-MC-Unique: Y-mL97mVM3GvpvNv8Q4v4Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b6c2a6083so118751466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968218; x=1705573018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvfh+d/PF2/QGoAtt0okJqQ5raTsSFhD1s6pDC9b/Lw=;
        b=W6mwvyOsdQj2JXJqeN94QVPmAt/V5lFb/MTH0+By08W/Gd955W0MuPamNDcto5SIFI
         0Ws5RRmijG05GB8eGe4ynL3H7NxAYLh9+oL5una0ctMmJF9PnaIog4ImWiyUrcJxraFQ
         UGMXM3p0yEEr4d3+TWLo4pY9q19kYCA+w7bqRdUIyVp8Ueo1+4JAdknaxYc8IaKYyWRN
         05NFwSfNw3b6DOJnk5nlnJSvL7/SqRHUpw9G2AUL444TotqwRojQhcn/o+mnAQCD4aqy
         7xFFdvT/Vp+t4JTcOmHeFc49pXXzTxL+ep7rNz/ZDp1qS7TZF9q0btA9GViDe8HKkjTP
         ZbRw==
X-Gm-Message-State: AOJu0YwCbF/DLdbLuK57cUHRhfx+0Hh1Vc7L2raeLppKO8iXQAMG+pNR
	sbPkX8Gfhc0k8/Vy9rq4ye9bmtwnGrEWFYU/jkwAZtBJn1L2p+Ay8ZExLzuzM9RGsRHkg0oqURM
	xEGOm9KNZGNWajLDwLJSC25oyQCq9Giwa
X-Received: by 2002:a17:907:1118:b0:a26:88f4:3fae with SMTP id qu24-20020a170907111800b00a2688f43faemr445676ejb.67.1704968217748;
        Thu, 11 Jan 2024 02:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXhoFxHtuchywcndajp7x42HN6ov4dAJlvko9sTO5poziYHxnk5h2wfHQuhiVgOiK4ROnANQ==
X-Received: by 2002:a17:907:1118:b0:a26:88f4:3fae with SMTP id qu24-20020a170907111800b00a2688f43faemr445667ejb.67.1704968217476;
        Thu, 11 Jan 2024 02:16:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906301300b00a26a93731c5sm387607ejz.111.2024.01.11.02.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 02:16:57 -0800 (PST)
Message-ID: <c62db276-289e-4a21-8e2f-6a6055e7c4ca@redhat.com>
Date: Thu, 11 Jan 2024 11:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Content-Language: en-US, nl
To: Prashanth K <quic_prashk@quicinc.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231212112521.3774610-2-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/12/23 12:25, Prashanth K wrote:
> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
> which fixes XHC timeout, which was seen on synopsys XHCs while
> using SG buffers. But the support for this quirk isn't present
> in the DWC3 layer.
> 
> We will encounter this XHCI timeout/hung issue if we run iperf
> loopback tests using RTL8156 ethernet adaptor on DWC3 targets
> with scatter-gather enabled. This gets resolved after enabling
> the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
> the xhci device property since its needed for DWC3 controller.
> 
> In Synopsys DWC3 databook,
> Table 9-3: xHCI Debug Capability Limitations
> Chained TRBs greater than TRB cache size: The debug capability
> driver must not create a multi-TRB TD that describes smaller
> than a 1K packet that spreads across 8 or more TRBs on either
> the IN TR or the OUT TR.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/dwc3/host.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 61f57fe5bb78..31a496233d87 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>  
>  	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>  
> +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
> +

If you do this you also need to make the props array 1 entry bigger (increase
it from 4 to 5 entries). Before this patch there are max 3 properties added
and there needs to be an empty terminating property at the end (which
is what the memset is for). So before this patch props[] needs to have
4 entries (which it does) and thus after this patch props[] needs to
have 5 entire.s

Regards,

Hans




