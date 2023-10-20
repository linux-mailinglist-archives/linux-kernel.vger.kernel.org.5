Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CE7D0E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377047AbjJTLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:19:00 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683191;
        Fri, 20 Oct 2023 04:18:58 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39K86sTq031492;
        Fri, 20 Oct 2023 07:18:47 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tubx8c81j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 07:18:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNx/FWD81ZHWYKrsw1TAxTTX+OT1qxFOQQWxa8dmJ5prYgGozTAxwwBhP/fqboYhP7Feqli0Q/9D4OE8wdYI8uLsQE3Xk7Cgfv3X3MiPz1+EMvc0V0GL2XjfCqhHUmzxeUpojMEgWprPOgoEe2D86qFObRStFHyjts/tVmTVA+s2IIQYve7TVAYgKtXTbvJlMy7liuKfbd66XQpviQKbxbttZ7WDG9gSqOVNUUBq61ZtPdiHfp5EXV2aZhyZIIAaU4wAj0sADJjBGwmAkxmp5AhJoFov471JWWMv9r0zIWXzFbvQYZZeoiEFvY+7IXY8JhbhtVgH6aFTuCXwRtP3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqri1q4g+3/KYN7XI55mNRIn1QO6D2fCRAZkW43x9Ug=;
 b=PgxazMd+8l2Qx+H5Ce8PdUqFV3yNI1elicUNCDN3jNqA1NZGG56ANy5F/wHjYhxsGr2DTJI383cFvC70/nEhTbThkA84Yx2Gv6VP6KA2uvPJ1r5NnDMdH6REKLPbTwCinvsNkz3npKJCfRGHnB2Q+Q4zS78JNY4GEuPFL8eu2moeiALLcRjvb/XcGXHbyqz8mdcaBTuU4RUcGRYYbPumuvEedjxfvGcAKOngXhod6bwdc+EJ1CGd33EIpWWlU+gPn1NTfWW6pTRtEJ1BKRO3gtbp/hmwzbDw1JKLd3R+xQZ2jNyGGuuYhBX8TDbvOLJyCyuy7MHsYK26UqfTLTCZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqri1q4g+3/KYN7XI55mNRIn1QO6D2fCRAZkW43x9Ug=;
 b=bieo7Yza9Qt7afPjPUo2azE7Ic+l+ECADSwClyFJlwsNqWjXG6ZrB966cMqUNHFtMX9nZGZmomsCWDW4+/ujk4kQmXvXuGv+4U86ex3i2ODpuxKE45KeSRfo73rQnstzejKGswlUjUAZUL4Us5d0nzGuO4LXsRSXLAB5QZP70eQ=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by SN4PR03MB6799.namprd03.prod.outlook.com (2603:10b6:806:217::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Fri, 20 Oct
 2023 11:18:44 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca%5]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 11:18:44 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHaAow+3kwQRklh0USw0Mt3uyHh0rBRZjoAgAEeXwA=
Date:   Fri, 20 Oct 2023 11:18:44 +0000
Message-ID: <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
In-Reply-To: <2023101917-cork-numeric-dab8@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNmJkZjdkZTQtNmYzYS0xMWVlLThkYjgtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDZiZGY3ZGU1LTZmM2EtMTFlZS04ZGI4LTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iNTUyMCIgdD0iMTMzNDIyNzQzMjE1MjIw?=
 =?us-ascii?Q?NTIzIiBoPSJtWGdoTE1vWjFWTzE5bnlLYWdzSndpZi9Yc3M9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUFy?=
 =?us-ascii?Q?SjAwdVJ3UGFBVWxWY1AvWTYyZ3hTVlZ3LzlqcmFERURBQUFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|SN4PR03MB6799:EE_
