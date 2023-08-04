Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C7770A26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHDU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHDU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:56:44 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D110CA;
        Fri,  4 Aug 2023 13:56:43 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374Ko6D0016685;
        Fri, 4 Aug 2023 20:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=zOVmxPOl86l1+eDR5lwoFeA8Qub82bLNY9Or6KTuxJY=;
 b=jc3sDvyfjlXDyT3R1BDjgupTJHIMvleuvWsys270FfsdP1IDxI4vZ/JtYf754KszekE0
 Y3h9BXHzi/2ntCe1gP+3S+RDFY4SdS5NDCe2ozZUn+a6aYpFL8Relz0/SL0gFxEf4aNZ
 ZpjLT82mGgNWm29Qou1Hsd3DwI6uZR/xIB3dh8TfsbpQTuoen7B9cd9ViekpBWiUx0NY
 zFe4K/v10ztVrv3mt/MuDfCtsaJIyESuoAakYkyKH3+GAvxylwIFVYPRXHD+1l30gvGD
 1wAlrrvi9acqU1kFLugvL5CMJap9o0ROcHFKQ5FK7oCDRNYxrdKdboYPTbEAKGCYivJT yQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s96rjgw8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 20:56:23 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CFA85D2E5;
        Fri,  4 Aug 2023 20:56:07 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 4 Aug 2023 08:56:00 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 4 Aug 2023 08:56:00 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 4 Aug 2023 08:56:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDC0qzmnso69B4anGV4jv0GheK0Mk91ny+3fChQ0wNKA3NYCjEqVeZecKmevgEiyK62vtVxpgPwMBubl6asmT7D1l4I6/wdQEIend2lnj6TNs4WebhjGoDYIM5V2bCNbPR9xsx3LT/sXNsA4RcWf3RMCCO3DytIQuc9BPP/ESLcfN7IUiX8h7L0xhnyfMaf9GyANOciBOvfde0TVdFfRbwGXty8eviEzFPpxCwJ2Aq/Bn0OrAg4kqCTzOd+lJy3ZXScgBUeg0HzIdUUJ5pSGBQFP0t1lL5x2fjnF+u11F6e2ueEUuE3JG+OwNCmxAwQTWww8ni1+oGAlbib0Oq1ZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOVmxPOl86l1+eDR5lwoFeA8Qub82bLNY9Or6KTuxJY=;
 b=Gd2iJOHcj8WNDtAxFQ5Le2PbSNxyjUVPCi5puFwLrp3iEMbhE/HOZd5wNLcmwkQ+57OSsS+0I++/RfD/YMpWw8SxM7qvrK600avYZ9GrIoxYAwL9lm7fzlc2EO1h9RPmZ0xBksyeKX0l2wPl1H5KDqgRa2Tyr4LGylNUsXn28XtcgF0l+SF56ODMqMr2B0zyEMZqSDy+YamKtj2usJZZBJKH4lRAeX3YbNTs112H7vxh11ZeJHLq5te1vpuPI0qdobmLVoKXDp3i3oqwoBuYr2FUetPILm4rhfqsJb9ttbHfeTxHC75xCUxt7S3+UjIg71xPmYsdzl+sTN3nsz0y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1720.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 20:55:58 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 20:55:58 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZxX8FQEkQXvMN30SqHDZcFt7as6/XpOCAgAEA6IA=
Date:   Fri, 4 Aug 2023 20:55:58 +0000
Message-ID: <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
 <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
