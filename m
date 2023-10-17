Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9A7CBBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjJQGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:51:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD32B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:51:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-419b53acc11so162611cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697525489; x=1698130289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHCjcIwAgD8r2ZfWSRWE2jRRIUmP7obRVpW9zzIvXZY=;
        b=LFjN/upgI4MMKEjVksgSFfYLl4hiuJAmzv7UAJJhTpD8bMjNFxX83y8A39/wySXMU0
         j2Fm/iw6EHqdpjS4czvzmVThq/PLULAPmRr8b6FZW1b6bXkQE4u0F6SUsgvCvd24GVhX
         uJ30oL9MoRY+ztlf3iJrv+tPhM+2g/5AHvI+Jhl5+u78pqEFU8FDunRbvFItETWQ/Si2
         fufeBOfkDb51pLYE4URsib0FTYhYw7NXU+59TQovysbuLx4ceoDKoIGowtlSNXFNjcyg
         mSRoeI21PDxx25DGeZ46DdEEoA/PGKmqgEN3zN02LQui/ri+yn4qkL0E+0f73VU0BLnP
         yuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697525489; x=1698130289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHCjcIwAgD8r2ZfWSRWE2jRRIUmP7obRVpW9zzIvXZY=;
        b=l2/PYuI5G2Z93/9UalByJQcDdlboG3XECDwVKL+2vYTAgkmp1eB/3eu0h7FA3SoJ8w
         Dme+vaKq8r4pvuncljqHjgS4hUPvj+WwsM7ShGnW2pit6A2BV4xXl4Kro+eUwhJQv8vR
         OJAjLrGe9Q+124IYWLFa3m0mgcL/0C9UOcDlIpuhimzDATb59OBJ/R8AAX9yCNbjz1ky
         JE7oRt8d7c0AK7n8RL9uVrzT8oZ44iShjb4S4C3fKEK2CXjnf7pyK7UiGa0FqkMiwPpX
         JaKg7OEiSiGe+gz5ej16X8q6Q8jlJSvbPeoGYKIsbfiM0hPD9Cn8T1IVr9SsaO+vITA2
         AbFw==
X-Gm-Message-State: AOJu0YyLj5RrTjNOu66fuQOAw5WVUsT2ElMvjsOANhjHYTcWgYQf4dpT
        ebf4nN6jzrmhMWRHoI5DYFTI9eWgI+yh+AxM4fyiqElectRlsAJybu/9OQ==
X-Google-Smtp-Source: AGHT+IHrmXZFq+mqMHdy8UJpV06hwPvok6+26xdf07c69sqojlknFnXbe8Z30UoZafYhf/PHhODqV8N5XpLKhiJclqs=
X-Received: by 2002:a05:622a:8119:b0:417:cd34:2a7b with SMTP id
 jx25-20020a05622a811900b00417cd342a7bmr111897qtb.3.1697525489453; Mon, 16 Oct
 2023 23:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <20231016143828.647848-2-jeffxu@chromium.org>
 <2023101614-scarce-discount-d7ff@gregkh>
In-Reply-To: <2023101614-scarce-discount-d7ff@gregkh>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 16 Oct 2023 23:50:00 -0700
Message-ID: <CALmYWFsVzHiysp1c2PuqfdE1ENDkK1xegoZedtCOaHzmxx2OSg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/8] Add mseal syscall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 16, 2023 at 02:38:20PM +0000, jeffxu@chromium.org wrote:
> > +#ifdef CONFIG_MSEAL
> > +     /*
> > +      * bit masks for seal.
> > +      * need this since vm_flags is full.
> > +      */
> > +     unsigned long vm_seals;         /* seal flags, see mm.h. */
>
> "unsigned long" and yet:
>
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index c0cb22cd607d..f574c7dbee76 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -802,6 +802,8 @@ asmlinkage long sys_process_mrelease(int pidfd, uns=
igned int flags);
> >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned lon=
g size,
> >                       unsigned long prot, unsigned long pgoff,
> >                       unsigned long flags);
> > +asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned in=
t types,
> > +                       unsigned int flags);
>
> "unsigned int"?
>
> Why the mis-match?
>
Thanks. Fixed in V2.

> > --- a/include/uapi/linux/mman.h
> > +++ b/include/uapi/linux/mman.h
> > @@ -55,4 +55,10 @@ struct cachestat {
> >       __u64 nr_recently_evicted;
> >  };
> >
> > +#define MM_SEAL_MSEAL                0x1
> > +#define MM_SEAL_MPROTECT     0x2
> > +#define MM_SEAL_MUNMAP               0x4
> > +#define MM_SEAL_MMAP         0x8
> > +#define MM_SEAL_MREMAP               0x10
>
> I think we can use the BIT() macro in uapi .h files now, it is _BITUL().
> Might want to use it here too to make it obvious what is happening.
>
Sure. Will update in V2.

> thanks,
>
> greg k-h
