Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772A808B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442884AbjLGPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjLGPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:04:34 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54ED53
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701961476; x=1702220676;
        bh=NYodcFpX/b1E1VWmahb0cxH1HMeWexFPLm+/MO5VZa0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DbZpTd+RCw007BN+kHHXkzxf1r7t3UmejqtgjZsqAFR6syJ5YlSWm1y+o5lM0FC7M
         /MpM8ne4aOhcZksrQjz3k801fEe7NjGlbkcIv225Qwxs+PD5PTPH4sLgtP9LhJQqgZ
         dz3pYMZoL5wIVfA175KG/ebiBkow+WA9w8dkaB5ZCJ9mnfpcrvEYY+v6woHeuWlCl3
         FuMOjhd4ynAn9CMIA2YbQG9Qx3BnmEwnjUzn95MFtTi6VOywOOkQR8T2DB0uMxLE+m
         a9fAl/xGO8IJnRPm2mZN1BcCSlaXt5KHYyKMtv5jMHh/JD2ku4z7Z35NZ45CEBUsW5
         zf7FNVnTbTYWQ==
Date:   Thu, 07 Dec 2023 15:04:19 +0000
To:     Jiri Kosina <jikos@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
From:   Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        =?utf-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        LinuxCat <masch77.linuxcat@gmail.com>,
        Marcelo <mmbossoni@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Fwd: Logitech G915 Wireless Keyboard acts weird on 6.6.0
Message-ID: <1358c8e3-8495-461c-a8d8-a551cc4a0d11@protonmail.com>
In-Reply-To: <nycvar.YFH.7.76.2311211458030.29220@cbobk.fhfr.pm>
References: <6929ebbf-f2e0-4cd4-addc-1e33ecf3277f@gmail.com> <ZVyr-of1X4RudpWG@archie.me> <0e10112a-7560-4dd8-8a03-5fdfc838168f@leemhuis.info> <nycvar.YFH.7.76.2311211458030.29220@cbobk.fhfr.pm>
Feedback-ID: 20039310:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 16:00, Jiri Kosina wrote:> A comment from Mavroudis just=20
appeared in
>=20
> =09https://bugzilla.kernel.org/show_bug.cgi?id=3D218172
>=20
> pointing out that indeed the report descriptor of the device he is workin=
g
> on is different than the ones from the reporter.
>=20
> Until this mess gets figured out, I am now pretty sure revert is the way
> to go for 6.7.
>=20
> --
> Jiri Kosina
> SUSE Labs
>=20

Greetings everyone,

I have recently made a new patch [0] aimed at addressing the issues that=20
have been identified.

I would appreciate it if you could test it and provide any feedback on it.


[0] https://bugzilla.kernel.org/show_bug.cgi?id=3D218172#c14

