Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15347D9950
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjJ0NHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:07:27 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B71B3;
        Fri, 27 Oct 2023 06:07:24 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39RC1BrV025394;
        Fri, 27 Oct 2023 09:07:07 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tywqxnn50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 09:07:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVmzRbOSrrdID76jR6OGs0LupxFfxXOp5tHJLZmrc1MfHrj4vhc4S6BV8i6tUH7ZhE8gGRqFbE0aWBYheWYRW0k5XERBSmnPARx814/PN/mc6DjpNuXbde4cqv8YTctpKZfiPmrSSpIfg8pei+69PCLPWel19f4V+BKNDiywzm1Sh52yGW26AFR2xQo/IozdeN6vAVXPNki9ngqXj2aM8s8Ut6I/7PZSgHBwrZFckeGN4x6Sl6GmFOzKofJk747PBK6ooR95VNSaFMEcAurENEdfuAcXW50zMu0vLeYsYr4nyyzlSWzspkKdVE7DXfwlUckqtHTzf7BLnN5x+Qx13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwTbNn6NP1tC890eYBNK+RVOfC6a2k3ygNjpmTZs3aE=;
 b=NyUWN8QXE9tHfEgzC8b1dUVyxgr6WkZPw361Puk+r8sAkGns63c06Ln6Tj5YVTmCwZfGnLTHCpB+2Ddtr/k0S3C3RkFOFBBRbNgZoJWxGvShQsuAnNrHedjwBTq33uAxnu2KSMIDDj2SkX0YxfHJBErrzSJw8FaYBltJd3x6WBxmgJdFNyamnie5J2/amI+B52YtdV9Cp7CW8KQgu/S3KAE1fpuetQnfiIrB1DTF4Vhkmw/d9VN40GMLndBV1oH4hwj3OB5YDzHSWKWQ8hvnanFh8vc/3z81YP8l/Z4ry87zGXtmUGy9eVwmRJoqhbI68PhQx0nwtl3266WB6AJjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwTbNn6NP1tC890eYBNK+RVOfC6a2k3ygNjpmTZs3aE=;
 b=LBpP4zFpjFKPzgdNSC2fPvkJk3QS1SbDnlj8aQDjeHaAPAaYwLgrRGfTu73j9KtmasRGpSj/7lyYS0i2QD/vJ15n/W/evf4Ifs8BL+hlXlY1ZXJqueDvzjEi63/tMMqTOJJVIbxpyWOZDc4iN1YBvhXt4R4DyWp19snE90gpabA=
Received: from PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17)
 by SJ0PR03MB6732.namprd03.prod.outlook.com (2603:10b6:a03:407::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 13:07:04 +0000
Received: from PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::d18d:cbcc:2b22:9b25]) by PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::d18d:cbcc:2b22:9b25%3]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 13:07:04 +0000
From:   "Matyas, Daniel" <Daniel.Matyas@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and
 max31829
Thread-Topic: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and
 max31829
Thread-Index: AQHaCBrux3jCd9w9Ok6JeCc2kSWWE7BdFUuAgABLXpCAADv+kA==
Date:   Fri, 27 Oct 2023 13:07:04 +0000
Message-ID: <PH0PR03MB6771212410349459B2865BE889DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
References: <20231026144405.546822-1-daniel.matyas@analog.com>
 <20231026144405.546822-2-daniel.matyas@analog.com>
 <fe99431e-3245-484c-bf26-928048500ec6@roeck-us.net>
 <PH0PR03MB67712B3C063B794442F6D58A89DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB67712B3C063B794442F6D58A89DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZG1hdHlhc1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWI3YjBkNDkyLTc0YzktMTFlZS1iNzQ4LTE4MWRl?=
 =?us-ascii?Q?YWFmMTM0MVxhbWUtdGVzdFxiN2IwZDQ5NC03NGM5LTExZWUtYjc0OC0xODFk?=
 =?us-ascii?Q?ZWFhZjEzNDFib2R5LnR4dCIgc3o9IjE0ODIwIiB0PSIxMzM0Mjg4NTYyMjQ4?=
 =?us-ascii?Q?MjY0OTAiIGg9Ik4yVGlLMDZyYmhvUldubHdndThNZVNBTXZDST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QjZSQkY2MWdqYUFTT2VPaEtBRko1Nkk1NDZFb0FVbm5vREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6771:EE_|SJ0PR03MB6732:EE_
