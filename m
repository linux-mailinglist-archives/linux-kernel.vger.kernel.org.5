Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA637FCF12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjK2G2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbjK2GZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:25:46 -0500
X-Greylist: delayed 16084 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 22:25:51 PST
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B31BC5;
        Tue, 28 Nov 2023 22:25:50 -0800 (PST)
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
        by mx0a-00823401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ASITVhV005413;
        Wed, 29 Nov 2023 01:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        DKIM202306; bh=EgEGo7rmJcNI2yKT0pJLX1aCEoMTPQ8Wx97vnCdy+jw=; b=i
        jeoHXGLcdGI43dPkH+1JKjHz67uiSSBAlsFcQUgr/igrKYELLzd8GDPyYCuemnu2
        JAm1wYXaI68aLtTEp3aDbF+2ekW6LYS+bTXMQQHjai9ZOxN4ew58fVTbuIJId5EM
        ziL6b8WcuMExGIKtCSFRhX5OpXVWusDs90wcbOXhjuCbkhJsV5GoBGO3IIvepN2+
        XhUInN+NeYG4Srv0Q/7qIMzJc2afzoqwX6sYnQDxrTW7RI7nkqY8E+tXOnDba3Qt
        rBWTRVwkyb4zXKpyvofEhQUjeT12heRAqFE703bOQ5ETOtXu3BjDefQQP0yeOpMa
        7WlDqm59JkAPayVP/n6Nw==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
        by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3unnhhrk36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 01:57:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu1Z712G2NFMUoPhKeTDgQVt9QdJV/lXfG+giJzkzmzK+gMbKiev2nE9BmWZUskq3JjaBtYRwyTRfd5e6/4ILsDAlrviZwC2d0adCm6LMO/JBH66R5pvZy5iDeSlOUck6n1oYNzY1Vxy9cZHJISu9MrhMDNFOKHt/ho+6UjTqk8larb4LqT4q0+pxaU1FGmn9DKEGkC1qPEu9veElCHXmCZDQaumr0vzSl4sl8KPNnmsrRceWpv/PldeXDqV/RTvjUznVPHfpI3vbXjWh71nJEuSWWP0mlX6a+amWvjm5712prz+wWyc9Z1mH3ZlgEcHuwCPWzEG9hp2EkZrgiV7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgEGo7rmJcNI2yKT0pJLX1aCEoMTPQ8Wx97vnCdy+jw=;
 b=cEkdhFLHA3BdZlbhBaIyYqgL/4MhIZ0BUmlpCZ2zRw4pWxMzNJq0alPbuWpQ4oSvNdNkbvLFRTOWRF759umr+y3nJay2sgc8apEbSNyRCa/9YsfCczn5eCZhn9e+7GmZCjdQOuxiEtsML/wwnb+/Old3gGfNpsnxh47Nq8c0InYtiR7ny7SpPdZ4TsvGHX2EcPm+RIOA2tfwYmU5ucFPxcm0E0vLs0y+YzKYgsGCENaZdQMAiI3CVvOso1Ck8HLIEcNbq5IGha0XQiHcpwSz0+tsI5lObDSywaQcx7A6EkpYyP6w2HCYUuvi4UvOF4aqcpVzi0mNTytTjAyuPRuJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TYSPR03MB8047.apcprd03.prod.outlook.com (2603:1096:400:470::14)
 by KL1PR0302MB5268.apcprd03.prod.outlook.com (2603:1096:820:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 01:57:29 +0000
Received: from TYSPR03MB8047.apcprd03.prod.outlook.com
 ([fe80::4697:2b94:9758:fed2]) by TYSPR03MB8047.apcprd03.prod.outlook.com
 ([fe80::4697:2b94:9758:fed2%3]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 01:57:28 +0000
From:   Peng Peng17 Liu <liupeng17@lenovo.com>
To:     Len Brown <lenb@kernel.org>
CC:     Peng Liu <pngliu@hotmail.com>, Wyes Karny <wyes.karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0hdIHRvb2xzL3Bvd2VyIHR1?=
 =?utf-8?Q?rbostat:_Fix_Bzy=5FMHz_calculation_equation?=
Thread-Topic: [External] Re: [PATCH] tools/power turbostat: Fix Bzy_MHz
 calculation equation
Thread-Index: AQHaCt7p9vvhs2feAEGbE56ndQD/OLBnLZsAgCf0PYCAAZaRgA==
Date:   Wed, 29 Nov 2023 01:57:28 +0000
Message-ID: <TYSPR03MB80472502DBB4A9DBD2FF7E8ECE83A@TYSPR03MB8047.apcprd03.prod.outlook.com>
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <002801da0da1$adb83fc0$0928bf40$@telus.net>
 <CAJvTdKmJRsWzr8MSZdUv+1AA8AXBAoMF_CaNDAJE5EgThP5+EA@mail.gmail.com>
In-Reply-To: <CAJvTdKmJRsWzr8MSZdUv+1AA8AXBAoMF_CaNDAJE5EgThP5+EA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8047:EE_|KL1PR0302MB5268:EE_
x-ms-office365-filtering-correlation-id: 61b46bab-09fe-490a-42da-08dbf07e8ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKkbNH27mUe8iqPs4E5qBE9ifmHdD0ejJZ8Xe5NcZSqptfqB6JNJPb81NGYU4x6TX1C0w9fNc7eoY3/TFDw2WxvOPgMSgrv7kJwd7FAWtb/k/qHe8N0mttZSg9kpeXpZsuDQAV61T/jZETbkI7qZVJobKhDiFkfKe8Jwlb5lIsZDgCvSg1568f/wnKUNIKPMssnEd+J2+jvb/VIyUhDy3pgfIaQeLTF+QjPQ1gA0seC/OTNBBnBG0sHWaGuws5y+CIC300aqps6pVAy0v8358sNy8NoXRzqVxKG/qQLvy+6+un+LT1AVwdA7j9FsXZSes5nA3N7uhiJaAx4oKcDjSyUB9Zbh2DpkS4tiumBRSQiEhcwFmaAbgG+x7mrL5Pbc8vnc7Dllawb2f1UvGSxfwnnJfi5DS2MnKCzeECWiz9RIDbrpyMlmtTGAZidR3AXjot3Cjmh3YnDPoS4VsVERsrn2PPRzoUSf4F2xapmEUCwTNxB5oa3zQMEib7rMU5C5oLU1LAHcpF/lRDcYE2yYOT9Z/TrCjVVDPa5w61A+RTCFmlvy00sKQo948jcQ/Uc2Z+hoecabTwTU9kX8MOinbHqavUdpkebqLlOPeyuNea4tnbVxV9b1XLCj5NvGHikJ29TyihSiJhcgjVocc5EcVy86pxIuhvZUoR62JpIqM0BjcSzOnz4AbY8QtbPtmXU9ZefhqrDEa72JuwiJhVWJpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8047.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(966005)(83380400001)(122000001)(38100700002)(82960400001)(45080400002)(52536014)(55016003)(9686003)(6506007)(4326008)(5660300002)(7696005)(8936002)(66946007)(54906003)(316002)(6916009)(66556008)(76116006)(66476007)(66446008)(53546011)(64756008)(86362001)(478600001)(41300700001)(33656002)(2906002)(224303003)(38070700009)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUdtWnR0M1cxSkZ6aTBydWVoc25rUnJrM0U0S3hub2ZXbFMzNGhteTg2MTZ3?=
 =?utf-8?B?aU15ckIzN2JlS0hTcmVYK2V2UGdhRzVWbUxVc2Nodm9sSVpURzAvM0VjY2Jw?=
 =?utf-8?B?SHdYTFpJWkR2NDR6Z3hXaDd5bmRUVVRzdTVoR0lvMUw4ZjR1VXlia2EzRHNX?=
 =?utf-8?B?blI2RDV4WDlYTVVWQnNKKzQzWW5RNGdUQ1J2QnFMSlo4ZVZDZ09oTmhIVWU2?=
 =?utf-8?B?WHoxY2hURTVmWGVxdW1LRmNReTVhTGp0am5GSWRwK25wWWtybi8ya01icE5i?=
 =?utf-8?B?ajFCaG5LenFBZjRERGs2T0NnR3VXdldIVXJ2S1hFekJsRnFNQURUN1lwc05t?=
 =?utf-8?B?bkZHeVVnNjFHb0kySnR2aElJQnU0ejQ4OEVPeklDVjZ3cHRtTm5PM0hBTDJ2?=
 =?utf-8?B?N3BjcnV5RytWdmFiSlkvdDZXaVdZakJlQ2VGQUZmRFd6MlVtRUhGc05DSG9F?=
 =?utf-8?B?ZUtZL3dzTDRxN3A4VGNsUDFkZWlzanl4OXRSMm8vY3FHN0FjMnYyeW5Ec0xO?=
 =?utf-8?B?a3FkTjNYU0s4M0wydDcwdmdPNDhqNzBJMzBJOWhIWURoLzZrMGxDbkkvUWhP?=
 =?utf-8?B?T1ZnN0hxNVM4ZTRRcW9zc0Zia2JudStNbnFoWXlaejZ3KzVQa3FnMnAxQ1hL?=
 =?utf-8?B?NXVXR1U1QkRvOVhjeVorSUtLc25VYXJ3K2xHYXB0N3A1MlFvUHNENHJBb3Yy?=
 =?utf-8?B?SlVLMkFzczVaUSs4bzhVV0RkZGUxbXlQUUsrVlRod1cwTDdjbHBNN2l1T3RH?=
 =?utf-8?B?aGI0bDNIaDhZY0htWVFmcDhGTVBMSStPUCs2eW43bGVtdTV1WGdYZSs0am4y?=
 =?utf-8?B?MU5MUXk3eHpvR3BCcGhWZE9GeUVnVEI1RityY3pWby9uL2ovT1pCU3hsRld0?=
 =?utf-8?B?SDh0TXdVR3I1RUczejlyUGVwY1lMbVd5ODJtQUhvazhNcjlHcXpsVXo0eU1R?=
 =?utf-8?B?L1YrM1VyVmZjSVhLNjlmY00zcWNCSDl4dWpLZFZZU0JzbFgvTjBtV2NROVJl?=
 =?utf-8?B?ZzA4QzJuNm1NSTFNayt6SXlyYTBDeEZnOW9pVy9hYjRaTmhJd2ltWTFMLzV5?=
 =?utf-8?B?c0JYUHNxckFjYXBiTDJIT21uZEo2N0lYNWRzVmZKeG85WHl4YmJCWXBleE5U?=
 =?utf-8?B?NWF1c3hFQi9MYXZtZVNJRitNbEtKaDhCWlVnRXFFdGpKVkRreEc5R2k0ai9v?=
 =?utf-8?B?UWo3Y2MyN0dzYW5zZTRzL0pBZzNHRStSdk9oQXFEd0hvTHVhS2ozRmswSlBt?=
 =?utf-8?B?M0pkUVBCd3FidW03UlBFdkFkbkNpV281aWovS0VMcXZPNnpWenEvVGdhREpU?=
 =?utf-8?B?RmsvcjYrM3dsQWRTWGo2OHRsYk52Q1RsZkY1NE1iUGhMZXVLeE9hN0tSbith?=
 =?utf-8?B?QU94MmE5TU55dzM3bnpmQTdKNXRuYWR3bk4vRUlmUTlINzNUK2R4U3ZDamha?=
 =?utf-8?B?c1lYTThrSFJzMXVIVmkyOGZvTlBWZ0lNT3k4S2tWcmxTN0hwVFNTN1ZXaHh3?=
 =?utf-8?B?alpDRFJ5R0RZSGNKYmNEUWJ4d01JVGp0WmpqQnd3SEZzdVVGYWJ4ZHc3Y0dq?=
 =?utf-8?B?S2VYY2lMTk9FaEtiOHRkOXZWYXpMMW42enU3bXlRNUlLUU41Qzk1cHpGNGRU?=
 =?utf-8?B?Um56dFdaaERFVjVHNW1YY1UreWQxUS9id2g5Z3dqM2YzZjVFVmFtMDM4Z3o1?=
 =?utf-8?B?Y1RiLzJPTmJFcElEUUloNE8zelgzOW5aREhReVMyaUhoL3RYYVZCSHBsTmpj?=
 =?utf-8?B?SFA4WUlOalBFRU1jV0x0b0dNZDZBdW4wZmdlZDNBZGZtZzJQQzE2YXNRVlNp?=
 =?utf-8?B?MG1oT1hhaE1GSlBlOVd3ZHVJUisyZlM4UVdMOFVJN1NJWHZDbkVxa21Lc2I5?=
 =?utf-8?B?ZERpZkZIbE1Cd1RaRllwd0VhTGlvcitkaVdNQzJSdWw4cGswdjBrb0wrMjJq?=
 =?utf-8?B?NTRUZnlrSit2dm5DYnpOWHRCenMwQStkbW5yS29iajZoUWpMY3pwK0JUZ0di?=
 =?utf-8?B?RCtoQ1BFMUZEREdyU2hWR3crb3hlaHdoTzYzbDREaG9NQ00ydHF6amRpck52?=
 =?utf-8?B?cjBLWUZSTHhMS2lSOEZZN1hBQ0sxR3lkMEJ4a1lnYnkvbWFPaVZsMmt6T2l4?=
 =?utf-8?Q?MQIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8047.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b46bab-09fe-490a-42da-08dbf07e8ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 01:57:28.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It13CfAkgdfzX8UY3WQyCxiTscZHQj/dpwitwdL2GUsgcHSDrs51Wsp9vyh/WG+dpwR2L3zS5S3Pq1sOPiJWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5268
X-Proofpoint-GUID: PBtYirGlfS6DQT5h-a7I2bMQi3QErFcV
X-Proofpoint-ORIG-GUID: PBtYirGlfS6DQT5h-a7I2bMQi3QErFcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=-20 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311290013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGVuLA0KDQpUaGUgbmV3IGNvbW1pdCBtZXNzYWdlIGlzIGJldHRlci4gVGhhbmtzIGZvciB5b3Vy
IGhlbHDwn5iKDQoNClJlZ2FyZHMsDQpQZW5nDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWP
keS7tuS6ujogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDIz
5bm0MTHmnIgyOOaXpSA5OjQwDQrmlLbku7bkuro6IERvdWcgU215dGhpZXMgPGRzbXl0aGllc0B0
ZWx1cy5uZXQ+DQrmioTpgIE6IFBlbmcgTGl1IDxwbmdsaXVAaG90bWFpbC5jb20+OyBXeWVzIEth
cm55IDx3eWVzLmthcm55QGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBlbmcgUGVuZzE3IExpdSA8bGl1cGVuZzE3QGxlbm92
by5jb20+DQrkuLvpopg6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSF0gdG9vbHMvcG93ZXIgdHVyYm9z
dGF0OiBGaXggQnp5X01IeiBjYWxjdWxhdGlvbiBlcXVhdGlvbg0KDQpQZW5nIExpdSwNClRoYW5r
cyBmb3IgdGhlIGNsb3NlIHJlYWQgb2YgdGhlIGRvY3VtZW50YXRpb24sIGFuZCB0aGUgcGF0Y2gu
DQpJJ3ZlIGFwcGxpZWQgaXQsIHRob3VnaCBJIHJlLXdyb3RlIHRoZSBjb21taXQgbWVzc2FnZSAo
YmVsb3cpIHRvIG1ha2UgaXQgY2xlYXIgaXQgaXMgYSBkb2N1bWVudGF0aW9uIGZpeCwgYXMgdGhl
IGNvZGUgd2FzIGFscmVhZHkgY29ycmVjdC4NCg0KdGhhbmtzLA0KLUxlbg0KDQpwcy4gSSB3b3Vs
ZCBoYXZlIHJlcGxpZWQgdG8geW91ciBvcmlnaW5hbCBlLW1haWwsIGJ1dCB0aGVyZSB3YXMgYSBw
ZXJpb2Qgd2hlcmUgZ21haWwgZHJvcHBlZCBtYWlsIGR1ZSB0byBzcGFjZSBsaW1pdGF0aW9ucy4N
Ck5vIHdvcnJpZXMsIGFzIERvdWcgc2FpZCwgZXZlcnl0aGluZyBpcyBpbiBwYXRjaHdvcmsuDQoN
Cg0KICAgIHRvb2xzL3Bvd2VyIHR1cmJvc3RhdDogRml4IEJ6eV9NSHogZG9jdW1lbnRhdGlvbiB0
eXBvDQoNCiAgICBUaGUgY29kZSBjYWxjdWxhdGVzIEJ6eV9NSHogYnkgbXVsdGlwbHlpbmcgVFND
X2RlbHRhICogQVBFUkZfZGVsdGEvTVBFUkZfZGVsdGENCiAgICBUaGUgbWFuIHBhZ2UgZXJyb25l
b3VzbHkgc2hvd2VkIHRoYXQgVFNDX2RlbHRhIHdhcyBkaXZpZGVkLg0KDQpPbiBUaHUsIE5vdiAy
LCAyMDIzIGF0IDExOjMx4oCvQU0gRG91ZyBTbXl0aGllcyA8ZHNteXRoaWVzQHRlbHVzLm5ldD4g
d3JvdGU6DQo+DQo+IEhpIFBlbmcgYW5kIFd5ZXMsDQo+DQo+IEp1c3QgZm9yIHlvdXIgaW5mb3Jt
YXRpb24gYWJvdXQgeW91ciByZWNlbnQgInBpbmcicyBhYm91dCB5b3VyIHR1cmJvc3RhdCBwYXRj
aGVzOg0KPg0KPiBQbGVhc2UgYmUgYXdhcmUgdGhhdCB0aGVyZSBpcyByYXJlbHkgYW55IHJlcGx5
LiBUaGVyZSB0ZW5kcyB0byBiZSANCj4gYWJvdXQgMiB0dXJib3N0YXQgdXBkYXRlcyByZWxlYXNl
ZCBwZXIgeWVhci4gWW91ciBwYXRjaGVzIGFyZSBpbiBwYXRjaHdvcmtzIFsxXSwgYXMgYXJlIHNv
bWUgb3RoZXJzLCBpbmNsdWRpbmcgYW4gb2xkIG9uZSBvZiBtaW5lIGZyb20gMjAyMy4wNC4wMyBF
dmVudHVhbGx5IHRoZXJlIHdpbGwgYmUgYW4gdXBkYXRlLCBhbmQgaG9wZWZ1bGx5IGl0IHdpbGwg
aW5jbHVkZSBhbGwgb3VyIHBhdGNoZXMuDQo+DQo+IFsxXSANCj4gaHR0cHM6Ly9hcGMwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiBo
d29yay5rZXJuZWwub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBtJTJGbGlzdCUyRiUzRnNlcmllcyUz
RCUyNnN1Ym1pdHRlDQo+IHIlM0QlMjZzdGF0ZSUzRCUyNnElM0QlMjZhcmNoaXZlJTNEJTI2ZGVs
ZWdhdGUlM0QxMDcmZGF0YT0wNSU3QzAxJTdDbGkNCj4gdXBlbmcxNyU0MGxlbm92by5jb20lN0Ni
NGNkNjFiMDFlM2I0ZDhiNzlhZTA4ZGJlZmIyZjUyMSU3QzVjN2QwYjI4YmRmOA0KPiA0MTBjYWE5
MzRkZjM3MmIxNjIwMyU3QzAlN0MwJTdDNjM4MzY3MzI0MTIzNzQzODk2JTdDVW5rbm93biU3Q1RX
RnBiR1pzDQo+IGIzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QNCj4gJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1uc3c4dndW
Mm9TQU9CVkdXVHU2UEFGZU1QaHBuWk04QVh0elhXcG9hUmd3JTNEJg0KPiByZXNlcnZlZD0wDQo+
DQo+IC4uLiBEb3VnDQo+DQo+IE9uIDIwMjMuMTAuMjkgMDg6MTIgUGVuZyBMaXUgd3JvdGU6DQo+
DQo+ID4gUGluZw0KPiA+DQo+ID4gT24gMjAyMy8xMC83IDEzOjQ2LCBQZW5nIExpdSB3cm90ZToN
Cj4gPj4gRnJvbTogUGVuZyBMaXUgPGxpdXBlbmcxN0BsZW5vdm8uY29tPg0KPiA+Pg0KPiA+PiBU
byBjYWxjdWxhdGUgQnp5X01IeiwgVFNDX2RlbHRhIHNob3VsZCBtdWx0aXBseSBBUEVSRl9kZWx0
YSBpbnN0ZWFkIA0KPiA+PiBvZiBkaXZpZGluZyBpdC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogUGVuZyBMaXUgPGxpdXBlbmcxN0BsZW5vdm8uY29tPg0KPiA+PiAtLS0NCj4gPj4gICB0b29s
cy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC44IHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuOCANCj4gPj4gYi90b29s
cy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC44DQo+ID4+IGluZGV4IDhmMDhjM2ZkNDk4
ZC4uMWJhNjM0MGQzYjNkIDEwMDY0NA0KPiA+PiAtLS0gYS90b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC44DQo+ID4+ICsrKyBiL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVy
Ym9zdGF0LjgNCj4gPj4gQEAgLTM3MCw3ICszNzAsNyBAQCBiZWxvdyB0aGUgcHJvY2Vzc29yJ3Mg
YmFzZSBmcmVxdWVuY3kuDQo+ID4+DQo+ID4+ICAgQnVzeSUgPSBNUEVSRl9kZWx0YS9UU0NfZGVs
dGENCj4gPj4NCj4gPj4gLUJ6eV9NSHogPSBUU0NfZGVsdGEvQVBFUkZfZGVsdGEvTVBFUkZfZGVs
dGEvbWVhc3VyZW1lbnRfaW50ZXJ2YWwNCj4gPj4gK0J6eV9NSHogPSBUU0NfZGVsdGEqQVBFUkZf
ZGVsdGEvTVBFUkZfZGVsdGEvbWVhc3VyZW1lbnRfaW50ZXJ2YWwNCj4gPj4NCj4gPj4gICBOb3Rl
IHRoYXQgdGhlc2UgY2FsY3VsYXRpb25zIGRlcGVuZCBvbiBUU0NfZGVsdGEsIHNvIHRoZXkNCj4g
Pj4gICBhcmUgbm90IHJlbGlhYmxlIGR1cmluZyBpbnRlcnZhbHMgd2hlbiBUU0NfTUh6IGlzIG5v
dCBydW5uaW5nIGF0IHRoZSBiYXNlIGZyZXF1ZW5jeS4NCj4NCg0KDQotLQ0KTGVuIEJyb3duLCBJ
bnRlbA0K
