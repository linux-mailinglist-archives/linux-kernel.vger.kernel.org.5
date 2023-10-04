Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD9A7B857E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbjJDQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjJDQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:39:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3CAB;
        Wed,  4 Oct 2023 09:39:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIiqT024122;
        Wed, 4 Oct 2023 16:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DYQhdNDmmINNT6SurIRs80Wmt2/rh2XkHOWRSSINC6U=;
 b=AXCCK7DlAqBttg3945xo/0HWbbUlbH5YixTPZD4HmSXMUwjjBt8DJY7WZBulscXuYXVB
 VyVx5xyoViSbbJNNIHymdPeKsmTJr+kOAFfJeFN9eZTXx3WnN/NPQmiINcbiboXq5hft
 agYG190D190ndl/Q5OmEDg0jWMyc+4EnMeivAU8+LmDdmWs1G0n8Dh9PcpcisJfFjUaa
 Y/zJDvdPJe1O8Nk4Nu8E/ua34v0lZqvxuoELomr+voYIcaJHgvfCv3TIkI0vyKK/fC0Q
 NGq1t+028bGYtaBq4Ee9H9c6tQDYbYm574sf2qtI4+uhD+itKNCpON/aDhjWckb+fRPV 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf47k95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:39:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394GUJ6j033618;
        Wed, 4 Oct 2023 16:39:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea480rps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDC7ODCceUTOjf8P08dsS0agzRhM2ms9M72qpwISYUmFmRzR0384EazjqRKv97bAv/XrSaDXayznYnwFH0cfNjzPtY7hIRBcLOh7uU8OupErlL+O3dM2wliIef4u8t8H9i8PHDgHSpLyBMuBlQ4EcvxJMkE9iDps/QVYcEeJZkb0Ncng9h+3DZ/wLDAvvzB0C4iCeKBBwJ1DS4VYM2+tbyys/Lq/T+oUrq5ORCEa5TAjz7kStABHpKztapvwTBFM5hFjj/aXS7EDhHCRrS/BEdSyrq6CervLl+fVFepYV9H0oEReiM1C/B7MzyNEXX4qHwZVuesL6WpARh0iLYWcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYQhdNDmmINNT6SurIRs80Wmt2/rh2XkHOWRSSINC6U=;
 b=jmo9Sp93R5d/ENxo0EXL8B9l/qBiyQjwLaT6f2KZPcETHqoz3YQbQbKAf+rpC1nJ9lKVeIMI8JKLbpS+rY3MZBDQZX7veMbYWn6T5bdUv6SMBMCc0M1LzYDlpFyjcZKSFiOvaIUCv3Rizfg3E5x4QEYp7dhMX2qtmSdFTqbiLiAeHpYyrcef0kYmDisgCSC780HoLzT+0KY5inlrdJMSlHkNn66Bq1BozfEGacGq406t10VKb0YJjEPSTrD5GBh9LIQFJFqeD0AT1pLi6u39LkiOQ0BHebnBZ4ilZYseBhyzVeh/nIlGtxOba3cwh4jcG9Irsyqn0l8GTtWRQSUoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYQhdNDmmINNT6SurIRs80Wmt2/rh2XkHOWRSSINC6U=;
 b=M6XrBn8vAxibHY2XLA9bzSPPygP/VJ8FXkRqKRU9QrN84r/8y5py/2XBAR5Ws2s7nK8kI2jP2aAoHVxfJyHLhoKS1/sezPuKFZKvM4ebFVBUWMb6AzDPehTW3Zkoj59KI0eg8nwKV0uSgRaoTCzogOFUx/sKNbVSWS44t+wFZ1g=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 16:39:14 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 16:39:13 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHZ647wLdBfKiOcokm+jxdng1npYrA52wCAgAAQcIA=
Date:   Wed, 4 Oct 2023 16:39:13 +0000
Message-ID: <C6E5D2C3-D280-4BDC-8DB5-948605ABF2EB@oracle.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
 <20231004084011.7aeef442@kernel.org>