x-ms-office365-filtering-correlation-id: 9c616343-359d-471e-b6a2-08dbd6ed9dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ro86BUkPwJNLpwUYErSQlb6Bvw82HPNh3MyTrxHBKy0EoBPSYlOL1OrmC3pHuXoPKfccvlsN2k5vaqoIx6XBOZm5tlVUuRwnta1CS/I2mD7YW4yo/zJ68WgihJIMW6ZW9Mc974ZHXWtgqMfmKTtM1BbIA2n0KURsGqZqWUHie9G+8j89tUXXabXi6Tcrx4r9zSd4kqYSRyWEvSl9C+Zc+WzU5NDHkr/p0g1+TdiUDVTmOZ1GkNmRRwrlmXnwWvaIgYqVR3ZXPD43HrnYbt234LdvB+WT0WcG5ermCLQCKEAFUMK4bDEY6PVcl+KUNb9LnckPVNdXkupHrIy7AxwUsDc3CEb03YrmzBZbioW/ejFWnN7/MWPMA0zjDRaVw1owy0y2mrElQeOr2VN1/9ka0bDloMAPf6kcE39uDL4UTis8BIxGdfdVS41cgh9brLbXe/Nlguk8DswglLCfGgFnLLSa1OTJYRYasbNaL1lqioAweHT68LRctmhDhproQVeE80fGnRq/D1tkpFVX+hLpQk1PIijT3/9fSYhPyVYKxd0tdgoeYjqdDuYD/cT6TFoGXF0LrUgugrd9WSuxCNT8SKlr+rCBEJo9VhDAO2bgG1gj4MRKuYb7BFuR+BnmoFH4l2Jm8/GsX4JAz9djcZoLSjgCameMVKHHoJQaoBrT5YIw4mhQcPTNbV4imFdqo89h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6771.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(1800799009)(451199024)(9686003)(41300700001)(2940100002)(55016003)(5660300002)(122000001)(26005)(8676002)(8936002)(4326008)(478600001)(66556008)(66476007)(54906003)(64756008)(66446008)(316002)(6916009)(76116006)(66946007)(38070700009)(7696005)(6506007)(71200400001)(53546011)(52536014)(86362001)(38100700002)(2906002)(33656002)(83380400001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lnmDeQSqSiHy9CNuKUlJ+wPfLigIFw/jctGY5v8itSZLPgKx3mDzr57rvYHk?=
 =?us-ascii?Q?Rv91R/3ujK+ILdUt7br1+sWDmd7BL2+kNUYWtLjjHr2AIBL/lS61yw7SqkME?=
 =?us-ascii?Q?BZTFBfNSICksOQP5P4yZ5tfmJKKaJUcguzX8cv7qOsdpftmWfRln5I28RMJ9?=
 =?us-ascii?Q?HMdKqSAcjqAsLF0HAEnWRtmYjo0BYd1rzLLp3DNiZpTl6o1B7uenLq8du06L?=
 =?us-ascii?Q?IAowiHIfYxcJQiNIF4OXOgpZdvtTtFy024+8i5Y9knh+C4vNw1dGumIGawa6?=
 =?us-ascii?Q?zlrbBtibGJANnffUkZI6sUMTWr8legom2d/SiND8/5gBj09ThEWnJODZ373i?=
 =?us-ascii?Q?dk+wgGPu3dVj2p1rpvCDPXsTGXnEEMvIBSn15X2w1mIyOzJYEXu1HiDkNvwL?=
 =?us-ascii?Q?V4Ow3vgTIT8IxN9BZ6VPA+AIFFpyP+Pxrry/YwzGmzhO+ljeH+t0pU87oMrw?=
 =?us-ascii?Q?S4mCFMbEGkg6MoXkr21hokFf4CsbyNMHuMDhhKMIEWT8lScZ3XQ8flh1S7dv?=
 =?us-ascii?Q?Nsb2V92BgJj/4k2dDWqRiH5Q7uo6lkdf4WYt9vgXzwdAQAaqVI+vwPK12bJ2?=
 =?us-ascii?Q?9LVhPQVd1gASjfxvjLAPeqw4fCo57Vbk63Hc8w+6c9B4TuWMHrBF0fXZCY6/?=
 =?us-ascii?Q?GEeW34coPXDOHYcahpuOzBNACQeM8GbdkbviRJWfl39hf1Pbyww125tHxUwg?=
 =?us-ascii?Q?P7p6sGapGHS2CaW522Z4iV8/nE4YRiLCPlK2p2WFsWohcuhwFC+28GHETiRc?=
 =?us-ascii?Q?AJz8/wVreuD6/Vs4SvGskaMt+fn3Urxl4bhwFqUvVcJoPIv82IPlUUn9dPc6?=
 =?us-ascii?Q?NL8WFlDdTMdSgG5pFOeiVHIhh7bgOp1/kIX/R9nCSXES/qoiP/7IY/2kmakV?=
 =?us-ascii?Q?pOe7zkEOPPtM+sbpz+MxUulR4XtMNWpBOedZq+8cRsKXRnTM/ZZamjBa8dPR?=
 =?us-ascii?Q?FZV3mxOsdAn5ilOlIMySC1Y6UTqp3xILjxCZQl2Z2Xi0Ilv9DhUfPGCUIiM7?=
 =?us-ascii?Q?XK5qk6VZRwWUPoGU/ArL/K39mMB7z5JEDMBFJ29krTq/x7tt9JbBegFNNoBj?=
 =?us-ascii?Q?nrU3w7u2XxfxsNf7+pPV4JuM6XNuEu1uy6aR5nw9oaHx31v8tA0sfOGmAiuq?=
 =?us-ascii?Q?5pkbC/5n0xdgEHCC18GrcbNQin3G31LS23rMRXh7x9Q3HzrhnlnBqKQMwm5o?=
 =?us-ascii?Q?erio/NJdmYeR1MYKl+vYCBwDy5MI1Eq9vSksu58PfZA50zfPc3gAxKk/OsVv?=
 =?us-ascii?Q?3g7PRrW5T+4FVBKJhlQipvHCjHsyREQhEuSZQb+7u4i2L+6WYT4/pjpMCyHF?=
 =?us-ascii?Q?boRIhwssBTOPD80/N7DiQolrfdEhdnA+aJkhj503xfYOb74K/kUMslutemNf?=
 =?us-ascii?Q?s+iU+O69v9PvYXPHQPYIatfOPj5kjyYIMVoboQehBLtwdjlWpCs7NOYarpYI?=
 =?us-ascii?Q?2bS9Ma4awMSF/laIX+u58NILRnhcNuShQoztPFpAPGOdAMRNPiI87hwr5hXS?=
 =?us-ascii?Q?7boI9mgodSri7fn6jFDvwK5a8WOcAQ5wpn3OZwWEdDsP9f8eTXXcUivKMjGP?=
 =?us-ascii?Q?C/v9PZepcLeElTVJFw+c3w78HT6tUcw1LlrV4sdC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6771.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c616343-359d-471e-b6a2-08dbd6ed9dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 13:07:04.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMsQ9cdfhjVGnY2alP288C+xqISTed3bk8BbGKfgJQnhC3Gw0G9cTOlGG4utucGau+25WCdI/8OnWFClXwEKUUS1UCFBZVZ+WQsEqTU0w74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6732
X-Proofpoint-GUID: Yxn1EZfvFJrnlKxRUp_o_bxLNyR0g01g
X-Proofpoint-ORIG-GUID: Yxn1EZfvFJrnlKxRUp_o_bxLNyR0g01g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310240000
 definitions=main-2310270113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Matyas, Daniel=20
Sent: Friday, October 27, 2023 4:01 PM
To: Guenter Roeck <linux@roeck-us.net>
Cc: no To-header on input <;>; Jean Delvare <jdelvare@suse.com>; Jonathan C=
orbet <corbet@lwn.net>; linux-hwmon@vger.kernel.org; linux-doc@vger.kernel.=
org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and m=
ax31829



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Friday, October 27, 2023 8:02 AM
> To: Matyas, Daniel <Daniel.Matyas@analog.com>
> Cc: no To-header on input <;>; Jean Delvare <jdelvare@suse.com>;=20
> Jonathan Corbet <corbet@lwn.net>; linux-hwmon@vger.kernel.org; linux-=20
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 2/4] hwmon: max31827: Add support for
> max31828 and max31829
>=20
> [External]
>=20
> On Thu, Oct 26, 2023 at 05:44:02PM +0300, Daniel Matyas wrote:
> > When adi,flt-q and/or adi,alrm-pol are not mentioned, the default=20
> > configuration is loaded.
> >
> That isn't really a complete patch description.
> It should include (even if repeated) that support for additional chips=20
> is added.
>=20
> > Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> > ---
> >
> > v4 -> v5: Passed i2c_client to init_client(), because I needed it to=20
> > retrieve device id.
> > Used a simple if to load default configuration. No more switch.
> >
> > v3 -> v4: No change.
> >
> > v3: Added patch.
> >
> >  drivers/hwmon/max31827.c | 51
> > +++++++++++++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index
> > 7976d668ffd4..446232fa1710 100644
> > --- a/drivers/hwmon/max31827.c
> > +++ b/drivers/hwmon/max31827.c
> > @@ -39,10 +39,15 @@
> >
> >  #define MAX31827_12_BIT_CNV_TIME	140
> >
> > +#define MAX31827_ALRM_POL_HIGH	0x1
> > +#define MAX31827_FLT_Q_4	0x2
> > +
> >  #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) *
> 1000 / 16)
> >  #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
> >  #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
> >
> > +enum chips { max31827, max31828, max31829 };
> > +
> >  enum max31827_cnv {
> >  	MAX31827_CNV_1_DIV_64_HZ =3D 1,
> >  	MAX31827_CNV_1_DIV_32_HZ,
> > @@ -373,12 +378,22 @@ static int max31827_write(struct device *dev,
> enum hwmon_sensor_types type,
> >  	return -EOPNOTSUPP;
> >  }
> >
> > +static const struct i2c_device_id max31827_i2c_ids[] =3D {
> > +	{ "max31827", max31827 },
> > +	{ "max31828", max31828 },
> > +	{ "max31829", max31829 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> > +
> >  static int max31827_init_client(struct max31827_state *st,
> > -				struct device *dev)
> > +				struct i2c_client *client)
> >  {
> > +	struct device *dev =3D &client->dev;
> >  	struct fwnode_handle *fwnode;
> >  	unsigned int res =3D 0;
> >  	u32 data, lsb_idx;
> > +	enum chips type;
> >  	bool prop;
> >  	int ret;
> >
> > @@ -395,13 +410,20 @@ static int max31827_init_client(struct
> max31827_state *st,
> >  	prop =3D fwnode_property_read_bool(fwnode, "adi,timeout-
> enable");
> >  	res |=3D
> FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
> >
> > +	if (dev->of_node)
> > +		type =3D (enum chips)of_device_get_match_data(dev);
> > +	else
> > +		type =3D i2c_match_id(max31827_i2c_ids, client)-
> >driver_data;
> > +
>=20
> This should be something like
>=20
> 	type =3D (enum chips)(uintptr_t)device_get_match_data(dev);
>=20
> though that requires that the enum values start with 1. This avoids=20
> having to pass client to the function and is more generic.
>=20
> >  	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
> >  		ret =3D fwnode_property_read_u32(fwnode, "adi,alarm-
> pol", &data);
> >  		if (ret)
> >  			return ret;
> >
> >  		res |=3D
> FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
> > -	}
> > +	} else if (type =3D=3D max31829)
>=20
> Not sure why checkpatch ignores this (maybe because of 'else if'), but=20
> the else path should also be in {}.
>=20
> But why is this only for max31829 ? I mean, sure, the default for that=20
> chip is different, but that doesn't mean the other chips have that bit=20
> set. There is no guarantee that the chip is in its default state when=20
> the driver is loaded.
>=20
> > +		res |=3D
> FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
> > +				  MAX31827_ALRM_POL_HIGH);
> >
> >  	if (fwnode_property_present(fwnode, "adi,fault-q")) {
> >  		ret =3D fwnode_property_read_u32(fwnode, "adi,fault-q",
> &data); @@
> > -418,7 +440,9 @@ static int max31827_init_client(struct
> max31827_state *st,
> >  		}
> >
> >  		res |=3D
> FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
> > -	}
> > +	} else if ((type =3D=3D max31828) || (type =3D=3D max31829))
>=20
> I _really_ dislike the notion of excessive ( ). Also, {} for the else bra=
nch.
>=20
> I also don't understand why that would be chip specific. I don't see=20
> anything along that line in the datasheet.
>=20
> Ah, wait ... I guess that is supposed to reflect the chip default.
> I don't see why the chip default makes a difference - a well defined=20
> default must be set either way. Again, there is no guarantee that the=20
> chip is in its default state when the driver is loaded.

The well defined default was set in v4, but I deleted it, because the defau=
lt value in hex for max31827 and max31828 alarm polarity, and max31827 faul=
t queue is 0x0. I had 2 #defines for these values, but you said:
" Since MAX31827_ALRM_POL_LOW is 0, this code doesn't really do anything an=
d just pollutes the code. "

So, I thought I should remove it altogether, since res is set to 0 in the b=
eginning and the default value of these chips (i.e. 0) is implicitly set.

>=20
> Also, why are the default values added in this patch and not in the=20
> previous patch ?
>

In v4 these default values were set in the previous patch.
=20
> > +		res |=3D
> FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
> > +				  MAX31827_FLT_Q_4);
> >
> >  	return regmap_write(st->regmap,
> MAX31827_CONFIGURATION_REG, res);  }
> > @@ -464,7 +488,7 @@ static int max31827_probe(struct i2c_client
> *client)
> >  		return dev_err_probe(dev, PTR_ERR(st->regmap),
> >  				     "Failed to allocate regmap.\n");
> >
> > -	err =3D max31827_init_client(st, dev);
> > +	err =3D max31827_init_client(st, client);
> >  	if (err)
> >  		return err;
> >
> > @@ -475,14 +499,19 @@ static int max31827_probe(struct i2c_client
> *client)
> >  	return PTR_ERR_OR_ZERO(hwmon_dev);  }
> >
> > -static const struct i2c_device_id max31827_i2c_ids[] =3D {
> > -	{ "max31827", 0 },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> > -
> >  static const struct of_device_id max31827_of_match[] =3D {
> > -	{ .compatible =3D "adi,max31827" },
> > +	{
> > +		.compatible =3D "adi,max31827",
> > +		.data =3D (void *)max31827
> > +	},
> > +	{
> > +		.compatible =3D "adi,max31828",
> > +		.data =3D (void *)max31828
> > +	},
> > +	{
> > +		.compatible =3D "adi,max31829",
> > +		.data =3D (void *)max31829
> > +	},
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, max31827_of_match);
