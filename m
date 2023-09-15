Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FD7A226B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjIOPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjIOPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:31:48 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8C98;
        Fri, 15 Sep 2023 08:31:42 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38FFV9v3006745;
        Fri, 15 Sep 2023 11:31:18 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3t4f4gkf6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:31:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw+ojwlnM7dqIGlx+I5KaszycJngjJqvUVWAwr5G4bmmdp2bYtf9u8B29kYAAbzMZyTmV1Evp9OahpXpeCWA2SYIBsikMXM/5i+xB9lttdlgkFY0kSXZzkOwNpFVNytQtD3QrQVLHaDXmEsp76bbiDVK6ZTeD12576w2xY8PdZ7/lgVpGvFilQX5pv4ig3B2WQhdH43ckXYQVgV/gCHXcq4ktUxiiWy9ZdqB18mA7TcyJXBls6KYCjk4rJ8i/m5l8ekCOf7j6LQjFTL9frY7a916mQcQ2p5vKCvf1Wdi43AaR8AOnjVVoZrL1Iwyh/0hE1q/UwiOiNE57CExaP8/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+HH13PfzYFFdPF9Pgc2P2SokhiBuKfTYmBfGrHCCSQ=;
 b=AKGMYRW1TBL288h3z5xObh7Qrp+rS9p3I886UqM/0LZRoII9OyUcy8NYosvEp/Yo47o18AtlEigF8CNKfAv6tPKF6pnVXnCDumd4OuxtWzn73BPzBm/qjuNqM2J+RfZp3a7QAFHNJrheFPvbuI5W8Hmc5fWnmuq2nVK+kBH/MV7wuM/H9hE0XW5w1AUelxQR3OKK5dLQsG4/Zx/KR/HyFtuJO4z9838Bqyju78iLbXL1tzESuQ8LT1JwnGAGsMoBdskmkMCVw8/tNDErweLq8QV/RLKZo8d7ayvFnd8pN6NBY73RwNadlyzzSZw1B1u7+jPny4uKusDIjq2KAyVahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+HH13PfzYFFdPF9Pgc2P2SokhiBuKfTYmBfGrHCCSQ=;
 b=IPkJlFmZhDrrVeJ2ZwFlHIGQPbdhcjc2b4ni4OoPa/VCLbFRVckLvN95p4o+xuq77OcoNV/Brtoxrpo85TSmsy+vkw+CYv3ewfXpRKZwPCPgZ9knoSjcMcMfJBOVNVveYeMjIzOZiQdzuC8k/FN6eBq+ZOdKzm8WwsKYBK+jlaU=
Received: from PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17)
 by SJ0PR03MB7101.namprd03.prod.outlook.com (2603:10b6:a03:4e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 15:31:13 +0000
Received: from PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::4134:3c8a:c35e:3d4a]) by PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::4134:3c8a:c35e:3d4a%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 15:31:13 +0000
From:   "Matyas, Daniel" <Daniel.Matyas@analog.com>
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
Subject: RE: [PATCH v3 2/5] dt-bindings: hwmon: Add possible new properties to
 max31827 bindings
Thread-Topic: [PATCH v3 2/5] dt-bindings: hwmon: Add possible new properties
 to max31827 bindings
Thread-Index: AQHZ5uGIjIOQar6MckC5UCinrmR7m7AaZXqAgAGe7UA=
Date:   Fri, 15 Sep 2023 15:31:13 +0000
Message-ID: <PH0PR03MB677168B3D2689B4D553443E089F6A@PH0PR03MB6771.namprd03.prod.outlook.com>
References: <20230914075948.208046-1-daniel.matyas@analog.com>
 <20230914075948.208046-2-daniel.matyas@analog.com>
 <20230914-qualify-ragweed-b06b7b7923c9@spud>
