Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83A770E38
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjHEG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHEG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:57:15 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E665E70
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 23:57:14 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4475df91bb1so1243833137.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691218633; x=1691823433;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GakJ4004HfKzStoDWvRep5JehYxyKkuk704LbpteieY=;
        b=iXBxP50Z/hxP49Fr1mP4ijKIdFt/Wca0mrpbiwcgNitt4mM0w/27tDndE7fedOi+fV
         X8RBY/eFIIrVU0tcQ9uiBw7+rvw7bzf8kgcCLHginYB6tqEfTm6Hmp4EGx4/qYsZrf+b
         vUfqarqvWrTEH5wemNLD7aGkB1zWAZxLI4HB+4emq7fYwEKSQ6EzliqIFDx8AM8zl5p9
         guEdKZZ0/o3Sq4G0XPzmD2VVAD1qd4XsbRr2J+OftEDTAoKUehZeLxpQcHrYPdK1KzIL
         c/IxVaztYohQe7k8/+dHV/jeLdE6BdKTD/pcBCLgi5TlR70HI0frWYUogaQh+PN5Ch5c
         nY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691218633; x=1691823433;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GakJ4004HfKzStoDWvRep5JehYxyKkuk704LbpteieY=;
        b=cevQ7Q9SktepX2lz3cSaNwhwdraNVfq2eBuAzWvh3G5rHaWEYhTiX2ICKqfCpdEZcz
         EyOyZpUkTd+IY2xO+orZRyj8DO78T/+jBwvvXb7r394OuwFHh/PUU6H7P+tADSlE/plC
         ujV3eKRT9UpDFPZAkdpf7nx1Qp9+W6yM9WL7z7XuGM65ZHiHiyebplodzo1xpkKI/tHG
         2Bi/g5UpfyjMYkkXUsH7mDDJOuctw1ZevRejqM6zoOmBJS7t3yFFaZz8dsUXN11t+ONn
         TL0SuXPnkZyFoL1UR6FoEIHNjU9dy0g8lokD/73fplPHpy17Vbgun8gddDN9/7wI3dcE
         hIvQ==
X-Gm-Message-State: AOJu0YxYXO8DkRwf73yfNyH1AVzNsRJ/36CunIE2sWhscmo9X/ir0KUF
        Y2xSMFJB7hnikdjEGIVhaFJX0jd9ehpc8dwEftpOyA==
X-Google-Smtp-Source: AGHT+IGJSssBp6wvD/ScMXX2ZJ5l6Cgn5Cbf4aMBixrBRvq30NTEpF11cjhncxgjo4CIKM5TaJkCDGafT0aOC6Zh/tA=
X-Received: by 2002:a1f:bf0e:0:b0:487:177a:d0f8 with SMTP id
 p14-20020a1fbf0e000000b00487177ad0f8mr2419082vkf.1.1691218633382; Fri, 04 Aug
 2023 23:57:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 23:57:12 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <ZM17VKzDBdm4uMNY@shell.armlinux.org.uk>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com> <ZM17VKzDBdm4uMNY@shell.armlinux.org.uk>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Sat, 5 Aug 2023 02:57:12 -0400
Message-ID: <CADyTPEyqG7D-_iuo+5WFGhhidK7p_fmvDhbgz05xogSU042Uag@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-04, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> I think we need to rewind a tad.
>
> My understanding is that this uses the Cadence macb driver.

Correct.

> In your original message, you said that the ethernet driver wasn't
> being bound to the driver.
[...]
> So, I think that the deferred probing has nothing to do with PHYs, and
> that's just a wild goose chase.
>
> I think instead we need to be concentrating on what's going on with
> the ethernet driver, and why the ethernet driver is deferring its
> probe. Is macb_probe() getting called at all?

I added some prints to the driver.  The macb_probe is called five times
on this one device initially at boot, then ten seconds later it is
called one last time, returning -EPROBE_DEFER each time.

> How far through macb_probe() do we get before we defer?

The result is the same for all six calls.  The macb_mdiobus_register
function returns -EPROBE_DEFER, which comes from the topmost call
to of_mdiobus_register within that function.  That is, this is the
part that returns -EPROBE_DEFER:

	child = of_get_child_by_name(np, "mdio");
	if (child) {
		int ret = of_mdiobus_register(bp->mii_bus, child);

		of_node_put(child);
		return ret;
	}

> I think those are the key questions that need answering.
>
> Maybe, if you can get access to the machine while the driver is
> deferring, /sys/kernel/debug/devices_deferred might give some
> useful information, but that's just a hope.

This just contains one line:

  ff0e0000.ethernet

which is the name of the ethernet device that is not working.

Thanks,
  Nick
