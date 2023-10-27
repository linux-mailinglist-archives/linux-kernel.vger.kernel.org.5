Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C106B7D9CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjJ0PUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0PUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:20:48 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85DAC;
        Fri, 27 Oct 2023 08:20:42 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R9IKxs022436;
        Fri, 27 Oct 2023 15:19:54 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3tywsyrs6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 15:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRzTgtMGreKFTzPnYZ26WMfUNQpW2WtJpLujcJykrkeLV2EkdcwcM9gOeQ65v6STXDpuu9DW44KWIhFFKuKXS/lHnCrPmCpDVdtQErTgPuXq+8V6QBs25XxrIahm/q3QSTSF/uaKfiAB8WnmJ/U8BvtzEHwEVHO2V9o4deIW0SYh1E4Bhh9cs6kNLc3YiaBxPls6R88Wd/Dq5AHLBiZsrG85EwF9GxC6dFmAqUILK0UzjITk7Lrja/hwETBrrqFzToLbE1IjSmfLmTAPQ4xY3+vAXbd6GLxmHtWgWjz6fmqwaB62GBOdSVh8PcyxxgtTgiMSsXejXK4Sp3rD8tFreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufz2UbzR2ZEHxjvn3ijG6zZK8JK/Ld2fKMbaOqINEnk=;
 b=VQfAA5j0f0azQyIw2I+ji+JeQxtbSAbqZDERL0EGBgoWzP+4BdDLf455+JibkGpk2DISoad2EoSrGZY0H2MLk4d3jf2K2So7VSa0z6ZvpL/ssIXuXyMtbgRwjr8pPxbauGRx4X1NXkb9C8MFgMoLfqeD+VyEmqNJitErXwpg3yS2AjT9k0ldCgCl0cG/KyhyxFKfNHkkU3bYImgBzU0n/1iy8yxgM3I+aHM/O1fKXMAXm0/KOD0lKgrKx77UIWKY9RfLaLPq+I7sWhDIPflyLKw4WTc5LpWDmDl+4kn0+0f8S5SvWJg11pcUAB9GNN0qLW62QkgCe/WedXWKL0yTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufz2UbzR2ZEHxjvn3ijG6zZK8JK/Ld2fKMbaOqINEnk=;
 b=dwwegxKsvZkEQlswBgq9m6bDJ2yI1qu7AMfVMC/Wn1W8+V3RSns9POAsOncyINaEdbVT6/hw1narLZ9MmBJwBMie/pJR7UyV8gVyxcLEqmxoP1XVt9C9iuYVtnb+g9Lvw1ztKYu7fcEls32d0aT2VjCIomgagZ557OZCUAWBohvol0oTbVQZSakHPdo1rM+H2z6hctox17YnXXIOD8odlZpmeilFBJ80ZxMVHUsrkNS45wO4iJUNChE9c0fgw/qsAW0pwg4iBhO+TeuR9p47wtGwwanZoI+oUG0xSWJISjHQOy/1Kl340/lnRutUmbVqmz9GrjNtapfbX5VjEfkXBA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB2272.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:19:49 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 15:19:49 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio/imu: inv_icm42600: Use max() helper macros
