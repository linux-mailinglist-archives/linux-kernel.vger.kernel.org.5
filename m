Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBD75B9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGTVjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGTVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:39:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D842718
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:39:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992acf67388so185486766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889149; x=1690493949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQU5ilzcOlx1ker9FtySpdRzva8lrA7ZPN1m8QAc4bs=;
        b=kApWVfk7mgCl3vz5Ks34PjDck0dcLfzryvNcDaqjJnMkjghZ5oWGDsCEc/ao3rre/Z
         Jdt2WbFSa0GjyRtPQsuWBQbrMofTViCueIJJ8NwHEf7hUAbR7knh77AhxDeySQRXM6Zt
         3synq3Y/BGvqXj0u6r/OHrp2S9+PmXOs5WvLuirsre55+YMvlLmO1ApDM0OvpuBC3UBK
         aGTNEBGtoKrWlX9jkCPpkZZr6dW9pCRMvfWfwicy15H4IZR4GvUKe6WvyLmwSQdCNaPl
         mReDkJfjQmxbt+aAbnqqTjL3LtUuLI9RIvjbTdrbKL2z4INQd1/hGTT0vjsjTJ9c8yxJ
         cvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889149; x=1690493949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQU5ilzcOlx1ker9FtySpdRzva8lrA7ZPN1m8QAc4bs=;
        b=fAtg4K52n7u4eMN8WPY9ipw1jYj8an+5E0aQuHWf4YVULzR8jn8ihtTh93kXzu/pce
         nGjAW/prE9nvZPd1Z++DG/8A2LXxeU9sgL/sqycV0juvhtrhFyCJpNRSqTZhuBJdSoko
         mRXyTIMOz4ITMIW4fM0OhEPrCneA9aY4u1EkbiyJnGrjzJVCfM9zUz+WmBryCVmDO7mc
         1eYayKoc2eFEremfteVa303HzKd5u8FqGgR9WPWzkZcxJebrnX77c/BdapoPNOMY987r
         YvvRQVb7zrYT5sBwgUUe/0vVUINpGSJga6pVnYfeUXEoZXgOGmSPJ8ljjND+JY2waGOq
         Ituw==
X-Gm-Message-State: ABy/qLaw7vE6lEzaK5c0AYSDEkXF0FugzUi5vwEDopXaevBKEjNVUbxm
        o39FfGxupvEP3GYX6D8RZEDjYOABZaNhSoFgRbeo+A==
X-Google-Smtp-Source: APBJJlHD7hrlkeh8bvoOtQtbsJUcPMsqPD5d1X8nOdFkRBVotzn7dstMixhkYI1uBNQo63PIZ1QUnDDiJGoXHWBicjE=
X-Received: by 2002:a17:907:b0a:b0:993:fa99:d7e2 with SMTP id
 h10-20020a1709070b0a00b00993fa99d7e2mr23601ejl.21.1689889148704; Thu, 20 Jul
 2023 14:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
 <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
 <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com> <CAB=+i9R+BnePZWJGm-5xi+2HEiM=_5EBZtFGmaHye+iZvVR2Vw@mail.gmail.com>
In-Reply-To: <CAB=+i9R+BnePZWJGm-5xi+2HEiM=_5EBZtFGmaHye+iZvVR2Vw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 14:38:32 -0700
Message-ID: <CAJD7tkaXKLgWhOnGPXhs513kEZERyD6eX7btuU7f5dXuhWY62g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>
> > > > It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
> > > > 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to the
> > > > current size of struct page. If that's true, then there is no loss,
> > >
> > > Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field is
> > > not used in zsmalloc.
> > > More fields in the current struct page might not be needed in the
> > > future, although it's hard to say at the moment.
> > > but it's not a loss.
> >
> > Is page->memcg_data something that we can drop? Aren't there code
> > paths that will check page->memcg_data even for kernel pages (e.g.
> > __folio_put() -> __folio_put_small() -> mem_cgroup_uncharge() ) ?
>
> zsmalloc pages are not accounted for via __GFP_ACCOUNT,

Yeah, but the code in the free path above will check page->memcg_data
nonetheless to check if it is charged. I think to drop memcg_data we
need to enlighten the code that some pages do not even have memcg_data
at all, no?

> and IIUC the current implementation of zswap memcg charging does not
> use memcg_data
> either - so I think it can be dropped.

My question is more about the generic mm code expecting to see
page->memcg_data in every page, even if it is not actually used
(zero).

>
> I think we don't want to increase memdesc to 16 bytes by adding memcg_data.
> It should be in use-case specific descriptors if it can be charged to memcg?
>
<snip>
