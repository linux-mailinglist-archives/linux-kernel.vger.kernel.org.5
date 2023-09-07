Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3A79780E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjIGQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbjIGQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:40:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E375E2726
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:40:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bf58009a8dso814363a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694104739; x=1694709539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAiBvTcyRsOXkihjAXwijX2b79d/6jZ/7uZYgdQjwfg=;
        b=PY8e4lLEZBkPnIrHFcR7YbHdMS75Wossa4ltOxhxr8Kl3HprCx5QuX0YFcCTOrJyqg
         uoInfP/uyE7pPVFXzDt6btMI5TlDEF6vcaBKYEdCdfVs1LC5WWx67GWexPGHt8o6CNTv
         FkhFoz9+94b0ntqnHlL6CIpyNUhsi7lkzk2IznnSefhD90GxfbY6rj2rHnI5lOc//g56
         xMzJUJltPuthTpAmGdGSO3+gkkLRg8wTTeZLo1/xBhigtMqoesJx877PussWcqW682BT
         BA3epdJMJmSug2TXoAh98A7HCvH0W7myPChq6f0MpAWCkPl+iUcCBXmI+5OawQnQRD7S
         VGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694104739; x=1694709539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAiBvTcyRsOXkihjAXwijX2b79d/6jZ/7uZYgdQjwfg=;
        b=TceBcGv8KZFY5aHxZ/phXKMCQ6Fws1KGF68iBDAUaQw2i/OEq6Zchu3/TAAUtTGatC
         /6kpBRcO/wLUjREPne8u7pVs6o2F/6ArfjK9K/KuEdtnJzDQ/QB4HT+XjgBZUzw+Mthj
         +595IgD6uGg5KmwZDvLfMYIO0efkTz9vERk8VV5MMVWzSCCcOSQ4hFJVPMqDxrjEYf5s
         szBDwsDLHYv9bUdShpnFKi6N2INqPJI8KVvGHCwc380WL9WFEP8yutGY6KueAqPSbkBk
         Ap1O2FfCutzU58n1TuMHxlz+h1vMZnM/QpVQgNfvxY61dpQJ/Lw3OGyLmq5zQaEmIuWV
         2T1A==
X-Gm-Message-State: AOJu0Yw4PugYQLLr9kRC6dKIYdOE0dcmVe0lPMUvefxo2dCEq43M07B3
        tW5RZfKSSSdRoySh0ELHeqEYIA==
X-Google-Smtp-Source: AGHT+IEuRWnwHgc+ZBKdtmJS94abNZCPgqRUkNRZbk5rlBgeJt8BMHp1bCJwoTQZQ3OLP1WMH8+BQg==
X-Received: by 2002:a05:6358:7e42:b0:135:69d5:1b13 with SMTP id p2-20020a0563587e4200b0013569d51b13mr21167rwm.0.1694104737828;
        Thu, 07 Sep 2023 09:38:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cdd0c000000b0064f5d312babsm6510838qvk.46.2023.09.07.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:38:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qeI1w-0017Sj-R3;
        Thu, 07 Sep 2023 13:38:56 -0300
Date:   Thu, 7 Sep 2023 13:38:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bo Liu <liubo03@inspur.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use helper function IS_ERR_OR_NULL()
Message-ID: <ZPn8oKc2s0HeBw1A@ziepe.ca>
References: <20230907071409.3805-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071409.3805-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 03:14:09AM -0400, Bo Liu wrote:
> Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
> open-coding to simplify the code.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please no, IS_ERR_OR_NULL is an abomination.

There are only two callers:

	for (i = 0; i < omap_domain->num_iommus; i++, iommu--, arch_data--) {
		oiommu = iommu->iommu_dev;
		iopgtable_clear_entry_all(oiommu);

		omap_iommu_detach(oiommu);

Obviously oiommu is not NULL or ERR since we derefed it

The second:

attach_fail:
	while (i--) {
		iommu--;
		arch_data--;
		oiommu = iommu->iommu_dev;
		omap_iommu_detach(oiommu);
		iommu->iommu_dev = NULL;
		oiommu->domain = NULL;

And here I don't see how iomm->iommu_dev can ever be NULL or
ERR_PTR. The i-- follows this:

	iommu = omap_domain->iommus;
	for (i = 0; i < omap_domain->num_iommus; i++, iommu++, arch_data++) {
		/* configure and enable the omap iommu */
		oiommu = arch_data->iommu_dev;
		ret = omap_iommu_attach(oiommu, iommu->pgtable);
		if (ret) {
			dev_err(dev, "can't get omap iommu: %d\n", ret);
			goto attach_fail;
		}

		oiommu->domain = domain;
		iommu->iommu_dev = oiommu;

And again we have always deref'd iommu->iommu_dev.

It is just wrong defensive coding, remove it.

Jason
