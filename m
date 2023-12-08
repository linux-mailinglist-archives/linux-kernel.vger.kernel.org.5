Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADC80A49A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjLHNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjLHNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:41:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6291986
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:41:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4258423e133so12145061cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042900; x=1702647700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=UQO4D9ufl/sEF35xxGRzYtk162hQ7fl1RaoDfoS/+9vl4xs3B3qXZlr9UGkNUlpU04
         VUqAwEonYfNfHnaDG/DSNPDCkcoPx2WOXMxQISI8l7WbtrG56pnofxLFtrRfVmZbH3bC
         qq+uB6QQkS2xHkPXxhm1T9Nh/NVcOSbVuq0DcK4eb4eCTOYkJ4i2UBp3g+c3TOmTZOBI
         kvkR+RRa6idVSYIo0Cp9PjJLNuR1hAj4nxTPR0rEzNS7Yf7vsNgNrhvt0Q8rG8hPrCRe
         FwKQZJ7Iho98qBcQPJ9ZkquW5dlXifvvFXtHnH07MmqXCI+2udmaTZm2pM4wiSOKeCs/
         Y/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042900; x=1702647700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=HWoOtqfMI1IvJoHjDln7kk0bWx8cmLeRNYnh7JdQbdC+qoJ+lekevDVAFiZzfvpGHS
         ePSJD/d7u9wouhOcV0LyRTRxa2/5IJmAwxwzx8aeM7YD3bmCnDN8ZBHJBjw6fiDrV5eo
         lMO2mpSsUb0jgiyVG86wmX1hpCdzHTBAfy8d4WlvVwzU6MYQ8UljnErswFTnOMA5vCZt
         f/oXKEJBEzvuuQ0PUKzESb7Ae5iiZTh/G3LDQE9n5lX2Jyo9s+uLlEPTJWtyfPePVkHS
         SuoY/c4DaRPTCFHvbBG57IseKwbCphKcrdPVdvkLKthkvEwEGkmryWsgLDOryg8eFQvf
         ZDTw==
X-Gm-Message-State: AOJu0YyOqJv8wXRvFq9BXH0IdjzbcA6JXJ8S7uuZtjRQ3m/Ci1opQUBb
        eql4IgWPmiMOV6gdQ5sd5f3VOA==
X-Google-Smtp-Source: AGHT+IHjZ5fbgyGNj4pXddo/yd/fsGP0DpJlldXMV869RcUAC8mCOG4RaDWeA5g67kLmuW+2zDsrMw==
X-Received: by 2002:a05:622a:1708:b0:425:4043:1d77 with SMTP id h8-20020a05622a170800b0042540431d77mr105008qtk.74.1702042900661;
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cd5-20020a05622a418500b004255fd32eeasm543901qtb.7.2023.12.08.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rBb6p-00C88X-Fn;
        Fri, 08 Dec 2023 09:41:39 -0400
Date:   Fri, 8 Dec 2023 09:41:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joel Granados <j.granados@samsung.com>,
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
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231208134139.GW1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
 <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 01:47:35PM +0800, Baolu Lu wrote:
> On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> > On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > > > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> > > >   	WARN_ON(!list_empty(&fault->deliver));
> > > >   	WARN_ON(!list_empty(&fault->response));
> > > > +	fput(fault->fault_file);
> > > > +	put_unused_fd(fault->fault_fd);
> > > I have resolved this in a naive way by just not calling the
> > > put_unused_fd function.
> > That is correct.
> > 
> > put_unused_fd() should only be called on error paths prior to the
> > syscall return.
> > 
> > The design of a FD must follow this pattern
> > 
> >   syscall():
> >     fdno = get_unused_fd_flags(O_CLOEXEC);
> >     filep = [..]
> >     // syscall MUST succeed after this statement:
> >     fd_install(fdno, filep);
> >     return 0;
> > 
> >    err:
> >      put_unused_fd(fdno)
> >      return -ERRNO
> 
> Yes. Agreed.
> 
> > 
> > Also the refcounting looks a little strange, the filep reference is
> > consumed by fd_install, so what is that fput pairing with in fault_free?
> 
> fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
> increase any reference.

fd_install() transfers the reference to the fd table and that
reference is put back by the close() system call.

Notice that instantly after fd_install() a concurrent user can free
the filep.

Jason
