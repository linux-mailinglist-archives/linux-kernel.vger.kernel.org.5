Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3887DFB7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjKBUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBUZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818571A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698956664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcWEoS06f0kWkjZ1YzkPeHLmfqD6IXJBjSAaROXoiz0=;
        b=boLdwsQSQcVsgz1OTErqGIbqGrKDSE8eh+XTYBeN6pVHg7+3EXIq62VOHnTLgtjVNUrDKc
        qli0GYMy1yMIW6/2Ax44xxqgVY0Wdci5Ku5nH18wrem32tSts1cj4dhS2rj6bM5f2HS5dh
        N+RFw8d7/7g/emnvGGR8IlRAWnja5Zw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-u6aI_T6iNrOW-c8oU-xxaA-1; Thu, 02 Nov 2023 16:24:22 -0400
X-MC-Unique: u6aI_T6iNrOW-c8oU-xxaA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6cdb4938072so1598795a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956661; x=1699561461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcWEoS06f0kWkjZ1YzkPeHLmfqD6IXJBjSAaROXoiz0=;
        b=d4cv5OPmBlbT+wFdkvSJwXwFkrEAStrzBP4h0c5ThbmWItA/M6+m37U+7ko7aCRBcd
         7plBEILjEfT0dkPe87lQvAC+OVuTyTR8i9N7qn0Sg/xIY+D2bAB0/kyq5T/wbDdHYK5j
         oV2W1Lu30a98oAGfSzB/OgbZjxUGmDeDYU1XIM+AHm6g3UYVl2v1Kr6WJsfD9Z2d+Ml/
         kwHir+gzMebrjLgGGidhb922Xuq8SHLHFCarS3DXnz2lQuN2RgIc0fPwOiB5c3XGZ57V
         U01FRvh2fdWWFzXqwz4R1BAeu7IzoW42UMBySN7hz2UoMPQ2rWQPalR0La1V6qSEEjN5
         c0HA==
X-Gm-Message-State: AOJu0YyFiL1TQVuoOUa9c6Ay6mBrlPRLX4/8fuDSsG3nW0oglXLJipy3
        xs1O/wzQgCKapTM1eV9666Js4xfC4mNM4W6eSyzU7CJ6ZoAnXWJb8bMbdckpMYhIFiXNoaHr9cf
        2j49mjKZqWTR7WH2nQJL0uno8XMbe2BbjNMis/Utg
X-Received: by 2002:a05:6830:4409:b0:6d3:2346:8e0d with SMTP id q9-20020a056830440900b006d323468e0dmr4431830otv.3.1698956661324;
        Thu, 02 Nov 2023 13:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkxOlsUqu5jNE3Q3DjQ8oBDcolX6JJ9/NvKVWr9Alk9XXeokWPfn4hKWgIkHS15eaNXFdtRSE+aO3obb0JX+8=
X-Received: by 2002:a05:6830:4409:b0:6d3:2346:8e0d with SMTP id
 q9-20020a056830440900b006d323468e0dmr4431813otv.3.1698956661128; Thu, 02 Nov
 2023 13:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231102192134.53301-2-pstanner@redhat.com> <20231102201424.GL1957730@ZenIV>
In-Reply-To: <20231102201424.GL1957730@ZenIV>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 3 Nov 2023 06:24:09 +1000
Message-ID: <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:14=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> > The functions (v)memdup_user() are utilized to copy userspace arrays.
> > This is done without overflow checks.
> >
> > Use the new wrappers memdup_array_user() and vmemdup_array_user() to
> > copy the arrays more safely.
>
> > @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, s=
truct unipair __user *list)
> >       if (!ct)
> >               return 0;
>
> > -     unilist =3D vmemdup_user(list, array_size(sizeof(*unilist), ct));
> > +     unilist =3D vmemdup_array_user(list, ct, sizeof(*unilist));
> >       if (IS_ERR(unilist))
> >               return PTR_ERR(unilist);
>
> a 16bit value times sizeof(something).

So since it's already using array_size here, moving it to a new helper
for consistency just makes things clearer, and so you are fine with
the patch?

Otherwise I'd think you are been a snarky asshole to a coworker.

Dave.

