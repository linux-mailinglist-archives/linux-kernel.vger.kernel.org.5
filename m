Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB9770A64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHDVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHDVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168864EC1;
        Fri,  4 Aug 2023 14:05:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCoKK014556;
        Fri, 4 Aug 2023 21:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=YiE3bI9CczOXY+M3tBrHxgK+Wi4/BsWUxmlu48+lBQQ=;
 b=tPy25h9KfkChmByvNca3MlmxpO15xnk4ls1A3h04GHHSRQ1mxgaBH/DHddKnsVXuLTqJ
 Qp+l22cjikpGEOZ8XOeftB9kBNDlj+uUtw+OhFYxnBRciPHRv+6XD67EinqZDEi/ZGcr
 Mt017xkunAqbWhWT75VTNuTIPCeN3RGvP6WtWrbFp9KntWSxonA9SQu8GP1U3nrtEEV2
 uURow7/Bk2OS1q27WTYP8lUyuxseVdqMjyUe97k5JKjeJubcvp83RhfzItxDFPA4h154
 BZArO+dQx5PNjZ6kbI9Y0+3XkMD4oU9BBLGawWY/dUQPKkvknxDXL/AoJ/2Nvnvo/Za7 /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spccr8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374Krtms040728;
        Fri, 4 Aug 2023 21:04:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kpkxn93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVavxDtMRxh6HSqEELlC2rYhO3SMaKFSOAu0/YghrCfY9SBGGJxNGlJvrU4I8Cuh1t4ofntp7wDaXRlg1wJ/fscOwo6CHdQktAbcBwYFPHH91BGvbkAST9AkquNC0n9MQqW4nnhlyz3DH12LQIay7XHDvuHvXEG8CmyD61FBiLip2w9V9wERkWt6uRUN5f0zjLT44q1sh2HQAAs81mF6kehDEaqSMqc5aOPEFNs1cvVsXk0L5UvwUgZlaLN27g5V/epSvFJSBoG6+EzbE3UbGAdK+JZEwYdI3zkylHbcI/9Rr9L2hfVXaMI88BE+K4GFaRW2ekCQ5LUb852kcvcliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiE3bI9CczOXY+M3tBrHxgK+Wi4/BsWUxmlu48+lBQQ=;
 b=WTBjytTkTUDZ79uOBhZY7VJFCdRIWyPxbgi3i5wGrk2wI1uyJHFcuCEK6a/hS1onT2uiggfX+OpdACdfMjvYrEmG8BsJNUZ16JNdK8E+HV6hzlnQiEhz67iSZsxkcZipxVn4uo6+HxM6sROE1EoMVoA+SpVA7Kjn/OJ9geai+SWImqFKoxLAuYm0aMZFqwInSj3oyjf4Z5gtbU2AZwYaaF99mcIpe98lRAklmcLtTU6LFIq5gK+XGSWYeaxRBiH/CwtKjdhSBYBndMtQmZD/XDb9kwcH/G/TavoC0cD9OvSXbyy0UX4ch2jGZnNLD12w4sH1xF0UnUCewjSJEwTZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiE3bI9CczOXY+M3tBrHxgK+Wi4/BsWUxmlu48+lBQQ=;
 b=sFDbLxQq9uAB5PHChPAkp1q7DWddYfGyrZmDbEd5FgUhv2Fsru7tjOQrytOa/clOYUiTCrqMlWt+b5MJWEhNiLPaxV8LGil++57mJ/OtDpChuo17LKYLOMtXqgxjbVCyexm5TVI7zM2/DTuJdM/ikajcUU6JBJ/fMnNLsOsKIfo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:04:21 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:21 +0000
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
Subject: [PATCH v26 5/8] x86/crash: add x86 crash hotplug support
Date:   Fri,  4 Aug 2023 17:03:56 -0400
Message-Id: <20230804210359.8321-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:5:54::44) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: c5acc9e5-85c6-416a-6f59-08db952e6004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Auab/AYjdOdGoRc7CkEbSSsExBpZU3M3hofDIt2I/DTlL2Z2mjPULop2N7/qqoh7gxBCMO88e05+VGh8KkzX/aSV9KJm1Jt4fpbfC06lwEwF59C6X0j8WZnNoJ/Gv+SX84yzEwx6d1xgJK+5vhdHiMlwCTbAV04WpYMzETaTmIGcDEeAeWwbyAWFKjGjHXhjmNKEaqAhlwTstpzmdcsTYlphLHUjEM3Z2qLsWat2UIZfypFX2C532mZKsKFgt7SEffKbIGFu5i8hIicZqcMy5PE+nwokcozy1tPkudCO3RMp3Z2oTcA67Nvo9AMYJ3UgAjjKDr0PaVcqcVRp4UvjJc6DgNEXHpsXU1YKY1r6/eBtK6kwIODnLUKub8ao+3bgSXsYVQvRTiPwtBz2bgrMmZvOjVcbfXkV0zqGPvqB8w/iJ40K67ZjGwwb27RX97CnXDtcdwYNBSxr0EhfQo2S4ll7o/KP4LkBW0KOhEHwQovT6VN4FbIEa/GBU7BRHHErZgLmYgO0izr/kNOUOaor5UldVz0VKXpfnuxLy+uppYLJIyDFegnUSzuDsEzr2a9OQBkzTocdHiBbqvE68f5Y7Bq5nBN/B3D1zzx2nZgD8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(1076003)(2616005)(107886003)(26005)(83380400001)(6506007)(8936002)(41300700001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(316002)(8676002)(6486002)(6666004)(6512007)(7416002)(7406005)(478600001)(921005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGHzJj8RKi+Ek2nbKQXoOfyndOJCc7CKSiEZQe7YK3TEzfAOQ23wbYZUBQvW?=
 =?us-ascii?Q?PzMkw8R9A42iLQGAxBMwqc1PNZfb3SGSardfmPkM9AA4JYzOh8vymnocGh0H?=
 =?us-ascii?Q?6ML2+H+dEJtb9Ud2Kks4+NmVvcqu51XZGpleUYpGfO1AHHZClj8ss1WYWekm?=
 =?us-ascii?Q?O6QO67MlBdf9s508E4iCcQJk0svJE5W9OUOtyqMDSH82jgn1izY2unhaM/GR?=
 =?us-ascii?Q?cmgKf9d7cT6ZhniP/3bY8WkCAtKVFcb9kni4gyWTp2zpH47ivZ9OSduNrH7s?=
 =?us-ascii?Q?3U4NQFv3kp/kQdLSukJCVvSgy8hUkOXzzcoGCX7K4Q6LFET8TVvSAVMSo7Fd?=
 =?us-ascii?Q?neD570Nu135MXi55UOXjzXLjRSg6OsSfzoBBbtOXjL8rG/PGzP2AQ9tDN2Is?=
 =?us-ascii?Q?ugBeXodZvPpgk3qWpPDpE0uTuxeSIXPbYmwBaL3Q3socHBAFf3kbjssiERs9?=
 =?us-ascii?Q?dYCAijrRYIlUas+0eJe3PAlvUFtboZGxt8Sy25LLsrHAMtUd//tD9KOBXjCA?=
 =?us-ascii?Q?lcHWGk7n9nn6/YjheZRym2MXrJrJcisPXfK2O9oaBAhkrGSYh5IJImD90DqK?=
 =?us-ascii?Q?b+K9kI9jlflfkNDmhSIPfASQGy1YnRBR8OwEjO6lZDUJBvTo+de5AjG7symc?=
 =?us-ascii?Q?0nncF3kUfXrNHrl90Z2Hwhru0vEAiJhVOgc4pe5gmcROWL3mILZcFEjlr6vV?=
 =?us-ascii?Q?+8z5X1B0D6pqyShZukOBNTijodkAXFaDc5b05TdQKf4z/IykWLq5XzLRLG8I?=
 =?us-ascii?Q?pfDsKpiXCv8GlRZzT0a2kwGUIXbItNsEnq/qmR/xtA8KhwG/1beIJWwU3hNw?=
 =?us-ascii?Q?CX8fwmYb+zSnxwyF4c+lpEnxhLOBRkVqh8IgCh23NRWG0Z2z6K3Mh/mkGgyf?=
 =?us-ascii?Q?1pAPSXvdkW5j4NdlY0KWp+nHEEYZvL/kwElAvnQUpisKUSuhFK6WBMzNWsF1?=
 =?us-ascii?Q?rSPMP9ieUDOPnLMw7e8E9SkUhlGVwEECedLKJe8zmCX67d0s1lX4v+K7jgUu?=
 =?us-ascii?Q?R9nechAVbNZnqIFDqVtki8/WJ+zEmuy+Fi2afPRekZVHUr+yxT+5HIsxkC6l?=
 =?us-ascii?Q?CuihbA15RGCAg2M6oY0QPmuTYg7reg/5trT0QxTPKyUqQmdW/ia/ue3h3UEP?=
 =?us-ascii?Q?mK9h0Izb6/hpDU4j77CcaCME4Ifb2nRm7JZjkoEUP+DR58I/Vbnv9bo+gqWx?=
 =?us-ascii?Q?5pSzMYJknos63iPTFSbo+MWVDUj57GNDIaPCcJUiSQqjJ5vepKfoXq3Lbjok?=
 =?us-ascii?Q?Ro4d3XiEaPSnjYfq/ngLBLbsnOTOX19fWsyTpyQvq1ljKDiyMQcZz2PZD+jQ?=
 =?us-ascii?Q?AOuhChc5QaVsLAHW3gIhTsefewXjeSzpDEnlwSBuw7A5W6BLo8ye/L8yeRaU?=
 =?us-ascii?Q?RHUXktST28gRexUgchFQirHFfMDBAnzPICqRDjndm6TdLjfWs5mV47NpaxZk?=
 =?us-ascii?Q?TidwGKCTxE+iNehyrC7NqtZIRFVjYUsgw8UNxQBEQs+45powwIe16lRwc9TJ?=
 =?us-ascii?Q?mznDEjANWhY/WphnDsSkaP+txRIMM8hPwyTj1CC8JBSeTwDETVxChZEP9kcT?=
 =?us-ascii?Q?Y1Roe3lIN3Kj0nho2Sg6PZzRBDknYLteq3xbv1I8+9i0WlT/EvZuipHdGDKH?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s5TSNR6JEkdI+VGZkddEQkmr7eDj+C2fHQ5kyyXBNcpiuv4fFsbmUoqzUxGz?=
 =?us-ascii?Q?kRSlKX9R4k6lCdzCDHdbTogNB5jstcazuEpTEv0HEc4dk8MpWrNNc+jQo3oI?=
 =?us-ascii?Q?QIOBXZaNxD5cXldzR5g0bW47hIZCNoNx+frExy0KQtZYAu9bM+0eRxj3CBB2?=
 =?us-ascii?Q?5N2/s8Ioto6c5NQMYNz7v/r5oxySo3e6pCq+tjRX6afS//7QInIxZOgjFQzf?=
 =?us-ascii?Q?T/tMEH9JzgUtadTqwkkYbhCR8bJJ7tSNMRaveAxvTfYkr1gOFjfuBu5L4F/b?=
 =?us-ascii?Q?vYyot+WOorYFpmeLKz6tLwo4I+lQJGoocngzJ2R25X++VtF8Xl63h1ozpFht?=
 =?us-ascii?Q?AQeTJRa/plBcOWbySMbd0jswi0YLMHlhQ6Nn6biWN44MCxEPcap0Ji4oKMyL?=
 =?us-ascii?Q?yn1RWM/G2OzkxjfH4vqahr55b/5q8SFl/FC3OXD0fk5XQOjbuDveyNQnjMmq?=
 =?us-ascii?Q?X/nC/D+u+SKTAh/cYrbfdxO5ny/xJu4jsrx1aCpIrSAYTIDV5mPv0BOwv8XB?=
 =?us-ascii?Q?dT0RcWp/4QW5h7G964cRwXVXAA0JjhP1g7eisgHxNXVPZsMdcg0FR+Ebp8K5?=
 =?us-ascii?Q?kiIelYguPrNjLSSr9rHbqU6hE8giQteVSjlNbd18qPcqJtSbfxU3pj7CL28j?=
 =?us-ascii?Q?Zrvlm2yMT/+2CYRppG7zCBQOV5QMl54rPrAq0R1BHp3LbviV19EYwZQCmJJA?=
 =?us-ascii?Q?01Qt3ROn5FpclRCWL3Yt9sX21QqXInpWpZOpC1ObekEuAnSytD2bUJh/gahu?=
 =?us-ascii?Q?ER47mxC9zgoNjyLimDelRMIV25+gr3xmCvRUzXVJLFZ+X4KVUtOTCDOnVWZs?=
 =?us-ascii?Q?Ins4bH73cMyuCFege1S8Dr2K8M2E5IgxsRICuxdAJAaBFyRVWGRC/lYddyro?=
 =?us-ascii?Q?1hHvlpWJT1mVf0LERFcYqkSQq4RzNBS6C0Nsx2tvlOi+09R+VmD1M/V0nvVs?=
 =?us-ascii?Q?rtkDdEDDdqkakooQ/KXjMvLpwsnLkNBUHrjsUKfIUI2DelPx8gl5yMUzlzzB?=
 =?us-ascii?Q?D4h8/ckvwBA7xkUr6rZgd5k0MgbsDXI8JY+SpSSLqTdk3Q3GE/hfyIrJq67s?=
 =?us-ascii?Q?vua7aaFMi66/FIi27tGyh7KFtrGqZvhqOkeRF0OOdKfB9qv7VW5zA48lwuVr?=
 =?us-ascii?Q?hrAXjApeyy0AbAOW29TME2QXI0wHctqpAjbJrbKxUtpMbRo7nawI8Go6JryA?=
 =?us-ascii?Q?09KSiibpIzy2vVqOAYV51dpdSDnUen1B681ZyM7Dg9JRNU40fUj0uVvgrwiH?=
 =?us-ascii?Q?DVNPvjJqhU74USCzkZz693O6mBmWNg4deYju4SVsfMIOHEOyDDGV207LZuVP?=
 =?us-ascii?Q?L2jJ15ed1P/A41NEFJ8i0I7yYiKiDyX8KulZi3Bloh4bwqcYN3BqJJX/Y4wP?=
 =?us-ascii?Q?WL6S8s4j4ff3CE1KS2GZQc+h9hQupYiI4Cv3eX4JynqqISoV3NLAtps2TEFu?=
 =?us-ascii?Q?xfFRx1hI36k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5acc9e5-85c6-416a-6f59-08db952e6004
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:21.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DTLKg8dojH0AIACMtGh6PVQ7lykOurKALbXySRTiLmzPQpT6rVRND0tr9BsHv19/PDMFtxsCxyUSepMssDr3Znbs9sotwqbOq3dMLzFuSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-ORIG-GUID: lee-4678h3AU203rQftC-TcooF9Xd6ey
X-Proofpoint-GUID: lee-4678h3AU203rQftC-TcooF9Xd6ey
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
and replaces the existing elfcorehdr. The segment containing the
elfcorehdr is identified at run-time in
crash_core:crash_handle_hotplug_event().

No modifications to purgatory (see 'kexec: exclude elfcorehdr
from the segment digest') or boot_params (as the elfcorehdr=
capture kernel command line parameter pointer remains unchanged
and correct) are needed, just elfcorehdr.

For kexec_file_load(), the elfcorehdr segment size is based on
NR_CPUS and CRASH_MAX_MEMORY_RANGES in order to accommodate a
growing number of CPU and memory resources.

For kexec_load(), the userspace kexec utility needs to size the
elfcorehdr segment in the same/similar manner.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, prepare_elf_headers() and
dependents are moved outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 103 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fedc6dddd743..d9fc80b9ef84 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2069,6 +2069,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..c70a111c44fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +229,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +247,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +258,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +373,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
+	 * maximum CPUs and maximum memory ranges.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +421,66 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

