Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727747C9120
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjJMXBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:01:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A01B7;
        Fri, 13 Oct 2023 16:01:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLJJJk002791;
        Fri, 13 Oct 2023 23:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fudT+JiWDPPDDBQcKrp5fIaQDMRG5BdQFN3dOWGKMlU=;
 b=fFmxI7pgJe3po6QUZ+vIw4AMxp9E0OnGB+wnHCOGxjpKFSVoAWUF5eIBlyqfsmCkGaN/
 nio3n1LKIt3kY1h4USqdL7D6d8nsE2Qv1MJbINBPZGaO5CqpbAW2Hhx7LX5psw/+Z5Ac
 uPhZrBlpgsjaW4Wr7aJhrs+3X2sKQyk4rsz7lwjK/Yx91eBq/NfSPrALKhn0rE2OG/AQ
 L/K8kIjwKHCmHw96fhYcvy00HmfRfy283M8xJ0TBBMsSHbqk4as0FsVxDDD7MRilSGaF
 6zkC2jZoUx1Gj5ZOEOMqWRZYjp5FTAGzCtUvFOkS2pQVZbV11ZOMpp3iPf4bI16W+Z1w zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2e3dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 23:01:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DL0CxO020219;
        Fri, 13 Oct 2023 23:01:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptck9rsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 23:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m97YhYFO4u4xYutfeVG0rjpD1M1l9lsldgOT/DxNQDQA/9yXObIB5RqMzjlGpHvHHYbWsmJpaag2//AQFroXA0tiUqP5wMH7vtPjOWonpd1+YOzb/iIrpSlPj7h6gZfkzeNwYnJeS4fGHtYGfxPEBWr20aPJ1VE4BnWI8cerYG1deCWYpXGZu5YZIac4l46b5yEWw26kb+7w5PWKCibNyJJKX29GOijGQ8tnGusQWeEvRECf8Y6SPDAnKCa4540/t+NY4SWhtCk75Prgpv9I2aQNcL57Z6ECdCFW+NLyL2f6b8ylVKCDSlyusslPy+dWpkurvSKGUKPVXyY59WtopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fudT+JiWDPPDDBQcKrp5fIaQDMRG5BdQFN3dOWGKMlU=;
 b=aGXxJWCgrAkhIF5Ss4nrY8rtIF+pksDMtbg7PP6Niub1GH50XjqLOrlyRGlUpcq9W1ShznNfKX3CgpmBpTKQB8wUCaOEjomoGxuclrRRIst9Lcxg4VRCPxky+M1ZCTmvQhe1sB24lUSVi/ssWMSwxHNumjGJN1wmO42lznEataMlG3Wc0USoEOUeSGBpPqHJ3770p3WUtvtsKoUAiacYaC0QJGyyFyfudgDQzTRE+rHEQv5b7O59xtrXdAp9pQWlo7FvSWGTnA2jGCMUA7nOYg2D1nZu7H4wJuJZ3NStMKXfV0Lm2y9slZl5JtdCxYU52UXpBf7PuY/n/ZVHVldrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fudT+JiWDPPDDBQcKrp5fIaQDMRG5BdQFN3dOWGKMlU=;
 b=KlF2m6D2MPsjx+P+f1nFSLU13Bf+9X5uLPZEjSzKLZCVyqhq6BRQz8ymigSyDREJuTkC+nd0fh1x3OhRUB5uujykRLRQmJf7jhfC6hb8aPFlQYOGh3qcyefs8Ri+N1rigxUfkYWmsbHWDiOvEv56345eckrsHVZeQTubvxUaeM4=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 23:01:12 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 23:01:12 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Simon Horman <horms@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Thread-Topic: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Thread-Index: AQHZ/AGKCAsFOxKU5UCM3TNn1o0Z4LBHod+AgAC4YoA=
