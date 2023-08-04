Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A076FC49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHDIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:46:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AD4234
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:46:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3bec2c95so13329145ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138810; x=1691743610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbSOiRVGFEbD9EWXxTVJOnnHg8d+rDuu3/77qsuWGAY=;
        b=mTKhUE+JGonMOrp+U11/tBMX4H8FfKWZQStdZ0kGgD8kXE9e2eR4Lv18vxWCf6mTaP
         LY4+qiYOxC93FwIpDIrSVCHyuTioULNkFXF2a+QoLha2SqYwyGJSPi5CYA9ytoYbWiPW
         q69JBWaOPmKfdVCpn9ErI0fOYXnIqNPkOxFFiFr/sQhA0r1mpDJl06kqmUjFk+D3RXdq
         xNTn6w7VxyaZ+F5V8UiwV/yLIVghhC0I0zlGsdZ44Z4pL7lqIgGSirXCKk/uJHvo0Ly6
         LZEroLsSRhFsdiS4VKrRWsgDQrjgi0BjTuymSJkIf7vVGJm2XR5KnJlyry9ZjiCIIzPk
         aTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138810; x=1691743610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbSOiRVGFEbD9EWXxTVJOnnHg8d+rDuu3/77qsuWGAY=;
        b=fdiIgfnmHKufla+zJs9Oq/iRUfUb92bG6cTC5bGZJw3121bjZl5VPFFIyukeqbPgYZ
         AAY6ngMiwMUR+NqEzAcXK1qMvv5VWb6Ijpvqz++/EyOm7dUniQU6OmLUvUp7o/GuMTe5
         aLC+gfWNOH3eosKwFNiUFkAZQ0RYDI9xB+RH7P2cWpVasCPnmdgWUopDHVS1lqOgix4W
         xUFWKVsY/w7lEOewJ4X/cLdewtL1ZgIBVE9lB18kUkKN5osn/gztAT7EpUdUnKmim+8m
         bocgK6u6QhIobhEFWMD5cvESu59HDzBF9GtIObcN4nqytGMmozPPKYoMLxA0TYWI1XAi
         UqqQ==
X-Gm-Message-State: AOJu0YycbTILmbwVpDE+QxlIJrHUSMTGyjlykedoHfTptUHnIHojkDcg
        mWAertQAqm/Q1oz1mzLjYUWSJA==
X-Google-Smtp-Source: AGHT+IGR60gw8YUIy3tAbLMT54aqn9AAI5w43Ca2RZvHrPtaJgaKasmhKnHdgjtyfY5BfJujf3bf9g==
X-Received: by 2002:a17:902:d492:b0:1b8:a67f:1c15 with SMTP id c18-20020a170902d49200b001b8a67f1c15mr1607154plg.25.1691138810102;
        Fri, 04 Aug 2023 01:46:50 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001b8a3a0c928sm1203861plw.181.2023.08.04.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:46:49 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:46:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, mingo@redhat.com,
        baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf record: Update docs regarding the maximum
 limitation of AUX area
Message-ID: <20230804084643.GA589820@leoy-yangtze.lan>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804072945.85731-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:29:45PM +0800, Shuai Xue wrote:
> The maximum AUX area is limited by the page size of the system. Update
> the documentation to reflect this.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 680396c56bd1..b0ee7b63da0e 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -292,6 +292,9 @@ OPTIONS
>  	Also, by adding a comma, the number of mmap pages for AUX
>  	area tracing can be specified.
>  
> +	The maximum AUX area is limited by the page size of the system. For
> +	example with 4K pages configured, the maximum is 2GiB.
> +

This statement is incorrect as it fails to give out prerequisites.

E.g., on Arm64, for 4KiB, 16KiB or 64KiB base page size, different page
size has different default values for MAX_ORDER.  Furthermore, MAX_ORDER
can be set by config ARCH_FORCE_MAX_ORDER, thus we cannot arbitrarily
say the maximum allocation size is 2GiB for 4KiB page size.

Maybe we could consider to use a formula to present the avaliable
maximum buffer size:

     PAGE_SIZE << MAX_ORDER
   ( ---------------------- ) * PAGE_SIZE
      sizeof(page_pointer)

   PAGE_SIZE << MAX_ORDER : the size of maximal physically
   contiguous allocations, which is the maximum size can be
   allocated by slab/slub.

Thanks,
Leo

>  -g::
>  	Enables call-graph (stack chain/backtrace) recording for both
>  	kernel space and user space.
> -- 
> 2.39.3
> 
