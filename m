Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E1800D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379184AbjLAOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379169AbjLAOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:38:05 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40609F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:38:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d8c38ea78so111522485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701441491; x=1702046291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=RydNWY3ShdLBfiklNm8Dqxqb+OQBGaFWZ8FG3cLe3fqBHCVohiDx0CCou5GDZgR7aQ
         DBcxY8pR6jXv2HvO1+mACu1KTgp72zLeGKfFy/qCqgp5y3ajSHuEPDFTyzxZ+kALlyw1
         F0aiTsAeMCque0+Ng4k/oSNE9fq37XeGa6U84VG3kOVHR/JgGphNdo/69LmgtcE7EaaV
         zmYEWMlpU2xQ2I2ei0xxqXDg0o5accz1wWpGoBi8kbkoLItVWd+HxiLB3JM3tuZ6RWKI
         z0y0aZe+cOU/sRQqdruVei9EDRDd+8TOFd+2/sk27Y6OyqSzd/jAZ5aKNSqn6M6aNoyw
         Jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441491; x=1702046291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=HePCxkfgnuZIkTu3RP9gpY6ZB6bNdnKJltqDspolQS/f0wf/K/Ekv5gM4uDCo/d1A5
         jytw0zuOxEaD4eSA+2nquxJaJhiv27GJ4meNg+7GjFseLix5EZVbCnqd2ZGAeA0HoRbV
         yO2bwqNm3ArubLHDSdBFJXrHh/MqiLq8/vUxTWjpwzAXYwgIC08TPVHpT6vf/L0BGuA/
         p3tIs4gvOSi3vAaF1WZi7wnS/prp4YUuCzCg3EkW+eMaSfAkkIMiN4wgaCtF2Ks9g9dG
         Tn58prhshxdb+rzS11ayjLagl3SRsE8rJpLg2V3hbJLZntvwE78tu3c9QlXl0PvN3z4v
         6mYw==
X-Gm-Message-State: AOJu0YxahjfbyTlznLdL1UL/OK9pspGRJdlMufponBju2rH/U1sulHxq
        BKy5I959sGlL+uYgiD3qgijlcw==
X-Google-Smtp-Source: AGHT+IFe8E0VqRO1AEaToLaRVQzH95JILmWc2UsaE9FahWhPD0VYJtmSp9BHS2kePetr70qtmP4TFw==
X-Received: by 2002:a05:620a:c0d:b0:778:ba89:2fbd with SMTP id l13-20020a05620a0c0d00b00778ba892fbdmr22271407qki.36.1701441491386;
        Fri, 01 Dec 2023 06:38:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a110100b0077dd463da60sm1533049qkk.126.2023.12.01.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:38:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r94eg-006FYA-Dl;
        Fri, 01 Dec 2023 10:38:10 -0400
Date:   Fri, 1 Dec 2023 10:38:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Message-ID: <20231201143810.GK1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:

> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
> +	void *curr;
> +
> +	if (!iopf_param)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_lock(&iopf_param->pasid_cookie);
> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
> +	xa_unlock(&iopf_param->pasid_cookie);

No need for this locking, the caller has to provide some kind of
locking to protect the returned pointer.

I'm not sure how this can work really..

What iommfd wants is to increment the device object refcount under
this xa_lock.

I'm not sure this is the right arrangement: Basically you want to
have a cookie per domain attachment for iopf domains that is forwarded
to the handler.

So maybe this entire thing is not quite right, instead of having a
generic iopf attached to the domain the iopf should be supplied at
domain attach time? Something like:

iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
                         ioasid_t pasid, struct iopf *, void *cookie);

The per-attach cookie would be passed to the iopf function
automatically by the infrastructure.

Detach would have the necessary locking to ensure that no handler is
running across detach

Then the cookie is logically placed in the API and properly protected
with natural locking we already need.

Jason
