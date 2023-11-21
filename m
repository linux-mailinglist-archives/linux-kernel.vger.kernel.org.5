Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59007F2207
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjKUAPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKUAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:14:58 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBF7BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5872b8323faso2851388eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700525694; x=1701130494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=UOGvAkMzHSUdsL6VXs/dSpIWDQFNn3S7Ovaghpcz3SKOanJvWPiwH/Ec1KleH4CsPU
         hnCnm+6LNvzNIRiMbR+NnVoDlAOVbV0Rzrapyqk5tnU2XscX3psiwhMaGvNYnnQ4ur1V
         25tNQ0e1L5h40ej1tX4yKBOnKDx+vogOKG/Xhb8dEXglLx/olfQTNHgxP3OiG/2LtlMr
         ToyHsFK73VB7v4nyQLysCoRSsT2Zw/Yzmnw8yzgHssby01ENKcJQ+ENx2cv+7ia2wi4w
         aU9d9lSKWmJcPV06R4/lUXO6HwFlUipPNNtJHSi3b1w+/0x25lnuIoQOXWFqX90v2cc9
         RGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525694; x=1701130494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=HGzGCogY7c+1tPCaJPwx3UqBTVM8ZCIOu6BR54UCfRM09adyJk0YK9Zn8A1D944MMm
         tzhjcSUNmvWumMN0ZywhYR3hzp8/a3jJ0/0uzL07lj//cKuU97PE42oGNX89nthjHtcG
         3XYBltoaWfXsPml+ddV3WPXIq/vr9jslRsi1GLOqfifWQdUNFdMTvEm4iNeYu9H8RfVs
         Y0OmdX82J8gXTTT+jStpPgZcpPpQdtuTFtYFJWa/5x7hvd0Tq2ayUjlet+hT9AUGr7b5
         eCrb5vJuUlwGTgIrpKwTeNYH9eIMzsqm/biLnsCQg4q8iHghEsa+aYPYwo+A0yy67TLA
         nxpw==
X-Gm-Message-State: AOJu0YwI2g7D5ctCIolo37jHStITZ5Gi/JG+pGQxaxkHaMC3sqCMh/G8
        5qGuVQaTUrLeZ49DzZK2BIkFsw==
X-Google-Smtp-Source: AGHT+IHCW/gnwvCFARN/IZLYIino35BqbfjASz8DDrzzSvjMWgTO3xenCZoSHE50H7LZjgQneLoOoA==
X-Received: by 2002:a05:6820:1628:b0:581:ed12:98c6 with SMTP id bb40-20020a056820162800b00581ed1298c6mr10069537oob.4.1700525694024;
        Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w9-20020a4aaf09000000b005840b5783a1sm1569061oon.43.2023.11.20.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:14:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r5EPk-0019u1-1E;
        Mon, 20 Nov 2023 20:14:52 -0400
Date:   Mon, 20 Nov 2023 20:14:52 -0400
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
Message-ID: <20231121001452.GF10140@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
 <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 09:42:23AM +0800, Liu, Jing2 wrote:
> Hi Jason,
> 
> On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
> > 
> > > This is the right way to approach it,
> > > 
> > >     I learned that there was discussion about using io_uring to get the
> > >     page fault without
> > > 
> > >     eventfd notification in [1], and I am new at io_uring and studying the
> > >     man page of
> > > 
> > >     liburing, but there're questions in my mind on how can QEMU get the
> > >     coming page fault
> > > 
> > >     with a good performance.
> > > 
> > >     Since both QEMU and Kernel don't know when comes faults, after QEMU
> > >     submits one
> > > 
> > >     read task to io_uring, we want kernel pending until fault comes. While
> > >     based on
> > > 
> > >     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
> > >     there's now no fault,
> > > 
> > >     thus this round of read completes to CQ but it's not what we want. So
> > >     I'm wondering
> > > 
> > >     how kernel pending on the read until fault comes. Does fops callback
> > >     need special work to
> > Implement a fops with poll support that triggers when a new event is
> > pushed and everything will be fine.
> 
> Does userspace need also setup a POLL flag to let io_uring go into poll, or
> io_uring always try to poll?

io_uring can trigger poll and use other approaches, it is flexible the
driver can scale this in different ways.

Jason
