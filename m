Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD7752A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGMSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:00:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A152271F;
        Thu, 13 Jul 2023 11:00:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DHi0gl027425;
        Thu, 13 Jul 2023 17:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8Z1Ji3RgzfpqH6LF3Oimy8yixJh/+HuixVJM2stEUps=;
 b=CCSFPpJphcWYa6PQxLG8P2HL27YkXIrnjUDFKQKanuf1QF5xOOLT2qf/fpUc/E7GzV5N
 rnK1U52x4CvRNDdRQyFan0jQa65HoEbLDF29Gk70mBzG051flXjs/OGeRAWIoTlppNQV
 Si/+YfzK0boC0mkZF2NOCAPqP18QB+54xxDOYwtHx/RR1dv5aOkkRZpgB8o5AhU7DWJc
 WIJXZvwp/eaSPGK7SWdk8s+RbBmi5l1tzgTkpdGOixskzOz4qtYo/Rk8QPz0tsaSDu3U
 Nm5f5gkMfYb8FAsl8HiainVEReqzPzCxJC/yu0fLjCz8hLZRUayeq76hc8DERA4SBXLA Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyudabgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 17:59:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DHwTsG026912;
        Thu, 13 Jul 2023 17:59:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx88qv16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 17:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns+OzLia8unGpqphdTclc5fS+V1P3NkG5qxLxEgQn15LgpYRiBnAx8RihnZvdXvJuYYyE6WnxTD2bwm+1SBlk6OPFtpqSWkjampQfSU+89mZ9bir4GiFlOPaIybgdl4fxV7pCVYNcD69srdXcu56ZbFG8JI1YaLjtIPQh1WeqF4Jz8q2xaJXQZ2gQlWZJTwmeVTVNtMVoHpjVLbkLt76T3Attyey9zB8jLgXS0CJBjNzmtEmMdwcnupyXdUApii2h1ze/0za8uCDewmTSUlchxw4rU1UHngDidw2y/YMpB7s7Ls2iRhXLs6KMA6JwXWjNK3LLa5cI9QCvSojZr54Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z1Ji3RgzfpqH6LF3Oimy8yixJh/+HuixVJM2stEUps=;
 b=ZwoBDQ+ZUAaOY4F4dZV51zLczNDI0tlwzv71HKEbw6fYnExZ+p3+8JmEuFILcP9iC5l5T3we+14Ywe0CVA9IztDZYjDFsC4WtAEa8sZonjGYlpWOb4fj/Q5hf+xCyiOhsQyIRrkSemt53qhcmORU0BFgnQSYy270gm9qKKwMmvwl83OUN8MvDB1kCKTGIVwuaTrfxqoqqp/JvxiRdOroOXlou7+iw8YFIEraS4M48JgIeX1BYhGhjR+xizWPZyVf5vSk/lrqKRelm/UTdqnuytiOv8HzHEq3C/y9w913MsD2E5gld9akbUkysNnaKM2YQhG/YpJJCB98PJuNFh4eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z1Ji3RgzfpqH6LF3Oimy8yixJh/+HuixVJM2stEUps=;
 b=Jc0I/JXhiQ3D1Sjzqyb7DegA4aq10IFEnxcs7yW1d1fMdzT9zbhQ23b8d//wZfBx7aLMAhLXH3MhICUFGcb89H1GrMD3zAF3SM0jL6RJo43ZF4Qe9vqUzcg7bb5ql293l6p9uK5IaWNYtqEtLixkvGD9AqzGuev/OJFEpJ/JhXk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 17:59:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 17:59:38 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC" <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Thread-Topic: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Thread-Index: AQHZs6Yx8QVGvV/d1EGz/VbT3miE2K+2dumAgAGJXYA=
