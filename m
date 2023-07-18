Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180075784C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGRJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGRJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:42:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64ECF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:42:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-fdQbA2bfPDyw9YlMT_GihA-1; Tue, 18 Jul 2023 10:42:14 +0100
X-MC-Unique: fdQbA2bfPDyw9YlMT_GihA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 18 Jul
 2023 10:42:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 18 Jul 2023 10:42:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Thread-Topic: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Thread-Index: AQHZuJHW6PrtpG8ivE2r96KKd0tu26+/RQCQ
Date:   Tue, 18 Jul 2023 09:42:13 +0000
Message-ID: <4aef09112d0c4a59a1a3fa393af59f37@AcuMS.aculab.com>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDE3IEp1bHkgMjAyMyAxMDozNA0KLi4uDQo+
ICAjZGVmaW5lIHNlcV9zaG93X29wdGlvbl9uKG0sIG5hbWUsIHZhbHVlLCBsZW5ndGgpIHsJXA0K
PiAgCWNoYXIgdmFsX2J1ZltsZW5ndGggKyAxXTsJCQlcDQo+IC0Jc3RybmNweSh2YWxfYnVmLCB2
YWx1ZSwgbGVuZ3RoKTsJCVwNCj4gLQl2YWxfYnVmW2xlbmd0aF0gPSAnXDAnOwkJCQlcDQo+ICsJ
c3Ryc2NweSh2YWxfYnVmLCB2YWx1ZSwgc2l6ZW9mKHZhbF9idWYpKTsJXA0KPiAgCXNlcV9zaG93
X29wdGlvbihtLCBuYW1lLCB2YWxfYnVmKTsJCVwNCj4gIH0NCg0KV2h5IHRoZSBleHRyYSBkb3Vi
bGUtY29weSB3aXRoIChwb3RlbnRpYWxseSkgYSBWTEE/DQoNCnNlcV9zaG93X29wdGlvbigpIGNh
bGxzIHNlcV9lc2NhcGVfc3RyKCksDQpzZXFfZXNjYXBlX3N0ciBjYWxscyBzZXFfZXNjYXBlX21l
bSguLi4gIHN0cmxlbihzcmMpIC4uLikuDQoNCkltcGxlbWVudCBzZXFfc2hvd19vcHRpb24oKSBh
cyBzZXFfc2hvd19vcHRpb25fbiguLi4gc3RybGVuKHZhbHVlKSkNCmFuZCB1c2Ugc2VxX2VzY2Fw
ZV9tZW0oKSBmb3IgdGhlIHZhbHVlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

