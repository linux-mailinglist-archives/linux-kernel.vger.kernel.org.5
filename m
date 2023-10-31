Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6B7DCE36
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbjJaNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjJaNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:49:13 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C51F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:49:10 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231031134907euoutp02fda67723d9cfa93eb423874862a81c4a~TNVp0jr2T2672626726euoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:49:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231031134907euoutp02fda67723d9cfa93eb423874862a81c4a~TNVp0jr2T2672626726euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698760147;
        bh=+5Eh93ax/i28RwkAXRyvodCltxo1X7H2c4M8Yvi/M4o=;
        h=From:To:CC:Subject:Date:References:From;
        b=TY2ZqbX01lXyA9N1nfvw8ZDucEq3K7+Kc624J5jR2G93u+ocf+hMocrFghz2aTs/6
         2J5vjbInPKGXnQWPA3q86Eteh6vZRXPNR/45vO6FQ9yRaN970LKZa35ZEcXo709OHk
         22adSkxROYxvMRQPpSLCETdnbiYfIBqwCoI94CiQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231031134906eucas1p125c456c32ccb1adac18e41771b90a4a1~TNVpYMQAv1867218672eucas1p1I;
        Tue, 31 Oct 2023 13:49:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.A9.52736.2D501456; Tue, 31
        Oct 2023 13:49:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231031134906eucas1p10b45c65d43bc0643116808c916c12c95~TNVo_4tD52324323243eucas1p1P;
        Tue, 31 Oct 2023 13:49:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031134906eusmtrp154f8104d9a371f7953b0b6ab7590a567~TNVo_VqOG0203202032eusmtrp1P;
        Tue, 31 Oct 2023 13:49:06 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000ce00-57-654105d2b47b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.10.25043.2D501456; Tue, 31
        Oct 2023 13:49:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031134905eusmtip13660961fdb7fd8b37e3b37ddfd16b821~TNVoyd4kS1714117141eusmtip1R;
        Tue, 31 Oct 2023 13:49:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 31 Oct 2023 13:49:05 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 31 Oct
        2023 13:49:05 +0000
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "kbingham@kernel.org" <kbingham@kernel.org>,
        "cleger@rivosinc.com" <cleger@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "Daniel Gomez" <da.gomez@samsung.com>
Subject: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when
 CONFIG_MODULES=n
Thread-Topic: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when
        CONFIG_MODULES=n
