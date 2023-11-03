Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19A7E0A41
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378244AbjKCUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378188AbjKCUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:45 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199F11AA;
        Fri,  3 Nov 2023 13:18:40 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231103201836usoutp025e89f242c06b081ff5bac6a305f0d8a1~UNlktMzv93064030640usoutp02e;
        Fri,  3 Nov 2023 20:18:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231103201836usoutp025e89f242c06b081ff5bac6a305f0d8a1~UNlktMzv93064030640usoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699042716;
        bh=e576S7CjUbGKecjfqTWMMj9uJ2tcdjBzvms2BDsK5HE=;
        h=From:To:Subject:Date:References:From;
        b=nBgAGflDJ4sG+S2Ydm84dQ4uOb8E2o5HLGxyXh4dTN+1sEsca9y4wVXOe0TIDygCp
         0npUkeRm+bay2I/v45YSbA5EuXTv0utfXU12CrtjEDroe+okM3EYTaStHF1vX3etj/
         aJowKkLz7j7h9UpkL/TlK5QQEBnW3pkYCLTD3xG4=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231103201835uscas1p2f0d035fbdfbef7ec88cc2af5cb6355c7~UNlkVVGJO1816418164uscas1p2H;
        Fri,  3 Nov 2023 20:18:35 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id BF.B6.50148.B9555456; Fri, 
        3 Nov 2023 16:18:35 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73~UNlkBjrnr1793517935uscas1p2I;
        Fri,  3 Nov 2023 20:18:35 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-7c-6545559bddac
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id BF.39.31410.B9555456; Fri, 
        3 Nov 2023 16:18:35 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 3 Nov 2023 13:18:34 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        3 Nov 2023 13:18:34 -0700
From:   Jim Harris <jim.harris@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/region: fix x9 interleave typo
Thread-Topic: [PATCH] cxl/region: fix x9 interleave typo
Thread-Index: AQHaDpLrd95Ds0IdwU+fCUHJLUtW4w==
Date:   Fri, 3 Nov 2023 20:18:34 +0000
Message-ID: <169904271254.204936.8580772404462743630.stgit@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6CB9ED8511BF54EBEE8C50A5BD025F2@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917d70aq+taepphuTJMcDlMulSGlSOjFIuCMEiX3lSac22u
        NKhmZE2LsodWm2jrQWZLU1bpsLRplj00yoYu7KEzW096CuIi513kf9/z+J7zOT9+FC4w80RU
        ljKXVSvlCjHpR9xs/9UZYdwoYyP7mucyfQNPSeZ06VPEPOgtIJmrvWbENA8OEUy1yU4yXYaH
        BPPcWk4yjpJ2LNY3/kDbZ178hSYXFl9q3Bf/oz44iUj2W5rOKrJ2suoFy1L9MjvPuJDKQuWV
        d/eROnSGKkYUBfRCGLyztxj5UQL6CoLB1mEfLijEwOW+jBUj3/Gm9oohjCuYERyqv0hywTcE
        Z3tO8LjgEoKjR++RHgtJz4eRbvO4RUg341BbZUGewjQ6CvpGm3CPFtIMWOuaeR4QIS2Ba9cz
        PWmCnguOZ0U+Hs2nV0BFm2lcIzoAhh+ax5FwOhAczkovnj+cN3IjYaznj/UtyekQeD3s8vGM
        x8d4aq0LOOsyGDlmR5wOgVOH33pX+UPHWSfBWWfA3aoewoMPdAsFL01d3plx8LHT6N0bBKfN
        z72G7XClVo9xb6oCXdt6Lr0ETKO1XuQp4B7pR1wLH/QHBSVIbJhwjOE/qGECqGECqGEC6DnE
        q0aBWo0mO4PVSJXsLolGnq3RKjMkaTnZ9WjsQz3605rdgBoc3yQ2hFHIhoDCxUL+8jVxrICf
        Ls/fzapzUtRaBauxoSCKEAfypTEdaQI6Q57LbmdZFav+V8UoX5EOu6y88aIwAc9bafi+JXl2
        SgtxcpJ2ZkCwQonxnHbBK6ttW0zSnFu2rsVR0in6pragS9gFaYLLLsq9lXhoUk3YzXPWzbqp
        +9dawqZf7De/GVLNMoXWhQi7C1LNKvsRZWKNY5VUlv+ICqVzI+LCI9x4Hf7B/2r0DnVV5OjW
        dxZW92MTCl8sCVpfZpImHugvcVc+Dus9JXvmnr0uueh3Z/Sv97bqHke48WXscXJtx8ryrI17
        Mpyh82Q/BzZE55Xu89ffCZ6cViYaTIkVT5dZ8iNbv76/XTzwRN27Q+/8guU05hQVRd13HUuq
        yUxViFZn9Yu17kpjdeEiuP0ucnljwKckMaHJlEvDcbVG/hfjY9D5vwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWS2cDspDs71DXV4E8zv8XdxxfYLKZPvcBo
        ceJmI5vF6ptrGC32P33OYrFq4TU2i/OzTrFYXN41h83i1oRjTA6cHi1H3rJ6LN7zkslj6ux6
        j8+b5AJYorhsUlJzMstSi/TtErgyzs14yViwhaNizpW7bA2MMzi6GDk5JARMJI7Ne87UxcjF
        ISSwilHi/sFeZpCEkMBHRolJ8ysgEksZJXbtaGECSbAJaEr8urIGrENEYD+zxPoVWxhBEsIC
        xhJ3/+wB6xYRsJDYtXE/axcjB5CtJ7F2QwZImEVAReLWpU52EJtXwEli3pGFYDajgJjE91Nr
        wOYzC4hL3HoynwniOgGJJXvOM0PYohIvH/9jhbAVJe5/f8kOMp4Z6J71u/QhWu0kfvVfY4Sw
        FSWmdD+EWiUocXLmExaIVkmJgytusExgFJ2FZNsshEmzkEyahWTSLCSTFjCyrmIULy0uzk2v
        KDbOSy3XK07MLS7NS9dLzs/dxAiMy9P/DsfsYLx366PeIUYmDsZDjBIczEoivI7eLqlCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEee8+0EgVEkhPLEnNTk0tSC2CyTJxcEo1MNkrmexSWipa8WRu
        2xHT5ZPnr/p08eYndrd37I+4lFICu79Jis/6oR366uGjSddmuTnnn5qdpaxo4fT3ufdaVUGZ
        C5ZzDs3xYtJYU3kv9t9qI3se3mfqG5MTrjE942Z8I7FBTzE4btcDmyzx7/aTuD2CZ7xv3xiV
        emX/dlfBT4bbeV7Pj24QZr+hvuTaz0Vf+BLVOzuCPmbXbtxcIcR4bmry5S1x5usa/WRZrvLV
        mU+U7e/85OMeNY8nL+Qhu5xOQ6H+97sJGwVWX2Au+hZ6xMfmQxrPvm6vWyI1ebeYBOfmblMt
        e9p3LsOKy3zD7t3dgivOr/66mdf5Qudj7UdHou79+P6+JmTp9jUTYs5MDldiKc5INNRiLipO
        BADdnwsEOgMAAA==
