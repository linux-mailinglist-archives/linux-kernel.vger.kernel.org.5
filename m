Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED7782757
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjHUKqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjHUKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:46:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9663DC;
        Mon, 21 Aug 2023 03:46:12 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76daeaded2aso4071185a.3;
        Mon, 21 Aug 2023 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692614772; x=1693219572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91+NJvb3XeUy21mbV0egFTNhqjvg3UgNfxu2JF/jzAs=;
        b=iybxIAy1nVsUJ21WCTmZRj+r16uzxExYBDSin/BR3sN0NAlpR6QfOZvV9Luv2XV5Sq
         9bRlqoRtotuBnOZY1AzI68w3mF4mrtzF0vz7OCBK4GtBkzG55zKGkN0prHFIN6G8rsKP
         LgaGdwrm6HTP97Hj8WKuwvZRdexIfTscvlPNhT+HaE6C1gZzEIFl8dEbxZM+YnRTGA/9
         LDGhkuISyCs9A8ozp0c2VSt85IgrtUREmsYa0rfQ06S2RFK7WG0NZQ3cW4PXvkT5Nl5/
         Dn26VxENC8avfYTVgKNblOYPsWAaDzs5WC4dvOLbMsC3XhJpwmpCzJJppDya6WblMaqi
         fs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692614772; x=1693219572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91+NJvb3XeUy21mbV0egFTNhqjvg3UgNfxu2JF/jzAs=;
        b=VJesPdYZnZnGVFBYnNtCHL27eF7vNuhb2H2c7+Q2qAU94NknN+umEBHE8/tHaooTiz
         q6rKdJm72L6r7tDpYqbe+Id30tMYlLA5pMK2VEa9MWp0j49efhEccWUdbOEPLqslmVMI
         SJMv+K4SE74b4BY6POyZhptBH66WHJIK7wkgImJpDqbnnsrDXMAgzAQeJQj+laE6/O5C
         ZLflqumrWBaKI1pQ6Jnj77+X29AYHDZkN2xxTJyNweK2cvgeuiVWPpBWPoJKTk1mfUAS
         wgNia+8iyCWjaeUs1ODol4I3fZnjLtyCL7fDPVc69UP+xfuxte3oFJMNKAmUikvbSwQy
         PxZw==
X-Gm-Message-State: AOJu0YzxOICLJf7IOB1KMgkxQbi8nCMQwaIZdy0lI8KpIGDl1igeIdef
        rOm3RGeUnzuqXuXIuxdKjkvY6RVR4OBadngylxY=
X-Google-Smtp-Source: AGHT+IF7uB7Vd8228/OsdKlUTAWtHZWG03cwsC9jguXp+IBvSvrAdw16P2M7u8CrkTRzfJNPlbLm97u0VKDH88ZvX3s=
X-Received: by 2002:a0c:e1d4:0:b0:64d:254a:63dc with SMTP id
 v20-20020a0ce1d4000000b0064d254a63dcmr6699128qvl.19.1692614771594; Mon, 21
 Aug 2023 03:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230611080505.17393-1-ansuelsmth@gmail.com> <878rcjbaqs.fsf@kernel.org>
 <648cdebb.5d0a0220.be7f8.a096@mx.google.com> <648ded2a.df0a0220.b78de.4603@mx.google.com>