Thread-Index: AQHaDAEDTRsJsWBk1kaMZj/f5uw8FQ==
Date:   Tue, 31 Oct 2023 13:49:04 +0000
Message-ID: <20231031134848.119391-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA017D15EDF91446AA17C7BB3E6755B5@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87qXWB1TDR4/VrCYs34Nm8XCk8kW
        927eZLY41b2ZyeLyrjlsFjcmPGV0YPPYtKqTzePEjN8sHjdmRXhsPzmJyePzJrkA1igum5TU
        nMyy1CJ9uwSujEUH17AUfBKpuDP9DnsD4xqRLkZODgkBE4lfN/6wdTFycQgJrGCUeHplFTuE
        84VRYtWkF8wQzmdGida5rewwLQ8Oz2OBSCxnlHj59SMrXNXbh/+hWs4wSpxtmcYE4awEmvxp
        MwtIP5uApsS+k5vAtoiAVO0/+gysn1lgN6PEqQm/wLYIC4RLPN71DaxDRCBG4uC7R0wQtp7E
        7v9tjCA2i4CqxIytJ5hBbF4BK4nrf2+zgtiMArISj1ZCzGEWEJe49WQ+E8TlghKLZu9hhrDF
        JP7tesgGYetInL3+hBHCNpDYunQfC4StJPGnYyFQnANojqbE+l36ECMtJeZ07GaCsBUlpnQ/
        ZIc4QVDi5Mwn4ICRENjMKbFx9iqoXS4SVw8sgtolLPHq+BZoSMpInJ7cwzKBUXsWklNnIayb
        hWTdLCTrZiFZt4CRdRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgYjr97/jXHYwrXn3U
        O8TIxMF4iFGCg1lJhPewqUOqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTU
        gtQimCwTB6dUA1PRAxfzN9dnH1nsEyVXc/G5snzhybaHG4rfTZNz0ZbWuTPn27ktr9hPOlXE
        /GS3PBtxb0v+LJ0/8m//l5/KfVLUELx4+rxonyS1WF9LtfAZzXLSN1QKrL8IVPJbcX1T1uP+
        ue/cp3sHgoI2zvX9qGvvMcfwiO2/7QYpFz5dnPSY+9edKaJVGz4rNL9kV7GTOlfzMNNnwToN
        09qis8secysy3lMUWXTX9PWliilKfqXuEc9D9/v3vbMxkv7af/LVOrbCR//W7Xc4LFi0cWuM
        joONdC3zZX1vvm1VMaa33hXyp377eO9UkMj8PdFaanyrQrO/67sb7n8deeSyX+vbRy3aPNu4
        dvZ+7Hon0vTznrESS3FGoqEWc1FxIgAyKrT+uwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsVy+t/xu7qXWB1TDZ78ZraYs34Nm8XCk8kW
        927eZLY41b2ZyeLyrjlsFjcmPGV0YPPYtKqTzePEjN8sHjdmRXhsPzmJyePzJrkA1ig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jEUH17AUfBKp
        uDP9DnsD4xqRLkZODgkBE4kHh+exdDFycQgJLGWUOLRkEhNEQkZi45errBC2sMSfa11sILaQ
        wEdGia8TVCEazjBKvP4zlxHCWcko8XHVW7AONgFNiX0nN7GDJERAqvYffQaWYBbYzSixYK0o
        iC0sEC7xeNc3FhBbRCBGYsmEw1C2nsTu/22MIDaLgKrEjK0nmEFsXgEriet/b4PNYRSQlXi0
        8hc7xExxiVtP5kOdLSCxZM95ZghbVOLl439QL+hInL3+hBHCNpDYunQfC4StJPGnYyFQnANo
        jqbE+l36ECMtJeZ07GaCsBUlpnQ/ZIc4QVDi5MwnLBMYpWYh2TwLoXsWku5ZSLpnIelewMi6
        ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB9bDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe9jU
        IVWINyWxsiq1KD++qDQntfgQoykwhCYyS4km5wMTWF5JvKGZgamhiZmlgamlmbGSOK9nQUei
        kEB6YklqdmpqQWoRTB8TB6dUA9OqlNDMqAp9puu+M+8G5a42+W9mWRK1T/7iJNGc16rtB0O1
        s8vvnmndZb9PXV8ys8TGuqIsrsum4N7/sO7ynNdXo7nO3bT+veHx2bw5LP//ecr8UXHyjT2x
        62jvGc31k83b6v1v3976+dGO7TcMbE+YfQs9e2Fn/xUf27CJO2fP8Z7Au092ybTGxkcHK8Tr
        94l4Owhtme37w+PXm2Cb6ASHGV7+u2MbD97bFbTXty3VdYeKdlbXMqZHLU/2zWFs3PrQ/dWr
        xVUhh7Z1e3w746573XbO+QlbfW11LQNm/fh6OePowTt91YdOLnnRm6tqWzRxlcYcaWmHzJmT
        t5uqfjOz/OLcbPGPuXp7+1c38wwlluKMREMt5qLiRABvLkBwqAMAAA==
