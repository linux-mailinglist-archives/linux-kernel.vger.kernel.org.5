Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C3769730
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGaNIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjGaNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:07:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F510DF;
        Mon, 31 Jul 2023 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690808836; x=1691413636; i=deller@gmx.de;
 bh=I5E7In3qLeawhm32r5BW4CB4+4g3GLRaXOk7wIj51uQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jy4RS8jDrPWTY6SPcrgNBJ1FF1cWboSWULhoDUdhJmNGCdgEyaKuo0336hWU3juf3tLZ3vJ
 dzDKhqe6J8yuaOhl5K5WiapKQZCE9sukFIqeizRf+mScsK/loIAcHnYzApgG5puLbS96ynImV
 9C8o+VgFoDF/0G54ZDu27FXqDdwfWHPe3yX2tJ+vrRHBol0cwG/VwRFUZe5Masxe0xpweZkXB
 oQzG05NQS5T6sx8OY62CkxgPaF5OQ6AmoBgiSaTRJlGxg4VEzb25L3a6yorOjqEajLkf/QvOx
 C9j+101Nsad20clG95wdIH2KluYlnBYQwUHguXtTobC2NgvF4Wrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1pwtId2EpP-00gnhA; Mon, 31
 Jul 2023 15:07:16 +0200
Message-ID: <0cb2ab66-ca30-b2ab-47f7-04208b2400cd@gmx.de>
Date:   Mon, 31 Jul 2023 15:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fbdev: fbmem: mark registered_fb static
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230714003748.91129-1-minhuadotchen@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230714003748.91129-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yveMOZcZH+xrsKsZ6Pi0xpCrONbM7Mh2l8rwBB+bHzDNdZPfLPO
 KeuC8wh1lMClf4wil/HxE7bv8ROOsclvZSc7SbCBxYkCFjLF/FqKAimjnT/+t7pplEMtpr1
 O9abhaQGAaB/xjU8ymui+4ozryAHXFx4nW2pHsriT6bqdsojdrVzbzS9hIkA0BeXxPEePix
 ILKK7B5K/u7hhFTusq9Pg==
UI-OutboundReport: notjunk:1;M01:P0:8SGNccr63Dg=;iqSetT1mEEkMwDOYOlNV+x50HA5
 94myZ1MfqzceDvtuJCPoAV7EbJquvxs8TIZOOUO9YAwqNFYqSUta47+S+0+MsfVqGGXpH2h84
 xKNjlEaUM1uohHMC1eOzameC0i1XfyjFFhzhygyjsaYjNlBFPvr19t/spzsp5fFbV3HbIyL7K
 7JN+mOujNxIflMn4F25/TBRL6AO/BuMqPZRBL8/Dt08DjKqkVZbw/JqXG50kqjNWNfV3zj5vI
 yoFGJ7IwJw/kFHeRO0qZsWiGgipDGU7xebMme6buuSjKISoqA3AsjcXpblXYGKgsGWAwjP8PE
 Th4bGivCUcjGz1TfSst70Z8FnFrCA7/aXCWm0C49AlFJf+482x7MK5usdZuGZnHaJQTaaGMux
 uIs3U8Jg4V2XGH94KLgckEKsMTLyqw6HteHJ9YAFrBeXKRc6Vf8jA86z3o79c3Kgkmwq7tTXT
 gEHjYaIgO7cYC7wr7PuyG0rl8fA5Vxv7Z7h7y4gup0rqJNtwjJf+CcPN+EaggfN3uoVXcGH0n
 xcxUVyClKD0eDeVvp4+i+NysAxTqYK5JkWY2Fxekbrj/WJmdQfpf+QS4aBIHGykpcARWxt1ac
 wbilIg1xfU9ZCwuc1Of99q+DMjHDM5zWB4TwQl0mW7x9JUARYLnQfbQNo9RMwWRzwYCFiesVQ
 J0FN9Z4Ema+nOAelOVjJKMT/tD90bmqKkjVgceOL4P7pkqGuvK3qYYuHS2BL66gcBIyQh+Xjx
 GNXp5PJRJt/dPJNONThyKMvJBbZWE5EFYKi2q3bT/8kf87zo1rzCfiyaE8wnqdn5ulT12Q1+G
 ooqmWcx4bYiP83HqtMIEV4UuWy1YnxAp5S1XLfHOTS1bFenHUgn5+Utpl4crTKkA+km8Z6/nw
 CSJvcGrZ90mnDICj6QSKVfH4zuleJ3jvFSy2Qc0X4ZAs/ubkmWUAv7THHkIOMNw6vGkLIDUDV
 fWgheuawauKKUgBy8Si/qpr+Ez0=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 02:37, Min-Hua Chen wrote:
> Mark registered_fb, num_registered_fb, fbcon_registered_fb, and
> fbcon_num_registered_fb static to fix the following sparse
> warnings:
>
> drivers/video/fbdev/core/fbmem.c:51:16: sparse: warning: symbol 'registe=
red_fb' was not declared. Should it be static?
> drivers/video/fbdev/core/fbmem.c:52:5: sparse: warning: symbol 'num_regi=
stered_fb' was not declared. Should it be static?
> drivers/video/fbdev/core/fbcon.c:105:16: sparse: warning: symbol 'fbcon_=
registered_fb' was not declared. Should it be static?
> drivers/video/fbdev/core/fbcon.c:106:5: sparse: warning: symbol 'fbcon_n=
um_registered_fb' was not declared. Should it be static?
>
> No functional change intended.

num_registered_fb is still used in:
drivers/staging/olpc_dcon/olpc_dcon.c:  if (num_registered_fb < 1) {

Helge
