Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BA7A9E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjIUT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIUT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:56:12 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CDC06AD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:04:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-658220cf800so6857186d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695323069; x=1695927869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72sbDhRS8Dzkt1xA5dO7DmLpaXJoMznOGL4Bfx40IFU=;
        b=lcSn07ZfRebL+MTEvtj5ds+YV5g4X76pT1gAMkbcUTsGegcBlk2DVhxhjZFuq18HLP
         hO/bsL+oE5edIMYHwGPeHtuCX8tYam9IFrirTTc2VoGrvehugqzLMstOiU32D8SCBcEz
         4yYlnpgePhpcr3yDi3PbEXU+ze5sSJN6m2XswVDtnRD8G5pJR3P8KtEy9v//nJEYr1WT
         7c7EyVmXXrfjsXyeZCHvsC+cObV5uXHYRopUulJXFAs/DJpd/5YWmcFljZU6A9eEjXEB
         o1ChTLWSXqpe2V3ZUuyFvkSDU9QxO1w/fpqRKyDqGiHOdokekiXz3imHjBg+itAbof8z
         TiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323069; x=1695927869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72sbDhRS8Dzkt1xA5dO7DmLpaXJoMznOGL4Bfx40IFU=;
        b=qLqwufF4vME0NRVeC62jhDW0kwnLCBlI1+FuKhljR3qCZrbKSltSx8/Tw6siSLJ2iF
         2hf9neOaZirqkPNIKMwtHXHcgNp4lNs6VsEzrmaEBbkZ3gZdCDQZwsnDn9ltRIolHDby
         J1hC0uQlAl54VSlB6V4GKcSdRmaQ3zv3Aq6y+fS4xePbay3YHq0J3IO1cheKHKOcROfH
         CAgh66WN+A74YvUolElYXApKkoKVdnalu+KFTPX3bVOW72b02IP7oiNpVaC7EvBr6lUR
         63sKr+gMnL5r9pmU2QC2+CplB2nQxfL0TRtQ9VnEoPj5uGxHCLf2pHLe4XK3IILBvIcJ
         PPhA==
X-Gm-Message-State: AOJu0YzUoTZkqoo6KwIOslgyP/TkRMGYaLSdLM4CjeriGwqrWdF9hCRc
        2BBtwe096qED9+PJcf5P/xc3lA==
X-Google-Smtp-Source: AGHT+IH13k+gaZje9K+RHnKkR06Ap+odjdEBfUpCNJgKS/I8QTQFYuTV8YnbuGPHw9wUe5fDUUE36A==
X-Received: by 2002:a05:6214:2a82:b0:656:3035:1b65 with SMTP id jr2-20020a0562142a8200b0065630351b65mr655517qvb.3.1695323069061;
        Thu, 21 Sep 2023 12:04:29 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c11-20020a0cd60b000000b00659ab059d73sm553412qvj.0.2023.09.21.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:04:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjOyR-000TZ1-JK;
        Thu, 21 Sep 2023 16:04:27 -0300
Date:   Thu, 21 Sep 2023 16:04:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: Add structure to keep sva information
Message-ID: <20230921190427.GA13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-5-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-5-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:59:34PM +0800, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h    | 5 +++++
>  include/linux/mm_types.h | 2 ++
>  2 files changed, 7 insertions(+)

This is not a great way to structure the patches

This patch should move the pasid into the struct and do all the
infrastructure to allocate/free the struct.

The next patch should just add the list head to the now existing struct:

> +struct iommu_mm_data {
> +	u32			pasid;
> +	struct list_head	sva_domains;
> +};

The code looks fine though

Jason
