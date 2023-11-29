Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41F7FE0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjK2UIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjK2UIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:08:30 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353CBD54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:08:36 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58dd3528497so127620eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288515; x=1701893315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsP0DQHpiXNbk6VOGkakvcLwir1Z3HAMieU28c9jQgE=;
        b=hNr1qyKa3IFDg7glTtTQHcMwoUzqhXiXqoEj/yHOcapeWNqfVhWM7rKQSIkKXu32/T
         /bCegjz1uT35GQP3wJWwoj6qINesXPRMBz+thHeVswKvOsadxlDIeMPfFR8FxVimo5PD
         jBmRBXl4mWD9SelWLpovv2FhwFrQ0KF5BENaDf54hUrbdgNCNpxa7HiJer5kNnLFm2X1
         7ZZoW1FWDdsD4oYKs78/MYCgvoNXAM+wknsL6oyDUaPZYqLD97vQSiQSETEmaSBdL76E
         WZ/1ckx9NKsppI2SN+DazJA7cbwWy4hCgWlovX9CetXKcft3cQa5ImYO+A6YhFPWntR/
         9SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288515; x=1701893315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsP0DQHpiXNbk6VOGkakvcLwir1Z3HAMieU28c9jQgE=;
        b=neu673Mlncu/cTrcEJtmhCt3MyQz5iPhDE6GSQSi8NG1DHz0/Nskkw9MuUKcy1G4e+
         drOg7Doa9w0QFEkFjyhe0htdwI0Hnj6JACQ+VzUorD4N63+6C4ovL2iUKY1m4UTrsm8Y
         JS1EQa1b6NtuKyPqWz55Skl7YKVWbo0L3s6eEcLoqckz4yCPs6nt8h2PobgKswJ9qx9N
         LuTSgxvuCDdJzd39NY3oZdv5pOhfl+FgmxeDGmIiI4yFeeiim37nqqLga5P4Yw/q+zho
         kVoWDsmCRpEvRWHnIgD7H/E4tU7caHoHV5HF07waeiEv+k0l3cyKXEAJp+VXnl/z0tpi
         aIZA==
X-Gm-Message-State: AOJu0YyRS2RBdj1x/HTum9Qbv4G5NmErqVUdauElL8/7uZJ7HPml7hfl
        P9r7no0uMXZIKBtEeHmsru5+hQ==
X-Google-Smtp-Source: AGHT+IF2DmngnaCYi3zuAHFgnZ3DUfiOj93dwxgBEsP3uuFuleePYML8J8jh4Z0n1YU6yjF7zHrasQ==
X-Received: by 2002:a05:6820:1506:b0:589:db63:bfd1 with SMTP id ay6-20020a056820150600b00589db63bfd1mr27351574oob.8.1701288515551;
        Wed, 29 Nov 2023 12:08:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id y9-20020a4aaa49000000b0058a0809ea25sm2352146oom.21.2023.11.29.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:08:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8QrK-005pQ9-1x;
        Wed, 29 Nov 2023 16:08:34 -0400
Date:   Wed, 29 Nov 2023 16:08:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Message-ID: <20231129200834.GJ1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:10:33AM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 65d37a138c75..ce030c5b5772 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -602,6 +602,9 @@ struct dmar_domain {
>  					 */
>  	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
>  	u8 nested_parent:1;		/* Has other domains nested on it */
> +	u8 has_mappings:1;		/* Has mappings configured through
> +					 * iommu_map() interface.
> +					 */

Is it racey?

The other option is to make iommfd do this and forbid it from
switching the enforce_cache_coherency if the IOAS has any maps
attached. We can get the correct locking at that point.

AMD has the same issue if it ever wants to implement its per-PTE bit

Jason
