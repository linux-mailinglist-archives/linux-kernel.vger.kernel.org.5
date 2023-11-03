Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C07E0310
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjKCMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:38:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA583
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:38:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so291832966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699015088; x=1699619888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbOdcT3r22Shg0jXhPNX4VE9G2kLj20NGnovJRJb6M8=;
        b=XqAZGt5oP9uTcZpNMtnNkoeRsxaJ8mi6U3/FMQgEz95FbwwPtVljMBLm/wcBmrfiee
         h013q66VZ67rzXgop5Dy1VPz1baRsXeqM2PZnkkKkiiEJxxcsPtMm4Xn+32l0qYX+mjs
         LsPf25gU6djqZX63yIqWm+pU0s9eIwsG3p7Sb7Lx1E8T0PlCs0X0ytNDmRtr7G1EavQg
         qSf1gjgakssGxeGo8KkyuY/1LtWDZCVkmF+joxEtYRDsnCQb8Iaf8Zc54xt7WNMguTP0
         GKxZL9OJA3e8/Uvli614KlNuK5AM7G3JN2DAXyLsO5Iw8vTi/UqTMTtp/b34+6iWKZ3X
         hRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699015088; x=1699619888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbOdcT3r22Shg0jXhPNX4VE9G2kLj20NGnovJRJb6M8=;
        b=vOYVEQmN0qTojlgrdeERAtUnLHNO0y4HFgCpxa85XCkjkuo8SsiXgjk+2i5uWnNFvr
         oHnyM6bBFpOmBXHb8ypnBoz+5SwNJyDTVy4I2Eed+nyXVIAXMtlbv7foy7363DP+QKBT
         mqxX8k2AADKXfbhdqEa+UMowOadIRKWnK+E/cSzwUXAdGPpJ0PSU7EbOpu1LGm1EhLoa
         O48YbaUzWr5xSXQUtvJ20/uSNk80VJAUdTs6tIwjRqFkM7QB70ksHHsDIm+quxICYDrc
         lT0zg0gdgKhCoAb/tUgMEJHYXe46AdZ+rbZfLtXGma8490DHoFPLWIKOgVIYiXjLG2q+
         PlOg==
X-Gm-Message-State: AOJu0YzaO6knI+ADoPLNHdhBVNRga8/T9/8ewn8CJ3lmGdvJrQloWrF+
        PaZhBrMSZwvaK0uyXwvduZM=
X-Google-Smtp-Source: AGHT+IEhXDNG96kPoYVE6YKWqMCxKtmin5dVTtmFwFkgvYtEFu//xfxUUo3NcQ8I0tvu+HwweN3LDg==
X-Received: by 2002:a17:906:db01:b0:9d5:9ff5:ce with SMTP id xj1-20020a170906db0100b009d59ff500cemr6210521ejb.34.1699015088316;
        Fri, 03 Nov 2023 05:38:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b004068e09a70bsm2353829wmo.31.2023.11.03.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:38:07 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 3 Nov 2023 13:38:05 +0100
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 01/13] perf: Simplify perf_event_alloc() error path
Message-ID: <ZUTprUojg7eHoxQI@krava>
References: <20231102150919.719936610@infradead.org>
 <20231102152017.847792675@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102152017.847792675@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:09:20PM +0100, Peter Zijlstra wrote:

SNIP

> @@ -11936,24 +11957,24 @@ perf_event_alloc(struct perf_event_attr
>  	 */
>  	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
>  		err = -EINVAL;
> -		goto err_pmu;
> +		goto err;
>  	}
>  
>  	if (event->attr.aux_output &&
>  	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
>  		err = -EOPNOTSUPP;
> -		goto err_pmu;
> +		goto err;
>  	}
>  
>  	if (cgroup_fd != -1) {
>  		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
>  		if (err)
> -			goto err_pmu;
> +			goto err;
>  	}
>  
>  	err = exclusive_event_init(event);
>  	if (err)
> -		goto err_pmu;
> +		goto err;
>  
>  	if (has_addr_filter(event)) {
>  		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
> @@ -11961,7 +11982,7 @@ perf_event_alloc(struct perf_event_attr
>  						    GFP_KERNEL);
>  		if (!event->addr_filter_ranges) {
>  			err = -ENOMEM;
> -			goto err_per_task;
> +			goto err;
>  		}
>  
>  		/*
> @@ -11986,41 +12007,21 @@ perf_event_alloc(struct perf_event_attr
>  		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
>  			err = get_callchain_buffers(attr->sample_max_stack);
>  			if (err)
> -				goto err_addr_filters;
> +				goto err;
>  		}
>  	}
>  
>  	err = security_perf_event_alloc(event);
>  	if (err)
> -		goto err_callchain_buffer;
> +		goto err;
>  
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  
>  	return event;
>  
> -err_callchain_buffer:
> -	if (!event->parent) {
> -		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> -			put_callchain_buffers();
> -	}

hum, so this is now called all the time via __free_event, but it should
be called only if we passed get_callchain_buffers call.. this could screw
up nr_callchain_events number eventually no?

jirka

> -err_addr_filters:
> -	kfree(event->addr_filter_ranges);
> -
> -err_per_task:
> -	exclusive_event_destroy(event);
> -
> -err_pmu:
> -	if (is_cgroup_event(event))
> -		perf_detach_cgroup(event);
> -	if (event->destroy)
> -		event->destroy(event);
> -	module_put(pmu->module);
> -err_ns:
> -	if (event->hw.target)
> -		put_task_struct(event->hw.target);
> -	call_rcu(&event->rcu_head, free_event_rcu);
> -
> +err:
> +	__free_event(event);
>  	return ERR_PTR(err);
>  }
>  
> 
> 
