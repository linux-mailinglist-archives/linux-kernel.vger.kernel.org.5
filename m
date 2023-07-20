Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F275B9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGTV6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGTV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:57:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157AB3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:57:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so188306666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890271; x=1690495071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl7nA+XKNyX4Yi/zc25RqNc24yJ/Bu5kqoLxAvSKOnM=;
        b=k7FUqjnEFiSOQp+i6HnlTAtqd8i7KjoxW0qnaUvp3pqEOsDYpiKwv00fK7tWIAWq+V
         L0csr+6h25bw7M8HETXIGy57xadGMUTb+e6CM7je7HBnge+7UIs63cC/NX9JNu+6uJOs
         P6cH3lvuitbwqNzI3/AMCkdY9FWo4kAiwqQO9qA23dlpNqDR2mj75Ip0E/5g0EyHrFFD
         uudgugzFkworrkWgpHHed6DK9CZtPjS8L2YRWKq7tRAZdcMJyilsaCDXot4b7oXYYIa3
         MzWUo1Y4OTmFKr/5RT/MwahFc9xlBuxiPJnnDMGRTs7uAflo4VtfGTAM+woDrrHj+p/0
         BgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890271; x=1690495071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl7nA+XKNyX4Yi/zc25RqNc24yJ/Bu5kqoLxAvSKOnM=;
        b=f0qYJTnUCpNzgUPE5h8WVCoBYcygAWUdKFTsHgE4uOVftVIjQu0Iz5B6SPyWEEBLjq
         MHEgxkkrd3xfnmxqOItjO9zU+Wc3mdW+davRP74DJ1mexca9n5M7JczAmtVPU8d8J80F
         8ID7I2Qp0UAYOEVu2BYZ2Jb3CSd4sbxztnhcrhdb4RQ2BNcPChfY+66klmFdEv/e0c3O
         NIeDPO00X+V6Gss/SiQ+Mvosav7tja7/YghA0AeCuaaYucOi0IJA1ceg1fss2qPTTFkr
         9I2IJxs2EZmx4aHIyGFaDVyS4fYrh5YAvdA6t/8DVuYnQ6q+ukofxjHHELTkNsf8sbLM
         65uA==
X-Gm-Message-State: ABy/qLZG3OADLP0jxgO+GE+HnYWTwF9YjxNP5w2k1hNYy6Q7LHT90l6w
        jizS/1ag64HtMD2yLTTH4RE3KFiQ1yfzxzBx8CvL2w==
X-Google-Smtp-Source: APBJJlHXzUjLfQzs92T3qbk994d5sxZCnzhdaqzg6hOIFEuKrMB7os7XrcfkM2rrHCIE6VN/59C1ab1ttWzWOSvrh9s=
X-Received: by 2002:a17:906:8a43:b0:99b:4bab:2839 with SMTP id
 gx3-20020a1709068a4300b0099b4bab2839mr43317ejc.55.1689890271331; Thu, 20 Jul
 2023 14:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
 <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
 <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com>
 <CAB=+i9R+BnePZWJGm-5xi+2HEiM=_5EBZtFGmaHye+iZvVR2Vw@mail.gmail.com>
 <CAJD7tkaXKLgWhOnGPXhs513kEZERyD6eX7btuU7f5dXuhWY62g@mail.gmail.com> <CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com>
In-Reply-To: <CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 14:57:15 -0700
Message-ID: <CAJD7tkZ=GsH_Ru2L+VnWOg8j81x_zTaGcmDxFLnEOEbBHzkehA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 2:52=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 6:39=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > <snip>
> > >
> > > > > > It seems to me though the sizeof(zsdesc) is actually 56 bytes (=
on
> > > > > > 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to =
the
> > > > > > current size of struct page. If that's true, then there is no l=
oss,
> > > > >
> > > > > Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field=
 is
> > > > > not used in zsmalloc.
> > > > > More fields in the current struct page might not be needed in the
> > > > > future, although it's hard to say at the moment.
> > > > > but it's not a loss.
> > > >
> > > > Is page->memcg_data something that we can drop? Aren't there code
> > > > paths that will check page->memcg_data even for kernel pages (e.g.
> > > > __folio_put() -> __folio_put_small() -> mem_cgroup_uncharge() ) ?
> > >
> > > zsmalloc pages are not accounted for via __GFP_ACCOUNT,
> >
> > Yeah, but the code in the free path above will check page->memcg_data
> > nonetheless to check if it is charged.
>
> Right.
>
> > I think to drop memcg_data we need to enlighten the code that some page=
s
> > do not even have memcg_data at all
>
> I agree with you. It should be one of the milestones for all of this to w=
ork.
> It won't be complicated for the code to be aware of it, because there wil=
l be
> a freeing (and uncharging if need) routine per type of descriptors.

Right.

For this patch series, do we need to maintain memcg_data in zsdec to
avoid any subtle problems?