Thread-Topic: [PATCH v2] iio/imu: inv_icm42600: Use max() helper macros
Thread-Index: AQHaCLotoyc7QWxPUkmMouktp0SaxrBdvkrB
Date:   Fri, 27 Oct 2023 15:19:49 +0000
Message-ID: <FR3P281MB1757C4183E5B536D463BAEBBCEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231027094410.3706-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231027094410.3706-1-bragathemanick0908@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB2272:EE_
x-ms-office365-filtering-correlation-id: 6a0d90bd-2ed0-4811-2710-08dbd700290a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUahuovqHykSEWfzY5f6U0Jg0wRRwwiqZfStt8FY02ZBs8oApVG0hvbsrjQAZSGYwmpwLSGYnRjTZYeU65FAaER+J1wZFHvdBPp90iVEoPeTBdJ5FbUz0f8mPcWlQuQ9fmmNstv+psiosfkpnpnRAtzAPVJKCjqzL7+sABImszCEloQ+l5yq+dbhq0yZ82oelw6tdWhdPEV8HSD8F+07RdMEWDvNMk9IhUxLz/cWcCzewjx3E38uvLaA9NfjnwZGm25oePRBxxziv24qv+lyIz4Hcvdh8se7pabWpur0lscr/JENSp8j54NfmbTF4fcfonD90mA5hPrdBd45vkwvZ2L1JDHjv/ulIXFZ1/5eYPu/JFh3vkF6CkK0vSliK0lc1EiDgzWLNAhlnr1wr5QreUaQNzs41uLYMwtk3j+EFoIitTS3cL1U45mooMiGaTAdP7fV/PvJC+jy4VDlstKNoqrKmW7GXQMQUHQxvwMUhR3MvaAWQotM7BJ9qOq8Xh0hTfDMrt8Svh5NAr/J0UrmdRf2ZqSCclezO1Wvm54+jkHwUi6nLNdo9gRnDSLAUdeoQCwhhVQH3MYGRkz0+10JIdKJfSeGXvvsSK1fD8WS+3pv9Jb4oCe749u7VATmBdXM9CgnWcyJ0ei6QVweM8aj6SXZZzUqe8b1V4zMoNGNDDn9PoUMNrMzuDDBKaPzZhpI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(86362001)(316002)(54906003)(33656002)(64756008)(66946007)(76116006)(110136005)(66556008)(5660300002)(66446008)(66476007)(91956017)(4326008)(83380400001)(52536014)(71200400001)(478600001)(38100700002)(41300700001)(7696005)(6506007)(53546011)(55016003)(38070700009)(8676002)(8936002)(3613699003)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hNY1Y1ZGZNNUpWb0cxTmpINXNNSE5UMEt3UDlTYURNYUZ6NEtROTNZaWpU?=
 =?utf-8?B?eHVLZHdWUURrdTlpMTlHcytaQWRtK3E3YkJpMC9iUU02THRXclV6aXpKRFpW?=
 =?utf-8?B?SU1scTVCRGUxemZReVZzRFpwUzlnQzlmMUpQSHN4TXo0Uys3dGcrNHYwMGlq?=
 =?utf-8?B?K1RROWpLNUs2VnFHZFFxWjZybFoyVDVGZWVYZEwxb2ZYeC9wam8vclN3Wmt6?=
 =?utf-8?B?TkFzTnVoMklVZUhXTGRXK2J1OWpoMXY1WXpJR09hcFllSWFhbllKTnI0bGFF?=
 =?utf-8?B?WEc5YVUyR3FMdGluREZ5SFpDVlNacDRMdGg1cWJsY1YwSEFuN3JIdGZYS1Iz?=
 =?utf-8?B?OEJVU1dRVjdBY3ZOZUNxVXpDOUdNWEo3ZUJxQnF3N1lJeFVad3p6d3U3SC91?=
 =?utf-8?B?WWNZK0FUTC80TzJQajAxYjlzc1czM3lIZTdTMGl3YVh1UFkrZ3VXa0F1RVZx?=
 =?utf-8?B?VGtSOEVUcUN2UmpGbkdxNWNEbUc1VndteElPSHVtaFpnbDlzeWdJTjlEbnBH?=
 =?utf-8?B?di9WaGYyaDk0MjU3Sm9kVkhJc0huVDh0a1lYNkQraG16dm9wU2REZGpQNUhq?=
 =?utf-8?B?Ri9xbjhLOVF1cnVvQ1hSR2dib3h0NmlQOU5zdHZsN2JKbEZEKzlPY3RpUGZH?=
 =?utf-8?B?dTN0TkM1SzE1bE50MHNQZ29wd3dKT3NmN2hna0xQR2llSnJSL0ROL3czWHhz?=
 =?utf-8?B?R05jTlBDWEFnaTBJVFpNUm9mS29QWEpUMXdaaFNYZmhvVWZjckdEVWs4czNm?=
 =?utf-8?B?UTdNMWZrczdpemxqQ25NR1ZuSHROb2ZrVXROaFQvNXJ4SUJSMzZ2L2k2OElo?=
 =?utf-8?B?RlJtNTVFU0VUN3hDcjdjSHpadXpMMEM0TGpUaHB2VnRtMlBjRnhRdUY5QlI5?=
 =?utf-8?B?V2J4Z0ZIVGlid1RkRm5lRVNpM283TTZLUERQODc5dk52MGxmWnhQeEV6R3Zs?=
 =?utf-8?B?S2l2OGR3NWpRQ0tYeURDekxJclM4dzdKZmFsMm1LUGZBNVB0RGJvaW5LaitH?=
 =?utf-8?B?VTI5djFCblJDTURDcGd5MkdkZi9RMlBFN3E5U0lPdE9Cak84dmJRWC9kTTd6?=
 =?utf-8?B?RTB0M3NKR21sL3ZHR2d1T1FDbkl1dzc3WXVJdnlBS0ZhZmlSU0RZU3lDVkdz?=
 =?utf-8?B?MzJlYnBhcFZOZXFST3g3eFEwWE5LYkNrMXU3TEdzYmJHNUxlUTkrem92eXdR?=
 =?utf-8?B?ZFM1VnVrYmlmdFI5a1d0aTB0UlNKd2lXMHI2dmZUNkc0RzVjRjYrdlVEZm9r?=
 =?utf-8?B?YXdoMkR0Mm43UTJTUlhWekpwVkNybXpJSDViYVJUYzVaeVRZV2RQUGpablp0?=
 =?utf-8?B?NmJ5cW9yOVlsNm96cEtCTnZKa0RqUy9yN1U4NmxwdVR0NjRERVZhWXQxTHl4?=
 =?utf-8?B?V3dsR05mZCtDd2tTLzdhOEdESkNqdHdoa2FFb2loekVsL0hnWEh0bThFZG1K?=
 =?utf-8?B?SHRYRks2S1FSeG54Z2pPeFNPN1ZudWNiTEpQbWVISFk3cVArZERoK2FiR25D?=
 =?utf-8?B?ZVpDR002aHFaOHRENmM5Q3BYdG5xSEpQMWdPKzAzRUxQODVwMmh2MWJoTURM?=
 =?utf-8?B?V2N6RFFYdk5uMXBsRzlZRmRVTG55UFp6MDI5aTFyMmNKUlp1MjdDb2tDZzY4?=
 =?utf-8?B?MW1nanlaUnJmeGcwVWVRbFlUSExjd09pR0JGQWtYUEFNbXYyM2Q5NXJ4SlI4?=
 =?utf-8?B?aWdFbmZveEZjSEZxOVlNVEF6VG8yM09rSEZGLzVuR3BmdFRFNHBDVnY2bkYz?=
 =?utf-8?B?SkhsajJDcmlzdGNPckMyR1lvSWpmeHZ2RzVuMEdkK3NnZE5rdlYwSnFrVW8y?=
 =?utf-8?B?VDFtc29EZ3d2YTFMSCtsamQyMUxzL1dLMXlKVGMyNGxuQTF4RktFSFBVMXo4?=
 =?utf-8?B?QnJVbmdhSExXcG5uRzJoRE9PZFpMYzc5eVZWM0krb2JyL0Joa2hyMlk2UCtJ?=
 =?utf-8?B?QWJNcTlST0h6eVZBM0VZVmN1dVB0bE1oeHhMNm94VzZZcWIyRmNiOGl3RTNO?=
 =?utf-8?B?N0N0dFhYdnFkTFZHd0RlWEhpOWRsOEU0T21mdjhGM3ZmN041S29pcGJ6MDVa?=
 =?utf-8?B?OW9RNWlaT013QlArWG5IMTVMR2U1NW55R0ttRlZXOFAvRzdnb0o2dmFkbTVm?=
 =?utf-8?B?YVlwc1VZbFl2dy80VzZDcmkwMEU5blRwVFdLSFlSeG1qdWkramdsVmE2VDht?=
 =?utf-8?B?VWJXRmgxNGVjK2xETHpIRjRFU0IvQmR2SXlyTUFqdC8zKzJwQXdHbVdqN1Ja?=
 =?utf-8?B?VUlmbG5sQkxQTkVJK2ZPV0pHeFBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0d90bd-2ed0-4811-2710-08dbd700290a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 15:19:49.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpJL+8niuzRxBql+AUfWDS1XUSrSECfi5gszGqOz+n9byWDwM0OnmYEzqT5mgqtbmhYg0TDLPJiyRMfqWHQsdhxuJnq0cMxyX+uszup6QfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgp0aGFua3MgZm9yIHRoZSBwYXRjaCwgbG9va3MgZ29vZC4KCkFja2VkLWJ5OiBKZWFu
LUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+CgpUaGFu
a3MsCkpCCgpGcm9tOiBCcmFnYXRoZXN3YXJhbiBNYW5pY2thdmVsIDxicmFnYXRoZW1hbmljazA5
MDhAZ21haWwuY29tPgpTZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgMTE6NDQKVG86IEpl
YW4tQmFwdGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUuTWFuZXlyb2xAdGRrLmNvbT47IGpp
YzIzQGtlcm5lbC5vcmcgPGppYzIzQGtlcm5lbC5vcmc+OyBsYXJzQG1ldGFmb28uZGUgPGxhcnNA
bWV0YWZvby5kZT4KQ2M6IEJyYWdhdGhlc3dhcmFuIE1hbmlja2F2ZWwgPGJyYWdhdGhlbWFuaWNr
MDkwOEBnbWFpbC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnIDxsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz4KU3ViamVjdDogW1BBVENIIHYyXSBpaW8vaW11OiBpbnZfaWNtNDI2
MDA6IFVzZSBtYXgoKSBoZWxwZXIgbWFjcm9zIArCoApVc2UgdGhlIHN0YW5kYXJkIG1heCgpIGhl
bHBlciBtYWNyb3MgaW5zdGVhZCBvZiBkaXJlY3QgdmFyaWFibGUgY29tcGFyaXNvbiB1c2luZyBp
Zi9lbHNlIGJsb2NrcyBvciB0ZXJuYXJ5IG9wZXJhdG9yLiBDaGFuZ2UgaWRlbnRpZmllZCB1c2lu
ZyBtaW5tYXgu4oCKY29jY2kgQ29jY2luZWxsZSBzZW1hbnRpYyBwYXRjaC4gU2lnbmVkLW9mZi1i
eTogQnJhZ2F0aGVzd2FyYW4gTWFuaWNrYXZlbCA8YnJhZ2F0aGVtYW5pY2swOTA4QOKAimdtYWls
LuKAimNvbT4gClpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBh
biBVbnRydXN0ZWQgU2VuZGVyIApZb3UgaGF2ZSBub3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQg
d2l0aCB0aGlzIHNlbmRlci4gCsKgClpqUWNtUVJZRnBmcHRCYW5uZXJFbmQKVXNlIHRoZSBzdGFu
ZGFyZCBtYXgoKSBoZWxwZXIgbWFjcm9zIGluc3RlYWQgb2YgZGlyZWN0CnZhcmlhYmxlIGNvbXBh
cmlzb24gdXNpbmcgaWYvZWxzZSBibG9ja3Mgb3IgdGVybmFyeQpvcGVyYXRvci4gQ2hhbmdlIGlk
ZW50aWZpZWQgdXNpbmcgbWlubWF4LmNvY2NpCkNvY2NpbmVsbGUgc2VtYW50aWMgcGF0Y2guCgpT
aWduZWQtb2ZmLWJ5OiBCcmFnYXRoZXN3YXJhbiBNYW5pY2thdmVsIDxicmFnYXRoZW1hbmljazA5
MDhAZ21haWwuY29tPgotLS0KVjEgLT4gVjI6IEFkZGluZyBzaW1pbGFyIGNoYW5nZXMgdG8gaW52
X2ljbTQyNjAwX2d5cm8gJiBpbnZfaWNtNDI2MDBfYnVmZmVyCgogZHJpdmVycy9paW8vaW11L2lu
dl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYWNjZWwuYyAgfCA1ICstLS0tCiBkcml2ZXJzL2lpby9p
bXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9idWZmZXIuYyB8IDUgKy0tLS0KIGRyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5cm8uYyAgIHwgNSArLS0tLQogMyBm
aWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMgYi9k
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jCmluZGV4IGIx
ZTRmZGUyN2QyNS4uZjY3YmQ1YTM5YmViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jCisrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZf
aWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMKQEAgLTEzNywxMCArMTM3LDcgQEAgc3RhdGlj
IGludCBpbnZfaWNtNDI2MDBfYWNjZWxfdXBkYXRlX3NjYW5fbW9kZShzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2LAogb3V0X3VubG9jazoKIAltdXRleF91bmxvY2soJnN0LT5sb2NrKTsKIAkvKiBz
bGVlcCBtYXhpbXVtIHJlcXVpcmVkIHRpbWUgKi8KLQlpZiAoc2xlZXBfYWNjZWwgPiBzbGVlcF90
ZW1wKQotCQlzbGVlcCA9IHNsZWVwX2FjY2VsOwotCWVsc2UKLQkJc2xlZXAgPSBzbGVlcF90ZW1w
OworCXNsZWVwID0gbWF4KHNsZWVwX2FjY2VsLCBzbGVlcF90ZW1wKTsKIAlpZiAoc2xlZXApCiAJ
CW1zbGVlcChzbGVlcCk7CiAJcmV0dXJuIHJldDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2lt
dS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2J1ZmZlci5jIGIvZHJpdmVycy9paW8vaW11L2lu
dl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYnVmZmVyLmMKaW5kZXggNmVmMWRmOWQ2MGI3Li5iNTJm
MzI4ZmQyNmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2lj
bTQyNjAwX2J1ZmZlci5jCisrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2lj
bTQyNjAwX2J1ZmZlci5jCkBAIC00MjQsMTAgKzQyNCw3IEBAIHN0YXRpYyBpbnQgaW52X2ljbTQy
NjAwX2J1ZmZlcl9wb3N0ZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQogCW11dGV4
X3VubG9jaygmc3QtPmxvY2spOwogCiAJLyogc2xlZXAgbWF4aW11bSByZXF1aXJlZCB0aW1lICov
Ci0JaWYgKHNsZWVwX3NlbnNvciA+IHNsZWVwX3RlbXApCi0JCXNsZWVwID0gc2xlZXBfc2Vuc29y
OwotCWVsc2UKLQkJc2xlZXAgPSBzbGVlcF90ZW1wOworCXNsZWVwID0gbWF4KHNsZWVwX3NlbnNv
ciwgc2xlZXBfdGVtcCk7CiAJaWYgKHNsZWVwKQogCQltc2xlZXAoc2xlZXApOwogCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9neXJvLmMgYi9k
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9neXJvLmMKaW5kZXggM2Jm
OTQ2ZTU2ZTFkLi4zZGYwYTcxNWU4ODUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZf
aWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5cm8uYworKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2lj
bTQyNjAwL2ludl9pY200MjYwMF9neXJvLmMKQEAgLTEzNywxMCArMTM3LDcgQEAgc3RhdGljIGlu
dCBpbnZfaWNtNDI2MDBfZ3lyb191cGRhdGVfc2Nhbl9tb2RlKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYsCiBvdXRfdW5sb2NrOgogCW11dGV4X3VubG9jaygmc3QtPmxvY2spOwogCS8qIHNsZWVw
IG1heGltdW0gcmVxdWlyZWQgdGltZSAqLwotCWlmIChzbGVlcF9neXJvID4gc2xlZXBfdGVtcCkK
LQkJc2xlZXAgPSBzbGVlcF9neXJvOwotCWVsc2UKLQkJc2xlZXAgPSBzbGVlcF90ZW1wOworCXNs
ZWVwID0gbWF4KHNsZWVwX2d5cm8sIHNsZWVwX3RlbXApOwogCWlmIChzbGVlcCkKIAkJbXNsZWVw
KHNsZWVwKTsKIAlyZXR1cm4gcmV0OwotLSAKMi4zNC4xCgo=
