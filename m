Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D557991B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjIHV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbjIHV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:57:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A4DC;
        Fri,  8 Sep 2023 14:57:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Lgmg8019500;
        Fri, 8 Sep 2023 21:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NcJ+TcTi5DL6TAPH5qR8WRY/LCHsb9uFqysZIwZ39bI=;
 b=NSDs3GK2AZ+ySPWZKtOby6nLA6WJ1Dmwb/sXb6CP+ThmuXllChvskpAD1EyqIECVS98K
 htXy91K6XBDGZQUTpXqKlvxCPGpcXufEsblgRZ3Vmc7OX/8Cx8isHFf2/0hdpECISsKC
 UsQ6k5fjA1+ui1DCa5+rn3hXrF03DhYjia5XG2IjXBQRade9a2YiCtfc+8GAdtcqCdrs
 XQdXSUehjUh69RpW3FXfW2GR2eMNOqNZm0d//nM05Z3kjrDne0IckxJvVkEvsymVHH2f
 nr8i5OGFLc+12YqYJ3hQ4BYLQ/V4J4UZVDTe67KkgGIPO+pHX+LQRpDKQjRBgQvbHx0s uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0bn8010a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 21:56:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388KCYqQ017268;
        Fri, 8 Sep 2023 21:39:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suuga5k37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 21:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKPSfpS+tHLVRxskW7007TeTnQ/9RlQWCmvp6ed4Y9jzGps64rfXf2WJRP6Iqx66XmOG7Tfc6UxNzYaQRb/bIoLcJdZ9XwsuLPagBs2o38dHOhNwoTwi1sOCni5bjH76sjTLPmY0E81dZTjej4HxNQSiFXO+Hx0v477E95ccsXs7gYZr1VwfCYxEwij9kpvJQXAFc8RhSeFEwvQB+EWVOoR6kTwExV9BzugYrrAmfQlDSfgMcqHYonUgsv2TQZ87wS65ytYWJ4w4mUc29UUdARl5KMBGHEQtr0+PkODZnuZ8sM0TV16qcxG8cAIX5zpgMkMuK2zYk1y4pl+dlMYz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcJ+TcTi5DL6TAPH5qR8WRY/LCHsb9uFqysZIwZ39bI=;
 b=mWKrYRwEvHdeAdPXT17bpG03O9M8/lnOQ3RRzdyvn5ff9nUGxKdWrCCInlQwXNR/lEwO82OU6oiiQDDjOcRkEri34VPvid8F99ERrx+TK9pLlz9i2n282FBIcpURtiwsdYDXFHZDRBhuuDcdiVm1hdSnXNM8tvPBh4kRXy1OtK3QoxWS/6EXN3K/6SGGJWnw1EioD4JvYpiDwfXShIddRRlblm42IktcAxXtJS6MGM+YNjphwDnMPyCNZ8z/GkEHHI8ihB8WhMI5K5iIhvfhkB5jue7N+O3w8RRJYJUJ5Bzbzgnq/KAuoa+YjDp1QtOo+bqIWEEvQUHXwwVoxwACJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcJ+TcTi5DL6TAPH5qR8WRY/LCHsb9uFqysZIwZ39bI=;
 b=D76Ny/X48rKRwHkOvugCogkw2C5038VIUfnQh7sLA03GXJsOUqwlP7XSu5E4g+XjFfRWErdtoPTjhYmgTPUA4YV8WOcre2cswthDs4D0BcVhNAeT53OnBQR8FquuycRGMT4EIb7Dlq6jkACzDuf6HvE+TBAVATDcoMPGLFZQ3yo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 21:39:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 21:39:54 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     mic@linux.microsoft.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] certs: Restrict blacklist updates to the secondary trusted keyring
