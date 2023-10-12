Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8857C7255
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbjJLQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379465AbjJLQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11515D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697127555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQu5TmIv6kRwUt1hSoHmn+8CkuoIuY67NQyE/AJm8Vc=;
        b=glkSy7ptwRtB+3UKbyYstmNQCZZ0bIgk0ay/PdQ5fDajDmUTo6qufwO+eVfphJBpDMZYqe
        Dn0TjwECf3j7xbb6FOV+ip65MsxA6zoWRrLkJ8wd7XaBLtVzoD63HSxBlDh1sxBaDnmYyA
        rYysel2EiT4Iv38B9qGqcV4ar2VKvns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-2Ttejii7N1WX9_4r3iRUVw-1; Thu, 12 Oct 2023 12:19:02 -0400
X-MC-Unique: 2Ttejii7N1WX9_4r3iRUVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E2C7858281;
        Thu, 12 Oct 2023 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.50.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53464060EA;
        Thu, 12 Oct 2023 16:18:58 +0000 (UTC)
Message-ID: <2017087fd471048ff1edb6e57e61883b4ae084be.camel@redhat.com>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
From:   Dan Williams <dcbw@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Date:   Thu, 12 Oct 2023 11:18:57 -0500
In-Reply-To: <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
         <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
         <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
         <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
         <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 16:36 +0200, Arnd Bergmann wrote:
> On Thu, Oct 12, 2023, at 13:47, Kalle Valo wrote:
> >=20
> > Is anyone willing to submit patches? Use wireless-next as the
> > baseline
> > for patches and one driver per commit, please. That way it's easy
> > to
> > revert later, if needed (hopefully not).
>=20
> I can do it, I've already done most of the work for moving the
> drivers, so I just need to split up my existing patch and leave out
> the bits that get added to drivers/staging.
>=20
> I'll also send Greg a patch to remove rtl8192u now that we know
> that this has been broken for 7 years. Similarly, I'd include
> another patch to remove PCMCIA support for libertas, as that
> would otherwise be the only remaining 16-bit PCMCIA wlan card,
> and I could find no indication of this one ever being popular,
> unlike the USB/SDIO/SPI variants of the same device or the
> other PCMCIA drivers.

This was only for CF cards of which there were a couple; I still have
cards but don't have a machine with CF anymore. USB/SDIO/SPI (as you
point out) have much higher usage.

ACK from me (if my historical libertas involvement counts for anything)
on removing Libertas CF support.

Dan

>=20
> This would leave only a handful of wext implementations in the
> tree: ipw2x00, ps3-gelic-wireless, staging/rtl8712, staging/rtl8192e
> and staging/ks7010. Since ipw2x00 is apparently still supported
> in theory and was rather popular on Pentium-M based systems 20
> years ago, this may still need to be converted to cfg80211
> before you can remove support for wext style drivers altogether.
> ps3-gelic-wireless and rtl8712 are also still maintained but have
> a much smaller user base I assume.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

