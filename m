Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCA753E37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjGNO4h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjGNO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:56:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6F358C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:56:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-249-MHkvfUD6Oua9lH8dct48VA-1; Fri, 14 Jul 2023 15:56:18 +0100
X-MC-Unique: MHkvfUD6Oua9lH8dct48VA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 15:56:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 14 Jul 2023 15:56:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'hanyu001@208suo.com'" <hanyu001@208suo.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] scsi: snic: Convert snprintf to scnprintf
Thread-Topic: [PATCH] scsi: snic: Convert snprintf to scnprintf
Thread-Index: AQHZtKnxEf7Ym24Gz0mmUQRzpLpcvK+5XNpA
Date:   Fri, 14 Jul 2023 14:56:17 +0000
Message-ID: <7cd26b15c9214e7c9b5c76ad67cebb9e@AcuMS.aculab.com>
References: <tencent_D20A645667548A8D5B1261D32ED4369FD70A@qq.com>
 <fe09ebd8774d05dc4038e640d7ddb2e4@208suo.com>
In-Reply-To: <fe09ebd8774d05dc4038e640d7ddb2e4@208suo.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hanyu001@208suo.com
> Sent: 12 July 2023 11:16
> 
> Coccinelle reports a warning:
> 
> drivers/scsi/snic/snic_attrs.c:35: WARNING: use scnprintf or sprintf
> drivers/scsi/snic/snic_attrs.c:48: WARNING: use scnprintf or sprintf
> drivers/scsi/snic/snic_attrs.c:26: WARNING: use scnprintf or sprintf:

The function you are looking for is (probably) sysfs_emit().

The PAGE_SIZE constant ought to be a good hint that neither
sprintf, snprintf or scnprintf is actually right.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

