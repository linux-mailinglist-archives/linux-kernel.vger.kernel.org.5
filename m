Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AFD759099
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSIsN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGSIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:48:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08510E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:48:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-2FrdlNlEO-aRlwCr8sDXcg-1; Wed, 19 Jul 2023 09:47:59 +0100
X-MC-Unique: 2FrdlNlEO-aRlwCr8sDXcg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 09:47:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 09:47:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Lunn' <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
CC:     Kees Cook <kees@kernel.org>,
        "justinstitt@google.com" <justinstitt@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Vladimir Oltean" <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] net: dsa: remove deprecated strncpy
Thread-Topic: [PATCH] net: dsa: remove deprecated strncpy
Thread-Index: AQHZua5uBGaLyFdvXEuDn4GOsjwmUK/Ax0MA
Date:   Wed, 19 Jul 2023 08:47:57 +0000
Message-ID: <02afcfd1dc4d4c258c2c5ffbda2688c8@AcuMS.aculab.com>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
 <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
 <20230718121116.72267fff@kernel.org>
 <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
In-Reply-To: <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn
> Sent: 18 July 2023 20:31
...
> Maybe we should actually add another helper:
> 
> ethtool_name_cpy(u8 **data, unsigned int index, const char *name);
> 
> Then over the next decade, slowly convert all drivers to it. And then
> eventually replace the u8 with a struct including the length.

Define the structure with the length from the start.
Add a wrapper that allows the length to be absent.
(Either ignoring the length or using 0/infinity to mean no length.)

Then you don't need to visit everywhere twice - just some places.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

