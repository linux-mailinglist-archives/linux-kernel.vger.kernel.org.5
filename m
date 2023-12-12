Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CF80F8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377503AbjLLVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377304AbjLLVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:05:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04379A7;
        Tue, 12 Dec 2023 13:05:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJs8j9008179;
        Tue, 12 Dec 2023 21:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U1HMoberY6FH0ObbCdOvvPMxwZLKtwNfx0lXRnzxJWY=;
 b=olmgMnxD4Xx5TtOHbVvhZOLnf4/GtVyj3mQB/b2P7N2fkoGqJtHMq2CfHzz3T+qVfvWU
 E9mfGzEHef8IF/c+CaIDRkLNSBiMVC61J7SQMLJZXSs1rCqElvxx7j4WU5npDp4xNcjU
 8hITVltygP45hF+vUNX85jhi/SKaZlvIXBK+dqicQihUhOQJw5ZVM5vjFfptJxInNvZC
 gVp+PqJl3dloksh3OWZLQ/vjnSaI9upCb/HM5bC6cFRK23OuWLbR6jwxUlobeKL5/Wld
 b1XH2I5dFb0E72xM7NGqp35HfUUQCl8u9QysFMe2+NKKBeWMcsjfOXnS2UtPqrlPbBFm GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df3dx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:05:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCKHMEJ003095;
        Tue, 12 Dec 2023 21:05:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep77953-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHU3fmVQWM6KUR/kTZQAPAfozm0ByuIpRjeqfvKOnHJkIOJNikYoWch6NM8vBYkJS41vfXcrm9INZAj8RGSAQqbQTomwyOQidhLuOWcJr/wJqkhKXsjGbHNJyELnMOt9ZUIoBxuUumWc3EmA09DnfHQkUmyJPG/MdVmXc5akGlBku8g1vfLOi+pUIdigJ0boUARM61sKEXwCThxicdKFnUU4LMQWRxOkJyQuLY0td6Nc5Gooaind41YE+h2g2NjvdWnDcTJd+CHYXMS8+Hmmr8UZ+iI8yePc2g5bPPi/4vtfciA0Z4fVgbLCAf1lfRtd5ofq4pcB1C3XdRJTwRUz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1HMoberY6FH0ObbCdOvvPMxwZLKtwNfx0lXRnzxJWY=;
 b=Gl4T/uuLvjTj5txGx7FNcaKsD/mZnMs/jhUzddT5pqgeM8kwuxz8smuvbuWYRHrGedO7gBE2KtG1/32NtMHcjPJbd5HGJVGCqpBxjJAJXmWsGRJqQhXJLqltzFe32XXAf7LbJSFoQWXYwEC0oSLnjGpILazMTf0Z3bB+KZlOKb7uhHOIQfDr+A0wfxf2krW9VZUdwdy1Qvz0rulUMH+jBqwtOgpncI/qwLVbttSKb8t6dHW3BcAmjmzblUtvFVbstu4MQNNQpneqVNR8eId1RhJBoF0Gs6fy4VSYeRGYQd0mS75VpY/RUWp6aHXvMb9D/uinlaVg4Vk4p4WHqHHOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1HMoberY6FH0ObbCdOvvPMxwZLKtwNfx0lXRnzxJWY=;
 b=mslN4W/99JU/Yht4G37+qRFkFNmpmcecUmyV/xmmZCV5SWroUq79FMNPpZsLJ642F/7WkY/jCBQJBbcfP07qOwuCN5ytSQksXZaTYaU06s7Ugd077lqWLmAfzEtrVC+Q1dg0ux8Qa4GzptLQACPhYzu9mmJp9iQtijps11Qz2q0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5240.namprd10.prod.outlook.com (2603:10b6:408:12f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 21:05:23 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::2db3:4f1b:bbc2:86c7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::2db3:4f1b:bbc2:86c7%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 21:05:23 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Eric Snowberg as a reviewer to IMA
Thread-Topic: [PATCH] MAINTAINERS: Add Eric Snowberg as a reviewer to IMA
Thread-Index: AQHaLRAR6OJNT75upk24TqFHu5ABZbCmI6SA
Date:   Tue, 12 Dec 2023 21:05:22 +0000
Message-ID: <E039FE80-E7E7-4626-A2CA-B5B473E428DF@oracle.com>
References: <20231212152937.928126-1-zohar@linux.ibm.com>
In-Reply-To: <20231212152937.928126-1-zohar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|BN0PR10MB5240:EE_
x-ms-office365-filtering-correlation-id: 7f0e4c97-b98d-4896-3b7d-08dbfb560e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ds5O7KBI2PgirWkp2Z1Oe241eX0UC7jF4jDzmwWbodAqEfgsQbypMImvG0+2VzmDAf/PL8GIJPJMk0ZABCXKuWpk1b0N68E07uHFiGh9bHM6B1FCDpH4kaJuVsiBH4SPOi9ZQsCFGzv1I+I2JQojWEktbUZntZPuMSmTbYIOXBRz9eUHXFYx6KkSNdK8JLR/sybJaTWyKizMFsP3LpD6sPhygRIY38r7BKp7Tof8JSnt1fgbtoRxGFEJIYitMLZUBEN/GQVOHAvmRRFNNd5tt8UlHpkDTy0vSfg5rutLznclRd5DofA3MbsDvRwVsjBjgt3IenZDvsncK6x+qdO6h37WuuZjCQU+BUY94/3gAMnO7Xo8PqQpKeSrt3Jn9EPcfgZfpOOzhTRNI7LKW49BH4uSUpYXxNfhMra5oI/fb8TkEsX1Kfn3Grf87G5U9a9FN+jZc4F2b77nmXTp2pGCirJ5dbJ1s5csYuG8LHgatKfjO0fBeX6fRiHLGaTh1Ok/A2w7nOiVOXarR8YRbTDtV8gjma8l0cgMOUZ0FJ+kDUhvBh+LdG6UdFQWTFButx/RrgHmPQ+jI35YLLD6/ZrPW5svUbsVdDQ1NRYQnouADe6JEceIP11DyCo4Zf9CO0x2ZuUWNdEIPkxFn8iVe/IDvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(33656002)(38100700002)(5660300002)(122000001)(4744005)(2906002)(86362001)(41300700001)(2616005)(478600001)(38070700009)(6486002)(6916009)(54906003)(64756008)(66446008)(316002)(66556008)(66476007)(66946007)(76116006)(91956017)(26005)(71200400001)(6506007)(53546011)(36756003)(6512007)(4326008)(8676002)(8936002)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r6M5Tc/nf3f0a8h2y8WlB4O6V/8IKbOiOKnl1j+Ct74fATOc8oSQpeZM67SE?=
 =?us-ascii?Q?ZyfRTjxtGp6XV8jfLSdEAd/++zajIJaAR38dIRMmflHjOl+xGp8Ol23Fa9W3?=
 =?us-ascii?Q?AAf+M8I8NSU9w/2F0fqjz2rwL1+82tHUyV9Pd+ZuWg5Ft76zCdZbr5Gfgqrw?=
 =?us-ascii?Q?VUkaLU+TeicKWu5Sb7V6nezcFirORiCzwYohFZnJXm9IgQJeyH4kqFf33BPC?=
 =?us-ascii?Q?9bSmJh5f+fx/xz9qTVy13ReTG+fRkCYFu3Uo1XnObvPX9zrNGD3iMyWbFNaA?=
 =?us-ascii?Q?mK6sLst1sQkgpK0IOBTY6wZPj9Uq8UIIrSayMmHguTu/VvI0wo09f0YH5ZiL?=
 =?us-ascii?Q?MddVr5GBT/9Y4h2obCjImK004wpw8Mew/BvigJfa499pGekyqwgRzZuSzwGs?=
 =?us-ascii?Q?OBz8Kbj1nmF3JwzG3VxlQEt1CVp/jtmSK7sBsJoVuG0HqHGxiyajq7iTofVK?=
 =?us-ascii?Q?e74oBEAuj9xIWXmJwS7mRAeccuDE/d6UfFxgEi8QVb9FjNR9xWtU0JbNaVa3?=
 =?us-ascii?Q?exxRCFeMS1VwALmUeBrGyH44FKdkV2LeuSG36oAElg4tH4/v+X46FpwZN3Cv?=
 =?us-ascii?Q?3FquPwY1AKRKBdut1BAXWGZg1E5Cx+mbDxdqcJ3smU8CS0BkwNuEoC/SpVHX?=
 =?us-ascii?Q?/8EN847Qc3EXFPxKLFCYObd5Qyw3crSKcZ3iFzxzB5trvpc85n9kIzgyRXhp?=
 =?us-ascii?Q?HW+qV6onor9eKckerXrZES+gkc9trUYb94OQFr4UeZ5rUf3+HGk4h1IGJZIi?=
 =?us-ascii?Q?5WWMBTX6JG8/95Q5WJdPtTlZw96z2m2ROc/SEMvhAPesXDXh6b/GCcz4ciKP?=
 =?us-ascii?Q?kz4nEl8/JbtcyOG6sntDEkiBZ+1Nwyn8hkRSkN39TxJrh0hDCMefdbN+seK9?=
 =?us-ascii?Q?s2SKhTYpm124OLYXVNRkiJd/B24iCjwL9jBmHJqZAjy0+w8LlZyoMikJA+Su?=
 =?us-ascii?Q?QY3nGvXhuLAI/UWb37TkiuIZfls4UnPafobZLarbPefCvYIu/Q0CedX3BPic?=
 =?us-ascii?Q?Gm7SOQpZf6uJ9QbztbygiiLwnTzcMxci5rOjObz+oQb5VfQ2q2zwGSeA9/FM?=
 =?us-ascii?Q?wNgEq97dTbBBj8TQI/ZJgvyi/LVDfCCIMt+0Hmlo4UrsJp6CQeEdGJ11ctb5?=
 =?us-ascii?Q?Go7bvjqujLquf8r3XbqrL/1osw6x2GkpxQOsH+/UuakNGf1I8vTwCUHtOY/O?=
 =?us-ascii?Q?FuPMVzPmmf/6Sz8JpVtdhzxUMSH51jJCX28Gu4pbqoxq0vCprhMkfXBOoN9H?=
 =?us-ascii?Q?yfy5NCUi0Bg5afC6KZ1gdaS7bmUucUAW+Y0asRUzj0u5xjxITwdutFMjCTc/?=
 =?us-ascii?Q?a7Df/FVlRrS9pgJ8o1KIk96g5Zu+9gRe0VJiiIaZBWgklJIQC7lWoJI19lew?=
 =?us-ascii?Q?gfEb2DJj+MlpFSvOLM0LpZwVlhpxEfVUbxpWp/X08gZN85GLsu/E8EQ/X7bH?=
 =?us-ascii?Q?YNatkgvlqVCwq7z7p7xL0WF5bWAEJCLQ+wfQFVEsYTUWasOiFQ/NxzVNFW+T?=
 =?us-ascii?Q?uj9+gFZvzo+mAVL+18jMuR6pRZjNe9dLY5c8K2h7fh4MiV4rMZkthvXHwn27?=
 =?us-ascii?Q?HT56NApMbrHSTXr1Myr6JLzYx4YrSyUS7s5IESm0mtyPl5UXK1SbWFBnUaa4?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <384A50C8F9A0984B8684BF62A1BF7D50@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A5L4erMp9qFfkJrOzTtpuL2zRefAtBO/ILlGQBZnm5wI4+wp0HM0pN8HGLvtAzHKJPuSaKOiH7IIqgN3UJrLcTjPzw6O7sGiHCqnpR95gXpmA1h738C7JW/V9tJQ0qgayikrgf1brmO8Tim6Env/R3viU7SfISFw9TzZZ8uk7y7hbY0BaCn5PZubib79gs2ezFjIUsHh9I0HHbxtdf3piRc3meaIR7weO4iX3Dx2RbejjW9VX520DDe66ex3VSoM0SBVCNkzBQ+VdMc0hX9AaXxMQEwCNih0KK+H4eSp6QexHJf7Nocpta3J2hiOc9La9AOy5ZMeVzYCGqb1QM94jT4t2ci5ROrh3LeKK1KbxvE2UrjYQ89Y5VWMUcaBdKjUFzbPl0Phw4LgtKE5i+cU6ag4eaLlj9g0a1hG6tHlqExCpezn+FxPZ//xJnvGrhEQV5lHR9GSjKTxSnWfTvgZshkCOASYo31dfSs4jGMoXZG3lyDvv90kyeSck++0S+cAWk8gUpdOZLcwIZD4DXWvR3/2oQmU2F1sCBI9IdCngrKilApBNJTaaDf8UfxZqx+8UoTWbdnMNkbVaHg3ijus1PUWwngcX0LESGUPaMaqHbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0e4c97-b98d-4896-3b7d-08dbfb560e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 21:05:22.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnj/JZE1fQR7K/6bEUxmX1SIeYkgsA5J76hQ7WcWSEF9YvyzXky8db638Qpg9+jjhCYA9UQphWuh6IsiPVlbv1zOWuyHZWbWYptgrJ/g8zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120163
X-Proofpoint-GUID: AZZTAtRec_kJR1gPFdaZ3qvU10e46R5o
X-Proofpoint-ORIG-GUID: AZZTAtRec_kJR1gPFdaZ3qvU10e46R5o
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2023, at 8:29 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Digital signature based IMA-appraisal relies heavily on kernel keyrings.
> Eric Snowberg has been involved in adding the machine keyring to allow
> the system owner to add their own keys.  With this addition,
> IMA-appraisal usage can be extended to allow loading local and 3rd party
> software keys onto the IMA keyring.
>=20
> Add Eric as a reviewer.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Eric Snowberg <eric.snowberg@oracle.com <mailto:eric.snowberg@ora=
cle.com>>


