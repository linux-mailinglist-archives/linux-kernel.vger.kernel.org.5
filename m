Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D15800A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378662AbjLAMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378677AbjLAMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:05:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5C103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:05:46 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-X74kH0vROIOvVwf52dPxkQ-1; Fri, 01 Dec 2023 12:05:38 +0000
X-MC-Unique: X74kH0vROIOvVwf52dPxkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 12:05:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 12:05:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnaldo Carvalho de Melo' <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
Thread-Topic: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it
 isn't available in busybox
Thread-Index: AQHaI9e+SqSraxumCUi58U+dHeCYHbCUUq5A
Date:   Fri, 1 Dec 2023 12:05:31 +0000
Message-ID: <ecad5dffa8474ed8a5367e917610e707@AcuMS.aculab.com>
References: <ZWkEeqdmCHMLhLr2@kernel.org>
In-Reply-To: <ZWkEeqdmCHMLhLr2@kernel.org>
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

Li4uDQo+ICAjIENyZWF0ZSBsaXN0IG9mIGFyY2hpdGVjdHVyZXMgdGhhdCBoYXZlIGEgc3BlY2lm
aWMgZXJybm8uaC4NCj4gIGFyY2hsaXN0PSIiDQo+IC1mb3IgYXJjaCBpbiAkKGZpbmQgJHRvb2xz
ZGlyL2FyY2ggLW1heGRlcHRoIDEgLW1pbmRlcHRoIDEgLXR5cGUgZCAtcHJpbnRmICIlZlxuIiB8
IHNvcnQgLXIpOyBkbw0KPiArZm9yIGFyY2ggaW4gJChmaW5kICR0b29sc2Rpci9hcmNoIC1tYXhk
ZXB0aCAxIC1taW5kZXB0aCAxIC10eXBlIGQgfCB3aGlsZSByZWFkIGFyY2ggOyBkbyBiYXNlbmFt
ZQ0KPiAkYXJjaCA7IGRvbmUgfCBzb3J0IC1yKTsgZG8NCj4gIAl0ZXN0IC1mICR0b29sc2Rpci9h
cmNoLyRhcmNoL2luY2x1ZGUvdWFwaS9hc20vZXJybm8uaCAmJiBhcmNobGlzdD0iJGFyY2hsaXN0
ICRhcmNoIg0KPiAgZG9uZQ0KDQpKZWVwZXJzIC4uLg0KRG9lcyB0aGlzIHdvcms/DQoJZm9yIGYg
aW4gJHRvb2xzZGlyL2FyY2gvKi9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmg7IGRvDQoJCVsgISAt
ZiAkZiBdICYmIGJyZWFrDQoJCWQ9JHtmJS9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmh9DQoJCWFy
Y2hsaXN0PSIke2QjIyovfSAkYXJjaGxpc3QiDQoJZG9uZQ0KTm8gZm9yaygpcyBvciBleGVjKClz
Lg0KSSB0aGluayBpdCBvbmx5IGRpZmZlcnMgaW4gaGF2aW5nIGEgdHJhaWxpbmcgc3BhY2UgaW5z
dGVhZCBvZiBhIGxlYWRpbmcgb25lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

