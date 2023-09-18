Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286487A5609
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjIRXDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIRXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B30A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK53J8016873;
        Mon, 18 Sep 2023 23:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=L95tnfc0CA4c741dFYEs+Oc7CEYreRyaczmGsZ9qoZw=;
 b=oaNOFPV6+NhD/4uADFBOH5g6t2k5k/9sPF2nezz5Yau3kC5ZyE5Jeiti/2SS6i6Vrwo3
 obKCZcbyE/SCurC6CfEG+KF+S+Gz3cxWvPn+u5v/415W20nnsH5e0JArZnlhuqnD3rPu
 UqyOhdwqCjeUtpBWd9FPRvyWNx7TohjgIKqRls+KdOhryLi3rtV5ryyzecZ68PD9x04x
 4YDEG/e/CdwEbxnv/ObSzrnxLPCfp3TZK2d+TvVY1ci3xXdqm879Hy3ZvwJNMw62cw+d
 lD0fNctKT9tgKffmnNGFOvAvj8zKN64ZVFo4IYLN5QdlxyNYzzSHydr8G3C2oFiV4Z24 rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539ckqdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILqIbK012157;
        Mon, 18 Sep 2023 23:02:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t559w9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCDvfE/v4N+GCtV0RhZNXwP/HqyPhnVPdU7ZSMVCpLbLGk9+ACV9KGNQBC5TJ1nilnQXsL7/xT9pV30KqGJfttHS5ryJLA1OFV+BJ4rSFw/hByKIwLYXRNHeGcFEIUSPaDz23jDtNwBlpDw0WXR0pXV/zHzzCOFWNe62J2jAw70vL9swxAeCeI5Dap+rRVbTwnafAPgcC8NfxBvfZCMKqNv28sBOGO1O46pct/30dwVQfzDtj1OjAVq0YG7uWE8zoBNIhKVVuk3WK4CWyzJJDR+r+lpdUtRd9lgeeqnmqH7de+fNGLyKQ+kJpURMmqNo3u6y+5U54p7fqFy9vU68rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L95tnfc0CA4c741dFYEs+Oc7CEYreRyaczmGsZ9qoZw=;
 b=MQZhTnh0X/Zkq1gzR639mIdO0ixZONT5ogj6wHoT0KP1sx8BsYkdHjJFX3xPcPmii+eospBgzjTCKoWrv+km+D5N/7eow8g4/PyWt409649RSe43Mkoh0+TWYM1n1ctzVa2Qwgf0Zt9ICxVxx3WxfrmPo0TGMv35ELXOMAUs4ZPo68wItODkRunRqsJ+aC2jIRwZnoTs/++6JaWOpnlbTpowIe1ctgmTlzK8RI9FJNQnWfxrZ/Fjr4t5impjP1lobuHkFNWrI+ek2a0jHfUnXdZ/1mJwGvtyi/QFKBwJrSV5sjkjJOcQb6IYM+HfpHXhU09t9MkxUD5zdffykx4hsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L95tnfc0CA4c741dFYEs+Oc7CEYreRyaczmGsZ9qoZw=;
 b=R+392oTdgx9xufT56DvB7OyGeXAZSBH2DYNZf4WvLDPB36sY/JfqNJ9gbV+6dRQzzRe72N6tmwhrnIiWd3R4DPQApbMgFgAd5IRi2LYTjOwM/ZylZq1z3OC2dmUNzJ7N/8xAmKxY1EYUR7m/Xsh2ydUyKBU88TUO6aUAW7qMEFw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:02:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:06 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/8] Batch hugetlb vmemmap modification operations
