Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83ED808EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjLGRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:17:38 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711010F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:17:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-423e7e0a619so9336921cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701969463; x=1702574263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=nxMBn2YApW5VEL1MlNnGJIIFFeWsB1ZObn77HSaA1tECBRwhpmyLiqy+OaQKS4kkQi
         pNEUeAeKBL2cqAoU4e0QjqghnX+yT8cqh/wXggRvd+EnQBzXGGvb9wUopLfVYz8ITP2C
         iKOzSu7zD4lq/oJlR8w1YwmhUIN1s8MODf81OSnttn2MO9qmOYa8j5xgGFCVZaiTN1xU
         MWhLtcXCHMr5vqa8d5M5csX7ok7z19GKdFxr6FS8Rd480ftPynXrgDcrDz9wln6Vtahv
         7LkIuUQIxVZ9mWx2hL+p4/AK2Po6sO7zlLhMoe2s48WaOEL+m9a9Lljf/2dWRUu0HTDZ
         nsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969463; x=1702574263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=Dixjtrbf9LBG29f5D+5jGeYXThvZZwzWg8ZKhUiqRm852KblgF5nFVv9K97Vg73FuN
         TL/2sFqKfT3Vg0C4tdtreue71ur2QtgGFggk3+FWdun1Y8VxfqXevY7aZ3KGpesFwYmd
         ll+CpaPWjaiptNRMQSsHBygRFXVVwNoUEcivN3b9MzccazT2Kewz2jxzTzBPtNHXYtPI
         kvhhl47w4d5AYA3KbwVAxqVGVXsRdL4ivw7QJyP5MeiOoffNhlrp1asWJk+rCiIgA1T8
         eas72T0mQKloNnauL5NxIjfF/Yu4sX+h8xQ3DZo1vs6zddaXoFzTAuq7dAByeF/dqE06
         2SaQ==
X-Gm-Message-State: AOJu0Yz1OdAgVxD7uTAFa1r1Qo3BdnRdQtDgSSoOvizcSg3eAXDHbOWY
        +J7inJZW99xmSlUB/EJH/Prmng==
X-Google-Smtp-Source: AGHT+IFZla2NtPfquQTzU6hdOuHOkG1umIFAlj7i5uyx6faPcX4R7PtWVD+lIF+qCRz3hijffJ+Kvg==
X-Received: by 2002:ac8:4e83:0:b0:423:e097:3b14 with SMTP id 3-20020ac84e83000000b00423e0973b14mr6734973qtp.10.1701969463718;
        Thu, 07 Dec 2023 09:17:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cec42000000b0067a10672b80sm66393qvq.48.2023.12.07.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:17:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rBI0M-00C1FU-8T;
        Thu, 07 Dec 2023 13:17:42 -0400
Date:   Thu, 7 Dec 2023 13:17:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Granados <j.granados@samsung.com>
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
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231207171742.GU1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207163410.ap3w4faii6wkgwed@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> >  	WARN_ON(!list_empty(&fault->deliver));
> >  	WARN_ON(!list_empty(&fault->response));
> >  
> > +	fput(fault->fault_file);
> > +	put_unused_fd(fault->fault_fd);

> I have resolved this in a naive way by just not calling the
> put_unused_fd function.

That is correct.

put_unused_fd() should only be called on error paths prior to the
syscall return.

The design of a FD must follow this pattern

 syscall():
   fdno = get_unused_fd_flags(O_CLOEXEC);
   filep = [..]
 
   // syscall MUST succeed after this statement:
   fd_install(fdno, filep);
   return 0;

  err:
    put_unused_fd(fdno)
    return -ERRNO

Also the refcounting looks a little strange, the filep reference is
consumed by fd_install, so what is that fput pairing with in fault_free?

Jason
