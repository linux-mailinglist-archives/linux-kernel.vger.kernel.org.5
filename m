Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF09751BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjGMIi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjGMIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:37:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3E4EF4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:32:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-C7sYW67KNPG6e6sJsnGWqw-1; Thu, 13 Jul 2023 09:18:47 +0100
X-MC-Unique: C7sYW67KNPG6e6sJsnGWqw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Jul
 2023 09:18:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 13 Jul 2023 09:18:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Azeem Shaikh' <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Topic: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Index: AQHZrdj8Qo2zsxXODk+YaMEZxqXK9K+zA4WggABClwCAAP0w0IACiCMAgACbHnA=
Date:   Thu, 13 Jul 2023 08:18:45 +0000
Message-ID: <24ccdb40832c4dc0a5376d76a9ea9ae2@AcuMS.aculab.com>
References: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
 <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
 <CADmuW3XOcGDBszYw80Dy03DXk3T25k8FNUrJWLKU9tL2znzanw@mail.gmail.com>
 <0aaa9355aa714e608091af2a5fca1373@AcuMS.aculab.com>
 <202307121651.04D1758@keescook>
In-Reply-To: <202307121651.04D1758@keescook>
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

RnJvbTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IDEzIEp1bHkg
MjAyMyAwMDo1Mw0KLi4uLg0KPiA+ID4gcHJfd2FybigiaW5pdF91ZXZlbnRfYXJndjogYnVmZmVy
IHNpemUgb2YgJWQgdG9vIHNtYWxsIGZvciAlcywgbmVlZGVkDQo+ID4gPiAlZFxuIiwgYnVmZmVy
X3NpemUsIHN1YnN5c3RlbSwgc3RybGVuKHN1YnN5c3RlbSkpOw0KPiA+ID4NCj4gPiA+IERvZXMg
dGhhdCBzZWVtIGJldHRlcj8NCj4gDQo+IFllYWgsIHRoYXQnbGwgcmV0YWluIHRoZSBpbnRlbnRp
b24gb2YgdGhlIHdhcm5pbmcuIEl0IHNob3VsZG4ndCByZWFsbHkNCj4gZXZlbiBiZSBwb3NzaWJs
ZSB0byBoaXQgdGhhdCB3YXJuaW5nLCBzbyBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gd29ycnkN
Cj4gYWJvdXQgdGhlICJleHRyYSIgY2FsbCB0byBzdHJsZW4oKS4NCj4gDQo+ID4gTm90IHdpdGgg
dGhlIGp1c3RpZmljYXRpb24gZm9yIG5vdCB1c2luZyBzdHJsY3B5KCkgOi0pDQo+IA0KPiBXaGF0
Pw0KDQpUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyB0aGF0IHN0cmxjcHkoKSBpc24ndCB1c2VkIGJl
Y2F1c2UNCm9mIHBvc3NpYmxlICdyZWFkIGJleW9uZCBidWZmZXIgZW5kJyAoZXRjKSBpZiBpdCBp
c24ndA0KJ1wwJyB0ZXJtaW5hdGVkLg0KDQpCdXQgaGVyZSBpZiAoZXh0cmVtZWx5IHVubGlrZWx5
KSB0aGUgc291cmNlIGlzbid0IHRlcm1pbmF0ZWQNCnRoZW4gdGhlIGV4dHJhIHJlYWRzIGdldCBk
b25lIGFueXdheS4NClNvIHRoZSBjb21taXQgbWVzc2FnZSBqdXN0IGRvZXNuJ3QgbWF0Y2ggdGhl
IGNoYW5nZS4NCg0KSSdkIGd1ZXNzIHRoYXQgaXQgaXMgcG9zc2libGUgZm9yIHRoZXJlIHRvIGJl
IGluc3VmZmljaWVudCBzcGFjZS4NClByb2JhYmx5IGJlY2F1c2Ugb3RoZXIgc3RyaW5ncyBoYXZl
IGZpbGxlZCB0aGUgYnVmZmVyLg0KVGhlIGVycm9yIG1lc3NhZ2UgbWlnaHQgYmUgYmV0dGVyIGFz
Og0KCSJpbnN1ZmZpY2llbnQgYnVmZmVyIHNwYWNlICgldSBsZWZ0KSBmb3IgJXNcbiIsDQoJCWJ1
ZmZlcl9zaXplLCBzdWJzeXN0ZW0pOw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