Date:   Mon, 18 Sep 2023 16:01:52 -0700
Message-ID: <20230918230202.254631-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b898ee-0f2d-48c3-b4d8-08dbb89b479b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REFkz7R0yX/8I728rPW0FYV2oQV65VK8pU//NGiBf/1i4YPJgd17ag/c0kiuKiMHsj0ZBLOKJmV4AcSCOpwLOtjI26bmBPH2AHt4Ejbnp0mV25aldvfY2v1yFZSkbJlJjpH9gLks5gHCzz4YwSqZXc40B8B+g6diFLZHT+klSUwTP2kFqaygfX2KYPYw7qz8Nvmizxxz3R9bPeWfz5TkBaOji49180Fh75QjXLQxyDUw4I11M0OErJcA+JOeFDHtQzcDh7uxXuiWWmcqOifTXXml55eLmm7dHe+LlYJCso0buFPlq0urGwz0sDQXU8sVKVgD70VM0zb3RXWc/QtLVp0YSxef8kiwJTlJBIKUSd9/VMxzH83dJmSbi+Of1VeZgMnKlthbmqrFsOmtmjicintfr1AIan3U5cwjWpUl4BWmb8jal9d7PpA8dNBfmnxyt/auAm89prbFzzXDB+X2ymKJqjZwAPLBe3C6O4nJfAy7ae5XtOErAdL94CXAUMnrRqnTUlKLcV13CHfB3UX5YryhlQuwk12xCmGJT5Bz59Bp7mYNgeDmt/kngKhhiVJI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(86362001)(6512007)(54906003)(316002)(38100700002)(66946007)(66556008)(41300700001)(66476007)(6666004)(478600001)(8936002)(2616005)(26005)(2906002)(36756003)(107886003)(66899024)(8676002)(1076003)(4326008)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNDQmRYZWZEVlhwbk50Rzh6QW5ZQ0NRUTlNRnNZalpEN1V5QzZuOFB5bnRW?=
 =?utf-8?B?cG1FS1JpT0xndU9SRjNBTnF6M2tUcWd0cmptNGl6L1hwUFRoSmExbnE2MWc2?=
 =?utf-8?B?Nm5GcVlUc2JpUlo3ayt2aUkra1RXaTRkQUtDVTZHRWoyemVaeEV2T1JKSXFh?=
 =?utf-8?B?NmNJT001dTZDZnZYZEdTT2RodXkrVFNFL2pjSFNzKzNnUFRQSjM3eWpsTHRr?=
 =?utf-8?B?bDBRNUlNUi9aekV5MEdzVjk4TmU4K2R1YUJBai9ZSTRMc21zQTZkMzdXNGkx?=
 =?utf-8?B?RDBqVnUwS2owWFlFZFBhSFlKbHNVdmFCUkx0Rjlma3FhdE5XOVlZakxwOTRm?=
 =?utf-8?B?OFlDdXJhaW5lK0g2a200WDBIZ1Q5Um42c29VTkZxZjM1bEpRc1gxbXFvSkZS?=
 =?utf-8?B?U0lRUC9ybnE2ZGc1TnBvOVRoZHN6WHdIeEdPbW5pRVg3WjRacWp1Tno1U2xs?=
 =?utf-8?B?OFArWHV0eEhFc2VQdExKTllzSU5mbWpFQ1h3YzRpSUVxVnNmUldDTmloazBR?=
 =?utf-8?B?RkpjYWE1c3BLamdDVW9vT3VNTHI3cFJSMTNMT2RETGpkdWRnRnNGa3BuRkRy?=
 =?utf-8?B?Mmp3S2ppV2F5K2U5ZzM3Q3RSS1Y1eC9yeXlVZTc0VjBUNS9hRmk3NXVkclAr?=
 =?utf-8?B?MDhLNjJKdmdjYUlUK0JoQTVYckZLVmhsakdzUnZBLy9JNnJlTHJOYWtJcGRq?=
 =?utf-8?B?Y3pGKzIwR0pBM2UrTjRxNGN1SGVsemZLeHFETWVuOFl3VVZkbHY5YUNYMFFQ?=
 =?utf-8?B?elRUR0tMQjRXckVGeEs3Y3FLYzVaWDBTNEk0cm1ESi9maGgySm9MdU1tbHdF?=
 =?utf-8?B?M3EvdVEzRWRsRjVyeWg4V2Y1b2JwMVlKSkNLK2FpTk5DUktYdk9SNU51QVox?=
 =?utf-8?B?MWVndTFRa2hrZ2RTaCtscTJDd0xZalU5M29nRjB0ekhXWi9XamtzOHJJOERR?=
 =?utf-8?B?VHB0N2lobHhSUCtUT0Y1Yjc0TmhtMmcxSkhlY0RFeCtUeWU5bGlqeUVMMStp?=
 =?utf-8?B?UmlnNnA1ZHJHL0RPVDFJVGRROVN3SDI5QjVTUTJ5azVJaU5IT2x6NGMwYlZN?=
 =?utf-8?B?ZWoxdUMrdVZnc1JmaXdkVnUvbEZmMHp2Q0swVEJYSkl3c3FiTnVFOEFmb1Za?=
 =?utf-8?B?TElPMVVhYzgxOGlxNUJFR3pRRlJGQ3hsWmt1alZQUkhtUW5GS1pOMTVyV05R?=
 =?utf-8?B?Vm5QclNHZnI0OEtTeHRCa25YRGpNclQ3Q2pQYjcwVFNLcm5HRW9YYVhyYmQv?=
 =?utf-8?B?UDJrZGxCTE9CcUx6U1ZPSUR0dWY1Yno2cFY4ZGpWRW5rcWVwcUVibFFYSEVZ?=
 =?utf-8?B?MXpaVFA2cndOOWJ3TWttYVRrZTFVbWR2YUdrRWo5M0U0TElBb3ZaZjFyMjYy?=
 =?utf-8?B?bm1Dak5EV1hCM0hOUDNYRXBUa0l1TVlYa3ZmKyt3M05oSVdWd0F5a0x0ckxY?=
 =?utf-8?B?YlFXRFBRdHpiRmErVkRjRkUxYlBaWUFoYVhIRitKV20yQWhKNHQvUlVvclpP?=
 =?utf-8?B?MTY0SS9TQWlBdmlmeCs4MittZDN5SUw4dmY3UnJSRTFPZGt3ODJSTVBFTXBQ?=
 =?utf-8?B?eXRxSkpLV1VJbEdFaFl6aDRheVBOdXNDZW1HZUhjSzNGellUZ2NzZkw4S1kx?=
 =?utf-8?B?RCtHUXM4NE5wZDdKc0IrWkNBTzlaaUhjTkI1NmtERnNzNENGUkNRVDdZWUx0?=
 =?utf-8?B?TlF0eHhUbzlRTEFsUlo4UWFKNURrZ1RGN2IwMGgxdVV0cVFPRHBTR1AzOThz?=
 =?utf-8?B?aHFPTW1Ib1QwYy9nRnEvd0hqL1BUQXRWcTh4UVdmMkx4WnlCdFUvQk12RUF5?=
 =?utf-8?B?Z1QrYVo3Y3BqQXArRmdhanV5L0U5RnY0ZDJPQVl6ZzkycEVvcWRSMjEyQ3Jh?=
 =?utf-8?B?QnZpeTQ0Y0dYQVpydFI5UVE0S3N0c29QV1pTeGVJdVBjUDQxcG5qbHJsUDB2?=
 =?utf-8?B?eGxsNWUrSE1MWHZrcWswbk1jRUQ4dWhLVFIvL0l0aGpCM0VNelN1eTlzUTd0?=
 =?utf-8?B?WVliTnJWZGY5bHk4QWo5Q1pEb3hnTEpNRU9JaFRiRzVUbFBBQWJwcGxLWERU?=
 =?utf-8?B?UXVYUE5PNGlLMzg5aXNPL0JLZUhudW96SzFQa0M0d2t4M0FRc1UzWWxEeXRE?=
 =?utf-8?Q?aSZty/Px6CpLfm8hKNxagqg4a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R3JvMnF2bGk3b3lqVmZCaWxiQVFyVWgyUnd0aXNSQnNZdWZmKzVOTmpZcE5X?=
 =?utf-8?B?Y0N0dGRTZlR6MXF1ZjYyY1hnQzkwZWJhdFdwUXVaNnRmelFpQkJhVnBoVTBl?=
 =?utf-8?B?Z2tjRlBZYzdZRGlTd2tDUkNWeXo2N1dwNXgxa3VWbS9ob0d2MHZmQVlEUS90?=
 =?utf-8?B?enV3VTNDRDNzdG5peUlWSkhrVGdZMUo3MTRYZm83cEdRejNWS1Z5Y0JYTGVx?=
 =?utf-8?B?Q2ovNWt2S2ovRE5QV0R0akxGM1R4MUpTVlRrMCtyTm1wRy9EbHJIL0lsdVdI?=
 =?utf-8?B?T0VubWY2UnlMSkpaYWVGeUphQ1B3VkZJcGM4b2g0TGZkM3ppZFUwaThPSkpn?=
 =?utf-8?B?THo4TE5ZcTE5MFEyOHVXTCt3OXFaNHl6QnhqL2xoRDVWNmhQZDdPWFdCbmlp?=
 =?utf-8?B?RUpYZkFOazJEano2OWFVVlVaTStCTXZoWS9zWGpxcExKUTM4aWRiSEgzM0Nj?=
 =?utf-8?B?Z1RYdEZoTmV5Z3A3M0FzeHRFdGJ0a0JoeXpHSm1id2M2UzJDNTU3Z2pVaWpj?=
 =?utf-8?B?MzRHcjBtbW1tZHpqWDRxZGN6WHR1eEp2WUtjVGFVZ3JiY0VCaE05S1BlZWp0?=
 =?utf-8?B?OTRMSStWenQyU0FHTDlwODAzN0N3bitmaWFMd2FjV3NPVnF2UDN1Tys5YmJK?=
 =?utf-8?B?eno5eHFZcUxBUVo0TWlZWmhiOThpalpQZWYzTlJRUVY4V2ZYZW55NThHRWJK?=
 =?utf-8?B?UFBRVzhnOTZkMlRaMmw2NGZ5NWIxTjVmZFIweDZVWk9kbXg4RjR1UkVYbWtZ?=
 =?utf-8?B?WkJ5bWdMaVp4N2Nzd0t6Sm9tZmFCc0tTTENhMHQ3dVRYQ254NFdTTmNBcmJW?=
 =?utf-8?B?ZE53a0lSaGZldlRySTVtQVBZQkhaNEkwMjQ0RkplYmZIb1AzOE9ZcXpJMUNQ?=
 =?utf-8?B?cG1SYzZxRXFPNEVyYi9LTXMzMEphK2hETWJmRlNMRllvMHF1aVZoTXYwZHA1?=
 =?utf-8?B?WlgzSVlBd1VGejBCOW5sV0pxNmdIcmdIMHVqUWxqaEdEL1c4eXpwMDBLZHVM?=
 =?utf-8?B?WUp3dDVUSy9mNGNUL3c4Y3lCbkN5QTJtbm1FTVhDSmNkMmkyS0VwQUZqRjBo?=
 =?utf-8?B?NGRFUStmc0VCYXMxS0liWkNtQmdPM1Vya3BJVDgxeFZxcDltZGZXSW54WWVj?=
 =?utf-8?B?cS82bnBCMjlWeU9XTXhVa3hFbStsQkg2K0VGK21PYkhYVEdIQWZoaGlJS2w2?=
 =?utf-8?B?Rk9VUERyTEhtUTFVL3VTOXBNQ1RxeHZBaWJERUJmMTBaL2VOaHljeDhsR0JM?=
 =?utf-8?B?SmkvdHFFdHRETUY0WjRPQVVXRnJDb2xEMUFpTm5mbFBZVU9SbUswZ3pTUUlV?=
 =?utf-8?B?Tm1KQVArMUhIa1lOZ2tZejJtQ0p6cmxKZFROZEhwV2VuazM5V0I0VXEzOWtt?=
 =?utf-8?B?dTM3RmkwRE5Qc2tJcXh4RDFMMThHcTJhNXVpbHhzdU5JOTZlT3FTR2E1TzFK?=
 =?utf-8?B?UFVUc2FJMlRBOGhhSHhTYmpxNWV5R0FhUHd6TDdHc0ZTT0FzZ29yc2dBUGg3?=
 =?utf-8?Q?u5s6nf6MZxbpN3wm1FVBR3p8BKH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b898ee-0f2d-48c3-b4d8-08dbb89b479b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:06.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNSFOqjmYuxso8AGGMAKxZoQOMa7bFnjn/xr+yZysivUoyPKy6ecwPRQBmSm1o41m2ptxRxVuD1JQRQARRGIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-ORIG-GUID: XBAhOLFLSVLh2sA84lOOWwOv6cOTf4JD
