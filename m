Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28E7807869
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379262AbjLFTMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379234AbjLFTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:12:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FECD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:12:06 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so67070a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701889925; x=1702494725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKXwDoSk6eUw/PYkuaUJ/DPKIhb1MBkA5JKGxmqSVm0=;
        b=dP62dgctc5dJOsUJ+PFQLCJfwenf3L/GUC2WUqdy0Xhdah+SYLgm+DUm3wvokHMrLh
         hCCzgwj6kcSaw3KANT6Uz2KMYnwsHSHq6+zLh1gXCXwWvU/YXtKwhkM3a+oOsfWlQH21
         JsURo4naAGz2Y+/rHfM/kE4vst0slvH5nKbao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889925; x=1702494725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKXwDoSk6eUw/PYkuaUJ/DPKIhb1MBkA5JKGxmqSVm0=;
        b=w5ciGZCIdRdu/eSuaxpYZRQbvaY45YkzD4pHdX5JKEc26aedrUVTEvbSkXGq7Y9DAh
         LFzrkhoqkweqzzWtkhjyvcabUIKnvCYD06bDL1mseYG8HMSqpPJmDgHAC+bEXquOtyzC
         j34ubB+cag9cUzmsWsIyLyQOtmo4qcU8s0BhW1463TtwvBOlwbbftjUtWAGvSOb16VNg
         0+eYWBH3lsdiWDyW7tkcewOp2sQcHFBtmdj3bXJqKibwCbNklUckmGssHoGuICVEIDiE
         4Gc7SBs4Mvctq2X7sUF2idUGjsiXMRyB57UUCBMTBnGXp0kz2sLsqlDVPRqvClSojeBJ
         wHlg==
X-Gm-Message-State: AOJu0YwcpKx3yZ5MkycAURYkfH/Le9D0i4ZBq0i9apRGCLj3Yao2ATLf
        WrtYjNpfDFFKxUjw6c7+EXRQLA==
X-Google-Smtp-Source: AGHT+IGdJRzVucMlxYBD9wNKRYWyoxQf1P8oLxsAK6R5Gjm4KiXF/9EzQwaztA006gC8JiiBA7SkyQ==
X-Received: by 2002:a05:6a20:938e:b0:18f:97c:8a37 with SMTP id x14-20020a056a20938e00b0018f097c8a37mr1695396pzh.98.1701889925521;
        Wed, 06 Dec 2023 11:12:05 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id k15-20020aa7998f000000b006ce742b6b1fsm330430pfh.63.2023.12.06.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:12:05 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:12:02 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Amitkumar Karwar <akarwar@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Message-ID: <ZXDHgo5QnZjb237S@google.com>
References: <20231205210237.209332-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205210237.209332-1-knaerzche@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
> This patch restores USB8897 support which was removed with
> Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")

Did you look at the reason for that removal?

"if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
sometimes mwifiex_usb wins the race even if user wants wlan interface to
be on PCIe and USB for bluetooth. This patch solves the problem."

That sounds like a legitimate problem, even if the solution isn't
perfect. Do you have any alternatives?

I don't have such hardware, so I don't know its behaviors nor can I test
it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
somehow.

> There are quite some devices which use this chipset with USB interface.
> The firmware still exits in linux upstream firmware repo and this simple
> patch is all what is required to support it in upstream linux (again).
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
> has one any of those boards soldered to the onboard USB Host controller.
> Geniatech has some boards [0], [1], [2] (maybe more) which have this
> variant soldered the same way. (optional)
> I've also read that "Xbox Wireless adapter for Windows" uses this chipset
> (unverified).
> I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
> PCIe variant of this chipset: It would be great if the firmware
> for USB variant could get an update too, as the one which we currently
> have is quite old - version 15.68.4.p103, while other have some 16.*
> firmware. 

The old maintainers here seem to have gone AWOL, so I wouldn't hold my
breath on getting any support from them.

Brian

> [0] https://www.geniatech.com/product/xpi-3288/
> [1] https://www.geniatech.com/product/xpi-imx8mm/
> [2] https://www.geniatech.com/product/xpi-s905x/
>  
>  drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)
