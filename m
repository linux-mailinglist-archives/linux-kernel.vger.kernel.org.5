Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C176A668
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHABel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHABek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:34:40 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97184114;
        Mon, 31 Jul 2023 18:34:38 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 1 Aug 2023 09:34:17 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date:   Tue, 1 Aug 2023 09:34:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Markus Elfring" <Markus.Elfring@web.de>
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Alexander Duyck" <alexander.h.duyck@intel.com>,
        "Daniel Machon" <daniel.machon@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Peter P Waskiewicz Jr" <peter.p.waskiewicz.jr@intel.com>,
        "Petr Machata" <petrm@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dcb: choose correct policy to parse
 DCB_ATTR_BCN
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
 <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3d159780.f2fb6.189aebb4a18.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgB3fxcaYchkoKpqCg--.55514W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQNEmTHEHoQmQAMsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFya3VzLAoKPiAKPiDigKYKPiA+IFRoaXMgcGF0Y2ggdXNlIGNvcnJlY3QgZGNibmxf
YmNuX25lc3QgcG9saWN5IHRvIHBhcnNlIHRoZQo+ID4gdGJbRENCX0FUVFJfQkNOXSBuZXN0ZWQg
VExWLgo+IAo+IEFyZSBpbXBlcmF0aXZlIGNoYW5nZSBkZXNjcmlwdGlvbnMgc3RpbGwgcHJlZmVy
cmVkPwo+IAo+IFNlZSBhbHNvOgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vz
cy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuNS1yYzMjbjk0Cj4gCj4gUmVnYXJkcywKPiBN
YXJrdXMKClllYWgsIHRoYW5rcyBmb3IgcmVtaW5kaW5nIG1lLiBJIGhhdmVuJ3QgYmVlbiBwYXlp
bmcgYXR0ZW50aW9uIHRvIHRoYXQgYW5kIEkgd2lsbCByZW1lbWJlciB0aGlzIGV2ZXIgc2luY2Uu
IDpECgpSZWdhcmRzLApMaW4=
