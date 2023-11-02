Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D587DF873
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377161AbjKBRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377148AbjKBRMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:12:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BF182;
        Thu,  2 Nov 2023 10:12:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2FkiEg010322;
        Thu, 2 Nov 2023 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tONCHmV+MgkF92rZ7p02ePmu8q7+n9Vy50Fwun3oWaE=;
 b=ev3hWdpqd6kMx1Jsdq36XvxuoKsoNx0kTfT58Jo1fu+SRFDVvaCBTZXTQ3f8YkAtZRI+
 wvhhpxT14GGfrwVrj4ULXDw9+2CTLF0q8EjVcZqbxx9mEJ6J5gjG83NJA0gVdRDfX3Ui
 NtqAZ8ZOhCIF9OPKMRsveD8G61UCmtvB7uWw7yYMnsgyVXc5J+4a0GoAYAH9duR8KS63
 r2KhsXmTItr+ulvuEX+l9hBjIw4eFRFoD6pnKyNdeQF6z2mXpKzcLaW9GUTYnO3e40Bh
 e4mcpGgGTwyjwyFkj459KMBNRYXnMJ3m+fIiqIMBcHqun37AR+oepjmnZjJgtzXGYWcQ ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuuj7dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2G0541020079;
        Thu, 2 Nov 2023 17:11:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrf480w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzPwcAsutDa0VSTa+sBFFoEfuUvzx5Ewk7mPrqH//ibIBkvb4LpBoRJtbBTEY/DRDHZxgA4S4ms3lGDGE5GIClGdAeBBAlLML30jfx7o2nggNwMnNxBAkJs+UvaAhpDOKoVCdOTc9Os9k6jpPWvZeT1QdZLxC9FYPaJfWoq7sGdJWTB4PchJjzPdNEqlZvOMxSgZaDvkZbbRpy7Ma9yAnUD0elq55haFlGDuQZ+uKhOQ5L6TYEXkfHEx6GRzMJZGhg2GS7rmSiKWnOvl0upozBHVAhiIZo7v/cgCYuFhtoz2xDm+Hj5Y+IRB4YLd+VEZXbd5/xQxVb3vaZwClAFbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tONCHmV+MgkF92rZ7p02ePmu8q7+n9Vy50Fwun3oWaE=;
 b=VSiuzwUKKQJ2wYPfUYGG0LWfHsNkRPkYBIhCYoCOp0QE1qteEY6gAeoaQIZTW2yZgOHV0pW11eDRtYs9BpvKnOahm/3HXM0IrRi/btlKBvg6O86wn/ruGAjrTCR9ocnp9lgEgmD0zVOrZh322qjl6GM2EuAj+WLWVAqN94MJq3Wlz2Xd6zbCUzcGB67o9H0DRWGUHZxVL1GEN7Hlobj+4WRhLMU8i25ymTwlG8PgK5FY8lKP9Acc6JBjFQLfVdB5/2cLEzAMsQrbkme4wL2rKojQEij48NEenyoLYYiyee6IotySkmFzjKGHywVC8/HGqOcjwX6rTgEEI1gE0ih43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tONCHmV+MgkF92rZ7p02ePmu8q7+n9Vy50Fwun3oWaE=;
 b=Rv1vXCEjeFOaOErPR70lq3LOQZXEe93dmwX1VjdTCGPr6H/9CkK0F3sRpj6bvmilTP4kIxT/Rs36XqfJtdNElgE/WXzT0xQVLvHi2xn4hz71eznU/nL118HXLqs+fvuoojBA6f11LNh9g3089efWG0CxnPUQb7RRgYIx+2ur+8E=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:11:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:11:51 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ima: Remove EXPERIMENTAL from IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