In-Reply-To: <20231004084011.7aeef442@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ0PR10MB5742:EE_
x-ms-office365-filtering-correlation-id: 3cdecd40-90df-460d-a5b5-08dbc4f87190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PV9VvZiPh4FUfCOu9Kbc2wCsBiCfqsc9YQ16P+8Yre7SGNrvwHr6Oay4U1/CRZVV2ac6mbf+brF3s2Mp8xBIaHQu2K2a6FT6dlu61KJxYMMdEMRu4CBKNesDObRA0cDStDqF47mTdRkrB3RTlHpY1taozq09qv8X6ewIb8an9j1IwkOYeiAZqeMgxc3xghyqTdnKRFzrEYh41pgKDwTlr/OPuVdT/ZBNcIEMuUabJgDMa+JEAkyBmTcP/l4uIJofiS3iIDZGNkw4I/vnKb8FmWsnPuh4o+iq/K/DDPJHpjna9kPdE3oqf3v/zku/+3BcCN3CVK6mX1XvytPKtup6lUnw/uyVVCdP9fyhdOt818pT4ZGcxC6aN2/14kvuN89xdt3ygJwxCoXmaEOVkkBvoG8GmbKiwqAAhVKUo/Srmf1zsJck0UwFOJ2RynTYTDU3aHtTIE8M8EgOxKVxzLyXR5up1ELKR5hQz7hktdIZ3AqUGKC7ZhHpel73HSYB48AwfD3jx7sMX+tEFEqoOZocShwQBjmJw5idCbmgnOUTnvoXsXCd/gCIh4tzkETP7HQ9YMsFZhWVjxnS0fr9oG9K/4U8uEXRe7tT69zP8IaiyQUb/W76yRgVfEYzrCTlfvwugJqkL/azKqasLEdH0quw2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66476007)(66556008)(66446008)(66946007)(54906003)(6916009)(64756008)(91956017)(71200400001)(478600001)(76116006)(316002)(2906002)(6486002)(4744005)(38070700005)(86362001)(36756003)(33656002)(5660300002)(4326008)(8676002)(83380400001)(38100700002)(53546011)(966005)(8936002)(2616005)(41300700001)(6506007)(26005)(122000001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrAmUc31thzv7bVM9JNX4NKrGRsIwBzV3e9Emct4SCJwqi3cyvM2G8ie4CMY?=
 =?us-ascii?Q?p47vTS/I1hdG+ULfLRW4v+72vU9FpV3NlijfKZaUUFizAPG+PVBXGvq/AAgR?=
 =?us-ascii?Q?sxAE522+XeJL0yj6Hf8UKFY8TYJQRxV8Pa/JaUfPfOGlEXciCXluAkq7Uxq8?=
 =?us-ascii?Q?HBh6HxhAUmTYYHMJd8GBa80r5X99FFOc40soQ6H10TIMq66W4/Ng0SYfDK1A?=
 =?us-ascii?Q?pgsxd7xk8/eKHcQ/VLQc0vmH12BTMs4aefcqsPpXqO2pMsXwqYZ3grClwBSN?=
 =?us-ascii?Q?mDoE8cO711blV4nk5kjuzR51VGVmRGNujhrMLKMfNvquTSz9mFCepD7LdZcA?=
 =?us-ascii?Q?JWZ6IEBSdfhe3IIyP30jF7x3i434cKo4uRUUed1OMT2PcQQJlcbxwQFqzZ+f?=
 =?us-ascii?Q?NSmeXm84Y1mKFUJlkZ+yExUR0BiPUV8c0uZZsnYi+3HeveyKF1qKa7wl9eNF?=
 =?us-ascii?Q?8WXb1ynzUhJQZt7ZqsDlUoZ32/YslB6kO1Hp01tshckn12TG5fx+3ohufJEd?=
 =?us-ascii?Q?oEx76/Y196LrzdZn10pUOIOIE83lPLjDWuZPvnmRQsUkdzrPkVURWar8lfGP?=
 =?us-ascii?Q?OOSAX2WuNROIGGdX8RdkzeF9iAN77V4B3Mpmf53IVfmAWDDWbxbq5o5EiWNF?=
 =?us-ascii?Q?JjFYyOjwAwuOMIlOt5rLmgfelOEFlB8Uxuat+thL4By98buR0V4yd/6se/zc?=
 =?us-ascii?Q?U8KD2wXc1N7JlCe1Xu0u59zP6746CI/Uk1UGt9MAYzAwyh7v7OEFG18517bO?=
 =?us-ascii?Q?j+OabX7DgWAPFtPEJxvdv8SXxarWILqXQQ+wgX8mNBLS3iUV9PPWbubs2GqI?=
 =?us-ascii?Q?rNOpYS4q8rHHtHqE2Q3wtu+mzAUcwsQl6C/8+pKPqigngr7tp4pKe5RuqYYy?=
 =?us-ascii?Q?4m5uWeQbbqZqsgxx2wMFpvsaIelhI+AQBQIJSkQIgCW0fka9agYF+v9G9P24?=
 =?us-ascii?Q?B+rbIKceGw8WZiys0PR2YIhZP8tLkZaLmNWuXynsyUv+lNeiRjJsXAHG4LFo?=
 =?us-ascii?Q?xoCfdpUmP19nnVuBOPiHMQVK7DwgLusmI/C+BB+BoMGNrjJ5jDBUWyS/sD9e?=
 =?us-ascii?Q?q4dS5tHeM6F61ZqXVXoODYFUgnVRFmx03o8EuqntSRUWOyWpBjOXZDrCgadi?=
 =?us-ascii?Q?7CJtSR11PRKB34v0r4akqZxYgSvh8ykTjJ2meSIrwtQVj02orJTUy1EpsbdL?=
 =?us-ascii?Q?eAQyqzZHYcQvbAhKumQEuTTfPTWtSEZR/pl8a9chnLy126V4GaVnmK/JopCf?=
 =?us-ascii?Q?vK1Ml89rr+l88zbzFIFVRCuRIPQEBxeZdxC16roLQ9wBs7uSK07dV0+AI2s9?=
 =?us-ascii?Q?VjeVkcbsInW0LPcfer86h/r9QaU9vJr5nrxXq8wm/nyHa+5zYu27/769eKaw?=
 =?us-ascii?Q?o4Rhdk9GwaTtimjaRzVIHjMElkdpXDN/h7wBK5vOazIuKv0j6qs2crtzi00U?=
 =?us-ascii?Q?YBS3K3w6ZCa4HWSw9u2to3n9KM+WzC7PHkK3vqMniDVkZ2EuhD4BSFnIA+Uk?=
 =?us-ascii?Q?z40BqWjIpEEQ1ApvzekpzWGanzkkSYm0WiK3KlFeiICMtT0KSw11ySJJUCw6?=
 =?us-ascii?Q?Icgez2Jya1hOuf+gqXD0KLzjveqaYSTfgyG8GIV6cjDxLobPLmbaUpDNp7rQ?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AC09D67CFB5454FADB73E2DE02E8F8D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FHIb/rNPYAKG/jLXBEAUW4USLw3+Dh4FYvkDu2+9fgib3boEY9CGSPPuhdURC6qkr+V6JvRZyk8QmCf5r14ASRf+5KiNEx/EvuT4gAhuS5NFevQE+CaoKZwRLe9dHUFY6mOc5DNE6EO5zKYNlQvb8QiDu5ysjr6W9P9YRSTXIRNgxJFo4qS4s5DR8Ab6HH2AmIr/QHKDHkY/atK3NGHGRyEUvht9xwm9mCV2h2D+hMqDNFLVCy8up4fZ9kLTCC/2so+nY/6uWEJNcaT63L5X0I/uwvlmVKwmeqhmjf6+ddacp8gLHQC5BBjcBiGmNAPEhvh6ir6DKor9c+yZzW9JlFjoqeyf1FDlFYSax5gHldLeb9jX8thW4g0Pyy08+T3jQ3zfvthdeU8qMq1p46Om9oAkII7Alxx5Dyus2CpqvzANGpVrHMELpkjFJHJMFIyJYfknEwad7pW7tV10SiP1q+u5dnHS7yI0ksDsv2koYHj7c6hBqco7cwZ11y5r2lAbnfsb83rdXFxTOEB9dg4EDX2ua/qqG2TWVU1B9kZC6xuraXpB+y7xPj95GxRNlIVzR5WEKd4sjpvXvHmQWr5zpJpUKukf6ymVRvtZOU5yPMNpiGn/jtPJSDTucWq8ZyuG7f/vY+rc+r/k3tIRH414uZDK3Rbgz3o4bm7k5OQzYmMrG0hUMHOv7OL9vsrhHTjEpDMVLmVfBwB0ePhqd48xjRsWLeHokGWNBGvw7Gz0fSskUw4K2zmTk8bl6SZ2455VNDkfx8yxJZu35I0di7EHFCumoZvS6tf8fUN8e6qZ69UDKx+P+haXvRyUY0971oqUT21dORi+F2RC18vJxuNIVuw0MYwL8kTt02kU3NXTrP/3FTvk/e3H/Lmq6pmjfW+Qs7F4y/5wzIv8WK9QjnM3qg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdecd40-90df-460d-a5b5-08dbc4f87190
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 16:39:13.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iej5LgA9BpIfX840acyqsNUvnHQzk6b8tuNSwNtxq9Tr+u3HDyp2HsQ44GFX9QD5StaskFI2AKlzbk3V3cLTw3klwoTfMc+cSCM63ANVaFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=942
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040120
X-Proofpoint-GUID: EVW46tX1qdvsZ_HJGsmJSc8uKutZRJCL
X-Proofpoint-ORIG-GUID: EVW46tX1qdvsZ_HJGsmJSc8uKutZRJCL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2023, at 8:40 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Wed, 20 Sep 2023 14:51:32 +0800 kernel test robot wrote:
>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" =
on:
>>=20
>> commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: Ad=
d filtering to fix some bugs")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> Anjali, have you had the chance to look into this?

Sorry, not yet, will look at it this week.
Anjali

