Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16927FCD90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjK2Dm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjK2Dm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:42:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFFF1AD;
        Tue, 28 Nov 2023 19:42:32 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT2RjqI024362;
        Wed, 29 Nov 2023 03:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=HuVgWhuxBEx6JBFGWm/Si8hkZMKoJr/y721ffo0x1ZU=;
 b=bA2lP01Q3PY/xclFy+WDQRMIQdE1PfxG0MWOVwTA1g+Q7sg+NVuQkH915TD4/aEmg5qN
 IlwpiK333iyy+S0qZ8EW21eUGWpHViKl3LMkzv7M6A2ohbMAqLEvvCPdUsLRbpZ85s80
 TPhsDHejJdlosGwypC4t20xccZtvgJAv56Usma5IYObcPAvRaMG7fnM9xwOcAYMKhdpq
 VESNbI2nj1XVXqgYwYeE9I0tieBCYW7m6tGRRI+Z53SbRKzxyXwHTjoteQwM8jqviynv
 jSTapfhqSMZL8K9VVntEYUa14R6HwmJ7SZKh4yx9bYj4Uu4fagjCR6kP4+2SxRcXr22V aQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unfn4t9q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 03:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgCmTQa6agHIbMXVsjQM/sACOdY1UolfXhOBq/IFolBDe8oU6hoITeSxc2tHbBULkbfsNVDEtELujiYZgV7dfS2+CVtlRb7jNL7SiMlvNKTprkCEaPt+yf4eHLJaATzb2zWYE56cd/2ia/dh0JvYOzX+bzwCNXy1orqeKS2Bcc3whKweILoaujFs7zvvebBqRxzdBcX2aLR8GWENyAs8j9znBTBqSjNl/pRo+bL6priHJFOV6Kz/r3M8wDBWikqGqMxEt3PviktjvY63+p18ueXFQtJkprv9Yv8VYcA86e2X/Y+5YUIw41VPOp29KIBRfnF0GXFHd/34shtzDBiOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuVgWhuxBEx6JBFGWm/Si8hkZMKoJr/y721ffo0x1ZU=;
 b=Y8p/pxDCNkkqTbfQayBARsSsZ7Gb3SwiZ2+JhbHEBwTzCoMzi7kJh0o0vPGQSnYKJ2RlWyLWpfPaLvaJl73rXug4cyeiAywCbUq0EqvqfrxhA6hYBbq/WBt02k1l/Ma/E8ZmrH+4EkkMmLo8T4HN/az8YE2+Zfa1s54wR9ekMwrvBNylxx05QOqbVmYHl98o3YvaaUC+JvVcraWjorLG0MnJkyu8KleK8DmTD3iveyxBNeYQ8MWwRFce6EEXRJd6Jl1Za+7hQi1HGCiYXs5p1KaI7mDhLQ8bkFC9LIBQU1rfBIasqMYRg3J0FR2Q9JNQrWTfb8nDknStjZYOBJI6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CO6PR02MB7778.namprd02.prod.outlook.com (2603:10b6:303:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 03:42:24 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 03:42:24 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Thomas Huth <thuth@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from uapi
 header
Thread-Topic: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from uapi
 header
Thread-Index: AQHaB//2OERsbOjxskupUbp44aavt7CQ3Acw
Date:   Wed, 29 Nov 2023 03:42:24 +0000
Message-ID: <SN6PR02MB4205BBAD065D3063745AE0B9B883A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231026113114.195854-1-thuth@redhat.com>
In-Reply-To: <20231026113114.195854-1-thuth@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CO6PR02MB7778:EE_
x-ms-office365-filtering-correlation-id: 4a24e8fb-7dd5-4300-4bae-08dbf08d336d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFzBZ/pFXUD5TzU9wDpfqn55d+npwc0BWK9emuwng880xi8m6upQic5klnMf0989SKrDCxxSwb+yjoIh8+sUZNpCpJSlkm1DZe+TxCW4ijKcPwmhNcj1IThqTivAxM3jtLGl8lOjiZEKLPPEPJhrgSGkkn3FGWpX3O9X7sgCeRjzPUCdLNobKtGCRlhGoz3ORyhXLNQRUfIbvBdhvPTDkOBt7yAcX9/xtziLexF5HEVJQVRzeSyoDHliICjO7o3HoGCJzPRXfsW2634fEP6P17U0SK1HAvAHiDUP0UGh6Z4I7wzsdlyhVTTL1QnNj5OEGzglQpzHmid1G+movnnMVPwroFVrAC9tAUwjcZrNrcdscvLt01HQyzZM9NvmvMGTT03DROqU9Jc413EsSbAQ3DMcyz3VhxWuLK2nLnNga1yns758tVzX+r6vNJH6boc6ZH8ZlF0EufRVZth2Tzuc2brBWEmkxjhads5tPnQ7i14TzSOCSNDlEBDH7cAb4D0nmuVdVXuSc+ueBMl6z0CAJk3Hz8ggZ160YP98FiAitITTz3YWjf/XdeBki1KH5yEwm7IfAwQVkVs6OoCnjGyoOrBK87XlApPTzi4dQkUZx6iW+K9KZWALIsGiqJnMkf7mrB51rCRJxeQiCRxP/SgkXTjo07UQHMF8kBETRupy46s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(8936002)(4326008)(8676002)(9686003)(71200400001)(7696005)(6506007)(53546011)(66556008)(64756008)(66446008)(66476007)(110136005)(76116006)(54906003)(316002)(478600001)(66946007)(122000001)(55016003)(38100700002)(41300700001)(38070700009)(33656002)(86362001)(26005)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tboBqD70SHZalikLwY0NLhtZbSJGSISm6VK79hFgSV3aLV6NVc0T0JFjkGQT?=
 =?us-ascii?Q?yQwMflzVzbQSANWw1+f9LJZlivVWo22qjeU7dYv+o8JTMmH/qxx5Y4QL8tL3?=
 =?us-ascii?Q?AHv0GFc5W5DOnbxc9x+TTrn4T9x6VAmmqAF67yp3cPYMg0dGEsnN2Z4Zm9CZ?=
 =?us-ascii?Q?9wJHHnl3kO8Zb+qR0SwE5L1aaoG91n6uWCGWz6vY4tLF9xXtHw7k/H5yuExU?=
 =?us-ascii?Q?22tbhx/urJSSf9DvGnb2kC3oGAcdShovAxkGumh5M1y9f0map3II7sPlRM6x?=
 =?us-ascii?Q?MkuCTKhFJWy4w/QHwb8Cc5RabFvY7U3mIv5XegI7ecqzl+/8jmrOx6eob/jY?=
 =?us-ascii?Q?wU/AtJW4OMN9rGp6QpYwomUkKD+3GyZUU3Uz8/iHkeOiTTlVqUHKHi/p+ZIi?=
 =?us-ascii?Q?yqAFwVeqh2NjyqQ9IGpiU4DbDMlwowt1csYHfvloqMbNhkz93mpOdsPewOrX?=
 =?us-ascii?Q?di5g7asSXdDc0mUk//bAYZaW1HZpKVOwB/6sTfNzr+AwvTaqcd3CaBswEuHJ?=
 =?us-ascii?Q?k66ptCeg8410YGfePOb/Uen6+1nQ2dD73RDiagUgei0i4f4p/TcFs7NabKvB?=
 =?us-ascii?Q?Dir/ZnQ1OZ5nwzt6utwk2U5NFv9+9v5wkMUkCx5JYPgnulY5RKKM38wA9wBZ?=
 =?us-ascii?Q?xcTQ6jDZwuo/ttI/wSHR8CYKj5ICDyEXCoiiU+kp6fv/RSyR6g3PqCl12y5X?=
 =?us-ascii?Q?e+hsOCNv3en+RxfALkfTgObE4gUm58sQvWLhT2ZUtBZtDL0+2M18PZTEUUJ2?=
 =?us-ascii?Q?KyNkWq66Ou0RqNF2BVg/T4NJ7DQCnVWYCO1Y/wKiuoY2qpT38DZO/QGZbR49?=
 =?us-ascii?Q?U1cfPJ5AyRQvmUByERzFbG7dq5eTdqEgTcKWasg4iLoZHjv1FHj7BGgV6cvD?=
 =?us-ascii?Q?2vzEkbgiXWlHss4IvYKrqw4Zewdnr10L879Byk9YGAKE6akbUlXCiePQeUlf?=
 =?us-ascii?Q?+PoSDH1u9YSV8P6fHHL6ZKP4DuIBqXfu5jg12nmvU2AtCBsdtjaS31lWBLms?=
 =?us-ascii?Q?pydd2Yq6U+Ncsv4o1OIT5BBrfkrJrZ8OovNGtHObrcxP/OMSjd7Rfh5mdzlR?=
 =?us-ascii?Q?JcAWdOJV/7CowzsExo+lUeylNEpx9J2edRFT0KD1715w4GXxHcQvPTxq4Kv0?=
 =?us-ascii?Q?+tIRp+gBBWvD8E6Jlo0npnKR7Qm8yRphkNn1HWOR4jTdyWpi0yMtpVm2lUML?=
 =?us-ascii?Q?bUTn6nGf/t1/NJfQv8i5L0zMJ3fvsPExOZVD1RuUfdDJbrN03+gykBV5jjcL?=
 =?us-ascii?Q?PeZrV+OUfqFfPOPIiJ8IQAMsRvVlrMwGFo+HGyylDLwiNsvCf3bnNNAw+VE4?=
 =?us-ascii?Q?tUkscGTNVXryc2hD2XgBdnxHqrrsMrwaawzkg+s4+Z3K3w0GD0VhvYVY1GOg?=
 =?us-ascii?Q?axU6IwmV4iXrVsr6ilqQkQAO3FUKVKu3OdevjcwBqQMiMjzAwfShTh8uLaPY?=
 =?us-ascii?Q?KnPlIKQb9zlLbuvwassAaBeYdWuiHEyCWk9IfI0ehHn2aTs4UUXLmIx/uFLE?=
 =?us-ascii?Q?PWZ09CCzV0NYNXYDig53M+Tt6K3UU26fEq1ixfAEzmU96JWwh90FNegjcqRh?=
 =?us-ascii?Q?LbPQEk0HDp8bDICjq7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o+fL+OmoBtnw3oVYGYL+hO4f/fCj9xVG7qeqGAgPCKO8tsOKuOYo9sIBbBFWo3MLz81j7iovbNds1UZgbZjINY5RkYMsSVDfz6YoLTEBFh2dl2oGOMHrXUpuN7plFSzU6+1Vpdt9GHqZxge7crcM97zbJU99+cfXfU3engZgPUX4Ch+yQhsDo3gikmupR2LULMhdecqiS4tqrfeanzno2d8afHMf3oJ8aQfBdNr0f4laKKUtOD5u1TQyziL1Y+e3/jOks8oxDXytoC2pcEzMA8mOABN2vtgBxOIlt+9iZVKEE8q8bNqaoA1BeVMMyAMKc8PbNf5TVoh3KEErakzSVtzfu0m7O3cPyxOsF4koIVw18WMTIoTeGI80cCHjm9McMCrqDKO8UlA+pRlff9Aj1XSUV8Uv4cdGyh0S34WKoKyBNImvGtC/GymHF0fWZgMqgf1pD4lbkvXhOq0CouJ/V4cZHeiGhrScIHPP6V05BeDaANBpnMrXweYwvk45oqJhWuZKT0Xq0Q7wFKCgRctZdoWDlg2xukm0QOTyTQp66MGZjI3yHJsY3W9bHeMPQ+tQLeb7y6TcIEyxFDJL60pb6Fj2GzxqfGox1EpA7immUYaZoiklgFclMjlBHvkY8501SnVLh4a3k1fKqwnlPRp8tvQQHh1UDJVlUEgJXOM1xotu2TzlV/4XeCLchiMpHJFUryI/OGBUsJtbj5IOkjSu3plhfu5RgvpsD4K1qPbty+2eDyTcIYsSqROtI/d/fsXGnODrnMWU+q6Abhn7irwcKhuJH+16OMlSoAiSbGzAtSP65LwQJk+nLRVWvddy+XVqApUiGCZ1aoGQ05I2V3sOmg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a24e8fb-7dd5-4300-4bae-08dbf08d336d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 03:42:24.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpOzPY1KzHKZbbJSINEJ4guNMDalXOQh+x91udaXqhu325NbFXUgtyERZOR2lfBQVqkuFOhZ3TjPOaMyQICDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7778
X-Proofpoint-ORIG-GUID: yIUXMGMbzvGky6oR1ED_NxgTfawlHe-i
X-Proofpoint-GUID: yIUXMGMbzvGky6oR1ED_NxgTfawlHe-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=959 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Huth <thuth@redhat.com>
> Sent: Thursday, October 26, 2023 6:31 AM
> To: Arnd Bergmann <arnd@arndb.de>; linux-hexagon@vger.kernel.org; Brian
> Cain <bcain@quicinc.com>
> Cc: linux-kernel@vger.kernel.org; Oleg Nesterov <oleg@redhat.com>
> Subject: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from
> uapi header
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> uapi headers should not expose CONFIG switches since they are not
> available in userspace. Fix it in arch/hexagon/include/uapi/asm/user.h
> by always defining the cs0 and cs1 entries instead of pad values.
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Based-on: <20231025073802.117625-1-thuth@redhat.com>
>=20
>  Compile tested only (with CONFIG_HEXAGON_ARCH_VERSION set to 2
>  and with CONFIG_HEXAGON_ARCH_VERSION set to 4)
>=20
>  arch/hexagon/include/uapi/asm/user.h | 7 +------
>  arch/hexagon/kernel/ptrace.c         | 7 +++++--
>  scripts/headers_install.sh           | 1 -
>  3 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/hexagon/include/uapi/asm/user.h
> b/arch/hexagon/include/uapi/asm/user.h
> index 7327ec59b22f..abae6a4b5813 100644
> --- a/arch/hexagon/include/uapi/asm/user.h
> +++ b/arch/hexagon/include/uapi/asm/user.h
> @@ -56,15 +56,10 @@ struct user_regs_struct {
>         unsigned long pc;
>         unsigned long cause;
>         unsigned long badva;
> -#if CONFIG_HEXAGON_ARCH_VERSION < 4
> -       unsigned long pad1;  /* pad out to 48 words total */
> -       unsigned long pad2;  /* pad out to 48 words total */
> -       unsigned long pad3;  /* pad out to 48 words total */
> -#else
> +       /* cs0 and cs1 are only available with HEXAGON_ARCH_VERSION >=3D =
4 */
>         unsigned long cs0;
>         unsigned long cs1;
>         unsigned long pad1;  /* pad out to 48 words total */
> -#endif
>  };
>=20
>  #endif
> diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
> index 125f19995b76..905b06790ab7 100644
> --- a/arch/hexagon/kernel/ptrace.c
> +++ b/arch/hexagon/kernel/ptrace.c
> @@ -74,7 +74,7 @@ static int genregs_set(struct task_struct *target,
>                    unsigned int pos, unsigned int count,
>                    const void *kbuf, const void __user *ubuf)
>  {
> -       int ret;
> +       int ret, ignore_offset;
>         unsigned long bucket;
>         struct pt_regs *regs =3D task_pt_regs(target);
>=20
> @@ -111,12 +111,15 @@ static int genregs_set(struct task_struct *target,
>  #if CONFIG_HEXAGON_ARCH_VERSION >=3D4
>         INEXT(&regs->cs0, cs0);
>         INEXT(&regs->cs1, cs1);
> +       ignore_offset =3D offsetof(struct user_regs_struct, pad1);
> +#else
> +       ignore_offset =3D offsetof(struct user_regs_struct, cs0);
>  #endif
>=20
>         /* Ignore the rest, if needed */
>         if (!ret)
>                 user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
> -                       offsetof(struct user_regs_struct, pad1), -1);
> +                                         ignore_offset, -1);
>         else
>                 return ret;
>=20
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index c3064ac31003..f7d9b114de8f 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -74,7 +74,6 @@
> arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>  arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>  arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>  arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
> -arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
>  arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
> --
> 2.41.0

Acked-by: Brian Cain <bcain@quicinc.com>
