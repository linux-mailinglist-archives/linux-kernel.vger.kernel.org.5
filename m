Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7EC7EC38F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjKON0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjKON0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:26:09 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EE123;
        Wed, 15 Nov 2023 05:26:03 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586753b0ab0so3700378eaf.0;
        Wed, 15 Nov 2023 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700054763; x=1700659563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4lW5vykFz0T3X7jPgJSMsLKowLbiXE9f/JbX5taq3Y=;
        b=gQ1UlyOBHFy3D5i7VDemiMqIoEI7w1/fjMwSaCOEe0coY1l0G2jO5FWGcCL1NNVDR9
         tg+ITRvc9S48oIts8ICdUHpCRbq+aNRxUh8xoTbKlc7cO6d98vN3EB5lkBYHhBhyQT7+
         sNti8R4rSgO1MZcf1OQrjujaxOOgUeyhCt3zQRIZ7h76dR1QuGD99CFCf2ZPJ1bWsmZo
         TS3E+gKx3Pk3JfD523ddOGThKqaxmuJM71XYmcMvfs+xap1Iltjlg43bJNZ4U6kTna49
         JDA4a5XXsmAbHWfaPQT9zymXcCr7BQc49j3Mki6MERUzG44Ke3xrExdgTuRXd4e5SiZz
         C3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054763; x=1700659563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4lW5vykFz0T3X7jPgJSMsLKowLbiXE9f/JbX5taq3Y=;
        b=ph05CxfPkenJAqO/9l1dTtwWD96jdLI3IBJ+gZCEUPoBpJVort5kEp8nRL8H/536T/
         83lSBJpEORC3l3TbzHig2DSkHZJPCVJj9R6VxM7z4XRh1dOR/tN2pzKTDHQg+OZUTtIB
         nEDeNCQSGmDMbER/8UkSgxbDQy6V/Y0Qw9SFZIfqRsoRfvulZDQrx+YKLWeRpd0gI6MP
         mf8ghzVBkoo4XydUgCWfOQgJ8vNff3k9S2l9FBS3fxh8jhLqJLk4H99kKAyDfLe9pfW0
         nWGXhghxdgiLhNRlHXXuoixTfvX/PtuBN/kZWWp0qWQ4/0fPHR2kzTi2ksWReZG3aoGr
         5XnQ==
X-Gm-Message-State: AOJu0YzfkRPgoIBjeTHHMo/Y7QfuKjSMqRFhpN0pFqrwM/Ho97qTUsog
        lGLP959vdyIO+6K7FYixPAO6z94x8+WSX7HDoGhSo0xrD9c=
X-Google-Smtp-Source: AGHT+IGGbuD0XYn11878bhTbk2Yq16yMB0LLWfmIiUMAJscEZFCt9JBrtPZCKzTfCX66xw7H+3SGlyLc8gdZ1p7EzHE=
X-Received: by 2002:a4a:851d:0:b0:581:d922:e7f3 with SMTP id
 k29-20020a4a851d000000b00581d922e7f3mr12511898ooh.9.1700054763087; Wed, 15
 Nov 2023 05:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
 <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com> <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
 <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
In-Reply-To: <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 15 Nov 2023 14:25:51 +0100
Message-ID: <CAOi1vP-H9zHJEthzocxv7D7m6XX67sE2Dy1Aq=hP9GQRN+qj_g@mail.gmail.com>
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 2:17=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 11/15/23 20:32, Ilya Dryomov wrote:
> > On Wed, Nov 15, 2023 at 1:35=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wr=
ote:
> >>
> >> On 11/14/23 23:31, Wenchao Hao wrote:
> >>> This issue is reported by smatch, get_quota_realm() might return
> >>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
> >>> value.
> >>>
> >>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> >>> ---
> >>>    fs/ceph/quota.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> >>> index 9d36c3532de1..c4b2929c6a83 100644
> >>> --- a/fs/ceph/quota.c
> >>> +++ b/fs/ceph/quota.c
> >>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_clie=
nt *fsc, struct kstatfs *buf)
> >>>        realm =3D get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> >>>                                QUOTA_GET_MAX_BYTES, true);
> >>>        up_read(&mdsc->snap_rwsem);
> >>> -     if (!realm)
> >>> +     if (IS_ERR_OR_NULL(realm))
> >>>                return false;
> >>>
> >>>        spin_lock(&realm->inodes_with_caps_lock);
> >> Good catch.
> >>
> >> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> >>
> >> We should CC the stable mail list.
> > Hi Xiubo,
> >
> > What exactly is being fixed here?  get_quota_realm() is called with
> > retry=3Dtrue, which means that no errors can be returned -- EAGAIN, the
> > only error that get_quota_realm() can otherwise generate, would be
> > handled internally by retrying.
>
> Yeah, that's true.
>
> > Am I missing something that makes this qualify for stable?
>
> Actually it's just for the smatch check for now.
>
> IMO we shouldn't depend on the 'retry', just potentially for new changes
> in future could return a ERR_PTR and cause potential bugs.

At present, ceph_quota_is_same_realm() also depends on it -- note how
old_realm isn't checked for errors at all and new_realm is only checked
for EAGAIN there.

>
> If that's not worth to make it for stable, let's remove it.

Yes, let's remove it.  Please update the commit message as well, so
that it's clear that this is squashing a static checker warning and
doesn't actually fix any immediate bug.

Thanks,

                Ilya
