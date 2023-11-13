Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743FB7EA579
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKMV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:27:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89182D4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso7618951a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699910822; x=1700515622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=SWNKusEikZ1DnrYVHQ0hQIr0P5xQ6d7ccHuOGHJIjnhbSRJxEpYKgjbrhrwOYU93Tz
         UXeeIK82VcqmypH86NZdLRny5x+n3RkaXs9A0Q8zejFkSAWi3wON91+UFgN0drxH7dZS
         L1I8W1/dkxAmQBmo2KMtchZsfVIPIaVscjoQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910822; x=1700515622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=bMSkC1+7QhQn6kTyY8N+sXk4PDqJbELfIRb2W4a1Q4A5uZLiktc6RI0iPSLWwYHyBW
         aA/i/zOgHte80jvKLY5Hzo6dvNcSRXx8RaUWDD4s4uPDv8MPUj3WXLvKjOOA7mS5+Vn0
         Uml7pQ9L+E1WMeemGTGufn3UX0wLrPzP8/qY8MYCacB2ehEvn179dvgiRgJFVy55T+OQ
         TZce0bGumO2TA9gsHS15y7ntGUr+UWavCgeLzbouzIid1ekEfIZ39k3PMLIrdzkzJXu2
         H8GFHBaooUWAGGVzOJ0wYupQiT+ERbyjw7h++50fxY2JI9EpEYuDeTcFqQvDujQPq8nA
         MOmg==
X-Gm-Message-State: AOJu0YwBgxuMRrcpYtaB5G2ysh6LMGQ/EFcwZwBWgHl8emNj6RT2P1cr
        85T87PChY+di9aFYRoCSrM6fOnshuMjyvynvHY9uxQ==
X-Google-Smtp-Source: AGHT+IGoL4C64VRkqMMt2Ko2g8gaFMw8YCcpuwoNcjFqFlvPZKJTDjJL2Bgl7LbSUmzZ0cB+I9TezFzC6HBD0IZ7Sjs=
X-Received: by 2002:a17:906:dfca:b0:9e4:67d9:438 with SMTP id
 jt10-20020a170906dfca00b009e467d90438mr5397879ejc.56.1699910821965; Mon, 13
 Nov 2023 13:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org> <ZU7RVKJIzm8ExGGH@dread.disaster.area>
In-Reply-To: <ZU7RVKJIzm8ExGGH@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 13 Nov 2023 13:26:51 -0800
Message-ID: <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > Hi,
> >
> > This patch series is version 9 of the patch series to introduce
> > block-level provisioning mechanism (original [1]), which is useful for
> > provisioning space across thinly provisioned storage architectures (loo=
p
> > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > series has minimal changes over v8[2], with a couple of patches dropped
> > (suggested by Dave).
> >
> > This patch series is rebased from the linux-dm/dm-6.5-provision-support
> > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final
> > patch in the series is a blktest (suggested by Dave in 4) which was use=
d
> > to test out the provisioning flow for loop devices on sparse files on a=
n
> > ext4 filesystem.
>
> What happened to the XFS patch I sent to support provisioning for
> fallocate() operations through XFS?
>
Apologies, I missed out on mentioning that the XFS patches work well
with loop devices.

I might have misunderstood: were those patches only for sanity testing
or would you prefer that I send those out as a part of this series? I
can whip up a quick v10 if so!

Cheers

Sarthak


> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
