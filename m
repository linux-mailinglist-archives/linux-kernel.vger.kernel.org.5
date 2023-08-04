Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA66770445
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjHDPVi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHDPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:21:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53B49C1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:21:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-hejOPKxFNWeHuOFbQdL2JQ-1; Fri, 04 Aug 2023 16:21:33 +0100
X-MC-Unique: hejOPKxFNWeHuOFbQdL2JQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 16:21:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 16:21:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Moore' <paul@paul-moore.com>,
        =?iso-8859-1?Q?Christian_G=F6ttsche?= <cgzones@googlemail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/9] selinux: services: update type for number of class
  permissions
Thread-Topic: [PATCH v2 5/9] selinux: services: update type for number of
 class  permissions
Thread-Index: AQHZxnpAfMoj5HezXkad2FNTf0iy46/aPz6Q
Date:   Fri, 4 Aug 2023 15:21:31 +0000
Message-ID: <764b3d9f340e403084fb44877d4a73b6@AcuMS.aculab.com>
References: <20230728155501.39632-4-cgzones@googlemail.com>
 <059e2bd127d8a6d59290d606a707a999.paul@paul-moore.com>
In-Reply-To: <059e2bd127d8a6d59290d606a707a999.paul@paul-moore.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Moore
> Sent: 04 August 2023 03:20
> 
> On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> >
...
> > +		u16 i, n = mapping->num_perms;
...
> >  		for (; i < (sizeof(u32)*8); i++)

Don't dop arithmetic on types smaller than int.
You are pretty much requesting the compiler add code to mask the
result down to 16 bits after very operations.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

