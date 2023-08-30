Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACF878E158
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbjH3VWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbjH3VWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:22:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DFBE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:22:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInXRW032362;
        Wed, 30 Aug 2023 18:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hk33vgDddTabMGLcd8V8QAslNep2bYD+vzm1FUsH/n4=;
 b=SpCEOU6TcEc269289HEcDZgbfCF0wHUliDxcFSHkDFlyd7Y5oYH3GCvMyESj5adOHxeY
 j1BG/6+XBhYIOzs555TmkkxrNE4D2FacYvKnjPXx6UkUtTC87KvPob1xYh2NY5yfDEMJ
 Jmit+GgkqcXnqY5gJcofivbjI4ldMa0OH8a/uFXvTeru5dtnkpmWqOvR/oK7AhJFj9lb
 oLVWmLoqiJY7PmLpQO1ciq0sitW4e9IeyIazC7QM3WVGh2i38F5U72Ffx/k8xwWWkv/k
 pLkhVMMcBfnK7GxFbyq8LVkq9c/CoMpejtz7ZinsL5d5TraD+SDxwgI7adyqe2BNj/Ok Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k686b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIJHaC009143;
        Wed, 30 Aug 2023 18:50:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepyapk3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+6aOJP5dhQzl2BPX33TzPwwIAJintGXJgBxkWTDEV5XYkzY0DBGU1GaLPRwnEBE8egfuI2WecZ6XdWp9QLURnbFljetgNWb24lP2QDZTeYImyAnIoA4HERNHLjrxHo/wEJ84rr1iugvDiG9KN1v4PU6UcpjicxdxhRKlPZBkb3q4jfgCO4Kpe8rQGxhV50MOrexPgv4RqEigVYnuoqEmn9QnFnn54oataDhgpvLrv4eqzRkuMleSXmu23H1FFgltX9fqOmzzQ2LbiVk8aii95e5c3pXKP28/V91HhENUGxf1XrWfqqDDOwNDrp+8kxMVwdfgOUP3ilVVc4kDt6Jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk33vgDddTabMGLcd8V8QAslNep2bYD+vzm1FUsH/n4=;
 b=lCQLaB1h1fsZHcvJ1ASeshvGHOXknb34UftQbWrFcLx+bg1hu5hdwl34e6MXrCxhy9A2qQ5S3f9WrZHsVKmaslF8i8B4iUWi06p+2c2mofPzEgbN/AsNjHFVgG+ky1BbROq/BOR5mGKpIu52ow9h08Z3eeSszVE+Ut3m+lbGtc/q+Nqulb7ICqEGr1xYboZ58N2uOqTbCzgZ25hdzdUAuAwC4GTC0ouqOm30UCI+TquKNTtoEiMDkti3u86iGZWVWr5eYU9D9W+T0A0UmKbntXZNDdihdYhl4C+YHTN9qqoJLft0NUx0d0GXDxQag3myjCTA7HNJsDogUDU2i5long==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk33vgDddTabMGLcd8V8QAslNep2bYD+vzm1FUsH/n4=;
 b=x2TmEqvpQfG5gThHqUWqHmUL1c9FNdzao25uNhKTZjZrzEDLG/KZHOSFpG5zqZDThgm3TdtqAnGE3scotGHzb4L0tnisXIx8WJi39DL3WMohRw30za0viCtX0pXXma7Bto2TzVet4k1RAOsffJ2K5FhvMqSBOFmiGqEEdDL3X3o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:10 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 3/9] mm/huge_page: cleanup clear_/copy_subpage()
