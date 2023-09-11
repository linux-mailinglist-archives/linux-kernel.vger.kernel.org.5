Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9193E79BDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378603AbjIKWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjIKQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A70CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694449816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnHJHN5Cfj592B1txIAsnJFDj1FO7IjqCo2I3g3K4yE=;
        b=iMYs9f0tBk8L0mtfEs92zj/d4zkNoWucwae951Wq2DyWQkwMX0o6kGOZlv7Jw7bRTI6IqC
        raeK2PQvYVDIz7IqRYXfRO4saoRxAW630llyZvAkLklYs31nYFFOl3wN+Yas9ZnY/8aHGQ
        5ZhD+UOJ3gr1UILSGolWiAMVvfLRHQc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-lOfPn6UbMj2ixN7pudwOeg-1; Mon, 11 Sep 2023 12:30:14 -0400
X-MC-Unique: lOfPn6UbMj2ixN7pudwOeg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a9e12a3093so649813666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449813; x=1695054613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnHJHN5Cfj592B1txIAsnJFDj1FO7IjqCo2I3g3K4yE=;
        b=ICfssURDcQ1WddATj2M+KKE0La03pRnSehWlz0+w2reXBCzNG1U4lHkeyGuRQrOnO9
         bAbOyLBbv+pJpfBf0BPEatvjhAXO8XXsb9tCJf7OEXD1tbqGwr/HlZ7v0qX365rj+gJ0
         A9gN13PC+wV/PS0fx0v1qFRo/MihFTOBPcIVwtksRVeEz/8XfeRA9JMpApaa+DaJechT
         wC6mXAMbLWUdJ5bjkueOrsuqNBaojZMUpWKLMzTGSLwzoXd2DYUAPat67o5NlqMNY+19
         0U8i2sYheGSrMN/zx0qaSTezREE7MKpdddiuy+4CVvOYlPTOWfOnjrlJ82ZzSoHeILBC
         Lptw==
X-Gm-Message-State: AOJu0YzAThM2AXXQnNeM4eK6yy1gy/qlAZ2sgoGaoWgJQp4HEY9Oz35j
        x88WU8h42itbeECJi3jUM4Dp8auhruit4IbJzgjzdRhYrhEdl/ZzW9yS2G3aG9G1O9dR7HUcjrB
        VvmHKINUjoE36WeDsd9qhhFRb
X-Received: by 2002:a17:907:8a1c:b0:982:a022:a540 with SMTP id sc28-20020a1709078a1c00b00982a022a540mr206927ejc.11.1694449813781;
        Mon, 11 Sep 2023 09:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNhPmNNStTZs5PE2OQ6KZzdKOTE5Av9U7Sptz++UFQy/HCfVuMVhM7hDiKm6FA6tPHtenKgA==
X-Received: by 2002:a17:907:8a1c:b0:982:a022:a540 with SMTP id sc28-20020a1709078a1c00b00982a022a540mr206903ejc.11.1694449813470;
        Mon, 11 Sep 2023 09:30:13 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5590017ejc.28.2023.09.11.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:30:12 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:30:10 +0200
From:   Danilo Krummrich <dakr@redhat.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 6/7] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
Message-ID: <ZP9AkkJ1FruZGSVV@cassiopeiae>
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-7-dakr@redhat.com>
 <20230911164526.0192a686@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911164526.0192a686@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:45:26PM +0200, Boris Brezillon wrote:
> On Sat,  9 Sep 2023 17:31:13 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
> > @@ -807,6 +1262,14 @@ drm_gpuvm_bo_destroy(struct kref *kref)
> >  
> >  	drm_gem_gpuva_assert_lock_held(vm_bo->obj);
> >  
> > +	spin_lock(&gpuvm->extobj.lock);
> > +	list_del(&vm_bo->list.entry.extobj);
> > +	spin_unlock(&gpuvm->extobj.lock);
> > +
> > +	spin_lock(&gpuvm->evict.lock);
> > +	list_del(&vm_bo->list.entry.evict);
> > +	spin_unlock(&gpuvm->evict.lock);
> > +
> >  	list_del(&vm_bo->list.entry.gem);
> >  
> >  	drm_gem_object_put(obj);
> 
> I ran into a UAF situation when the drm_gpuvm_bo object is the last
> owner of obj, because the lock that's supposed to be held when calling
> this function (drm_gem_gpuva_assert_lock_held() call above), belongs to
> obj (either obj->resv, or a driver specific lock that's attached to the
> driver-specific GEM object). I worked around it by taking a ref to obj
> before calling lock()+drm_gpuvm_bo_put()+unlock(), and releasing it
> after I'm node with the lock, but that just feels wrong.
> 
As mentioned in a previous reply, I think we want to bring the dedicated GEM
gpuva list lock back instead of abusing the dma-resv lock. This way we can
handle locking internally and don't run into such issues.

There is also no reason for a driver to already hold the GEM gpuva list lock
when when calling drm_gpuvm_bo_put(). Drivers would only acquire the lock to
iterate the GEMs list of drm_gpuvm_bos or the drm_gpuvm_bos list of drm_gpuvas.
And dropping the drm_gpuvm_bo from within such a loop is forbidden anyways.

