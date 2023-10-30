Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C607DB4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJ3H7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJ3H7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:59:42 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A41A7;
        Mon, 30 Oct 2023 00:59:40 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U6BLWA021704;
        Mon, 30 Oct 2023 03:59:16 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u1f5hp8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 03:59:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXsw7aCx7gXbDwsrtK2G757cZJZ/kn9tWtX8+EzsynSuiGoOBY8qCn0n04aaDJ5pml6BSYLya2LwF1/R3b2Rt5e+c2kGYRDEnVdCdnevzqq/KgXz+gLInWsYvD095aHYiV3DdZsDoOfjP5FdH8NS2zCGADKqPrZYoDy8cG8IxbuhztY5acJKqsXMESCjuOR91DPvevNQ7EE/rxFnT3gSB4PJRqChixO2LXOO59HQIW/FiQacUuf8bUT5WoBrX14NHWmL2sRYJE9xVMVc0gPuQvJRqKqccSTAxZlUA9i/qzy+hVcqIqAFW08PT0JXfbyOCy+xjiYDH6PAlLqe7lIwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uaz/eAXAgvFomGrqW/uQdB/u1gT1gS83WUEnYRPSPhY=;
 b=BazSoXkidgrtiJB+/ezUzXnrBdVuJV6c8IiqpqQk5J+SPS/FdI0TmtiXs3p3ir3U4xPx4NxLwQHgmh5MOi1I2Q5qDlmBjG8H/R1GQL5GWKgcF2hXYfGnGwVrzj8vZjQdtSfLPyP7F7zRBXvIoRFcJE5VcSUnbQPnejkcrgUCygw/H3poJvK4R0x0/KMD5ugVu72y5AHSSEDwPNjqjzBGtf1oA3cI1/a8+fBvKOzGorAff3rau3w423OREqFb3WTmqWiZ2H+RzguuwNsySzjreMdg138Eb/lnB6RaVVqJLfOWDTjh1vG9XeH4tntnXG/gWTnbgCdQ6IYNNXd3UbvbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uaz/eAXAgvFomGrqW/uQdB/u1gT1gS83WUEnYRPSPhY=;
 b=M2qUK19gw133atrPbaJoHeS1O/cRzHpMMHwtcMuAIFuLDg4f7WsbBLNXeyjX+e+Y13ZlO6hQVHBwCZY1ztI2tjnk0mko3zdDLRPy/PmUJUgksWN1sHqOtOA8YqsoHaROTwYPK8+JdJdE8Jn748l9pH5eGREzStz8fpAFI68MUGU=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH0PR03MB6068.namprd03.prod.outlook.com (2603:10b6:610:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 07:59:13 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 07:59:12 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] hwmon: ltc2991: add driver support
Thread-Topic: [PATCH v5 2/2] hwmon: ltc2991: add driver support
Thread-Index: AQHaB/gc9TyQBjH91U+XiC0CuBoxd7BfZOIAgAKYcqA=
Date:   Mon, 30 Oct 2023 07:59:12 +0000
Message-ID: <CY4PR03MB3399049CB79E0F468A945C659BA1A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231026103413.27800-1-antoniu.miclaus@analog.com>
 <20231026103413.27800-2-antoniu.miclaus@analog.com>
 <075f6150-74f2-478e-9290-aa7186140cee@roeck-us.net>
In-Reply-To: <075f6150-74f2-478e-9290-aa7186140cee@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0zNjE0ZjQ4YS03NmZhLTExZWUtYWU3Ni1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcMzYxNGY0OGMtNzZmYS0xMWVlLWFlNzYtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxNDcxIiB0PSIxMzM0MzEyNjM1Mjcx?=
 =?us-ascii?Q?NDE0NzIiIGg9InNpOTRuZk53b25HTWJHZTlxMDdzL3BCSlhwST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QmdnSGY0Qmd2YUFZbU02RWRoQTdVN2lZem9SMkVEdFRzREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRU9wbE9nQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH0PR03MB6068:EE_
