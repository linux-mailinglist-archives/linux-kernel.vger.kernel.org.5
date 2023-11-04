Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010187E0CF0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjKDA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:58:01 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B4D45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:57:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231104005752euoutp02458ff0b384d7b82c5c7b090f76fb7ecd~URZabYAfd2782227822euoutp02i
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 00:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231104005752euoutp02458ff0b384d7b82c5c7b090f76fb7ecd~URZabYAfd2782227822euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699059472;
        bh=AESS63LZVCXNB93Mxd4hWHrajmtUyG5SfOlOm896vK8=;
        h=From:To:CC:Subject:Date:References:From;
        b=W5iN8h357CbQQbGU108tTmuusAvmucPD23yHyusNAmCHoBO9pLXTkxXoP6djgup1M
         29vUb5yM0weDyaB0Pfnr4E4wyVATzUxQIfiQrJ3oKvji0uNUohkeEZhrbStU4w+ytd
         nXOmmwHQCFi85k5s1pFJvxvgeDe+jy5sGLJ/FlWA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231104005751eucas1p22032a33f6c24c3ca000089df9ebb6dec~URZZHfTpq1177611776eucas1p2U;
        Sat,  4 Nov 2023 00:57:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 40.F0.11320.F0795456; Sat,  4
        Nov 2023 00:57:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231104005750eucas1p11bb8d7b203f8376aacd097a713f35734~URZY1Jm4b2723927239eucas1p1T;
        Sat,  4 Nov 2023 00:57:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231104005750eusmtrp264651f6aa194e2e6befd8bb14773ce98~URZY0hSk_0448904489eusmtrp2p;
        Sat,  4 Nov 2023 00:57:50 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-d3-6545970fd754
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.E9.10549.E0795456; Sat,  4
        Nov 2023 00:57:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231104005750eusmtip26a453993d5fa908dae0768449e6cde80~URZYmQxFw0896808968eusmtip2r;
        Sat,  4 Nov 2023 00:57:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 4 Nov 2023 00:57:49 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 4 Nov
        2023 00:57:49 +0000
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 0/2] XArray multi-index tests
Thread-Topic: [PATCH 0/2] XArray multi-index tests
Thread-Index: AQHaDrnumPQICHUIPEiQzctipV++iQ==
Date:   Sat, 4 Nov 2023 00:57:49 +0000
Message-ID: <20231104005747.1389762-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <28DC7C9537AC0847AD4582A7CE8E49F5@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOV3+6a6pBgc+sVhc3jWHzeLGhKeM
        Fr9/zGFzYPbYvELLY9OqTjaPz5vkApijuGxSUnMyy1KL9O0SuDKufJrHWtDEVzG7cS5LA+MV
        3i5GTg4JAROJ2b9ms3cxcnEICaxglNj+fTIjhPOFUWLTiz9Qmc+MEnf2zWWHafnQvIoNIrGc
        UeLc2YuMcFWzFq9jgXBOM0q0fH7LBDf50ZM+RpB+NgFNiX0nN4HNEhHQl1h56SxYO7PAK0aJ
        d0cnsoAkhAV0Jabtnw6U4AAqMpLYe9Qaol5P4mDDGzYQm0VARWLH7I9sICW8AtYSvzeXgYQZ
        BWQlHq38BTaeWUBc4taT+UwQZwtKLJq9hxnCFpP4t+shG4StI3H2+hNGCNtAYuvSfSwQtpLE
        n46FYBcwA528fpc+xEhLidU7nrNC2IoSU7ofgq3iBRp/cuYTsN8lBCZzSixv+Qk1x0Wi58lF
        aNAJS7w6vgXKlpH4v3M+0wRG7VlITp2FsG4WknWzkKybhWTdAkbWVYziqaXFuempxUZ5qeV6
        xYm5xaV56XrJ+bmbGIEp5vS/4192MC5/9VHvECMTB+MhRgkOZiURXkdvl1Qh3pTEyqrUovz4
        otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJvWum1JRXrdL/rX1Tzxj7WXx
        q/AtW4S3uo+zl0LWZF3xzfcyp3VuuGZ0lWX929QHTwyz1c4ZTXrwO4r14tbH2QskpsyUaGhW
        10m++0E4NCfzd4fj+vMhHj9+f1KY2BlbWvritRkvS5uf9sTmTYwCjfPDjhQqCG1anLnvhOZ/
        u/8lu8V05F3mH94174D8A2fhLo8dUoIZ983ke7dX/zz+tFe2XFXi0fbjrzcnP9nKlpf50MNc
        donZph6msj8/lzBOeJR8qf2be2moYn0aZznvr363oMDJa2cdS7q0b7eQwbFPO139PpXpfs98
        65W65EPzp8n5D4++av5bPtlkuohVv8VijxdaB3I/ZZt+vHfeTomlOCPRUIu5qDgRACr7wm2g
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7p8011TDX706Vhc3jWHzeLGhKeM
        Fr9/zGFzYPbYvELLY9OqTjaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3N
        Y62MTJX07WxSUnMyy1KL9O0S9DKufJrHWtDEVzG7cS5LA+MV3i5GTg4JAROJD82r2LoYuTiE
        BJYyShzZsocdIiEjsfHLVVYIW1jiz7UuqKKPjBL/Tv9ihXBOM0qc/LiKGcJZwSix7d9aFpAW
        NgFNiX0nN4GNEhHQl1h56SwjSBGzwCtGiYYHq5lAEsICuhLT9k8HSnAAFRlJ7D1qDVGvJ3Gw
        4Q0biM0ioCKxY/ZHNpASXgFrid+by0DCjAKyEo9W/gIbzywgLnHryXwmiEsFJJbsOc8MYYtK
        vHz8D+oDHYmz158wQtgGEluX7mOBsJUk/nQsBLuAGejk9bv0IUZaSqze8ZwVwlaUmNL9EGwV
        r4CgxMmZT1gmMErNQrJ5FkL3LCTds5B0z0LSvYCRdRWjSGppcW56brGhXnFibnFpXrpecn7u
        JkZgMth27OfmHYzzXn3UO8TIxMF4iFGCg1lJhNfR2yVViDclsbIqtSg/vqg0J7X4EKMpMIAm
        MkuJJucD01FeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPT8i//
        QovvrAtPPqhpvUdQ5nHR26m2H7UndicKHs1kbiv62Nwuszk+7e/1bTXb9jmHCZ2w2/KSX4bt
        cNdThv85TOeOnlOuvL/vLsN0jZZwvSLvq4+2avenT//y6u+/vd/tH0yUfskitZbjfPDXrUq3
        XN+uCFDZ0CT86Ob2llB2Xb5b9w/mLuqennHhQP+m39NcX3J/e7Cqx91ojf9PDXtFj3f6W6/F
        s9Sd3WnSpXduuVJaThTv74uMqXmW9QzWi3w7+1c4NfxXKmgIWx+ztNq78wnL95M9TYuiMlL/
        Zjx8cGnHyco3d8LMrM85b1myd6UBk6hmeq5jcKJ7RNKFz9MbTmaVPLKfEuJl+GrfhfsxSizF
        GYmGWsxFxYkAu6aol48DAAA=
