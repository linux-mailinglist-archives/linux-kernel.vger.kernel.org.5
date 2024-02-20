Return-Path: <linux-kernel+bounces-73377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181185C1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0209328444D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862A76416;
	Tue, 20 Feb 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyDhgOxg"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364A2599;
	Tue, 20 Feb 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447582; cv=none; b=oFNQz7iZADOdFhB7FSK346XXYAppZ7PVKLF92nlezjIZBVQ4apM+2riJrlspu28K2OAVEyXRt8wRuc/eFmvGiJ6Yvtrne2I0BXf2s8BBQvv7Jhf/1ii/V1Yqjw2PUnjC5kv/Isj4LKEeBGvNENz/a2Q6TdNnG+Dwt0kAFl60gXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447582; c=relaxed/simple;
	bh=suR8Rs0AHOQkNsEY0PApqeMkAnutzaV9k5g6uW+uUnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jME6sJVtKlO7fX68ZOYmDvZYr4gzWEzvdEy2x6E4ngFyCOXKzSa9xANCexgYdzMLNsOCahm8azrQvHtp9/rtgcHgIWiNRYMuXdpyJzcjnO1YQ/o5VtHzhMrKtytiAQ4jLslmzFiRFMyG7CzOYOX57qsJMe4ZhYCLzTwe9fQSGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyDhgOxg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e471f5f1a5so1121537b3a.1;
        Tue, 20 Feb 2024 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708447580; x=1709052380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5QPzR1FmjhBmkaK4qiZRtFOwvDZ75PdgfB2Mxx1Sq4=;
        b=iyDhgOxgPw3RCz3TPa3UwJCQOr5i4gyNCAKH4ZDorE804grYupLwCNC+yvD9qPVzDx
         aJqLFTTK58GPUg6b+8aOaxPwbHnpTarxXfi2dyn4VCJO+R+lMD5LzOGtwKdJQPyB8BQv
         N90NaCTMjw7CssP/UvKDtTOb5j36XydBzzLRFURHs3oQ4VyNVqwRz6dBQfKcGOo/000Q
         mjb085QoggkT+0eHFy/bPxa927h/0qo9R53SP758SJsJsy9JFWH75KJHHe3gPIpslo/B
         7fIXwk84Qar5TJLMnUhEKR61nvTHexsvCKP6RCniPSyvU7FMRZTl9N8Q5ekWU27gHHH2
         Nn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708447580; x=1709052380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5QPzR1FmjhBmkaK4qiZRtFOwvDZ75PdgfB2Mxx1Sq4=;
        b=LzC8VqfH0ZZ0+85AEMlFGS1QTz61pifdKVV5mAwOTUd5K7IeleoRPJfanc5J1KDQlN
         5VdAOeQdYIa3ReQ+hP4LHzV35gpUwF0YQeQA4FClsvmB2CgN+kmJD4/vDzcv0k07RZJb
         4xzu8Fbx5lNzGVvsSP+ES4Ms3qAlTVB9m50SneFNuLn00iuKY2QLNUYA715c14bwz1TT
         o36uqa2GEH0qOT3Xfcby/ABSHtHoM5AC5jTjoTcLUrC7npNXuRoq09nWJbxG/9s7BAJA
         MdJXsVVsbYjtlI6HiphtwGGWf1t2TcyZaSY4CwawqlcuG8JHupHvpCyC8lSyLVpDIQas
         z5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSwJ13phH3iEzsPsrB4BMVq0OCjEy7xYOfZox4N8ofvHwWHyY506tyjy5lf4RmcHIRZfZvtFsIQoNCE0rdXPBZD0CTdEuEuGv7u+URhx++Y9np04PUurgnBmxG8PpQoEAhtMuvHU7l
X-Gm-Message-State: AOJu0YxBK6hU2bgVz/iRtrfBl+1rgdvKi8m41oSdzs7Da+kJG8fwvFX0
	vOqirEpIqEk1mAfNcIRw5bod/e5DEora4JU1ulZttQGK9M9icaZO
X-Google-Smtp-Source: AGHT+IH/ghx4j/2kIKddFi+O1AqVnGJnknpzLZd2h6Jyx10a13jkfiSpFtwx2VlzgdnhOaICXtawPQ==
X-Received: by 2002:a05:6a20:9d8f:b0:1a0:aea4:a1fe with SMTP id mu15-20020a056a209d8f00b001a0aea4a1femr4308836pzb.1.1708447580263;
        Tue, 20 Feb 2024 08:46:20 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id p11-20020a63fe0b000000b005c6617b52e6sm6921260pgh.5.2024.02.20.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:46:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 06:46:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: jiangshanlai@gmail.com, corbet@lwn.net, paulmck@kernel.org,
	rdunlap@infradead.org, peterz@infradead.org, yanjiewtw@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
Message-ID: <ZdTXWrB8dascOIM_@slm.duckdns.org>
References: <20240219074634.2039-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219074634.2039-1-xuewen.yan@unisoc.com>

Hello,

On Mon, Feb 19, 2024 at 03:46:34PM +0800, Xuewen Yan wrote:
> +#ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
> +static unsigned int wq_cpu_intensive_warning_per_count = 4;
> +module_param_named(cpu_intensive_warning_per_count, wq_cpu_intensive_warning_per_count, uint, 0644);
> +#endif

wq_cpu_intensive_warning_nth is probably shorter and more idiomatic.

> @@ -1202,7 +1206,7 @@ static void wq_cpu_intensive_report(work_func_t func)
>  		 * exponentially.
>  		 */
>  		cnt = atomic64_inc_return_relaxed(&ent->cnt);
> -		if (cnt >= 4 && is_power_of_2(cnt))
> +		if (wq_cpu_intensive_warning_per_count && !(cnt % wq_cpu_intensive_warning_per_count))

But aren't you mostly interested in the first report? Note that these events
can be very high frequency and reporting every nth event can lead to a lot
of constant warnings. Wouldn't it make sense to keep the exponential backoff
while allowing adjusting the initial threshold?

Thanks.

-- 
tejun

