Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3654D7D993B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0NEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F9129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698411822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVcmnz+h9Wp1dg5zqY58Bu+omj+8UrC2mLNcXHDP45s=;
        b=F80x4RP2IJoxgTfNIn1otPO1zbiHDIL+oxT9XOyYQpfv8lPIzI6wIJ5QPt3BpzehDL83vp
        mVwSEpCXFL1maIlXD6R3C7KiVH0mndQFzEQo/tOV68n4i4SyAZUM9roxptQOoVi1zFsC/7
        EQJw84w5nCX12iFJLE2CYus4qCPH8HA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-rk3_kctUPeKKYdp9b_I3Wg-1; Fri, 27 Oct 2023 09:03:41 -0400
X-MC-Unique: rk3_kctUPeKKYdp9b_I3Wg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27ff2533572so1763389a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411820; x=1699016620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVcmnz+h9Wp1dg5zqY58Bu+omj+8UrC2mLNcXHDP45s=;
        b=iY5zCriTOuQKmSJl40W4sQEJlyG4rgQpKnFhLaXvOO/QbzTqE2NPAI6hvnmTrIWmrS
         g9BqBcWcNHskSgcVROvkETjoHj05VTUupSMqZO7ewZHWeSzDwKqdMVj6l/DEX0qCf0c/
         vWz2ZpPDQrrD4sqebJQxsewhpZPLQ+86efLdbqqd3N/bOv4eUXLZ3cg/LN+OFrePavwa
         aenmr2wP9UexhQeHC6OaPqfaiSTKJPX3mkLJ40nmCoe9FYPAymYDSxqBNEB0nygvbInS
         oU/QNrCZgZI+g0KgqawyZK+7VZqMIkrtyVMHkbkUJpb7CCrqoKPj5pCmmDmixBLxm3f0
         UKnA==
X-Gm-Message-State: AOJu0YwP7XndznbADvxz2n9e37E3hr0dK6VJGRW3Pmwm2cSoIvC7Axj2
        zw5A3frHDlFQZjFM2Abb6XyBfvWkRavZl5uJZeByiPFKitixSdoRK56Q3QzYjO3aSdxOD5fR4eL
        cQEvch5Q2OdBtQhB7iy+7Q+9FVs+iQKTpwyMAEvjt
X-Received: by 2002:a17:90b:3b48:b0:27d:568b:a741 with SMTP id ot8-20020a17090b3b4800b0027d568ba741mr2460399pjb.41.1698411820023;
        Fri, 27 Oct 2023 06:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZjQ1tdxUfloUFbfwOvHU6IcOUHddzRBirnv137cBPl3kSEYtV61sCAMQL4pJ/UaVKSzg+XbSOSdLftoLB2iA=
X-Received: by 2002:a17:90b:3b48:b0:27d:568b:a741 with SMTP id
 ot8-20020a17090b3b4800b0027d568ba741mr2460374pjb.41.1698411819787; Fri, 27
 Oct 2023 06:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh>
In-Reply-To: <2023102740-think-hatless-ab87@gregkh>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 15:03:28 +0200
Message-ID: <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 2:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> I'm talking about a patch where you are changing the existing
> user/kernel api by filtering out values that you previously accepted.
> And it was done in a patch saying "this might break userspace", and
> guess what, it did!
>
> So why not revert it as obviously you all anticipated that this might
> happen?

Because it's a useful patch, and while I mentioned the possibility of
a regression, I definitely didn't expect it to happen.

And I still think that the Android case doesn't count, because it's
just a completely different environment.  What can happen on Android
may not happen on non-Android and vice versa.  Why should I revert a
useful patch, because it causes a regression in a downstream kernel,
because of an Android only patch?

> The "internal" patch from Android was just using the upper values of the
> fuse api because they didn't want to conflict with the upstream values
> before their code was accepted (and it was submitted already, but not
> accepted.)
>
> So how do you want developers to work on changes before they are
> accepted with this user/kernel numbering scheme that you have?  You just
> broke anyone who was using a not-accepted-in-the-tree value, right?

Again, upstream and downstream.  There's a reason why some companies
have upstream first policies: because it's less painful in the long
run.  Android having decided to go ahead and add that patch is not my
problem, and I really really don't want to care.

Having said all that, if there's a regression that someone reports for
upstream flags (even on a vendor kernel), I'll just revert the patch
right away.

Thanks,
Miklos

