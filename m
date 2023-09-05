Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD8793135
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbjIEVqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjIEVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664541732
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385KnnkX009401;
        Tue, 5 Sep 2023 21:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=Omeu3vW9x4nTdyOqJ2H6+YUj63kgueRXOqd9WWVLTdo=;
 b=f29JHKDgjDVkPaFIdCvqI3EZ3JaxkBFpZ4A8iO5Sl/5KQraP9GYaB8gW4Lb0NfpxtCFC
 13jbaroxShhHUcIm98qvmGqNzvk/Uk21WRUJoqtvKU3igeod9EEr6a/R/MOaMNYdFvGh
 1/7/LZ0eL8xfsecP4vFIAnAHZcHxqkWC+fe+tCVxAZruGgvwlb0wTOg62VXx56pbEUqa
 Wg23q3HIBKsT+kmN+RnMfzuIGqT1PWw+szPVcrFL2pY4wHkrwM8SSxzz6c39M5gceJjD
 Sr0v8iP+Abj+Jh35/ZTaQEoO5A3DHK0nMQCaj6hLOo1ZNK/JBXU8X+DS7dsOAX5HPEtA YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxbq383r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KA9He037099;
        Tue, 5 Sep 2023 21:44:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbkmr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRmD6QouwfIuGzMveQok7t5CtOXPaQ9bREn1i2PVGfNaeqxN70zfT83vrLgoqX6DnYAO+PbVZtz1rB8QiX1a+vVValZBLYRCMDySnQngMMOOaY6gHxNjcjqjcayswY9CB95giNLb5AS30Em7laVft5QDvZawNuc0paJ62uGKzdt5SUwvARE9dfi+tC8mbTWjFBAWZifCSuIVS2nnd293DbM4k5ofncE97kwwGy4jARZ478BdDMyAKvt0MjCO14+no70EaUSHHnyRMQ3vFvKIkVQmvQOy8eh+euuttjS31HJiURSNSzeHzKARu2WUYvAD/1y7GZ8SrfuDF9fMj/xHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omeu3vW9x4nTdyOqJ2H6+YUj63kgueRXOqd9WWVLTdo=;
 b=cwrHwLJkf+Yt+/IwDtkCIyBqovPNvopLRXy4HRRCwbI8k+E0eswBUOxAkRsQllE8Ooqgn43LVkhVL9eD1X7eBGzIJIia1sM2ktfDFiLXAPxLb8GslgB2KG6vTE5OhjHqY1wizV53AlNVV/iwL+n5pAGjZB0Qs6F3NlXuFwjcADS/OQIeEqJ5b9dltS1owV0ziDLNTq27OrhbibNf+DBMsdANSdmT4HqMHtCpg1AhDVEKhdVQT+mChcPIFJXQBxJ8P8YvI/dGnBz9TKmdc0z3n7ClbdRLnp/F3wAzlVA1v7J3oX6TI4RyYRBfUIk2yZWspcMRpHlxUlak35XvwxB6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omeu3vW9x4nTdyOqJ2H6+YUj63kgueRXOqd9WWVLTdo=;
 b=DfIqUJdw2uzlby+5ofvcYl7VOpkovVOwaz5MUwV2tVq7p0p0QWT5deTLNA1J9CWK7+RRPsbjPjJkrx2cANF34nhYIpK41AM3KPQtEGk8xSJicNfuXdo7gtSPqJnMwLQVJrbTDDa+AzfZjyYsBhtMYCHgTPIPpeokHMpSRbnoRD8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:16 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 00/11] Batch hugetlb vmemmap modification operations