Date:   Fri,  8 Sep 2023 17:34:28 -0400
Message-Id: <20230908213428.731513-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::26) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a103e8-25ce-4034-c830-08dbb0b42390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUukalFTVyE3a7zJk/q3aIjkiN0xapH8VXy50kZbReuh5iyXhwyoosPcm3wVRFqNeyLzvPYrARo1aXBCXOpq3dQeZZXgfTkmwg6EA2IKQgx/6jYtpUENYrJ2Egtp7v8WbA+dUUG0v9cpH3NeoVpyHy5XEGMW5y7Ha+fTWmV+3kM+KPRr3Wii1blnO3n+ifH1bEYgCeLqmc82Kk0lx8cMKd1ecrAKF5jdsF7w9HWQsH7uftJHidSd90L1iEmzCKsr0iXB4Ey3sWf9lWytowsb9raj5HFpbh/uXjErSRRJuAczECO1vyl3Y1vmCAkRu7G+qjm8a9CCqwNfJvWoyyGiVAAH2FVftjI5ug9rFn/CHvK7JmakJwKT0/JWJfqZgk3EQH83V/aricT6ucCyOEuBzX/HurIEdChTMvnf6qmB/oG4NUjW16ZopyV57dos3wedas6Lw4s5sABVr+VgwVN7v7rq5NW62CuhvycfWnx/Vd3FBEkBwEvY3N2DxmKyaQcGRmmOzCAt0pBM8SSGZo4MfxokbiV/6lgh9moBdBffizZ0jblvg1Mw+hnLw5n5nCP4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(6506007)(6512007)(38100700002)(1076003)(6486002)(2616005)(86362001)(6666004)(83380400001)(478600001)(44832011)(66476007)(5660300002)(8936002)(8676002)(66556008)(4326008)(41300700001)(316002)(36756003)(66946007)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/Tx4LmKwflK+yGja+sxQTk6iNUAkcCOVHt1zcch7kDcaSIHahQ9tRDO6K+o?=
 =?us-ascii?Q?6EI3Jvx9Zh0LanC6MK8cmuOrwd8waES5rCmIzpc11gZc7FKuX37GcUONPxS4?=
 =?us-ascii?Q?nSvgPMgs7F9RyExobzPtj9lUZ07SKtrjd+SBSiW7m+So+Bd6ZNfFHlY6uUBx?=
 =?us-ascii?Q?SqIdtmAMJ53Hexq2/QCDreD4ViEuDMWG9eiXT92F416af4GmDXxXn1K0HFaF?=
 =?us-ascii?Q?+/iWgbU+/9AIX7TvYMcy2/63vnllN16Vezu60ASJ3ERHfdJ7uqZQNp3UT9Tm?=
 =?us-ascii?Q?yVI1hUFB3aVv4+NWyUBmH8Jq1gghfXAfBO5jI8AxPCVTqxJ0o+qskiLvYp3l?=
 =?us-ascii?Q?UHFhvCwqQAAD1L6kObSX9KyQ6CHHrUH6QbqC/w6zpOhbXc2Uzr0FJHEC/q8u?=
 =?us-ascii?Q?xiC1Ble3DkEhu/vog9fU6tEobZiJ9gBnM3P0fj1gQOjG3xEOeOlhnumAKGY7?=
 =?us-ascii?Q?DgEyfbI5UR/67xpeGtV5BJwApYTpqjj/ml0C03dVL/KKLYFgqfTMxx9g22mR?=
 =?us-ascii?Q?0y+fBusHk5yYCD7XQhSkS7SY9FGT81E44u06IzlxByCJmP4FdsSVPWOzhuex?=
 =?us-ascii?Q?MhWxVK9pOhqquyR8vz4ysi5TsFuBLoJTQC9mtbOTOXCmpyCCFjA2AZ6WYc9f?=
 =?us-ascii?Q?vvPgZSTfEgZPeX9//XBDdRrSFIKI+ta9tBs2edI5D4QmLgs/zc46yWlep3Gi?=
 =?us-ascii?Q?7kswwuagq52JwReKNmoJ28Gom+Qq8XLrVHBqnJ/iOGlxSVgmZrfaTDOrK7RW?=
 =?us-ascii?Q?r/TI4PZwFGx8dhwihJB6c4HeI0IsU9AzAPvHYk3SatNkLO0pDRuTpX77bZo3?=
 =?us-ascii?Q?jwQ4pPRhwjULO+HJGxE22e2m9NpeMmbFbkCbM0p/jsJAPfEoMNXW6e7GmRB0?=
 =?us-ascii?Q?q+6qGqEYg6Fy2kgsyDpqhtFV007meQD5IlklRt2tR6ugxh9Kk0T7tC+/V9si?=
 =?us-ascii?Q?FJsvZ94Ixb4PHALHK3ipFbLSyU2IBWGU+aZ2v9Pz+eNV/a7/9QgB6JeazMTv?=
 =?us-ascii?Q?OsojuKb+Kzy3/rOPi+tejYQ/rQQf48FVJU2s8tjUL9fbNtBAQu7yxOZ2PYBV?=
 =?us-ascii?Q?GeqcbXofphEtCcuNguwYxhqvjxnrFF3qblKvZiC6boZ5VJwHcom1XziBOXX6?=
 =?us-ascii?Q?jZPotiFfeYD0rmGpf9BvNWH9rpA/rIm+8jsyCK/9SR6k4SOtzpe7IIT8AehW?=
 =?us-ascii?Q?wcIs+tdorOXH9ZP5E71sfHnAm7HAcdOBO+i8D+J7AHOOekDyPGzEGlEzTHSD?=
 =?us-ascii?Q?McNBM161TkzI7FS8IZ4iDj9zPK18Fxjn+dPeyzuT6656Y6uSmWVYBVH6LPpz?=
 =?us-ascii?Q?Alk1PxHxg9SJfEKgaV8ev8HlqCMoRaPUgII0gEmiSxSNKx/0U/ixZIRJT/bq?=
 =?us-ascii?Q?7BYlXY+8AYhUhCwtw37NY7Ta5O7vkrAh9yuyqJ7Oog8rH1KukqW8yIEQ6lAk?=
 =?us-ascii?Q?CrGGOL2TGLhNQRBP9cYQFsK01s6NNFeisI4VGPq2xeky54wUbBh0hCuw9ZyW?=
 =?us-ascii?Q?6MLAn++U9qItpb9wf0UTCVSg7TK563aNSADgT9VNxQ+3plSLNxNeGpPnFQgx?=
 =?us-ascii?Q?P9rbaHSYr/+EK2E1GP7HayHXcpguEbsd1Tqf4d6a2xnp67htIt1r/kU9XgaS?=
 =?us-ascii?Q?lfxX5ekjOs4PYfIt2cUSk+U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZnrsaWZl60a7whbkKEbXp4pn7jvz3OcLp9AD6w1+YeFTRIDhwwn91tW2Pdm9?=
 =?us-ascii?Q?zdasfNnh1Aqebec74aHdVWyHpVE6v75ytnsIbpLVi1BF8z9YCr4s8oXPTIvY?=
 =?us-ascii?Q?afnUjJ0Jvs5sFlra2/u/lof7u24DUSTAT6oDdrAq/QOtQv4sBPosI4U92zbD?=
 =?us-ascii?Q?cUJddlWybhSXhvwqDr0phC9SLZ+edO6COFhvbU/j8qhC/Pk3CmTTWnoAbTg0?=
 =?us-ascii?Q?n5DrlHFk+SMAhagSc0xqNE/oaANgSbSd22sNjFaHwY5mjyi8XMeh5UNBR6hX?=
 =?us-ascii?Q?SaapdezNxsMQm8StYwCv7lpj157Ig2mEFvoBQbikCeQMLYalKf0PZtiOPG7J?=
 =?us-ascii?Q?h62Clwby8yCWr2+E3xZA3TXLqlG0He15EYHBixNMDlFbHkOrCW38tO2q7RLs?=
 =?us-ascii?Q?EN0ywh1VC4SVHjjl73Jgc0nbsQMDjmMyc9tG8zrJXfp6UEV+dtQNMs9Lhlh4?=
 =?us-ascii?Q?FXqG4uHsqyrG1FKPN4T7q2Iq52RSrP+mHgkicrVy1MmwpeEtb/acfClcaB0B?=
 =?us-ascii?Q?9HL6sAe8HS40reRQK5FuCZQgE8fgNCOfNRvs2oJr7waimgSNHBOdODinCs9L?=
 =?us-ascii?Q?2APciYvG4n3rEWCjb3WNVmWB491ja4wi+WFvnqy2UmqIMgOMx1pO7axUipR+?=
 =?us-ascii?Q?QXkSg59uRzvkpRDMkJBJEgTRYNc8BiWRtheVKnnsLtO3ALMJVzwJuEVWmNDF?=
 =?us-ascii?Q?urPP2v30KWEa4OVpVf99DHZ5GBQQ5dvnz9b5Q+IIL0q55It3wWUXLqcUfne4?=
 =?us-ascii?Q?QALQv6jH4kXa564GHuQuu73pLu+8Ik/EFGSJ9ITHXrj63OF9K+RNxMS1JamJ?=
 =?us-ascii?Q?1z5u4bQw6NqjZSBxOcDrWZPOv7F7+XpVCoMupkjpYETNQqP5bSg1HWLkwERp?=
 =?us-ascii?Q?FUOTJd/4ebT5X97TpuTev0fmdk0Xj8N2olARD3wI/xmCkmy0Mwn3kasr+oUQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a103e8-25ce-4034-c830-08dbb0b42390
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:39:54.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l7MSYLfH2/hXShUKxSj6a/VW2pE9ksOzcM1MIPWBRECwpZ9nDdEyD48e/EVYU3lTsTjmXSvqE68e70FXVFy/kBrW4KC+FZsR0omfiESR20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080197
X-Proofpoint-GUID: silJ_PINSYC9QgqbQEYKZn1Koaj0RisT
X-Proofpoint-ORIG-GUID: silJ_PINSYC9QgqbQEYKZn1Koaj0RisT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently root can dynamically update the blacklist keyring if the hash
being added is signed and vouched for by the builtin trusted keyring.
Currently keys in the secondary trusted keyring can not be used.

