Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0507E0681
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjKCQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbjKCQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:26:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3DD6B;
        Fri,  3 Nov 2023 09:26:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc34c3420bso23675345ad.3;
        Fri, 03 Nov 2023 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699028788; x=1699633588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RxeQm4cmA2JrbAVa8HTs83GsMijucDFIF/Igdee3yE=;
        b=W7agCHmw8Wf8ksBG+oocMABlvXfmAtkin1FM2uDvC0/DWJzQYT5/CSJ8YToJorGPoD
         pbK/6MIe60aD0nKfJPmgkmyOQH+GIsNZI9FKW4zYX/YOxVGBowL+eIMrBKRtEgfS1G5D
         O3/QIWe8MzvHBnpC2MXu7FvnHF94+DtgunW9les5SDXRrj8V1I4EYQTW0FBuZqzmV3S0
         Fib3DUmFjnHokYxQm3cgt+NyY2rG6JbpMWDXnelH+I/GV2PeFIV7wFnZcXEK6EAzyZc4
         6/6TbYJbnwep3+1nU0PzVTG8PGcPYfcT0FkN97LmPU+RNmH8vMpnGQtWY0MszKGbs2Ao
         0A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028788; x=1699633588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RxeQm4cmA2JrbAVa8HTs83GsMijucDFIF/Igdee3yE=;
        b=G5tXNGIfFrhMj7Gs1tds4L8d7YH1FrWvSK26NDF84/evFVebXOr9E45XPKtZNBiM25
         EzTnwzw9JLOlGKOxQ55WPdzN4JQvUx7LnTHjVux00J4fC/NK4yR/kAhh71jztMTB16/A
         leJClUTNS7wUMdzsB+WGFYtvOV1/zalwrRchyRefmM3tIJ9WMIHhlZDBdpxvKvOd0fR5
         y9qaQe3HojnGzm5cRuXOav4BEHVH5r71uA0NopcdnXP2jHsnpbDpaCfWSqCGAXUVddLq
         aDtyfdGAABg6bOk1PI/+c5S6HJekLm1gVrmJfCQrGwMExNRVnkYUui45gTAfnWshFpYa
         sRcQ==
X-Gm-Message-State: AOJu0YxTS42aymXh3oUsy9wvgTxZfhAHZM3HR35hHjEInxW006h9zmmO
        wq8ZrsUk3GPIQ6pGxui4ijc=
X-Google-Smtp-Source: AGHT+IH+UfkDk1M09a11MgKdQ/HzVeEoAf8yilhUhOvIPnSu6kULsuDKgmMoS0l4cwRyk9qiS6Zxpw==
X-Received: by 2002:a17:902:f551:b0:1cc:5b2a:2f33 with SMTP id h17-20020a170902f55100b001cc5b2a2f33mr14887406plf.43.1699028787560;
        Fri, 03 Nov 2023 09:26:27 -0700 (PDT)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902b09600b001b8a3e2c241sm1609244plr.14.2023.11.03.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 09:26:27 -0700 (PDT)
From:   fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date:   Fri, 3 Nov 2023 09:26:06 -0700
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v8 1/3] mm/memory_hotplug: replace an open-coded
 kmemdup() in add_memory_resource()
Message-ID: <ZUUfHqaGGxjYc0wH@debian>
References: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
 <20231101-vv-kmem_memmap-v8-1-5e4a83331388@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-vv-kmem_memmap-v8-1-5e4a83331388@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:51:51PM -0600, Vishal Verma wrote:
> A review of the memmap_on_memory modifications to add_memory_resource()
> revealed an instance of an open-coded kmemdup(). Replace it with
> kmemdup().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  mm/memory_hotplug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8d3e7427e32..6be7de9efa55 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1439,11 +1439,11 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>  		if (mhp_supports_memmap_on_memory(size)) {
>  			mhp_altmap.free = memory_block_memmap_on_memory_pages();
> -			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
> +			params.altmap = kmemdup(&mhp_altmap,
> +						sizeof(struct vmem_altmap),
> +						GFP_KERNEL);
>  			if (!params.altmap)
>  				goto error;
> -
> -			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
>  		}
>  		/* fallback to not using altmap  */
>  	}
> 
> -- 
> 2.41.0
> 
