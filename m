Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B90794333
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjIFSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbjIFSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:36:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFA26A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:35:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7eaffe2f99so119012276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694025281; x=1694630081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJltTaOgL5jEO4WF+/Vz9Gw2r17/bIVfgXIk3gpklQ0=;
        b=ZBkElbtxY8+7TLIrlgLpWVdSV0K+mkpw6JYmfN41F7Wn3XAvD7IQoOx0RxFQ9erVNR
         3ReSgxlDWPfPbH14qJ+zNpVtJgm7a7lpQ73zeKvFs567ceYu+cdSOjrTwx4lycdzEMky
         ufE0kTwnCdtn8jLEohVW+ULhALXbTAD+PAkuhiec5/ScwsUp7AiBJVDG6mEOQ7sLVvw4
         aNAa1b8XdFyRu87ho7hFb2nVVdKjB8NVrQNZdZkUBTL+aFOiC4bQOlcTJyIocH60pqyD
         jNBtF0Rxt2DYWoCMfKZc4ayXjmJz/cF2nBvxXgAdUAbdyyfpl7Jh/ngPtV9CaqDpt6gi
         XLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025281; x=1694630081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJltTaOgL5jEO4WF+/Vz9Gw2r17/bIVfgXIk3gpklQ0=;
        b=ea3uvMFJC/RhDaesnMspPNcZWHchN6KRGb/87I8JSFLOyTQTAU9/zqQPzbvsaOpBXh
         5Skn0gLoFcrH338ypzFk44YmaRwjP7ewA4tnQ6ERg+Wks2ao3iMohBtPk7hw7PduZLcl
         6vmtrc0OWf7mbHTdRMb/+4F+zgpKnfR9G/1EEN7UDFhpAyPdA1BjmS6hkN79t2LqSeQH
         yqf8a09h5Zx8+qFbHYZdCscjkr7nKOQpmFUonSFzhgm0bAF3jBTPzPoGyo+lQlLhl2pR
         Y0U16wqC+6mwYhuRO/AwHJhIjLAW75s5N8R4PnU8VQ3H3C9Mr5jl1UbBse3bYszuWQbY
         j/fQ==
X-Gm-Message-State: AOJu0Yxw5xdUA55h/NGMLXsDrQx4vXw8AFtUz6jLdoQqjlNfwuZE92va
        gAvR87Tm7ameT1N2i977Ag3ThVI=
X-Google-Smtp-Source: AGHT+IFhuu2m/WV5JV2cBMSFsDFG5jxjHWU+oNXD57WJzhNfO2v6ypwJ2+8P7l5k9Yg1Ux0KHyvAtdw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:e0c7:0:b0:d63:8364:328 with SMTP id
 x190-20020a25e0c7000000b00d6383640328mr424401ybg.5.1694025280934; Wed, 06 Sep
 2023 11:34:40 -0700 (PDT)
Date:   Wed, 6 Sep 2023 11:34:38 -0700
In-Reply-To: <c7f9db8879a9342080e74b9270e9925132b02f59.camel@gmail.com>
Mime-Version: 1.0
References: <000000000000d97f3c060479c4f8@google.com> <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
 <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
 <20230906075730.6d61420a@kernel.org> <c7f9db8879a9342080e74b9270e9925132b02f59.camel@gmail.com>
Message-ID: <ZPjGPjbxazLkRkEW@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_offload_verifier_prep
From:   Stanislav Fomichev <sdf@google.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06, Eduard Zingerman wrote:
> On Wed, 2023-09-06 at 07:57 -0700, Jakub Kicinski wrote:
> > On Wed, 06 Sep 2023 16:50:23 +0300 Eduard Zingerman wrote:
> > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > index 3e4f2ec1af06..302e38bffffa 100644
> > > --- a/kernel/bpf/offload.c
> > > +++ b/kernel/bpf/offload.c
> > > @@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
> > >         offload->netdev = netdev;
> > >  
> > >         ondev = bpf_offload_find_netdev(offload->netdev);
> > > +       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
> > > +               err = -EINVAL;
> > > +               goto err_free;
> > > +       }
> > >         if (!ondev) {
> > > -               if (bpf_prog_is_offloaded(prog->aux)) {
> > > -                       err = -EINVAL;
> > > -                       goto err_free;
> > > -               }
> > > -
> > >                 /* When only binding to the device, explicitly
> > >                  * create an entry in the hashtable.
> > >                  */
> > 
> > LGTM, FWIW.
> 
> Thanks, I'll wrap it up as a proper patch with a test.

LGTM as well, thanks!
