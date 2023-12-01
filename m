Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B126D800FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjLAPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:42:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670319E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:42:32 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77d6b28aa9aso117228085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701445352; x=1702050152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5OluPhgDT3nAw0/mpsAOoQF2zqQkql7YLDt75eO1Ow=;
        b=Ng68X9q7uWhzgH8+vw3hnH3jIliA7sQWGau9BEHHVvKFw8t2vgwgzG3WLzdAlwV2h6
         r2aQ/QZJci+VkwE1NXHabaeoIyQq17Naxj1N5Ox7DErwIW15zJ/lmofMIt2gXeKrDWfT
         IzCykAfijXnBy+WVZxuIqdkJwpDPuqtYEJVktxqLcVvrKoW0ceLsPBlEHhs6mUMKum9y
         +uwMJxtD/icDgF7fI6zZbGhGqBX0uLqhrl9hJsdeIhSTUNeAUM1cwncfMmxZdvqq+sao
         BR4jkbxt/EQjZFm5d1Kv28TUr2STeNCCmVb0IGNMBkdzHofnvAEA44OuVY7DzFIgsR/c
         gsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445352; x=1702050152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5OluPhgDT3nAw0/mpsAOoQF2zqQkql7YLDt75eO1Ow=;
        b=mdmrAj1DdC8EtFAyWu4wuFHEuuIOD05el26KmgOLjyV6gGT0pwR0sw+RWSsqpUslL3
         rRFRMmQQfjiJPYUpFON+B5ymOKbqutPPeqGD1bddWXdmcABfQ34xUBgnreCqtandGS6J
         1DVvX224zV5BK6vq7ZYIlc5OwxASKgsNn1+mazguRzHh+XtSRHCVqZPcRovsw+RZ7h0O
         CcpXLFOdgv75dtn1DnqgbDpBsxPWBAiUbxj/jRGWcnkRLC9X8OmIQZZ7TzV2h333Qr3r
         XkpZdw3XXTLggsgmTgC9IA9KeNWFTtxTCWc7bn0psidjODOLuX8l0P/1eYVuXfaLo3QZ
         WSnQ==
X-Gm-Message-State: AOJu0YzsW8v/bUeZbFCJduN88JDEI0a3DpOxt7nV1fxvXjEB/o6cpKoJ
        u1VhuqK0NyNioBsaoEhDERkPbg==
X-Google-Smtp-Source: AGHT+IGJqqOzBXgm1gG3l4eq+iJtvvsWrjEeRODObVtVODE5xSIuIkhfCOaHdl0inwKoRnlUy4vC5Q==
X-Received: by 2002:a05:620a:4092:b0:77b:9bf1:6526 with SMTP id f18-20020a05620a409200b0077b9bf16526mr29808153qko.44.1701445351820;
        Fri, 01 Dec 2023 07:42:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a048b00b0076e1e2d6496sm1584171qkr.104.2023.12.01.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:42:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r95ew-006GSJ-Ja;
        Fri, 01 Dec 2023 11:42:30 -0400
Date:   Fri, 1 Dec 2023 11:42:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] iommu/arm-smmu-v3: Remove unrecoverable faults
 reporting
Message-ID: <20231201154230.GC1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02:16AM +0800, Lu Baolu wrote:
> No device driver registers fault handler to handle the reported
> unrecoveraable faults. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
>  1 file changed, 13 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

If we do bring this back it will be in some form where the opaque
driver event information is delivered to userspace to forward to the
VM.

Jason