Keys within the secondary trusted keyring carry the same capabilities as
the builtin trusted keyring.  Relax the current restriction for updating
the .blacklist keyring and allow the secondary to also be referenced as
a trust source.  Since the machine keyring is linked to the secondary
trusted keyring, any key within it may also be used.

An example use case for this is IMA appraisal.  Now that IMA both
references the blacklist keyring and allows the machine owner to add
custom IMA CA certs via the machine keyring, this adds the additional
capability for the machine owner to also do revocations on a running
system.

IMA appraisal usage example to add a revocation for /usr/foo:

sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt

openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
       -signer machine-certificate.pem -noattr -binary -outform DER \
       -out hash.p7s

keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/Kconfig     | 2 +-
 certs/blacklist.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 1f109b070877..23dc87c52aff 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -134,7 +134,7 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
 	depends on SYSTEM_DATA_VERIFICATION
 	help
 	  If set, provide the ability to load new blacklist keys at run time if
-	  they are signed and vouched by a certificate from the builtin trusted
+	  they are signed and vouched by a certificate from the secondary trusted
 	  keyring.  The PKCS#7 signature of the description is set in the key
 	  payload.  Blacklist keys cannot be removed.
 
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..0b346048ae2d 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -102,12 +102,12 @@ static int blacklist_key_instantiate(struct key *key,
 
 #ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
 	/*
-	 * Verifies the description's PKCS#7 signature against the builtin
+	 * Verifies the description's PKCS#7 signature against the secondary
 	 * trusted keyring.
 	 */
 	err = verify_pkcs7_signature(key->description,
 			strlen(key->description), prep->data, prep->datalen,
-			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
+			VERIFY_USE_SECONDARY_KEYRING, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
 	if (err)
 		return err;
 #else
-- 
2.39.3

