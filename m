Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E07AB3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjIVOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIVOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:42:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3DC6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:42:24 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d776e1f181bso2615294276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695393743; x=1695998543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlcUHfBjvDv/+8kmxymQCbCEugELBDLa0lrBy4oxtDc=;
        b=Pid8+zudDNngq0U2uLvUJm9netGsnWSnl0ai0iUgUe5IMQY3lDwDrKOMKO+cu5nJT4
         v4jQYTvnmb86+WRJGykA0eS2l2X7pIFjDkuHPHt2gE/2nWCTNMdV5ETcJjIW/IKwnk5A
         VMy+kmIXkDQcEZ1N3DXrQdTeLXIU8au6NxbsyGV9upPIei3DXmZ8hmZ1m31mZUZqXcZ2
         iPydaHiZPVcR78W+vfmWD8ocdj4IopkRile62wJvKzQaKxYM20mt9fPLfmKNwD3DLs2y
         VOZ5Ik0o0HWg2yfuBMMFXd6tpYl50y1YtKp/YIHWbGsnIbeoqyRfNzgYBxZr+hqq94n0
         TKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393743; x=1695998543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlcUHfBjvDv/+8kmxymQCbCEugELBDLa0lrBy4oxtDc=;
        b=HyGWts8joNOWsqLFTZg0zIac85vZejg4gnZUs2gTUI8gzQ89WPiRLVNEeD++WYR2nc
         JttkN9/Ck3a1kMrlqn5Ildi0iWxq+Ki9eiMuK68pVkqDHgyA6jJf6lCNfVuOj88YdMnf
         AIIAR0DRePGYwfeATa2sfeP03rQTcHSfXryEdNpX/Tv6UXouE1WApICbmjsHywVpkMGB
         NLJHFm297MW8ZlB+JAmY+3kU5fY8v6WEvRpJt/fbETDcYF3SvgvOASrpa1flWzcWjLty
         MxDWecyhlyypw3pP7rAdLsRTbEyWi5M+q2ubmO4//1RxtiEL5N0Rp6t6Vv6PL/+jjLFn
         3NvQ==
X-Gm-Message-State: AOJu0YxfUurb9QfB/kdvTqi6AlVJs2oQFFoDdstZ5E4tXMGFAzUueqHN
        qsJGSVpZ2xdqf6Wq9Wtf5vIZfw==
X-Google-Smtp-Source: AGHT+IEIruOEpifrm1oS0n3df3jP1SIS1yx5cEIbpMqLOWOUy3gIHUmXlub4hrYEyo8SfNoLg5tF8w==
X-Received: by 2002:a25:5c9:0:b0:d7b:8d9a:4ec5 with SMTP id 192-20020a2505c9000000b00d7b8d9a4ec5mr8517791ybf.41.1695393743267;
        Fri, 22 Sep 2023 07:42:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a11-20020a0cca8b000000b0063f88855ef2sm1462282qvk.101.2023.09.22.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:42:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjhMM-000Ybv-7d;
        Fri, 22 Sep 2023 11:42:22 -0300
Date:   Fri, 22 Sep 2023 11:42:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs
 that support them
Message-ID: <20230922144222.GF13795@ziepe.ca>
References: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
 <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:21:17PM +0100, Robin Murphy wrote:
> On 22/09/2023 2:40 pm, Hector Martin wrote:
> > Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> > IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> > introduced in iommu_dma_init_domain() to fall back if not supported, but
> > this check runs too late: by that point, devices have been attached to
> > the IOMMU, and the IOMMU driver might not expect FQ domains at
> > ops->attach_dev() time.
> > 
> > Ensure that we immediately clamp FQ domains to plain DMA if not
> > supported by the driver at device attach time, not later.
> > 
> > This regressed apple-dart in v6.5.
> 
> Apologies, I missed that apple-dart was doing something unusual here.
> However, could we just fix that directly instead?
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2082081402d3..0b8927508427 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain
> *domain,
>  		return ret;
> 
>  	switch (domain->type) {
> -	case IOMMU_DOMAIN_DMA:
> -	case IOMMU_DOMAIN_UNMANAGED:
> +	default:
>  		ret = apple_dart_domain_add_streams(dart_domain, cfg);
>  		if (ret)
>  			return ret;

Yes, I much prefer this to the original patch please. Drivers should
not be testing DMA_FQ at all.

I already wrote a series to convert DART to domain_alloc_paging() that
fixes this inadvertantly.

Robin's suggestion is good for a temporary -rc fix.

Removing the switch is slightly more robust:

if (domain->type & domain->type & __IOMMU_DOMAIN_PAGING) {
  [..]
  return 0
}

if (domain->type == IOMMU_DOMAIN_BLOCKED) {
  ..
}

return -EOPNOTSUPP;

But not so worthwhile since I deleted all this anyhow...

I'll send out the dart series, it can't go to -rc, so a patch is still needed.

Thanks,
Jason
