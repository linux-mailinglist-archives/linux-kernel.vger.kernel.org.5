Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86F76114A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjGYKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjGYKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:49:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D71990;
        Tue, 25 Jul 2023 03:49:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so8343909e87.1;
        Tue, 25 Jul 2023 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690282169; x=1690886969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKaUQGPjdDfYhdrv9D3r8wNt4DpcmSXfx9EIaio0fng=;
        b=LXifjZ/mWLZLJKXUG1XZqUsk1oAAJ3pVW9sAqnUn03nM32YdNrljcxEpUHsCPFO4iH
         WgGXpaVPLa4Q+eJm+c27T/IzKHrb9NqTmVq49XhlPfQuN+3/5E6eC13Zee4K82ON9D0F
         /KMoYGpj2F2nQLA8B/Zl6XoINJPwrjzRjbX/wM0wOqOX8LecLwS15XnkgGJs8EM6vo+c
         dzS5/Uvj5djmTI/pUfCdy/inviuUarpn8d2BDbBmrrRKGa0pTa64MV4EEfs/L5CERjsD
         l8sCuqhUDkubDcqIxYe75AxGYWoAfSXnvhfU8dDZNN9Orjb6LczeiVNlIFAbm7VQ+fFX
         xD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282169; x=1690886969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKaUQGPjdDfYhdrv9D3r8wNt4DpcmSXfx9EIaio0fng=;
        b=j78iCSgvNgZGkuQzg4F/ITiT0XUsAMDjUe2eROdxzCjQU2T+x5U8UDciVAXm/1NVN0
         NlkSk+Q0AJw94wYZW1YwNYKQ4xIylbfgxanIGLoLGp1CYTp6EkFyuUJcjVWb8p4phca6
         3FOjkEGgbOdiLRnY+Osx1YfGwQruw+mT8r7j5FioW6jqb3LnLUQle6nX1veA1i5rDJCu
         cVZB1hnWfoq1EURCP3zBoUf55zn43dPFIMOCPpxNDMhI+KzzGiiXgAXdi6iDpOUU168u
         uNtQfkcTYkuYt7tUfiQljSYOlZixdSMG8Z2TnwR8LvNMecKnlF4sDwbTYv4Mh3gOD+Ae
         gT9Q==
X-Gm-Message-State: ABy/qLYG3wnaKMHVp9//840yrHkfM4IIB7oo4wjMkaCHVWItrD9l0oMH
        4jv3AHsUjMSTXI52v7KOo8fi/uPxNSTRZgrQ
X-Google-Smtp-Source: APBJJlFHZDa5JGiPNcdmSGdDvacm6f4uAn24FLGnr6AtF453L+WG4jkhfRjsQnNjWdBVI1BQRpG/eg==
X-Received: by 2002:a19:6755:0:b0:4f8:5bf7:db05 with SMTP id e21-20020a196755000000b004f85bf7db05mr7354401lfj.27.1690282168453;
        Tue, 25 Jul 2023 03:49:28 -0700 (PDT)
Received: from akanner-r14. ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id c20-20020a197614000000b004edc72be17csm2695943lff.2.2023.07.25.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:49:27 -0700 (PDT)
Message-ID: <64bfa8b7.190a0220.b6db7.53b7@mx.google.com>
X-Google-Original-Message-ID: <ZL+otOFR1r507Opz@akanner-r14.>
Date:   Tue, 25 Jul 2023 13:49:24 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] drivers: net: prevent tun_can_build_skb() to exceed
 xdp size limits
References: <20230724221326.384-1-andrew.kanner@gmail.com>
 <20230724221326.384-2-andrew.kanner@gmail.com>
 <CACGkMEt+LW8FBNwcn6f0cBwTOuKy+ZPy3Smg6fJgo9OrCUAOjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt+LW8FBNwcn6f0cBwTOuKy+ZPy3Smg6fJgo9OrCUAOjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:39:46AM +0800, Jason Wang wrote:
> On Tue, Jul 25, 2023 at 6:15 AM Andrew Kanner <andrew.kanner@gmail.com> wrote:
> >
> > Tested with syzkaller repro with reduced packet size. It was
> > discovered that XDP_PACKET_HEADROOM is not checked in
> > tun_can_build_skb(), although pad may be incremented in
> > tun_build_skb().
> >
> > Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> > Link: https://syzkaller.appspot.com/text?tag=ReproC&x=12b2593ea80000
> > Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> > ---
> >  drivers/net/tun.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 18ccbbe9830a..cdf2bd85b383 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1582,7 +1582,13 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
> >  static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> >                               int len, int noblock, bool zerocopy, int *skb_xdp)
> >  {
> > -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> > +       int pad = TUN_RX_PAD;
> > +       struct bpf_prog *xdp_prog = rcu_dereference(tun->xdp_prog);
> 
> This misses rcu read lock.
> 
> I wonder if things could be simpler if we move the limit check from
> tun_can_build_skb() to tun_build_skb():
> 
> rcu_read_lock();
> xdp_prog = rcu_dereference(tun->xdp_prog);
>         if (xdp_prog)
>                 pad += XDP_PACKET_HEADROOM;
> buflen += SKB_DATA_ALIGN(len + pad);
> rcu_read_unlock();
> 
> Thanks
> 

Thanks, I missed the part with rcu read lock for some reason.

It's a good idea to move / reduce duplication. Let me think and try to
fix according to your comments, I will resend it as v2.

-- 
Andrew Kanner
