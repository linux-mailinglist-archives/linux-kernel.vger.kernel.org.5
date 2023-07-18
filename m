Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5A758370
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjGRR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjGRR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:26:32 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518AE19A5;
        Tue, 18 Jul 2023 10:26:17 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFh5vR019790;
        Tue, 18 Jul 2023 13:25:59 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rutmpuc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 13:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL0HhHlQB5qLh0xYJ30GTFrCQpMkG1N+JsmNE9L2Rv/OAhZc+xvBMQZ0osOBOf2VAOAJcn9eSVsgFyA5m3hLNJfFuSg8FBQceZWRQNw82z7QSPBXCKJaFImLI4aMJ2fI4S7614Ge1MELmAJftOMbL7rELERiNsnpURSuYi2Ovtb5tWnpLH0VgTT3H/SOpK8vQSYQiub5+iU3+LS307CIUJNNSmTQ7JXLAJpArQBz6mUuxEzLSiDZN4plWBJBPcLiz9GyFVMdw5fokBKaoaSU4660IheVa+IYs72y+1nYmgzNQIoAR1m+DQTKeNr/F+x0xkHPtA4Xb2SZpVm3IvhHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/T3IUfSrFgKKv0NsunNQ62CfLcYGhXmBxb2z98z3kI=;
 b=ANYmArIVhP5t+F3R+cCSornwVzpYHcc7piivC2RacDCHBjh8FK1jW9ieIq6QCTmiyDimGQm2m+b5qZVXrzSjiOWgWaFtAME3A8ALtPHjTemW/u/p7M2SQIgb8h//UdsnnNlyE8RMcEJjOqdSjnzbpkoLA5LMyMqYVCmZdMw+n2uGWJFV5Pxrdarm9GIhkZzeuxWIUd+VEnyqZl2ilngsqmMfiaq2Lm5YtNOTkXh2ExDzpVRcbU4ZaTijp4IHstDe5VbnriyPFJ4ZtHYQ18Vri5tHvr0mFrXsbbBVowbC2aUuMb+eohXm6TZbfW2yGO/54FjuQ2NujSsUMjmt4X6jug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/T3IUfSrFgKKv0NsunNQ62CfLcYGhXmBxb2z98z3kI=;
 b=vo1z4r+0bCh57j5LxZForikZljfvKS8QvtVIlwUuy96IWyB06jrdFotLQ9Bz5BrmDfySu02Ezzteagj9qIbKAU7GBEtZi/S/18oPGbqa2eJhnJYY8ku5W8E8ox0ju/5wBq90wfzWgo9OycE5XPLaccjpjfY+2G0hCfCblmQNfNU=
Received: from PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5)
 by BLAPR03MB5585.namprd03.prod.outlook.com (2603:10b6:208:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 17:25:33 +0000
Received: from PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::847a:a4cf:8f84:ac74]) by PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::847a:a4cf:8f84:ac74%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:25:33 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Topic: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Index: AQHZuGy8mN9TLCcuJkyLQ19F8fkBDa+/r5IAgAAYsVA=
Date:   Tue, 18 Jul 2023 17:25:32 +0000
Message-ID: <PH7PR03MB7391206E2D2F1FEF3992C354E738A@PH7PR03MB7391.namprd03.prod.outlook.com>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
In-Reply-To: <20230718155502.GA3542993@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTE3MjFjMGU4LTI1OTAtMTFlZS1iZWZkLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFwxNzIxYzBlYS0yNTkwLTExZWUtYmVmZC01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjM3NDg0IiB0PSIxMzMzNDE3NDcy?=
 =?us-ascii?Q?OTg4NDI0NTciIGg9IjBocHM3Qnh6dktMRkxCRW1hTElJaGtZazJ5OD0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVv?=
 =?us-ascii?Q?Q0FBQlpOM3JabkxuWkFXY3lFUUNsUHVSNFp6SVJBS1UrNUhnREFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRQUJBQUFBdmRoa3hnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFC?=
 =?us-ascii?Q?ekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdN?=
 =?us-ascii?Q?QWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5?=
 =?us-ascii?Q?QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFB?=
 =?us-ascii?Q?Y2dCdkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7391:EE_|BLAPR03MB5585:EE_
