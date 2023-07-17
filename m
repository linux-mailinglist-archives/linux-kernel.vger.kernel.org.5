Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20D755E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGQIWM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:22:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A0E3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:22:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-pBC7QbWwOeSzpXkXTc7A_g-1; Mon, 17 Jul 2023 09:22:06 +0100
X-MC-Unique: pBC7QbWwOeSzpXkXTc7A_g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 09:22:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jul 2023 09:22:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Russell King' <linux@armlinux.org.uk>,
        "hanyu001@208suo.com" <hanyu001@208suo.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Fwd: [PATCH] arm: mm: replace snprintf in show functions with
 sysfs_emit
Thread-Topic: Fwd: [PATCH] arm: mm: replace snprintf in show functions with
 sysfs_emit
Thread-Index: AQHZtXMxNEAgMD6bokCn2RYqnhTjN6+9pEMg
Date:   Mon, 17 Jul 2023 08:22:06 +0000
Message-ID: <9896a3f4009946dda3d0dcbc1d8e8f7a@AcuMS.aculab.com>
References: <tencent_EFB5DEE75502CBD51C95CFE33D443DB41608@qq.com>
 <72204230a061f7d5bf19f09d524203ce@208suo.com>
 <ZK/O9Dc2aYtXEKHd@shell.armlinux.org.uk>
In-Reply-To: <ZK/O9Dc2aYtXEKHd@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <linux@armlinux.org.uk>
> Sent: 13 July 2023 11:16
> To: hanyu001@208suo.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: Fwd: [PATCH] arm: mm: replace snprintf in show functions with sysfs_emit
> 
> On Thu, Jul 13, 2023 at 06:06:15PM +0800, hanyu001@208suo.com wrote:
> > coccicheck complains about the use of snprintf() in sysfs show functions.
> >
> > Fix the coccicheck warning:
> > WARNING: use scnprintf or sprintf.
> >
> > ./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: use scnprintf or sprintf
> >
> > Signed-off-by: ztt <1549089851@qq.com>
> > ---
> >  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> > index 993fefdc167a..d20626451a2e 100644
> > --- a/arch/arm/mm/cache-l2x0-pmu.c
> > +++ b/arch/arm/mm/cache-l2x0-pmu.c
> > @@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
> >      struct l2x0_event_attribute *lattr;
> >
> >      lattr = container_of(attr, typeof(*lattr), attr);
> > -    return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
> > +    return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
> 
> This only serves to shut up a warning. On 32-bit ARM, there is utterly
> no way what so ever that "config=0x%x\n" could ever overflow 4096 bytes,
> or even 32 bytes!

The code also doesn't match the commit message.
Did you actually send the correct copy of all these patches?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

