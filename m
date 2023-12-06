Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906F80786C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379315AbjLFTNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379234AbjLFTNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:13:38 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B07D45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:13:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so64319a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701890023; x=1702494823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9JTl2Ob5990E2xo2ynBpvDirXKr70Qj24AYoBKEABw=;
        b=H6smL0l6yi7qXtoQMqD3d7rlecjM9KbFlvKR5aoYnz001g+ZjM3xNJPnf2ijR+HTok
         bZj+HZUin8nTk5E87k0xmD8Rc5RZPRTJHnaXhgUzR+kNdhmG0Ri79iGCwh+hvGWpfxaP
         ITEYtDO/OaMEBthdrtXUFwcpSEZNgxnJ+hN5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890023; x=1702494823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9JTl2Ob5990E2xo2ynBpvDirXKr70Qj24AYoBKEABw=;
        b=qMiWbTwl8MvJZKV/FHEruzrRF3PCQKUsy+9hPnG4gbZHc7/BNIUPC690GxmQGqWLlN
         8GLH7R9Gl+tj4C8tqOl9LVG2XUBXKzkKtMfpd1KUAnkS1we8OVBznV5PWUgo3yIEEA7l
         xlk01oZhmJX5uRj3m7T3pr/VVzkAMDaMm+NRvkcM7lcamt2wFnZhDEcQvpX3gCuS/2h9
         eoGl2QueGOTr/8x07gmiiAxPMeHAFaLldgNqtl1XIQhAP7r9trakzQ4OlOzAXTkpTFLp
         NBA1S+uKKXmdp3UKzSm0QZnkcfgvI8qP7JIzDji/0EW0PFA92/FRrXSiKBiuLYEX1+ng
         0jHw==
X-Gm-Message-State: AOJu0Yz+v6610c1q2+ZbjrmCJPXbOxA8+TYHe33+DhEO1ebqNP6I6nFc
        v2cQuKwAhuT4pKKRiYTW10Sm6A==
X-Google-Smtp-Source: AGHT+IH7OUxc5WA/EaAqeHciu7u12n2fYF7bSOYPD35YM1E/5mRG8hyDMQjaN11W3CPwVzZxpjYK/g==
X-Received: by 2002:a05:6a21:8195:b0:18d:c72:63b3 with SMTP id pd21-20020a056a21819500b0018d0c7263b3mr1518317pzb.16.1701890023286;
        Wed, 06 Dec 2023 11:13:43 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id y13-20020a056a00180d00b006cde06a7b66sm320845pfa.172.2023.12.06.11.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:13:42 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:13:41 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Message-ID: <ZXDH5S7rM32y48Fc@google.com>
References: <20231205210237.209332-1-knaerzche@gmail.com>
 <ZXDHgo5QnZjb237S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXDHgo5QnZjb237S@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Altering CC list; sorry, I didn't notice the RESEND at first)

On Wed, Dec 06, 2023 at 11:12:02AM -0800, Brian Norris wrote:
> On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
> > This patch restores USB8897 support which was removed with
> > Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")
> 
> Did you look at the reason for that removal?
> 
> "if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
> sometimes mwifiex_usb wins the race even if user wants wlan interface to
> be on PCIe and USB for bluetooth. This patch solves the problem."
> 
> That sounds like a legitimate problem, even if the solution isn't
> perfect. Do you have any alternatives?
> 
> I don't have such hardware, so I don't know its behaviors nor can I test
> it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
> somehow.
> 
> > There are quite some devices which use this chipset with USB interface.
> > The firmware still exits in linux upstream firmware repo and this simple
> > patch is all what is required to support it in upstream linux (again).
> > 
> > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > ---
> > Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
> > has one any of those boards soldered to the onboard USB Host controller.
> > Geniatech has some boards [0], [1], [2] (maybe more) which have this
> > variant soldered the same way. (optional)
> > I've also read that "Xbox Wireless adapter for Windows" uses this chipset
> > (unverified).
> > I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
> > PCIe variant of this chipset: It would be great if the firmware
> > for USB variant could get an update too, as the one which we currently
> > have is quite old - version 15.68.4.p103, while other have some 16.*
> > firmware. 
> 
> The old maintainers here seem to have gone AWOL, so I wouldn't hold my
> breath on getting any support from them.
> 
> Brian
> 
> > [0] https://www.geniatech.com/product/xpi-3288/
> > [1] https://www.geniatech.com/product/xpi-imx8mm/
> > [2] https://www.geniatech.com/product/xpi-s905x/
> >  
> >  drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
> >  drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> 
