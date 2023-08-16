Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674AA77D96B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbjHPE0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbjHPE0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EA2102
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692159947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ip39erQL05vM1EfoUzr0gxFHM5VqQHryueh/4GpGeoc=;
        b=S5Ve8nRei7fqlsTx4g+8pqjye5U10EiIXQh0bOKBAiSmVpO1UwId7qi9qhrCbYzH4+h0df
        Dpk5xOsm01HyXMSXRcDdSS1FYQIs0XW+d59k9eEhXd3DlVdVBbct4LhM3k3ES/AT2M1aMQ
        o6qcwmxYbCzs/q2/HqzD6oYlE8/MDcI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-xX0HvtxcPAK6w-mzM8i2yQ-1; Wed, 16 Aug 2023 00:25:45 -0400
X-MC-Unique: xX0HvtxcPAK6w-mzM8i2yQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6418ba8ed7cso63262296d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692159945; x=1692764745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip39erQL05vM1EfoUzr0gxFHM5VqQHryueh/4GpGeoc=;
        b=DFHcMzInUw/ul2cfzmRgzB7WfUE69AU0PdpqjKvWeZk/rXFJyUgTSMmgEetjufR1r/
         sGi3OhL0RmPjsgYLVWY5acnCLIgodGVP054IWaRqegQJFDME69ZQTCiQT7Y+GYAyH7GH
         vogwYrqrL3lYKT5+2oIdzFBPmkSoiUaBxVMkYtKsr9WOeiDRzO1YdpdzR7MoaoDDlsPJ
         0qDDn7+nRGlymnf8GDv6dQ0oEwa82R12dGAX8nPZJV1fDP0ck35nXLYOfxmSpI0ezjo9
         coJ27JsmZI0qdewIwWzSLY8EyO2g/fQWRo6J4BCXB4u03sRV7Db+bIhhSxEyd/lIfN23
         j0Eg==
X-Gm-Message-State: AOJu0Yy+GzKregfimrW/Fr+zxRIsmeNrMdvEx1qwyzgTwFG7t/sKPgpo
        M8D95jAhIDFfSt3M1MR09a+T4kWqav7pr8OqAeG/V0p3CURBKhNnjZZRwDFoDl8Qk0aY+VxbgGp
        JGL9cQRzYS0KOal3NfoLHiGgNE3hmxFtc
X-Received: by 2002:a05:620a:bc8:b0:76c:de57:7b61 with SMTP id s8-20020a05620a0bc800b0076cde577b61mr973677qki.25.1692159945124;
        Tue, 15 Aug 2023 21:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGr6aYlrh82DZ/hL7UsMEar2vLjwlrqUpt6dQpM33QY1109L6Qr9W32PzkRFKCPIldoiLtsQ==
X-Received: by 2002:a05:620a:bc8:b0:76c:de57:7b61 with SMTP id s8-20020a05620a0bc800b0076cde577b61mr973650qki.25.1692159944853;
        Tue, 15 Aug 2023 21:25:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id oq15-20020a05620a610f00b0076d4bb714afsm2579213qkn.50.2023.08.15.21.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 21:25:44 -0700 (PDT)
Date:   Tue, 15 Aug 2023 21:25:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        john.g.garry@oracle.com, joro@8bytes.org
Subject: Re: [PATCH 2/2] iommu/iova: Manage the depot list size
Message-ID: <2eq236vycub7mrxlxos2dnbzgqptkeclbprsh6rsml64eoapdx@xumsokaj6rfy>
References: <cover.1692033783.git.robin.murphy@arm.com>
 <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
 <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:11:51PM +0800, zhangzekun (A) wrote:
> 
> 
> 在 2023/8/15 1:53, Robin Murphy 写道:
> > Automatically scaling the depot up to suit the peak capacity of a
> > workload is all well and good, but it would be nice to have a way to
> > scale it back down again if the workload changes. To that end, add
> > automatic reclaim that will gradually free unused magazines if the
> > depot size remains above a reasonable threshold for long enough.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index d2de6fb0e9f4..76a7d694708e 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/smp.h>
> >   #include <linux/bitops.h>
> >   #include <linux/cpu.h>
> > +#include <linux/workqueue.h>
> >   /* The anchor node sits above the top of the usable address space */
> >   #define IOVA_ANCHOR	~0UL
> > @@ -626,6 +627,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >    */
> >   #define IOVA_MAG_SIZE 127
> > +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> > +
> >   struct iova_magazine {
> >   	/*
> >   	 * Only full magazines are inserted into the depot, so we can avoid
> > @@ -646,8 +649,11 @@ struct iova_cpu_rcache {
> >   struct iova_rcache {
> >   	spinlock_t lock;
> > +	unsigned int depot_size;
> >   	struct iova_magazine *depot;
> >   	struct iova_cpu_rcache __percpu *cpu_rcaches;
> > +	struct iova_domain *iovad;
> > +	struct delayed_work work;
> >   };
> >   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> > @@ -728,6 +734,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
> >   	rcache->depot = mag->next;
> >   	mag->size = IOVA_MAG_SIZE;
> > +	rcache->depot_size--;
> >   	return mag;
> >   }
> > @@ -735,6 +742,24 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
> >   {
> >   	mag->next = rcache->depot;
> >   	rcache->depot = mag;
> > +	rcache->depot_size++;
> > +}
> > +
> > +static void iova_depot_work_func(struct work_struct *work)
> > +{
> > +	struct iova_rcache *rcache = container_of(work, typeof(*rcache), work.work);
> > +	struct iova_magazine *mag = NULL;
> > +
> > +	spin_lock(&rcache->lock);
> > +	if (rcache->depot_size > num_online_cpus())
> > +		mag = iova_depot_pop(rcache);
> > +	spin_unlock(&rcache->lock);
> > +
> > +	if (mag) {
> > +		iova_magazine_free_pfns(mag, rcache->iovad);
> > +		iova_magazine_free(mag);
> > +		schedule_delayed_work(&rcache->work, msecs_to_jiffies(IOVA_DEPOT_DELAY));
> Hi, Robin,
> 
> I am a little confused why IOVA_DEPOT_DELAY need to be calculated twice in
> iova_depot_work_func(), as it already equals to "msecs_to_jiffies(100)".

I think it was a typo, and is meant to be IOVA_DEPOT_DELAY like it is in
__iova_rcache_insert.

Regards,
Jerry

> Besides, do we really need to invoke a delayed_work in
> iova_depot_work_func()? As each time we put a iova magazine to depot, a
> delayed_work will be invoked which is reponsible to free a iova magazine in
> depot if the depot size is greater than num_online_cpus().
> 
> Thanks,
> Zekun

