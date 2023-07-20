Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915FB75B92D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGTVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGTVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C062727
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689886991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
        b=NqLaU+V22HIVrqYv3Or3rQjJCdh8Z7MCI81/zhFnSuq2YlCLS+viepiZzLfhcpNGrps5FX
        9BDzO7ABWgjYwqlrdSZr2LjNjos3HKY7HDEtZj6+8XgLgUIlWIWXZvtjNrMoqHSQaK68zj
        raxDhZb7g4SjHEa1uhyJON1GJ0QqU3w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-aFG9s8ChNMKrWhSuvy3bbw-1; Thu, 20 Jul 2023 17:03:07 -0400
X-MC-Unique: aFG9s8ChNMKrWhSuvy3bbw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b934194964so12814651fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886986; x=1690491786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
        b=kYJjswLTFUawvBAElrx30V1w+ALEr1TyrXIDWoK61VynZfYWL+2wJCS8jpN4JXVOCG
         CW51DohUzr27/6n4WCP92hQywaT3nDSpp2DOymA52iTGC1/8ODJkBFk7a9yaIUnZCSiw
         HP0IssOPzu9TcvGotStABn+GRa92JMUcrVwaHCe0cs2ChNYHg83061rE73Vc1nBAvKuG
         ObblaEFefoEzOgmNfxVWuT8QCo/6ASbswfae8DvaCCQjd12/7eotqpU5ap8DSEvIHs7E
         VqKTmaC+aSyJue4ffAmNJLBJhCn8BiUKVOp1M372CZykdluq0cAl8wdixiaOuZhbwaZz
         ocNQ==
X-Gm-Message-State: ABy/qLaM/i3IRwcWVwCZVQiRmUaQeypXMs+gPewrzxbW1eYCgtsiJ7FD
        tdtRyHB14ycfUO6cuQV6Z7M1WTDNwZy6FZuIK0NtNs053Y1lnKI2yYIJ8yc2bVk0J8LmymCOWeC
        y/351dP+/J0AvwRZxHqI3Hily
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id x15-20020a2e9dcf000000b002b6dbc55ca4mr86345ljj.16.1689886985702;
        Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkO9895VB0oEJzz7Mt1u7LjrPYNqoemBmNFeHR6tqktWs0kblZ6OrDWTCIs6FgX5K3EX736g==
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id x15-20020a2e9dcf000000b002b6dbc55ca4mr86325ljj.16.1689886985355;
        Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c248900b003fbb618f7adsm1982153wms.15.2023.07.20.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:03:04 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:02:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720170001-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> This still leaves hung processes, but at least it doesn't pin the CPU any
> more.  Thanks.
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 

I'd like to see a full solution
1- block until interrupt
2- still handle surprise removal correctly by waking in that case



> > ---
> >   drivers/net/virtio_net.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9f3b1d6ac33d..e7533f29b219 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >           * into the hypervisor, so the request should be handled immediately.
> >           */
> >          while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > +              !virtqueue_is_broken(vi->cvq)) {
> > +               cond_resched();
> >                  cpu_relax();
> > +       }
> > 
> >          return vi->ctrl->status == VIRTIO_NET_OK;
> >   }
> > --
> > 2.39.3
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