X-CMS-MailID: 20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73
CMS-TYPE: 301P
X-CMS-RootMailID: 20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73
References: <CGME20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73@uscas1p2.samsung.com>
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

Q1hMIHN1cHBvcnRzIHgzLCB4NiBhbmQgeDEyIC0gbm90IHg5LgoKRml4ZXM6IDgwZDEwYTZjZWUw
NTAgKCJjeGwvcmVnaW9uOiBBZGQgaW50ZXJsZWF2ZSBnZW9tZXRyeSBhdHRyaWJ1dGVzIikKU2ln
bmVkLW9mZi1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2
ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKaW5kZXggNmQ2M2I4Nzk4YzI5Li5kMjk1
YjM0ODhlNGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKKysrIGIvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYwpAQCAtNDAzLDcgKzQwMyw3IEBAIHN0YXRpYyBzc2l6ZV90
IGludGVybGVhdmVfd2F5c19zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCXJldHVybiByYzsK
IAogCS8qCi0JICogRXZlbiBmb3IgeDMsIHg5LCBhbmQgeDEyIGludGVybGVhdmVzIHRoZSByZWdp
b24gaW50ZXJsZWF2ZSBtdXN0IGJlIGEKKwkgKiBFdmVuIGZvciB4MywgeDYsIGFuZCB4MTIgaW50
ZXJsZWF2ZXMgdGhlIHJlZ2lvbiBpbnRlcmxlYXZlIG11c3QgYmUgYQogCSAqIHBvd2VyIG9mIDIg
bXVsdGlwbGUgb2YgdGhlIGhvc3QgYnJpZGdlIGludGVybGVhdmUuCiAJICovCiAJaWYgKCFpc19w
b3dlcl9vZl8yKHZhbCAvIGN4bGQtPmludGVybGVhdmVfd2F5cykgfHwKCg==
