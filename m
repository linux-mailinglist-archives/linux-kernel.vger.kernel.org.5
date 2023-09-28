Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F7A7B2240
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjI1QZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1QZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EDB1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695918300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndiSQPUClBTrz4CKUdDdf3vxdcFaBznOakZY24ftqF0=;
        b=FCMxENEGxglT6ftwEJ/kZ57h+dED+OFVDkGNb3T0K6wuZK89DLJZXq8E4RbZ4CUWoOwnRu
        zHHdY5oLJgvOjjB/fk9WW4VSgWnOHVVPMGiDQ97ZcxmalWgwWibuUKlAgJO741eyruJnSj
        hd9mJtnZT0C91J7RX/lD+ZumdmNCCFE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-84LkYUHhMXOfCVsJci29gA-1; Thu, 28 Sep 2023 12:24:57 -0400
X-MC-Unique: 84LkYUHhMXOfCVsJci29gA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41810d0d8c2so36997991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918296; x=1696523096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndiSQPUClBTrz4CKUdDdf3vxdcFaBznOakZY24ftqF0=;
        b=GrpsFG6Sc4/ftja7uQRPyIpw6qs/7UMgKtkIh9hh0VCZYRBFzyMIApMJLqOsImO3E5
         IgJ5OcLLC/cQ2y1kQmpMDoIS12ccZKelHbHDlle4vIri6c8PvNFXAv/vxfL8kZOHIkai
         qk7OBmDtrcre2zZ34LAWZycucMbiCpFLPUJYq/FfryNXgoZrAuA6wL76ziREPgOjhBLG
         tKCYw6/HOg18zXtDgb3ebi56CQ4LKugepfsoSOfvUw8RYgk8axwL2Z5f1zinDwsGtFUp
         /AXrZGThm+4sSU03QwYPXqiUu6b8GvQl2huNzQh9GtLlkdKvIinCmcSmAJQ+0LkqBk0C
         Jd2g==
X-Gm-Message-State: AOJu0YwkMxR0ezlocBNjzGF5umBd4g9Yp7KMoyACTOyt+q70326ZNz8O
        pT/wxZXVYyQ1ya8wtbO9DdjUw6/nHM53OecmjEJ8G5Lk6O6MVL1BLvgC0eDb8G1UVUWcUFF54Ko
        /EogIXnCP91nQ8v2Wc2mj13ql
X-Received: by 2002:a05:622a:1a27:b0:418:f2a:c223 with SMTP id f39-20020a05622a1a2700b004180f2ac223mr1920012qtb.1.1695918296714;
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2f1QIwKluc2EwyGnzKjSpJAlIkFFpuh6Qbcc40o5jjLqmHgZGD4ZV3pjpnz+FWlEbN4/rtA==
X-Received: by 2002:a05:622a:1a27:b0:418:f2a:c223 with SMTP id f39-20020a05622a1a2700b004180f2ac223mr1919998qtb.1.1695918296376;
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c25-20020ac86619000000b004195faf1e2csm1154119qtp.97.2023.09.28.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:24:56 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:24:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRWo1daWBnwNz0/O@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:29:35PM +0200, David Hildenbrand wrote:
> > > +       if (!pte_same(*src_pte, orig_src_pte) ||
> > > +           !pte_same(*dst_pte, orig_dst_pte) ||
> > > +           folio_test_large(src_folio) ||
> > > +           folio_estimated_sharers(src_folio) != 1) {
> 
> ^ here you should check PageAnonExclusive. Please get rid of any implicit
> explicit/implcit mapcount checks.

David, is PageAnon 100% accurate now in the current tree?

IOW, can it be possible that the page has total_mapcount==1 but missing
AnonExclusive bit in any possible way?

Thanks,

-- 
Peter Xu