x-ms-office365-filtering-correlation-id: 1eea58ea-4145-4662-d25a-08dbd15e525f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4orOuCGDB2NFuhXoIZALpSJIsaiqs2l5Aoogh0Sq0evy4nNZyJLC4Ho74s0Rn/p6LDcCPgKxuiF70cIvKFXDeeBy9OEiKuV8KCHehzlB3UCU5Grf0rZ7IEmamJeXYhenO4CsJsrDuoH+MXY/OGkK/WVXe+vej7v/Sl20GYe2j2EVX0ZxndJvFf41k7yJNUdRPgxwHuSfKWXNkuxCI6gMxCBaVvMuJjeuUjkLvo5okMXsAZ0wM5sueZBxwFboV4OE8RN21BaSRWvz1OqFVAWjK8JLtKSnxjaTifnBJ7IizXvWbAn6cuMKV6h84ubpMe5Kp7sbUcq3i7gr37HFt/DV2nb92ecdyyXivUjoIT3svFKGFzIAilFEBNCMGtr4ATfrb+DdoI8pP8tFUPnd9Le58+b3h8CxpZ+GsOlwqq6Xk0ksVQlSqbi9xrAK3d5n3ca/MLxmZk5s15nrSVri/RMmBs9LwDfLDG4hhQ8ZZQnwllncakoT7yRvHnoGBMmfGVnjtFTkv7tcZJHiL2cqnG6nNt1tR6QjAL+52c1llZbBu3yKk8k1UDWJeJolb/UbE+mYKx0n9g1DXyEBviZ17FQBMt+KTbg4hUN1L6gCTRtfZUkJf83yJ4iqMetdyxYdwy4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38070700009)(55016003)(71200400001)(38100700002)(86362001)(6916009)(52536014)(76116006)(316002)(66946007)(5660300002)(54906003)(2906002)(8676002)(41300700001)(83380400001)(66446008)(9686003)(8936002)(53546011)(6506007)(7696005)(66476007)(66556008)(64756008)(4326008)(122000001)(26005)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WPBRExj6FfpDpcizlb69THpu6xkLwIUcKN2BVDZjQVWsnzT7iibsfDTCe5vF?=
 =?us-ascii?Q?JAN8orOmugpvgEfDgx8+yG/YFoOPMdxaFw2ITSE0DwrxmYxXudhzUuUNvtym?=
 =?us-ascii?Q?FZhxJ/zIepyU1ZeoKvK+M0O2oUC2ruZVF+c1aPopDAlE8aVXM7pJOKIi43Fy?=
 =?us-ascii?Q?aGW8PEymAOopUs4h9/cpEBDgxCr1M4iLnjxiSBMPew905wF4BauMfz2OmReS?=
 =?us-ascii?Q?D5zUCp/nDI0fX1bJd0x8j7ZNX1HesOvTJgChI4M9MCfog4AOxb0JXTsvSq75?=
 =?us-ascii?Q?QhgiIyug/M+NXAeVzwU6KnLkZSstttR+2Y13NGHXQTK/AexSSRLiFOztzg2X?=
 =?us-ascii?Q?YRE6JP8IABAswoqDl+Ndh1OiLBJgM4aO96jxrU4M0ZW899Pb05Cu1kwHcP4E?=
 =?us-ascii?Q?5WKAn0QYQxwHaIwlDWvt2MPZ7UIwMq9ICQX0SVZJFuS26O3kT9+EMShHzPyu?=
 =?us-ascii?Q?8VbYwUQPAFXvWSGtZwfTfwKDPB73iN3LioIy/+rDu+G/dsa4kdaU98rQFRvE?=
 =?us-ascii?Q?i22B+iT3uNRUaTWRcaY6iJgfHdl5PG+vZ2RYrKLQq4BZDzCtVsxnWcaQShAv?=
 =?us-ascii?Q?3+tx/EwW266HYToFxpYX2MIk9bxM+GphqWAq+VL543v1Ki6QWdGmQKW/j+hF?=
 =?us-ascii?Q?05Y0QR60b3BLo5gEHWRRVGJKXYqHqJjfv/vng5HlDTpUCV8lYxrJFzyWMokN?=
 =?us-ascii?Q?6rM6cSPiuwALlVCf6gEQ45vsmYhU60oRWorfs9Q6Sgfevhi3PFVK9i9CftM/?=
 =?us-ascii?Q?d3BvieJSszu/xrcfiFCrUdraYlEOfaZomX5BYdPLLURzveMrOX5JKi5l43Vg?=
 =?us-ascii?Q?3btOpPCitHxeH16kypVAMV+BmJbAMhCehMhfm5luRUvVeFpjXuDoA+3OZka6?=
 =?us-ascii?Q?DrVgFVZSK8NfOIwCK/OCm704koYJ4QoziRel8Iu85r1CL3zp50qZRjrGfRjx?=
 =?us-ascii?Q?o4/na7DpfD/SpkVc9fv1mqoCK1yVCsJDHTg1F7+zJAP+qlG9rrXf+OsSSRrs?=
 =?us-ascii?Q?AH6rK9ExLzxETXtLadu+GdaNInqmfnawvvnHBV/3RYGMMNSBVmyuk7Efs/Sb?=
 =?us-ascii?Q?5zBN8Vcv3z6n1xVTKQ3s8sEZoyP4H0XpQnAXH9w+CUPzHGJVfWWYuMKibyWQ?=
 =?us-ascii?Q?I/E/rBv5oest7g4FOrcTlnhIwcgDOKUgW+Be7OvrxIw4+9P/AmTahcqQxCLz?=
 =?us-ascii?Q?eDMBL27eibI2aoEkKbc9br5BE6B8Fu+HeVlwZCQjKP9Ak63JrahQh1b3Dftu?=
 =?us-ascii?Q?033P+RkijVaWZi1phjnvmopwxa7tQHw1oOlZYZxYQsqo6Y+I9is4EvPTafXT?=
 =?us-ascii?Q?tOa/WBcm/jr8xG9qFBYiKZyvEV4FDRKnPnLJNno2UW7BYqkN4xOlW9kvpvuU?=
 =?us-ascii?Q?kOv0urbVW6SMH7Jnibjbs0c3M755c9C1Vn0pcdrsoXJel7BF8aKL1PKlkVyA?=
 =?us-ascii?Q?zu5SI3EZsksTceHoHfs/6o7iOkwA6fscginClrDqKwT8MEYPYDRdRYOYtU1d?=
 =?us-ascii?Q?A4qf/BcFcUemDPBbYGFCbVCSknPTdw8oetqbw2jXIxgUG6xz6bUj0XAz16py?=
 =?us-ascii?Q?9rT07QtS/iIJCgntaj+9BnbEj6GeRstlPYmQoJIS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eea58ea-4145-4662-d25a-08dbd15e525f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 11:18:44.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSaY+jrAy0RQK/bIVU0lVMaDtJSldEfNrVtoJvuK1VksbqKZNync6AWHySFLCX2A22aucNWFORYPP+iB18GW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6799