X-Proofpoint-GUID: XBAhOLFLSVLh2sA84lOOWwOv6cOTf4JD
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

This series is based on mm-unstable (September 18)

Changes v3 -> v4:
- Rebased on mm-unstable and dropped requisite patches.
- patch 2 updated to take bootmem vmemmap initialization into account
- patch 3 more changes for bootmem hugetlb pages.  added routine
  prep_and_add_bootmem_folios.
- patch 5 in hugetlb_vmemmap_optimize_folios on ENOMEM check for
  list_empty before freeing and retry.  This is more important in
  subsequent patch where we flush_tlb_all after ENOMEM.

Changes v2 -> v3:
- patch 5 was part of an earlier series that was not picked up.  It is
  included here as it helps with batching optimizations.
- patch 6 hugetlb_vmemmap_restore_folios is changed from type void to
  returning an error code as well as an additional output parameter providing
  the number folios for which vmemmap was actually restored.  The caller can
  then be more intelligent about processing the list.
- patch 9 eliminate local list in vmemmap_restore_pte.  The routine
  hugetlb_vmemmap_optimize_folios checks for ENOMEM and frees accumulated
  vmemmap pages while processing the list.
- patch 10 introduce flags field to struct vmemmap_remap_walk and
  VMEMMAP_SPLIT_NO_TLB_FLUSH for not flushing during pass to split PMDs.
- patch 11 rename flag VMEMMAP_REMAP_NO_TLB_FLUSH and pass in from callers.

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

Mike Kravetz (6):
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 266 ++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 255 +++++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  16 +++
 3 files changed, 457 insertions(+), 80 deletions(-)

-- 
2.41.0

