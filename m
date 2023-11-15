Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C87ED77F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbjKOWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjKOWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:44:23 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235871A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:44:17 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586b512ba0aso94438eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700088256; x=1700693056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXrgWyvWAa7mpo5Hy0ExAVZUfBAE64Xn9mUeqoQEoh4=;
        b=G6P1KuxC/8vgxmJjt8e61ALhjOaPcnCCjXRG9YaWtG+H3OpebOg+XM3J4W2yizHvBr
         xv6Xdhv/6xvOj1ogEg7wIFTV1Ybgr+alR2aerFP3ZGDaDUVYuxHSDho/24o9U/z8SMia
         bkAoWu1N3RDiWjxDniySLR5aF3PLf4FSNVzlCNfPcI74ReIcNvg+kzI3A9XTi0TwiPiq
         uoBvOJSiKDTvyAP/o/w3Y+j46ZWot6U/NHksKKXK86UYneIgIjyCex+uojROOGEdALGm
         iohnvUur2kCTPfcAFSDGoZns29kA9xKmhHJI0vOL1Nk6YGZk4dJ4DbsgQaIj2YbkvSFs
         AGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088256; x=1700693056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXrgWyvWAa7mpo5Hy0ExAVZUfBAE64Xn9mUeqoQEoh4=;
        b=F4oCT4jmQbeNckIFiA6/wHcvyKv8RdJGV1IUehXTdDy2u/bekkzMI6c14EZrAdsYUN
         xMQMLJE5d8XL6rhLYfCotLsQX1CvHNdRp0M2TBeQvBk6j/h0bFp2+gMew7/Fec8oGDy9
         KjrCnBYlzxFJ0gydq1YPb43hanqaTnIcbp/jJ3NuKh/yjWPI2tQdbJn0pV0u/oxY768W
         D5YA/WDVHZaqcj6gkSngUsGYxfi0UNx6PgVKTd9VHAW+VblPd5EHs72iOb6RRWm/tY9I
         QPMewVuy9wiscUiv8U8lYbN38VvOVdD03ydsd5rE6Kca0RuXIWgMMHhP5OXKmsLP5P4x
         y6qw==
X-Gm-Message-State: AOJu0YzpOSO9BuztDv7IMwRGj2AJBbxWq7QjhdiEyLyxwHdIru8B2jU3
        AjfiFwcVyoV9sT3i8dhmgIer9DwE3DLR42S6CP3+uTvvacZn5iPBvT9+vd47
X-Google-Smtp-Source: AGHT+IGrycqa+3tW5XHyxAo6jk4d3g94Kstx3L4T6j5UriD6ILVj1s4cuFgwmiT04zhqz0EokZUAdXeiJ2vS6qbrCkw=
X-Received: by 2002:a05:6358:88f:b0:168:e55a:853e with SMTP id
 m15-20020a056358088f00b00168e55a853emr6625450rwj.4.1700088256000; Wed, 15 Nov
 2023 14:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Wed, 15 Nov 2023 14:44:04 -0800
Message-ID: <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:55=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.dk> w=
rote:
> >
> > Do you mean something like this? If not, can you please elaborate
> > "when we need"?
> > -               struct nvme_effects_log *cel =3D xa_load(&ctrl->cels, n=
s->head->ids.csi);
> > +               struct nvme_effects_log *cel =3D (ns->head->ids.csi =3D=
=3D NVME_CSI_NVM) ?
> > +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->=
ids.csi);
> > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > already defined CSI?
>
> I suggest either re-assign the cached head->effects to one from a still
> live controller when current path is removed, or move the saved effects
> to the subsystem instead of the controller. All controllers in the
> subsystem should be reporting the same effects log anyway, so
Is it specified in spec that all controllers in the subsystem
should be reporting the same effects log?
> duplicating all that per-controller is kind of wasteful.