Date:   Tue,  5 Sep 2023 14:43:59 -0700
Message-ID: <20230905214412.89152-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 15193abf-7438-4861-1642-08dbae5940a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GsfMIJsS/EN+KaxNcnunEjxIwvTSWzaC90RFFixlEo42Au4bXYRnNz2Jk05n88uWI+utI+xcQM7nq035StAAjgP0gW9IYm6tqur0yh8tO2qOwOI/jhAtUgyOQIGvCD15XsERsciN9ioYU8TRvLAadNmkl322LmQrYDTuRX7RS/1Hrjnty1BRvp0D+nEbaNSl9dbcJcCIkJDxR8qFUemndtQ9esGTyd3QaWCTyH02PCIMLfDuMzYB8vMInwElA7jUSFrTxwzTTbiOkUaW21/NJ/kk5bWiTRQMuwmbKoWXrHSB9upgRRCnrngyGUEgAf2w3QMAVped4ThzCSDwgGK0pHyu+fNpTBuWCarPg9bS9DMtalIlBmGmZ897E8qRHGjVoGTVpN8tKNWeiGzab+Rt5rTSL5uUn7CyY7lI8F28J9niXw56Ox4mtgpVhtF3TkxFlRVrkSEpR9o0v3mRgy8AWFkTycEGESli6hV/I2QBDWq2i5JFELPPHEfSQSN1+Ps4cNeWd+OeN0kUQI7Y6uCNqOM6PxnhieKH5xATSzue4RZ4SBKQZ5APbQX0+nz13mS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(66899024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThCQ01ibDNxUDNxQysrUnMxVXBvcWNISzlpdmdQL3ZveGxGMDdjSEFJQ0xh?=
 =?utf-8?B?dzd1enhxTFVsSjIxWjJoeVphNXFrR2dSOUQxc3VNSTFzbXZkK2x3a0pVa2lq?=
 =?utf-8?B?emRCTmNOSHF1cWhGUHdlTVo2czJEbTViQ3Rjd2NYWGJNQU9LQytrQnRPWnhu?=
 =?utf-8?B?NGRodWQ2U29VNDUyV2pHWFJwakZFQ25QR0F3b1pKbTMvdDJXSmIrS2hOaER3?=
 =?utf-8?B?S1hSQU5MNWNONU5rZTdGT0FDYzBtblM4Q2ZBSlpsYWVjTjJJSzZGQ0c2eWRM?=
 =?utf-8?B?R2wwS0tpY1lndHBsTFZvejZTS3R6OGY4UklJTUtBSkdRcVVOY2ZSRUJoQTg5?=
 =?utf-8?B?bWVCTmlKY3hiLy9kb0RYNU15SkFURXB0TTNTOEpwRDdVcWpmSWlqdWwvL3hU?=
 =?utf-8?B?Rlc0aXdWOUExV0RtYnBPQmlaZHNhWHRIK2c4QjF3ZytoMVFVRUtsZUY4N3NQ?=
 =?utf-8?B?OEppeU5XRVNvRWlFVEVlTlFid0N2aVFUZnFtWDduTXlOQytGY0g1UUVIT09m?=
 =?utf-8?B?QnJDWVBoNCtVQUI5TktTZWt5WG1wbExTYkY1RDZEeS9kZXo0SDVsU0xId1Fk?=
 =?utf-8?B?c2lpZkZ1U2lpL21uT3VGWlErampRZ09vaVRBQkg5YnhJMjcwZlc4R2EzUU56?=
 =?utf-8?B?b2xRRmNXTkhVUHkwTkVGZ3ArMVNLZnpjWVl0UmFucmhuR1NPcWpkKzJ3bFRH?=
 =?utf-8?B?M29qRWFlTkNqdUsralRYMCt6dC9XVmd2a2prNTZuNGFtS2x1OE5ja21Jemox?=
 =?utf-8?B?YXVaRVF6YUJOU09rd3cxbW1uVlYxcnZXOU1aay9xbndmZEVuZGlnQTZnYStt?=
 =?utf-8?B?bFlzUGZLZGorZEQ4UWxEVlJUTGxBL21aVHBHc1RqeHh2WG1sVXhEaVVKVXZH?=
 =?utf-8?B?ZnVqSjFDdnBQeFhjWEhVWGpJZGg5RGlZN3lvNi9wdFVJTlcwOTJxN3I0S2t2?=
 =?utf-8?B?aUpDS1cyUTNTY2RxOFBHMXZ2WE1YZ29NaTdnYXI2dituWjNyTE44VmlVNWJ2?=
 =?utf-8?B?ZUNaRjR4RkVPL0ljbVROSDdDSStwMXJVRzQ3cW9kVTVOVVhjQk1kdHFNQUhq?=
 =?utf-8?B?RFpPeFpRVzNNc2RsZnhKTlJCb3ZoUnJnUFNLbmJMWVo3RHpWRGxoSG9EaCty?=
 =?utf-8?B?RGxmRmlLaTJ5b3FvZ2RnQVFDbFRsMHBOR2VkbGJHRVZ1MFp0RDZvSG4xdXBX?=
 =?utf-8?B?M09PSlBXWjJLb3pYeUViSVpkYkFHbVQ4cjFPSHI3dmpzd05pbzdVTlh5RTdN?=
 =?utf-8?B?MExUUU1CZ2IwWVFLcmdjdXQvNUlpUUcwRERHc0ZRaWZXakp1UEd4K213TEZn?=
 =?utf-8?B?dW1vcklZRzdiYzUwbkxuVVAzZkNDMnpKdXpPanVoT0VCOWIveStPZkwxTEJ6?=
 =?utf-8?B?L0F3NDNwTnBLNitDN2djSE1qN0hyc2JqQlVUcWZkTFVSaHUwb2EyOTVTUjZ3?=
 =?utf-8?B?amtFU3VBaVdiMTF4WldnbkNTL3Z6OTUra3FYMnNzVlROUGRsMno5RDVyR2hq?=
 =?utf-8?B?R3AvNXRQcEFGQ0pvNTMwNHhycW9mSkc4d2YzL2JCd054YmdPakJ1Yytla05E?=
 =?utf-8?B?anViaVZSalVDSk0wMTBiYzJ3RmF1aERjN2NUb3l5L29QbFRCckt4dVAzbll6?=
 =?utf-8?B?bGpWZ2t4WXRPUEJnT3E0WGs5aWlITy9Oam8zUDBFRW02c094VytTM29XZWVM?=
 =?utf-8?B?WmhvMmxKUVVnL3lUZGRMT1dsRFpOVzZaVXJSc0JqQnF2MlZyNm03bHg5aTJa?=
 =?utf-8?B?dFQzVWZ1MmhFUUpYR0J3Ly85eGRHTDE2YTJ4cHNwOGZYcysrbFFHaUFOWmEx?=
 =?utf-8?B?SUFOdU9XUStxeTZiaXdscjNKWmxXbVhxN3dhVFQxWEdiNVFHTTZxWXBuM25B?=
 =?utf-8?B?bmRJVEdJSVErSm5EUmZRcmcyL0dhSFJ0c0M3TjdJQUZJQ0l0R2hNc3BxL2Jo?=
 =?utf-8?B?K3ptUVluMm9hdU5TSXM5cVRuNmI4cnF3OS8zMi9EQzVTdWlCb0dDZExPL3Rk?=
 =?utf-8?B?LzdXTHBtVzdwdERqbmZQbmZDdkRMRjRtbzFiNi9ZajM4YlRZdW1NQ2pMMEsx?=
 =?utf-8?B?TGRPUzRlQXZ0YitBRDJTZW0wcVUrcmtLWEtVSERVRm1nRm9ZNkE3aThvbWhE?=
 =?utf-8?Q?6AmEOWu4hbAAHrURCdUOwB0tE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NlovUDlha0RuSFpNd1BUd3Jwb0VGd0ZhR1czaVBzSkI0cFNMZk1nUmplTlJB?=
 =?utf-8?B?Zm14d0NIZFgyM2pEY1dKS1QxbXpMQU1Cb2FWQm1DQXRmNXJuRUpvV0JuVXFT?=
 =?utf-8?B?dUppK0VDcVlBWlFDaUk1N1BoRGVYdkl1bmpkdEJLSTRIODVTUmZiQU0vQ0Fl?=
 =?utf-8?B?d3N1RE5Gbzg3cStZOElSb1NXN0NBRTRpQXlnaVBZd0lIMVBleEtqY2JxNEpM?=
 =?utf-8?B?ZGFMNlZ2WXpnRFA3RVd1V1U1N0VBTWJoK2M2NE9rcHJtamN1SEFBVzhSNW9D?=
 =?utf-8?B?aWlBclF4TVhycUFVOHZNWWlnT0Q4RFVLd3MrTVFPUnphazQ3MXppTXdpL0VB?=
 =?utf-8?B?SkVlNWQxeGZISTQzSjVoQjBycXI4S0dHMUFqdVpES0ROOVN6NTJsdDZCTzgv?=
 =?utf-8?B?RTdkTTA1Ris0NlhnZCtNaHZ5cm5BN3FvREJVSFJqTlNPK1lRem1jSGtVTHFP?=
 =?utf-8?B?eGVlMTVFTU9kK0FMVTYzTzJWZGlVNXlGZmRvcnIzeWQ4aC96dFMrWHJIOEw2?=
 =?utf-8?B?VGxoSzdmcDkvNkFZcnBjMitXNnFaNnZwd1NtSnhEdU1KYXJuZ3Zid1BxaUVE?=
 =?utf-8?B?bVRPOFgrRnRINC9WeVRCWmZ3VUt3MTRRZUtLWkhkMnZUTU5ySXh5VU94OUhV?=
 =?utf-8?B?aEVIakk2ZEZyOFlXYjZLS2N1L015bkV5Vkp2SWR4dEpwTThlWkVZK2xjQjBI?=
 =?utf-8?B?UE91VDZOZmpOcTNmOS91bXFjZkZacjcrSXBIU25PdVdkYWNKSWx1QWsvVCs5?=
 =?utf-8?B?a2FSa1k3WU01djJWSUpxOWE0SmNXbGFDa0t5blVkemE4eHVPMXRwSjdtTUpk?=
 =?utf-8?B?N2RRSVc1VzN6b0Ryd0xleVBWa0F3ekU5dFpPRlExWGg3ZC9qdU1KZGlPS3BQ?=
 =?utf-8?B?c0dCOUZvL3ZUTWZqNkNpanhnSks3SUM2Vjlaa3AwTXR4UXErVFNrdDBYWGN5?=
 =?utf-8?B?SUdQS1pRN0p3YnhVS2tDSmYyZFZIRC8wUUJ4eEsxaFRrRThIL0xIUTU2L01k?=
 =?utf-8?B?TFdwVlFxSHFIOHo3UllYclFEOTRURVZ6OWdFSERCQTNXVjM1NUltQ3RXYTBS?=
 =?utf-8?B?STAxYkRybDNoblk1VXJkZ2d4RzVqbWV5ZjE1c2dYbVNHcmw3OHhOazBpcUVv?=
 =?utf-8?B?dVg4cWx1MjMxV2NqYlFTTFl5cEZWeTk0RC9zbmtPUXVIVVhiNXlHeUhJRFNI?=
 =?utf-8?B?UXUvYnBrbStLVURQOUhlOUxKa0tTa3lyVEFiL01CSUpSZlRrNGlHSVdlVC95?=
 =?utf-8?B?dFg0c0laMStFK3ZTVFd3YWpUci9nVFUvUndWUkNpKzFITlo3ZkdNTlRSUEg4?=
 =?utf-8?B?MHFwdDFjUFZXTDlWVk5rSVNBaENuSDJZN2U2bTU0b0ttcFBVRCtyRTBHNnJ2?=
 =?utf-8?B?NGxkZ1h3bHI1eU9RM050dUlTaEF1V09wMUNMeUdYdmFZazV3YmtXZ3djZnky?=
 =?utf-8?B?SjhYcm16L3lKSDNYN0h0dExQL3R0Y2NCS2ozNlYyS1BOSm4vOUw1L1FwWmkr?=
 =?utf-8?Q?DcFu98fbkq5NMlhM/FvN6j2Blqn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15193abf-7438-4861-1642-08dbae5940a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:16.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk2mkK8f0inoBhffQ56L0SoYky0CS1NxO6Yli07x5yW+MI0iHu7k+7xZsxbwadGk8y4SG20a65OJYXjtJ+QrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: _wBsUF7NX-oHcZnvgt1rjxYR-31vF0Om
X-Proofpoint-ORIG-GUID: _wBsUF7NX-oHcZnvgt1rjxYR-31vF0Om
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb vmemmap optimization was introduced, the overhead of enabling
the option was measured as described in commit 426e5c429d16 [1].  The summary
states that allocating a hugetlb page should be ~2x slower with optimization
and freeing a hugetlb page should be ~2-3x slower.  Such overhead was deemed
an acceptable trade off for the memory savings obtained by freeing vmemmap
pages.

It was recently reported that the overhead associated with enabling vmemmap
optimization could be as high as 190x for hugetlb page allocations.
Yes, 190x!  Some actual numbers from other environments are:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.119s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.477s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m28.973s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m36.748s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.463s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m2.931s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    2m27.609s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    2m29.924s

In the VM environment, the slowdown of enabling hugetlb vmemmap optimization
resulted in allocation times being 61x slower.

A quick profile showed that the vast majority of this overhead was due to
TLB flushing.  Each time we modify the kernel pagetable we need to flush
the TLB.  For each hugetlb that is optimized, there could be potentially
two TLB flushes performed.  One for the vmemmap pages associated with the
hugetlb page, and potentially another one if the vmemmap pages are mapped
at the PMD level and must be split.  The TLB flushes required for the kernel
pagetable, result in a broadcast IPI with each CPU having to flush a range
of pages, or do a global flush if a threshold is exceeded.  So, the flush
time increases with the number of CPUs.  In addition, in virtual environments
the broadcast IPI can’t be accelerated by hypervisor hardware and leads to
traps that need to wakeup/IPI all vCPUs which is very expensive.  Because of
this the slowdown in virtual environments is even worse than bare metal as
the number of vCPUS/CPUs is increased.

The following series attempts to reduce amount of time spent in TLB flushing.
The idea is to batch the vmemmap modification operations for multiple hugetlb
pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
flushes for each batch of pages.  One flush after splitting pages mapped at
the PMD level, and another after remapping vmemmap associated with all
hugetlb pages.  Results of such batching are as follows:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.719s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.245s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m7.267s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m13.199s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.715s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m3.186s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m4.799s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m5.273s

With batching, results are back in the 2-3x slowdown range.

This series is based on next-20230905.
The first 4 patches of the series are modifications currently going into
the mm tree that modify the same area.  They are not directly related to
the batching changes.
Patch 5 (hugetlb: restructure pool allocations) is where batching changes
begin.

Changes v1 -> v2:
- patch 5 now takes into account the requirement that only compound
  pages with hugetlb flag set can be passed to vmemmmap routines.  This
  involved separating the 'prep' of hugetlb pages even further.  The code
  dealing with bootmem allocations was also modified so that batching is
  possible.  Adding a 'batch' of hugetlb pages to their respective free
  lists is now done in one lock cycle.
- patch 7 added description of routine hugetlb_vmemmap_restore_folios
  (Muchun).
- patch 8 rename bulk_pages to vmemmap_pages and let caller be responsible
  for freeing (Muchun)
- patch 9 use 'walk->remap_pte' to determine if a split only operation
  is being performed (Muchun).  Removed unused variable and
  hugetlb_optimize_vmemmap_key (Muchun).
- Patch 10 pass 'flags variable' instead of bool to indicate behavior and
  allow for future expansion (Muchun).  Single flag VMEMMAP_NO_TLB_FLUSH.
  Provide detailed comment about the need to keep old and new vmemmap pages
  in sync (Muchun).
- Patch 11 pass flag variable as in patch 10 (Muchun).

Joao Martins (2):
  hugetlb: batch PMD split for bulk vmemmap dedup
  hugetlb: batch TLB flushes when freeing vmemmap

Matthew Wilcox (Oracle) (3):
  hugetlb: Use a folio in free_hpage_workfn()
  hugetlb: Remove a few calls to page_folio()
  hugetlb: Convert remove_pool_huge_page() to
    remove_pool_hugetlb_folio()

Mike Kravetz (6):
  hugetlb: set hugetlb page flag before optimizing vmemmap
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 283 +++++++++++++++++++++++++++++++------------
 mm/hugetlb_vmemmap.c | 210 ++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  10 ++
 3 files changed, 387 insertions(+), 116 deletions(-)

-- 
2.41.0

