Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B77EC432
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbjKON6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKON6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:58:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D227AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:58:08 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc56255e3so42713261cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700056687; x=1700661487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=fxE5AZTqZNA1c3pM8PnL1ZfVKuwJpxUheldfHGEsWEtAp2gEVDDCk/sQbeVIYFoPxf
         9KGVuG2GTZ61BFzp6iB80uFJEEgO+3AcP74J0XslGkuiEeomjUVANK79vYcLWKYP4xyS
         2LgGCbLrvB/pQw6jo94DnBTy0KASnx4Dq0zcgzgTmGzfAnIu0l+CQa08/nM1FfDi0klD
         8lmM/ZtEAne1zy4g4j5vifdPvxi4iYwH78y+Shm8tYEYEiDWLvvK/1pfqtmYfrkpgLuW
         6zdCfOmRw/hQ9xXIzXdRA9MhRyYweUY7Gf/m2FFpFEx2vzp/qthF0gtt7XlhbzRn9XZi
         zq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056687; x=1700661487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=vISWELZPFbUR6msaWmUQSH3SmAG+Q25esRlWpLGQppARZqB9Qp+zh/p2BgTqvml7Le
         fXiqG0exVg7I2iqk1vZc987aLIXCJYwWJqjITg434D62Oj3vqHpQbU+BLW11NnAtIcgH
         YBqVjJG/zit4lSJUwq50wQIgDOSPxUBkgKqqj/o/eFBwPBRpL9bIjFnsy3kv9lYHh34W
         q+o9Z2qzvfFnZTIyihnGq3Zaw4BVpeLlFG4etIbmb0jiw750Q7tNepbY4uv6gSb86gNh
         4PlwSspsu7asjKcpcVKNKg6ecxHTNbWPBVg+b2ruIcScL2AnfMwpdhzhfgD+kTp8dQTM
         m9wQ==
X-Gm-Message-State: AOJu0Yyu3aoms/bNkysC3EPoWaMQaO2fHnu4INw799z9f4oSwXtGh5mw
        q9bd0qXVTZ29aOuZpm7YUMyNvA==
X-Google-Smtp-Source: AGHT+IHaKxJpp001exVovZ4EBDqBHs310q9gAHegSv6c6n8XW7Wb8GybvCcKXWJGvY9i5/iI45wjWw==
X-Received: by 2002:ac8:5dd4:0:b0:421:f8d8:e0d8 with SMTP id e20-20020ac85dd4000000b00421f8d8e0d8mr1428187qtx.38.1700056687165;
        Wed, 15 Nov 2023 05:58:07 -0800 (PST)
Received: from ziepe.ca ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b0041818df8a0dsm3553547qtp.36.2023.11.15.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:58:06 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r3GP8-0007bi-2i;
        Wed, 15 Nov 2023 09:58:06 -0400
Date:   Wed, 15 Nov 2023 09:58:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZVTObiybC1MYlSam@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:

> This is the right way to approach it,
> 
>    I learned that there was discussion about using io_uring to get the
>    page fault without
> 
>    eventfd notification in [1], and I am new at io_uring and studying the
>    man page of
> 
>    liburing, but there're questions in my mind on how can QEMU get the
>    coming page fault
> 
>    with a good performance.
> 
>    Since both QEMU and Kernel don't know when comes faults, after QEMU
>    submits one
> 
>    read task to io_uring, we want kernel pending until fault comes. While
>    based on
> 
>    hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
>    there's now no fault,
> 
>    thus this round of read completes to CQ but it's not what we want. So
>    I'm wondering
> 
>    how kernel pending on the read until fault comes. Does fops callback
>    need special work to

Implement a fops with poll support that triggers when a new event is
pushed and everything will be fine. There are many examples in the
kernel. The ones in the mlx5 vfio driver spring to mind as a scheme I
recently looked at.

Jason
