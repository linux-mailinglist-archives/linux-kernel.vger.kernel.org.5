Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B77DC2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjJ3XMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3XMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:12:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5849DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:12:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7dd65052aso51072847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698707523; x=1699312323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGr7gy8kOteEp5Y91mfSF0OEQx3erWbimD8/Mcv0sFY=;
        b=PpF0uSS5isybsFqiY9Wj/wQu1OimTVd1wcrpeYZk4SC8V7951zvtLa2KRZGcDEeSUT
         bxUpDqnQrQUEoJ4/1Cktshv0ovouyStaGscLXLYTRUoG6PY4lbiZfAxrxWoKkpPTXgMb
         GHmDuVcN+bqsTSfC/BLuhSQ/9ctAgDK+jiMmARhoOpX40bR17bQ4kO6IsQlrHn2n7aps
         r697GZgq+JztDKPkuEu8xgaaf9rxFiGpJJzAta6G3doEVWTgOMn5DtVfmvKBNuYvGd81
         PQlXxmm6XTF1mR2TVv3k7emaICXZEN5G2MGhv9IRQid2T99qUuzaygMAVyT0DhymswUR
         aPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707523; x=1699312323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGr7gy8kOteEp5Y91mfSF0OEQx3erWbimD8/Mcv0sFY=;
        b=OkCaV29gAZx+TXVsJTLxkNd59O2VIQzfFXHeNg+8FSxysVT4mx4vWjaj2nEyZ8icre
         TQXt0bfAm6yf54jlzb7HpCjC+RscaIZLI0oCfSN3zOvUvjK33cOt3MpuuR8tS8Ah1nUw
         fkJbCy7Xl98baM7Odlldqa8bUWfPfyKFMq3vaAy/IEiWS2xfNNPE01q4rSYUbN9EZUG7
         MINHFYa4wzljI/nxsRaPqssLIXELtawF+xAQE24koHSq/ClWPFd0ili+Ld4QBlJC+cWz
         JrXn/AzDlaLuNJo1M3o7K1jE1C8lFv3x7kEXCxLEti9Sapk9PzoWYfRsQWkvGh4PtNyQ
         aiMg==
X-Gm-Message-State: AOJu0Yy/+TDkD2QeSODs7HB9WLjYKpTk2hEn0c7xpg8/tpdJTlA4dfEa
        12IMxpJIItMti+/uMRx5DNkoxuQuig+5FXkpULXa4w==
X-Google-Smtp-Source: AGHT+IHzh1T19az228TAdi0hy2EN6mS90efMvKloneYEnAGZRzkBhLFluz6Vij5HYrvkFtXmDQ378OncfN5m8RJQ40o=
X-Received: by 2002:a81:c64b:0:b0:578:5e60:dcc9 with SMTP id
 q11-20020a81c64b000000b005785e60dcc9mr10288103ywj.10.1698707523065; Mon, 30
 Oct 2023 16:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030230906.s5feepjcvgbg5e7v@skbuf>
In-Reply-To: <20231030230906.s5feepjcvgbg5e7v@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 00:11:51 +0100
Message-ID: <CACRpkdZ=Y3wnnUtBVbzaOsA6bLm7nOwXoi7qO3=n_K=xpqofjA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 12:09=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > This of course make no sense, since the padding function should do noth=
ing
> > when the packet is bigger than 60 bytes.
>
> Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn't
> work? Could you add a static ARP entry for the 192.168.1.137 IP address?

ARP appears to work, and also DHCP then (I reconnect and
restart the interface before each test), so it's really weird.

I'm trying your suggestion to skb_dump() before/after.

Yours,
Linus Walleij
