Return-Path: <linux-kernel+bounces-14337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBCA821B93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6344282EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA7F9C8;
	Tue,  2 Jan 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crr0UGsm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4EF4F2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8a8p/tz4/wo9Xo5tNF2/PSDKzKkEQri0kDPWt5RPsQM=;
	b=Crr0UGsmP2/COevqPJNfdfBnoh6BzMkDtqYIPq6p/NMFw7zSt2GvXN1u74cPu47ozs9bD6
	nWypK3hs6q94ZLlTo0ZBHX7A/wO5e/I209gL1IY/UnMuZq3mAOydyrbOBD+iJZKPGUIhjD
	kge4gLKcBBEYrOIHB37322XlbKb1GKo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Bz6Pw6yjPFaxhCAY5bCWKg-1; Tue, 02 Jan 2024 07:24:26 -0500
X-MC-Unique: Bz6Pw6yjPFaxhCAY5bCWKg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-556a28dfb41so139362a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198265; x=1704803065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a8p/tz4/wo9Xo5tNF2/PSDKzKkEQri0kDPWt5RPsQM=;
        b=j+g8qRjCe/exoelNDrD/GboyYGCNJdigZlPrUgXxbDBnohBA9j7kJaYIUzj+sGAk8v
         VPHcTwpsumo1xOahZsnCHm0WsAm8+tJlS1si5NtV6x5udjgYN7qy6hctJmElm/Fh2Uwd
         Z8a4Wzf74ITz5AepGHJAtsjY9OhR2f7GYmh/6JDp4p3zfu1jNbvDWe72Pw0AeUouahp/
         trAHn24c6BBCX/lmY/ds/j41EUcFEOdi1KGMEBHVw/02BXnO9M4/2yLbV0gEv72alube
         jCJyUQU8NVGuUAMC8LgcLsRO85JY/sj/K7cgrP8S4Z7/6klyu/91KsIPdyTI9jzM6JkK
         dCgA==
X-Gm-Message-State: AOJu0YyMpsE4pp1XlZWZvE0hqeUn7ff+rPZrb1E3fKj9p+hcnPgk7fob
	sHgNirnEQI96ENLjWdbwEFGd4UvvaCt2xAVV9+I+xbSpbnT687JucvyxpmvUMVZzwY8GToTmqx+
	nYqHLoQu1ERz3HAW6qyChwJcu9d7yNw4J
X-Received: by 2002:a05:6402:8d3:b0:555:f8d6:3958 with SMTP id d19-20020a05640208d300b00555f8d63958mr3238862edz.55.1704198265350;
        Tue, 02 Jan 2024 04:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ6k4T2HeIqC2SuJg3ax/+d7LV51poDPZuTi2eYjdajjCqMNVS1Pc1vq+BSfDYOrxgp8tOUQ==
X-Received: by 2002:a05:6402:8d3:b0:555:f8d6:3958 with SMTP id d19-20020a05640208d300b00555f8d63958mr3238854edz.55.1704198265086;
        Tue, 02 Jan 2024 04:24:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm9824333edb.72.2024.01.02.04.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:24:24 -0800 (PST)
Message-ID: <37160e32-49ec-4977-aab0-4bb340335055@redhat.com>
Date: Tue, 2 Jan 2024 13:24:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel-uncore-freq: Add additional client
 processors
Content-Language: en-US, nl
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
 andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231222203957.1348043-1-srinivas.pandruvada@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231222203957.1348043-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/22/23 21:39, Srinivas Pandruvada wrote:
> Add support for client processors starting from Kaby Lake.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Rebased on top of review-hans branch. The processors are ordered based
> on their release similiar to intel-family.h.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
>  .../x86/intel/uncore-frequency/uncore-frequency.c   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> index a3b25253b6fd..a5e0f5c22179 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -205,6 +205,16 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> @@ -212,6 +222,9 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M, NULL),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);


