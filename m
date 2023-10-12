Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA07C6F78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjJLNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJLNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:43:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C591
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41811e7ac3dso5789201cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697118191; x=1697722991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MluVB4G/OSSjJ/0d/xLFgibgQBCCZLZ69FsduH+Fl7s=;
        b=ZmH0R9ul7CeOHiByc5T+DmW7pX3ndWagE3zVRCuVEeYL4Wh+5sW5SHZUvQ+yCJAdBX
         0cwuwElulLbDbKEWsm8kKd0JPmf8qc/nKPu1QPvMGvuFQX0qfpp5h0udpRZzLJzgScth
         H5LW9oHG/u2FRX80CuBwfo6HIo3h4ElKtrns47/jnxN1y9yqO9V3skDZQLhMTZrWkGke
         LrbhuX2hSUnGn9dOnFk7Jii4tvLVz2rPu/jY4AWsFLJSGkKdvhH4OkauHy7lDaBpu1NP
         gFvuwvA5pGVr0t27inoOZqxWg0oibvsvsQnXZnsbY+xaArUYXmBhYhiLbkhvH6u16crV
         3bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118191; x=1697722991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MluVB4G/OSSjJ/0d/xLFgibgQBCCZLZ69FsduH+Fl7s=;
        b=T2d0KjgFI3hl0y5g+7RvalWxhejMMYm9k3awGMxCWhEd1M3golOhydwTzuXKZkbPP3
         0xSCzSb2Jjx34sbLmGIQ0nEgP4kFFpGYwKlslBJw0QkJ1sNMXLC4UfrjVT3IMC5CPzGW
         sDayzETqBT1pbFbbwSiPUoetFeR2PLgXTvWcKxUvDMRSKNoCgp+lBFYph64phjljEiEh
         JvtOaI/Q7uAbA8Qjv+PxjWovk8nqLQ52vlrS6aFoS55/AiMTPUU2kN0UoZCtDv7MP4uI
         2dJlPKq02J3p6sBRmNrHhZTTp+UfjAS5rwf0BXC42c9x/G4RnlL9R1AYjs8r/MdkE6j/
         wSEA==
X-Gm-Message-State: AOJu0YwzQL8BjeXCXeNt1eq2qcpOi/kfbjPF4qOPTEehtN8npDUyKyD9
        X/pt5LWRJO+jQqJ0Aglix2T7OQ==
X-Google-Smtp-Source: AGHT+IFTSk1TBC/FWAOmcIsydmdZ4wEnuCWLZA2bbATovdZPo3v6ZHeDGPrL3D9l+NocZ0jjwHBfwQ==
X-Received: by 2002:a05:622a:130b:b0:419:a2c6:8207 with SMTP id v11-20020a05622a130b00b00419a2c68207mr30087662qtk.22.1697118191240;
        Thu, 12 Oct 2023 06:43:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id f27-20020a05622a1a1b00b00419b5274381sm6198340qtb.94.2023.10.12.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:43:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqvy2-0018hm-48;
        Thu, 12 Oct 2023 10:43:10 -0300
Date:   Thu, 12 Oct 2023 10:43:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Nicolin Chen ^C-cc=iommu @ lists . linux . dev" 
        <nicolinc@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231012134310.GI55194@ziepe.ca>
References: <20231012030112.82270-1-tina.zhang@intel.com>
 <20231012030112.82270-5-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012030112.82270-5-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:01:11AM +0800, Tina Zhang wrote:

> @@ -1188,15 +1193,26 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  #ifdef CONFIG_IOMMU_SVA
>  static inline void mm_pasid_init(struct mm_struct *mm)
>  {
> -	mm->pasid = IOMMU_PASID_INVALID;
> +	/*
> +	 * During dup_mm(), a new mm will be memcpy'd from an old one and that makes
> +	 * the new mm and the old one point to a same iommu_mm instance. When either
> +	 * one of the two mms gets released, the iommu_mm instance is freed, leaving
> +	 * the other mm running into a use-after-free/double-free problem. To avoid
> +	 * the problem, zeroing the iommu_mm pointer of a new mm is needed here.
> +	 */
> +	mm->iommu_mm = NULL;
>  }

newlines after all the }, between functions doesn't checkpatch
complain?

IMHO this hunk should be moved to the prior patch.

But it all looks good to me now

Thanks,
Jason