x-ms-office365-filtering-correlation-id: a06aaf32-472a-4997-1aa0-08dbd91e1acb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93YQeuqQMixgk0urIqhzPZYl+RFirkpwTJvm0LT73UOgUi8L9mFkq1zK0ror9tuAqeDbNoFzDjB7SRyPqaLaNzmzcSjGkc2Eh9MunB8hVWFPPl0BVOYcRMYi9WGfuNuH8w3c53aKnuY7Rf9AcGmc6ojq0y2K7IDTHgaZOuVCrF3foHWHORbD7GJ6xk52ETgXnvGl2iLBzLPGapVDpkeXO8jkzG4pfbZ2ngstg6tmdOd/kyBhBdgMYmrTQS7aA8iJEg11Pz26OP83bqoIotQRzVx+/Tuf2ZgdcCXIZ0JlYSP5NyX7urdO+CwOzUofMELTaRu9GplgRNk43MbRRlbeAUBfSRKLWpzB0hRyLdG/K3zbamETzxTB4oB2l2M5gCf1xC5zuUrxyzxxCc7xFp3P6KYCxBs8JCYtzqjDLZzuF6ggKORLzrDopc9/XnqoaTmlmRdZED49VugbASxHKk0bjKDqu+uISNhH/yBEeLgKWLyiUjs7Tw8936jWYfQd4hq7Q3fJy6TJTaNVfOslbf87c6PBmyfKKyRwrVttr2laGxWqKCm9ceoG/JNldZtvDDKuLKZZA4z0dD3lEkIMriehNJAVgnoPyv31rzctHasdj8tykqkW858H3304auKzkAKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(71200400001)(41300700001)(2906002)(7416002)(5660300002)(86362001)(55016003)(33656002)(52536014)(26005)(122000001)(38100700002)(6506007)(7696005)(9686003)(478600001)(64756008)(54906003)(66476007)(66446008)(66556008)(76116006)(4326008)(66946007)(8936002)(8676002)(316002)(6916009)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wR5sygZLoWjs/C5FFj6J3PudO4R7gBoL0mGeyGunEhb8VIRSc9JusI0CC+fU?=
 =?us-ascii?Q?mOHcVGQtjjgDJmdyy4j4Cbs/kLulGxmYUDGTIJpU4cukshEXyFdgq+OGnJ59?=
 =?us-ascii?Q?8yVfgTi+OFw034MXrfPsIbCbnXsYg99sLrlFLJWr8ku9hkvprr8h2gwMJaWI?=
 =?us-ascii?Q?uDsUw6sNf0ZuqU68G05lz1++hSWB7cYrHPoFNRXcCu8DBU0WDjefdP8Jnvw5?=
 =?us-ascii?Q?CilKTxzxn0RTcCJvTE8xMFY9m6+U/NOXo/syG4dVnis3Qpx+LYQ3V96ANqjt?=
 =?us-ascii?Q?syet9LHjADBKydO8KUA0YCbNS3v8b3le+wKFPM7REKALSnkC4+QR+aGWcLWn?=
 =?us-ascii?Q?akqNitR/cQbKK7A9x4lhWCCGlSqUBOfaOqKaqpmF9LljLG1QuKjUz4aJAdl+?=
 =?us-ascii?Q?u8SZJhFZs0a7fYO6RtQq6EtgRig9A4+xVTJrU/YRZngHgj2AHjk04vtsBsFe?=
 =?us-ascii?Q?hEo9bkiIDXmoGmqckyt7qYxeHNcCXMU8S1O/x0T5UosE+1j0w4xODjnIi9ya?=
 =?us-ascii?Q?rMw+zh8xMnvqO/7Z8IfG02lapZ3OhPNRedmrf+b9ogQB+X0YEVkwX3V+0Nmg?=
 =?us-ascii?Q?4UgCz2/ZyY9YpUkZ4H6Jf5GBv/6618EfKtqf2mlbz3ywk+dCX8yuQRnEmtGf?=
 =?us-ascii?Q?4ydomd0sXUGvxtPrpwgeuyZQg2qSi0sIGxp78SPSdSO65mYvqOCzcmhj389C?=
 =?us-ascii?Q?zZthccAKqiKVMLu1suMeZBbeL5Xze7n/pPucPdPsKqpBWa8nNVT112iXWW6K?=
 =?us-ascii?Q?b1+2tFwgoPeV6e+dxdzopRmqFVPRErjhQ/oo25s44yFMrq4lz03aNJ9WsZVH?=
 =?us-ascii?Q?z0FkCpXWzfubvXoMnVTeVLIimmxqcmQ51ERL+BtZX3FAP04f87sJbrGPIda6?=
 =?us-ascii?Q?r9N29DfCY0ZKwDNtvSuUH9bUSUfKq529bNh++to2K7IPPdHt1Ietkj39JAw6?=
 =?us-ascii?Q?lPL6eyvZzhUFWO9Qk69vtXdykI6uIiCwur8Kpj39PKBPYEGiaYPyBJkfaxNi?=
 =?us-ascii?Q?HtsEHlBoSQ6jLjNIxeuwfP/rqUKW+WHPSFGR9otJoA9zQr+UaItSu1kovNMF?=
 =?us-ascii?Q?vYs7MaEdUR4E/bC3QAkCITtkpk0URsit2JkfYrCGitmCyedMKZ/vEVgP1yNl?=
 =?us-ascii?Q?u6eolrg/CaGWAENgukQGtnk/hDgTkAtCyH05DMiULiV5gyHo6AvSjS9AKJRP?=
 =?us-ascii?Q?qyYXkdRv/xqeJNGA3qyK3csJx+P9XdTZnVVLGsD9kdhqJL1haG3KzRroh0zW?=
 =?us-ascii?Q?0IDoUZ0eY7/fs+LPl5KGjxVLRAkzyh+RLXzcBMUh4neOummnGLSE2IJNxr5L?=
 =?us-ascii?Q?fCvzLFdKo1QFjcSgH4qDdJvxsgB22cuaa9CmuVqsp+xXUDFxnHdLqYSj/UNP?=
 =?us-ascii?Q?Zm07GpLFdXmuxi2iaRjnUPfqtDtlWnPx04pmqpMRJFFahJ5R91myGga0Gntl?=
 =?us-ascii?Q?/312zkz2q7e+G6sK4dO3PZ7OJVzk8Sat85S3qo/jLnBxPa7gyMvTqMy6rw91?=
 =?us-ascii?Q?dL34R2Bp6lIC68x2qSb+CDwtt8FUvLCaEjJGIFcZZwAyzGtG5vOpFnLq7cRd?=
 =?us-ascii?Q?nsZW8vjkAYrMFWsw4kfnqAegHr8Lt1z0Y+xyLQHvsgNslgKVxJRXXhBi8/E8?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06aaf32-472a-4997-1aa0-08dbd91e1acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:59:12.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxdoX94VDQzsooXNBcWXvZpmTaXvVISX6GR2TIkBu0WULok0D1GuLZA16a4751kbH0jFr1dzdz+uKmb72Wap7YCcNCVPRa6nxIL7F+RvEBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6068
