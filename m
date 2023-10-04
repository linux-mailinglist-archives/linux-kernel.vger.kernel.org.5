Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2457B7D73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJDKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjJDKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:42:09 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4EA1;
        Wed,  4 Oct 2023 03:42:05 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3948baLg000457;
        Wed, 4 Oct 2023 06:41:11 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tgtsjm56t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 06:41:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRyAz8HRDIWSeyVrWtP8W8fH4m7DMXUFr469FN/IlS6l5wirVOJ4+9WbXEbeFKz6IUZDpH0p7IgEYraAft/7iuy/8DR92aPZ78h1YDP8k1bZcvtsZUEj0MrZ1dsA1tvFHHDkdUgjA7qdN1k7Uu0eg9lFLywlz21Kj41Fq6YzgU82yIXpaJgkZ3sckX9S68dhhSh/IeM56pDz9NDAet76plGK5T4YqHWMRYtd6C1R0O/pKZ0xqv+XwIl1fZFBS7nH137KIwSiH9d2JPD/iXz3PC6YoPk907yAjlSO2wiFWkO4JbOS3PCyTOdhhNRagxOsDfVUtiRU5XPyCP80RyArGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gt3vyLJiXhPPsZavIzdHhpYBmtV+X03RkxXMpuMlCY=;
 b=eHmGD1C/zS8Le6Z3du6xO0mMQpqIKvf1S8p3pO2auK2b7jfy2Thd+/2lsuYPlkRU1LQhVwf70c+rEe1Xcy1y35mp0dqCRCs6U1piY06pqN3q+pfVL+rjp+GYgLx3YqBdv+u3UyK8xRbMgaBIbsLd4G8KJmY/j+T3lK3hQ/hzNxrzlKvLmacsvLQvOs0Ge17JXRYFGK/MPPUN1YETEMJmLzLZdZm91odxWZKflPeit6CZUuwUjDRxGiZ96mJZ+f/hkLL2tma7PDVm8MkXATlxQtbjOk4jzvsxukIwvw9nAoCCYV94sOrrrMd18MM8TY9X/wPFzaINoztuU0pYWuSbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gt3vyLJiXhPPsZavIzdHhpYBmtV+X03RkxXMpuMlCY=;
 b=7iGNztM3+uevyBb7u/E9tL3EYKiWjFjhe0Zz9/pUqCCgnnaLTwGvBlYU1Lro3avtURx4BEEXiIfrZ+lDZ9Cuh5KaMkwxZjLOPiuRC7JRgNncYPMDe8y4r5Fnrs00aUYwHbSosGbKwGlqUjGA86juSmRro3auKMWgGewNHs4VLuU=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BY5PR03MB4967.namprd03.prod.outlook.com (2603:10b6:a03:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 10:41:07 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::b34d:a248:7b9a:c625]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::b34d:a248:7b9a:c625%5]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 10:41:07 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: RE: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Thread-Topic: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Thread-Index: AQHZ8voiHr0CPygis0qlB8JK4Lezn7AzcHuAgAYH0hA=
Date:   Wed, 4 Oct 2023 10:41:06 +0000
Message-ID: <SN7PR03MB7132D8899A862B7D4D475F848ECBA@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
 <20230930153429.0387ab8c@jic23-huawei>
In-Reply-To: <20230930153429.0387ab8c@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04MmM5YjA3OS02MmEyLTExZWUtYjgxZS1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTZcYW1lLXRlc3RcODJjOWIwN2ItNjJhMi0xMWVlLWI4MWUtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE2Ym9keS50eHQiIHN6PSIxOTAxNCIgdD0iMTMzNDA4ODk2NjQ0?=
 =?us-ascii?Q?ODM5OTMxIiBoPSJzeVd4bzVqOTJHSUlJZWRpVjNjS2t6MDhkNW89IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUQ3ZVdSR3IvYlpBVWNXMDZoYndhV2ZSeGJUcUZ2QnBaOERBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BY5PR03MB4967:EE_
