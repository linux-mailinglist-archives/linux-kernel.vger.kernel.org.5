Return-Path: <linux-kernel+bounces-18064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A398382582A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578B71F221C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B731A61;
	Fri,  5 Jan 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWKeU+9v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13B3173E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704472241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZRYev09Q9Q6d9PQHNA+O3Tjdc3b7n9JilQT9ObeK4Q=;
	b=dWKeU+9vXOLZ3MvMd4OwtJTmherfvVpJ1o+jZfuftzVvgunebHhc7OCIjbVY1IQH0sJCLu
	0H0bR4/G7UZArznMvTrZ07O5uOQdHzKw4D9fAgp+WXy/WXaIeDZHNxVeL0Nr8Jqr/6l0Rs
	KAwhBegeApebk9rdw82OjBDEjdYauMg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Alm99DQ1MQS0QwjjOvXBNg-1; Fri, 05 Jan 2024 11:30:39 -0500
X-MC-Unique: Alm99DQ1MQS0QwjjOvXBNg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bbaec23e66so158540239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704472238; x=1705077038;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZRYev09Q9Q6d9PQHNA+O3Tjdc3b7n9JilQT9ObeK4Q=;
        b=BgQHDgjzAcI1douX1lAou0BikoDsuldFWf0x1lms5nLlSc7fh0U/wCrH2i9n6GdZCJ
         n54JvU9w8WWl3FKZYH7pO2zCqwFnGipVG8rJfmOLY9wzMAiiECgw+j1c2GQwvU3ABYwS
         a/ERHtaGsGLeP3fJ/1Uhk88ZrMTAQLGKOvuTHIB/u5LMiStE4nCFzi0tuE1sx5OVLJh0
         OOixenxzijK+/IoBjUVA5RBzWV3YK39/Dl4v5vEec5WYVGBqNAc8qDRLXrxUtALjSAU9
         nvj1Wr6ihuf7ER5RDoUJg9VaE/c3Q2V6KRIaaTPvgpXOppxXKA8nDq0GK5PPu3vwDXRw
         eLoA==
X-Gm-Message-State: AOJu0YwjfkM8Bf96e/8mECsU4dqegiUx02l6873yACsEyFP6K/uGxjwk
	Zqq8rWleo9ntS4carjpM27YYeJRwWss9gRow+2z1zI6niDl/BTTmZjRo+Atd9bZ48iiuoRb0zLs
	Teom6RXDAmLeuy8frOrGAmZ4RuJY0O4i0
X-Received: by 2002:a5d:8341:0:b0:7ba:77f3:b7e2 with SMTP id q1-20020a5d8341000000b007ba77f3b7e2mr2539935ior.42.1704472238647;
        Fri, 05 Jan 2024 08:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMpGLWG2gX0Lk0rBvmpfAgzGpXntP7Dx3Aq4mH68sA0m5Is0FmZ/4ELY/VuuZqdTcP+WU1DQ==
X-Received: by 2002:a5d:8341:0:b0:7ba:77f3:b7e2 with SMTP id q1-20020a5d8341000000b007ba77f3b7e2mr2539931ior.42.1704472238427;
        Fri, 05 Jan 2024 08:30:38 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id s15-20020a02ad0f000000b0046df0c7e8f4sm494942jan.87.2024.01.05.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:30:37 -0800 (PST)
Date: Fri, 5 Jan 2024 09:30:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, Linuxarm
 <linuxarm@huawei.com>, liulongfang <liulongfang@huawei.com>
Subject: Re: [PATCH] hisi_acc_vfio_pci: Update migration data pointer
 correctly on saving/resume
Message-ID: <20240105093035.229f8d29.alex.williamson@redhat.com>
In-Reply-To: <12f92affadf34f048a2eb2e7e9ecd879@huawei.com>
References: <20231120091406.780-1-shameerali.kolothum.thodi@huawei.com>
	<20231120142928.GC6083@nvidia.com>
	<12f92affadf34f048a2eb2e7e9ecd879@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 15:56:09 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Alex,
> 
> Just a gentle ping on this. 

Thanks for the ping, it seems to have slipped under my radar.  Applied
to vfio next branch for v6.8.  Thanks,

Alex

> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, November 20, 2023 2:29 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > alex.williamson@redhat.com; yishaih@nvidia.com; kevin.tian@intel.com;
> > Linuxarm <linuxarm@huawei.com>; liulongfang <liulongfang@huawei.com>
> > Subject: Re: [PATCH] hisi_acc_vfio_pci: Update migration data pointer correctly
> > on saving/resume
> > 
> > On Mon, Nov 20, 2023 at 09:14:06AM +0000, Shameer Kolothum wrote:  
> > > When the optional PRE_COPY support was added to speed up the device
> > > compatibility check, it failed to update the saving/resuming data
> > > pointers based on the fd offset. This results in migration data
> > > corruption and when the device gets started on the destination the
> > > following error is reported in some cases,
> > >
> > > [  478.907684] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> > > [  478.913691] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000310200000010 [
> > > 478.919603] arm-smmu-v3 arm-smmu-v3.2.auto:  0x000002088000007f [
> > > 478.925515] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000000000000000 [
> > > 478.931425] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000000000000000 [
> > > 478.947552] hisi_zip 0000:31:00.0: qm_axi_rresp [error status=0x1]
> > > found [  478.955930] hisi_zip 0000:31:00.0: qm_db_timeout [error
> > > status=0x400] found [  478.955944] hisi_zip 0000:31:00.0: qm sq
> > > doorbell timeout in function 2
> > >
> > > Fixes: d9a871e4a143 ("hisi_acc_vfio_pci: Introduce support for
> > > PRE_COPY state transitions")
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)  
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Jason  
> 