x-ms-office365-filtering-correlation-id: 71fc8a07-caf5-423d-cfdb-08db87b3fdcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQ4s+eGro/JB/LtFbZe49SamVRCFrx4FUWv8KREGvmAGCtDIZaW9sO+OXoQKOmKytDDHivCR9IIk8cxi9DovP7EBdimBlLzGGvcywDICVlVdvfnLR2hYUfzjmPP3Rf/SI8TKdn6WLEcI4WFeN8TJ94w+wrNFzR4qq0YD3s6KQ6oixmYeb1V+B6VtZqYNcD0JIe1etNeSvI3OjfkMAimOxoEIytSvX8X9JK8ixt5/nO+YsJwKNxNH025xjQO2BOZhRDv8NU0brLl4jIFF5iVkpU2PzDgwGLmfT1p2Hkx8Wh8ZKqBFC28Ouo6pSrPJKJLQti7Qyf8Rgu+RYZAEqbfApotqtGDO/2PSv6Gny3nDiUFk+AP7c0VlbGf4kGFIZbVlNZ5zImx7owTXZ8m7KLIKz/oGTn11Tw0lpTqBXyxStZeAXakEXaLYFSBzRN8ZNjtAqPzsEe1b89LT4ZhurQcT8B/mFPPP64Z3//RPp/doRCszONcPTgfr+TqW6rW2SS4qBCpVDwZJtj44AndQKyDC9fpvs4mS74/++CYNwNUqDDcxlj/eT053vsarOO+U1HkWvsz9TVFvGSMKc/FYozkbrWSFyyE47nXCPIJKr8BnQq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR03MB7391.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(33656002)(71200400001)(6506007)(83380400001)(38100700002)(186003)(26005)(55016003)(478600001)(38070700005)(54906003)(66476007)(41300700001)(8676002)(7696005)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(316002)(52536014)(4326008)(5660300002)(9686003)(30864003)(64756008)(86362001)(122000001)(76116006)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zlanf/0WK+SgQu0bIYHQRXHsPa8EDoI5Ks5WQJ2kHNrG7Sco1583rGxgU7ls?=
 =?us-ascii?Q?Tne8Pj0tKa5Yp81Zy0agDYeH3rZeIh3NY5sDs9GahGkiArvb4Kx9WC10H/ak?=
 =?us-ascii?Q?O3Tv07C9l+o/oOnbiz42vGhDtS5Canap6YpCz3Jw+wA3bOQoGtj2NTdz+OwY?=
 =?us-ascii?Q?m68QfL1FCAQLyEkFfyeQGhaIBLr+VPgRq7Gk0Uob+zzIo/RGnL9rXK9Bro1/?=
 =?us-ascii?Q?rUgXPJMtjyU5F+vBjbXZV5SMiijZtH2huEcx8yq8Yk83dcDgARjWriGaveVb?=
 =?us-ascii?Q?4FnLAXuBD+AodoXuv7rcfsr5ZPSFDzeTqbNTiTgELTZ4nXxVCwKZ2yU4gWvh?=
 =?us-ascii?Q?g5tnn1baocAIjX7ep2+0uncEpWlS33Rro3Nqxinatk4ZozUbEMruv7IdyN1h?=
 =?us-ascii?Q?Y5ASMh/gWT13jGBY8vzSMdOg+2ZIaspS/ug/Xo1m7sAMAb/zG0cYLEBbGYa0?=
 =?us-ascii?Q?95if6aEpj9b+5lSVcW8Rit2/7TWZ4D+y6jETP10k/j21pfyxVWx0b+/kREER?=
 =?us-ascii?Q?3185o+s+SallG7JMJ1SwPxdyqQzuHss+zcSiyGCPOGXdgYHZ35JL6WlJb+hJ?=
 =?us-ascii?Q?6k9sCm7Wih2vPAFFImMQDqayjiXaEUdYeDLlLx1iEMY4W+HGaCLwnfslCEXe?=
 =?us-ascii?Q?o5mV/uuPRpDfoyYaVzb2TrYJj9IaEV3ujOl8qFsnESFTl6XYeGMIpNN6vGzl?=
 =?us-ascii?Q?LjUpOHlDZeZVx5nSP+DeKAK5piikIW7/mfIjafmKigoWQW8pFmTnyoaLu51Q?=
 =?us-ascii?Q?XWqh00O3TGzUzkSl7CpvIXUYi2yjgfZXQMfLRuAMoSMsX9MWQF8JU0JFITnG?=
 =?us-ascii?Q?iZXXGdZVD/OrXHXz13MUSs05NLGkuexwOCaok+Gnql2GePYNnzvzDS5VG2mb?=
 =?us-ascii?Q?YDeMPw4QuF0YT3PN8D7tM4O8GUwofPg3D5CUBolrAC9BQ52Sh55p+6WJGobz?=
 =?us-ascii?Q?VMgIWR3pUpu0gomlJLMXtH6S4BJkxGFjnFUx7nzhHMORIxE4fsyB6k4PlVFY?=
 =?us-ascii?Q?wddlG7yttVGpgeUMcaGhQSfT8zHqSJqPs56Z0swsmncRFMX6Mn39mVkKODcn?=
 =?us-ascii?Q?43Vpk1gRT607JgovcO6pjs3xbWn7mjOhb/vMiCbWsHN1Jgnp0pctcAkLHXT3?=
 =?us-ascii?Q?nV4EWE3q9nPwhv/Y23h9Rv4KrtG3gX3p9zuqHc0IWfnP9+KIqwDqTxjPAYS4?=
 =?us-ascii?Q?u23J5rX/eHq0aGeJb747eP2RogTGTVewxwBHEZew8Hlx/mHDM2y/TWEtDjpK?=
 =?us-ascii?Q?AOw0bRYyuA7Tir1kZ2WIBuvKJ6agv9zcPOxjV9Mck0fwOmiKczmosBg1jLTZ?=
 =?us-ascii?Q?1J4La/ZpQv9MBX76+QDLhHhN3rCe8qCVdRov5ionsCdAsNj3NruTU62Kwa0T?=
 =?us-ascii?Q?0d+ln5dQ8GjBEV8jBI0bs/wSij+yPLtv0aVRcGexA3CF5WKQ0NH2/hiQeowP?=
 =?us-ascii?Q?BHqkVPbr3V2TrUhqLvHYLSc+BQNv49HND6eKpb2VyXTcdATpYgiTo9oHtpB0?=
 =?us-ascii?Q?BJ60VtiCpmHEXBb/s5lwfz7tOxrf51l1zf9jPGAtBcVK091ifzSn40rhoczQ?=
 =?us-ascii?Q?cK7/P1Moxd2Lk2AQ2Cggutj4pQd1Qe9qjeGeKRtz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7391.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fc8a07-caf5-423d-cfdb-08db87b3fdcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:25:32.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lvmptp60+l4Oh/+FIL48K4RNHjy6/8K6m+NLeSWL+aK5Io4HlCB2+MmJxd+7Fy0kaj0UBPdTJ8/jqAnANpHWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5585
