Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD27BC3CA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjJGBai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjJGBag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:30:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DFAD6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 18:30:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adca291f99so470682566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642233; x=1697247033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF4QfWNaA43XRLFWp4IMKch1uhvVZ0qlp9xdhdkNJ44=;
        b=bKOFJ4YBkF2Q7KcWEZF2IkVd8iU2u0IxVP4otCn6OaJUzrW7//fsHo+cK65+d0w9SQ
         CHOFNHP0C6WNlY56fBySb348Mqw8ZHPWOw+SrR5a84p5zJNxl756EExueiukGQa7JQHB
         oEmhMrXAKyQVehh0jBMgCol7v+eEhWuQtR1tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642233; x=1697247033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF4QfWNaA43XRLFWp4IMKch1uhvVZ0qlp9xdhdkNJ44=;
        b=mi3AKioG87xFqowMqYNJl7jtfES4n3FqvurgzSd6jaZVy3ONR6HR1rm8NHmRI0pHbe
         KDzafUdqJXbCiCZit2cbmAHD3Amp3fAlre8nT2JD8KbU+8NhmPWgP+UDIWyNr0WOjPFp
         0DGlLw6JipRSWxuzBXV376D+ZpWRlf74mZ2twx8/LrC8b8Iejpwb/lmV3DTGfAI99PL7
         fPJXxafUBt0SSQ53mUyDCpK/9PskoVGgjvwDDavTac+2Db6nSlpsjnfOsriPPELmY7Hv
         Z6bBz8A1gH1DR7Fx9u26kBB5FqgiZPPNBD++TL8EfwvXpRvfz6IPab0Vln+jwSUoXnsM
         FXIQ==
X-Gm-Message-State: AOJu0YxyKL3HWghtNZZETAC0sfRJOmzNEwkLJnXkZQ3qyqu3249Bwh9j
        jFXKpqP3AvyAsPquZMd1Gmhf5p+QGCR3t0AJWOtl/Q==
X-Google-Smtp-Source: AGHT+IGkSJj0mtqaOVe5wcCfMcCmFe6Tgpzeqmz0eI2dsh3Q9Ib7QP0au+a6EA1F28rIWShFnSAVw+4uLntty8zEul4=
X-Received: by 2002:a17:907:2704:b0:9ae:961a:de81 with SMTP id
 w4-20020a170907270400b009ae961ade81mr7780096ejk.27.1696642233743; Fri, 06 Oct
 2023 18:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZHFEfngPyUOqlthr@dread.disaster.area> <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com> <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com> <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area> <ZHti/MLnX5xGw9b7@redhat.com>
 <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
 <ZIESXNF5anyvJEjm@redhat.com> <ZIOMLfMjugGf4C2T@redhat.com>
In-Reply-To: <ZIOMLfMjugGf4C2T@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 6 Oct 2023 18:30:22 -0700
Message-ID: <CAG9=OMPqGmX75ZmK=Fc7DNE7dcxS+t-UPkjtCVDF+dPN+xkrNg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 1:31=E2=80=AFPM Mike Snitzer <snitzer@redhat.com> wr=
ote:
>
> On Wed, Jun 07 2023 at  7:27P -0400,
> Mike Snitzer <snitzer@kernel.org> wrote:
>
> > On Mon, Jun 05 2023 at  5:14P -0400,
> > Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> >
> > > On Sat, Jun 3, 2023 at 8:57=E2=80=AFAM Mike Snitzer <snitzer@kernel.o=
rg> wrote:
> > > >
> > > > We all just need to focus on your proposal and Joe's dm-thin
> > > > reservation design...
> > > >
> > > > [Sarthak: FYI, this implies that it doesn't really make sense to ad=
d
> > > > dm-thinp support before Joe's design is implemented.  Otherwise we'=
ll
> > > > have 2 different responses to REQ_OP_PROVISION.  The one that is
> > > > captured in your patchset isn't adequate to properly handle ensurin=
g
> > > > upper layer (like XFS) can depend on the space being available acro=
ss
> > > > snapshot boundaries.]
> > > >
> > > Ack. Would it be premature for the rest of the series to go through
> > > (REQ_OP_PROVISION + support for loop and non-dm-thinp device-mapper
> > > targets)? I'd like to start using this as a reference to suggest
> > > additions to the virtio-spec for virtio-blk support and start looking
> > > at what an ext4 implementation would look like.
> >
> > Please drop the dm-thin.c and dm-snap.c changes.  dm-snap.c would need
> > more work to provide the type of guarantee XFS requires across
> > snapshot boundaries. I'm inclined to _not_ add dm-snap.c support
> > because it is best to just use dm-thin.
> >
> > And FYI even your dm-thin patch will be the starting point for the
> > dm-thin support (we'll keep attribution to you for all the code in a
> > separate patch).
> >
> > > Fair points, I certainly don't want to derail this conversation; I'd
> > > be happy to see this work merged sooner rather than later.
> >
> > Once those dm target changes are dropped I think the rest of the
> > series is fine to go upstream now.  Feel free to post a v8.
>
> FYI, I've made my latest code available in this
> 'dm-6.5-provision-support' branch (based on 'dm-6.5'):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.gi=
t/log/?h=3Ddm-6.5-provision-support
>
> It's what v8 should be plus the 2 dm-thin patches (that I don't think
> should go upstream yet, but are theoretically useful for Dave and
> Joe).
>
Cheers! Apologies for dropping the ball on this, I just sent out v8
with the dm-thin patches dropped.


- Sarthak

> The "dm thin: complete interface for REQ_OP_PROVISION support" commit
> establishes all the dm-thin interface I think is needed.  The FIXME in
> process_provision_bio() (and the patch header) cautions against upper
> layers like XFS using this dm-thinp support quite yet.
>
> Otherwise we'll have the issue where dm-thinp's REQ_OP_PROVISION
> support initially doesn't provide the guarantee that XFS needs across
> snapshots (which is: snapshots inherit all previous REQ_OP_PROVISION).
>
> Mike
>
