Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE57D3F22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjJWSXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJWSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:23:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5089B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e308a751so1869263b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085414; x=1698690214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asV/mzEgZ0QPpPGTkL/tZKxIZbV4pZf1YGZ30QE3Rpg=;
        b=AUeGajGcM9qqd0H0+u84YQUazg5mZQSwadjvuIsUeKb8yUmWQn/xmc7Whjnxg7YNDv
         OLaZ6TPBJNlFrf/0GYxZwWVgO5T0PpAe511cRJx3fatgj7qQmk3EUia+c095gQ45z2em
         vMDGCKr1HdcDOhO1/MNr7TgnyAgQmcx5lk++9UpUsv9WTU7lFHuAmMSELdOYH1mKuUmK
         8+2hMZya9TPOSjx9FQ7j40yEA05AQH3+EpDf7o/diKFgBqLGXvtWKfiZmZbrZQm1VfEd
         9Ll36m7GRWwyEoxMMZ6JX++nr0sr5ajAzK/UHI+YFe0obsrym+SMlDg3gXTNDN8pHi2h
         NQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085414; x=1698690214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asV/mzEgZ0QPpPGTkL/tZKxIZbV4pZf1YGZ30QE3Rpg=;
        b=Gj8n0Qi5O0EC4D32M56UpmoCm/ll3D1fs9i7HkXT1Rfm8/mHPhyoLHVtXle52ITQX5
         DecmsIrHTbDxmAIwnZIok66KWCoFb0WoUXNpAFW/383aS2+u0CUZ6zPOsrE0tTkCDwhs
         iAFAFf6jWtiYAWI+rorvsMWvclZhrVywO7o+w1dq82ZW97GOV5v88ilGZ69A1xtyxR8r
         loI3aWLdnUdGMkmIPuPQ3uLlQDfpCUfSY9xLhP2PvyZCJWc9r33cYCH+ZuwcztwCd+yC
         YUDb4klXws724bke4OiVOHkJY9Djg1mM0HHBcV2olynbKm6Pwc1FM6+beXOhfGD953Bs
         yRJw==
X-Gm-Message-State: AOJu0YwB6TnAnzgcteJ13KKV0fmslNvBvZ5QGStez9rXH/MAuG9imMyf
        RAVcajI+UEinnJR0veusHbGIwQ==
X-Google-Smtp-Source: AGHT+IEqObC+cIKLIFikGXPFoFK2xQU9I3Zh+K8TuPgknSCWC7VYdDuKHSMhiAnrYCeSVxsNF5l/Cw==
X-Received: by 2002:a05:6808:1a24:b0:3b0:f8bd:9503 with SMTP id bk36-20020a0568081a2400b003b0f8bd9503mr8622436oib.10.1698085414027;
        Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id j9-20020a544809000000b003b2e4b72a75sm1582234oij.52.2023.10.23.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:23:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1quzaO-003jRh-QZ;
        Mon, 23 Oct 2023 15:23:32 -0300
Date:   Mon, 23 Oct 2023 15:23:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     sharmaajay@linuxonhyperv.com
Cc:     Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Message-ID: <20231023182332.GL691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:12:02PM -0700, sharmaajay@linuxonhyperv.com wrote:

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ef3275ac92a0..19fae28985c3 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		wq->id = wq_spec.queue_index;
>  		cq->id = cq_spec.queue_index;
>  
> +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp, GFP_KERNEL);
> +

A store with no erase?

A load with no locking?

This can't be right

Jason
