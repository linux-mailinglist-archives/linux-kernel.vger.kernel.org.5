Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24776CCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHBMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjHBMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:31:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53F2720;
        Wed,  2 Aug 2023 05:31:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so6864327f8f.1;
        Wed, 02 Aug 2023 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690979484; x=1691584284;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M/m/gzewmCnAmIApz3YxUDPf30Sh/dA/f5p9pyqk5tg=;
        b=MCHG2V9Qo/45YT02/1PeUF3/ROIo4tB7le3QDdH/gDTWQJEGR8ADc8EzIqx2OWjJxL
         9UJDBTxx05zFF6tNdsQU5cGmqDSEWya4likKfLq/IUj6S9DjkAQ81DgGhCPpsMNu2IAt
         7M1G+phvyTVzKvXTJEfcP2SjYORFoM3eIkdEG5+0Saz8d1lI7ANmhfb96p6wrDh3MGlB
         r1phEHqoMz9nFD4FoG17Ggqyl8OfaDmvsUZag08zIh+0k/pUDDlz1w4uO9nBzFCHPHVL
         G7OHSocTAWStxv5B7sgxhfkqMnzzJ4w+M1kbdcMjLq6+iXLFNIYek2E2dIrC/tmrOhuX
         ZhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979484; x=1691584284;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/m/gzewmCnAmIApz3YxUDPf30Sh/dA/f5p9pyqk5tg=;
        b=OoyhCSLxO4myIHt/Bdg+nX9QSwc7wl+cFkMFE0z49PhUfu07QzHR520QTvTKCcbJ6b
         QVC+4e+0m0VVrlrV7PWFwsFn0GDyKVPh1EPkF3vGhU+MKMff90WSc7J8nxL2ST6z0nzA
         LE4F2fxj6d5bgR4Mj9xsZrSYo0uTN977b+L53eo32Dv8vYiSLUepaY9D/G8HmIeNniJv
         q/tHc7957E8eo/LpYWiPiDsOTsINh0eALI1oRMtJwNECYuVFh82Gt1RJGRNmMp7YxxRl
         hCBqLrFvZ5XRKi1zBb7oCJUQRL6HLjEcDJGD3kfmVEyfiQ+odt4tl4J9+zgYRe+aGJq8
         BXTw==
X-Gm-Message-State: ABy/qLbiUgdbSYpy0rsCQCVXFdIRR9bu1X9mShL7CDY6oDR1rzx1B39h
        jzGxhthXu53YAR1uW3/K7Os=
X-Google-Smtp-Source: APBJJlEhxGp8UzvRhk6wLS7gXVN8NGSRwfsL5WAcYURFG9K14NiU37a760PVMsWwLzEp7FSpGWRwtA==
X-Received: by 2002:adf:fec4:0:b0:314:1aed:8f5f with SMTP id q4-20020adffec4000000b003141aed8f5fmr4960310wrs.34.1690979483752;
        Wed, 02 Aug 2023 05:31:23 -0700 (PDT)
Received: from akanner-r14. ([77.222.27.58])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4206000000b00317a04131c5sm9907243wrq.57.2023.08.02.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:31:23 -0700 (PDT)
Message-ID: <64ca4c9b.5d0a0220.2f302.b8de@mx.google.com>
X-Google-Original-Message-ID: <ZMpJNh+PYy40FRnZ@akanner-r14.>
Date:   Wed, 2 Aug 2023 14:16:54 +0200
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <3fa4d25d-7fea-d25b-fa83-4ada2c550725@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa4d25d-7fea-d25b-fa83-4ada2c550725@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:07:39PM -0600, David Ahern wrote:
> On 8/1/23 4:07 PM, Andrew Kanner wrote:
> > @@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
> >  	if (zerocopy)
> >  		return false;
> >  
> > -	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> > +	rcu_read_lock();
> > +	xdp_prog = rcu_dereference(tun->xdp_prog);
> > +	if (xdp_prog)
> > +		pad += XDP_PACKET_HEADROOM;
> > +	rcu_read_unlock();
> 
> 
> since you do not care about the actual xdp_prog (only that one is set) I
> believe you can use rcu_access_pointer here.

Good point. Thanks, David.

I'll resend both as v5.

The correct cc-list for PATCH 2/2 is also needed. It fixes
net/core/filter.c instead of drivers/net/tun.c now.

pw-bot: changes-requested

-- 
Andrew Kanner
