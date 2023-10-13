Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB107C81E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjJMJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJMJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E2BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697188961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y79P95BNudFuWy4ZhGlYbCRHyPElKrXCG8x3TZEUCz4=;
        b=JLC4OkFgyaURisTZG2bNAS5qyId0hkLNk6wL2BZSwB9iDhaJlR3b9UgDKpl9AwsrVpzZUk
        vOWBzx51xgPn1lFFQCxsXrqzmzyX+cbiLdT9DU8RvNO90ZdgetTHSo4SxjGU/dDkz7c4St
        UUI+DnIGBINdxKU4EzLi4VZ7Ukl2KvI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-AJe73-UHNGGHSQ8dDERs9A-1; Fri, 13 Oct 2023 05:22:40 -0400
X-MC-Unique: AJe73-UHNGGHSQ8dDERs9A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-775751c3437so236037285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188960; x=1697793760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y79P95BNudFuWy4ZhGlYbCRHyPElKrXCG8x3TZEUCz4=;
        b=mK4aKsWoUyvB97inr8CCYnbaAPpjEdErhrLgUxWt52C2+YR1jLGxXFN+MDSuH4Z5mU
         gjw9mwMsnFJ8e35B3DTUwGbtlrDbVmHyvRcdqsZ2REKf8OfbB2/RuUZMyB4L3mhvBfKi
         nNl0MkBxtimtvnTxdwzc+kD/q83eClQNDkFb6CaTqCcqRjwTsvbRgKQ6agQfUoVFhlHJ
         4ElOZAmL7r0QnAOdgfW7dSP/RvSKuzAFTjbfyFlAK2GWsw9u+bItFtmnckGuaQd7fBV/
         djyEVyyi2iIPp0xaciEr41nrRvc99Yy2uf+lbo8ubdWWHU0j32Glrqzu5ihsZvHGHgQh
         3Xsg==
X-Gm-Message-State: AOJu0YyFvdtTLVnL6D6aTi+9bazGT5UI01py8DvfTNhPVRyPzvgkSrb1
        TscqPJRr06eDK3WadC0Jz9a0HEnDcGcvjnZkfFupUzIx50hsUgXCS04PkNL7gH/LglcE8mNYTKe
        2u5cdFgE0IBLcXXurznLYEpwN
X-Received: by 2002:a05:620a:d85:b0:770:70d6:417c with SMTP id q5-20020a05620a0d8500b0077070d6417cmr30517231qkl.33.1697188960020;
        Fri, 13 Oct 2023 02:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7yQXWpfoJ05zTNZZ3hijxAkmU5shyP7Ol6Sd7hHjzaaIhP+h/JsELmfnvxIgO7AnjSGmhuw==
X-Received: by 2002:a05:620a:d85:b0:770:70d6:417c with SMTP id q5-20020a05620a0d8500b0077070d6417cmr30517223qkl.33.1697188959805;
        Fri, 13 Oct 2023 02:22:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it. [79.46.200.251])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a132900b0077434d0f06esm476063qkj.52.2023.10.13.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:22:39 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:22:32 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Message-ID: <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Si-Wei,

On Fri, Oct 13, 2023 at 01:23:40AM -0700, Si-Wei Liu wrote:
>RFC only. Not tested on vdpa-sim-blk with user virtual address.

I can test it, but what I should stress?

>Works fine with vdpa-sim-net which uses physical address to map.

Can you share your tests? so I'll try to do the same with blk.

>
>This patch is based on top of [1].
>
>[1] 
>https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/

The series does not apply well on master or vhost tree.
Where should I apply it?

If you have a tree with all of them applied, will be easy for me ;-)

Thanks,
Stefano

