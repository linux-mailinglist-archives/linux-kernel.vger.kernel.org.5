Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2677DBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbjHPIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242792AbjHPIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:12:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF4AB;
        Wed, 16 Aug 2023 01:12:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G8040d013993;
        Wed, 16 Aug 2023 03:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=XBrvMs7nTF97Zizz0enpQAZB41SWEkMJ3maqN3ukMzQ=; b=
        FgDChWYalZkKudOOEl8FamrnW0bJoqndnzdJB/gr4eG0X5mDtAvBrR4gxLNPd/+a
        yDVeG9LyKDHv+Ym3ekfZQlQ6zzMDHYpKgpHvPDHRZQmATKClkJ5AcdijbiyxKCBa
        xob5TxcHeU4MSxNR95tmXOWGeTDABwCVqWH3aqLhHsda4/CuEKPCnAoT9VROevk0
        JsYdGqmwaArrELbprb6ujZF9SP00EmMU3jzUkucVQJcLsRxM2gi5XTbrAPUK3cDl
        hr6gSSwIwm9FemUK6AmQ1MwSYWjZ85owtTwEiyMzC1FsTav9OZUbQDGo0jbAwaFz
        Q+Vmbo/J1qw7ldjF+G+2Bg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhkwmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 03:11:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 09:11:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 09:11:30 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9AB083560;
        Wed, 16 Aug 2023 08:11:30 +0000 (UTC)
Date:   Wed, 16 Aug 2023 08:11:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     James Ogletree <James.Ogletree@cirrus.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Lee Jones" <lee@kernel.org>, Jeff LaBundy <jeff@labundy.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Bai <ping.bai@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Message-ID: <20230816081130.GB103419@ediswmail.ad.cirrus.com>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <20230810103005.GZ103419@ediswmail.ad.cirrus.com>
 <51826BD7-BB75-4D1F-B947-A7AC2C642F62@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51826BD7-BB75-4D1F-B947-A7AC2C642F62@cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: qkx6JlK6fSTwvvVUFttnD-gWC8JlX5E0
X-Proofpoint-ORIG-GUID: qkx6JlK6fSTwvvVUFttnD-gWC8JlX5E0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:33:00PM +0000, James Ogletree wrote:
> 
> 
> > On Aug 10, 2023, at 5:30 AM, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > 
> > On Wed, Aug 09, 2023 at 07:10:28PM +0000, James Ogletree wrote:
> >> +
> >> +static int cs40l50_pseq_write(struct cs40l50_private *cs40l50, u32 addr, u32 data)
> >> +{
> >> +
> >> +static int cs40l50_owt_upload(struct cs40l50_private *cs40l50, s16 *in_data, u32 in_data_nibbles)
> >> +{
> > 
> > These pseq and OWT bits, could they be shared with l26?
> > Definitely worth syncing with those guys, my assumption is the
> > wavetable/pseq won't have changed much and it might be nice to
> > factor these bits out into some library code that both drivers
> > can use.
> 
> The pseq code most certainly can, likely the OWT code, perhaps others. I assume it is
> acceptable to move some of these functions to a library in this patch set, even though this is
> the only driver utilizing them as far as mainline is concerned? In other words, we shouldn’t
> wait for one of L26 or L50 drivers to be accepted before splitting off the common code as part
> of the others’ patchset? I’m probably overcomplicating; just want to be sure on the process here.
> 
> Everything else in your review will be fixed in V4. Thank you.
> 

I think this makes sense to do now, just need to make sure the
next series of L26 is synced up to it.

Thanks,
Charles