In-Reply-To: <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1720:EE_
x-ms-office365-filtering-correlation-id: 0a396971-94d9-45cb-5aff-08db952d3425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJhsC5g/db3RpMQ7Wlcz0cWPp+hTwUXghXF1CFso8joViGyv32rmwaQektsKmPUWHQINxiIOCRVEjRZBeagrNA7mQ50eI7xfgVwF+uHJfl2tc3oZzBPp6I1hOU7Ra40DZweizyXQW+awowbAR+E0WrJdIxAVr7p3vWygvpmWZAjkzeA218vdDPePld1E9yLWTrDd7RpXYaAdQr4InSz8adelFxuCoXF2Jsxi95377uMgj5jyChAPUOeOm6XlYdkSjI4kzVrZqtPWj+CNxoKshk+KzTRTBY66rNwCqB7o35AkMpRDxfiZLsuQw269UOigBOxI/HAaMuWb8Sc2uQApXZMEfE5BwiyrpCo4OYgazzFdGavi/QNP+L6u2mbIfwr/S5DuoRrVEvLd/yD+EZkZyCffcwODyKEdIJEt7tKMj0a4NMsLzyCDXCdE8mQIJ/N7kZzsRVkXaekaWZRUnlg0gkt+tGLXdkmRWJxccD0of3+tvmnInIxRjG0lqIuvnSsgoZTzazpYWgBjt15uQS/44Ct/vTzMky81+Mu8BOwJG1bGMTbrl2lic9VBIlrJuX8vu2BJ9/ery0h+NRCTUGbNOpDDxblzPFCXs3SZyyUnob6mvQbgbog2LZbtJTq61t8ACj8oCDhYf6kKuG+oAlq66A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799003)(451199021)(186006)(83380400001)(2616005)(6506007)(8676002)(66476007)(6916009)(4326008)(2906002)(91956017)(316002)(76116006)(66946007)(5660300002)(66446008)(64756008)(66556008)(7416002)(8936002)(41300700001)(966005)(71200400001)(6486002)(6512007)(478600001)(54906003)(38100700002)(82960400001)(122000001)(36756003)(33656002)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1JxQk10d3YyY2M2WXhzYmtnaU90RkNyZ1RzbnRhNk5hdkhCUHp4bEZoTnR0?=
 =?utf-8?B?WWNVV0ZTNG5GL1h6UjA0RHBtQWxDc3FTeDU1K2ZSWk5YTHZvTFBjemNCVDU0?=
 =?utf-8?B?NFN5TVpPaytURFlzOUY3SlRXQWpQTnR5TVpqUklYaXR1ZDV4OFZPTlNyTXZV?=
 =?utf-8?B?Tkp4dEc1Sk9kVXE0U0NVSFZ1T2tKU01IWVNvMUF0ZFJ6YjQ3ZEZyengzZFdI?=
 =?utf-8?B?MjhzeVdHcUg2dyt1K0FXUVdweVJ0Mk1CdzZYeWFpdkI4V1lMMlJWRURsOTUx?=
 =?utf-8?B?cGVyelNqRjYzQURiZFVGYU9XQ1JnTkZSNjB5MUszK2cwZE1TRG1aeVlmeWFS?=
 =?utf-8?B?ZGQxNzdDZ1puVWttYXVDbmxGNTBRdlBDbWlMSzM3dEo0MzF0WmZldEVKYnJJ?=
 =?utf-8?B?REpvVkd5VUFtVDFtNlA4MHRybTRGbktrSUR6UlZkNkJHdlgvSEtOV2NLb1VP?=
 =?utf-8?B?U2dSRFNMdjFOMTk1Zm5ZMDBnc0VTS2ZoeDN3bEkvTlNWYlNCck5obERyeGFp?=
 =?utf-8?B?OFVXRTE5Y1htNUQyN3FPTnlPSXlQL3kvQm5OaThvSkJMenNvV2RRQkVnRUg0?=
 =?utf-8?B?Yy9SdU81eXlEQXlRd0NFSGo5RjhaL0NiclBNSE5FRVhZVkQ5Z3lkYkZtUWlE?=
 =?utf-8?B?bTlVZlVLeTRwczlUMlBiTWN4VE5xVW95TE9UMjd6Ym9kdEVQZmVIamc5Y1hu?=
 =?utf-8?B?ZkdOT2xpcGtGTWNBV1FWQjJNZVZwT2VHN3BTWVVKREMwVTBIcnVYc0ZjZXhQ?=
 =?utf-8?B?UUlBWFRGV0JVUm9kYmt2OWtjZDhPbG1uZGtlK2NWZjVJaDRsK0M3YWkySVg1?=
 =?utf-8?B?NlZ2cXl0Z01idzVMY1RlaHFpSEwrQ05NYzREV2lLTUdhS3FEcTAyYjdsa2x2?=
 =?utf-8?B?eFo2NEtUY0lObXkwaFR1YTZWa21sNzhGa0o1UFg1TGtJZkljeERuOUtnSnBu?=
 =?utf-8?B?UkJic2NIY0xEYi93aVZacFQ2alZGNk5BaERKdVFKeTA0QUJaQm1rZm1mazVm?=
 =?utf-8?B?NHI4RWZiSGk5YU9FanBLK1NmT1UvYTJhS1oyNjJveUN0aEJGT0E1VDlXcUxE?=
 =?utf-8?B?QXk5MDB3d2pTdFA1RU94Uk1JMXlGWUhoTHNBMWFOK3dUWTh0TjgvOVI1NUZa?=
 =?utf-8?B?eG1Sa0d4SFFFRVhzRWhicDYzcVB5RDZMTitxcG5aMDh3Mkl4NHcyTFF0bWUw?=
 =?utf-8?B?OGR1ejF3WGZCd2ZzU2NQQ1pVTWk0QXlQdXprZUxjN3YvbTNIUXZPTG4wckZM?=
 =?utf-8?B?ZjF3VDl3RVlPRGpQdkVIVE9PMjV5R3dGWWEwUFZqK3U1bXF6N0ticHdnVFZ1?=
 =?utf-8?B?a1MxR0UrREJvbXoxVUFZZU1vUzREMG5qTEhDbEt0Z3NwWHJrdXVyRFBrbStH?=
 =?utf-8?B?UjV2TGgxZjdSYVU0U1VYOEZkMkE0Wkx6MmtscXhOU2hMMXhkSTVrUFlNcHRk?=
 =?utf-8?B?Y2F0a0NzampNYklJc1lEQW5RdlBKVER1emtKYnBOQ2p5RWpxbStMWHlLWGwv?=
 =?utf-8?B?L0FOTDhOdXQ1c1V6RnFWNkhNQjFxa1d0UGFLSHdyOURPN1orMzNoMDBWb2h0?=
 =?utf-8?B?UldMTkZIVUVHYXlrS2NrK0tlMXFJR2U1cTk5aUJiU2VnR29PUzh6QXVQU1U4?=
 =?utf-8?B?NG9SbEo4ZXUySkRsdHlzbVNOODVwTDM3Snl0ZU9XN2RibDE5c1RKbTY3WHVO?=
 =?utf-8?B?V1FNWE10WDNwTGIvUkxjTXRGdUhoR2xRczBIS2JaMW5XZjlocGxNanVjYWh4?=
 =?utf-8?B?dWhGZlpZcXpIMVlTekI1dm5WVkY0U0RoMkRlUGh3Q01HOUs0dHVqSjAvbitP?=
 =?utf-8?B?SE9kanBhMzA2K01HdEJZcHlSeVdoREFlQWJCVTMwektJRkl5VTBPUGFpVDZm?=
 =?utf-8?B?a3JXT1ZuWnluTXFlbGJOQVBxeFAvbHgzNnd4bkFJUXdVTzlzREo0YlhsUld0?=
 =?utf-8?B?NlNOWHJmamZwa0pId0hTZEZlTFkycWFxSVBVMmptYlZ5OGwvQnRUZFFPZVJ0?=
 =?utf-8?B?bEtZUVYvL3crZXZiOVdMaEgzRnRaM3o2c1pkSlVCRnhyd2NEeXFEOFJQL1hC?=
 =?utf-8?B?L0g5OExBNHZMRFE2V3Fxa0svR3E3TE9SZEZ5RWkrZFM3LzQ5L1FnUEkxVDcw?=
 =?utf-8?B?TG5La2dvWVVuOEtoajdEUVMrU1N3bXhtTC9JREpqMkJ3TWxMZVFpZVIzRCtC?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0336DCB98D50F441B9FCC92589D3150A@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a396971-94d9-45cb-5aff-08db952d3425
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 20:55:58.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+FMvozomv563uuWFooy5bsKrVaBtsBjoBkPGUhQaikqH5m93HuEP4YTUqI5dyDkGSgigNO6qKFi6b5RE0gxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1720
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: i5chCkICRYh-qaZm1dNZEl5R2Snxx3E-
X-Proofpoint-ORIG-GUID: i5chCkICRYh-qaZm1dNZEl5R2Snxx3E-
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JlZXRpbmdzIEFuZHJldywNCg0KRm9yIHNvbWUgcmVhc29uIEkgZG8gbm90IHNlZSB5b3VyIHJl
cGxpZXMgZm9yIHYxIG9mIHRoaXMgcGF0Y2ggb3INCnRoZSBtZGlvIGRyaXZlciBvbiBsb3JlLmtl
cm5lbC4gQXBvbG9naWVzIGFzIEkgZGlkIG5vdCBpbnRlbmQgdG8NCm5vdCBhZGRyZXNzIHlvdXIg
cHJldmlvdXMgcmV2aWV3IGNvbW1lbnRzLiBNeSBtaXN0YWtlLg0KDQo+PiArc3RhdGljIGludCB1
bWFjX2ludF9waHlfaW5pdChzdHJ1Y3QgdW1hY19wcml2ICp1bWFjKQ0KPj4gK3sNCj4+ICsgc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoeV9kZXYgPSB1bWFjLT5pbnRfcGh5X2RldjsNCj4+ICsgdW5zaWdu
ZWQgaW50IHZhbHVlOw0KPj4gKw0KPj4gKyB2YWx1ZSA9IHBoeV9yZWFkKHBoeV9kZXYsIDApOw0K
Pj4gKyBpZiAodmFsdWUgJiAweDQwMDApDQo+PiArIHByX2luZm8oIkludGVybmFsIFBIWSBsb29w
YmFjayBpcyBlbmFibGVkIC0gY2xlYXJpbmdcbiIpOw0KDQo+IEhvdyBpcyB0aGUgUEhZIGdldHRp
bmcgaW50byBsb29wYmFjayBtb2RlPyBUaGUgTUFDIGRyaXZlciBzaG91bGQgbmV2ZXINCj4gdG91
Y2ggdGhlIFBIWSwgYmVjYXVzZSB5b3UgaGF2ZSBubyBpZGVhIHdoYXQgdGhlIFBIWSBhY3R1YWxs
eSBpcywNCj4gdW5sZXNzIGl0IGlzIGludGVybmFsLiANCg0KSXQgd291bGQgb25seSBiZSBpbiBs
b29wYmFjayBtb2RlIGlmIGl0IHdhcyBwcmV2aW91c2x5IGNvbmZpZ3VyZWQNCnRoYXQgd2F5LiBJ
IHdpbGwgcmVtb3ZlIGl0LiBUaGUgUEhZIGlzIGludGVybmFsIHRvIHRoZSBBU0lDIA0KYW5kIGlz
IGFsd2F5cyB0aGUgc2FtZS4gR2l2ZW4gdGhhdCBpbmZvcm1hdGlvbiBpcyBpdCBhY2NlcHRhYmxl
DQp0byBjb25maWd1cmUgaXQgaGVyZT8gSWYgbm90IHdoZXJlIHdvdWxkIGJlIG1vcmUgYXBwcm9w
cmlhdGU/DQoNClRvIGhlbHAgcGljdHVyZSB0aGUgbmV0d29yayBoYXJkd2FyZSBsYXlvdXQgSSBo
YXZlIHVwbG9hZGVkDQphbiBpbWFnZSB0byB0aGUgaHBlIGdpdGh1YiB3aWtpLg0KaHR0cHM6Ly9n
aXRodWIuY29tL0hld2xldHRQYWNrYXJkL2d4cC1saW51eC93aWtpL0luZm9ybWF0aW9uLWFib3V0
LXRoZS1CTUMNCg0KLiAuIC4NCg0KPj4gK3N0YXRpYyBpbnQgdW1hY19waHlfZml4dXAoc3RydWN0
IHBoeV9kZXZpY2UgKnBoeV9kZXYpDQo+PiArew0KPj4gKyB1bnNpZ25lZCBpbnQgdmFsdWU7DQo+
PiArDQo+PiArIC8qIHNldCBwaHkgbW9kZSB0byBTR01JSSB0byBjb3BwZXIgKi8NCj4+ICsgLyog
c2V0IHBhZ2UgdG8gMTggYnkgd3JpdGluZyAxOCB0byByZWdpc3RlciAyMiAqLw0KPj4gKyBwaHlf
d3JpdGUocGh5X2RldiwgUEhZXzg4RTE1MTRfUEFHRV9BRERSRVNTLCAxOCk7DQo+PiArIHZhbHVl
ID0gcGh5X3JlYWQocGh5X2RldiwgUEhZXzg4RTE1MTRfR0VORVJBTF9DT05UUk9MX1JFRzEpOw0K
Pj4gKyB2YWx1ZSAmPSB+MHgwNzsNCj4+ICsgdmFsdWUgfD0gMHgwMTsNCj4+ICsgcGh5X3dyaXRl
KHBoeV9kZXYsIFBIWV84OEUxNTE0X0dFTkVSQUxfQ09OVFJPTF9SRUcxLCB2YWx1ZSk7DQoNCj4g
VGhlIFBIWSBkcml2ZXIgc2hvdWxkIGRvIHRoaXMsIG5vdCB0aGUgTUFDLiBXaGVuIHlvdSBjb25u
ZWN0IHRoZSBNQUMNCj4gdG8gdGhlIFBIWSwgc2V0IHRoZSBjb3JyZWN0IGludGVyZmFjZSBtb2Rl
Lg0KDQpJcyB0aGVyZSBhIHBhcnRpY3VsYXIgZnVuY3Rpb24gSSBzaG91bGQgYmUgdXNpbmcgdG8g
YWNoaWV2ZSB0aGlzIHdoZW4gSQ0KY29ubmVjdCB0byB0aGUgUEhZPw0KDQpUaGFua3MsDQoNCi1O
aWNrIEhhd2tpbnMNCg0K