In-Reply-To: <20230914-qualify-ragweed-b06b7b7923c9@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZG1hdHlhc1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWU0ZDA5NDljLTUzZGMtMTFlZS1iNzIzLTE4MWRl?=
 =?us-ascii?Q?YWFmMTM0MVxhbWUtdGVzdFxlNGQwOTQ5ZS01M2RjLTExZWUtYjcyMy0xODFk?=
 =?us-ascii?Q?ZWFhZjEzNDFib2R5LnR4dCIgc3o9IjgzNjQiIHQ9IjEzMzM5MjY1NDcwMjQ4?=
 =?us-ascii?Q?MDE4MCIgaD0iZElhSU1mNGxXYWY2M1NmWXo4Tzl6b2E4QlFNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFB?=
 =?us-ascii?Q?MEN6Q242ZWZaQVN0K1Fkelh3dnUzSzM1QjNOZkMrN2NEQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFsR1RHVmdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFR?=
 =?us-ascii?Q?QmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4?=
 =?us-ascii?Q?QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFC?=
 =?us-ascii?Q?eUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0?=
 =?us-ascii?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6771:EE_|SJ0PR03MB7101:EE_
x-ms-office365-filtering-correlation-id: f4678d8d-9f5d-4e88-2252-08dbb600cb72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2msh9xAtlCcCVoWxH/NZJnKeWWUy/sbOAGxEgUxBdypj4TEtXMq36blRjBJYMqyeslMDniCf6oYZHCvHBlx9b5WBOYPxrPU4FyBmAnPhkxv6P4PKwfcvot7OWsJz+FZy+Lr49QNAroiHZV/Sq41Faqpf7HYeKH6LnxZVaXwUtKbRwWRkktUq7ATvOuamjhNYc7MGH3sFPZxZcq6bm0KSNyne1P4KBskun5PYYGrV9M3rhJEgNVVH7s8OSo6cILivRdwaAoKTYHflVoqoNJz7C0Cj6VG5/T1LGixpzXTlRxEwVBXL6VX4sCuTE3X3FffmuvpndxD7nnCVxe7462VFt7zmuy7Q0UpOSLszWajdWsC7BPJyUfQ0M2gxSIw6QUWcUtoH/6ftO1+hK+3qeE9/0VZ/ge+AhNTZBGl9/Kyx0m6XJZ4LMP5rtwFuxh7ZYGo2r8RZjQHMJnrxKD56P/9tsTW7o0ifJmAer5RgWOOro83fdeVzY/kzmbvQbuOhpAfC1qGq1kbH7xn3LuS636Y6YNrfkKvuCEP2uDaelCsPQzcHNkMZZrdsQkOV5iXyg/w8Nssboyth4gVd7ILVvkCrNpam3oN7CJ2ySHRg6la//G9PWPf/SX4k2pCn/nzUMiVy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6771.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(186009)(1800799009)(451199024)(52536014)(5660300002)(26005)(8936002)(4326008)(8676002)(2906002)(7416002)(86362001)(122000001)(38070700005)(38100700002)(83380400001)(33656002)(55016003)(66446008)(6506007)(7696005)(71200400001)(76116006)(54906003)(64756008)(66476007)(66556008)(66946007)(53546011)(478600001)(41300700001)(316002)(6916009)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ll8cR23h7fDOl5QA5/yZ/h1hmFXAvQ6ctq4jvi0WKUiAztfH9klBapmJGG9m?=
 =?us-ascii?Q?zfXwCNCUt7wv6YOeGk5iZDcFey+IL8cdAA9aYCrwtLVQBRCTIzDPI+3YO13H?=
 =?us-ascii?Q?w8vrFDUAHW8Ec4ijeatDE97zaIFS+k1v+Fxe5zViSp0arFAgPn0KOsb3R795?=
 =?us-ascii?Q?06ZSssHbGY6kgFx30ImQKU/p+nWOy1Fh6govhUReHPUyLu33NLWHpkFReC3A?=
 =?us-ascii?Q?DLZ5b/a0F/MX8Kaa9BuwLMl54xmAQmWRGK0fDIoU7ntLBpkFGpmwAO2UCRAe?=
 =?us-ascii?Q?uXXAn5CqhRa9gwrFk6vP6vk8Solv1wjj7yWJq1+z8OJ4wR2jqFOH0+NFau+h?=
 =?us-ascii?Q?YoJbHDUHfPnIOxUCWVSaIVoYHewWyJZFQAXpGpkA73hPfOBsLPJnqOK/++NQ?=
 =?us-ascii?Q?gsR+al0SE1S5KTgUfW34a1/Gy0mGCYNypi1lWc8LQNUsMXENY+bgPbSinyzQ?=
 =?us-ascii?Q?MCbrmuhDdtOdcQhWFn5FtFFklCkcMypagkvaK+rIqdhBbwS3flOf1rxB2b4+?=
 =?us-ascii?Q?2zNVep8lDEze1AnyzQW42xuC4u/gDXR/zo0ObEz28hBQS5y5XaUtCnS0yjHD?=
 =?us-ascii?Q?fQ9ZJBLq2b8jJJfE5vNqwI2NMcdGLuRGRwytQEaObBhsloFqV0O9OHw3dToI?=
 =?us-ascii?Q?gWLEypDH9bpBYwGHmDPcLtHZ9uG9uzbvUYIVxUJwNxYPUEies+hWIbS2RK6U?=
 =?us-ascii?Q?l3v85XIYITm9phrMbAFMbjTScBtFjBy3JXFRAo2765UWPM4vQEb1yfK8OV3x?=
 =?us-ascii?Q?J6QSPhEnghWBka+eq1I0qV1MwPffBsvmMJAngETSoRbfHT5JqhOYcS3zSsEW?=
 =?us-ascii?Q?FOiQth3jsQcftXMSF7WzWTFdPojcb7HCDCNER1gfykisLJjbiUoQk1BOJewi?=
 =?us-ascii?Q?gFXwxLqKDTiZis5pmKFVsFZ+0SZ94v3S890FDV9gdhMoiSUosTIv0Lf+Lv2R?=
 =?us-ascii?Q?c1fVroVYqgyVXEF+byiwB1NHSlGnHxmALArnuNZ/V/6/pnsud2Jd1tqvaEZO?=
 =?us-ascii?Q?0/qKYEaZbFKpJtOT10iaPjRPBvaT8oXcII2NK6GXC8xDnRh2PXoFLik+xqRd?=
 =?us-ascii?Q?F6yMz3JvQasqV1AJv9jWlEkphTWz4h+PO5vLGollHcTOMb2MwRbL8RydfySB?=
 =?us-ascii?Q?76kHcZ4sBnBhvI/bS8P7f2yLczweadwQAqRETAN1T7myFjIR6JnZXS4URF+H?=
 =?us-ascii?Q?7m8VTBZ6dmZPdUiKiMgP6oFH0OKmU2950EGGhjtiOMTdhgAzELC7ZYgS+iil?=
 =?us-ascii?Q?uS3s8WEZQu8Ao3pJQXA+AwuKxgzLTqykhMuVgIIkMO8lLttDI9Vauftvzc5L?=
 =?us-ascii?Q?Ot4btsWEYVhFWNzO66skj34zYNdCJnPZd47nu1Xiff+x1+J9xdm7ekLA7/1j?=
 =?us-ascii?Q?KA8XQk2CADJleUxTMfXD1J81iMIsY/XgsH6K9mr1bDNuzT5OPf1Rz2WerSBf?=
 =?us-ascii?Q?VrZrbrUQov8PJrd9El471YAJOAELVYeo+k1ywA8jufj7jcu+y+Uz5cVm2JhZ?=
 =?us-ascii?Q?N1s6N32e6qNERe5YE2RQWVCdGDtyQkCyks51Pt9tAOpx/gNTlfBJqQfx1Rnm?=
 =?us-ascii?Q?H6OSCzpT72p5C6vvGGjzbFlGkOtbXikwz9P54o6e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6771.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4678d8d-9f5d-4e88-2252-08dbb600cb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 15:31:13.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0BIfqjC+k5sSZVAFxvh0Ut60F7op8Qq086AEb/oO1l1PIHB+9YFCCit9kNs6Bkn5JWO4OrFw4PiKrcmljRUl62w/xqEFFSErs59jZX0OjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7101
