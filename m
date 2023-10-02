Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24C7B5446
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbjJBNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbjJBNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:47:24 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDDA9E;
        Mon,  2 Oct 2023 06:47:21 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 392D155w027436;
        Mon, 2 Oct 2023 09:46:57 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tf173p1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 09:46:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFsKxbTdSKc6NuFx7Ls2UMeJ264YTmAntoYvB5zzQPo7eVH238yXMFHIelh/6Y7Ih9jfHZGTqknN9HNajFL50on2ksxjvdAx9sJ2ARldXg3E3thFJvVBllOApA24KqkpoCfHaWctyvLNC7ae9c5NfIewlJc20dmfTiDPmEojN1lytSDiJSoPv0fST6L+MRplTTYD756AJxrgqRGLd78qyStw1KsyzGf8M5+ilMwlivjYK/KTBP/coYR4b23kivBfYimyekFdmFL/I8llMmIw8swiZ+5yQ2nCsJrIopqdh7rn9B0Z7t4bnm/DoQI2DdP6SUln7vu7C8wGQ78Y/38pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8aEZcv02SFjVt7ogqapx+RI7Xm8ZPWY1e7xx6Nli9E=;
 b=L/QWzI/t70PBwA8vmx8txCWRZ3VFxeGmjJLOvYqjawq6ARVXMflSw2Y9KEEg6tO0tR1Ur5qWGGoRipHyGnchF4iUZgAUZoRNgNGbKlM8l67u9G/+XK5ojuYQcC6Z4GRD+CR3e1+i7f7s5m14+9HJTjj/KQowOzC0XDNaNPD9Sp35DeZzIGE8uBbfZSlsAmBKfxdYCaPmuExbkIv2PTrz4vtljQ5cKUsOJfj3SjFT2FkBm7bCBUsFgWNks1pClpxTyEuKhnOCmhfEg9vWuh8UjHvx7AQCYQfwcPkebW6W57XCfiZIGaD5UzHIeR+H/lE5KH4NGR6YgDKCmRymnFCKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8aEZcv02SFjVt7ogqapx+RI7Xm8ZPWY1e7xx6Nli9E=;
 b=0dmlrWbwS4VOVYPWfDHM9rJbB36KBTG7JNg6hJ7WoofRTmnmIAKf+0brqCon2A+AyzfOhcwLxVfJeichj67pNgHSlA34kQJHou5I9pKzkmoEZkns65alpBmJf4nMyaaF/mzuV/pf7wUlCYU+ctT13+Rse0KAwsLAxlZBsv4SMKI=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH2PR03MB5206.namprd03.prod.outlook.com (2603:10b6:610:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 13:46:54 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 13:46:53 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
Thread-Index: AQHZ9RneaXApFz9wS0W13c9REV1TnrA2dqyAgAALTVA=
Date:   Mon, 2 Oct 2023 13:46:53 +0000
Message-ID: <CY4PR03MB33990FB22E1BB8686AC0CF509BC5A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231002101835.39624-1-antoniu.miclaus@analog.com>
 <20231002-babbling-justice-73d3601a71aa@spud>
In-Reply-To: <20231002-babbling-justice-73d3601a71aa@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0yMzAyNzE3OS02MTJhLTExZWUtYWU1YS?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcMjMwMjcxN2ItNjEyYS0xMWVlLWFl?=
 =?iso-8859-2?Q?NWEtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI2MDA5IiB0PSIxMzM0MD?=
 =?iso-8859-2?Q?cyODAxMDkyMjgxOTgiIGg9IlhJeFpUNS90ZlZHN3pEV1I1UENGMUJoYUIy?=
 =?iso-8859-2?Q?QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQ21rRnpsTnZYWkFRaHUvZ1hKVVBrSENHNytCY2xRK1Fj?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBRU9wbE9nQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH2PR03MB5206:EE_
x-ms-office365-filtering-correlation-id: 6704a007-650b-4005-a7c3-08dbc34e0999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oVCuqlKbNBzqUS+DaYnYee+ylJpjtBje40GomP84xGWtjCgFpxEfKPLKK7xe/VtpwHHf41M5AbC+FixlB+y47z9Sj1McpwAgqGUeUKOE0Pl+C1HLPBTuvnLasEpEvCHrOSqrirNIjDQKdNbUB44ChRsfOiaNV/QCUtgECEtGgnLlro3dQcq4EN5PdZhEAoea3nhZb/RgKSg/8yslKMkEMup2LEjOK5Q5tJiVSEGhInSVb8VfGbym8DX3dO8LQxW0tRT6/q5AZVTPrraRDTX7P+i3+CJZGPb6IjBPk2ZIOcVddyqw0swpiDhxbDYyL1MltYYMeQNSx4pUgMSHvWH6yYP/EMqyvBzvSX6gnnECq8S1SjlI4LjviyeKuQt2Q2RSv6dQABtTGKN5+/p1IQi/rVcIxP1X5APQU5q59/Wxx8N6b9HENPeaLBuHthwjuzVgRv1rPKo4qiLgCge8aeWMgOIsmRe2MTlqhDEvB7A5nGdkmMgA+eMGau2GeC4c2Ce7Zwtgn8k/MBbYR/Vk1V4k4avSWesGWanpe8ZxQGhLzSD5T/vjmVgFmzIvVdEZ8Qps0e7KhwwZVxX7HI5dphN8n7gBOWwHBbyzbHzyzmM/jY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(26005)(38070700005)(122000001)(33656002)(86362001)(38100700002)(83380400001)(55016003)(66556008)(66446008)(66476007)(478600001)(7416002)(76116006)(316002)(6916009)(64756008)(54906003)(5660300002)(66946007)(52536014)(966005)(8676002)(8936002)(4326008)(7696005)(6506007)(41300700001)(53546011)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?BMWbaU77BOg2IXgD17ZwBLIHmMnVdiPbDTT/wm0JmixKq9jmhmEjy//hgI?=
 =?iso-8859-2?Q?q9r3yb/qmY1PetBJqfpS7P21c3ZHp2Ksjld2h9oiXnzxA47KuQuByFUZaK?=
 =?iso-8859-2?Q?8V2Ysxx1rz/sRw8GjVrD6STYSnwvWQBOWGxq3JMXFiKvcwdFCxdI8A4u/C?=
 =?iso-8859-2?Q?AcbXQvQvmkUkjGPnK85Fx7dn8jhnyv2PEyyW02BfBNUXHZW6AKc28yw59P?=
 =?iso-8859-2?Q?alE3qo7LVmDwQeggS0ATni3Y7PpiW7lY8HxNwRQdpoB9+KLxLgt2DMzRhm?=
 =?iso-8859-2?Q?f44bxx7ziyxU+MIN4b7irgA8dujPheAcTOy+r1DpIzd7fQJC4hj2asT2Ia?=
 =?iso-8859-2?Q?GDlOlq373sp1f/MB+vacdYwMAUWB3zmxJu9y+htca78tJu94KzV4RWxAbI?=
 =?iso-8859-2?Q?BqLaJdu9+XhHPIwGg9cDRu+7wqUrEqPQlEr2zs/Ik2yeTvdhTEpsIfr3ET?=
 =?iso-8859-2?Q?ZYawHWsf6v3sF0fQkZilYRIYVitMbclwH4QBdOxMpemEMRREJCsyjDs6gf?=
 =?iso-8859-2?Q?me9CHw8elkpIKCj+6AqEB5FR8O/DtLi1b1vJrQMLIe2I44p4IXJqRmd9XR?=
 =?iso-8859-2?Q?8RXv6c0X6zSBWzQ4YxEt+4eHrZuUWb/esEBpBfmdHjK4NgUxVnoERBqjzy?=
 =?iso-8859-2?Q?yFayYsNzndbIj6OuE+mb8bcN+zC8sF7TNOufHRKADTejHLJgbn7YcevsyK?=
 =?iso-8859-2?Q?lxclaHeR9G3800JRPU2/nbU6MPSwTAl4jxXj2ZKhhoEtsJ8GoE52cdzUnH?=
 =?iso-8859-2?Q?BfiR77SJ0m4Uo4kbPjgOYgyYyjGM65BU8HoLLLxU5bC0TtKHpD7Oeqvv4T?=
 =?iso-8859-2?Q?QMx5/ZT/MLjXd9/8EoU5YvgcSH+gSgRaaDBnAIbI3FqkfU6MQMEYxZw4u2?=
 =?iso-8859-2?Q?P4K5YGAa4L9ZmKEz9nEm89jLrBtDJ67OPBp9cgfJlIOLyuwaKC9m8GHXud?=
 =?iso-8859-2?Q?nQrqWoPShqPo0rOEH3DQcrPqMT3RKf8v2wfXoTIHr0NZ2hduMjVI2e+JXV?=
 =?iso-8859-2?Q?Jukg+yyRTbeNBfjcC9YmOhfw/Nlsjj9XCGPrroHQQlTtcXAvGx9fTsSIE9?=
 =?iso-8859-2?Q?lqYZlXSDiKl6dpcbFl4Uhqv+3lIXGtdzdb8HKWfOx5zspWKOZEpX871kLB?=
 =?iso-8859-2?Q?El5fz/nxF89SjQmdNy3HsJNHF/46lAzKSSpdyvgbI5MZsChGY9QuCD1YWe?=
 =?iso-8859-2?Q?BYvwu4Vg0aCvflNMd6GpA1Xi5NW5wc2ykUoyMQLLBsmts/r1G5eAs24Ln0?=
 =?iso-8859-2?Q?Ipp8U9XicRDGcgZWu+mmckeitCsS86P4OJjWGcqxPFf1Zt9AilWXNsJGEf?=
 =?iso-8859-2?Q?9QsDK3IBhXRA2Je02DPePzn+A7IBQU6dyafqYEk/mgck6vTWIo0Ya+7PiO?=
 =?iso-8859-2?Q?CNUMWJKfLgSm0ic02yiqiNwEXByxZHuIwMcJlRM+LPib7XMjvgT+2TFiNS?=
 =?iso-8859-2?Q?4oO8aB9btlL0pzD4Q7ZoEU/FL5LnPalXvy557VvPy5/86pNfSDxwGw1x1V?=
 =?iso-8859-2?Q?ZyPmQ1AE9HdAB8lHGKtu59hAOVIedxc2my+C5LiOGwTshTjbQM2+ITJzQP?=
 =?iso-8859-2?Q?1BYOTAhRf3ovXEomtax653WBmwIZ4moTZju23rDDxxDxpok5adJpgQ7xLo?=
 =?iso-8859-2?Q?h+a2FxIu4yBRMIzbhB55/EW2ZXMdJIait4OqexNuckjQPIP32iadoyKw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6704a007-650b-4005-a7c3-08dbc34e0999
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 13:46:53.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfiuSn2C9kGq55A1mrGnn8kviW0vtnxsWG6vbr0TnL+uvY85DL56amXZ5yrdZf+z+twkyo63bGfJ/rMHKatBhAbRu/Uqsv7pyJAXdj9LXMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5206
X-Proofpoint-GUID: JdjIp7aeAMsiqjV7Yht-YOCeq86yFVUB
X-Proofpoint-ORIG-GUID: JdjIp7aeAMsiqjV7Yht-YOCeq86yFVUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310020104
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, October 2, 2023 4:01 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Jean Delvare <jdelvare@suse.com>; Guenter Roeck <linux@roeck-
> us.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ltc2991: add bindings
>=20
> [External]
>=20
> Hey,
>=20
> On Mon, Oct 02, 2023 at 01:18:14PM +0300, Antoniu Miclaus wrote:
> > Add dt-bindings for ltc2991 octal i2c voltage, current and temperature
> > monitor.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v2:
> >  - make compatible const type
> >  - remove `|` where not necessary
> >  - switch to micro-ohms for the shunt resistor property
> >  - add vendor prefix for temperature-enable
>=20
> Thanks for the updates...
>=20
> >  .../bindings/hwmon/adi,ltc2991.yaml           | 114 ++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > new file mode 100644
> > index 000000000000..3811ea07a04f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > @@ -0,0 +1,114 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2991 Octal I2C Voltage, Current and Temperatu=
re
> Monitor
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +  The LTC2991 is used to monitor system temperatures, voltages and
> currents.
> > +  Through the I2C serial interface, the eight monitors can individuall=
y
> measure
> > +  supply voltages and can be paired for differential measurements of
> current
> > +  sense resistors or temperature sensing transistors.
> > +
> > +  Datasheet:
> > +    https://www.analog.com/en/products/ltc2991.html
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ltc2991
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  vcc-supply: true
> > +
> > +patternProperties:
> > +  "^channel@[0-3]$":
> > +    type: object
> > +    description:
> > +      Represents the differential/temperature channels.
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The channel number. LTC2991 can monitor 4 currents/temperatu=
res.
> > +        items:
> > +          minimum: 0
> > +          maximum: 3
> > +
> > +      shunt-resistor-micro-ohms:
> > +        description:
> > +          The value of curent sense resistor in miliohms. Enables diff=
erential
> > +          input pair.
> > +
> > +      adi,temperature-enable:
> > +        description:
> > +          Enables temperature readings for a input pair.
> > +        type: boolean
>=20
> ...but I did not see an answer to my question on v1:
> 	TBH, this seems like it is used just to control software behaviour.
> 	Why would you want to actually disable this in DT?
> In other words, is there something in that hardware that precludes
> measuring temperature for channels that do not contain this property?
>=20
> Thanks,
> Conor.
>=20
Sorry for missing that. I took in consideration this approach based on the =
pin functions
described in the datasheet (page 8 of 32). For example the V1 pin of the pa=
rt can support
3 different configurations: "V1 (Pin 1): First Monitor Input. This pin can =
be configured
as a single-ended input (0V to 4.9V) or the positive inputfor a differentia=
l or remote diode
temperature measurement (in combination with V2)."
Moreover, looking at the multiple typical applications examples at the end =
of the datasheet
there is a specific adjacent hardware circuit connected to this part for th=
e temperature
measurements configurations.

Thank you,
Antoniu
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vcc-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        hwmon@48 {
> > +            compatible =3D "adi,ltc2991";
> > +            reg =3D <0x48>;
> > +            vcc-supply =3D <&vcc>;
> > +        };
> > +    };
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        hwmon@48 {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            compatible =3D "adi,ltc2991";
> > +            reg =3D <0x48>;
> > +            vcc-supply =3D <&vcc>;
> > +
> > +            channel@0 {
> > +                    reg =3D <0x0>;
> > +                    shunt-resistor-micro-ohms =3D <100000>;
> > +            };
> > +
> > +            channel@1 {
> > +                    reg =3D <0x1>;
> > +                    shunt-resistor-micro-ohms =3D <100000>;
> > +            };
> > +
> > +            channel@2 {
> > +                    reg =3D <0x2>;
> > +                    temperature-enable;
> > +            };
> > +
> > +            channel@3 {
> > +                    reg =3D <0x3>;
> > +                    temperature-enable;
> > +            };
> > +        };
> > +    };
> > +...
> > --
> > 2.42.0
> >
