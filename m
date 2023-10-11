Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839467C5B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjJKS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJKS1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:27:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B7B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:27:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b98a699f45so16060666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1697048866; x=1697653666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfuTTDR+nJ6o/M0eow0TQoImOGAmMP0qEOP+RWPlF7Y=;
        b=jsXPe6t32aXYqLf16ejPQffnyIQK+RRE24WPNmawlpZtdmpeGPbzpKF+UpGQGNv8gj
         ExM725dg2iExTK56lZUkjLkg+p83sL/u75VgT0Ne5Mbl4RWNxWZjVnt2EsPXkyYGx6NK
         K/cvq8KZCQlS7Ldw1R984Q5zJhAEkGBume2yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048866; x=1697653666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfuTTDR+nJ6o/M0eow0TQoImOGAmMP0qEOP+RWPlF7Y=;
        b=NEBxIS0wAcJTGfWU0iff94OFLv3ujJcubTEsHHu/Bugr2FkRwuAMMQS5Vdo9NBtwu0
         kuzNJk1QI/QpBTXaMlrUewcnCZeJJFQuCqpd0goh1AdWeKoNtSJfmsxvi4D8T1hHqqAm
         ZMgSUN1lc6KZa4hv+pJqqBTAPZ/xNBrVol3HWkMR/qaqF/NWq6wNMAJeVlYzMbvxwiqj
         QsEHE7k81obn9yDqg8zP/vC724QjvUyKhq+GqMYVMcw2v5EljG77BiTRu+OyWeUagj72
         UmfD/A8sxBIu12YrCdXmsHW02n4aXHl4xmisaqY8Uh7XToPIZDmT+p/9z+NTrkuV3szN
         5Z+Q==
X-Gm-Message-State: AOJu0YyT+wkvUUyMuCxF/aw8RY9J5h3NmozU4IvJreE3Lw92Bv8lzx8I
        F9HYQ/QqMjfmjUkoe6JcbXJSapIa8XwQTebO/Y5Cyn9YkmU+O5PP
X-Google-Smtp-Source: AGHT+IEJB43UBIJkWXU/+yP7anQC/n2l6c6US9J/b6MClEUeWkTP8XSWSjTPJvy9IenYfNOmz1l4zjbgc9TJFxEEOO8=
X-Received: by 2002:a17:906:8a50:b0:99c:e38d:e484 with SMTP id
 gx16-20020a1709068a5000b0099ce38de484mr19331684ejc.6.1697048865820; Wed, 11
 Oct 2023 11:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com> <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com> <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
 <20231011163220.GA1970@templeofstupid.com>
In-Reply-To: <20231011163220.GA1970@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Oct 2023 20:27:34 +0200
Message-ID: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 18:32, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> On Wed, Oct 11, 2023 at 09:07:33AM +0200, Miklos Szeredi wrote:
> > On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:
> >
> > > I am curious what you have in mind in order to move this towards a
> > > proper fix?  I shied away from the approach of stealing a nlookup from
> > > mp_fi beacuse it wasn't clear that I could always count on the nlookup
> > > in the parent staying positive.  E.g. I was afraid I was either going to
> > > not have enough nlookups to move to submounts, or trigger a forget from
> > > an exiting container that leads to an EBADF from the initial mount
> > > namespace.
> >
> > One idea is to transfer the nlookup to a separately refcounted object
> > that is referenced from mp_fi as well as all the submounts.
>
> That seems possible.  Would the idea be to move all tracking of nlookup
> to a separate refcounted object for the particular nodeid, or just do
> this for the first lookup of a submount?

Just for submounts.  And yes, it should work if the count from the
first lookup is transferred to this object (fuse_iget()) and
subsequent counts (fuse_dentry_revalidate()) go to the mountpoint
inode as usual.  This will result in more than one FORGET in most
cases, but that's okay.

> Would you like me to put together a v3 that heads this direction?

That would be great, thanks.

Miklos
