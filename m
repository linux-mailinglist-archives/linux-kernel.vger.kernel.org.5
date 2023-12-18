Return-Path: <linux-kernel+bounces-3430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84C816C25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0436B1F237E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAF199DF;
	Mon, 18 Dec 2023 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ6zcqR/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C5199A0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702898730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ldc2f04tPQnL7mptFYAJQ0E8xfxLz+eKZoc7PtpvgL0=;
	b=gZ6zcqR/cLxGCJyLMsYOdwTBmAsrGqb/yTBDVF2xNDerHoEuksGGatEIfgd2iWjToCSVbM
	FLPPxv1UBIK6GyXCMtf+4+PmTrDPKZ2cKtmXtEhmqs4mvFgG55dEbN41PgNRkAWGgVuIgR
	Vtp6iSuY+15trCPixz25cBzSZYv7HMg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-aaKU6YPgPVC5-dvw1npBqw-1; Mon, 18 Dec 2023 06:25:28 -0500
X-MC-Unique: aaKU6YPgPVC5-dvw1npBqw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fb151c89bso12700515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702898728; x=1703503528;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldc2f04tPQnL7mptFYAJQ0E8xfxLz+eKZoc7PtpvgL0=;
        b=ASyc/J/vgpxd4oGSS3Lg125XurF5gygpLsLdcsWD+DymQAEueIWLWAaHchh2ww/viW
         s8EnYeFF0mGy4QUmTFrvwPutKDRmK5gnzcV8UmhUqenlYxTH7+u+NqjwQv289D8zLL35
         EM4Qy5IabN1t4dPK6SJHu4NMqothNxbLJQAs2Pm67FxuehzVj8HX5fJF7uUmAKiXiWeJ
         0e+NING2GBT8s5X2I6g6mIUULBGnYKKkNWtNaVIBAZFVTOfLVAzmsvFl9E63sRkClh3J
         HQoxWomk6Z8zF6k5lC5N9n0Dk4XIjbYrk6YWhqudwGIiMArZu1++OHRb3anPsEy/BreE
         daAA==
X-Gm-Message-State: AOJu0YwhFBAemTJlbieYQJWpXT99F8NJyrCD4zvzPDBwR7RguTvbJfuY
	864sm2iMd4MTr0l9DMWgrJyuCsCGb6AcG57gimldkeMF6YbyFm9GEP/6MbNSr3RT/uHMT66tU+G
	pKwkkD7EWgF+hzre2kHCNlFRkrbUurxCq
X-Received: by 2002:a05:6e02:148a:b0:35d:695a:d323 with SMTP id n10-20020a056e02148a00b0035d695ad323mr27097799ilk.70.1702898728014;
        Mon, 18 Dec 2023 03:25:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeie7lEw5N6j/3h4eqdlAkM0zcI6bCN54t1JVtwOxfjSPEpDnMO4wFZ4LAoaomtGqd8QaKnQ==
X-Received: by 2002:a05:6e02:148a:b0:35d:695a:d323 with SMTP id n10-20020a056e02148a00b0035d695ad323mr27097787ilk.70.1702898727560;
        Mon, 18 Dec 2023 03:25:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id v28-20020a63151c000000b005c60cdb08f0sm17724802pgl.0.2023.12.18.03.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:25:27 -0800 (PST)
Message-ID: <bca31bff-5d5a-43e6-876f-0d8d20b4000b@redhat.com>
Date: Mon, 18 Dec 2023 12:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] mm/ksm: add sysfs knobs for advisor
Content-Language: en-US
To: Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213182729.587081-1-shr@devkernel.io>
 <20231213182729.587081-3-shr@devkernel.io>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231213182729.587081-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.12.23 19:27, Stefan Roesch wrote:
> This adds four new knobs for the KSM advisor to influence its behaviour.
> 
> The knobs are:
> - advisor_mode:
>      none:      no advisor (default)
>      scan-time: scan time advisor
> - advisor_max_cpu: 70 (default, cpu usage percent)
> - advisor_min_pages_to_scan: 500 (default)
> - advisor_max_pages_to_scan: 30000 (default)
> - advisor_target_scan_time: 200 (default in seconds)
> 
> The new values will take effect on the next scan round.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 139 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4f7b71a1f3112..f7387a6d02050 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -302,10 +302,10 @@ unsigned long ksm_zero_pages;
>   static unsigned long ksm_pages_skipped;
>   
>   /* Don't scan more than max pages per batch. */
> -static unsigned long ksm_advisor_max_pages = 30000;
> +static unsigned long ksm_advisor_max_pages_to_scan = 30000;
>   
>   /* At least scan this many pages per batch. */
> -static unsigned long ksm_advisor_min_pages = 500;
> +static unsigned long ksm_advisor_min_pages_to_scan = 500;
>   

That renaming should go into the previous patch.

>   /* Min CPU for scanning pages per scan */
>   static unsigned int ksm_advisor_min_cpu =  10;
> @@ -341,6 +341,16 @@ enum ksm_advisor_type {
>   };
>   static enum ksm_advisor_type ksm_advisor;
>   
> +static void set_advisor_defaults(void)
> +{
> +	if (ksm_advisor == KSM_ADVISOR_NONE) {
> +		ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
> +	} else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME) {
> +		advisor_ctx = (const struct advisor_ctx){ 0 };
> +		ksm_thread_pages_to_scan = ksm_advisor_min_pages_to_scan;
> +	}
> +}
> +
>   static inline void advisor_start_scan(void)
>   {
>   	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> @@ -434,7 +444,7 @@ static void scan_time_advisor(void)
>   
>   	pages = min(pages, per_page_cost * ksm_advisor_max_cpu);
>   	pages = max(pages, per_page_cost * ksm_advisor_min_cpu);
> -	pages = min(pages, ksm_advisor_max_pages);
> +	pages = min(pages, ksm_advisor_max_pages_to_scan);
>   
>   	/* Update advisor context */
>   	advisor_ctx.change = change;
> @@ -3722,6 +3732,127 @@ static ssize_t smart_scan_store(struct kobject *kobj,
>   }
>   KSM_ATTR(smart_scan);
>   
> +static ssize_t advisor_mode_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	const char *output;
> +
> +	if (ksm_advisor == KSM_ADVISOR_NONE)
> +		output = "[none] scan-time";
> +	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> +		output = "none [scan-time]";
> +
> +	return sysfs_emit(buf, "%s\n", output);
> +}
> +
> +static ssize_t advisor_mode_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr, const char *buf,
> +				  size_t count)
> +{
> +	if (sysfs_streq("scan-time", buf))
> +		ksm_advisor = KSM_ADVISOR_SCAN_TIME;
> +	else if (sysfs_streq("none", buf))
> +		ksm_advisor = KSM_ADVISOR_NONE;
> +	else
> +		return -EINVAL;
> +
> +	/* Set advisor default values */
> +	set_advisor_defaults();

It probably makes sense to not reset the defaults if the ksm_advisor 
didn't change.

Apart form that, LGTM.

-- 
Cheers,

David / dhildenb


