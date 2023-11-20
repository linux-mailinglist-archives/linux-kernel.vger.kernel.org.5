Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CCD7F21D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjKUAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKUAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:00:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4EAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0039ea30e0so143779066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700524799; x=1701129599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=Y5licVVAyPYKD/k20MMZkSMbBgiQ++7QRIuNqG+xiuB0SnUHTKl3SoFGXT9oOR1BFC
         6te8qwB6pW5OllpzSlBA9GOtTqW+jpPSILGsKwRrY8KLEvYpVbUVFoqRZkoGqV7rnhFC
         aZyf/bNkojtKE+Jy9BzgucSosPFunWOnts5Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700524799; x=1701129599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=Q+sdPSJSXhbcKsmqze33aG1SZputiWrZwHo3sSd5u9lct5JZ0nnycnIXT0RQtGcDHl
         EZvj1i3GN9r9gamsDNfAVVfVle6kpa1jlnixvFog1lJe15dFIYEdaa/mZWoVkhQEx/mM
         6vr/u3SOmpKJ7wJDy3TUFShuEfXQKfP5KDJcFJnjMmA5PFHkfldrejsPPd08DfdYIIzf
         qBcbX+0JBpJyE+Y4ACfbyEFj643tTPUxLVAHiIjbbDPuCwjhNf6HJ940KdTvV2qTTfVU
         Q01EbWD4TOFoc2OUyJ+msOoIAH3YzPoKJObbd5Me9TzEACaiyBS5vdBNsT/JL3NxKitj
         6QVg==
X-Gm-Message-State: AOJu0Ywt97zbA2D5u5WfKHm0s+KgDOaORMNIns/IUiH4ERYE1i1p+B5p
        C4V/N/vsslBexp/YjcT5HC+9dBXqofG2YfTfy4eVZw==
X-Google-Smtp-Source: AGHT+IGS/DMjLcVARh7/W+3Xwjr7CBqtoFkp2YHIj8I+RchJwxdGIbnk77jU2LOk1Rw8ir/jKvddnwjVTa6iwN+tqTI=
X-Received: by 2002:a17:906:5904:b0:9be:e90:5016 with SMTP id
 h4-20020a170906590400b009be0e905016mr6390836ejq.24.1700524799291; Mon, 20 Nov
 2023 15:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <ZU7RVKJIzm8ExGGH@dread.disaster.area> <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
 <ZVvCsPelezZesshx@dread.disaster.area>
In-Reply-To: <ZVvCsPelezZesshx@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 20 Nov 2023 15:59:48 -0800
Message-ID: <CAG9=OMMar0shTijQfehFSktir2vsvRkvH8t69gREzVyLKyPH4A@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
To:     Dave Chinner <david@fromorbit.com>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 12:33=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Mon, Nov 13, 2023 at 01:26:51PM -0800, Sarthak Kukreti wrote:
> > On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > > > Hi,
> > > >
> > > > This patch series is version 9 of the patch series to introduce
> > > > block-level provisioning mechanism (original [1]), which is useful =
for
> > > > provisioning space across thinly provisioned storage architectures =
(loop
> > > > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > > > series has minimal changes over v8[2], with a couple of patches dro=
pped
> > > > (suggested by Dave).
> > > >
> > > > This patch series is rebased from the linux-dm/dm-6.5-provision-sup=
port
> > > > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The fi=
nal
> > > > patch in the series is a blktest (suggested by Dave in 4) which was=
 used
> > > > to test out the provisioning flow for loop devices on sparse files =
on an
> > > > ext4 filesystem.
> > >
> > > What happened to the XFS patch I sent to support provisioning for
> > > fallocate() operations through XFS?
> > >
> > Apologies, I missed out on mentioning that the XFS patches work well
> > with loop devices.
> >
> > I might have misunderstood: were those patches only for sanity testing
> > or would you prefer that I send those out as a part of this series? I
> > can whip up a quick v10 if so!
>
> I was implying that if you are going to be adding support to random
> block devices for people to actually test out, then you should be
> adding support to filesystems and writing new -fstests- to ensure
> that loop devices are actually provisioning blocks at exactly the
> locations that correspond to the physical file extents the
> filesystem provisioned, too.
>

Fair enough, let me work on an additional fstests patch to validate that.

Best
Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
