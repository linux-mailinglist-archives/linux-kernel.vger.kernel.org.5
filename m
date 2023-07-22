Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D037075DD0A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGVOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGVOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:54:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F01FD2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:54:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E6E235C00B0;
        Sat, 22 Jul 2023 10:54:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 22 Jul 2023 10:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1690037680; x=1690124080; bh=1yjiORy39pCWYuOJ1JsVJ5WcE
        LO0kW+BzYweY2Xf8Vg=; b=ZY3H8DSgfWOUMsJZB4uOmwJTdjArYs4nZ/6P3NS1a
        tuRxG4cCs0wgnOColy+L83kSHBI3H9R2QDXpfRP1dNHUIVK/WIopuarEIhXivLLK
        Vbm8S+TBD3oXgd9roJFEI0ZVgkaRff9F2COy1idU9Olnk6MJCup9Ir2qGfEbF77z
        ZFNZlZaA2rpjTvZLXM9lWcIFieH1bXE9hfFEgbzgdrwKNo5pHVYt76WmNbAEV9TE
        pZ2BLs90CFgFOblfwgjNVDv2U9TYH/nFQKFngG1s70nehxOYUKvknKWQbHjKwNJQ
        omsqxxTnT2oTSzgir/JtO0/KcQDlIJkOL03X9XlW2oUpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690037680; x=1690124080; bh=1yjiORy39pCWYuOJ1JsVJ5WcELO0kW+BzYw
        eY2Xf8Vg=; b=OVr0r+yqBRbCZZr0tv1+OCUxSNzIfJiCaaRHNBDUztRRKiXb3po
        I/L7DkrnEqK+BpECTN766vK324Xk6KUy6YRycB1R0wcx59/0GmshprzqBEEmi1Pk
        V3OvAulCFuOXQP4fR9rGQAOX730hnObXDsiGcJoRvMarAV+rXfn+2udOrn2WtJHs
        yodvjab6YR6dDzjy+wNbIXGjAKUSuDCUwoKQF8biVFH6zt7UHqEpRMn62C99+OHN
        YWj9eqdd+Zqvx/nG3lkwDIc7DmrJFvsjUcqb/QgUCHgUG7ci6Gc2FodQtMWXc1xX
        vEgWl3uC7jQxdMoF9CIIRNRPtZXVSMR8oFA==
X-ME-Sender: <xms:sO27ZD3I61TPbb8J9i9TrD-iXUNiuQSs9eOEMFMDbD3Qd7jrQjba0w>
    <xme:sO27ZCEsfcSQNbpW_mC3UeZDA8dV7gOFnfoKK_DOsO4Nk-4bszjT9uq713YjlKtlI
    QtcTYnLpmY-1pzPHPw>
X-ME-Received: <xmr:sO27ZD7IvWKcuwkShvgCZ1FirHIjlxg7NB1CCeiPgAsO00XTt4o76-Ez6u6XUHNYRnrgN45XlqIO3gy0OTLKVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtgfesthhqredttderjeenucfhrhhomhepffgrvhhi
    ugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegffetffeltdffkedtgedugeehgfejgeffueffieevheetvdevkeeiffef
    heevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgesuggrvhhiughrvggrvhgvrhdrtghomh
X-ME-Proxy: <xmx:sO27ZI1iwS5k39psd4FMboHwmpwecmcBQorneym3WfD4jHGDUfD3ng>
    <xmx:sO27ZGFoIQPirKkK3q-eS02-l_OJWWjs5EI_8fWB1BXD1JE1mN8GpA>
    <xmx:sO27ZJ8zUzH4hPzTfxLNXR7HMmtl_NNVnw4bv30iKz89-PeCWf83XQ>
    <xmx:sO27ZL62f67IJyOeyzw_rVSgx_12DQoMpJtsMWv7pWJGrW66t6e-ow>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Jul 2023 10:54:39 -0400 (EDT)
References: <20230706185100.84322-1-hugo@hugovil.com>
 <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
 <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
 <7eb2d50baf269310e51854f700936e94@lemonage.de>
User-agent: mu4e 1.10.4; emacs 28.2
From:   David Reaver <me@davidreaver.com>
To:     poeschel@lemonage.de
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christian Meusel <christian.meusel@posteo.de>
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear
 display command
Date:   Sat, 22 Jul 2023 07:46:59 -0700
In-reply-to: <7eb2d50baf269310e51854f700936e94@lemonage.de>
Message-ID: <86wmysknde.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


poeschel@lemonage.de writes:

> Am 2023-07-06 21:49, schrieb Hugo Villeneuve:
>> On Thu, 6 Jul 2023 21:33:05 +0200
>> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>>> On Thu, Jul 6, 2023 at 8:51=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:
>>> >
>>> > The "clear display" command on the NewHaven NHD-0220DZW-AG5 display
>>> > does NOT change the DDRAM address to 00h (home position) like the
>>> > standard Hitachi HD44780 controller. As a consequence, the starting
>>> > position of the initial string LCD_INIT_TEXT is not guaranteed to be
>>> > at 0,0 depending on where the cursor was before the clear display
>>> > command.
>>> >
>>> > Extract of CLEAR_DISPLAY command from datasheets of:
>>> >
>>> >     Hitachi HD44780:
>>> >         ... It then sets DDRAM address 0 into the address counter...
>>> >
>>> >     NewHaven NHD-0220DZW-AG5 datasheet:
>>> >         ... This instruction does not change the DDRAM Address
>>> >
>>> > Move the cursor home after sending clear display command to support
>>> > non-standard LCDs.
>>> >
>>> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> Thanks! Sounds good to me, as long the extra command does not
>>> introduce some issue with the actual HD44780 -- can we double-check
>>> the HD44780 still works as expected?
>>> Cc'ing Lars and Geert since they may be able to give it a quick test.
>> Hi Miguel,
>> I do not have a standard Hitachi controller to test it on, so lets wait
>> for feedback from Lars and Geert or others.
>
> Sorry guys,
> I do not have access to the relevant hardware anymore. I am CC'ing Christ=
ian,
> who has the relevant hardware and maybe he can help testing the patch.
> Christian is on vacation up until mid august, so we have to wait a bit mo=
re
> for someone able to test this.
>
> BTW: The displays I did the work back then on were for sure not genuine
> Hitachi ones either.
> I do not see, that the little patch should do any harm.
>
> Regards,
> Lars


I was actually hooking up a 16x2 HD44780 on my BeagleBone Black last
night before I came across this patch, so I was able to test this. It
works fine for me. I tested with:

    $ printf '\f' > /dev/lcd
    $ printf 'Hello\nWorld!\n' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\f' > /dev/lcd
    $ printf 'Goodbye\nWorld!\n' > /dev/lcd

As expected, "Goodbye World!" was correctly placed left-aligned on the
display, split over both lines. Let me know if there is something else
you would like me to do to test this!

Tested-by: David Reaver <me@davidreaver.com>
