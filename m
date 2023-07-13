Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B027515DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGMBmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjGMBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:42:15 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 18:42:13 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152991FEE;
        Wed, 12 Jul 2023 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=m3po4FiRsuRaodVf3w1lKGRDQNG5T/ke8/cTCsTCpi0=;
        t=1689212533; x=1690422133; b=EzF0nwhmzXPInb/EC4kTZO9WQzs1BCBZclq9VKpD7u+Oi+C
        ZvH7ocEqCvxafHLwgapM6jHGE1C7/X5b+LkEWP9ZEFpBucgRD1dLJP41VsOlEiHJOwK6VKKn/5/8o
        8U+/Rtyogf2TTB4a1mCM7f7mbL9RT09bfqfliyYl2nQksZm39QY1vrzTknEhcRjGOiSqx5dYISHZF
        lyns2lU0Asay7cKxhO90vz+Q3WMLZ2r+Ru/ujvw6155gNXNvoW9wpUXLlv7DkQ/Sg0F+rL9oJ2LSu
        exCiHKSyFXPbRY8W9EzEIMtE4llRHlP/5jTecbZT6D0h3Xkq12sQKvnLS+T3MLCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJkC3-0004Hv-1i;
        Thu, 13 Jul 2023 02:28:27 +0200
Message-ID: <2d26c0028590a80e7aa80487cbeffd5ca6e6a5ea.camel@sipsolutions.net>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Date:   Thu, 13 Jul 2023 02:28:26 +0200
In-Reply-To: <2023071222-asleep-vacancy-4cfa@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
         <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
         <2023070430-fragment-remember-2fdd@gregkh>
         <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
         <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
         <2023071222-asleep-vacancy-4cfa@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 18:39 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 12, 2023 at 03:00:55PM +0200, Johannes Berg wrote:
> > On Wed, 2023-07-12 at 11:22 +0200, Oliver Neukum wrote:
> > >=20
> > > On 04.07.23 08:47, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > > > > Hi all!!
> > > > >=20
> > > > > I think the rndis_host USB driver might emit a warning in the dme=
sg, but disabling the driver wouldn't be a good idea.
> > > > > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrat=
ed in routers do use this protocol.
> > > > >=20
> > > > > We may also distinguish between these cases and devices you might=
 plug in - as they pose different risk levels.
> > > >=20
> > > > Again, you have to fully trust the other side of an RNDIS connectio=
n,
> > > > any hints on how to have the kernel determine that?
> >=20
> > > it is a network protocol. So this statement is kind of odd.
> > > Are you saying that there are RNDIS messages that cannot be verified
> > > for some reason, that still cannot be disclosed?
> >=20
> > Agree, it's also just a USB device, so no special trickery with DMA,
> > shared buffers, etc.
> >=20
> > I mean, yeah, the RNDIS code is really old and almost certainly has a
> > severe lack of input validation, but that still doesn't mean it's
> > fundamentally impossible.
>=20
> You all are going to make me have to write some exploits aren't you...

This is getting a bit childish. Nobody ever said that wasn't possible,
in fact I did say exactly above that I'm sure since it's old and all it
lacks input validation. So yeah, I full well believe that you can write
exploits for it.

All we said is that your statement of "RNDIS is fundamentally unfixable"
doesn't make a lot of sense. If this were the case, all USB drivers
would have to "trust the other side" as well, right?

johannes
