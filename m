Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2A78F19F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbjHaRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346695AbjHaRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:03:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46348F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:03:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1e780aa95so7250275ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693501382; x=1694106182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHgjjj35OJGXCjuPasaEGJ/b/jcHEmhkYoXcUVIk7ww=;
        b=kw1iHdM3wd9fH4rBn2CqW3Pp1R1zEfWD/YtWbYepI8tGr9+ks5wfgsaYELHIpTejT+
         NEfRlrGoprpz6DCTkuuWeiX6xA2xsLvPCs0rTeCzJqeViYqgiJCfPtPqg0KbKxVEZGlK
         0Y2I3K6k8caGBtB/9Nnq8Aef/rQhWbOhHFl3xt9cPcZJ7eBNOL29Z3E+6/OSr/uhYko4
         4WnAo4FyjotTccDNpIpn0f3h4zEjibiZMH1ehpvzHmIn9ld0Sj0cc77KPBoh2GqiyTgk
         l6oFxzV3s4fSuCBx3jcBuVIS89ZJ9yODf6+PKvdHvAp0F8iI5KwcgT2C/l9lFuaDw3Vy
         saRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501382; x=1694106182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHgjjj35OJGXCjuPasaEGJ/b/jcHEmhkYoXcUVIk7ww=;
        b=lB06psrfTxoz4VrI49i9N6xIH8yYYzaNaFsOgCcj5L8GUw7cXhZZr6RmXjrk1P0CUu
         6B0BybTJ/O4VotZsQP+9Z3IFKHYMr03GSvOLTYdSI+uUvIIuC711iA5bssxJ5OuIfyl1
         pMhRqI81s8NYnpi2bCFjk7kRfEHIc+kt3sXN84BT7orpMajcW9exr79TgDNaKt3uFddT
         wseOlb7r31m/ltysh/iaDY08nCcR4JwFmN4Fv5N/8y/Vp6Whk2ajEfbReCpTjW7nsHzP
         T7odJLbR0jjFbM8KIKIB/1FDFuReeD7U2UYlNrZb6AxjFxG740lsINsNeIp3iysZHG9w
         IkiA==
X-Gm-Message-State: AOJu0Yy4XwAtmNuA7j6TWyMhW+sB6lhmSxnK063pPArU0G9G2fdNSJaT
        Ijauuv6dc05RlPTD7rEX23ii4A==
X-Google-Smtp-Source: AGHT+IF+htXs2E3/1dWO3dXoakLSbjGOY+B/JfHkO5GVPE7OJGYw2rF1HEEP9wx5/tbOWtsOFEQO4g==
X-Received: by 2002:a17:902:b588:b0:1b6:649b:92cc with SMTP id a8-20020a170902b58800b001b6649b92ccmr185987pls.69.1693501382283;
        Thu, 31 Aug 2023 10:03:02 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001b9d95945afsm1482930plb.155.2023.08.31.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:03:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbl4M-000IVp-Uu;
        Thu, 31 Aug 2023 14:02:58 -0300
Date:   Thu, 31 Aug 2023 14:02:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Message-ID: <ZPDHwseKQ3IC8dT9@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
 <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:14:20PM +0800, Baolu Lu wrote:
> On 2023/8/27 16:43, Tina Zhang wrote:
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index e95b339e9cdc0..e6377cff6a935 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -306,13 +306,13 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   	unsigned long sflags;
> >   	int ret = 0;
> > -	svm = pasid_private_find(mm->pasid);
> > +	svm = pasid_private_find(mm_get_pasid(mm));
> >   	if (!svm) {
> >   		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> >   		if (!svm)
> >   			return -ENOMEM;
> > -		svm->pasid = mm->pasid;
> > +		svm->pasid = mm_get_pasid(mm);
> >   		svm->mm = mm;
> >   		INIT_LIST_HEAD_RCU(&svm->devs);
> > @@ -350,7 +350,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   	/* Setup the pasid table: */
> >   	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> > -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
> > +	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm_get_pasid(mm),
> >   					    FLPT_DEFAULT_DID, sflags);
> >   	if (ret)
> >   		goto free_sdev;
> > @@ -364,7 +364,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   free_svm:
> >   	if (list_empty(&svm->devs)) {
> >   		mmu_notifier_unregister(&svm->notifier, mm);
> > -		pasid_private_remove(mm->pasid);
> > +		pasid_private_remove(mm_get_pasid(mm));
> >   		kfree(svm);
> >   	}
> 
> There is no need to use mm_get_pasid(mm) in the set_dev_pasid path. The
> pasid has already passed as a parameter. Perhaps, pass domain and pasid
> to intel_svm_bind_mm(), or simply merge intel_svm_bind_mm() to
> intel_svm_set_dev_pasid()?
> 
> Something like below?

Yes please! As a prep patch 'remove mm->pasid references from vt-d'

Jason
