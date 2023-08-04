Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5F770A6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjHDVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHDVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C254C3B;
        Fri,  4 Aug 2023 14:05:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCeMH003731;
        Fri, 4 Aug 2023 21:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7wKVXLKNhKNORm46zMe4NUJSIkoEzC59bebmmT0YR8s=;
 b=uvVQ5Xv1t/go8kM+ANE3C/irIi8if7UpJvopfGF8pzs/G77bV+4IM1nekyY/IyKNdRBt
 04YuibGwZLdK4RmMjGxosoR328ve/GpNxggIYkVB5CLR8g9cxpOG4Xgybw5YxJ4i4XSW
 Pu1c4HimVo44eEhbW4qm8Aa7XdK0aWMHyjHPjqwqYvyZAiippck7b9J436aoS13/9qvh
 kPjfrguTObHONlS2NrHkJqLTqdNskjOrmwANk3wft15or60ae8YEEWJgIL1xsBsHNxqN
 1SmmDRPxMzOsidx7rciwwYIniz450wO/5oh17n+8at/fFMHok/EkxtrQjzUsDmVx2FCT mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2mqff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374JM7rM011630;
        Fri, 4 Aug 2023 21:04:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2sdmu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPvVxmqFIfIb7g/MF61NeaggLXZnfIxVvPe51kqNLp+P+83FatEbiOCXOnR7RM00NSPv1wbJ+mCl+jaeloc9ryRqQ7Go83pYnWCGehQIUY8s8z8rssc+/VBMKDTP1UyZHb86uVERNGCz2o0jt3T6C4VILJPi3DCaSQNMmQ8RkIg8Lx/w4wmVF8LoczOYGRM+tJ/QM6/5u1wETEwBWTeO2eAb7apFN/lOacEtr4n5rWFoT3jq0Vg7QbDrN9E1efYCwiBan8wVvfZD824dWtrz90way+43YAUvKAJscsPCCkW7s0/u8CWasYO/CbZNT7/cJELNyOdvuW4jF4Sccy/fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wKVXLKNhKNORm46zMe4NUJSIkoEzC59bebmmT0YR8s=;
 b=bYUqyPgLkxkgMfTCBLn5Kibbtzblf0bklfPJPJrPH4y550wgIyYCfzc8NHUaErmEABztTuzlHt0ABHTZE5GdwHCVZ9+gRq48t6uiMbqnu0yBGTdtkHiMim2xFUmo8vKv8Qv4B8s5G55w57mj/VoIWy/jOjm5S6QfLSBD5T2pSYDEPQ/Vct7dBHfSDjqq8ytSOxf/GQbEgZe0N3wqcqIrbqnbKGsapnwqCcvoU81HJ5dK69DKbSupWL9Fvt8oHGEoOLzZPQ7fbiOOgeBg6QmZQKhI7ZYElrBFxH7TEKawDjPhZW0W1/+PvUxBZ5NsZqet6l8dCnscPSabv/jtCPYL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wKVXLKNhKNORm46zMe4NUJSIkoEzC59bebmmT0YR8s=;
 b=RksEj6/7dzY73JGorwmnFzQdHFLkLKBrkQVV5hhxRRIdNIJV0F2lS0XygskNr0wfBRmY/tpRcEB7cB44Ob9m/HmnaYZrYPkKdhi3wwV1u7xGcbkMngfW+8yY7oVO9MZA2Co3+otZLqojHKr/25Oa0x5j8bEgzrtOMffqUSLrGcs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:04:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:07 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v26 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri,  4 Aug 2023 17:03:51 -0400
