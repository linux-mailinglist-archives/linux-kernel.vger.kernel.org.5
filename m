Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738AD7DF276
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376308AbjKBMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbjKBMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:32:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2225F137;
        Thu,  2 Nov 2023 05:32:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso1440639a12.3;
        Thu, 02 Nov 2023 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928353; x=1699533153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pM8zlt4obzxoJwrjk3uA0SX3/4WusjoDm/ScOgDY3EQ=;
        b=efmsZab6cESdm9WKcEjMxynzAg0I/RqXRTgAXIEuHgc+cKkoLjgna59bd0+C+HXlc7
         q0i5Z97FbVP7InT9Dz6vgyBaBKSOgxT88ls71Rd4W/26R2v53hydht8eyKo0+BNii7ks
         i3lVg5jVREmrvypjFxx7b58kC0z2ksxLUcY7PHAkBVoeLlUQMcjoh8iCOZr7Sokevryu
         lbqfdpcg5MFUvI+OctynNmTadQrUlWNcxGYK2fklzp5J7j4+0KIm42k5TQwElw9JoyQe
         7CbH8ITZya8K2iuZytuT60IWtwSR/Bpe4njbRgMKOo/9yz8pi3FhaudtRPgB7DwTNn8J
         +jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928353; x=1699533153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM8zlt4obzxoJwrjk3uA0SX3/4WusjoDm/ScOgDY3EQ=;
        b=l635X4WuRXvlPL8PL5uFZNn6688uvHMLa7XF4M4YcjGHSPjora38HoHUDVtZr+g/0G
         87oojnyUhWpTPg4tFe21PqxkF0go46+3Ad2siFJtfFZjEqECK1RHRpmufFT9eLlZ5mK9
         BLppb/bFKjgz9kgmqRtlYjp81V30jBas752QwGsSkzQMEB48RAgNq/brpwwbvX0Jgmrx
         EIEHHrQo0qm9opV7Sjkas+R9KA2B+dcHaQkpyWBDF+D1ulGtvoOH/M+UnQ7iVsp3NVcm
         2NbECBK5XqqmA/j2h7mOevUymFvi0jb83C0LKqlAtIZugCMYrJdQLGOYnlS8JQ4iV74b
         muXg==
X-Gm-Message-State: AOJu0YzhayVrZVBgN5CgoKTBvRUYwPyXR9MDz0qPfQXzKJo997e5fIoI
        rI7wrw7b317fWcTUaU6MKjM=
X-Google-Smtp-Source: AGHT+IGpWEQw/lrAY3504ljM8AOISqQkQ25WLINqL0dId7TMKisUKJ2cfbrp1dPqiVaJUysFZFPlCQ==
X-Received: by 2002:a17:907:608a:b0:9a5:7f99:be54 with SMTP id ht10-20020a170907608a00b009a57f99be54mr4395989ejc.67.1698928353180;
        Thu, 02 Nov 2023 05:32:33 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170906ca4300b009930c80b87csm1104868ejb.142.2023.11.02.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:32:32 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:32:30 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102123230.luoyrh2j4r4bbwjf@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <20231031163439.tqab5axhk5q2r62i@skbuf>
 <CACRpkdb=16uLhsXhktLCwUByDAMv9Arg2zzCA+oJW2HBJ35-Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb=16uLhsXhktLCwUByDAMv9Arg2zzCA+oJW2HBJ35-Bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:02:29PM +0100, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 5:34 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > So on the gemini-dlink-dir-685.dts platform, you can also use &gmac1 as
> > a plain Ethernet port, right?
> 
> As a port it exist on the SoC yes but it is not connected physically
> to anything.
> 
> &gmac0 is connected to the switch, and the switch has all the PHYs.
(...)
> If you by remote end mean the end of a physical cable there is
> no way I can do that, as I have no PHY on gmac1.
> 
> (I don't know if I misunderstand the question...)

No, you aren't.

> But I have other Gemini platforms, so I will try to do it on one
> of them! Let's see if I can do this thing....

Ok.
