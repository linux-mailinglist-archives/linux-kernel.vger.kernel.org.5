Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72697D8003
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJZJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:51:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4C191;
        Thu, 26 Oct 2023 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JE/wzep2Kl9fulvu7hozBAZLnaAXZolsk/A0oBuPFR0=;
        t=1698313884; x=1699523484; b=aUPICMNRjEfQRVhPTSCqMqFE9qUaOz9kSL/nyE2hCk1cJ7k
        Exl19kY2+639qapt2SBvgNU7acJpenBvcNhC2bgNqdD9F1/HsRwOsJzfabi7ZkO+g11fthbiWpnnj
        kP9tk1BDjDsW6Hmc3tx2bn2hWOLAE0/8Y7AsoOXSY1Q4pmpCEKkSX7T87wtkOc3+26aTURH50c1fP
        TXS+cKMSTNm6cDyt5CEgrquDMGAFEhHwYt9vtMYqAR06hIy3k9eWugEuAPfsUUZ+ZP3758iOlmO/3
        vZgPdKVtfKKi3ugSU22JUeOR8m0JBrgjpD9gdaoKfZpm+JAOiN/CyHehDL5IhtFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvx1A-00000003a91-3X6O;
        Thu, 26 Oct 2023 11:51:09 +0200
Message-ID: <14bd2e39338dd755f7bfde23a93563865580ee83.camel@sipsolutions.net>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Witold Baryluk <witold.baryluk@gmail.com>, arnd@kernel.org,
        Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        ilw@linux.intel.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com,
        stf_xl@wp.pl
Date:   Thu, 26 Oct 2023 11:51:07 +0200
In-Reply-To: <87jzr9d883.fsf@kernel.org>
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
         <c608f328-387e-431b-b3c2-4b8fa0c4f11f@gmail.com>
         <87jzr9d883.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 12:49 +0300, Kalle Valo wrote:
> Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:
>=20
> > On 10/26/23 00:27, Witold Baryluk wrote:
> > > I might be interested in modernizing the driver, but I have no idea
> > > how much effort it would be (in terms of changed fraction of code).
> > > 20k LOC is neither small or big, and not obvious (a lot of it would
> > > be unchanged), if it is a week of work, or months of work.
> >=20
> > Hi Witold,
> >=20
> > I am trying to do this with rtl8192e.
> > One possibility is to take the following patch series as a starting poi=
nt:
> > https://yhbt.net/lore/all/1414604649-9105-1-git-send-email-tvboxspy@gma=
il.com/
> >=20
> > For me as a beginner and hobbyist this is a huge task. I am happy when
> > I can finish it until next summer.
>=20
> We also have some docs available:
>=20
> https://docs.kernel.org/driver-api/80211/
>=20
> And I also recommend looking at our hwsim driver as that gives a good
> idea how a simple mac80211 driver works:
>=20

FWIW, I don't think this can be ported to mac80211 - only cfg80211. It's
a fullMAC device.

johannes
