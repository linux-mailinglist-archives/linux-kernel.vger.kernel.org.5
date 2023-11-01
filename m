Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6B7DE070
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjKALlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKALlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:41:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81B11D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:41:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d2fedd836fso1721800a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698838862; x=1699443662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FHDdTo0xw0CeTOfybYuakNtKEAEzS/7tS2HLJVX5Rc=;
        b=Ghg/clUmecjSlvuJ+sUZbGvoh9MpOM9rYKDHO+eHqG31S4Lqj8/qbUJNNoN/CyZtrF
         mVgZzo+NbD1O/0jBdQpoZ8r5qnIGqC4iDWRyBzGc6GFS3F5sB2NUn0YmLOgAj01CZ8rD
         zVREY7oJMfStJV9Jxw2InHe49MlZ/e4uv3AhKDZkj5yKBvcMl6l6F4rAjph24pDq6wb5
         vCz3VXM5bhWtNNNxjwP0QeAGpsnT1HTFJzxAKJFy3aEZGe11IrVesMFp2luAH6vXtxOF
         25k8TC38noMBMSNPvC23OPW/pvPYu1IMdpY/N38pOl7GZ1rcEIGMSqlPALUllTOSnLad
         t/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838862; x=1699443662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FHDdTo0xw0CeTOfybYuakNtKEAEzS/7tS2HLJVX5Rc=;
        b=DJqTRo/hJWdfQ2q32Y33FGumu9K/n0p3twiZtcQpY7EZzLrO+eGhmnSuEPFndB5m86
         lyOpgkA1oBAW9zgB/gJmBuUibff3BZ7pmi4/Oj1LyuQvf8DTBn+uKZoiR85XoMFJ7W0v
         ygjxrdk4/d3AIfKzQ7CoR/mXBPbVrCN38kOWPrxLYTaxC7CviuM4x3jnAByCsSOsiaXf
         3TZEXwnsFLG3z4hxgEn8ojTDmaXO2Jn8Ii3T6s471fsHnY36AUKX8mr3r/O/B8hbbUEh
         Zv5p3HssoHDio6JHJ2mwTcw7GKz9VXCg5XzqVvURVYmnQiBjvU5opGDCO5RQ36CpBg5j
         fm3A==
X-Gm-Message-State: AOJu0YwBPnT3csj98W6loWZxuXT8L+NrN1IiNtnJ+63ZFBHG4VYotUVC
        svRl+6z2DcZmT34hAmv4oiP8XA==
X-Google-Smtp-Source: AGHT+IHqSQb4XYlupFI/7jvcRxPMQ1qS7FUqz7C/cqobb0l3gR2NbYXd6BI6//mH/WNE3AcDQJ1NFA==
X-Received: by 2002:a05:6830:2054:b0:6af:95f9:7adc with SMTP id f20-20020a056830205400b006af95f97adcmr16123618otp.14.1698838862545;
        Wed, 01 Nov 2023 04:41:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0041803dfb240sm1321271qtn.45.2023.11.01.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:41:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qy9an-0083p0-83;
        Wed, 01 Nov 2023 08:41:01 -0300
Date:   Wed, 1 Nov 2023 08:41:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yi Liu <yi.l.liu@intel.com>
Cc:     kevin.tian@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iommufd/selftest: Remove unused function
Message-ID: <20231101114101.GL691768@ziepe.ca>
References: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:23:23AM +0800, Jiapeng Chong wrote:
> The function are defined in the selftest.c file, but not called
> elsewhere, so delete the unused function.
> 
> drivers/iommu/iommufd/selftest.c:511:1: warning: unused function 'get_md_pagetable_nested'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7104
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 19 -------------------
>  1 file changed, 19 deletions(-)

I think this is a miss placed hunk it is used by a later series that
hasn't been merged yet.  Yi?

Jason