X-Proofpoint-ORIG-GUID: kj6RlJ20phUWQyhWC6MbLQkUQnGRHIY1
X-Proofpoint-GUID: kj6RlJ20phUWQyhWC6MbLQkUQnGRHIY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309150138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, September 14, 2023 5:42 PM
> To: Matyas, Daniel <Daniel.Matyas@analog.com>
> Cc: Jean Delvare <jdelvare@suse.com>; Guenter Roeck <linux@roeck-
> us.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: Re: [PATCH v3 2/5] dt-bindings: hwmon: Add possible new
> properties to max31827 bindings
>=20
> [External]
>=20
> On Thu, Sep 14, 2023 at 10:59:45AM +0300, Daniel Matyas wrote:
> > These modify the corresponding bits in the configuration register.
> >
> > adi,comp-int is a hardware property, because it affects the behavior
> > of the interrupt signal and whatever it is connected to.
> >
> > adi,timeout-enable is a hardware property, because it affects i2c bus
> > operation.
> >
> > Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> > ---
> >
> > v2 -> v3: Changed commit subject and message
> >
> > v1 -> v2: Added adi,timeout-enable property to binding. Fixed
> > dt_binding_check errors.
> >
> >  .../bindings/hwmon/adi,max31827.yaml          | 35
> +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git
> a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > index 2dc8b07b4d3b..6bde71bdb8dd 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > @@ -32,6 +32,37 @@ properties:
> >        Must have values in the interval (1.6V; 3.6V) in order for the d=
evice
> to
> >        function correctly.
> >
> > +  adi,comp-int:
> > +    description:
> > +      If present interrupt mode is used. If not present comparator mod=
e
> is used
> > +      (default).
> > +    type: boolean
> > +
> > +  adi,alrm-pol:
>=20
> Characters are not at a premium, is there a reason not to use the full
> words? "flt-q" in particular would be quite cryptic if I saw it in a dts.
>=20
> > +    description:
> > +      Sets the alarms active state.
> > +            - 0 =3D active low
> > +            - 1 =3D active high
> > +      For max31827 and max31828 the default alarm polarity is low. For
> max31829
> > +      it is high.
>=20
> This constraint can be expressed in the binding, rather than in free form
> text like done here. Ditto below.
>=20
> Thanks,
> Conor.
>=20

Ok, but how? The default values are different depending on the compatible s=
tring. I searched for similar examples, but I found nothing...

Some bindings use 'default: ' to declare the default values, but this is th=
e default for every chip.

Kind regards,
Daniel

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +
> > +  adi,flt-q:
> > +    description:
> > +      Select how many consecutive temperature faults must occur before
> > +      overtemperature or undertemperature faults are indicated in the
> > +      corresponding status bits.
> > +      For max31827 default fault queue is 1. For max31828 and
> max31829 it is 4.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8]
> > +
> > +  adi,timeout-enable:
> > +    description:
> > +      Enables timeout. Bus timeout resets the I2C-compatible interface
> when SCL
> > +      is low for more than 30ms (nominal).
> > +    type: boolean
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -49,6 +80,10 @@ examples:
> >              compatible =3D "adi,max31827";
> >              reg =3D <0x42>;
> >              vref-supply =3D <&reg_vdd>;
> > +            adi,comp-int;
> > +            adi,alrm-pol =3D <0>;
> > +            adi,flt-q =3D <1>;
> > +            adi,timeout-enable;
> >          };
> >      };
> >  ...
> > --
> > 2.34.1
> >
