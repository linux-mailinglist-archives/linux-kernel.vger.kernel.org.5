Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53357C71B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379454AbjJLPjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347155AbjJLPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:39:43 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C99B8;
        Thu, 12 Oct 2023 08:39:41 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso685668276.0;
        Thu, 12 Oct 2023 08:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697125181; x=1697729981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4kyj9ZjW+gYqmJqenBaJFDkWv6wTV1m+k4AYZcQP5U=;
        b=Y485q4qrpddHaroBj2bBK8HtvIGSkf0jQUglHo+ijsrWX3FacyHS21tP/YLT9qc4gA
         duc+P2NIYI5DjlDSA09j190GBBTnR6VNmRtRiNfmBNYYzzVqdDSw3ahKKYMKqTTCwrOd
         L4SS8VZSM+NYEk6LKgQF4B8bMI1JDznxgnPGRA5ODcA3GTwDcprSWhglEzi+GpwCvLxj
         Xi1v4b0nxN3HcJ1j63V+CPiATyj+jf0+cq7apUmyGgsK7dedX7uEQc3m3lDmBZLANvsr
         ZDnRg1PZ0gt5bQM27Y8kBKRsE0p+1emjoTdfv5gCt41a6oHBpAN4xAfYdE2t2GfeF4JJ
         nVNQ==
X-Gm-Message-State: AOJu0YwoZHJ55xTSaqH2xJcpxzCEMDkiArywhzhVXCniarTG2ftP56a+
        TM9eJZNThaps+7xHRGBjDIJ5MjB5fmRDgA==
X-Google-Smtp-Source: AGHT+IHaPF7JLMVJohv1c+pvVujAPRbQ9QqRJJqjUSIXufp+uzyePS1WhCqd8F08pqLLiay0DXcW7g==
X-Received: by 2002:a25:42c2:0:b0:d9a:4b66:72a4 with SMTP id p185-20020a2542c2000000b00d9a4b6672a4mr6055387yba.31.1697125180804;
        Thu, 12 Oct 2023 08:39:40 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id u4-20020a258404000000b00d72176bdc5csm27732ybk.40.2023.10.12.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:39:40 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a4c073cc06so19269977b3.1;
        Thu, 12 Oct 2023 08:39:40 -0700 (PDT)
X-Received: by 2002:a81:49d7:0:b0:59b:5255:4882 with SMTP id
 w206-20020a8149d7000000b0059b52554882mr12310427ywa.20.1697125180367; Thu, 12
 Oct 2023 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231010155444.858483-1-arnd@kernel.org> <2023101051-unmasked-cleaver-79b3@gregkh>
 <87y1g94szz.fsf@kernel.org> <2023101139-pyromania-game-2237@gregkh>
 <87r0m1fwg9.fsf@kernel.org> <20231011080955.1beeb010@kernel.org>
 <87sf6g2hc8.fsf@kernel.org> <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
 <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
In-Reply-To: <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 17:39:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
Message-ID: <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, Oct 12, 2023 at 5:28 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2023-10-12 at 16:36 +0200, Arnd Bergmann wrote:
> >
> > ps3-gelic-wireless
>
> Didn't Sony disable Linux on PS3 eventually? Though maybe someone still
> has some devices with old software.

If you didn't update the firmware, you could keep on using Linux.

And people may have found a vulnerability in more recent firmware
versions that allows them to run custom software.
I don't know, it's been +10 years ago I touched a PS3 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