Date:   Thu, 13 Jul 2023 17:59:38 +0000
Message-ID: <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
In-Reply-To: <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH7PR10MB6203:EE_
x-ms-office365-filtering-correlation-id: 65a7ae7f-d2ac-43e4-0d7b-08db83caed35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eeiMONR17HGMdm3+5Wlw1TxNw0umZ+EnreVyko9m/1e4Tvk0RfCoHYlKpGfnPevt7W3OXXb0xc/sg+jFCs8hDK/O1WpHDWD93qI4Gdovz52C8byknrZYksHzzCuagWxpwSFRwytj1GIWnleRxUBKiSju0zYPWK8bynW24Sb+cAq3y5C0cqihM5/qiNqCPVM6ZRhVXu1DQjgaiCKlxoPPAifnnA0YG/waqW73MdcxMSJp+BeuN3OVphEPhgfJxjn3Z4Fa+J3L4hWANK7oh13SSurSB6dB4bn9tXGryhtvlnGbY3M1RzS9CIcTdoB0vXsOQGlOSloTw1aHeZAtdca6jDtpF26b2sNtgluYiRuFjjcgmQXvKMUzsc1Gq9PAumvO61YWTOS2aLZOTgW0wBe3AjXc+kof8nfiQmK5QYykzgTRU78LVDrsE50lapuk/oN/0WsmoJFHyWGBMsF5FScsWyjcWo9rBZgNTwkOIo7JtXy1nBIJyIudvu5gaWk5lNoD23/4m/FRX1D2nDRdcOy6jEHa7ySGGeceChYVWE5ZuyA9RAU/GftDcGOARaDVPtJgOEEpOFoXZn1YA0r51Hlo6o9Z/RMOLQ017kvLJ/4R9kFZ51+wtMk+v/jYQvrBnrn9osT73NbzXCWoGC6LrGUog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(6486002)(478600001)(91956017)(110136005)(54906003)(71200400001)(2616005)(83380400001)(36756003)(38070700005)(86362001)(15650500001)(2906002)(76116006)(186003)(26005)(53546011)(6506007)(33656002)(6512007)(38100700002)(122000001)(66946007)(4326008)(66446008)(66476007)(41300700001)(66556008)(316002)(64756008)(8936002)(8676002)(5660300002)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ToCwY7lAsNyne1rIXfT0r7b1QU3s8/msGXM5J2gyVwTiCtMSMFrpwLKhpFec?=
 =?us-ascii?Q?y28wE9brLdngEcug8mgSFJL6I2ISNO/ol1dLFM4UodX+Yvk3wIIMudQPhjEX?=
 =?us-ascii?Q?jet78zdxGNXk8uJ6exwoR8MUmMr2IgAFpKGkXmBJbq0KAwc1CSOUuhYEvDSo?=
 =?us-ascii?Q?eVhGk/6c9/qX4jKyFp/18XGwT7jQOjlZmd4G7ExI0hPlm4cwhnbHAGOlcisA?=
 =?us-ascii?Q?gPscZg4MDGG6/UTeNL5RsrK2LzRAOQB6ztwQHD27QVYkA8ScLlDKAMSwBGez?=
 =?us-ascii?Q?Qs2Jqrr/4vGLaWKYwtgURCbnLlqCOOMrUl8pC5PwqxFwdGKoeJLnZmFywHFY?=
 =?us-ascii?Q?xFk+0fOIEb+wIfEnEJwPCN2aIugdmjTG5wv8rbfBeiF73cN6UByU3P8h1Ir8?=
 =?us-ascii?Q?fl4StDx70aHdAgqOC7gmarsdnkTi36jbh2yBjfofX1h+W+e0AIBNN0QX4a1j?=
 =?us-ascii?Q?ietcPwzqwFtNPmF99biSv1/EBhHQah8KfN++Qvg7qVQK6MmIz9nFKUAq3o2u?=
 =?us-ascii?Q?anCbNsxkPWs5Q5/epqoTktn06F7PGQxGak5F+lcvYwxPmntDvV2MfWphZKRo?=
 =?us-ascii?Q?dkgE9RvpzLPzW/ltIWNvGY7afOr+dqt1QbZ8RsldV/+EV0fBtU2OPce+ne4C?=
 =?us-ascii?Q?9Da0Ded18w5JVTsQUUyf3/yeh/r02z9dV68URTlCzp/B1kzYTT8JLPWt5xFn?=
 =?us-ascii?Q?agSiCbGtIG12z8Go+WrQkPxSuYp2p1EHJRj0j4ysiEjR6kpFBJ98xBl7Rd/r?=
 =?us-ascii?Q?MJ7slj42CGjnoAKVNzehwFZilPKbWsaffZml5fycJJ11AgdqA1F32khpDqL5?=
 =?us-ascii?Q?5ea5pSatNXJD4xJGWOKE10piDP95kT2NvkD+Mt70XRYsJJANFoPRBlnkS4zh?=
 =?us-ascii?Q?1D9zmIMfyo0ZDiudt3gKmD7kMTETRsiVB5sow/lUX2Gi4N0U2Pu1lnQYDETh?=
 =?us-ascii?Q?YxZPJPcyApUISGR5m2T5OZuDfetvaGV1aXXhjfUPUo6sqg0/c6iE288C33+p?=
 =?us-ascii?Q?fIVPX6LMbWuemIaHTWLWhKwi+rzlTre2kdBC4k2lOiIFkLBTUxHSdO2P9EMu?=
 =?us-ascii?Q?gSNDZ0PZLYtXrGBx9RT1r4Ow7NL//wupGW09ZtI0hXFNSw/HwyyN5mm9zxav?=
 =?us-ascii?Q?h8uHeFAGyhM5/QExvol/Cd6duIq9hRU5S5i62N8eUZGY6QHpB12oExWqRkzz?=
 =?us-ascii?Q?EHHDNF7o+cHk11izWz57uEhhzbuTu6HqT8E/viQx37rsV4Ui1Qu2bBzwAu0V?=
 =?us-ascii?Q?Yy86TUhRECWejX3wV3Uf+MUs4clFdWmYRUl/B1MOFbCdSeaTyZENEaClovUm?=
 =?us-ascii?Q?njXtAMsFVFOjMOnq1Gx286tI9h9s6g4fBC0OEWPR3dFopQyNNi88NMUrfWlt?=
 =?us-ascii?Q?iHejbg3eyE77RcKYddGiZY/NBj7zNQ5Ug+NF3MGdklL6E11cK26/8eufjPMR?=
 =?us-ascii?Q?Nm59gfaUuKDHtwVBqwLdWG27KWtanR8yYiFaJodBIw+ovlLzKyXrVDAeWZyW?=
 =?us-ascii?Q?m3tNMHlhLraa4AX5artsEmRtaG2RFILM0MoD+f4izAI4knQhIfekWWJyddHP?=
 =?us-ascii?Q?f5vokuCG1jBNNx775oMOlAC6AjV1fkn/SMeED4sIFBwJGf6iEqAjDsNmbhKU?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <897ACC4DE5D7F943926DFA1617126E4B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3lwIPFKrUKAlTay8hPmdCMZok/gi2bMwkWlMuoPZ3Kn54jNRM1bY2HfykKI2G0wOeYSy9kgA6XGUqsR46w9h+hq8HU0CH6JmLxpXQTjBFRJG01y4rgm0epvHa3fY7tessvSb6UjftWaA+WGAFuBuNEtrL/mqHIO2xZ6uFDMRpdJ71NJVN2kFHcYod1y/9x0XiLc+0GtKboZYKrj6k9g50YyB1jgaDE6a99umQBrelhW4QGg/C+7XHMndIMNPVBrqGwTUYyFxT4QBugJVYpFHfBRS3iW+qSc0zzUYgQlL1HbHPqWsHxLa5CHFkVsL0SWhzOPnY8D6Rtxav21lxhC+CxuIrtg4CjupcmGRZxwPHoO+QCXKALQVynObXsXLrzzQnQCAtLDxtHz0i1rMnRW1H3CGteRN63KRYzpMaDVB+9z/CMxWWLsdgCuqLOOgPfhYjO5wepgVfslQsLPX/14ASoCr+LaTvzcKLqd8du3i69wVAgguPNz+UxzANDRFXyiKYSYZvoKAKaT+WmRAOUpsCM4QxVX895174jZZijONamSSxo6PhdWXqp4INMSShXOWX6wS/kXXfZphnmMbd62gfBqOeDgwAfXliO9HzS45cpfCrZrexHSHYPAutaoUXIV+yq2hxO92roStqRXa89fY012mFDUWLdWaGfDuKGGZcbcM75KmVu79uLDz+ZQ+CmRjYvktxvua+oTlWKfrIJTCUTL5gerYDF07liLBr47yLZufYKTd6rwhhsZln158XuO5X29nQe59cV4zyM4vUE+lbtK5GR+EENkzqDmOJfB6MdD31Gj5zseN7dR8/Rq24IwSDT+PR1q8tB4Vn0XecVGjazrJ8iNkKi9jnMLXY1+h6vzIQ8/Dra9tEdCdhz+rU2oqGaD/dej0j6qakDfrqsydFmWhwQgKsnQfZcuu3CRqfZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7ae7f-d2ac-43e4-0d7b-08db83caed35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 17:59:38.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnpaAs7Hiuearu7CiCf/tObJcCIdW145V71UegU/JzDO7Rp+OU/0ylcs7GY/iV+oLzZnc/+46scueKqtYWc1WBoIc21tiM2jAD2Aex3X9so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130159