X-Proofpoint-ORIG-GUID: 2QO9vlStUbXWX9xEh7vpa6Xch2s5mBxk
X-Proofpoint-GUID: 2QO9vlStUbXWX9xEh7vpa6Xch2s5mBxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180159
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Nathan Chancellor <nathan@kernel.org>
>Sent: Tuesday, July 18, 2023 6:55 PM
>To: Sahin, Okan <Okan.Sahin@analog.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; T=
ilki,
>Ibrahim <Ibrahim.Tilki@analog.com>; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; llvm@lists.linux.dev
>Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77=
831
>Regulator Support
>
>[External]
>
>Hi Okan,
>
>On Mon, Jul 17, 2023 at 08:07:35AM +0300, Okan Sahin wrote:
>> Regulator driver for  MAX77857/59 and MAX77831.
>> The MAX77857 is a high-efficiency, high-performance
>> buck-boost converter targeted for systems requiring
>> a wide input voltage range (2.5V to 16V).
>>
>> The MAX77859 is high-Efficiency Buck-Boost Converter
>> for USB-PD/PPS Applications. It has wide input range
>> (2.5V to 22V)
>>
>> The MAX77831 is a high-efficiency, high-performance
>> buck-boost converter targeted for systems requiring
>> wide input voltage range (2.5V to 16V).
>>
>> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
>> ---
>>  drivers/regulator/Kconfig              |  10 +
>>  drivers/regulator/Makefile             |   1 +
>>  drivers/regulator/max77857-regulator.c | 459 +++++++++++++++++++++++++
>>  3 files changed, 470 insertions(+)
>>  create mode 100644 drivers/regulator/max77857-regulator.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index e5f3613c15fa..09eaa1cd90de 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -573,6 +573,16 @@ config REGULATOR_MAX77650
>>  	  Semiconductor. This device has a SIMO with three independent
>>  	  power rails and an LDO.
>>
>> +config REGULATOR_MAX77857
>> +	tristate "ADI MAX77857/MAX77831 regulator support"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  This driver controls a ADI MAX77857 and MAX77831 regulators.
>> +	  via I2C bus. MAX77857 and MAX77831 are high efficiency buck-boost
>> +	  converters with input voltage range (2.5V to 16V). Say Y here to
>> +	  enable the regulator driver
>> +
>>  config REGULATOR_MAX8649
>>  	tristate "Maxim 8649 voltage regulator"
>>  	depends on I2C
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index 58dfe0147cd4..e7230846b680 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -85,6 +85,7 @@ obj-$(CONFIG_REGULATOR_MAX77686) +=3D max77686-
>regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX77693) +=3D max77693-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX77802) +=3D max77802-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX77826) +=3D max77826-regulator.o
>> +obj-$(CONFIG_REGULATOR_MAX77857) +=3D max77857-regulator.o
>>  obj-$(CONFIG_REGULATOR_MC13783) +=3D mc13783-regulator.o
>>  obj-$(CONFIG_REGULATOR_MC13892) +=3D mc13892-regulator.o
>>  obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=3D  mc13xxx-regulator-core.o
>> diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/=
max77857-
>regulator.c
>> new file mode 100644
>> index 000000000000..c5482ffd606e
>> --- /dev/null
>> +++ b/drivers/regulator/max77857-regulator.c
>> @@ -0,0 +1,459 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023 Analog Devices, Inc.
>> + * ADI Regulator driver for the MAX77857
>> + * MAX77859 and MAX77831.
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/regulator/of_regulator.h>
>> +#include <linux/util_macros.h>
>> +
>> +#define MAX77857_REG_INT_SRC		0x10
>> +#define MAX77857_REG_INT_MASK		0x11
>> +#define MAX77857_REG_CONT1		0x12
>> +#define MAX77857_REG_CONT2		0x13
>> +#define MAX77857_REG_CONT3		0x14
>> +
>> +#define MAX77857_INT_SRC_OCP		BIT(0)
>> +#define MAX77857_INT_SRC_THS		BIT(1)
>> +#define MAX77857_INT_SRC_HARDSHORT	BIT(2)
>> +#define MAX77857_INT_SRC_OVP		BIT(3)
>> +#define MAX77857_INT_SRC_POK		BIT(4)
>> +
>> +#define MAX77857_ILIM_MASK		GENMASK(2, 0)
>> +#define MAX77857_CONT1_FREQ		GENMASK(4, 3)
>> +#define MAX77857_CONT3_FPWM		BIT(5)
>> +
>> +#define MAX77859_REG_INT_SRC		0x11
>> +#define MAX77859_REG_CONT1		0x13
>> +#define MAX77859_REG_CONT2		0x14
>> +#define MAX77859_REG_CONT3		0x15
>> +#define MAX77859_REG_CONT5		0x17
>> +#define MAX77859_CONT2_FPWM		BIT(2)
>> +#define MAX77859_CONT2_INTB		BIT(3)
>> +#define MAX77859_CONT3_DVS_START	BIT(2)
>> +#define MAX77859_VOLTAGE_SEL_MASK	GENMASK(9, 0)
>> +
>> +#define MAX77859_CURRENT_MIN		1000000
>> +#define MAX77859_CURRENT_MAX		5000000
>> +#define MAX77859_CURRENT_STEP		50000
>> +
>> +enum max77857_id {
>> +	ID_MAX77831 =3D 1,
>> +	ID_MAX77857,
>> +	ID_MAX77859,
>> +	ID_MAX77859A,
>> +};
>> +
>> +static bool max77857_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	enum max77857_id id =3D (enum max77857_id)dev_get_drvdata(dev);
>> +
>> +	switch (id) {
>> +	case ID_MAX77831:
>> +	case ID_MAX77857:
>> +		return reg =3D=3D MAX77857_REG_INT_SRC;
>> +	case ID_MAX77859:
>> +	case ID_MAX77859A:
>> +		return reg =3D=3D MAX77859_REG_INT_SRC;
>> +	default:
>> +		return true;
>> +	}
>> +}
>> +
>> +struct regmap_config max77857_regmap_config =3D {
>> +	.reg_bits =3D 8,
>> +	.val_bits =3D 8,
>> +	.cache_type =3D REGCACHE_MAPLE,
>> +	.volatile_reg =3D max77857_volatile_reg,
>> +};
>> +
>> +static int max77857_get_status(struct regulator_dev *rdev)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (FIELD_GET(MAX77857_INT_SRC_POK, val))
>> +		return REGULATOR_STATUS_ON;
>> +
>> +	return REGULATOR_STATUS_ERROR;
>> +}
>> +
>> +static unsigned int max77857_get_mode(struct regulator_dev *rdev)
>> +{
>> +	enum max77857_id id =3D (enum max77857_id)rdev_get_drvdata(rdev);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	switch (id) {
>> +	case ID_MAX77831:
>> +	case ID_MAX77857:
>> +		ret =3D regmap_read(rdev->regmap, MAX77857_REG_CONT3,
>&regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (FIELD_GET(MAX77857_CONT3_FPWM, regval))
>> +			return REGULATOR_MODE_FAST;
>> +
>> +		break;
>> +	case ID_MAX77859:
>> +	case ID_MAX77859A:
>> +		ret =3D regmap_read(rdev->regmap, MAX77859_REG_CONT2,
>&regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (FIELD_GET(MAX77859_CONT2_FPWM, regval))
>> +			return REGULATOR_MODE_FAST;
>> +
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return REGULATOR_MODE_NORMAL;
>> +}
>> +
>> +static int max77857_set_mode(struct regulator_dev *rdev, unsigned int m=
ode)
>> +{
>> +	enum max77857_id id =3D (enum max77857_id)rdev_get_drvdata(rdev);
>> +	unsigned int reg, val;
>> +
>> +	switch (id) {
>> +	case ID_MAX77831:
>> +	case ID_MAX77857:
>> +		reg =3D MAX77857_REG_CONT3;
>> +		val =3D MAX77857_CONT3_FPWM;
>> +		break;
>> +	case ID_MAX77859:
>> +	case ID_MAX77859A:
>> +		reg =3D MAX77859_REG_CONT2;
>> +		val =3D MAX77859_CONT2_FPWM;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (mode) {
>> +	case REGULATOR_MODE_FAST:
>> +		return regmap_set_bits(rdev->regmap, reg, val);
>> +	case REGULATOR_MODE_NORMAL:
>> +		return regmap_clear_bits(rdev->regmap, reg, val);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int max77857_get_error_flags(struct regulator_dev *rdev,
>> +				    unsigned int *flags)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*flags =3D 0;
>> +
>> +	if (FIELD_GET(MAX77857_INT_SRC_OVP, val))
>> +		*flags |=3D REGULATOR_ERROR_OVER_VOLTAGE_WARN;
>> +
>> +	if (FIELD_GET(MAX77857_INT_SRC_OCP, val) ||
>> +	    FIELD_GET(MAX77857_INT_SRC_HARDSHORT, val))
>> +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;
>> +
>> +	if (FIELD_GET(MAX77857_INT_SRC_THS, val))
>> +		*flags |=3D REGULATOR_ERROR_OVER_TEMP;
>> +
>> +	if (!FIELD_GET(MAX77857_INT_SRC_POK, val))
>> +		*flags |=3D REGULATOR_ERROR_FAIL;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct linear_range max77859_lin_ranges[] =3D {
>> +	REGULATOR_LINEAR_RANGE(3200000, 0x0A0, 0x320, 20000)
>> +};
>> +
>> +static const unsigned int max77859_ramp_table[4] =3D {
>> +	1000, 500, 250, 125
>> +};
>> +
>> +static int max77859_set_voltage_sel(struct regulator_dev *rdev,
>> +				    unsigned int sel)
>> +{
>> +	__be16 reg;
>> +	int ret;
>> +
>> +	reg =3D cpu_to_be16(sel);
>> +
>> +	ret =3D regmap_bulk_write(rdev->regmap, MAX77859_REG_CONT3, &reg, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* actually apply new voltage */
>> +	return regmap_set_bits(rdev->regmap, MAX77859_REG_CONT3,
>> +			       MAX77859_CONT3_DVS_START);
>> +}
>> +
>> +int max77859_get_voltage_sel(struct regulator_dev *rdev)
>> +{
>> +	__be16 reg;
>> +	int ret;
>> +
>> +	ret =3D regmap_bulk_read(rdev->regmap, MAX77859_REG_CONT3, &reg, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return FIELD_GET(MAX77859_VOLTAGE_SEL_MASK, __be16_to_cpu(reg));
>> +}
>> +
>> +int max77859_set_current_limit(struct regulator_dev *rdev, int min_uA, =
int
>max_uA)
>> +{
>> +	u32 selector;
>> +
>> +	if (max_uA < MAX77859_CURRENT_MIN)
>> +		return -EINVAL;
>> +
>> +	selector =3D 0x12 + (max_uA - MAX77859_CURRENT_MIN) /
>MAX77859_CURRENT_STEP;
>> +
>> +	selector =3D clamp_val(selector, 0x00, 0x7F);
>> +
>> +	return regmap_write(rdev->regmap, MAX77859_REG_CONT5, selector);
>> +}
>> +
>> +int max77859_get_current_limit(struct regulator_dev *rdev)
>> +{
>> +	u32 selector;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(rdev->regmap, MAX77859_REG_CONT5, &selector);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (selector <=3D 0x12)
>> +		return MAX77859_CURRENT_MIN;
>> +
>> +	if (selector >=3D 0x64)
>> +		return MAX77859_CURRENT_MAX;
>> +
>> +	return MAX77859_CURRENT_MIN + (selector - 0x12) *
>MAX77859_CURRENT_STEP;
>> +}
>> +
>> +static const struct regulator_ops max77859_regulator_ops =3D {
>> +	.list_voltage =3D regulator_list_voltage_linear_range,
>> +	.set_voltage_sel =3D max77859_set_voltage_sel,
>> +	.get_voltage_sel =3D max77859_get_voltage_sel,
>> +	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
>> +	.get_status =3D max77857_get_status,
>> +	.set_mode =3D max77857_set_mode,
>> +	.get_mode =3D max77857_get_mode,
>> +	.get_error_flags =3D max77857_get_error_flags,
>> +};
>> +
>> +static const struct regulator_ops max77859a_regulator_ops =3D {
>> +	.list_voltage =3D regulator_list_voltage_linear_range,
>> +	.set_voltage_sel =3D max77859_set_voltage_sel,
>> +	.get_voltage_sel =3D max77859_get_voltage_sel,
>> +	.set_current_limit =3D max77859_set_current_limit,
>> +	.get_current_limit =3D max77859_get_current_limit,
>> +	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
>> +	.get_status =3D max77857_get_status,
>> +	.set_mode =3D max77857_set_mode,
>> +	.get_mode =3D max77857_get_mode,
>> +	.get_error_flags =3D max77857_get_error_flags,
>> +};
>> +
>> +static const struct regulator_ops max77857_regulator_ops =3D {
>> +	.list_voltage =3D regulator_list_voltage_linear_range,
>> +	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>> +	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>> +	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
>> +	.get_status =3D max77857_get_status,
>> +	.set_mode =3D max77857_set_mode,
>> +	.get_mode =3D max77857_get_mode,
>> +	.get_error_flags =3D max77857_get_error_flags,
>> +};
>> +
>> +static struct linear_range max77857_lin_ranges[] =3D {
>> +	REGULATOR_LINEAR_RANGE(4485000, 0x3D, 0xCC, 73500)
>> +};
>> +
>> +static const unsigned int max77857_switch_freq[] =3D {
>> +	1200000, 1500000, 1800000, 2100000
>> +};
>> +
>> +static const unsigned int max77857_ramp_table[2][4] =3D {
>> +	{ 1333, 667, 333, 227 }, /* when switch freq is 1.8MHz or 2.1MHz */
>> +	{ 1166, 667, 333, 167 }, /* when switch freq is 1.2MHz or 1.5MHz */
>> +};
>> +
>> +static struct regulator_desc max77857_regulator_desc =3D {
>> +	.ops =3D &max77857_regulator_ops,
>> +	.name =3D "max77857",
>> +	.linear_ranges =3D max77857_lin_ranges,
>> +	.n_linear_ranges =3D ARRAY_SIZE(max77857_lin_ranges),
>> +	.vsel_mask =3D 0xFF,
>> +	.vsel_reg =3D MAX77857_REG_CONT2,
>> +	.ramp_delay_table =3D max77857_ramp_table[0],
>> +	.n_ramp_values =3D ARRAY_SIZE(max77857_ramp_table[0]),
>> +	.ramp_reg =3D MAX77857_REG_CONT3,
>> +	.ramp_mask =3D GENMASK(1, 0),
>> +	.ramp_delay =3D max77857_ramp_table[0][0],
>
>This breaks the build with GCC 5.x through 7.x:
>
>  drivers/regulator/max77857-regulator.c:312:16: error: initializer elemen=
t is not
>constant
>    .ramp_delay =3D max77857_ramp_table[0][0],
>                  ^~~~~~~~~~~~~~~~~~~
>  drivers/regulator/max77857-regulator.c:312:16: note: (near initializatio=
n for
>'max77857_regulator_desc.ramp_delay')
>
>and clang:
>
>  drivers/regulator/max77857-regulator.c:312:16: error: initializer elemen=
t is not a
>compile-time constant
>    312 |         .ramp_delay =3D max77857_ramp_table[0][0],
>        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>  1 error generated.
>
>This relies on a GCC 8.x+ change that accepts more things as
>compile-time constants, which is being worked on in clang
>(https://urldefense.com/v3/__https://reviews.llvm.org/D76096__;!!A3Ni8CS0y=
2Y!4ql
>noZFf_EVInN-
>MaRDQWqOHb1SEbEqkwlU06PCt1Ngw6tE41ZEE24hnL1wBMsfotRCue4-i1VwD0xw$
>). Since the kernel supports older
>compilers, this will have to be worked around somehow. Perhaps a define
>that can be used in both places?
>
>Cheers,
>Nathan
>
>> +	.owner =3D THIS_MODULE,
>> +};
>> +
>> +static void max77857_calc_range(struct device *dev, enum max77857_id id=
)
>> +{
>> +	struct linear_range *range;
>> +	unsigned long vref_step;
>> +	u32 rtop =3D 0;
>> +	u32 rbot =3D 0;
>> +
>> +	device_property_read_u32(dev, "adi,rtop-ohms", &rtop);
>> +	device_property_read_u32(dev, "adi,rbot-ohms", &rbot);
>> +
>> +	if (!rbot || !rtop)
>> +		return;
>> +
>> +	switch (id) {
>> +	case ID_MAX77831:
>> +	case ID_MAX77857:
>> +		range =3D max77857_lin_ranges;
>> +		vref_step =3D 4900UL;
>> +		break;
>> +	case ID_MAX77859:
>> +	case ID_MAX77859A:
>> +		range =3D max77859_lin_ranges;
>> +		vref_step =3D 1250UL;
>> +		break;
>> +	}
>> +
>> +	range->step =3D DIV_ROUND_CLOSEST(vref_step * (rbot + rtop), rbot);
>> +	range->min =3D range->step * range->min_sel;
>> +}
>> +
>> +static int max77857_probe(struct i2c_client *client)
>> +{
>> +	const struct i2c_device_id *i2c_id;
>> +	struct device *dev =3D &client->dev;
>> +	struct regulator_config cfg =3D { };
>> +	struct regulator_dev *rdev;
>> +	struct regmap *regmap;
>> +	enum max77857_id id;
>> +	u32 switch_freq =3D 0;
>> +	int ret;
>> +
>> +	i2c_id =3D i2c_client_get_device_id(client);
>> +	if (!i2c_id)
>> +		return -EINVAL;
>> +
>> +	id =3D i2c_id->driver_data;
>> +
>> +	dev_set_drvdata(dev, (void *)id);
>> +
>> +	if (id =3D=3D ID_MAX77859 || id =3D=3D ID_MAX77859A) {
>> +		max77857_regulator_desc.ops =3D &max77859_regulator_ops;
>> +		max77857_regulator_desc.linear_ranges =3D max77859_lin_ranges;
>> +		max77857_regulator_desc.ramp_delay_table =3D
>max77859_ramp_table;
>> +		max77857_regulator_desc.ramp_delay =3D max77859_ramp_table[0];
>> +	}
>> +
>> +	if (id =3D=3D ID_MAX77859A)
>> +		max77857_regulator_desc.ops =3D &max77859a_regulator_ops;
>> +
>> +	max77857_calc_range(dev, id);
>> +
>> +	regmap =3D devm_regmap_init_i2c(client, &max77857_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap),
>> +				     "cannot initialize regmap\n");
>> +
>> +	device_property_read_u32(dev, "adi,switch-frequency-hz", &switch_freq)=
;
>> +	if (switch_freq) {
>> +		switch_freq =3D find_closest(switch_freq, max77857_switch_freq,
>> +					   ARRAY_SIZE(max77857_switch_freq));
>> +
>> +		if (id =3D=3D ID_MAX77831 && switch_freq =3D=3D 3)
>> +			switch_freq =3D 2;
>> +
>> +		switch (id) {
>> +		case ID_MAX77831:
>> +		case ID_MAX77857:
>> +			ret =3D regmap_update_bits(regmap, MAX77857_REG_CONT1,
>> +						 MAX77857_CONT1_FREQ,
>switch_freq);
>> +
>> +			if (switch_freq >=3D 2)
>> +				break;
>> +
>> +			max77857_regulator_desc.ramp_delay_table =3D
>max77857_ramp_table[1];
>> +			max77857_regulator_desc.ramp_delay =3D
>max77857_ramp_table[1][0];
>> +			break;
>> +		case ID_MAX77859:
>> +		case ID_MAX77859A:
>> +			ret =3D regmap_update_bits(regmap, MAX77859_REG_CONT1,
>> +						 MAX77857_CONT1_FREQ,
>switch_freq);
>> +			break;
>> +		}
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	cfg.dev =3D dev;
>> +	cfg.driver_data =3D (void *)id;
>> +	cfg.regmap =3D regmap;
>> +	cfg.init_data =3D of_get_regulator_init_data(dev, dev->of_node,
>> +						   &max77857_regulator_desc);
>> +	if (!cfg.init_data)
>> +		return -ENOMEM;
>> +
>> +	rdev =3D devm_regulator_register(dev, &max77857_regulator_desc, &cfg);
>> +	if (IS_ERR(rdev))
>> +		return dev_err_probe(dev, PTR_ERR(rdev),
>> +				     "cannot register regulator\n");
>> +
>> +	return 0;
>> +}
>> +
>> +const struct i2c_device_id max77857_id[] =3D {
>> +	{ "max77831", ID_MAX77831 },
>> +	{ "max77857", ID_MAX77857 },
>> +	{ "max77859", ID_MAX77859 },
>> +	{ "max77859a", ID_MAX77859A },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max77857_id);
>> +
>> +static const struct of_device_id max77857_of_id[] =3D {
>> +	{ .compatible =3D "adi,max77831", .data =3D (void *)ID_MAX77831 },
>> +	{ .compatible =3D "adi,max77857", .data =3D (void *)ID_MAX77857 },
>> +	{ .compatible =3D "adi,max77859", .data =3D (void *)ID_MAX77859 },
>> +	{ .compatible =3D "adi,max77859a", .data =3D (void *)ID_MAX77859A },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, max77857_of_id);
>> +
>> +struct i2c_driver max77857_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "max77857",
>> +		.of_match_table =3D max77857_of_id,
>> +	},
>> +	.id_table =3D max77857_id,
>> +	.probe_new =3D max77857_probe,
>> +};
>> +module_i2c_driver(max77857_driver);
>> +
>> +MODULE_DESCRIPTION("Analog Devices MAX77857 Buck-Boost Converter
>Driver");
>> +MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
>> +MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.30.2
>>

Hi Nathan,

Should I need to fix it within the patch v4? Or  should I sent another patc=
h after merge?

Regards,
Okan Sahin
