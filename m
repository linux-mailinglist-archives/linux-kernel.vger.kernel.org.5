Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A557BBC34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjJFP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjJFP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:56:19 -0400
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 08:56:17 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD1F0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:56:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5586:0:640:b3c3:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 6D5325F098;
        Fri,  6 Oct 2023 18:48:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2mb8353Wl8c0-bpdhOTQ8;
        Fri, 06 Oct 2023 18:48:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696607283; bh=hBdl579il4TUGabtGmXDqgjI0VAhDoml9PoRzZo90es=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=CO/AoQc74uABi0NR9Y7RtlJ8Fkk27KdxcEBZg3mzNMK849zhr6PHPux5Oqt7fSf7P
         cAVrsDm2VDqC9CLA8l+Ldu7YmDk/z1RDC4f491gKamdDsbhKNKM/ggA4j584GMadGv
         OhsGbgIY6LsJVrAE/6JQbt85TKE4rZ1W5/xCkhiA=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
Date:   Fri, 6 Oct 2023 18:48:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 18:34, Hector Martin wrote:

> For better or worse, if nobody else does, I'm willing to sign up to
> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
> BCM4387, BCM4388 - that last one I have bringup for downstream, just got
> it done this week) and partially BCM4377 as a bonus (since I have access
> to an older Intel Mac with that one, and already did bringup for it,
> though my access is sporadic). I'm already playing part time maintainer
> anyway (other folks have already sent us patches I'll have to upstream),
> and we need this driver to keep working and continue to support new chips.

Good news. Would you capable to consider some generic (not hooked to any
particular hardware) things like [1] ?

[1] https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantipov@yandex.ru/

Dmitry