In-Reply-To: <648ded2a.df0a0220.b78de.4603@mx.google.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Mon, 21 Aug 2023 12:46:00 +0200
Message-ID: <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Steve deRosier <derosier@cal-sierra.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno sab 17 giu 2023 alle ore 19:28 Christian Marangi
<ansuelsmth@gmail.com> ha scritto:
>
> On Fri, Jun 16, 2023 at 01:35:04PM +0200, Christian Marangi wrote:
> > On Fri, Jun 16, 2023 at 08:03:23PM +0300, Kalle Valo wrote:
> > > Christian Marangi <ansuelsmth@gmail.com> writes:
> > >
> > > > From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> > > >
> > > > Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984
> > > > based chipsets with on chipset connected led's using WMI Firmware API.
> > > > The LED device will get available named as "ath10k-phyX" at sysfs and
> > > > can be controlled with various triggers.
> > > > Adds also debugfs interface for gpio control.
> > > >
> > > > Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> > > > Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
> > > > [kvalo: major reorg and cleanup]
> > > > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> > > > [ansuel: rebase and small cleanup]
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> > > > ---
> > > >
> > > > Hi,
> > > > this is a very old patch from 2018 that somehow was talked till 2020
> > > > with Kavlo asked to rebase and resubmit and nobody did.
> > > > So here we are in 2023 with me trying to finally have this upstream.
> > > >
> > > > A summarize of the situation.
> > > > - The patch is from years in OpenWRT. Used by anything that has ath10k
> > > >   card and a LED connected.
> > > > - This patch is also used by the fw variant from Candela Tech with no
> > > >   problem reported.
> > > > - It was pointed out that this caused some problem with ipq4019 SoC
> > > >   but the problem was actually caused by a different bug related to
> > > >   interrupts.
> > > >
> > > > I honestly hope we can have this feature merged since it's really
> > > > funny to have something that was so near merge and jet still not
> > > > present and with devices not supporting this simple but useful
> > > > feature.
> > >
> > > Indeed, we should finally get this in. Thanks for working on it.
> > >
> > > I did some minor changes to the patch, they are in my pending branch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=686464864538158f22842dc49eddea6fa50e59c1
> > >
> > > My comments below, please review my changes. No need to resend because
> > > of these.
> > >
> >
> > Hi,
> > very happy this is going further.
> >
> > > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> > > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> > > > @@ -67,6 +67,23 @@ config ATH10K_DEBUGFS
> > > >
> > > >     If unsure, say Y to make it easier to debug problems.
> > > >
> > > > +config ATH10K_LEDS
> > > > + bool "Atheros ath10k LED support"
> > > > + depends on ATH10K
> > > > + select MAC80211_LEDS
> > > > + select LEDS_CLASS
> > > > + select NEW_LEDS
> > > > + default y
> > > > + help
> > > > +   This option enables LEDs support for chipset LED pins.
> > > > +   Each pin is connected via GPIO and can be controlled using
> > > > +   WMI Firmware API.
> > > > +
> > > > +   The LED device will get available named as "ath10k-phyX" at sysfs and
> > > > +           can be controlled with various triggers.
> > > > +
> > > > +   Say Y, if you have LED pins connected to the ath10k wireless card.
> > >
> > > I'm not sure anymore if we should ask anything from the user, better to
> > > enable automatically if LED support is enabled in the kernel. So I
> > > simplified this to:
> > >
> > > config ATH10K_LEDS
> > >     bool
> > >     depends on ATH10K
> > >     depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
> > >     default y
> > >
> > > This follows what mt76 does:
> > >
> > > config MT76_LEDS
> > >     bool
> > >     depends on MT76_CORE
> > >     depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
> > >     default y
> > >
> >
> > I remember there was the same discussion in a previous series. OK for me
> > for making this by default, only concern is any buildbot error (if any)
> >
> > Anyway OK for the change.
> >
> > > > @@ -65,6 +66,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
> > > >           .dev_id = QCA988X_2_0_DEVICE_ID,
> > > >           .bus = ATH10K_BUS_PCI,
> > > >           .name = "qca988x hw2.0",
> > > > +         .led_pin = 1,
> > > >           .patch_load_addr = QCA988X_HW_2_0_PATCH_LOAD_ADDR,
> > > >           .uart_pin = 7,
> > > >           .cc_wraparound_type = ATH10K_HW_CC_WRAP_SHIFTED_ALL,
> > >
> > > I prefer following the field order from struct ath10k_hw_params
> > > declaration and also setting fields explicitly to zero (even though
> > > there are gaps still) so I changed that for every entry.
> > >
> >
> > Thanks for the change, np for me.
> >
> > > > +int ath10k_leds_register(struct ath10k *ar)
> > > > +{
> > > > + int ret;
> > > > +
> > > > + if (ar->hw_params.led_pin == 0)
> > > > +         /* leds not supported */
> > > > +         return 0;
> > > > +
> > > > + snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
> > > > +          wiphy_name(ar->hw->wiphy));
> > > > + ar->leds.wifi_led.active_low = 1;
> > > > + ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
> > > > + ar->leds.wifi_led.name = ar->leds.label;
> > > > + ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> > > > +
> > > > + ar->leds.cdev.name = ar->leds.label;
> > > > + ar->leds.cdev.brightness_set_blocking = ath10k_leds_set_brightness_blocking;
> > > > +
> > > > + /* FIXME: this assignment doesn't make sense as it's NULL, remove it? */
> > > > + ar->leds.cdev.default_trigger = ar->leds.wifi_led.default_trigger;
> > >
> > > But what to do with this FIXME?
> > >
> >
> > It was pushed by you in v13.
> >
> > I could be wrong but your idea was to prepare for future support of
> > other patch that would set the default_trigger to the mac80211 tpt.
> >
> > We might got both confused by default_trigger and default_state.
> > default_trigger is actually never set and is NULL (actually it's 0)
> >
> > We have other 2 patch that adds tpt rates for the mac80211 LED trigger
> > and set this trigger as the default one but honestly I would chose a
> > different implementation than hardcoding everything.
> >
> > If it's ok for you, I would drop the comment and the default_trigger and
> > I will send a follow-up patch to this adding DT support by using
> > led_classdev_register_ext and defining init_data.
> > (and this indirectly would permit better LED naming and defining of
> > default-trigger in DT)
> >
> > Also ideally I will also send a patch for default_state following
> > standard LED implementation. (to set default_state in DT)
> >
> > I would prefer this approach as the LED patch already took way too much
> > time and I think it's better to merge this initial version and then
> > improve it.
>
> If you want to check out I attached the 2 patch (one dt-bindings and the
> one for the code) that I will submit when this will be merged (the
> change is with the assumption that the FIXME line is dropped)
>
> Tested and works correctly with my use case of wifi card attached with
> pcie. This implementation permits to declare the default trigger in DT
> instead of hardcoding.
>

Any news with this? Did I notice the LEDs patch are still in pending...
Since I notice the process is a bit slow I wonder if we can also queue
the 2 patch i attached in the previous email so we can speed things up?
