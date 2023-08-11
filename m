Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CA778A42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjHKJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHKJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C652272D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691747022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVBQVlLlx3UI5+a+PNiyio4m0DC96vSRbURfcW+Z9No=;
        b=WhpWQxW4TpE4hVagOKFKF1xtFfD/fQlCiWq+8JRMju+FvIqg02FL8IamNWa7CXRglc1VDE
        6NQ2NsM3nBw2a6r5mMRR01J5UptY+EpF8r5USzcEnRopo+VQSRnQPUExuhTVO/0iNPTSza
        3L9H3tzITJD5Rh/WZhQhXMJ/HAO5XTE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-YR7TEhMuMGqGOq6cyfZLvg-1; Fri, 11 Aug 2023 05:43:38 -0400
X-MC-Unique: YR7TEhMuMGqGOq6cyfZLvg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so19556861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747017; x=1692351817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVBQVlLlx3UI5+a+PNiyio4m0DC96vSRbURfcW+Z9No=;
        b=gQiJIZFovfLiJzRBQK03N0na+lBIlPUnZECswP9rDQ+mX9mU6mnyy+Rm2jtF0SdGMZ
         H60ZHZ02rk7dSUTquTVzcrktyG8W9t9NQXuiy7gosDVE+6SpVlfvDKtlmQuGkJgNcIun
         r7rxFKUFRDDWmMAsFe+QDQAPfqQYEP6zaVqnkMgFJ2v9XKgJEiKxzyc9RCmTezihxOlA
         fam+5AmuooQitO2z9GdRu7kqbaQif0YOlk/0/yrK0UdzuNm699XXhRQ9HcSt1B8uOgN1
         uS1xUGts+1bBqBglvB0pfC+gYCH3zdzgutGRZQyMp8G+jqjLNjkYFd4Mr7kpBYkRkUJi
         M8IQ==
X-Gm-Message-State: AOJu0YzTFntEyk6PYlffoFzT2RsDNnJF1W+vjz2ayuCBZH2PWq372Rrt
        u+AapzPc5TqzOEI2fxsfAB8DMVt+5TIKjclclBmwbOPW3N+aR0sSlIIOXR9JMFCOFpsrYKegZLV
        6/2+i4e7SxW2Kgrv3AGRMr00e+g0x0poXmoIAPmeb
X-Received: by 2002:a2e:7401:0:b0:2b6:d137:b61c with SMTP id p1-20020a2e7401000000b002b6d137b61cmr1291866ljc.39.1691747017304;
        Fri, 11 Aug 2023 02:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPmBEhq0ziyPvWMK2kOU1LG5Tzuyf9Sczaa1OhunLxidY9Ot6SzlxL1INuZU60YWrmY9CA+ZI+9c5cvbQkMs8=
X-Received: by 2002:a2e:7401:0:b0:2b6:d137:b61c with SMTP id
 p1-20020a2e7401000000b002b6d137b61cmr1291848ljc.39.1691747016987; Fri, 11 Aug
 2023 02:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org> <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org> <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org> <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811052102-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Aug 2023 17:43:25 +0800
Message-ID: <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 5:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Aug 11, 2023 at 05:18:51PM +0800, Jason Wang wrote:
> > On Fri, Aug 11, 2023 at 1:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > > > On Fri, Aug 11, 2023 at 3:41=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > > > On Mon, Jul 31, 2023 at 2:30=E2=80=AFPM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > > > program will create issues in the networking stack.
> > > > > > > > >
> > > > > > > > > Unfortunately, it's not rare as the device/cvq could be i=
mplemented
> > > > > > > > > via firmware or software.
> > > > > > > >
> > > > > > > > Currently that mean one either has sane firmware with a sch=
eduler that
> > > > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > > > >
> > > > > > > > > > But if they do they can always set this flag too.
> > > > > > > > >
> > > > > > > > > This may have false negatives and may confuse the managem=
ent.
> > > > > > > > >
> > > > > > > > > Maybe we can extend the networking core to allow some dev=
ice specific
> > > > > > > > > configurations to be done with device specific lock witho=
ut rtnl. For
> > > > > > > > > example, split the set_channels to
> > > > > > > > >
> > > > > > > > > pre_set_channels
> > > > > > > > > set_channels
> > > > > > > > > post_set_channels
> > > > > > > > >
> > > > > > > > > The device specific part could be done in pre and post wi=
thout a rtnl lock?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > >
> > > > > > > > Would the benefit be that errors can be reported to userspa=
ce then?
> > > > > > > > Then maybe.  I think you will have to show how this works f=
or at least
> > > > > > > > one card besides virtio.
> > > > > > >
> > > > > > > Even for virtio, this seems not easy, as e.g the
> > > > > > > virtnet_send_command() and netif_set_real_num_tx_queues() nee=
d to
> > > > > > > appear to be atomic to the networking core.
> > > > > > >
> > > > > > > I wonder if we can re-consider the way of a timeout here and =
choose a
> > > > > > > sane value as a start.
> > > > > >
> > > > > > Michael, any more input on this?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > I think this is just mission creep. We are trying to fix
> > > > > vduse - let's do that for starters.
> > > > >
> > > > > Recovering from firmware timeouts is far from trivial and
> > > > > just assuming that just because it timed out it will not
> > > > > access memory is just as likely to cause memory corruption
> > > > > with worse results than an infinite spin.
> > > >
> > > > Yes, this might require support not only in the driver
> > > >
> > > > >
> > > > > I propose we fix this for vduse and assume hardware/firmware
> > > > > is well behaved.
> > > >
> > > > One major case is the re-connection, in that case it might take
> > > > whatever longer that the kernel virito-net driver expects.
> > > > So we can have a timeout in VDUSE and trap CVQ then VDUSE can retur=
n
> > > > and fail early?
> > >
> > > Ugh more mission creep. not at all my point. vduse should cache
> > > values in the driver,
> >
> > What do you mean by values here? The cvq command?
> >
> > Thanks
>
> The card status generally.

Just to make sure I understand here. The CVQ needs to be processed by
the userspace now. How could we cache the status?

Thanks

>
> > > until someone manages to change
> > > net core to be more friendly to userspace devices.
> > >
> > > >
> > > > > Or maybe not well behaved firmware will
> > > > > set the flag losing error reporting ability.
> > > >
> > > > This might be hard since it means not only the set but also the get=
 is
> > > > unreliable.
> > > >
> > > > Thanks
> > >
> > > /me shrugs
> > >
> > >
> > >
> > > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > >
> > >
>

