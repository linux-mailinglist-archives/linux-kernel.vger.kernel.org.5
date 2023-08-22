Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84832783B54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjHVIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHVIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:00:07 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3DCC8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:00:04 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64a70194fbeso24204396d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692691203; x=1693296003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asUWMK1gCt6jligLNxv9OySXwdWZpULBiw8f9aYh8OM=;
        b=K4IEXN15NCW64V9NNsVqPK2d0r9swsPvPTmXHdIp9T5yLutX8kkBwQosrY47bRDjqp
         n1WG+lNwunxPeCXMMdjDLQW//+PauMumZ4N/x2t9GNvRJY1gw8sO+PxXtGtyRfd/8vnY
         0kK4CFrzPthHQhTvwO8f/aYUc4CYjqbVpcT8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691203; x=1693296003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asUWMK1gCt6jligLNxv9OySXwdWZpULBiw8f9aYh8OM=;
        b=Dqi9p9mN7hdQvLW+1n7gPxLbF9EjmUrtiCq51qBdMBCxfT38z1pg35FQ7EO5+hBD4f
         8H2P+Ust36gk4RopkNNL7MhUEqyY3C9ZLxq1OpPWTzn/UARrLUApxamG+AUKRVIHVPkz
         JCOFEmPK4H5rI7J4ujT3zt8ROZc8gPJtIAjaR17vR+RY8Z7AKuIcVf4DxITUAGKgJdiH
         8yL36h0wRQzQiI/rYDkwuzSNjE1Ayc++zbR/+fS1gALTZ/B+uowxdQeSg4GC8pPortuE
         FpOnVAuL5D+I2quDg9zD1ao+iDMxu+N/EVa27ebmRu8X8TMWzO9Y6QY/HseO9ABnJON0
         pP9g==
X-Gm-Message-State: AOJu0YztkAtgGC/dhzCvH585riWK8Rgr+AumHb0EHZLZ7VLj40jHVz2A
        /HTSHGnS8Wlx1VN1ctONPMZp9+a+YeoFICCAcV0=
X-Google-Smtp-Source: AGHT+IGfALjvgALc0mRTd503d01G4aNx4EOoP+1v6ppuA2ZmSxq/0m2PFFlD+urC5SR0D7ImLwHMfw==
X-Received: by 2002:a0c:b3c7:0:b0:64c:e47f:30fc with SMTP id b7-20020a0cb3c7000000b0064ce47f30fcmr9492753qvf.3.1692691203398;
        Tue, 22 Aug 2023 01:00:03 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id j16-20020a0ce010000000b0064f4749e1a9sm978297qvk.92.2023.08.22.01.00.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:00:02 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-64a8826dde2so24100546d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:00:02 -0700 (PDT)
X-Received: by 2002:a0c:dc81:0:b0:641:8bf9:e0ec with SMTP id
 n1-20020a0cdc81000000b006418bf9e0ecmr9694353qvk.0.1692691202093; Tue, 22 Aug
 2023 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230704040044.681850-1-randy.li@synaptics.com> <c79a2a0d-9510-b514-3b94-bc1d68e3d53b@xs4all.nl>
In-Reply-To: <c79a2a0d-9510-b514-3b94-bc1d68e3d53b@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 22 Aug 2023 16:59:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CS3ZdUikoPgiHAJTfGScWY7Nbqd2Kc=gnTm2P=JTKkbQ@mail.gmail.com>
Message-ID: <CAAFQd5CS3ZdUikoPgiHAJTfGScWY7Nbqd2Kc=gnTm2P=JTKkbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve V4L2 M2M job scheduler
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        linux-kernel@vger.kernel.org, nicolas@ndufresne.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:45=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
>
> On 04/07/2023 06:00, Hsia-Jun Li wrote:
> > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> >
> > The first patch is an old patch, I resend it again.
> > I want to make the work thats parses the bitstream
> > to extract the sequence information or video resolution
> > as a part of V4L2 schedule. Such a work would also
> > consume the device's resources likes remote CPU
> > time.
> >
> > Although reuse a flag which no current driver may
> > not be a good idea. I could add a new flag for that
> > if people like that.
> >
> > The second is a patch offering a generic solution
> > for tracking buffers which have been pushed to
> > hardware(or firmware). It didn't record which buffer
> > that hardware(firmware) still holds for future
> > decoding(likes the reference buffer), while it
> > has been sent to the user(dequeue). We may need
> > a flag for this work.
>
> I am dropping this series from patchwork: clearly this generated
> a lot of discussion, and I think that needs to come to a conclusion.
>
> BTW, I believe that at minimum the codec-specific parts in
> v4l2-mem2mem.c should be split off in their own source (v4l2-m2m-codec.c?=
).

I like the idea. This way we could possibly evolve the framework more
towards the codec helpers, reusing as much code as possible, but also
keeping the basic implementation simple.

>
> I agree with Tomasz that mem2mem.c was originally for simple m2m devices,
> and adding all sorts of codec specific code to that source doesn't make
> it easier to follow.
>
> Regards,
>
>         Hans
>
> >
> > Hsia-Jun(Randy) Li (1):
> >   media: v4l2-mem2mem: add a list for buf used by hw
> >
> > Randy Li (1):
> >   media: v4l2-mem2mem: allow device run without buf
> >
> >  drivers/media/v4l2-core/v4l2-mem2mem.c | 30 +++++++++++++++++---------
> >  include/media/v4l2-mem2mem.h           | 10 ++++++++-
> >  2 files changed, 29 insertions(+), 11 deletions(-)
> >
>