X-Proofpoint-GUID: SpVjsjbwRc5IYtHlawiMBSq3EZozlxxV
X-Proofpoint-ORIG-GUID: SpVjsjbwRc5IYtHlawiMBSq3EZozlxxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310300059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Oct 26, 2023 at 01:33:13PM +0300, Antoniu Miclaus wrote:
> > Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> > Monitor.
> >
> > The LTC2991 is used to monitor system temperatures, voltages and
> > currents. Through the I2C serial interface, the eight monitors can
> > individually measure supply voltages and can be paired for
> > differential measurements of current sense resistors or temperature
> > sensing transistors. Additional measurements include internal
> > temperature and internal VCC.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Applied. I do have one comment (see below) about code which
> I would normally reject, but I am getting tired.
>=20
> [ ... ]
>=20
> > +
> > +struct ltc2991_state {
> > +	struct device		*dev;
>=20
> It is completely pointless to have a reference to dev in struct
> ltc2991_state because it is only used in the init function and
> dereferenced six times there. It would have been much easier to
> pass it as argument to that function. That would also have avoided
> the wrong assumption or expectation that it is needed/used elsewhere.
>=20
> Guenter
Sorry for the misunderstanding. I took as reference some old driver
implementations from the mainline kernel.

Is it fine if I do a follow-up patch on this subject in the near future?

Regards,
Antoniu

