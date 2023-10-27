Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A857DA0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjJ0Sro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346476AbjJ0SrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74510F3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698431029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1GFRFSXrJZnqwU7bWQb2Id5cyqADGdT0GyV9+GmOAk=;
        b=hmCpIiJmxOdLA6LPh8hkpLWRHEpLbQdEzACS93bAI/3TOOZCWiCJT+5fSU5W/SVcZyuubo
        6/kM5lzTdseJDpkuIs81yxKpiphyYy4X9vwRzVNT2hVDZbt5HNxdu2c6Ep5JmvvOgqTG53
        7OLWVTzXx2qD7l7s2aEg4tjrTHgg85Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Ig0bKLJ5MMCEtupVBmhczQ-1; Fri, 27 Oct 2023 14:23:47 -0400
X-MC-Unique: Ig0bKLJ5MMCEtupVBmhczQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b83bc7c7b4so1861968a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698431026; x=1699035826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1GFRFSXrJZnqwU7bWQb2Id5cyqADGdT0GyV9+GmOAk=;
        b=B1aL2VBLpgmd4CBwsyFZ84tb3zItWRLJ/gynC2T35YadaCcOOqzsAp1BitvlZJymEE
         HPctGxa5+9HCD1LaaSj6DRTQAUDF6IMnr2lsEC2jQQ+lhOJT4EJZTQaSg2Eg4xQlVyoM
         h2kuwnyAVL0uYNgVD9eRZBNPyJtQRPX/EJQc4LO7DhXXr4vwiKQRU+VVFhBnQE6XiA/r
         v56t0N9kqtguZEOVTp21zrOxDjskqy+Pr91k9Lt+eGgc67rdF2jjIfIGHsZDwvTONLRR
         BTKz7vOKm/6nMYxcmL+Iy0YvKN0mKtj9dXkwvIZrSbInC+0RYg/pVbqQS+T3+4YNMAHt
         lDoQ==
X-Gm-Message-State: AOJu0YxwdtihD/SVRUKvegYBw7e/wInDag3T105n5XDm34PVvJcjeZ8j
        i2Bn7pi1GR3XUJx9dDcGRw2VkZ3o6NrgxKHs8RQBLFFg+utTVclrw6xYTtrpcrunYSjBs9yD28r
        X11ZgCToxJy5qA8BNAb4jGVLkyLKkJJrL0jg1SqzU
X-Received: by 2002:a17:90b:3644:b0:280:1508:fbbb with SMTP id nh4-20020a17090b364400b002801508fbbbmr1868678pjb.23.1698431026277;
        Fri, 27 Oct 2023 11:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG50FlCwAd54tu9bXNQ2lOanyMl7ApDN5fYTheNDi/qcr0Q8FcDhYQnCfYRD6hGz6A5X4B1bh6MAyLWI8uU85M=
X-Received: by 2002:a17:90b:3644:b0:280:1508:fbbb with SMTP id
 nh4-20020a17090b364400b002801508fbbbmr1868659pjb.23.1698431026001; Fri, 27
 Oct 2023 11:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <2023102757-cornflake-pry-e788@gregkh>
In-Reply-To: <2023102757-cornflake-pry-e788@gregkh>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 20:23:34 +0200
Message-ID: <CAOssrKc6zpsTox58CMvWHAU7EhM1REEk6J9SbV5DaBzurpmr5Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 3:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> So because Android userspace is sending a flag value that is not in the
> upstream table, this breakage is ok?  Or do you mean something else, I'm
> getting confused.

From my POV the regression in the Android kernel was due to the
Android patch that added those flags.

Not all flags are equal, some applications use a specific set of flags
and another set of applications use another set.  Non-Android apps
won't use the flag that Android added, for obvious reasons.

I still don't see why we'd need to revert this patch due to
regressions in Android.  Maybe I'm really dumb, but I just don't get
it.

Thanks,
Miklos