x-ms-office365-filtering-correlation-id: ac7d5923-4d8f-4ecd-1cbe-08dbc4c66a45
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gm5sE6xFKhg2qRQMPG6XXjO4cULvMqoQc6lHCexrcdD74PVbieMk5oqaLtmd0fAkT9KylobeW3HTcoHdZo0FHZIHY4KXqu5QL3kQhD5DdSI0Fv3OPSWjN6ljVzjQqVANYaRscq1gMap+lNimH/h2bQqBmJHUFxCyDY+MUvwo+5vXDjcnVIusQQxmFtmfZa8r8brooQVsMRZDfWC1Flw0vAipfG6d+qjDSke/t6/2SuxNQ2+gBh8bi7Wesfllyh3eV599TFeddrW70u/K/OGBdM17a+CYgn4aKPke8t6Z9IKrBDjPwNvEeGF2zbRXsqQQG8tWytw9cL4x369E//yst7MOVMNdQtaUysOd3xc/nQQ/pLstbTRPt/7gqJ4MhgHhqrjdV0wS7BfhTWB0fG+wkO+kdQxl+hG7hvW/pANIDWmettqKF9Yi6OI3cq2VKrSj+bRnePhvOcg9UJ7bNupE4xLfOucJx462jLMT1fKIycH5loJtYETM178GxxVTIt3YYKBYLHJdlRDv2yMXUm5mxfSeqovfYrNPTfVEZy+6NIfydPjRxl0O7CkVGkpaQm2Jesmfh1wrDDxeiaI8dIcxRFhcyzJFSC3GFEVo/1Nd32I8xf+ILdPmp8rK0IxY1j1CJfgIh8QQCN6fQc4yXIdkp5YWzZH4ZvX5Q/ZhB4lcfsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(66899024)(7416002)(38070700005)(86362001)(33656002)(38100700002)(122000001)(55016003)(53546011)(316002)(66476007)(54906003)(76116006)(66446008)(66556008)(64756008)(9686003)(6506007)(7696005)(66946007)(110136005)(41300700001)(966005)(478600001)(52536014)(71200400001)(4326008)(8676002)(5660300002)(26005)(8936002)(138113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7eQtH6knqCGDJ6xoBrNtgOxPock4vzcgaLP2SaB/AMGg8aPKIh29i7SGAmPz?=
 =?us-ascii?Q?qVUlocJ9jxA3Lc/dQPlYq24NOstGAgVYNd1zLAf82comD2AvvpwcQy1/GCUb?=
 =?us-ascii?Q?nlFnebgj+5uSaHcyYDY82b7Z4FbVrv60BPLdgPfbqOyjFIVlQIM5hn1uM9O0?=
 =?us-ascii?Q?dWq+09IcbZe/cUu0p7vkOSn0tGrLUq2kCEdvkWdhqAe3mloKCAPATtKZQJ5r?=
 =?us-ascii?Q?5p2mdrJV/8qnAEph3PhRk8M7lbDRH+Co7yJIOCXbAE85DdrTtxeill1MT9gE?=
 =?us-ascii?Q?pHKSrRjJxBoV8k2ADZv1OtrA7ucqlxPgyze0XPIksvLzNvJO/pHMDcjxt/iW?=
 =?us-ascii?Q?k0Y1G68w00m5DB3Vxorv56womEzkAd9sJFef3FF8xJsMRT1MwrvjD97IASGC?=
 =?us-ascii?Q?+I2R0D4Qq1pehtzKVZuUcmy0ZGxqgO2Snf+BceiENXbWVXb+MUg4lgoaX8EZ?=
 =?us-ascii?Q?+LYcnyeDwHWO75enk6k49ijmlxcoMOv0Z8jmy5yVQAl6S/s3+gzcsONJmmTX?=
 =?us-ascii?Q?QyBjfxYeE/4nyFqfC/2PjR3W/iceji8fnGQNhkWX/PQXOQzv6fhbz1/Nzhzl?=
 =?us-ascii?Q?rndoR9rgorzXzJBGFD0sSKY5B8oZm0RRXzQ/o/5PM1V2VrbMPuA4EuNsoFSg?=
 =?us-ascii?Q?SXF6GRLeSTGbjEUFvE+kGNvd+PS809PrQbnJpqgL9EzaYVMogSM1ukVncPWc?=
 =?us-ascii?Q?UfqhnIZNJOb/CFfEJ4VBydASPMNYfJffOCmGitPMDThcIytWDai7SEmRZNGI?=
 =?us-ascii?Q?J8Cny9Qu14lt/b2C//eqrIxWKudPYaYAilW2dtEsdSY2iIKy8tTRiSkrl3Yf?=
 =?us-ascii?Q?uBIdsZwHr0l3a2k+WJDNC3u/iUhf9mLlWrhT7/77iGKyrIPrZytyioXRJ0gp?=
 =?us-ascii?Q?RxaVim2NsdNeamXhDCGy86vvn9v3IaqrY2jK+B81IVjuD6fESvg8SaOlKhG+?=
 =?us-ascii?Q?AUE2y6nDmKm1EYY1x2zLBtJNLPmqmMSu0yChxSM6AExXROrCnfzW4ePc+m8Z?=
 =?us-ascii?Q?iyjH4Y5x9/L2LBw+gOtRDVgTbLRCI+maxy/z6sRL2sEHElP2X2XoWU7/PIVx?=
 =?us-ascii?Q?wUronu3HgS38glR1VVjdktc9ngtSr0l5w+cKcOoNsgu0gDYQ7hxZanhsMZ/T?=
 =?us-ascii?Q?9Jz6WZnBd5Z7gWMJebZZE7eTmw1ewNaVz45XO/UEHdjmwGmDHKuAMr5KGLtt?=
 =?us-ascii?Q?yNloJSROiD5uKcMptvKCp+SJBvvBpHXj39Dp5wCNAZ2KlbttZP2vhfmoLHzX?=
 =?us-ascii?Q?0Be6C4VfogiwrCqQG2nJ0PmGengKZG6F9ENdZz1i6sANa2MXVmAfdveuhfL+?=
 =?us-ascii?Q?nwInwTc3CbvWgkUW0ZR6VcfMYjYLpvpqkRAV6LK+TnUOvB3Hhlj9pIxJD8PQ?=
 =?us-ascii?Q?tHzaj5gvzq6dpGOwFwdiaRyO6ZOmdaRchYqL2nfFYHL7sn3HvyY5QmdnWsfS?=
 =?us-ascii?Q?EGSIdyjTwNVyEvqlbtZ/6H+qCiOoTLo4F0CEgNmeXRH16Q1h1pe5vzdYUwi/?=
 =?us-ascii?Q?TH0mjowuB6pECrGtp1ukjM0R1egDPjXQJiyIaeCq+UUnHp1nno9WZyHdKKnB?=
 =?us-ascii?Q?IBRBlccJaHHxa6oB6frtpA1wOeQmFQXbsr9NKkBcJS5L1qXerIa+pYvDKzUL?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d5923-4d8f-4ecd-1cbe-08dbc4c66a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 10:41:06.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddPuBs3XuKzr2+uvBJjUU23JLlaJRFzzY8/ZAwf0mg2lwWhT2GHpfitmklQgOmW8IAFwtWdUdfC2+OCNV7l7KQibjRWm4+djF/J+2tBqaaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4967
