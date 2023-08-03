Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE676F0EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjHCRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjHCRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:53:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D713C3A;
        Thu,  3 Aug 2023 10:53:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso2141262e87.1;
        Thu, 03 Aug 2023 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691085202; x=1691690002;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V+wyudEu/QspMENufwePSDeBm7uMlK4OkNp5EvN/35o=;
        b=JL+ZqAqjXrPGGLl4Rbob9P7lElgz/eZuZmXKnawuVKZBW75wL5TqICw4umkMOq+7PV
         00x8OW1CbC//gpvy8dRhNiGfAPCugbxKC3zfXksmbBbUscvWho018BDCca2uVKy0k8vw
         8TRd/qdKa6fpUJychSdgSxRvnTiB8e8Wn/gwrh/UaAoC+eF6HkUz/G/nqoBBD/szkhnc
         XQ6l2u6atW5ZZbHWLQ4Tal1fh+ROry20RaLG35HfU1ewxzJMlgFT3J4Tj7MaRKxxxBBY
         OEndrsRCD8JDKLUN53jpgdimIobPT096j/V0OHlJkxMkn1InGJ8WO1nAuRezDqZDc5WG
         7+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085202; x=1691690002;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+wyudEu/QspMENufwePSDeBm7uMlK4OkNp5EvN/35o=;
        b=fe7Z9aW1EEzvCYaWE8THVTM66cMwpkSQdwGbiCsd+pTq0N3kpDdUDcY4mQLjeArhAh
         ZetESbWKjgng3lzGz2FCtaPuwFS4m2R0XBUUln9gfYddfx3bU9NyrXdj3ubo+0p+RZ3P
         V5Mxf6P7U95GC4AVumHEWYPrdQouQv2bKfrgsgKVlt52HYRF6nG7VsncVYf4Tt+scJCc
         JDHSnNCYN37M4VBQM5BbHEL0HdhgQFyYVIBeG/ljHQeOgwuzf7Lt2p+bKCGzk6TgFO64
         1jNAbRlYvL9mULzPpMRGmONqKfTTsVzihXauauYpvANLAD8oWJ1X2lRUjwHgcgcgAlzo
         Y4bQ==
X-Gm-Message-State: ABy/qLbloKpjmW0nVjPReEWeVTfisW2QUQIGWew3QgGToHu/bmKUk8F/
        ReMZ04WacxC4gwAx6Nzqad4agvDAEzj7UA==
X-Google-Smtp-Source: APBJJlF+LqRZRqf2E33KO6guouHFBeH+ORAACowQeq08iE+8pelgELDa3c7+5LJh1LSKxy24OeUz2g==
X-Received: by 2002:a05:6512:370b:b0:4fe:279b:8a02 with SMTP id z11-20020a056512370b00b004fe279b8a02mr6690530lfr.67.1691085201631;
        Thu, 03 Aug 2023 10:53:21 -0700 (PDT)
Received: from akanner-r14. ([77.222.27.58])
        by smtp.gmail.com with ESMTPSA id m8-20020a195208000000b004fe31fa2490sm46205lfb.247.2023.08.03.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:53:21 -0700 (PDT)
Message-ID: <64cbe991.190a0220.b646b.04c1@mx.google.com>
X-Google-Original-Message-ID: <ZMvpjJFyLDqMuLK/@akanner-r14.>
Date:   Thu, 3 Aug 2023 20:53:16 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com,
        jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
 <CACGkMEvukuV5UZqb=MOaPqWfuJKOokZW1986GE4cRwt=Vx9Unw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvukuV5UZqb=MOaPqWfuJKOokZW1986GE4cRwt=Vx9Unw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:19:47AM +0800, Jason Wang wrote:
> > > @@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> > >       if (zerocopy)
> > >               return false;
> > >
> > > -     if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> > > +     rcu_read_lock();
> > > +     xdp_prog = rcu_dereference(tun->xdp_prog);
> > > +     if (xdp_prog)
> > > +             pad += XDP_PACKET_HEADROOM;
> > > +     rcu_read_unlock();
> > > +
> >
> > Isolated seen, I guess, this is a correct fix to 7df13219d757.
> 
> I think so.
> 
> Actually, I think we can probably always count XDP_PACKET_HEADROOM
> here. Since there's a window that XDP program might be attached in the
> middle of tun_can_build_skb() and tun_build_skb().


Thanks, that makes sense.
I will do it in v5.


> > Question to Jason Wang:
> > Why fall back (to e.g. tun_alloc_skb()) when size is above PAGE_SIZE?
> >
> > AFAIK tun_build_skb() *can* create get larger packets than PAGE_SIZE
> > from it's page_frag.  Is there a reason for this limitation?
> 
> I couldn't recall but I think we can relax.

Jesper already sent enough info for this idea in v2, I will use it for
the next patch/series.

Jesper, I will add this tag for this next patch/series if you don't
mind:
Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>

-- 
Andrew Kanner
