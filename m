Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4657F95AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjKZWJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:09:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E3ED;
        Sun, 26 Nov 2023 14:09:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso405745f8f.3;
        Sun, 26 Nov 2023 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701036559; x=1701641359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TgD7s06JjVP8cEZohf4eaBr5zl/6fuWipDfeZojH3Cs=;
        b=dOZQrHU/N4sBGwr24OWrEgfy0UqNCts/N3N9bIWYS5GtixVXRDp+K15OhmXnUBu9An
         H5PMJ6z923ZtJygymbXGTFeJnmyFjWAmGxvKdF24e4Ze248P8x5aOZ+2qREk2w8KvZBF
         HyVdb65QUSgKr3W3TGpwlINloxlJwLzGftLN/qTfsf/KLAbCaF/2Kli8yG65TbbV/15S
         0ckMjqIcXw0Y4PU7gPM3tXYB1qLIWB1JitAKbH5JT1lpwCYbYlz0hjcKY5NwF7ruMr39
         iaz1UviH9NB8lAzmxawCbP7YLWwEoCRYxmYPFro7ss32YeopLybk9vgnXf6y5UxkRX3x
         5L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701036559; x=1701641359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgD7s06JjVP8cEZohf4eaBr5zl/6fuWipDfeZojH3Cs=;
        b=Evsz7jwadEaGmMa5xRrw1QvxiSc+OxDRBn+BSYQznBpvkpB1m9tPXoK20eV/Zf4x5f
         kV8MGem9dTSTvAzdMV85qpMcXHkr485unMl+yCXVgMzY1kvkVYSj35THaX0wm2ENMi8X
         v4/dU1jVmiFal3KD+54kBsT8w+JtEA0CCIrpqsM762F9I3Fl9WrhO6KfkWs3u48MFNoa
         +PJHUN/ZwtVbT6CM7xpGfhdKjAuHMv1aHcqBfPXpbQNrcEmfV21Suf+etYpvi1iiG+ot
         mr3tIvIj192hAPev33reIO99q+1YYcMbfMAfArLSyW2kYLsAxlK3xJApUc2TIxbNCrEu
         Q+oQ==
X-Gm-Message-State: AOJu0Yzaf4bNOHiyDvcIk2StCRk3DvDkrbWDBb597E2KQlcu+aks7GBs
        fqIXbhzMrZbOZ1uLa7/OPPI=
X-Google-Smtp-Source: AGHT+IF/weuraeT4gREw41hnQVk/EcFUAjBWWs4sobrwdP8aML9tLcfOApj8nQcBDziT1LekP/vmTw==
X-Received: by 2002:a5d:4607:0:b0:32f:7649:2648 with SMTP id t7-20020a5d4607000000b0032f76492648mr6819352wrq.46.1701036558369;
        Sun, 26 Nov 2023 14:09:18 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b0040b3d33ab55sm7411173wmn.47.2023.11.26.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 14:09:18 -0800 (PST)
Message-ID: <6563c20e.050a0220.6de54.6c62@mx.google.com>
X-Google-Original-Message-ID: <ZWPCCwrZrZ45zN96@Ansuel-xps.>
Date:   Sun, 26 Nov 2023 23:09:15 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>
 <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
 <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>
 <4bd8642c-988f-4b99-944a-da573d0ef2c3@lunn.ch>
 <CACRpkdYp76UK3uC=3JrbZ5MhPRn7CkAbO1fezrSCNfDqobjZww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYp76UK3uC=3JrbZ5MhPRn7CkAbO1fezrSCNfDqobjZww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 09:11:28PM +0100, Linus Walleij wrote:
> On Sun, Nov 26, 2023 at 5:45 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > On Sun, Nov 26, 2023 at 12:46:03AM +0100, Linus Walleij wrote:
> > > On Thu, Nov 23, 2023 at 5:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > What i would really like to see happen is that the DSA core handles
> > > > the registration of the LEDs, similar to how phylib does. The DT
> > > > binding should be identical for all DSA devices, so there is no need
> > > > for each driver to do its own parsing.
> > > >
> > > > There are some WIP patches at
> > > >
> > > > https://github.com/lunn/linux.git leds-offload-support-reduced-auto-netdev
> > > >
> > > > which implement this. Feel free to make use of them.
> > >
> > > Oh it's quite a lot of patches, I really cannot drive that because there are
> > > so many things about them that I don't understand the thinking behind...
> > > But I like what I see!
> >
> > O.K. Let me dust them off, rebase them on net-next and see what is
> > missing.
> 
> Thanks Andrew, appreciated!
> 
> I'll be happy to rebuild it on top of what you put as the baseline,
> hopefully it will help Christian with the qca8k support as well?
>

Sure thing. I can test and see if I have problem with the generic
approach.

> > You have some fibre things i don't have. I don't have a
> > machine with fibre so i cannot test that.
> 
> I can test that, the way I check for its presence is through device tree looking
> for an "sfp" phandle, AFAICT I don't see that the hardware can tell be
> when there
> is a fiber connected, but alas I don't have any datasheet.
> 
> Yours,
> Linus Walleij

-- 
	Ansuel
