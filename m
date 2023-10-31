Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA17DCEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbjJaORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjJaORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:17:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956DF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:17:02 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5afbdbf3a19so43717517b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698761822; x=1699366622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fVXL7vb6GbxabG5we2Eq28H8QOY1kAFg3Bko4ORL2g=;
        b=dAxwaCYBtixPEx0tcuSEUmDR+j3Xd/7t+51p35EK3TSX+NM8bW/I557Ydz72DBnQ+s
         W9MkaKImcfFDmtcihHHlpEPBZlo9TrXqE8ImQWMhPk46qNwnqqi3baBKEseKf0DwAFDn
         RnAAcIU8bfmqdNjuhpIxv8OH60R/E09szocCVpHuYZbQBS9oCovQBqpPzVYHEMfxCOaJ
         oLgxAuHcjSM+62eWPXaExDuzPRDN39eW+scxi1OXyixEHA6lcTm7+7bmAZ4+Ze+rY3hd
         uak5LG7TiNGy3CvHVOd/sUhpAdq8Cs39dN0wfTSC5Wenj3k5lC6MLvvJxzS7zeNccHrJ
         Jzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761822; x=1699366622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fVXL7vb6GbxabG5we2Eq28H8QOY1kAFg3Bko4ORL2g=;
        b=V6wG08VKvMmFyGrAyADbVJxHl4lGe/FajkiIyaiv5odLWwW917fzZgHGplSqkLYb76
         UVqRjtt4pdtn6i95HsuIvWFKzwRpN7qxonzZm7KLibIBIw+v/BooCyMYzSk/V/MdmnuQ
         hrwp+DNAmFSjSaLz6E7WkDo1NOR3daHKYVZAU1YOLissmHcWQ/yRbGOJu0S8S2B7FVwU
         tVCmFbZsEh3L/bSE/lh0ZEKCQrJMLbZOdiklfa12b7sAaJfDpKbHqZXHYAn4Ewh6y3//
         XOwXdaKEjJz9CjIvHwrrDiYcUBHN3JaDFzN/LftU/20xIBEjY0k05O8Lebb0rCUgr0CY
         QqOw==
X-Gm-Message-State: AOJu0YxD5zEwlAFrq2V+I7tSZNfdyTr1AAjicry/EVAbTpEQi+0BVXoR
        cOJQfMziWSGNEr54pJvhcaoJpMhAwQsS2+RceDLtauJZFQrBEBwm
X-Google-Smtp-Source: AGHT+IFCck+AHxWiEdyT40Wws/dE6mHlB2i4QggXWgD7qWIthaYxhzHpcbulHD6te5HSkKkST4qKxhqEXvsPPhwoXhs=
X-Received: by 2002:a81:79d1:0:b0:583:3c7e:7749 with SMTP id
 u200-20020a8179d1000000b005833c7e7749mr11832766ywc.41.1698761821616; Tue, 31
 Oct 2023 07:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
In-Reply-To: <20231030233334.jcd5dnojruo57hfk@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 15:16:50 +0100
Message-ID: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 12:33=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > Here you can incidentally also see what happens if we don't pad the big=
 packets:
> > the packet gets truncated.
>
> Are we sure we are debugging a switch problem? On how many platforms
> with the RTL8366RB can the issue be seen? Is the conduit interface the
> same on all these platforms, or is it different and that makes no
> difference?

I don't have any other RTL8366RB systems than the D-Link DIR-685.

I however have several systems with the same backing ethernet controller
connected directly to a PHY and they all work fine.

Yours,
Linus Walleij