Date:   Fri, 13 Oct 2023 23:01:11 +0000
Message-ID: <86531411-0D87-4F45-BD19-CE456A70CC47@oracle.com>
References: <20231011051225.3674436-1-anjali.k.kulkarni@oracle.com>
 <20231013120105.GH29570@kernel.org>
In-Reply-To: <20231013120105.GH29570@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH7PR10MB7034:EE_
x-ms-office365-filtering-correlation-id: d388086e-3c46-4989-611f-08dbcc404b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/Up1Pay/aLqtvAceuXnIQQ0iCXwcqUVafNYBPSgAZcpWL+Cln1hu7bDa62b1pVmY6sNMtRfyC4GzVSf8PbDreL9esFWCDuQgzNn+PuJIxROCfzCLTgKi+Zewjhpnrz3vHroomuyZ3zu0lFVQPeL0sSKPWB1Id8whHLOR5R98c6fVWcK3z+wY0g3NU+r6tN7aL2c79RzUPf7H7Hr96gBKgn+y5JNPKJ7qAclYRHhMqYV7l4WgPoA6xSOxAJbamO8/wuVBXfeZmEES0ZrmF7pnmNrAQ9bK7NkPdmgoanfufeRhmFV4VJFvu/A34UbAHoKY9qZn8I9LbIUZI2MaTmi6deYvvOlt1dOl2DHc0sPF/S0WXDQYb9Xs61xmArsSgPGUOV2G9+c8orRd8EwUU/DTjijeJXy+h5oY/HQTa/nOMgF77+TpQDDzE8yJs7IAgNWtcuUh+WrhG3TA4kHReoc/qN9FCQwngVxVNHc84mHyDvGHt0RNU5OG+TAPbZklY4YfT/B15izLUmmM2Ty3g7x/lr8bKAIh+laKjW3SfxAE/mYSHtJiJ1aoL2jVIKKXwSzoxnzH747ZJ+g23TgjqrNSe/SebFInRa7mT1am8lcM1HIb+IZAAQdRE7VEQTsVnNuHMr8/sPEUAqkBvFFAExD7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(26005)(6916009)(76116006)(66556008)(66476007)(64756008)(66446008)(54906003)(4326008)(8676002)(8936002)(66946007)(53546011)(38070700005)(36756003)(122000001)(2906002)(6512007)(71200400001)(6506007)(33656002)(83380400001)(316002)(86362001)(5660300002)(38100700002)(478600001)(966005)(6486002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sg0X7MV6j4EmUE/jBJGQRsas8zEPx8fcDeIWa7ZaZStu3Kn0pbicN7vXsgoM?=
 =?us-ascii?Q?2HwBatwn/2S5uRl9b6ohQmaaLIBspL5uA1Zuy6YhnyMoNEsANxsNkEw8s5pK?=
 =?us-ascii?Q?6xyMnIiQz70sY8TGGS6DxWiC7+YR7rDrXVdjTZugIi+S/Hb02AiUKIre4fHc?=
 =?us-ascii?Q?zlndP1U0o+L8qeatRcY5AuK44hgMfNj1cctd5RkYgNvzh+aSWySluOK5jwnd?=
 =?us-ascii?Q?of+YVDrzwkFpHFs513hypHKM4q3KJ8M1Ovfr4XPLSHVdAwgA9F2L9QAp7z1m?=
 =?us-ascii?Q?MD3cVADY9hsOnoJfRiC5DUjQh9UwcKXlSS1iuSNwOB+M3clf8P4wL56BUqAJ?=
 =?us-ascii?Q?bODfUjN9hP7mBiErDPUN3zTypvK5pR/u9t8XNHbhkBFFeoW94oMyurWjhvu2?=
 =?us-ascii?Q?gl1C2JynnZ03pWY3fzbIz9HZCUyAxFOfMLcP1XTQldg5Pb+Qm1XbcvheKmlb?=
 =?us-ascii?Q?AnpjGsxkTD7q/ulAD9sdbD38J9cg1/XLymafEd6OA0Q/e+1EKL6oR4/rZuvB?=
 =?us-ascii?Q?0EcrDqSO2kZyva2tV1UIVF82QvPgRd4vHcV/L6xV9YSM6vulrqcVmguvmyo8?=
 =?us-ascii?Q?tN+3KGtBGJuBpG9C6vcgGshl/DVcrl2LbaxK1EM04ZiWGlhPhJAsWbipNBDT?=
 =?us-ascii?Q?DBXxK3VbqWkM4dtE5IjzXsk0py73WSk9LxHKxsqvhlvsV/wu+hr3+omccPkG?=
 =?us-ascii?Q?6h6HrdMu+8tUFr4Rcj+yvJsFxuhETktLNTwQJan9CD5v7r+/tlfEKbZOohrh?=
 =?us-ascii?Q?yMMFpTjE2i72MsJy3bZ/Zu6MGIDe/VUEEJWVMHPBV/pu4LQxTdbV3SsNd/kz?=
 =?us-ascii?Q?Lrez7cyysPBJ+S6mHBZjjVnthIPEr2XgCbyJ8gGM+TWI+7qXPEcBD+LocBZz?=
 =?us-ascii?Q?ln9usw3b12nVaAeAka0mGJXbH/uopf/yMOIfHiFfdblx9o+7fj7YWhRTyBwe?=
 =?us-ascii?Q?JMkQQTb+o4osbFFw5XkVoWvu5jYWCUQKUP5/+pyUh9ill7Y9l7eYm3UWie21?=
 =?us-ascii?Q?8QQ03vlNc7YGmppAKnTs7wr+dW/KdxuHjx5ioQydTaWeRY8gvefdkid5Nu5G?=
 =?us-ascii?Q?LxvjbuSvysbm1BsNO4/8E2daxHPiYdudfkcNnNDXVlMA98xHk5OlH7yyFxtT?=
 =?us-ascii?Q?wKwpcKHlvsK/insYRX1G346tvWD3cXPEXy051Q/chd2YE7gQdiaXZqDicMw4?=
 =?us-ascii?Q?0GIHx7VosR2QntaT9tBMC8sA6fqegaGiTPmTvVlDI/n7RI14Gs+zjyrDSvyu?=
 =?us-ascii?Q?0ALayRCM1+2X0sKRO0pKaMzQbPervwWbyuuLRGLwOZUrEUZ+J1nxZ9HYSyoR?=
 =?us-ascii?Q?8T8N9WSIgWi3Yh2S+0/5j/tNp9CMKXCo5WTVQRC3iuNiBIxTP+y6NolpDJRe?=
 =?us-ascii?Q?K0gVONSZXghAvfU88FiFLbyGskA2lzAjozA1rsBSpFlI2SnyLgoxxlVojvNq?=
 =?us-ascii?Q?05cT3WuCqKQpJhEbJ8RsYsDSY7IQuAHf2Fn6GACwpGH63vrTK2YVqPH8J+FR?=
 =?us-ascii?Q?wZUwDTcI8IxPJFvPcWLztY2COMloeHM+St/yB8GhJpoHIWfeYihtBSCtdC8a?=
 =?us-ascii?Q?Gx58b/mUmVKaYe0wHuy/PBYClCKBnZKAqfMB8kLr6OfUWKDa5qqxxAKi3pce?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69E382E667D9E44383775598312AE4DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QnWeaOcyEuVRhof37PaFWTXndTMS9m5T/klp0koTKe+MZpbx67DHwBL3raBza84dEFzDmKlp/ZrXuAx2M3o3F9G7cfau9gB8ili1fOZps6kZwF3QJjxh6LLzbJuYNwyGJQTRtiH8FfSuAr7sHpUZxrBZ0Xp/gOgE4HwEWR2Frjd+lXN/YiVQDFPGY2G5gT/k22SXQev2T7/3iy67ZSQaF4YLwtHqL6+og3dnXR1xfsjGDwQwcaVx7CzYqesSYikOlzmQCAvVeGsLWUcIpcQzKdzcLQYJgkVaDI3a8+apOcIlpr4c0efATElLoLG6Fd57HMlmoce/1TNJCNFiixp0i/A3qFS3uaPx2XOhHA+TJY02qDF1FL2pkZp+lMfaOX+egA7+6xD4TYqttvfYchb2YHFPyeAhRzaMUoOLSSVKFyLGD/ngsumhzos9hHPFp13t3jv5AGfwMHdPCfkmmxj5VC0y9ueS/qKGyoB0ibNeP9SevfC0iISurugKktLCTSHSt8iTERSQn19B9Hv2fOxE4TvtqFYg+snxfUcrNwPfbiQDQOXLNf3G3kr/BXI8OVSUmmLovodI2sXrcJAeY/Pqlpcejk+Z8+tepmWEC525Uv3+DMy/fPZEUAEp28w7Fg6KitjXJh/RZ5fZBb4v1AdYF7pPrHFS542E8qNN04CyweKdMYdIrguIDiAVCurZ1AUF86ffzSN0uqlkxObk1wuPsIEXIyx3uZ1CSYR1PVEH70lBp3T/pb4vqa66IDBSgIIuLKhndldADEHDZ6BZobxsTbM9pauNNFAYc+PyHPE5IbswuDudt05P7BuzJsYfIjJ3zvZZvCumczRnI49rskJ0dUq9p3JAJ0fZ7/Af64VatUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d388086e-3c46-4989-611f-08dbcc404b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 23:01:11.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZrUPFKmgcnYjHycaKwIgzDC6QHASTSawFm6apVUfZn7m4CiOutkmTRkvJn/MkcvCIfKp5fTtY13otzHy+hglT+hlhqF82koHcEiqyJ64jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130200
X-Proofpoint-GUID: 04zlpBG3Zr7oE2I5fUBAG5B-LEtttQaz
X-Proofpoint-ORIG-GUID: 04zlpBG3Zr7oE2I5fUBAG5B-LEtttQaz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this patch,=20

Anjali

> On Oct 13, 2023, at 5:01 AM, Simon Horman <horms@kernel.org> wrote:
>=20
> On Tue, Oct 10, 2023 at 10:12:25PM -0700, Anjali Kulkarni wrote:
>> cn_netlink_send_mult() should be called with filter & filter_data only
>> for EXIT case. For all other events, filter & filter_data should be
>> NULL.
>>=20
>> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs"=
)
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20230=
9201456.84c19e27-oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!PgqlHq_nOe_KlyKk=
B9Mm_S8QstTJvicjuENwskatuuQK05KPuFw-KvRZeOH8iuEAMjRhkxEMPKJJnLcaT8zrPf9aqNs=
$
>=20
> For the record, this got a bit mangled. I believe it should be:
>=20
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@=
intel.com/
>=20
> Also, there is probably no need to resend because of this,
> but no blank line here, please.
>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index 05d562e9c8b1..01e17f18d187 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -104,13 +104,13 @@ static inline void send_msg(struct cn_msg *msg)
>> if (filter_data[0] =3D=3D PROC_EVENT_EXIT) {
>> filter_data[1] =3D
>> ((struct proc_event *)msg->data)->event_data.exit.exit_code;
>> + cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> +      cn_filter, (void *)filter_data);
>> } else {
>> - filter_data[1] =3D 0;
>> + cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> +      NULL, NULL);
>> }
>>=20
>> - cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> -      cn_filter, (void *)filter_data);
>> -
>=20
> I am wondering if you considered making cn_filter slightly smarter.
> It seems it already understands not to do very much for PROC_EVENT_ALL.
>=20
>> local_unlock(&local_event.lock);
>> }
>>=20
>> --=20
>> 2.42.0


