Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22D7736B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHHCcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHHCb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E33185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691461871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeABWAIqA3NR/jSM0/v+3WWsrOAd6qgiAGCX11jVSJU=;
        b=H7KwxRMbTsv7yjfgkx0gHA2zIrBdxWIKXVPVJ9q2lT4xxU5PmaEPEDQtoSYjafYC4NV8c/
        4IYm7qwMcmjuDPkAWlW3+bcI328yJ/h3ULwWRDneIiVDj4zca0EEvEp8q+sh0BLkBsnlUA
        8mUaVB4EMAMZwFGkwvX0lK2EkBC/rcc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-T279-xFSNfup0XZPtBPaIw-1; Mon, 07 Aug 2023 22:31:09 -0400
X-MC-Unique: T279-xFSNfup0XZPtBPaIw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9fa64dba8so49311051fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461868; x=1692066668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeABWAIqA3NR/jSM0/v+3WWsrOAd6qgiAGCX11jVSJU=;
        b=KcGCoEIo/bTw2J8oQJtimrAqCSHdoM+ugvlqaTBf6sI0TAL+XLKmzEP725uxoB0P/o
         sNAGtGB+uRrI2+7tLP6Hh+1nvos8bohg4MZEXTs5BABk98WGLPaE0OBEfbsXQpl8JGuZ
         0jtjxJbQFYIw21fZHoUlSr+7Zfe19k49L+z7b6Aqyk02nI/Joi2Zc9rGdS0mRr8/FB8z
         YV0DwJ+URwm07gVJ/2o3HYXDkWWhdAMCZkD3HVr73Nb+yPTpGeov4IoQ0EypVP/fzF2O
         eUwnsZn7FvVEZlGH7JL2Yia2YHTj6EDx/mewiNDw+M5+4iMsvMzYYV45iC2uk93IimFv
         Sn6g==
X-Gm-Message-State: AOJu0YycAlclMwXSwg1uhi8UlRu+upRA/7tjMNauAiNMRDBL+fx/fi7f
        yHwlNvCsByPCkzQx+7mNVk9148vvHZjtW1C7t593MrJuziM1Qz4pqFlTRxAbB1k2AKOquJeAHoM
        2celxk2ZeOb7CNjlfGvE5G2j6YyKY3NcMK1GPf9JD
X-Received: by 2002:a2e:97c9:0:b0:2b9:b1b2:f97a with SMTP id m9-20020a2e97c9000000b002b9b1b2f97amr7713161ljj.0.1691461868041;
        Mon, 07 Aug 2023 19:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf6wmUz9KD7Pm40wOolwzcO4hKLwPojzVOso6zb90KU8To2voaONAyiIwO5firUf/hF/21vH+T0rjab6rKFwg=
X-Received: by 2002:a2e:97c9:0:b0:2b9:b1b2:f97a with SMTP id
 m9-20020a2e97c9000000b002b9b1b2f97amr7713147ljj.0.1691461867765; Mon, 07 Aug
 2023 19:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org> <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
In-Reply-To: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Aug 2023 10:30:56 +0800
Message-ID: <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > They really shouldn't - any NIC that takes forever to
> > > > program will create issues in the networking stack.
> > >
> > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > via firmware or software.
> >
> > Currently that mean one either has sane firmware with a scheduler that
> > can meet deadlines, or loses ability to report errors back.
> >
> > > > But if they do they can always set this flag too.
> > >
> > > This may have false negatives and may confuse the management.
> > >
> > > Maybe we can extend the networking core to allow some device specific
> > > configurations to be done with device specific lock without rtnl. For
> > > example, split the set_channels to
> > >
> > > pre_set_channels
> > > set_channels
> > > post_set_channels
> > >
> > > The device specific part could be done in pre and post without a rtnl=
 lock?
> > >
> > > Thanks
> >
> >
> > Would the benefit be that errors can be reported to userspace then?
> > Then maybe.  I think you will have to show how this works for at least
> > one card besides virtio.
>
> Even for virtio, this seems not easy, as e.g the
> virtnet_send_command() and netif_set_real_num_tx_queues() need to
> appear to be atomic to the networking core.
>
> I wonder if we can re-consider the way of a timeout here and choose a
> sane value as a start.

Michael, any more input on this?

Thanks

>
> Thanks
>
> >
> >
> > --
> > MST
> >

