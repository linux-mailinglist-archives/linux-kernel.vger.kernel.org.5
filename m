Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AA7C7112
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjJLPMN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:12:11 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98914BE;
        Thu, 12 Oct 2023 08:12:09 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7be61fe74so13860047b3.2;
        Thu, 12 Oct 2023 08:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123528; x=1697728328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khfGRdh12F00jlibT3/fQRqCkfRRZuJbfBIrcarozTE=;
        b=eHmrjINgob7qcXf/BNwqMyvKNDUYNB4fQZRfjO/ZOSIAyO90nb9St0tnC/N9p5+1OB
         REfxlUNEk9mSEr/d6f8sOW9XboEeytme0+5y1Donofno7AzboFjK6cYjPbz7wXXChp43
         E/UhUPiPRSlqeY0RNBs8314/DC4NoMYKLdnmU8nvSEPHKIRT/Kp5jCr8UbQZcegE9jbl
         e9L/i4eL6KKgLF8h0576afOJzJHyzYE5X5DWlNwkeN97wwn7oJ7XBgPCRCppJEWK/b1z
         XuBIgI+KRaUIO9variEHZ3aROuou0skrwr5JCsUsPvwyE1o97d6UwKLESAlnj37cdLjE
         WQog==
X-Gm-Message-State: AOJu0YwtCsteRqtCxovGXP1YhNQ1nYi4dv8P8bhElkrYERBpTVbU0vGs
        ILross/qg2w2TEePa0ZT9gKdJwO5Z67FJg==
X-Google-Smtp-Source: AGHT+IGAAdjGkg4YLukOWadNTttXvIIqtDWnqmSxmAw1Vxgi/121gqLZMiEk0I2PK3Y+/zj+fnzupg==
X-Received: by 2002:a0d:e8d3:0:b0:5a7:d0b4:983e with SMTP id r202-20020a0de8d3000000b005a7d0b4983emr7109914ywe.35.1697123528456;
        Thu, 12 Oct 2023 08:12:08 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id p62-20020a0dcd41000000b0059f61be458esm18364ywd.82.2023.10.12.08.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:12:07 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7c95b8d14so13851437b3.3;
        Thu, 12 Oct 2023 08:12:07 -0700 (PDT)
X-Received: by 2002:a81:8246:0:b0:58d:f1fe:5954 with SMTP id
 s67-20020a818246000000b0058df1fe5954mr25609250ywf.32.1697123526926; Thu, 12
 Oct 2023 08:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231010155444.858483-1-arnd@kernel.org> <2023101051-unmasked-cleaver-79b3@gregkh>
 <87y1g94szz.fsf@kernel.org> <2023101139-pyromania-game-2237@gregkh>
 <87r0m1fwg9.fsf@kernel.org> <20231011080955.1beeb010@kernel.org>
 <87sf6g2hc8.fsf@kernel.org> <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
 <87fs2fgals.fsf@kernel.org>
In-Reply-To: <87fs2fgals.fsf@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 17:11:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0P6H=pAGr_KtmecvNxwDLJXYPRbyyELXaCRhNHgzAzg@mail.gmail.com>
Message-ID: <CAMuHMdU0P6H=pAGr_KtmecvNxwDLJXYPRbyyELXaCRhNHgzAzg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
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

CC geoff, ppc

On Thu, Oct 12, 2023 at 4:46 PM Kalle Valo <kvalo@kernel.org> wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>
> > On Thu, Oct 12, 2023, at 13:47, Kalle Valo wrote:
> >>
> >> Is anyone willing to submit patches? Use wireless-next as the baseline
> >> for patches and one driver per commit, please. That way it's easy to
> >> revert later, if needed (hopefully not).
> >
> > I can do it, I've already done most of the work for moving the
> > drivers, so I just need to split up my existing patch and leave out
> > the bits that get added to drivers/staging.
>
> Awesome, thank you!
>
> > I'll also send Greg a patch to remove rtl8192u now that we know
> > that this has been broken for 7 years. Similarly, I'd include
> > another patch to remove PCMCIA support for libertas, as that
> > would otherwise be the only remaining 16-bit PCMCIA wlan card,
> > and I could find no indication of this one ever being popular,
> > unlike the USB/SDIO/SPI variants of the same device or the
> > other PCMCIA drivers.
> >
> > This would leave only a handful of wext implementations in the
> > tree: ipw2x00, ps3-gelic-wireless, staging/rtl8712, staging/rtl8192e
> > and staging/ks7010. Since ipw2x00 is apparently still supported
> > in theory and was rather popular on Pentium-M based systems 20
> > years ago, this may still need to be converted to cfg80211
> > before you can remove support for wext style drivers altogether.
> > ps3-gelic-wireless and rtl8712 are also still maintained but have
> > a much smaller user base I assume.
>
> Actually I would prefer to remove ipw2x00 and ps3-gelic-wireless as
> well. I have not seen any evidence that there would be users for those
> drivers. If we find out that there really are users I can easily add the
> drivers back. The faster we get rid of wext the better, it really needs
> to go away.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
