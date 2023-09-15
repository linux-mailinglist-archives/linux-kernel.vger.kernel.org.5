Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1B7A2A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjIOWRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjIOWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971483
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLtxMN026316;
        Fri, 15 Sep 2023 22:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=qivZngOpRxmOmRzB9eRb63RaXMdYCj2C+bkKYI1jEhI=;
 b=KSLisCBDr2XDJDns2qqzM7IrgtTQoJu+X+Ppe3aMUObiSD/pFbQp73uyjZzO4oWQQ0yI
 /WS5PV8PT2+fnJFTqDrsgdjglU2p1mrlNwiIbxRSxNEC1CZIUYeN4Z6g/zZRS6RU7nOS
 D8U0hr/PdihvbODmSMznXEo7HD9jmdJe+gc4/M1bs08dQRmNz3f8iM+8SxNSxvDDWaVn
 AykxTt4dvU3PHO3viuFdEyxrQ3RLgouSGWfBCl7woQF85H4YrkJOwwz0AyKtxyCImKeK
 BAVbBj6yWgd3UEN37V/ihRCdEja7FgWLnwm6oZ+zBXtq9Pdodpx2QD53Pki+9g/xzM4m TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7prnyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:15:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLFlNV036185;
        Fri, 15 Sep 2023 22:15:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx8qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDiDejKQMqBe4Fr2Js9winF4A6s7Yf6DD8dfZ0LN7whnvWYjUrLaGTo05/q8z7gxFRnyi0rD7/33E4uK69GjzKEwj0x5ruLXT3Y5lhb4akFOakTCbgus6uNJkDOS8wd/zOSk/9gLVAbOHTE1BrFxFZ72OkNzaGHnRSjiE6BLOGuUuj9pj5of+gZ32bBj012pvXoiFz4CztxIs2GnIts1P5UJ1TUZ1j1VSwXyauABcuj836623rhk1zi1MwuJGZEDX4eWTwkfK5pkXoda69iJlfUdfJz6zbTeA+6KJzqDtQWTi8iThnIKYGJ2mb17HdpHJYvK3kfTyaQ3S73Hm/NlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qivZngOpRxmOmRzB9eRb63RaXMdYCj2C+bkKYI1jEhI=;
 b=nk/avYhMbLJIDsXIUE6ejZkB4IM0syji09H9q1DBkMzeDMSEH52BJfUwf+dOY/t52vuwGC0p+JvRvMW3GYOjPy2G5/tp1IDPu5ADcwgig9lRWqmhqu9YQMchxuc9zg1N7zamZgsauuPrzItYExvrGUbex6bjg1k1OhtQCFCJyC5bPvpwJH8y7ny+QWg7pJnGYuGpurfawkNUpdJPPKk+7JpQs0auwvSKQxHhtKWO+/GjKmyXG/Lxhff07iO3rUdcF7hn8RnXOwLnFwuC5tFB1VyRLjJFSncjxM68h5X6vTUycwLUDWmQzwxFVkxIoTZGF+Q39YCv/Qqup7tsTmgsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qivZngOpRxmOmRzB9eRb63RaXMdYCj2C+bkKYI1jEhI=;
 b=IYwAB7yOOXcF/POtmf+6+sEUQpVDkwd+ZWP6eBytx/MApV/3GMLDExzSAYAjO508TgR+PGktGNMbu4HZcY5DMkvgkypfsJWLv9e5NZXAkrzEYDNlJsIipg6IM8j/9zysX8vrGQH5/ExS8eg3XsHhHHLaPrB3DfBKXSufR4ni7Pg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:15:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:15:52 +0000
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
Subject: [PATCH v3 00/12] Batch hugetlb vmemmap modification operations
Date:   Fri, 15 Sep 2023 15:15:33 -0700
Message-ID: <20230915221548.552084-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: b025e1e6-390e-4230-6d18-08dbb63952b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwV5NXTK8B2FUqlUp1yTp9INkvxGbBtIUk0jths/YdzzYsqM24OsIliuBvERhxKQDVjNPwCNfAJSvXOE5X4YTQ/3L1mFH8KBIYHBz0TwW00nQQsTDyNlWO219QbcqmNfe+e45bB7p89897oWhmfutQ+x5QQ1l8scVMB1xMv4dByfSb7FDWSEOmYkzkFYIn2L+qq+lMBCVauVdy8tFpOvRdcpL80E6jLPNjdKuQHkLju6ll7XgWS4F+K/FM+PJIRwBLoOzsCle3S+yvJCJQngM6fu7JD6EukgpScFzJgog94/XEjvCb1Kme230mVQtexMN/bQKyNHGVEtVejO1FlVFerK+BimIVMkIGE+K60M0eJCt19SPDnANqBBQL6Fis/jFljZwDL6cFM1xvMyrkzWb7HetiN7vWq6P1HVDagwYdljMkHsjsUOnX7Jp/Fq7hVOgysjTyH8kuYPdXRJ6PtvJdfuRWVyK7z5/1Au7F6SH/eGljNtCodvM9E0aHDr/36fjgjf2LC/Z1ydTbliURZnzyk1Ds+nTPXe05BGWaWuTLMX2nP9D2HsF7TnICjbBY2d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(66899024)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhvcUx5YmJxL0ViYi9sNzY3S29hYnFaeWVyZ2dUUE56VUVVWTlON2xSZ051?=
 =?utf-8?B?RDhHRHk2NTB4R1RyeFEvL1ZMVVZQY2N5OE42Vm1nSFhTWjA1OU0wUFhTQTNH?=
 =?utf-8?B?RE00Q0dDYVlieDdROUZwQ29rZE1yUnN6VHVMaDFjZE1mdmgxaTBNV21XUkdZ?=
 =?utf-8?B?TGRxdHVTREJnWFBoQmpqWmRsYnpoVU1NRHI2ZU5mbFI4dS8yUks0Vlc4NTZo?=
 =?utf-8?B?ejEreFB5eUxUdCtDSzBqT0s2NDg4ZitMdXdzejdTM2Y3RFl0VXRscm5wbzlp?=
 =?utf-8?B?bVhBdVpkMHhmd0pmVkdCbEYzelpJOWNXN0cwU0dBZWU1UHIwVE50eS90bERx?=
 =?utf-8?B?T1pHRUFaK3pyRXJEUitRenk2WTNMRzRyZHhWaHdlMzVjaVBrenFabUVLSzRr?=
 =?utf-8?B?dy8vYU42UlQ1ellmamtHOW5QNVZaei9pdzJBdkcxUGZWWUlyelZ0SXpILzli?=
 =?utf-8?B?WXJCZDAzRjhhaUZZcEVDdVV0YUlURkcvWW80VmN2VDR2NUxiNzQ0RU5YZHJT?=
 =?utf-8?B?TmNsYklEY05ERnZwYlRTVk1ublhxZUlEcTlBRkxQOFBXQ3hvVno0OUEzNzNy?=
 =?utf-8?B?NStpWlpMMUdMa1Ezb0pXRDlwY3NRME56em5jbmsvZmlzeUVVQmU5blpwSndN?=
 =?utf-8?B?YVpTSFc3VW96UzlhTm9UWWRMbk1SZ2ZOeHFqUG9yWFg3QkpZQVAzLzRBaGw4?=
 =?utf-8?B?NWFROUtOTEVGUDdnM3oydTV5Y0lDQVlSTXZlcTlCMzl5RUpXSjRWd2ZIaHlI?=
 =?utf-8?B?ODFmWSsxaGI2Zkl1TXBsVFBjNUE2V0l5TDBCQzB3aUZZZ0tZWFlpek44eHRa?=
 =?utf-8?B?WVlZQ3ZpTU9sM1VPbGtMVWg1WVdYWEpULzBzeTE2KzgvcWpXcHdLYTRzVU9m?=
 =?utf-8?B?a0M2Wmk2Q0NBcURmZ3h4RDVmTDUrcHIwUEp2R2srSmhWYkVxM0w0all6TVZV?=
 =?utf-8?B?dlBDczR4aWp6RG1aZElVZ2p2NEEzaG1VVUtzUTVReEV0N3BQYWtkcGhuMm5T?=
 =?utf-8?B?Umw0RWFwWGlYaDV1Ykk3QUdrUzJlVjJiQlJtQWF4S3pZaWhlMzcyOFdHenYx?=
 =?utf-8?B?cHhUQitXUU4xWlEwaVhoN2N0cm1UckNCdVJWRWNmeVVUT1F4bXRIb3E4K1ph?=
 =?utf-8?B?RmwzYlFLY003R1VoM2UvYWF6RmZWSi9lZFZLL1ZORnVrVzBwVXRiOEtsUC9j?=
 =?utf-8?B?a1BlZmczTmNRcm4rays3MzE3WlJaUnROaVRlWExDSDYyVEZ5SkJpRCtIRWdl?=
 =?utf-8?B?cmxMcVEyN0hQSm8raXFKdnZFVVhVY0RsVHVueGVSckZvWEdTR3V0RmhoMTZP?=
 =?utf-8?B?TWhwS0k0aXJyS0gvR0dhS2ZuSVB1bGlNaFpyZ1VQb050Yy9PWW1OMEtBcDVD?=
 =?utf-8?B?R0ZZZzFhNS9RU1ozbUxnZEpnVk4yYnYzZ2p1RlpqaUFMa2g0N2VET3ZRempU?=
 =?utf-8?B?U3RhMFJEZVhNWkh5dnZVQ3BnRDNwd3BYTHc1U3ptZnRTS2ovdXBmZXJPM1pV?=
 =?utf-8?B?OVovSWo1dDRNUVNqcHJlTmtWMkl4MFdRWUVrRUUzTUUvcjA5T3FSR0ZIMnYv?=
 =?utf-8?B?MlB1UEVlV29CZ1pFN1JSb0xIZkdRZkZ1SDlXckxaV3VKa2Y5UzBVQVpEMEd2?=
 =?utf-8?B?OEJZL1FKQmZKVVB6VkxUUXJaNGtGMjZFbXlHeWFkSElMTzJHcGVLZlloRWcr?=
 =?utf-8?B?Q05oY3MzMTZqbnMyK0pYQUw3YjhlWUo3K3hmU2R3QWdOdEhWRDVwdGNwRVFy?=
 =?utf-8?B?QWhpT2lPSUE3SmJjZkM3ZXZTL2I4MGZrYjhYYXFFYTlRNXB0U2tLUkZjcUhO?=
 =?utf-8?B?WnNWWmh6eS9DcnBpWWdVazJlNjRGbTVUMWpGbThMNmZDTjZVeDc0TW9MYVZ2?=
 =?utf-8?B?RXo2Z1VaZitZd3VnaXc0TUNkM1BZdm1oU3d3NGRtN2t2N3VSb3Ntbjk0RXZm?=
 =?utf-8?B?bkxCRjlncGRTNElPQWh5eVgzdFNxQjJXZTB6VU9IMGFrRmZQalNGcXVoNUxp?=
 =?utf-8?B?MGVhZXdYdFRaelAzOGhWTkhUWmpJcjZ3UEhnMExDY1dwM1FuUlphT1ZwOWZu?=
 =?utf-8?B?UWZReUJJVk1uYVZCdTFTSlVsbk9CY2ZwNjJCT005WGcrd29sUVgveW1ZTHZR?=
 =?utf-8?Q?RaipjQslkXOXEjjG0T1XB0j1P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bVR0Ky9tTWc1VXZXVUJ1NzFJS1k2RGlkSHpDaStPUmxwYkNEOTk3WVlLTXBV?=
 =?utf-8?B?T0Z2WkdXS0hVWEJHTEd5U0hnd0puM0trNGhyNFowK2Y0TWI1RzA4V01pTFdV?=
 =?utf-8?B?NXlBNFVQbWdDYktwV21IZm1LSk9YYXZYWUJMZXBuMjhhbGcwOXU5VG1sVmJh?=
 =?utf-8?B?N3g1bDMweTh6MmlYNktJRm5URkZhZTNuazY2MkplamFURmN2VjRCQnQrNDVp?=
 =?utf-8?B?KzdwY010cVNiaGJwU1ZJbFRNd01LMS9WQ1ErS2FjdlVtNjZGQ1ZWY1FyaENY?=
 =?utf-8?B?eFZaRVRCV2ZHeTRTbW9Od2Y1RDJGbTVmL3dwR05lVUdxZW84N1ZabFRwdU93?=
 =?utf-8?B?WVZMako3Qm9mRHpsdFhSaWlNWnJxMlY2S1RPdlF0UXRKUy9NVmc0N0M5dkxT?=
 =?utf-8?B?cDJRazUxMFpkaUFBVnU3Sk00N3crNzVHVU9YS1ZOOEJscC9idVZHSnR5MTlo?=
 =?utf-8?B?SGRydnBsZit5Nk02VGE5RjB2ZDgxZzNwSFhpTk4vRmRhWE1IWUJDVEVWaUV0?=
 =?utf-8?B?eW5lY2tLcldieDZndTZRNmRwVjA2QUdtdWdGTFBkckJabXpORDBlSi9PN1dq?=
 =?utf-8?B?WE9US0dnOTRNY0ZmME5RdzQ3RHVoK3NXUldYYTdaaHUrNklWY3ljc09HZEFN?=
 =?utf-8?B?eDliQXovczRUMXFidVVka0xFNGhGRzVNbkVPRE5obmlNNWlMVEZDRHpsMjFE?=
 =?utf-8?B?RkxFelM3YzhZb2ZEWlpKNmRUYyt1bGwzUllubFpYMFUvZWN1RUtYOXZoazFw?=
 =?utf-8?B?VlZzUGIrcXVrOGowN1NsSVJhMEdEeEl0Wm1KRHlBc0I0SnEwZ2s1SnVkWUlK?=
 =?utf-8?B?L1g2eFlQVjFxUzMwSVQ2dWw3Um1JUWxuMWh1dkY2MUgxLytLNjBGR1R6dXFK?=
 =?utf-8?B?ZUVKczlqNFErQUgrNUlWS3NldUdvVVlkUHJ5a0M0VFZRUTQwMHF6a2NxMHY3?=
 =?utf-8?B?N2Y4OE10M2NIL2hKRHhqaFh5R0NjbWlkbVVCVjFJVWVmMGRZL0N2SDYyWnJN?=
 =?utf-8?B?M1F1NmMvcFk0a3dPWVQ4QlJzb2d5YWVBYUNFMy9iaFRkUUdyUjh1OWphakha?=
 =?utf-8?B?Z2NtUWx4U09kUGtCZXh0VzdELy84ZUR5L0xZQ2NLaUhJdmxKYjVNZ2RlZU9I?=
 =?utf-8?B?bFl3ZFVxalppVGVnUzI1ZndhSkdUUko3WWxRYmY3MDhuaWhZV3o1UzRTejN1?=
 =?utf-8?B?SVVqVFB6Q2lzNUV3MUdiMG1WeDAwUUVTa2Qyd21rSjk2UTFXalQ0TktCRTZy?=
 =?utf-8?B?QzRnODZpSjBLbWcyMCtGWmJxQUhRekVqS0VDcjVhck9WQW9MVmFwcmc5bUFw?=
 =?utf-8?B?RnZVSUs0N2pzTHBuSXhBeTViaE1qdXpLVGRYWjd6a2FjcEdzUm8yblk5T0xC?=
 =?utf-8?B?L0dKWmlyT09tYmxnbmxxWXRtb1E2K0NSazliUVJSYzNmRzFNQTdTTWoyY21t?=
 =?utf-8?B?Z0Y2UHVZZ3E5K3ViYmMzeWZZS3FxbFl6R2JmOHVWYUVPU1ZFQmdyajJhd3Zs?=
 =?utf-8?Q?acq3Rc481sgpMV3T67f/4Y6NMaO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b025e1e6-390e-4230-6d18-08dbb63952b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:15:52.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUwb6sULeI+sucv6V8eSoqjZmv/VczSS9mmUZhgEEbqnWx/OA8OzwAq8ZA4v+4rpRf/8Zu0yHae/VN/bOEOX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-GUID: ReiDg3TvbRjN485bMLuaAEjvHi7QfA-D
X-Proofpoint-ORIG-GUID: ReiDg3TvbRjN485bMLuaAEjvHi7QfA-D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

This series is based on next-20230913.
The first 4 patches of the series are modifications currently going into the
mm tree that modify the same area, or fix BUGs hit easily when exercising
this series.  They are not directly related to the batching changes.
Patch 5 (hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles)
is where batching changes begin.

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

Johannes Weiner (1):
  mm: page_alloc: remove pcppage migratetype caching fix

Matthew Wilcox (Oracle) (3):
  hugetlb: Use a folio in free_hpage_workfn()
  hugetlb: Remove a few calls to page_folio()
  hugetlb: Convert remove_pool_huge_page() to
    remove_pool_hugetlb_folio()

Mike Kravetz (6):
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 288 ++++++++++++++++++++++++++++++++-----------
 mm/hugetlb_vmemmap.c | 255 ++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  16 +++
 mm/page_alloc.c      |   3 -
 4 files changed, 452 insertions(+), 110 deletions(-)

-- 
2.41.0

