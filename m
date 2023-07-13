Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE41A751D39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjGMJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjGMJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:30:24 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355112E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689239941;
        bh=V/e71QCnBQtZC9hmwL+F3f0BKWlNDzfr3iN9W0BOyyU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=vFHxxSTzaHryDCoUaF3Ti+E8WenyhoFosqP1tYquRghj4QOs/34cDj7hLYvVUEzd9
         9htw4MA3IKMRNFtTIjON4uzVlIdrzbSlzf+QxRkJnrt1a/go82grEjAQaP1ieygQlA
         Nwl08X+b7bfr+F84wfXvrjUfT9P4a79EbSH5of5h5RhurwLpA11HQJKy1XPPIfvUFx
         6hZZxOkH0tfiATkAEm2kn4qWOS3pBwSs1HfS3q4gabHSPHVIUhtpdOoSOXVa1zRrFM
         XS5b3JRFAZHNPDLbDkMWim4hjX/OjOOzgJ0VN7gYMWNeNbKnHDA8rNFp25GuNQij85
         EqNYSZr2/4JdQ==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZUmi9/xwYP1tNtkugFXddhctvjq8xtZQAgA1wIoCAEI6VgIACLo2AgAAF3oCAZPYrkIABURWw
Date:   Thu, 13 Jul 2023 09:18:58 +0000
Message-ID: <52f69c31ad674d6698e1a535b29a06ef@dh-electronics.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
 <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
 <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
 <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
 <OS3PR01MB8460C4A6047EE4590D4F791FC2769@OS3PR01MB8460.jpnprd01.prod.outlook.com>
 <e7e4f933-5098-5fea-7a1d-254609c93cbd@denx.de>
 <ef0f6ca48d9d492c996d9533281ed704@dh-electronics.com>
In-Reply-To: <ef0f6ca48d9d492c996d9533281ed704@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyDQpTZW50OiBXZWRuZXNkYXksIEp1bHkgMTIsIDIw
MjMgMzoyMCBQTQ0KPj4gT24gNS85LzIzIDEwOjU5LCBETEcgQWRhbSBXYXJkIHdyb3RlOg0KPj4+
IE9uIDA4IE1heSAyMDIzIDAwOjQxLCBNYXJlayBWYXN1dCB3cm90ZToNCj4+Pg0KPj4+Pj4gSXQg
bG9va3MgZmluZSBub3c7IHNvcnJ5IEkgZGlkbid0IG5vdGljZSBiZWZvcmUuDQo+Pj4+DQo+Pj4+
IEkgdGhpbmsgYSBmb3JtYWwgUmV2aWV3ZWQtYnkgLyBBY2tlZC1ieSB3b3VsZCBiZSBuaWNlLg0K
Pj4+DQo+Pj4gSXQncyBhbHJlYWR5IHRoZXJlIGluIHRoZSBwYXRjaCAtIG9ibGlxdWVseSByZWZl
cnJlZCB0byBieSAiYmVmb3JlIiwgdGhlIGFwb2xvZ3kgYmVjYXVzZQ0KPj4gSSdkIG1pc3NlZCB0
aGF0IHdoaWNoIHRoZSByb2JvdCBwaWNrZWQgdXAgb24gYWZ0ZXIgSSdkIGxvb2tlZCBhdCBpdC4N
Cj4+DQo+PiBBaGgsIGluIHRoYXQgY2FzZSwgc29ycnkgZm9yIHRoZSBub2lzZSBhbmQgdGhhbmtz
IGZvciB0aGUgUkIgLg0KPj4NCj4+IEFuZCBmb3IgYWxsIGl0cyB3b3J0aCwgcGF0Y2ggaXMgYWxz
bzoNCj4+DQo+PiBSZXZpZXdlZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IA0K
PiBJIHdhcyB3b25kZXJpbmcgaG93IHRvIGNvbnRpbnVlIHdpdGggdGhpcyBwYXRjaC4gSXMgdGhl
cmUgYW55dGhpbmcgYWdhaW5zdA0KPiBwaWNraW5nIHRoaXMgcGF0Y2ggb3IgZGlkIEkgbWlzcyBp
dD8NCg0KVG8gbWFrZSBpdCBlYXNpZXIgSSB3aWxsIHJlYmFzZSB0aGlzIGxlZnRvdmVyDQpwYXRj
aCBvbiB0aGUgY3VycmVudCBuZXh0IGFuZCBzZW5kIGl0IGFzIFY1Lg0KDQpSZWdhcmRzDQpDaHJp
c3RvcGgNCg==