X-Proofpoint-GUID: 71mZCSyTGx9YT4Kf8PWjSsYF1WQF9bAP
X-Proofpoint-ORIG-GUID: 71mZCSyTGx9YT4Kf8PWjSsYF1WQF9bAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310040076
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Samstag, 30. September 2023 16:34
> To: David Lechner <dlechner@baylibre.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> staging@lists.linux.dev; David Lechner <david@lechnology.com>; Rob Herrin=
g
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Axel Haslam <ahaslam@baylibre.com>; Philip Molloy
> <pmolloy@baylibre.com>; linux-kernel@vger.kernel.org; Apelete Seketeli
> <aseketeli@baylibre.com>
> Subject: Re: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
> bindings for ad2s1210
>=20
>=20
> On Fri, 29 Sep 2023 12:23:06 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > From: David Lechner <david@lechnology.com>
> >
> > From: David Lechner <dlechner@baylibre.com>
> >
> > This adds new DeviceTree bindings for the Analog Devices, Inc.
> > AD2S1210 resolver-to-digital converter.
> >
> > Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>=20
> Michael, ideally I'd like your ack on this given it volunteers you as mai=
ntainer. If
> I don't hear I'm fine with leaving Michael listed because he's in MAINTAI=
NERS
> anyway covering these bindings via a wild card entry:

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>=20
> ANALOG DEVICES INC IIO DRIVERS
> M:	Lars-Peter Clausen <lars@metafoo.de>
> M:	Michael Hennerich <Michael.Hennerich@analog.com>
> ...
> F:	Documentation/devicetree/bindings/iio/*/adi,*
>=20
> So any queries should hit Michael anyway.
>=20
> LGTM but I'll also want the dt binding maintainers input before picking t=
his up.
>=20
> Jonathan
>=20
> > ---
> >
> > v3 changes:
> > * Expanded top-level description of A0/A1 lines.
> > * Added required voltage -supply properties. (I did not pick up Rob's
> >   Reviewed-by since I wasn't sure if this was trivial enough.)
> >
> > v2 changes:
> > * Add Co-developed-by:
> > * Remove extraneous quotes on strings
> > * Remove extraneous pipe on some multi-line descriptions
> >
> >  .../bindings/iio/resolver/adi,ad2s1210.yaml        | 177
> +++++++++++++++++++++
> >  1 file changed, 177 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> > b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> > new file mode 100644
> > index 000000000000..8980b3cd8337
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> > @@ -0,0 +1,177 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/resolve
> >
> +r/adi,ad2s1210.yaml*__;Iw!!A3Ni8CS0y2Y!_mSGRdlDHlqAKev0r38paa3K51l2k
> G
> > +o8bShqK2TH4nAF_cYu2WixIa62xv0p-A70086DQmj4oN9FWvOlk78$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!_mSGRdlDHlqAKev0r38paa3K51l2kGo8bShqK2TH4n
> AF_c
> > +Yu2WixIa62xv0p-A70086DQmj4oN9FWzdE10U$
> > +
> > +title: Analog Devices AD2S1210 Resolver-to-Digital Converter
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +
> > +description: |
> > +  The AD2S1210 is a complete 10-bit to 16-bit resolution tracking
> > +  resolver-to-digital converter, integrating an on-board programmable
> > +  sinusoidal oscillator that provides sine wave excitation for
> > +  resolvers.
> > +
> > +  The AD2S1210 allows the user to read the angular position or the
> > + angular velocity data directly from the parallel outputs or through
> > + the serial interface.
> > +
> > +  The mode of operation of the communication channel (parallel or
> > + serial) is  selected by the A0 and A1 input pins. In normal mode,
> > + data is latched by  toggling the SAMPLE line and can then be read
> > + directly. In configuration mode,  data is read or written using a
> > + register access scheme (address byte with  read/write flag and data b=
yte).
> > +
> > +    A1  A0  Result
> > +     0   0  Normal mode - position output
> > +     0   1  Normal mode - velocity output
> > +     1   0  Reserved
> > +     1   1  Configuration mode
> > +
> > +  In normal mode, the resolution of the digital output is selected
> > + using  the RES0 and RES1 input pins. In configuration mode, the
> > + resolution is  selected by setting the RES0 and RES1 bits in the cont=
rol
> register.
> > +
> > +  RES1  RES0  Resolution (Bits)
> > +     0     0  10
> > +     0     1  12
> > +     1     0  14
> > +     1     1  16
> > +
> > +  Note on SPI connections: The CS line on the AD2S1210 should
> > + hard-wired to  logic low and the WR/FSYNC line on the AD2S1210
> > + should be connected to the  SPI CSn output of the SPI controller.
> > +
> > +  Datasheet:
> > +
> > + https://www.analog.com/media/en/technical-documentation/data-sheets/
> > + ad2s1210.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ad2s1210
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 25000000
> > +
> > +  spi-cpha: true
> > +
> > +  avdd-supply:
> > +    description:
> > +      A 4.75 to 5.25 V regulator that powers the Analog Supply Voltage
> (AVDD)
> > +      pin.
> > +
> > +  dvdd-supply:
> > +    description:
> > +      A 4.75 to 5.25 V regulator that powers the Digital Supply Voltag=
e (DVDD)
> > +      pin.
> > +
> > +  vdrive-supply:
> > +    description:
> > +      A 2.3 to 5.25 V regulator that powers the Logic Power Supply Inp=
ut
> > +      (VDrive) pin.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: External oscillator clock (CLKIN).
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO connected to the /RESET pin. As the line needs to be low fo=
r the
> > +      reset to be active, it should be configured as GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  sample-gpios:
> > +    description:
> > +      GPIO connected to the /SAMPLE pin. As the line needs to be low t=
o
> trigger
> > +      a sample, it should be configured as GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  mode-gpios:
> > +    description:
> > +      GPIO lines connected to the A0 and A1 pins. These pins select th=
e data
> > +      transfer mode.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  resolution-gpios:
> > +    description:
> > +      GPIO lines connected to the RES0 and RES1 pins. These pins selec=
t the
> > +      resolution of the digital output. If omitted, it is assumed that=
 the
> > +      RES0 and RES1 pins are hard-wired to match the assigned-resoluti=
on-bits
> > +      property.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  fault-gpios:
> > +    description:
> > +      GPIO lines connected to the LOT and DOS pins. These pins combine=
d
> indicate
> > +      the type of fault present, if any. As these pins a pulled low to=
 indicate
> > +      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  adi,fixed-mode:
> > +    description:
> > +      This is used to indicate the selected mode if A0 and A1 are hard=
-wired
> > +      instead of connected to GPIOS (i.e. mode-gpios is omitted).
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [config, velocity, position]
> > +
> > +  assigned-resolution-bits:
> > +    description:
> > +      Resolution of the digital output required by the application. Th=
is
> > +      determines the precision of the angle and/or the maximum speed t=
hat
> can
> > +      be measured. If resolution-gpios is omitted, it is assumed that =
RES0 and
> > +      RES1 are hard-wired to match this value.
> > +    enum: [10, 12, 14, 16]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpha
> > +  - avdd-supply
> > +  - dvdd-supply
> > +  - vdrive-supply
> > +  - clocks
> > +  - sample-gpios
> > +  - assigned-resolution-bits
> > +
> > +oneOf:
> > +  - required:
> > +      - mode-gpios
> > +  - required:
> > +      - adi,fixed-mode
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        resolver@0 {
> > +            compatible =3D "adi,ad2s1210";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <20000000>;
> > +            spi-cpha;
> > +            avdd-supply =3D <&avdd_regulator>;
> > +            dvdd-supply =3D <&dvdd_regulator>;
> > +            vdrive-supply =3D <&vdrive_regulator>;
> > +            clocks =3D <&ext_osc>;
> > +            sample-gpios =3D <&gpio0 90 GPIO_ACTIVE_LOW>;
> > +            mode-gpios =3D <&gpio0 86 0>, <&gpio0 87 0>;
> > +            resolution-gpios =3D <&gpio0 88 0>, <&gpio0 89 0>;
> > +            assigned-resolution-bits =3D <16>;
> > +        };
> > +    };
> >

