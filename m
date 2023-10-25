Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1F7D77D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYW2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYW2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:28:00 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22C92;
        Wed, 25 Oct 2023 15:27:57 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so156175fac.0;
        Wed, 25 Oct 2023 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698272877; x=1698877677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpIvHM5NvuykoUDW2kRupuz5sx/Tvq7a0jlZsKkUcZs=;
        b=eWNAk+1+9NCO7Q0BFAip+sDbyQQZPat2xWXVi83UWRwnZ1Ly0js3vGVQmijzWwhGK4
         2LQyU9aXYudK1kALFtugRBIloQQAhGfCSj/MNcsSmtErCmSXmjNt2bhU4TtaQjnGwFJ/
         71SD+dmM3/cyAJRu80rBx/XqfzdIrtjrjifzvXmVEUoF7p2b7VMiQfIuWxxT/0t9MM0P
         aBbvfG/S6+r+19GKtePxZCneEUXKJpVorsb4k+ETjeMi/IRxv/xTy/3Spk1mVc5EfV6n
         jQJgaz3B2IZFyFj5dTUgn37t+F1E5w8KdhZx8FtteHRB3pnSaqZjEpgXPQSX4ptak1qL
         CVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272877; x=1698877677;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpIvHM5NvuykoUDW2kRupuz5sx/Tvq7a0jlZsKkUcZs=;
        b=Jx1fnKk70FRJ/qk0cucOTt96CH6qaoNshuJ3qqX1r9zfXFYdAD6q93B4skPzPd+mDB
         f+Y2yxGXDgpjeUhLfxR2ARBTTmqs9y2phKknT4YCyR3r8dZ1m7OO51ci56Jk2Cldg0GR
         zs3qgvYM5tZmkU3ZaJmh9A6lqifAYrE8VGBoxGmDDuxZnmyD1xbjB8h4dhyslbSQWlKy
         Yrz5mjD8TCTe8A7NjI2ZlV2TjdqdkhLqwyL0C99FetNt5JyLWsR162/+1YUkMokeTPk8
         ySDAY/b5qU/wrV1b1R31YvgNPDEYgeMhAcN8zGCGcerfKF8UxO7OBPTCK8EVxihacVRh
         1lew==
X-Gm-Message-State: AOJu0YzyHGtR/mKStNps3zpp+OEGQqwMYhkfd0EinrJc0GkAcxnoHb+5
        JEgbh+lFc6zEa6chVWp1XIEX4nRbumpplYyTKi4=
X-Google-Smtp-Source: AGHT+IGppM3tGzEymUiuG98SnROM8wXZMsAgd+v2Tnglma2FhzcDZnsttPGrnBID7W3UQdByYtn9HbwApuPSX3zdZhk=
X-Received: by 2002:a05:6871:4391:b0:1bb:a227:7008 with SMTP id
 lv17-20020a056871439100b001bba2277008mr20401190oab.3.1698272877001; Wed, 25
 Oct 2023 15:27:57 -0700 (PDT)
MIME-Version: 1.0
From:   Witold Baryluk <witold.baryluk@gmail.com>
Date:   Wed, 25 Oct 2023 22:27:20 +0000
Message-ID: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
To:     arnd@kernel.org
Cc:     Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        ilw@linux.intel.com, johannes@sipsolutions.net, kuba@kernel.org,
        kvalo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nicolas.ferre@microchip.com, pavel@ucw.cz,
        quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com, stf_xl@wp.pl
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
>
> These two drivers were used for the earliest "Centrino" branded Intel
> laptops during the late 32-bit Pentium-M era, roughly 2003 to 2005, which
> probably makes it the most modern platform that still uses the wireless
> extension interface instead of cfg80211. Unlike the other drivers that
> are suggested for removal, this one is still officially maintained.
>
> According to Johannes Berg, there was an effort to finish the move away
> from wext in the past, but the last evidence of this that I could find
> is from commit a3caa99e6c68f ("libipw: initiate cfg80211 API conversion
> (v2)") in 2009.
>
> Link: https://lore.kernel.org/all/87fs2fgals.fsf@kernel.org/
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Cc: Linux Wireless <ilw@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not convinced this should be in the same set of drivers as the
> rest, since this is clearly less obsolete than the other hardware
> that I would remove support for.

I still use ipw2200 on Intel PRO/Wireless 2915ABG [Calexico2] Network
Connection card, in my IBM Thinkpad X41 (Pentium-M 1.73GHz, Centrino
platform). The laptop is rock solid, and I use it as a backup for my
other Thinkpad. In fact is sometimes preferable to more modern machines
(IMHO X41 itself is the best laptop ever made in terms of a design).

Never had really issues with WiFi on it. In terms of speed it is neither
far or slow, but does the job anyway.

Now, I do not use this laptop frequently, maybe once or twice a month.
But that is more because in I use laptops less in general these days. Not
because the machine is not usable. I have modern SSD in it, second hard
drive, two USB 3.0 ports via ExpressCard, high res 4:3 (1440x1050)
display, full disk encryption, etc.

I would really like for this driver to stay in the mainline for another 5-10
years.

I might be interested in modernizing the driver, but I have no idea how
much effort it would be (in terms of changed fraction of code). 20k LOC is
neither small or big, and not obvious (a lot of it would be unchanged),
if it is a week of work, or months of work.

I would not have an issue with removing it, and readding back if somebody
(or me) ports it, if not for re-review from scratch concerns. If I port
it, I would not be able to do re-review, 1) out of date coding standards,
2) different reviewers, 3) I would only port needed parts, and keep rest
of the driver intact, so I would not be able to really provide much
insight. So, readding after porting might be harder than keeping and
porting.

I also used in the past other drivers you are removing (zd1201, hostap,
orinoco, rndis, wl3501), but I do not have too much worry about them, as
they are ancient, and also require ancient hardware to run.


Cheers,
Witold


-- 
Witold Baryluk