X-Proofpoint-ORIG-GUID: hcpspuS77_1qJ9XJw_-2Txr1VJisGVd3
X-Proofpoint-GUID: hcpspuS77_1qJ9XJw_-2Txr1VJisGVd3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2023, at 12:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> [Cc'ing the LSM mailing list.]
>=20
> On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
>> When IMA has verified the signature of the kernel image, kexec'ing this
>> kernel should be allowed.
>>=20
>> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXE=
C_SIG is configured")
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>=20
> The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
> appropriate IMA policy when locked down") was not in lieu of the PE-
> COFF signature, but allowed using the IMA signature on other
> architectures.
>=20
> Currently on systems with both PE-COFF and IMA signatures, both
> signatures are verified, assuming the file is in the IMA policy.  If
> either signature verification fails, the kexec fails.
>=20
> With this patch, only the IMA signature would be verified.
>=20
>> ---
>> kernel/kexec_file.c | 14 +++++++++-----
>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 881ba0d1714c..96fce001fbc0 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>> 	ret =3D kexec_image_verify_sig(image, image->kernel_buf,
>> 				     image->kernel_buf_len);
>> 	if (ret) {
>> +		/*
>> +		 * If the kernel image already has its IMA signature verified, permit=
 it.
>> +		 */
>> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
>> +			pr_notice("The kernel image already has its IMA signature verified.\=
n");
>> +			return 0;
>> +		}

The issue I see here is ret could be many things, for example it could be
-EKEYREJECTED, meaning it was contained on a revocation list.  With this pa=
tch
the revocation could be overruled if the image was IMA signed with a differ=
ent
key.  Do we really want to add the ability to overrule a revocation?

>>=20
>> 		if (sig_enforce) {
>> 			pr_notice("Enforced kernel signature verification failed (%d).\n", re=
t);
>> @@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
>> 		}
>>=20
>> 		/*
>> -		 * If IMA is guaranteed to appraise a signature on the kexec
>> -		 * image, permit it even if the kernel is otherwise locked
>> -		 * down.
>> +		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
>> 		 */
>> -		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>> -		    security_locked_down(LOCKDOWN_KEXEC))
>> +		if (security_locked_down(LOCKDOWN_KEXEC))
>> 			return -EPERM;
>>=20
>> 		pr_debug("kernel signature verification failed (%d).\n", ret);
>=20
>=20

