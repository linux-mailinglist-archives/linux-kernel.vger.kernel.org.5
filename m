Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8A762D29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGZHX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjGZHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138D3C07;
        Wed, 26 Jul 2023 00:20:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so94985361fa.1;
        Wed, 26 Jul 2023 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690356032; x=1690960832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIjAg3STPHrNomBKUumGhrzH+A1OTejnaQKtF+Ii1BY=;
        b=b89jjWwJiBDG2oEiGcg/JALiB45ddMP2u6a2WXMQEM8EZGteM5sCa7eH3PNzkQyYHC
         QPGZPY4O9IEmitqWRDReKl5g6XwASzx/pKRrNauSttsyC4RJHqGyoVerbgqNZ90+LYS3
         PK89OErr44MIWudAgTKUwMFbP7LcRd/CpkmpZ2Tito6IGdfQyZWaMceythWP7zw3H4IL
         wh9YLhodxBhpjmC1HqZdwQBvJc+iHPWXvIjqLg9PDxOg4t6he2D1f0QDWrxM0/ygARwT
         2MN1nMkPOVJgE7oXWndmuo0LTTsC8jg/kfdjEN6PkAbwZF5UEsUxVNHXMBGss1LZI6oC
         GTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356032; x=1690960832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIjAg3STPHrNomBKUumGhrzH+A1OTejnaQKtF+Ii1BY=;
        b=b8PJeaGaNb45lA1IVB9Zy+hVf8AZpf5EE/N4UbvDzHdU4lHrI0MpBFBXcQcyxwV+1c
         vxA+k+m7B173ouNJClx2xsw1caEOTwBC6iyTJTrD47gZbacCInQ3m/QtDZvHuyQAq6cn
         qNtDpueIEO/m5T8pmA6UJG29Begjib6pFAkWWSt9r/EpYKNvQKCK4EExQ8kHz9ERtp7W
         iJrIHS6Nn13Aa0DG8sqXJmU+njIXpDOAtMlaIBtZBeguoydzllLBZpOzmFMxknS3bhq3
         WpqlhRAyJrJ41OPlMSP45QogP9/vNM+Q0XSsA22HA09R/XQ/Vp06mbYliNOQp55HaOwQ
         P6Ng==
X-Gm-Message-State: ABy/qLbXNzUNi7VZmZai1MBs5abIJsV14Vd1X1fiCR/YMNBfk8VPNFO8
        vH4fe78GpoIKspHZ53uS5DAB981XS9Y53WP+
X-Google-Smtp-Source: APBJJlE4digYFNcgniMLPCgyqsbVEt12BREu8UdInq/XleqlenAUDJygmszhWK7XdWTDrcfDThHHEw==
X-Received: by 2002:a2e:900a:0:b0:2b5:974f:385 with SMTP id h10-20020a2e900a000000b002b5974f0385mr808562ljg.9.1690356031776;
        Wed, 26 Jul 2023 00:20:31 -0700 (PDT)
Received: from akanner-r14. ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e960e000000b002b9b90474c7sm132830ljh.129.2023.07.26.00.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:20:31 -0700 (PDT)
Message-ID: <64c0c93f.2e0a0220.25086.02ae@mx.google.com>
X-Google-Original-Message-ID: <ZMDJO1BGGJV4PQAZ@akanner-r14.>
Date:   Wed, 26 Jul 2023 10:20:27 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:09:53AM +0800, Jason Wang wrote:
> On Tue, Jul 25, 2023 at 11:54 PM Andrew Kanner <andrew.kanner@gmail.com> wrote:
> >
> > Syzkaller reported the following issue:
> > =======================================
> > Too BIG xdp->frame_sz = 131072
> > WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
> >   ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
> > WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
> >   bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
> > ...
> > Call Trace:
> >  <TASK>
> >  bpf_prog_4add87e5301a4105+0x1a/0x1c
> >  __bpf_prog_run include/linux/filter.h:600 [inline]
> >  bpf_prog_run_xdp include/linux/filter.h:775 [inline]
> >  bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
> >  netif_receive_generic_xdp net/core/dev.c:4807 [inline]
> >  do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
> >  tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
> >  tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
> >  call_write_iter include/linux/fs.h:1871 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x650/0xe40 fs/read_write.c:584
> >  ksys_write+0x12f/0x250 fs/read_write.c:637
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
> > ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But
> > tun_get_user() still provides an execution path with do_xdp_generic()
> > and exceed XDP limits for packet size.
> >
> > Using the syzkaller repro with reduced packet size it was also
> > discovered that XDP_PACKET_HEADROOM is not checked in
> > tun_can_build_skb(), although pad may be incremented in
> > tun_build_skb().
> >
> > If we move the limit check from tun_can_build_skb() to tun_build_skb()
> > we will make xdp to be used only in tun_build_skb(), without falling
> > in tun_alloc_skb(), etc. And moreover we will drop the packet which
> > can't be processed in tun_build_skb().
> >
> > Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
> > Link: https://syzkaller.appspot.com/bug?id=5335c7c62bfff89bbb1c8f14cdabebe91909060f
> > Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> > Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> > ---
> >
> > Notes:
> >     V2 -> V3:
> >     * attach the forgotten changelog
> >     V1 -> V2:
> >     * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
> >       syzkaller repro and missing XDP_PACKET_HEADROOM in pad
> >     * changed the title and description of the execution path, suggested
> >       by Jason Wang <jasowang@redhat.com>
> >     * move the limit check from tun_can_build_skb() to tun_build_skb() to
> >       remove duplication and locking issue, and also drop the packet in
> >       case of a failed check - noted by Jason Wang <jasowang@redhat.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks
> 
> >
> >  drivers/net/tun.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index d75456adc62a..7c2b05ce0421 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1594,10 +1594,6 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> >         if (zerocopy)
> >                 return false;
> >
> > -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> > -           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
> > -               return false;
> > -
> >         return true;
> >  }
> >
> > @@ -1673,6 +1669,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> >         buflen += SKB_DATA_ALIGN(len + pad);
> >         rcu_read_unlock();
> >
> > +       if (buflen > PAGE_SIZE)
> > +               return ERR_PTR(-EFAULT);
> > +
> >         alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
> >         if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
> >                 return ERR_PTR(-ENOMEM);
> > --
> > 2.39.3
> >
> 

Thanks, Jason.

Can anyone point me to some tests other than
tools/testing/selftests/net/tun.c?

This one shows:
PASSED: 5 / 5 tests passed.

I'm trying to figure out if we're dropping more packets than expected
with this patch. Not sure if the test above is enough.

-- 
Andrew Kanner
