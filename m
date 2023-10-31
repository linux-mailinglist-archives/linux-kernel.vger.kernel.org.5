Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BF7DD679
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjJaTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJaTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:02:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF2E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:02:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9cbba16084so5087971276.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698778961; x=1699383761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4KGArxAse9OlmNDHK67l7i0Cf0qekzekrdh/xlwJmQ=;
        b=yQz4eMEItzBmFMC4dabipGKrJS1ip23YbP8+4da9G2lnbELZFRJaCROodOwdtrGgha
         cUY9sB+uLHDXjaSlo0M570FH62VcuBCTk1UfPiCchgOyGp+peuL1iawzEnWqViPVcqMH
         vtdh8E4g39daL/AlMHA/fBUM9RtOF25BcoZbW/NCnj+FaZ7wkIhOJGibL/aIY252AiAS
         o+q5t/QNOsS9Dv/HXnhpadiWupdGzwv7zOTyywOdiOelUfym/Fr+XN2orVQ4DPDfT34M
         6xbg6GWxRUKfki3n2HoB6GZrh+48OUaOzDsUdIrn/sUWDaYlJ57yd6XfeqTguzQhBBu6
         cB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778961; x=1699383761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4KGArxAse9OlmNDHK67l7i0Cf0qekzekrdh/xlwJmQ=;
        b=d9PRRzh0yv72hIMYsL1s3L/3+nJwgIu2z3lkqKlOOvXoqeowyr8bElWMjhax5oAkcu
         /IxtppkyoG2RE/Te77fF6mXjfxJ21JAmWWShvKmP0fnxgVzEertQStdhZFO1jba5LXLp
         OnUkAE+d6ogQVwry0Qcb5z/jtNgJyTpP3R8JzGFbHDqFFMLOOugdRwyoKQaoKLD/OQmw
         NWGr1/EdmBjcpsiCr/PqPRfQt1DUVwVO4ZD4XFYOFkO23QUN5hMaX99pubh50+zUuG2f
         F0QqFwq7dexm+/rNAr71n83cSRyOce/WxtS8k67feRxHp55EAnyiIMX3kcdnWDO8Zcyu
         Vgdg==
X-Gm-Message-State: AOJu0Yyremo3uFcCl5k/cfnxS68cxbIz2Z+qlEZ+qOjb0Hda/tuWaMJU
        N6tKgGQFXIE/IZhd2uieQwPdTJWpg/qKscTDvOCLrQ==
X-Google-Smtp-Source: AGHT+IFr3vYMDVg5evYLFpLKM2lZT9hhsdNKErYMijLOZGzm/zFiSNML75lGDwp7FixY5bxqeWQAteCakEzmlrwjtcc=
X-Received: by 2002:a25:ab73:0:b0:da0:48df:cafa with SMTP id
 u106-20020a25ab73000000b00da048dfcafamr12634653ybi.16.1698778960745; Tue, 31
 Oct 2023 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <20231031163439.tqab5axhk5q2r62i@skbuf>
In-Reply-To: <20231031163439.tqab5axhk5q2r62i@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 20:02:29 +0100
Message-ID: <CACRpkdb=16uLhsXhktLCwUByDAMv9Arg2zzCA+oJW2HBJ35-Bg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 5:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Ok, so we don't have a confirmation of breakage with other conduit
> interface than the Gemini driver, either. So a problem there is still
> not off the table.

True!

> So on the gemini-dlink-dir-685.dts platform, you can also use &gmac1 as
> a plain Ethernet port, right?

As a port it exist on the SoC yes but it is not connected physically
to anything.

&gmac0 is connected to the switch, and the switch has all the PHYs.

(I don't know if I misunderstand the question...)

> If possible, could you set up dsa_loop (enable CONFIG_NET_DSA_LOOP, repla=
ce
> "eth0" in dsa_loop_pdata with the netdev name of &gmac1, replace DSA_TAG_=
PROTO_NONE
> in dsa_loop_get_protocol() with your tagging protocol) and put a tcpdump
> on the remote end of the gmac1 port, to see if the issue isn't, in fact,
> somewhere else, maybe gmac_start_xmit()?

If you by remote end mean the end of a physical cable there is
no way I can do that, as I have no PHY on gmac1.

But I have other Gemini platforms, so I will try to do it on one
of them! Let's see if I can do this thing....

Yours,
Linus Walleij