X-CMS-MailID: 20231031134906eucas1p10b45c65d43bc0643116808c916c12c95
X-Msg-Generator: CA
X-RootMTR: 20231031134906eucas1p10b45c65d43bc0643116808c916c12c95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231031134906eucas1p10b45c65d43bc0643116808c916c12c95
References: <CGME20231031134906eucas1p10b45c65d43bc0643116808c916c12c95@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg0KDQpNT0RfVEVYVCBp
cyBvbmx5IGRlZmluZWQgaWYgQ09ORklHX01PRFVMRVM9eSB3aGljaCBsZWFkIHRvIGxvYWRpbmcg
ZmFpbHVyZQ0Kb2YgdGhlIGdkYiBzY3JpcHRzIHdoZW4ga2VybmVsIGlzIGJ1aWx0IHdpdGhvdXQg
Q09ORklHX01PRFVMRVM9eToNCg0KUmVhZGluZyBzeW1ib2xzIGZyb20gdm1saW51eC4uLg0KVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICIvZm9vL3ZtbGludXgtZ2Ri
LnB5IiwgbGluZSAyNSwgaW4gPG1vZHVsZT4NCiAgICBpbXBvcnQgbGludXguY29uc3RhbnRzDQog
IEZpbGUgIi9mb28vc2NyaXB0cy9nZGIvbGludXgvY29uc3RhbnRzLnB5IiwgbGluZSAxNCwgaW4g
PG1vZHVsZT4NCiAgICBMWF9NT0RfVEVYVCA9IGdkYi5wYXJzZV9hbmRfZXZhbCgiTU9EX1RFWFQi
KQ0KICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQpnZGIu
ZXJyb3I6IE5vIHN5bWJvbCAiTU9EX1RFWFQiIGluIGN1cnJlbnQgY29udGV4dC4NCg0KQWRkIGEg
Y29uZGl0aW9uYWwgY2hlY2sgb24gQ09ORklHX01PRFVMRVMgdG8gZml4IHRoaXMgZXJyb3IuDQoN
CkZpeGVzOiBiNGFmZjc1MTNkZjMgKCJzY3JpcHRzL2dkYjogdXNlIG1lbSBpbnN0ZWFkIG9mIGNv
cmVfbGF5b3V0IHRvIGdldCB0aGUgbW9kdWxlIGFkZHJlc3MiKQ0KU2lnbmVkLW9mZi1ieTogQ2zD
qW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg0KVGVzdGVkLWJ5OiBEYW5pZWwgR29t
ZXogPGRhLmdvbWV6QHNhbXN1bmcuY29tPg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdvbWV6IDxk
YS5nb21lekBzYW1zdW5nLmNvbT4NCi0tLQ0KSGksDQoNCkknbSByZXNlbmRpbmcgdGhlIHBhdGNo
IFsxXSBmcm9tIENsZW1lbnQgTGVnZXIgd2l0aCByZXF1aXJlZCBjaGFuZ2VzIHRvDQptYWtlIGl0
IHdvcmsgd2l0aCBsYXRlc3QgbGludXgtbmV4dC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIzMDgwMTEyNTcxNS4xMzk3MjEtMS1jbGVnZXJAcml2b3NpbmMuY29tLw0KDQpJ
IGhvcGUgaXQncyBhY2NlcHRhYmxlIHRoYXQgSSd2ZSBpbmNsdWRlZCBteSBvd24gU2lnbmVkLW9m
LWJ5IGluDQphZGRpdGlvbiB0byB0aGUgVGVzdGVkLWJ5IGR1ZSB0byB0aGUgKG1pbm9yKSBjaGFu
Z2VzLg0KDQpEYW5pZWwNCg0KIHNjcmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbiB8IDkg
KysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbiBiL3Nj
cmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbg0KaW5kZXggZTM1MTdkNGFiOGVjLi4wNGM4
N2I1NzBhYWIgMTAwNjQ0DQotLS0gYS9zY3JpcHRzL2dkYi9saW51eC9jb25zdGFudHMucHkuaW4N
CisrKyBiL3NjcmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbg0KQEAgLTY2LDEwICs2Niwx
MSBAQCBMWF9HREJQQVJTRUQoSVJRRF9MRVZFTCkNCiBMWF9HREJQQVJTRUQoSVJRX0hJRERFTikN
Cg0KIC8qIGxpbnV4L21vZHVsZS5oICovDQotTFhfR0RCUEFSU0VEKE1PRF9URVhUKQ0KLUxYX0dE
QlBBUlNFRChNT0RfREFUQSkNCi1MWF9HREJQQVJTRUQoTU9EX1JPREFUQSkNCi1MWF9HREJQQVJT
RUQoTU9EX1JPX0FGVEVSX0lOSVQpDQoraWYgSVNfQlVJTFRJTihDT05GSUdfTU9EVUxFUyk6DQor
ICAgIExYX0dEQlBBUlNFRChNT0RfVEVYVCkNCisgICAgTFhfR0RCUEFSU0VEKE1PRF9EQVRBKQ0K
KyAgICBMWF9HREJQQVJTRUQoTU9EX1JPREFUQSkNCisgICAgTFhfR0RCUEFSU0VEKE1PRF9ST19B
RlRFUl9JTklUKQ0KDQogLyogbGludXgvbW91bnQuaCAqLw0KIExYX1ZBTFVFKE1OVF9OT1NVSUQp
DQotLQ0KMi4zOS4yDQo=
