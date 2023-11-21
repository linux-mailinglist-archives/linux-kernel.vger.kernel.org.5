Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE77F2D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjKUM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjKUM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:27:35 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78FE7;
        Tue, 21 Nov 2023 04:27:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DB2BC32014FC;
        Tue, 21 Nov 2023 07:27:28 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 21 Nov 2023 07:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700569648; x=1700656048; bh=sVBBvqTkj9q2vNx24eU0OMVGviLHmJMCGMu
        iAotm8W0=; b=MyUt5DgjSax4zCgEeSm14lSY3UJKiScQT8sTh3VhPPjRKU6WXIy
        orySfNt28HjamadVjM+TB2Tyitl9TN4cFHtK79GE/kJ5YlL8/CiD/KlEW42y8Cuk
        C3IaSgg8LeJzxu6DvkOuOipl+h+bKyd8RmBdZg842CHgqinbDoPOGQjq2gCW8ySP
        06y1L2GnRpbJ2g3FqWCc/ZmyQyYA9UiVeTvcsKA4UgYZ4IiFNRrxNBDhL98PB2oi
        qE5KkV9E0XJPZfZbEYivK0FCpNDBCs/hb+KEfQ5HEaAMDQQNzLzglzJbTxEsUMfb
        ychke6JmFyffNu0RY8AVn4Tc18T/LlRwOsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700569648; x=
        1700656048; bh=sVBBvqTkj9q2vNx24eU0OMVGviLHmJMCGMuiAotm8W0=; b=T
        sGfoFyfx+2UWmQwMeedGtOB1jlOt7Ejf2kfn+DXxl08Z0jnvnIT87YRXWPNYRui+
        n/gJSyRBzC/Iiv4TPU1YuLaluZVyigO/lVj73zTjPsphBtsGBujlEQ7B03ny9A1x
        bwu8DzfDbJk4dJ3dcKP7/5SGle8PRSBsqIMLHbfvvgSKHInnq7nlVBPJ5UKTwTUy
        COGEelkCX47qCxZQJRgHpl1hqFM+p53edKU8miry+4O8aMUucencGSjI2zrX3t0E
        m3lilzhn5QLEQyzjFzXv2Z1zNxxatZOjBKOMp6R5up1SlwwiN29VQr3gTCEf0XjJ
        0Ka1/vnNHT9vmgl3vjQog==
X-ME-Sender: <xms:L6JcZQoA5ZgkG04UM6euO_4UCMz06yBhDqrGcMsyO6bpTiINqeEgyA>
    <xme:L6JcZWocuNQTOzN__OHrk5JJj55B_P9k8Q2bg83zgbnvavqTFx1FnxVU9_dO6uvUR
    zow-a7_qIeb-kSsUKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:L6JcZVOtAxFmHeQwsEJrdQ80v4bE7IJ0NFrsKEotXEIEKFBExTnccA>
    <xmx:L6JcZX7KsJPGr1seGKgnUYB5w6RMhPVRz_4FU1g1qS3JXKT_i0MDIg>
    <xmx:L6JcZf4vn-RkPVfss7NGf58cKeT7yrNy6Ekg8KMMpNwQTJFubi4kPw>
    <xmx:MKJcZfH-1MUI_tbF3W-54F4ulJwuqB6sDV9xerC40DqcZ87le13Vag>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CD83D36A0075; Tue, 21 Nov 2023 07:27:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <c9e2daa2-65a8-445e-bace-ab750f04411a@app.fastmail.com>
In-Reply-To: <ZVuuqAUJ7f2ELIYW@alpha.franken.de>
References: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
 <ZTvQGs/lEpizUFLh@aurel32.net> <ZVjaDTcjNpD3m0cC@aurel32.net>
 <ZVuuqAUJ7f2ELIYW@alpha.franken.de>
Date:   Tue, 21 Nov 2023 12:27:11 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "YunQiang Su" <syq@debian.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: process: Remove lazy context flags for new kernel thread
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8820=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=887:08=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Nov 18, 2023 at 04:36:45PM +0100, Aurelien Jarno wrote:
>> > Anyway, I have been able to test a backport of the patch onto the 5=
.10
>> > kernel (with minor adjustments) and I confirm it fixes the reported
>> > issue.
>> >=20
>> > Tested-by: Aurelien Jarno <aurel32@debian.org>
>>=20
>> It seems that this patch hasn't been merged yet, either in Linus' tree
>> or in the MIPS tree. Is there anything blocking?
>
> sorry, took some time to get really back from vacation...
>
> I don't like the patch doing too much code restructing. I can't
> reproduce on my loongson machine, so I can't test below patch...

I intentionally do code shuffle to match with other arches :-)
To reproduce, you can just install Debian sid and build kitinerary with
sbuild. However, it seems like loongson3_defconfig won't expose this
problem, you'll have to build kernel with Debian's config.

I'll test this patch later today.

Thanks
- Jiaxun

>
> What cmake version do I need and what would be a package to
> reproduce the bug ?
>
> Thomas.
>
[...]
