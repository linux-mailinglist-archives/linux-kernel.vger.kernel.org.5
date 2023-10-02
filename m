Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431F7B5881
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjJBQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:46:45 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3DB8;
        Mon,  2 Oct 2023 09:46:41 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 392EPnsK030167;
        Mon, 2 Oct 2023 12:46:32 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tfpccba4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 12:46:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d93o2ZAon1tvWQ16bvKqcDTID/0nMcTO9QWDSgoSjA9+adgg0+6rDq7F1NfbGGqR8dDpcIy0vwtVdreuHY8XQiX8Th9ovngQlKJX3IYYV9sQP/dJ019AwD6CKxCZZ+6jhd5/haeQMa4+KZbgNmnTdd5deIa7Z+eetyff0y5VBsuq2/+FVbhwuYSeqleBwoo7QTeEDCVah93TfbPZTJ3u5FDQKLxUUlgwfr8EFa9TStVnxuVh+6jUuGyF93UCHX6qBodlIPpKGmmyo8MKg6t11mr9ZsXV9TNZuVPutWfKE81uop1dwaAKBK8jlrKw5bhRBKIE7PHL+NwblU7HaAsMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf/xXmYGMM/0r7V6Ezuo1C8RXnaHyr3CoFDUIlneKGA=;
 b=Dkv0igj+V7KeTO4XLRgPxRveWVSKDFm3MXRv5wrY+6HrDYQ+Y8eRhb0gU8NKl3bTmCAnJO2Ow19Q6juarpv0/VUNQMlVRDCtJfE7CSQ2jZ7UDG/Q710hIk24irpRNucPOoRF0LJ86mTiRU7nlydweaTL7L5F1Nqdm0xxp5Xw35ZtChBG5X5yZKjd35VR/TtXbDvo/RR0MWfGrElfmqAdWWj/B+8AKbvjyCHm7lk6If4s+YTNzF9T0Kk1cd++fFv8LBDK0wTdIcRLaXbPNp9cWcCKW3FeIoairAslTmh96e72HqKA5g4/o9K4J8JqrGMPmhd4m+OfvT3FOujUn+bBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf/xXmYGMM/0r7V6Ezuo1C8RXnaHyr3CoFDUIlneKGA=;
 b=F4X1p53YPkYHGHVlfngu5owtwdNQ8dmki+sv4qOoPP8WR7CN/HSHfGzbcBQuYHsw8LYMQ69MnrnFQzXHG7V/7jdGYVYUorFFTxtMgPrZISR7ROx02eJf2bWnSniW5VtvEkClzhZAu7Z6VHKIcmHMViCHnknpr/T31HuIOA6G9kI=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by SJ2PR03MB7402.namprd03.prod.outlook.com (2603:10b6:a03:555::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 16:46:27 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:46:27 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Topic: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Index: AQHZ8e6/zUxp0vYDHECkHhwPalTB6rA2uEYAgAABCqA=
Date:   Mon, 2 Oct 2023 16:46:26 +0000
Message-ID: <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
 <20231002163244.GA1886905-robh@kernel.org>
In-Reply-To: <20231002163244.GA1886905-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMzkxYTVlZjctNjE0My0xMWVlLThkYjItNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDM5MWE1ZWY4LTYxNDMtMTFlZS04ZGIyLTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iOTA5MCIgdD0iMTMzNDA3Mzg3ODU1MTk0?=
 =?us-ascii?Q?MzE1IiBoPSJPZUVpWUo1cmNjS0VBZEhudVhVNUI5ZnBpM3M9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQURM?=
 =?us-ascii?Q?aUlYN1QvWFpBUXR3aVRVL3krQW9DM0NKTlQvTDRDZ0RBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|SJ2PR03MB7402:EE_
x-ms-office365-filtering-correlation-id: d5ea0cfd-a43b-4e88-fd2d-08dbc3671ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysAjOYofIfyLcWde9KMXOb8bmrGnliP5ZDO2OUrzJAKGksg6Ie57WD4eSnSLbgV/QeGIlT2zr0CxLXQeNULGfN11rt8iBcoyRghQMHDP44awQp/jOnL8eGzJodDVuna3A0cCP7dUPwC7hI6G/9h4p1jDM60SNhmsow19zjhHX2MVEJ1Q7EpfuwTlvShaZqmRLze4mjOVjT/jobboStvlCZzjxCU3O9TBQyDN53/qEApFLRwBll/Lxc99NqxmmQ3YG+mv2tDt/zTxjHaIjNIaD90EezmyWh7WwkP5OSpgYwkTIUWsuwDqTfMa+VilAmNYn8MHvfCUCh5Z03tIPBW6WWZm5kEwPu/WDnanwkha2cI8AdlYJi0S6em/8PGleHn1C+PSvtkyatptg6NOFlaK4qK/UjbPMwXyEOnWo4wYbQ2EY1QWSDgml3RsGcXGQu/oFSN+pd005kSB+UkZjbLmDHeXew+WE0kUV4QoiIqyOsYPlXStNwT9g9yt0cQJgd0ZbhhYrmbSIx8GTnolqaBe/5Es2zdwtpgLCpY36ITsqlvlepkxVSLuEdmut5Yl0VbGQpM8CQwkrbHa8b2IgtZyce4JFi5HxrXzjkXcjYX2N+XrgRp9tU0+b37xAIZxUJzOZO8soFhaHptLmvB2ay47PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(26005)(86362001)(122000001)(38070700005)(33656002)(38100700002)(55016003)(83380400001)(54906003)(64756008)(478600001)(66476007)(66446008)(316002)(6916009)(52536014)(8936002)(8676002)(4326008)(66556008)(66946007)(5660300002)(966005)(76116006)(6506007)(7696005)(41300700001)(53546011)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q5Q3WcngjDJyQmjxErkPpm6o88u4YAC+H5Y4XrFCcxOiii5/Vc7A+rTIcxQZ?=
 =?us-ascii?Q?/IE8oXuGTex1OcGZg5o2C+s+H5t69JQUIPXvdGEls+6vkCoQPxgEA9wPr7Rh?=
 =?us-ascii?Q?X1If+wD0WBDndOwYjBDrDW5Kw32D/3Q22IRixTKKgfQtpVl86F5dYQe0uNoA?=
 =?us-ascii?Q?Uw4ytmKaN0AMNqMm8ke64/01M7ddWvGIQwgxFxVkdoZEatqTrBNSk2vnPT/c?=
 =?us-ascii?Q?KZ4EY4gzWB4qY4VAVHlZQCd2WqyLDyT9H2aOnTeBP9aZmAre3NhmzJZ+YDvy?=
 =?us-ascii?Q?An6SkuPI8Va5Z6Y0paziktx05D8rqthZz2W/iQMKfwELz2KZGDfvj4I5XaE5?=
 =?us-ascii?Q?qBLwVoqgAkVLiWSDzxhvOp+KJcd6x1bt8jdshk9xh4IiqKdUT0GlChOKYxYr?=
 =?us-ascii?Q?OD4aLnBCc9E93o60PwnxozZgOTk7PomoJoT1Fo2EZL/7dg4jrxH8wpboUntI?=
 =?us-ascii?Q?LiPq1z8fkL9REcek5aChtZ5CmxSFF/XmOi6wYxoQNQHlV3EPvAzTxRZFTJeB?=
 =?us-ascii?Q?fKbzj98io92HXdqTAJbB3xPzXM8owQ6uDqzyaUFC0JbVL+FERUTU3/LT81D2?=
 =?us-ascii?Q?V9NS1BANOKRj38C+ziHyJbhajW/TAbiuIphnUpGE45tyDQ5I5XDeSgxOV86/?=
 =?us-ascii?Q?IKOhV0JemkVOinY7U5bU/6D/m3aZfCESaiNeZYJBLJTSOZSkxasGqTNzpxkr?=
 =?us-ascii?Q?HKzZlj/XL7LDaI2V6IAOGoO1GJ5ZumEjhmljDCiDFSsDkYPLncTsHlgl3dNo?=
 =?us-ascii?Q?2RzF05PoyOLz5MmaAGJfuZBe974tgE4Wno0Kd2ep88wnw9+XC076TDVPigfw?=
 =?us-ascii?Q?bRgbmfeITMO7+BzUhPWxi8kR2bRO1EtScnU7L8u1yw5N4NiFiBJlubE63rU5?=
 =?us-ascii?Q?yHtbniIdwweDDqRE+laTbu2F7CxgSBVAX9jq3PHoLTVsugSzw1Ou+4Uf4f6v?=
 =?us-ascii?Q?Ufh2LJ1UDCyFd7fyvTemAaxKjnYiBbFzYlaWWQz494WfvItfeCtJUmK7O4PO?=
 =?us-ascii?Q?ahJuszxZDIwJMb6v7gVlD0h9//VKk2fsBAccliH+M96xQqLUDYSCu2vRn9Kw?=
 =?us-ascii?Q?HSjbXyoGvxfRB7HqgOr44h2E/a+BDLVwxUXCW2ojH1pukea9EigmMrmn24TB?=
 =?us-ascii?Q?XFmvV4B6bfCJGtyvbYQCBoRoxZRVm45dcvISO9cr9mylmAP6hVyj9PwH17Je?=
 =?us-ascii?Q?F+TvXo8WP6vdTw98UTsln74lxvUoJcepBQPtK9kk8DihOq0SWvVc7bv0/vl0?=
 =?us-ascii?Q?+CpQ2Z6MAzyF9ck6bYyf5Dc7nbPcrEPopIwisVw0iUTbw1LW+KQMl6sRnMsn?=
 =?us-ascii?Q?V1cHDKfr9ljdnPk8b9min7CEbdTl1NMKUKBAF1yoGT+VACmU0WzkgJCTQsrG?=
 =?us-ascii?Q?8ZBPnrHz2krn5+ekW1Op9umKtkUwHB/N0pxkrlOYoaoYIMIZDX6X/Hpw8gW8?=
 =?us-ascii?Q?dhdxsEzikZkS5w78DOOFqA0L6Q6jHIj3iywgOs6VjFcKQvlDJCQA6q0m0LJY?=
 =?us-ascii?Q?bcHa5E8AgsC6GnvYi4l3iST5629IV6O2PeTdRYd2f+lsp2Iwn1hQStl3kEz1?=
 =?us-ascii?Q?pEdbVev7tFYL0xQDf3zoArpms4zvhTyNmyqNfLHk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ea0cfd-a43b-4e88-fd2d-08dbc3671ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 16:46:26.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5Z8Uk2XiSEjmSJPApRtrqL5eCw+Dl8EvZUabQKIMCTuYgSMUQY0CW7FyTzXY9PYyEb08Wk37w4kn6Ng24YBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7402
X-Proofpoint-GUID: ME6DsxtMCrNf_5AXLfs3Zwoo4WnVsZgS
X-Proofpoint-ORIG-GUID: ME6DsxtMCrNf_5AXLfs3Zwoo4WnVsZgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310020130
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, October 2, 2023 19:33
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley=
 <conor+dt@kernel.org>; Derek Kiernan
> <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.com>; Arnd Berg=
mann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; devicetree@vg=
er.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tr=
ee binding for TDD engine
>=20
> [External]
>=20
> On Thu, Sep 28, 2023 at 12:28:03PM +0300, Eliza Balas wrote:
> > Add device tree documentation for the AXI TDD Core.
> > The generic TDD controller is in essence a waveform generator
> > capable of addressing RF applications which require Time Division
> > Duplexing, as well as controlling other modules of general
> > applications through its dedicated 32 channel outputs.
> >
> > The reason of creating the generic TDD controller was to reduce
> > the naming confusion around the existing repurposed TDD core
> > built for AD9361, as well as expanding its number of output
> > channels for systems which require more than six controlling signals.
> >
> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > ---
> >  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  2 files changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/=
Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > new file mode 100644
> > index 000000000000..8938da801b95
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/misc/ad=
i,axi-
> tdd.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS9J1yt0xgj=
p9g3Y1N5PbZ7pAcIkKU4WPbS_TR9yjTKw$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS=
9J1yt0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_RK8aQ9xw$
> > +
> > +title: Analog Devices AXI TDD Core
> > +
> > +maintainers:
> > +  - Eliza Balas <eliza.balas@analog.com>
> > +
> > +description: |
> > +  The TDD controller is a waveform generator capable of addressing RF
> > +  applications which require Time Division Duplexing, as well as contr=
olling
> > +  other modules of general applications through its dedicated 32 chann=
el
> > +  outputs. It solves the synchronization issue when transmitting and r=
eceiving
> > +  multiple frames of data through multiple buffers.
> > +  The TDD IP core is part of the Analog Devices hdl reference designs =
and has
> > +  the following features:
> > +    * Up to 32 independent output channels
> > +    * Start/stop time values per channel
> > +    * Enable and polarity bit values per channel
> > +    * 32 bit-max internal reference counter
> > +    * Initial startup delay before waveform generation
> > +    * Configurable frame length and number of frames per burst
> > +    * 3 sources of synchronization: external, internal and software ge=
nerated
> > +  For more information see the wiki:
> > +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,axi-tdd-2.00.a
>=20
> Where does this version number come from? I looked at the above link and
> see versions such as '2021_R2', '2019_r2', etc. I didn't dig deeper
> whether there's some per IP version.
>=20
> If you want to use version numbers, please document the versioning
> scheme. For example, see
> Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt.
>=20
> Rob

The version refers to the IP version. The version of the IP is also specifi=
ed in its VERSION register (there is a drop down to expand the register map=
 on the wiki page) which is verified by the driver during probe.=20
"2021_R2" refers to the compatible tool version used for creating the FPGA =
IP Core.

I will document the versioning scheme.

Thank you,
Eliza