X-CMS-MailID: 20231104005750eucas1p11bb8d7b203f8376aacd097a713f35734
X-Msg-Generator: CA
X-RootMTR: 20231104005750eucas1p11bb8d7b203f8376aacd097a713f35734
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231104005750eucas1p11bb8d7b203f8376aacd097a713f35734
References: <CGME20231104005750eucas1p11bb8d7b203f8376aacd097a713f35734@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG11bHRpLWluZGV4IFhBcnJheSB0ZXN0cy4NCg0KVGVzdHMgd2VyZSBmaXJzdCBpbnRyb2R1
Y2VkIGFzIHBhcnQgb2YgJ1tSRkMgUEFUQ0ggMDAvMTFdIHNobWVtOiBoaWdoDQpvcmRlciBmb2xp
b3Mgc3VwcG9ydCBpbiB3cml0ZSBwYXRoJyBbMV0uIEkndmUgY3JlYXRlZCB0aGlzIG5ldyBzZXJp
ZXMgd2l0aA0KTWF0dGhldyBXaWxjb3gncyBmZWVkYmFjayBbMl0gcmVnYXJkaW5nIHRlc3QgJ1hB
cnJheTogYWRkIGNtcHhjaGcgb3JkZXIgdGVzdCcuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMzEwMjgyMTE1MTguMzQyNDAyMC0xLWRhLmdvbWV6QHNhbXN1bmcuY29tLw0K
WzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aVDY4ZEJpSktOTFhMUlpBQGNhc3Blci5p
bmZyYWRlYWQub3JnLw0KDQpUaGUgZnVsbCBub2RlIGlzIGxvc3QgKG5vdCBvbmx5IHRoZSBvcmRl
cikgd2hlbiB1c2luZyB4YV9jbXB4Y2hnIHdpdGggTlVMTA0KZW50cnkuIEFkZGluZyBhbm90aGVy
IChGSVZFKSBlbnRyeSBhdCAnMSA8PCBvcmRlcicgd2l0aCB0aGUgb3JkZXIgaW5mb3JtYXRpb24N
CmRvZXMgbm90IGtlZXAgdGhlIG9yaWdpbmFsIG5vZGUgYnV0IGR1cGxpY2F0ZXMgaXQuIEknbSBu
b3Qgc3VyZSBpZiB0aGF0J3MNCnRoZSBpbnRlbnRpb24gZnJvbSB0aGUgcHJvcG9zYWwgeW91IG1l
bnRpb25lZCBpbiBbMl0gYnV0IHBsZWFzZSwgbGV0IG1lIGtub3cNCnlvdXIgY29tbWVudHMuDQoN
CkNoYW5nZXMgc2luY2UgUkZDOg0KKiBVcGRhdGUgY21weGNoZyB0ZXN0IHRvIGluY2x1ZGUgYW5v
dGhlciBlbnRyeSBhdCAxIDw8IG9yZGVyIHRoYXQNCidrZWVwcycgdGhlIG5vZGUgYXJvdW5kIGFu
ZCBvcmRlciBpbmZvcm1hdGlvbi4NCiogVXBkYXRlIGNtcHhjaGcgdGVzdCB0byB2ZXJpZnkgdGhl
IGVudHJpZXMgYW5kIG9yZGVyIGluIGFsbCB0aWVkDQppbmRleGVzLg0KKiBEcm9wIHByZXZpb3Vz
IEx1aXMgQ2hhbWJlcmxhaW4ncyByZXZpZXcgYXMgY2hhbmdlcyBhcmUgc2lnbmlmaWNhbnQNCmZy
b20gdGhlIFJGQy4NCg0KRGFuaWVsDQoNCkRhbmllbCBHb21leiAoMSk6DQogIFhBcnJheTogYWRk
IGNtcHhjaGcgb3JkZXIgdGVzdA0KDQpMdWlzIENoYW1iZXJsYWluICgxKToNCiAgdGVzdF94YXJy
YXk6IGFkZCB0ZXN0cyBmb3IgYWR2YW5jZWQgbXVsdGktaW5kZXggdXNlDQoNCiBsaWIvdGVzdF94
YXJyYXkuYyB8IDE4OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDE4OCBpbnNlcnRpb25zKCspDQoNCi0tIA0KMi4zOS4yDQo=
