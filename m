Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CD7C8EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMVKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7264BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697231394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdAOO2yFE2cJwQjxlMCkUqIXwqY1KJtN1wzUd1l3G64=;
        b=fR3rxFNdqQB88WDemz8NddC8USWA8flmP7m1VIa3dkiyjjybjOXESGXRQjb1zB+LL5C7Yn
        vVj6u+MCi4p5FcC4SKGFHIv3aIcjGG+YE+k6s6PI9dfBxUPuROoceSWw51v4YHiQ5kOEew
        DUcwpCIpL8EQawUzgBL1r7rfsje8POk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-_G_w1Ht9M7yyUHNlRBRUqw-1; Fri, 13 Oct 2023 17:09:42 -0400
X-MC-Unique: _G_w1Ht9M7yyUHNlRBRUqw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3514cebdbd5so15410685ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231381; x=1697836181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdAOO2yFE2cJwQjxlMCkUqIXwqY1KJtN1wzUd1l3G64=;
        b=FUMIRcQpKQg4ysesv+aFKU5oq+OVDiAxb+cUG9hoqLF6nhtwZ6fq46QvZqdCOTHZgS
         a8eqb81yR8WyTcW1fgrf2Li6zU97XKoSAqfDL/BrnBtlV7BHy1rjH3M3w6xE82xG+rMo
         eWRsJxyrs2mP4TPrVtmFgytPVdNpf3mZNJ6BRA7drWpUvdkhSOHCIFxcKBVBrqlNTKEz
         9JVqeViMx+Slkxbsj4IapVywu0VK6PlMAJggLhACllnyGI5h2mlVatFJbLTm93m9h3/h
         TnWPl5Ya46h+PQ0pG1fPH598aGCNOJrrObfICo09gimuABxPcN5IVxFrh05WHec2Pn0u
         cHrA==
X-Gm-Message-State: AOJu0YyCi1HbQf311QtFLmXoocJUnyoTGJQ/a5RuIeKsWq7LoW+cbcbH
        +WEP28VJWbp2wBmVPOZlJ6Yt/A8ibsZIbZ0H05mFJ9bPoT+eVn/3cN9cRce5dX6OXEPfV+7WLVn
        8uxMjmVRfoYXlgsSiN6Zz07y2zh07PGIC
X-Received: by 2002:a05:6e02:1ca6:b0:34c:bc10:2573 with SMTP id x6-20020a056e021ca600b0034cbc102573mr34215544ill.3.1697231381572;
        Fri, 13 Oct 2023 14:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Tpiwqx7qpgdqVqQyELH26TBmji8DoBVKjQ2UGq8YoxDUwwru20TSAqCp0/uAeckBK0pzWA==
X-Received: by 2002:a05:6e02:1ca6:b0:34c:bc10:2573 with SMTP id x6-20020a056e021ca600b0034cbc102573mr34215536ill.3.1697231381324;
        Fri, 13 Oct 2023 14:09:41 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t4-20020a02cca4000000b0042b3e2e5ca1sm4914515jap.122.2023.10.13.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:09:40 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:09:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <dan.carpenter@linaro.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 vfio 0/3] pds/vfio: Fixes for locking bugs
Message-ID: <20231013150940.50804350.alex.williamson@redhat.com>
In-Reply-To: <20231011230115.35719-1-brett.creeley@amd.com>
References: <20231011230115.35719-1-brett.creeley@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 16:01:12 -0700
Brett Creeley <brett.creeley@amd.com> wrote:

> This series contains fixes for locking bugs in the recently introduced
> pds-vfio-pci driver. There was an initial bug reported by Dan Carpenter
> at:
> 
> https://lore.kernel.org/kvm/1f9bc27b-3de9-4891-9687-ba2820c1b390@moroto.mountain/
> 
> However, more locking bugs were found when looking into the previously
> mentioned issue. So, all fixes are included in this series.
> 
> v2:
> https://lore.kernel.org/kvm/20230914191540.54946-1-brett.creeley@amd.com/
> - Trim the OOPs in the patch commit messages
> - Rework patch 3/3 to only unlock the spinlock once

I thought we determined the spinlock, and thus the atomic context, was
an arbitrary choice.  I would have figured we simply convert it to a
mutex.  Why didn't we take that route?  Thanks,

Alex

> - Destroy the state_mutex in the driver specific vfio_device_ops.release
>   callback
> 
> Brett Creeley (3):
>   pds/vfio: Fix spinlock bad magic BUG
>   pds/vfio: Fix mutex lock->magic != lock warning
>   pds/vfio: Fix possible sleep while in atomic context
> 
>  drivers/vfio/pci/pds/vfio_dev.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 