Date:   Wed, 30 Aug 2023 11:49:52 -0700
Message-Id: <20230830184958.2333078-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c370bb3-20f2-41f2-ca1d-08dba989efa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8CoWdwka9GKhJuUJpgCFHLAEUgkPTGWZKcdHZvoe9LaHTSqTCjzt2r+exZ6zBCnZBMeQaizSduoDNgLv7bbBbNopT2Byr1z9NKjzhYWDEpFA3DxanpBO7HjtQwPtWVS84T8EpaXoqUkMsmEYvhQYrmLItF9bjaniDoxEqHj5lo8D5P+5DDa5CjR7mtXJIjAOrThrY/EOnBvxkMeo7O1aN15a9blR6Ohp3nQzXbpWHfmVPRlz6U91ZWddu+hR5/zVYz5lSvWcvoHJr62qZjWipJ+7RRbKsA5CjsWJ/rgJhVc1xZNQaKhzggRKKUHBqIeQQbGKshdlv4TEi2HbTMOp6c2Nd66iOEYjp6ormEmXAYchWhTeLbtS6Ivj0UT1pCt/BnBpynnpLuNTj/aRlawSyIAB6qPsSNZOj8ZXxMhxaoMggKi7G4XtpLRn63Fv++JX6XX7CzQ/E3jGNg90MlMDypmtHOu6ZUjkC6/xHHel5ph1AgIkCT3vfJc1G3TaikXGV8riwRPckAQugtDoErTImgQAa3QycuILPCjufoeD65qho6WsBqlkZNm3YqC9fLd4IrcGXGbCggLPq6TTdvsMvuGrCfFd2DreTlcbqFTZVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(107886003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3D3u1xCvM76a6dgzs/4GfgHr7ZTkz28EjRo6dySGNF1tfPBndiGsPYLiYvy1?=
 =?us-ascii?Q?m9n639nfWgRCs4K2yhDJFKg0PJfxpmPVXMNBew0Vthw5HVqmAaOp7i3JJZND?=
 =?us-ascii?Q?Rm5OLAdolre/QgouryquaYdaCQK0y5TJ78GwQc2NMVT/wVATNFdcOPY5gf34?=
 =?us-ascii?Q?H0hYPWZJiOvNuMP8r96RLn08iZFpSegDwrEsZrSWCmofgRGc+Eq0OyCesKWb?=
 =?us-ascii?Q?2cayiNKYLOUk50TX30fZ9z3aTWWRXtV/F0ip3BYCqbcwW2XM41XD6vqPvPRq?=
 =?us-ascii?Q?wMdjIlXQDBTWDH4bT8G6yPz+6v+yvG+SQoPsMI2geBL7+q7GYCC4KMKksSz7?=
 =?us-ascii?Q?u4i/9byzVWxjgtq2R8i/jW0L4Fjqufq+ONFSLszcd+RKWrFUS/kzpFwY/Z8v?=
 =?us-ascii?Q?EiCo1QL2xqjurfVPkohQYPaCHW+uECKjU3c5BwkUYRqbcfd5PGq5wurKW9sc?=
 =?us-ascii?Q?+e8+V50VNFx/gHySuJAlRtPgEMu0DpnqAMEYfJkOfjjRg0g6q3rQEku4E597?=
 =?us-ascii?Q?RqNioP11YPWaskoPfI3KH/LSLHGj9CPMERhjbZ1vWkNzoDChXt+O/xF0Ag8/?=
 =?us-ascii?Q?DRbs4Eb/keWIvK3x3EF/NQHa6Gg2PT+NiXztWSFBMkALHJseoimUlRayCc+R?=
 =?us-ascii?Q?pcs2N2D+2WI4hg9/SyEyFm3M5/GxVhG/ctRQvc9eANTjt7OOpaKRGlCSf2K3?=
 =?us-ascii?Q?uVMl6asWsSNT69UbY95HuCqW5ExTNP9wi9LgRZwh6YK+km2UR2aKaa+9aSVL?=
 =?us-ascii?Q?7nhuz0brrHWVMUX9/AargbOAz4qxwNjOTs3o4CWkJqt5FkmZQTPPIDKnM1ZA?=
 =?us-ascii?Q?c6Hrwc2bV9EZQTgi/gdGDyw982XrEZVu361tAXtH1HtemtcDioOK3BVFXf91?=
 =?us-ascii?Q?vbxIjlwg7jOaGed0YNMnsVbvVgsWdtrOfMa6230ItERfuKf2cRyMOVtUev7y?=
 =?us-ascii?Q?GuoNznF45RaqBWeq3w4WHhvwK8COTOjLlP0490YRy0ANxWJo24AbF6n6SFSe?=
 =?us-ascii?Q?L3dqyTJFKQGKzhuI5ZvA6eImGIZp4qZWCB8sE6mpxoVN0BtA2jzoNi7mDPKl?=
 =?us-ascii?Q?9vt+Iv2AFt/gb3I5to3FS8uJ7+jjvRMCNNIqM9BLQUfHF+4GTKpfJ2WVWTFg?=
 =?us-ascii?Q?kKxnZ5ugVMbsvTvdU+JXC0Rapc+RGSY2ZgeWR0cyYp7dYQsN1YImdy+QQ2wh?=
 =?us-ascii?Q?tmdiXGiYx/QdljQh4D3Ht2WeibX6ioggfPuTcjfDYJZN//KFZ1/YjO1+wXFN?=
 =?us-ascii?Q?VTVHAv51zkeLOsdR3gIduz6UXbuNyO8imHT9ceZ6QOXWX8DdsIHOQhDEG8B8?=
 =?us-ascii?Q?U3c8jrrKEmS0Px2cGLNLXmjcHdnDijbOSCXtOnWeAX7pl3+NQ6saa8qKVWrW?=
 =?us-ascii?Q?HRsTAF50RFmQ44Lf8SIu+XO1fJDpxEztYlkVupPR4VsgnHr0wSHoh3z3knt8?=
 =?us-ascii?Q?M/SEbPl9FOHE11yNYM3ZCrfZw/YJsqY1rB+PocGNKswH0SsBYUrj2xqgE22a?=
 =?us-ascii?Q?UYjohxg8UeCQxBQZtWopjojOPhEaBb8xhOEp4RyNR7LJDiMHypKKEqvrgVN5?=
 =?us-ascii?Q?Xoh6T5NrHd1ItMjbdFtsl0SrMBMasC/SQjdvKPCE/prRewPw1kELRmPn0NT+?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NvKzZ7L4jWm73LZS93EiXtnkrGxcD264ImOID4rNPFPbLjxYIs1fqaEWXMnZ?=
 =?us-ascii?Q?yGDZ5v/11C/2CiRyZhcVG+5c5JY2D4lgT2zFsKdaeS/WQvg8s7YKwihYcLWc?=
 =?us-ascii?Q?Uy0Sg5rNqfjfqPAJTK9t1GL3aYzCafvVcKtAPKixdBjkm2zMwRYa37msAGGU?=
 =?us-ascii?Q?l0OkXAYVUWatlQ5j0+geoTSlb/rO79lw9oHSFCo98jLcpffGF7oA6S4+BpE0?=
 =?us-ascii?Q?fMj1piKBF/1YjVSU3YvZNCEh75PyGN26KISXa7ktotXRiZ9+umCX6jjBenDE?=
 =?us-ascii?Q?waqpU0t5VauneN80C/ZgG9NpeBPMPhxFnvjrLJ31yu57fAgwfz7/UC3qFhqP?=
 =?us-ascii?Q?h1rvvNb3lxT2qUeyYU/FXFxBG+SJfwdHUmnKnaYuxzVaKrSbcEULUn63GOH+?=
 =?us-ascii?Q?wz0ethYUs8/xGivCvkNzVNGsPwXOLolUWv9DcTlEajKqibW9MqTjzEROvI4W?=
 =?us-ascii?Q?7Fcr2EHES32h2hIZJvWxTHURlOVaKbqFfri024x9HT8e6MEXvx8NEBFKPOml?=
 =?us-ascii?Q?3ITTHINjWoQt45c57DaimZvt2sk5RgYIxm10eFKsNwG0YwRcHdn4y+l7srrK?=
 =?us-ascii?Q?d4ND+kxo8MeCK6/matId9HWRu6eAGFoYMOKKL1zx1rwkhDletV6iE6y5JeoW?=
 =?us-ascii?Q?b/ZRukOgOlwAte0HLV4sEYYQVOrV8ADG1WETo0aqpj3t84lgjOiSpoKezEbT?=
 =?us-ascii?Q?ZlncYTcBh7Kz6z1Zidjrka96PECjIvs3bY2Zs7G+E+WHxZALAO+p3OqNsv4t?=
 =?us-ascii?Q?sGm74Dpfz8IOoEsRqTK+tA7uq15vQuVDqPVryFJ762ZVkcIzPMCYvJzvlj1R?=
 =?us-ascii?Q?zT/o5gvoBsvjMe58QftMAlhx9QXhN8dPKNgbaKVe/VpuvMkuxIsvsdtpdLH9?=
 =?us-ascii?Q?r/VaWLxF7w3nqHlsW0UurRZQyaC9W1xWqLvJJ+9c89v6lNZn0O7w8/he75y+?=
 =?us-ascii?Q?n5q44XAaOG2eU3r33EQuo7qIKi721X36ZWaREJcBDOKJ5knAc7tfu9fqFARE?=
 =?us-ascii?Q?aFB7IHeVGGUrUF58Qs0l6up2c3B473nhZZuyEtANlf1iGfW47SmCmD/l5W7v?=
 =?us-ascii?Q?Y0IheLKQhOczj9+sCSrg2XKbPeQUZic0Rnlm4RGr7wfamKnexHmgVYzoJUcA?=
 =?us-ascii?Q?DlnlhsP/0YKyu4Fum/brmyAMC13344kWVlW0aglbKjVILLoackoIMww=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c370bb3-20f2-41f2-ca1d-08dba989efa2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:10.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBjRkwE0VI9QKHvgvP4zzjSVXNqe9GBGBlJkEhr3zAy/tG79Owh+CgmVQRzKTzgtWPN3C+S+YGcPFjZiJBHplsXuIzprukCHWWNlCo4Y77Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300170
X-Proofpoint-GUID: oNAlS3PA7YW6O0NhswrsjxO3qsP6U2eL
X-Proofpoint-ORIG-GUID: oNAlS3PA7YW6O0NhswrsjxO3qsP6U2eL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_subpage(), copy_subpage():
 static int clear_subpage(unsigned long addr, int idx, void *arg)
 static int copy_subpage(unsigned long addr, int idx, void *arg)

take as parameters: an index, a post indexing virtual address,
and a struct page * (clear_subpage()), or an opaque structure
(copy_subpage()), both of which we would then resolve using the
index.

Fold clear_subpage() back into the caller and cleanup the indexing
for copy_subpage().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 58 +++++++++++++++++------------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6e005b787608..4f1ce3ad0af5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5914,24 +5914,14 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-static int clear_subpage(unsigned long addr, int idx, void *arg)
-{
-	struct page *page = arg;
-
-	clear_user_highpage(page + idx, addr);
-	return 0;
-}
-
 /*
  * Clear subpages of the specified huge page. The target subpage will be
  * processed last to keep its cache lines hot.
  */
-static int __clear_huge_page(
-	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	int (*process_subpage)(unsigned long addr, int idx, void *arg),
-	void *arg)
+static void __clear_huge_page(struct page *page,
+	unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
-	int i, n, base, l, ret;
+	int i, n, base, l;
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
@@ -5945,9 +5935,7 @@ static int __clear_huge_page(
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
-			if (ret)
-				return ret;
+			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5956,9 +5944,7 @@ static int __clear_huge_page(
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
-			if (ret)
-				return ret;
+			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
 		}
 	}
 	/*
@@ -5970,15 +5956,11 @@ static int __clear_huge_page(
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
-		if (ret)
-			return ret;
+		clear_user_highpage(page + left_idx, addr + left_idx * PAGE_SIZE);
+
 		cond_resched();
-		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
-		if (ret)
-			return ret;
+		clear_user_highpage(page + right_idx, addr + right_idx * PAGE_SIZE);
 	}
-	return 0;
 }
 
 __weak void clear_huge_page(struct page *page,
@@ -5993,7 +5975,7 @@ __weak void clear_huge_page(struct page *page,
 		return;
 	}
 
-	__clear_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
+	__clear_huge_page(page, addr_hint, pages_per_huge_page);
 }
 
 static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
@@ -6025,12 +6007,10 @@ struct copy_subpage_arg {
 	struct vm_area_struct *vma;
 };
 
-static int copy_subpage(unsigned long addr, int idx, void *arg)
+static int copy_subpage(struct copy_subpage_arg *copy_arg, unsigned long addr, int idx)
 {
-	struct copy_subpage_arg *copy_arg = arg;
-
 	if (copy_mc_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-				  addr, copy_arg->vma)) {
+				  addr + idx * PAGE_SIZE, copy_arg->vma)) {
 		memory_failure_queue(page_to_pfn(copy_arg->src + idx), 0);
 		return -EHWPOISON;
 	}
@@ -6041,10 +6021,8 @@ static int copy_subpage(unsigned long addr, int idx, void *arg)
  * Copy subpages of the specified huge page. The target subpage will be
  * processed last to keep its cache lines hot.
  */
-static int __copy_huge_page(
-	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	int (*process_subpage)(unsigned long addr, int idx, void *arg),
-	void *arg)
+static int __copy_huge_page(struct copy_subpage_arg *arg,
+	unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
 	int i, n, base, l, ret;
 	unsigned long addr = addr_hint &
@@ -6060,7 +6038,7 @@ static int __copy_huge_page(
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			ret = copy_subpage(arg, addr, i);
 			if (ret)
 				return ret;
 		}
@@ -6071,7 +6049,7 @@ static int __copy_huge_page(
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			ret = copy_subpage(arg, addr, i);
 			if (ret)
 				return ret;
 		}
@@ -6085,11 +6063,11 @@ static int __copy_huge_page(
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		ret = copy_subpage(arg, addr, left_idx);
 		if (ret)
 			return ret;
 		cond_resched();
-		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		ret = copy_subpage(arg, addr, right_idx);
 		if (ret)
 			return ret;
 	}
@@ -6112,7 +6090,7 @@ int copy_user_large_folio(struct folio *dst, struct folio *src,
 		return copy_user_gigantic_page(dst, src, addr, vma,
 					       pages_per_huge_page);
 
-	return __copy_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
+	return __copy_huge_page(&arg, addr_hint, pages_per_huge_page);
 }
 
 long copy_folio_from_user(struct folio *dst_folio,
-- 
2.31.1

