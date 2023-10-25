Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D167D6C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJYMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjJYMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:37:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0573129;
        Wed, 25 Oct 2023 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698237433; x=1698842233; i=j-p-t@gmx.net;
        bh=PkdRxhsM568WFqpYCtZJdhLCVi8JSeQHaWDtFdzRt/Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=ELIsFPXGyy+9ZaosbLA5G8t0D9AyaFmV5IDbUVwB32LJOGpV2O6lpKKLrIr2v3i4
         5Yiw8YFmCRbY2TQhfoBqlTeZMq69GrMEcPcS/Kb5RFpfx18hWpCFM3LYJ9iofOLU3
         bmsYdmiRl8ZOSUl1r4CSYPS1qx/AkU1uZMbb6R92Pw78kqFSBRdL6UccqoacR036t
         6bWF55QJVdqWxoV1X9/navQI7iwgIfRd48xfdBJDtPte0gNGzOAavkbjh1khRbBGU
         Do4emAv/3fY46Qk/GozaGqlPyTB+/mlFwTjrAfEa+CrabaDICotDeKCtnkLJoUhx6
         tXccOJW6IgQuQByI7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.58] ([45.14.97.35]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1qtyAx3cIk-002q5E; Wed, 25
 Oct 2023 14:37:10 +0200
Message-ID: <80e8bc56-ed41-40ab-af04-1fb11d383a5f@gmx.net>
Date:   Wed, 25 Oct 2023 14:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: si2157 not working at all?
Content-Language: de-DE
To:     Gonsolo <gonsolo@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <1cfa1365-ca0d-4e33-a149-751277183440@gmx.net>
 <ZThgwTieDv7Gi8UG@debian.me>
 <CANL0fFQMiubX3saR7fmQvYjKqDVCbDNTwyzj1_-aiN6HSB-hwg@mail.gmail.com>
From:   JPT <j-p-t@gmx.net>
In-Reply-To: <CANL0fFQMiubX3saR7fmQvYjKqDVCbDNTwyzj1_-aiN6HSB-hwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/DKT4sNcFYRd10XdPzLLw9nhVc3ru6CzYzcJ8GNuYxjoJ0VzL0C
 FnX/6pGfPDucBVb2X9R0RXz0+mxP5JXFlm5GhBqTqkja1RdF7jNnv84/wBXF/wDjgwV/qSr
 kbdWGiJXYMc+lkqrOSU7z7zZt+mK5ZizmSqzejtB3qHuMG4MROX+3V9RttznMzmx7Fb+lrl
 kFPLnsd49TXEmyKxY7yXg==
UI-OutboundReport: notjunk:1;M01:P0:Q0GHDGjUTyo=;SyzAtHAnp1irmVkn9/3ethD+Q6/
 D9tK726xOnLuxmSX37FAxLeEsPG7CzT9XudVClhESB5uyrzoxW0BeCwgswvasV5vd5z7FVArd
 8qeNXxwHCm7BOAOz3Dgg7YKn3NI4lEyItSxFD0Js6Iez39IjDShCgqWSzXEr5y9sXlfoiXcUZ
 aZdraJR3gwehjmM1KG3Qr1eYBwnuzmO+r0GJX8ZdxcxSRiUPEO4zSInuhA4rxZXpHdoeK+rd3
 OWk1tzy3h5DIbMZxGPh40JjnY4BuoRB4YluS6d/0NpE5K/8+Umxi6Dgy+2ouaGdeyN5IIfZE8
 8VSHloHWMttPnEtZQ5YmPDS6OoKmcwZxJNtBKq8MYY4LDFKT9VAxzpEElE4Uuc/1diXxn28hW
 F4MFgnpWD2BVisZH2mUQGbNUXlk4QGfsbCduxH1yamtweajD62AQnng8Mf7sJsss84aRSst0C
 P1uneSDecYu2lPsogjNDXfPV8tR7I0k06roBvscot8mw7Igo7SM9fTHSmeG/OcnPeEkRc9c7/
 5ubj92IAULBF/IXqRTeTZ4cF8K/8h1BkInicMrKOfNVi1BB0eVMzpvWMj5San/u3mN4/gcie/
 9IelL4utvl/kiQ3rYbH1HvrXVfW1G2H7Bl3mADA94v0FEwDwB3iOspWL+Lb3/mJ5+FHDuwmSl
 FEdQj9lxvrtK7j1cRWhJhaItQy2GvCwSr02lkTwEELmaD+vntUnXkPjMo3ULleUYEOyPkyG4r
 7qUzMV0UBaq8xyakgrDeTcoDdJRiOGVhblvbY+BOQVbCb6qMmm8uyp8rU3nbDfefaF29x2S82
 w0
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[TerraTec Cinergy TC2]
> > could someone please have a look what is the problem with si2157?
>
> No problem.
>
> Support for your stick was added here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dc0e0d3138896f <https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/?id=3Dc0e0d3138896f>

Oops. Thank you very much.
I was on the wrong trace all along.
Sorry, for bothering. I have tried hard to learn a little bit of kernel
development, but I am far from all of you :o)

could someone please change the kernel message to something more specific?

for example:

drivers/media/tuners/si2157.c
153c153
<                        "device is buggy, skipping firmware download\n");
=2D--
 >                        "firmware upload does not work, using firmware
already installed\n");

thank you very much

Jan
