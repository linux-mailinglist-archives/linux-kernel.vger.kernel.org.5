Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391C79B4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbjIKVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbjIKQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048741BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694449024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAgyEv8v84Vh6tDzXDpI5U6AfJ7ln7UC0vFeWtEv4VA=;
        b=Nfrrl7TSV65QbkdpkuKPQUVb+iYCjpLCKeG3Zo0J6u9pMV6Nr75+vAJD9iaO0bCHxmJALU
        vmvO79p9bGFRb+Dg3EVsiHUG/4q+JjVgyjY5vtlDxg8tRy4AUoqGHdbv4YCX+AISSag25B
        9DoEW0PJJOh44YmLVon053oxiHEBYks=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-nN9xznatOACertSja_4nKw-1; Mon, 11 Sep 2023 12:17:02 -0400
X-MC-Unique: nN9xznatOACertSja_4nKw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5029253c6f9so4793816e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449021; x=1695053821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAgyEv8v84Vh6tDzXDpI5U6AfJ7ln7UC0vFeWtEv4VA=;
        b=GjeTx3hK7OiOlw05NBTfrHg7BB7yhWWFnUTsiyLtnZNUoUXP79euuRKH4s8NeV1RzE
         /Aik8Ai0JRGlcVGfohCHZYE4m81jyV/Q9lU6adMcpCCe+i6KjHHvAHWNU1ttGXhvoGY+
         Jgqp5a6o4Iyvt5+WxO0QeCqFJhoQuvFWM3qVOrAXuJ+IZKs63/FVPYzMLTwmpO4LXCpA
         f3ucjiKhbIEgBqOzL5yM8fuXVfQWPASxzNtdid0pHjxVQ+UnunIcDle7K+d5yiuQUmV0
         czT637mfgV3Ws9fleGpF5EGtbGDmrcBXUYgf0Oar0Yve4UZ6p/hyvaUNNQ211VFg9H2Z
         J/nA==
X-Gm-Message-State: AOJu0YwYtMtAPuzFOVwIzlF8ZLj31aA5TaSS8fh7FK67OPhEa6ltWv1k
        aAqqORzXkEXmhcYsow2udtyqa43rjVbTsCWp2E4A32IvyoCsMPOrk+VcfJoQm38lsU56ZPFhmGO
        D1j2Nvx01J58OsH95CYf4+3by
X-Received: by 2002:a05:6512:ad3:b0:4fb:745e:dd01 with SMTP id n19-20020a0565120ad300b004fb745edd01mr8799046lfu.45.1694449021284;
        Mon, 11 Sep 2023 09:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFT/b800+k5rxjo807GRz9nrW77AzB8A8eqobtwbZiaP3UyedgpDYvLTqnvwcN3x2j75AAdQ==
X-Received: by 2002:a05:6512:ad3:b0:4fb:745e:dd01 with SMTP id n19-20020a0565120ad300b004fb745edd01mr8799026lfu.45.1694449020980;
        Mon, 11 Sep 2023 09:17:00 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bm5-20020a0564020b0500b0052e7e1931e2sm4801801edb.57.2023.09.11.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:17:00 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:16:58 +0200
From:   Danilo Krummrich <dakr@redhat.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 4/7] drm/gpuvm: common dma-resv per
 struct drm_gpuvm
Message-ID: <ZP89eqnqPdvlDoZg@cassiopeiae>
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-5-dakr@redhat.com>
 <20230911140035.06159577@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911140035.06159577@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:00:35PM +0200, Boris Brezillon wrote:
> On Sat,  9 Sep 2023 17:31:11 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
> > @@ -240,9 +240,22 @@ struct drm_gpuvm {
> >  	 * @ops: &drm_gpuvm_ops providing the split/merge steps to drivers
> >  	 */
> >  	const struct drm_gpuvm_ops *ops;
> > +
> > +	/**
> > +	 * @d_obj: Dummy GEM object; used internally to pass the GPU VMs
> > +	 * dma-resv to &drm_exec.
> > +	 */
> > +	struct drm_gem_object d_obj;
> > +
> > +	/**
> > +	 * @resv: the &dma_resv for &drm_gem_objects mapped in this GPU VA
> > +	 * space
> > +	 */
> > +	struct dma_resv *resv;
> 
> Hm, I'd be tempted to drop this field and add a drm_gpuvm_resv() helper
> returning vm->d_obj.resv;

Makes sense, will do that for V4.

> 
> >  };
> 

