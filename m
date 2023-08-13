Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2475177A60C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHMK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:58:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D70170D;
        Sun, 13 Aug 2023 03:58:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso468342666b.2;
        Sun, 13 Aug 2023 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691924287; x=1692529087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbwLo9vq/XDu6x+nLulntq2VrlRNT0aEjgWQ6Z46kXE=;
        b=PzGqEtpzSTzWZUJ4pq7RtXfAXn03yFp0r/Dh84lcTkQfdHmVM+35ipv4Pcaxy/i6qO
         rcDe6T4RvbwyQ1aukudJ+3A+rIDCKxLlBgutkwPw2k7kd8pTikAQKMXCNxThCi6/aflp
         3NKQPJO2VeC440JlT68VTPNmfboesjpsyAyDfZNpM6bG/bxwAWzarwF2Hp63K23rSSpn
         xf44vWaxjjn9Nhywm0Ja3cpafFPYfD1SGWQABVcUNBgCpynWaInM00/KF0jL/qpz091V
         LyCXPxrp7Q+Lz4B1vtc8GeAxB333k9uvS8YpbTcLzz7QyT+uaFRVS395eSIaZ4VJPvUo
         BIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924287; x=1692529087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbwLo9vq/XDu6x+nLulntq2VrlRNT0aEjgWQ6Z46kXE=;
        b=FxngI+CMRVVQ5vMFane8YzKmEZaadX/10L4ub3V6B6T4M7ud67i0eH9RYUc96aWEsf
         g9UaIUzUPl8iUtSLH4v3U8LNMDEY6Efw+Yn8s+Nrc9rPFohhs5iaor4BcCDKx1GXSIn9
         9dpqQ5z485l61lhxkw0r6dHjvBOywyFZCg1rir6/1rUDyN70840PHutzxyj2q9PsVG3r
         5ee+wdGzW4aJW0LjERv+bYT/dyXUVJm+0PDw0vGxE+AZNl7lxNPvKIeXHbvIg47igyz1
         9f3/nMv7xg3zRhqXTTXaA+lnvyBBZNY8nBckOfuQNiS51m0bcJKItW3cvJ+UVyJi615F
         eD9w==
X-Gm-Message-State: AOJu0YwD0tTKjIuKY0/VD6YKHU4OMUK/AWOyAXgAcbjSLHu+IIyW/e9n
        wjxQXdzy7fEq9EeTd1f/oQE=
X-Google-Smtp-Source: AGHT+IFhPrq+JzxAzfXLhBxnMjlYVhwtBIx/avAcNkD+jnJwRomb28lYMYJjrAb4BYDRmiusbecabA==
X-Received: by 2002:a17:907:7755:b0:993:6845:89d6 with SMTP id kx21-20020a170907775500b00993684589d6mr5952699ejc.47.1691924286961;
        Sun, 13 Aug 2023 03:58:06 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090611d400b0099bd6026f45sm4449622eja.198.2023.08.13.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 03:58:06 -0700 (PDT)
Date:   Sun, 13 Aug 2023 13:58:04 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
        AVKrasnov@sberdevices.ru
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <20230813105804.2r4zdr6dyqe5dsrf@skbuf>
References: <20230811232832.24321-1-l00g33k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811232832.24321-1-l00g33k@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alfred,

On Fri, Aug 11, 2023 at 04:28:32PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpect mode
> rendering it inoperational.
> 
> Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>
> ---

I don't think you understand the meaning of the Fixes: tag. It is
supposed to point to the first commit where the issue being fixed
started being visible. But git show 8abbffd27ced shows:

commit 8abbffd27cedd0f89f69e5ee2ff6841ea01511eb
Author: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Date:   Tue Jan 10 10:18:32 2023 +0000

    test/vsock: vsock_perf utility

    This adds utility to check vsock rx/tx performance.

    Usage as sender:
    ./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
    Usage as receiver:
    ./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>

    Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

So:
1 - that has nothing to do with mv88e6xxx, so it cannot have introduced
    the issue here
2 - there is a mismatch between the blamed commit sha1sum and the blamed
    commit message. In fact, the blamed commit message is _your_ commit
    message, which is not correct.