Message-Id: <20230804210359.8321-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0126.namprd07.prod.outlook.com
 (2603:10b6:5:330::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: f329bfa3-3247-43dc-502d-08db952e577f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGB+Yl/TuY3xFfslbNYQi79rTe6jF21ptMwWfNoxy6MXd5JGBx3X86oVU9aqtWIQF3HXUuhY8xjhi40DxLjZ0YmTJp5x83SdyDaNQ2NpugqvtrDofLupDmeY06UVkF4yl8wh4ubw6qsUBLcAEy+IdhjRQ3pjvJnM4iXrQ7hHfVKdsA1G5IXqshJbyx8gJfPPFr5LdwTA2mstqUVsNQpbJRo7kAPf4tx1KrwwlQ6jJf9Y02sipjNnkQNiSckp/5hoazi+nl+NRdYT6VUAJVTAIJgvQXkgXbBwAHVzz6OGokayzUAuxsAZUHNhGK7zHjtVDfa1zSEaNdfUIgYJcHCqoBLcCsxTtLJFlzGi0suG2fvoWPhLtoLQNbQm0qGif4uQmuFldcORNWubxgxuC2LxdYUOaXS9ubFUv5TYet9Uy4lf8O9zwtYrJb4iFWpXZyU00E//5lpEOkn08APhQz00QDA5LAZUS92BEyD203OWvsHi7vs9mz/tmGaOADtKU/Xmo/YNdM6i3WF7aswh4ajHZ1ESYJm88TmusQBsAjaBxeNu6/Er50z+vXZJ/fX1F1lFdPkEtNSPJEChRKgIJWE8xEx1glR6fJXedG8ZIohQL+a/sNxrEOQ+7KppzqYgChtb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39860400002)(136003)(186006)(451199021)(1800799003)(5660300002)(7416002)(7406005)(4326008)(2906002)(66946007)(66476007)(66556008)(30864003)(316002)(66899021)(8936002)(8676002)(41300700001)(478600001)(86362001)(6666004)(6486002)(6512007)(966005)(921005)(38100700002)(6506007)(1076003)(26005)(2616005)(36756003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHt1DBo54CjhJDIBlt46Rc/qoI6qkKj2l4jECLNzEhG0PuZI0q6yvv/Ebjt5?=
 =?us-ascii?Q?eegcTZjokT6MQQXOV+mvLDxpBOlGRzI1VtSy8OcPZC0KxUlcQxfSZpI53Rdg?=
 =?us-ascii?Q?6F+C5oOamdnfEHkqGsQMElFrBmtYYb4Su+sJtEmK4Y+l8vaM5R3eIeRblMBN?=
 =?us-ascii?Q?QAMgJGrRlqphcj3MjSDC1GSut96wt0IkEciMYyQyIp0+Ky20IyxTrAY5EwPp?=
 =?us-ascii?Q?7mOm9F0O7gEjrx38pQd9cLa62qyAtFCXsD/OXpWIStem3yj6Dg1e0vLZHK3F?=
 =?us-ascii?Q?9vzohsKEhyYTUVKK+9H9XSEAv050jTg6WQeoeUEJrpjr89OmDybHeHL1Le67?=
 =?us-ascii?Q?c9hcwfrb1CJK18zIrGaOdYaUqDWXrJJDrzzqwYKdbeuTINjrpyVTR8iqj5tp?=
 =?us-ascii?Q?Am1sscKB8xK1Qi6tU7rN1RQK6NllS9N8mVUjnhPuFujeqq4TU/UH/FbcHESc?=
 =?us-ascii?Q?NiKFqborcTi0XlMUN/XxjhRlky/Rna0H9nA9YLKmAr/HR7TyeKfcE5R2KaZZ?=
 =?us-ascii?Q?PDHKYmeEHEyDc1rNb0erYRr2quoVuX6I9Oaq25V+Ih8r+GdiVO42oyyx32Rc?=
 =?us-ascii?Q?BnmK6j1N80tBAoKURxZUOuIdwFiGUFXX32lr+bEZT+xtdhNzXkLRA2+8FI0B?=
 =?us-ascii?Q?R+zlXiuGtW/UKaRpLq9WcKgsKzcbk+jUsigmZIGN1YPM8CNcOTDAaNp32Ifn?=
 =?us-ascii?Q?OVdws4P4sbdXvS3zBrK7GGhcAelcSK61l64ndSzUYKHxtTc2U+Uy7iEVBmOi?=
 =?us-ascii?Q?3S1E5pQlkMbxtVXfmBaGplC1BhrjJ/YCApwcwlQXN2d4mHUmm0wp1aNfrsS/?=
 =?us-ascii?Q?taEOMcwJmkVMQJB1HLshVn2ByB3sZGvq3TGjy6IQ4SpgIYYaMgBfvVMH+sye?=
 =?us-ascii?Q?nBOCiNpZZfR8i9WQSUfYNL9YtzssbN9qEMopfe+xF+Vqwm0xroAIFgute/zM?=
 =?us-ascii?Q?TyjrtpyiWIzG4I8zso3p4zBph8gC5fKRz1vItxnoL2j8EdFrsMXlPOmP/5wp?=
 =?us-ascii?Q?vfbrJEjYXyszqctFH+Z5Vw1VcElHZk37azuwcjsuStq/YHLkHxSi8nFHS0qi?=
 =?us-ascii?Q?1AIHnzSTnYVZ9jL80h/fuwAuYjdipgNfY6nbuNlrSXEHhQT4RjhIIKvk6p5a?=
 =?us-ascii?Q?FJKkbzv3kBa6PUaKDM4QQWK2GvZ2LmvkCmthkSeMIOEHasTdLB6VOw4Dh1v7?=
 =?us-ascii?Q?FXLOKpDsJ5by9iesf+YongIkRoNr/+jDiAzKnSekYsMqmfAd3bZ2MTG9Ix9m?=
 =?us-ascii?Q?Q6LOfeJA2tFPsnn+6Tc+NHqWcM3WXQj5t5vDkcHg8z9JznhWUjyb973PVzNN?=
 =?us-ascii?Q?8emPw6yLVGjAdL8fxf3BYZS/43h8m3ShudObe0hIeoOKwWl5gSplRu7O4Rci?=
 =?us-ascii?Q?vqz6b06Ym5HP1M9FzFW8FtUZVLXsa4goSJNxc9/4uWa7V8CRDwfxpqkK2xpW?=
 =?us-ascii?Q?4X2/+b9zi7CtlePrAhI2yFLbKpv1Kw0/GGzevC7GTmENStflRTe3x/oP5H9D?=
 =?us-ascii?Q?KRIsXy44qde77UZhr92+uBO9w6BlagN5lPT/1LD2V5r9bYrumzjnZKQVL0X+?=
 =?us-ascii?Q?dXqRF8qGxGtpOjN9lihlpqb5IzzHfH/vWwrZAYiA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4DI5HYocImmRoynitwQz8DHw+hqKKOUaysfoQXcvoWQuAgGM3r8EJ44Z5ltF?=
 =?us-ascii?Q?YvAHMC8x71rBetoNqvbrbFeX2ijZ0S56Beu42KebxrqcFVjV2I59ksUDWKzx?=
 =?us-ascii?Q?2ueZ4EOAmH5DcKfZqikS31AWF4rqghHBzX8QfjHbdHdKcBqhAArwUd+nPg1Y?=
 =?us-ascii?Q?gI6RYhJpUQoX87ehnbR5JaIl0XUJWzxqVLbmQKfIDsZmwm7TqwQfNHtTXofb?=
 =?us-ascii?Q?X+pCV1DNJK2AFM5lPm6plChcZ0FHFzzXKhbPdIfAT6KuoC08K0LKYWGMBnLp?=
 =?us-ascii?Q?bjTUeuu6NcRDc3VjqAxg+/5NZ/MgN0zNs30qY29BKxQzHXu4WPQd8o8rpyuy?=
 =?us-ascii?Q?KoCZstvSXA31Gj3Ku0eroS4n8Zm81vfebblooTgxWpghcOFHu6ticps2AYTL?=
 =?us-ascii?Q?SAEgW5veJa6C5IBpJxa9VakfFDfnPL4AGrkSuMt1ZO2qcwkuDpHxp9rdXziZ?=
 =?us-ascii?Q?Rm0JD/yZo6Lo06JH5BlxoJ5r/dUI1oNGL/1NdE8RUnYjuLGa+E0KdAxMLq1s?=
 =?us-ascii?Q?KXFR1tWqsEwnIhQWRzqLBXAYJDlCQYl4S0F8jCijw7+4Yj5J3TUx/jBso5mP?=
 =?us-ascii?Q?segmYJF5lqqHbvqOgt4yIea/vaBSYMneG8aQT4bM1saPe/NmcLW73hPjFvXU?=
 =?us-ascii?Q?yJtlfOxoMYoU1SP2hdpsZwH15vD/dFcBWx8jhdiTwwygpn9KvIwAz+ZLba5P?=
 =?us-ascii?Q?c14CZO7CKmtlzl/mKwalYtzz/LPz49D1vj/Q7daoOHUUKqi4qgmcYH8Ra53e?=
 =?us-ascii?Q?YhiM/leaDmeVEL9J5K3tyrinJQM4MFWgYaBBm1CAaewNsnos8W0DMIxHA2Ba?=
 =?us-ascii?Q?H7pImYLxCh0o3lBc+EsUPhSYmEujmTNGZwIp7rg7O7kG4g7qFRBWVxYYHbNO?=
 =?us-ascii?Q?/y7/swnrtqJIKCfKE7aBZpfp317aZDkNEYtlTxNQGHBDkr4/neYCFF4IDGvA?=
 =?us-ascii?Q?TlMRuE00MDJ4c8+jkY+c86qBi4MDfJXTJ8ZJuBdPJcS1MS2HcuMycaD2J5NE?=
 =?us-ascii?Q?YHoHQphT5tv14RVODoXIp2kVDqyAj8J2Y6EbJWHTwAkXEPe2VsD5ZcVJ4Iag?=
 =?us-ascii?Q?G01yjl8ds6F+D8xJgqlqQKx0+moTi9TKyvolwUbtBy/yL6OmYaqgZihRO0AE?=
 =?us-ascii?Q?Qn4GjSVZGe8sSNS6HEiDZGoViUSRV8cSwRPN8ygplcuOGwdXQKg13DDf2ce4?=
 =?us-ascii?Q?hZc1DrHVntfCrAFTJ0rKYNP0rA0hG1b6aECKtZstDXeCyF6kVvbpjSA0CVr0?=
 =?us-ascii?Q?fYrm0Cate8DUJVlNn/nB66hncoelaFzWoe78fFq4kcuPW5+ydtVuqWqb/iKD?=
 =?us-ascii?Q?aPN09oM2TgfSaRXSohs8py7u9hvqUtvWW2OZ5nR5lCQYmVyvtbEtpCoMrXKQ?=
 =?us-ascii?Q?wQergOIpFtaaAy2tbDHF4Phsn97ZkbkjvGP9I17aYaGPhIMkWQYPf3pJxeb/?=
 =?us-ascii?Q?I/psBfiuXNY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f329bfa3-3247-43dc-502d-08db952e577f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:07.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K1SLy/SVqvXVJJPJcsuhZh6kf35CdN/WT5eYA/i2n3FQf+I6GrWF5CifJDOh7JPWNT07aAyxcB/dZwUGjQ3aSeKjtBELQP8ZuqtCAyeBds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-ORIG-GUID: mOX92VTfdqMVBtaErKfRoPLYrJuXHT53
X-Proofpoint-GUID: mOX92VTfdqMVBtaErKfRoPLYrJuXHT53
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v26: 4aug2023
 - Rebased onto 6.5.0-rc4
 - Dropped the refactor of files drivers/base/cpu|memory.c as unrelated
   to this series.
 - Minor corrections to documentation, per Randy Dunlap and GregKH.

v25: 29jun2023
 https://lore.kernel.org/lkml/20230629192119.6613-1-eric.devolder@oracle.com/
 - Properly applied IS_ENABLED() to the function bodies of callbacks
   in drivers/base/cpu|memory.c.
 - Re-ran compile and run-time testing of the impacted attributes for
   both enabled and not enabled config settings.

v24: 28jun2023
 https://lore.kernel.org/lkml/20230628185215.40707-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0
 - Included Documentation/ABI/testing entries for the new sysfs
   crash_hotplug attributes, per Greg Kroah-Hartman.
 - Refactored drivers/base/cpu|memory.c to use the .is_visible()
   method for attributes, per Greg Kroah-Hartman.
 - Retained all existing Acks and RBs as the few changes as a result
   of Greg's requests were trivial.

v23: 12jun2023
 https://lore.kernel.org/lkml/20230612210712.683175-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 NOTE: s/vmcoreinfo/elfcorehdr/g
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../ABI/testing/sysfs-devices-memory          |   8 +
 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 140 ++++++-
 drivers/base/cpu.c                            |  13 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  35 ++
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 18 files changed, 700 insertions(+), 205 deletions(-)

-- 
2.31.1