Date:   Thu,  2 Nov 2023 13:06:17 -0400
Message-Id: <20231102170617.2403495-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231102170617.2403495-1-eric.snowberg@oracle.com>
References: <20231102170617.2403495-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:510:325::16) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: e94ae4f8-ed56-41e1-30db-08dbdbc6ce09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hVs2F0r0Iaxqcf5ZBuVYjsdiL2ktA1EVCHV/klf8eyCOO/32saYmzllZEoujTXFSP5g23EJ71M1lMYCr7Y4/mPf7YEoJ0LpZ7HVp37yKbnTtzGKy4ymPCYug6oO9h66JhsMP5xnYImGpPVx2pQI87fItarSI9Oqr8JDBA9Yq7MZvrmUBcHAdICN19slvjQUAn+AH8SZJyomo5FGWpnAv8I+AyUFoML1ijVt+B93EdLYaHSX301/uOM8xaiqdPHRqn3thNI08QFHqNyoyuCgwX/iXEUqvUwZ0VyBkYKs5sFcZX2tCa1ShWa0MmcudAb49mMiGFExk7kig2Uh9zEzDh22nAnU6IOCDS5Xs/SL78thY9M79iGfNayzZcFxs/GphXGkA1lP5puCSmwGM7KcmbhleuAV5z7ediP1s2E/2sWR7tOO1rnYMufiKE1FPnerlYtUEgXuyU1lngAhGvSBblxD60uSlF/ZsHYDWzM6BuaRdub8P56YcP1AyIMPCD7ooTofn4zfudDdfDDYNAR02OdqDVvZ9KAP6ogHpdMZgT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(4326008)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(44832011)(966005)(6486002)(2906002)(478600001)(8676002)(6666004)(6512007)(36756003)(83380400001)(6506007)(1076003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpYL+5LaVVxPwlKpMsaidq9EWwAwIg3Y25L3vTxs9L1SgFj9CbSQMJ36N2vZ?=
 =?us-ascii?Q?iYon6wxqd8awILAJXptrJvrOdfhOm26DYtoxK/jDAmuxHszjGQvlrulxAmHt?=
 =?us-ascii?Q?tHwSAR0+/9KdK7EOxfA+oZQd0DIp6j91Sdm839WNFR/7Km+S3Uurba1Efl0h?=
 =?us-ascii?Q?Ow/zO/e3sc7sBMJR9mw68yLdqL1rMJAqWnOAdD7xDUFo7nLDsdFX2AjVnl5C?=
 =?us-ascii?Q?j1fhkqFoacBhdlJlnFav2xFANElBd6Qt38e+KjF2DZtS+TsKb2uhU5eL7Djr?=
 =?us-ascii?Q?1zAL2fDwBLwNYAK7Mz2JfXY7dmT/j0Jv4U1/4wJEYeR6Y2DhHf/+QEtlaM/+?=
 =?us-ascii?Q?TR3kWZxQcv/JdEmQ102ZooktCG40aFAZAnI3q7EpPDPlkzfmKfmUUwqxx7bX?=
 =?us-ascii?Q?+nvafTQKsyVrfIwHYID9l+lwYhKRlLzgOKVbQKYkwyPWR3+/Lt8jSOwzSvu9?=
 =?us-ascii?Q?wDwLB8llvPXgl1t6T4jjCSAzIPZF3M+Y4R5NokGrnV6ioaNAN4aEUTg3Nc0l?=
 =?us-ascii?Q?127YBIZls1XSLZIcr+BUdv6/i6Qr7ktA6JLyF5kbRYHk0+mgwpbUl2TqiDuj?=
 =?us-ascii?Q?BeqpWjLOxnZNLumBr5+RFOf5fUzetxLsHEp5w35dU/bVQ0aqHN3BesxDBuF4?=
 =?us-ascii?Q?rgauf3BIViNouZxb1M2tb9cqQ7JFK/Qbns3gDQXPXkWZMFCHLu2G63wbrppy?=
 =?us-ascii?Q?7b4phnDcP4+ksRunsQMieKPWIu4pgSTYUj6O6NghmvwtI1xBAPeKrnvjJ2Ch?=
 =?us-ascii?Q?dtfZtlkmL/7J6aNgLbYb2O4+DXbH4Oy/LzpKR/SZKEHsNfq35V6tULEl5afV?=
 =?us-ascii?Q?VqTAFefaQg1aFhLq2n6Cfn+9SWI7KmdAPF1dMF65Akt2TW9osxri6yaXj9ix?=
 =?us-ascii?Q?bZrtXRX2zd86yQAcSr+n+fAycIMbRBtFAK7/W6Z188Lnd8OvaXVRFmsfqffP?=
 =?us-ascii?Q?PTncAo2E7Z1aDuzORm3b2FhMbc2FA4rQwesyqILTdaiaBUiDcUgtL38sufNl?=
 =?us-ascii?Q?bQ7itj8kmgl4rv2OwlMmPrU/ONJH+n+rfNAUACzyiyzqJeAkNjXbT1ELb2y0?=
 =?us-ascii?Q?JjDEJ91y6RfO8OumNwU4/mdGLgFc1DSV2xIqIvJd3WsQOj/SCT/j254FwGiL?=
 =?us-ascii?Q?jXZ3dyr93kxwyCH8TvipOAkaIb6QPs6JYHvnKLwcNouhTAC5rOJh3ph4YKXo?=
 =?us-ascii?Q?p0L05qqPmrBPQWrHJ1f7GIbGTobV07nlFjRFl+nVf9rKTYY5yoXGhIiOiLxu?=
 =?us-ascii?Q?43eXmh0tO0UB+13EyWiZ5yeNklx5nCVxRq1Kod6p0RJXpti5ZZNpkVEe3d+q?=
 =?us-ascii?Q?Bwv1IZzFtlliRaw+uqTs6fdz11b3Wo3cwXkA2S0rjzbIWtVzjr/+CVkOe0qM?=
 =?us-ascii?Q?fyd4bVJ1RX2/DUsB7JFNzxUdizsmBaq8rA++cu0e4JIjz/Wi9EXPJtscEJ2x?=
 =?us-ascii?Q?qE3SCM1pmB9VerrRHSlr+yd0cJzo3Qko3mAHOVFGc1c7/698XveCVbCamiVe?=
 =?us-ascii?Q?upSQzxzDyt4Xv5/e5U4xN0Ph/X+GF4CQAQU0OH8LTKNfG2qCDbdqq5GiV87b?=
 =?us-ascii?Q?5elTfPCByMfhjo/fpQH1f0fCEPotcK+T9g3KvOU09X+m1coEANxqEVGwKVGd?=
 =?us-ascii?Q?mxLyyPY5eMtitxWfVy81xaw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3+iBcpx02hmIMFvmwheO+ayA0znPx/ED8XTbJ14o9E0bbqzK5KR8UrJFWe0h?=
 =?us-ascii?Q?c1/vdyOxc+eqPJY5BoZTOjS6+YT6JSDKlNZlWLfAjH5lQFScVTmeRUEDwkTq?=
 =?us-ascii?Q?UK/bm5yrW6oIocQbBx4ridiHVdOnVV9dZwStnsES/+5g38wjLR1Da/dXqu/y?=
 =?us-ascii?Q?WG8hPVzrV81xnXNjH9YR3evXMYwdzq2F/m96kNY8mIxqFUWpgHw2ImRdslof?=
 =?us-ascii?Q?PdNUon5J7hmh/zck3LDZH3jzVmafKGmxrn2+GBjWzSrYW2+fQbAXZ+BSu7Wj?=
 =?us-ascii?Q?FNTZsscS9uWWXR9Onz32XauyZfndUe5oddEqReKq1fzznD2iY85CgO2TDYrO?=
 =?us-ascii?Q?p0DfSekPrc9ZHlyf/yIb+8IRcC5Age1eu3WzhMDdohRKH65xg92kQ5Msaydl?=
 =?us-ascii?Q?vVfkzyf4Jp8AFYeHjjnKndVx+FkjuCc91oyqQWBIhecC3HnMmMQD2lb+bZWp?=
 =?us-ascii?Q?5lG2EkZAoPyYQr21/OL8x3Jsh6wC2Wf0PziMG8HlfTZgTCiL7OhkspOC/tHV?=
 =?us-ascii?Q?J5t5Sb9F0sgsdYLIUsSJqZe2yIVLeaBsVAyiKt36NRJy8W9EoKQj/0baHWD9?=
 =?us-ascii?Q?HWcEAWz8Mk+DSOHO/LBmn/gzXuh1VFTNIbe8NQwSgBS6EPF3qttIkPyph4EY?=
 =?us-ascii?Q?Ci6iI79MV4VHiHJfX6g1S0+qRlrs7+dLwl51MAL4RsxS5IOWV/0I5G8/knr2?=
 =?us-ascii?Q?FfX9darhtMeRsNPZDPmSOpWqOHGMfuVxDd0rCAIBfQj67PsrvBJFgyyalDkG?=
 =?us-ascii?Q?Sm9IoIKgWWeBYwcmzQVFHExes2bxcc9EiPdKTcsuRlHCM1irGqxDqScf6PIe?=
 =?us-ascii?Q?ctDAaN3l8rjXnfhjme5p0b0NuZnFf9QRi6vscsYx3RvWAsWOhQavnAUq32k3?=
 =?us-ascii?Q?ED3AaUTb8okJewJPHxT4oxXRkrJ50+SD1r5uf6xyuZjhQgrIsI9xxtU/BzpH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94ae4f8-ed56-41e1-30db-08dbdbc6ce09
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:11:51.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vps0zmIw+JAYnZgsnE5I2D93cmz8b5MGOxw3tYYe7TkOG995cKeXSocgsDehRYvdh5sfyPkBZzIkApvC780PFdNUi7otWPP15gy8Rmz5Z0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020140
X-Proofpoint-GUID: sgMZWKg-Gle3q7GBFp3aKYm5DoEyutWt
X-Proofpoint-ORIG-GUID: sgMZWKg-Gle3q7GBFp3aKYm5DoEyutWt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the EXPERIMENTAL from the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig
now that digitalSignature usage enforcement is set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
link: https://lore.kernel.org/all/20230508220708.2888510-4-eric.snowberg@oracle.com/
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index c5dc0fabbc8b..2b99c734d5ac 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
 	   to accept such signatures.
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-	bool "Permit keys validly signed by a built-in, secondary or machine CA cert (EXPERIMENTAL)"
+	bool "Permit keys validly signed by a built-in, secondary or machine CA cert"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
-- 
2.39.3