X-Proofpoint-ORIG-GUID: 4TMbOyVCKikdY7X87A26Bo_LgJcaCNGv
X-Proofpoint-GUID: 4TMbOyVCKikdY7X87A26Bo_LgJcaCNGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310200093
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, October 19, 2023 20:57
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Rob Herring=
 <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; =
Derek Kiernan <derek.kiernan@amd.com>; Dragan
> Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>=20
> [External]
>=20
> On Thu, Oct 19, 2023 at 03:56:46PM +0300, Eliza Balas wrote:
> > +config ADI_AXI_TDD
> > +	tristate "Analog Devices TDD Engine support"
> > +	depends on HAS_IOMEM
> > +	select REGMAP_MMIO
> > +	help
> > +	  The ADI AXI TDD core is the reworked and generic TDD engine which
> > +	  was developed for general use in Analog Devices HDL projects. Unlik=
e
> > +	  the previous TDD engine, this core can only be used standalone mode=
,
> > +	  and is not embedded into other devices.
>=20
> What does "previous" mean here?  That's not relevant for a kernel help
> text, is it?
>=20
> Also, what is the module name?  Why would someone enable this?  What
> userspace tools use it?
>=20
>=20
> > +
> >  config DUMMY_IRQ
> >  	tristate "Dummy IRQ handler"
> >  	help
>=20
> Why put your entry in this specific location in the file?
>=20
> > +static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
> > +				const char *buf,
> > +				u64 *res)
> > +{
> > +	u64 clk_rate =3D READ_ONCE(st->clk.rate);
> > +	char *orig_str, *modf_str, *int_part, frac_part[7];
> > +	long ival, frac;
> > +	int ret;
> > +
> > +	orig_str =3D kstrdup(buf, GFP_KERNEL);
> > +	int_part =3D strsep(&orig_str, ".");
>=20
> Why are we parsing floating point in the kernel?  Please just keep the
> api simple so that we don't have to try to do any type of parsing other
> than turning a single text number into a value.
>=20

The adi_axi_tdd_parse_ms function does almost the same thing as the=20
iio_str_to_fixpoint() function which already exists in kernel.
It parses a fixed-point number from a string.=20
The __iio_str_to_fixpoint is used in a similar way, as I intend to use adi_=
axi_tdd_parse_ms.
It writes to a channel the corresponding scale (micro,nano) for a value.

Since the device is not an iio device, using an iio function would be confu=
sing.
That is the reason for creating the adi_axi_tdd_parse_ms function, which is=
 easier
to understand since I don't have to make all the multiplications that are m=
ade=20
in the __iio_str_to_fixpoint function.

Thank you for review,
Eliza




