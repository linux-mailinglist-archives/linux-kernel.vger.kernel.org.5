Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA27078E01D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbjH3TMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbjH3LSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:18:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B7122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:18:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9ibHc020915;
        Wed, 30 Aug 2023 11:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z4rPyQY4QyHyygkxAh5qiWdwc40LavkYw011/z1rWFU=;
 b=i2kAvbRfSrZaAb79sGhd5LOzqMKItYtJxkSOP1ckVUx0Aa6bbSCUlvOhD0g937yaJ+1R
 5oXhUiTuU00B+IzyOMhGO/8NJSFbJV79N1TJTxc2fFwF8h/qyUGL84QtxxeRNpuRBwMW
 AcqiaStaXAmIIcVj1cdYISkBoR4szSSqrrR338/RZtR9wGiKN0ec6Lzyj6defuaQ1US7
 40ijun9RboJB/IvImRNvDXFchp3vNifWNgrIubDEFW5r4kXAZwKq9mKBdHVxXYwDCGVi
 OfRNFI8D2VWUDf/MNRBUr+qCCqGVj+8K19nbU61G6xzRlWgK4KmzV3ZtsW24HgBciQg3 KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcq4c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 11:17:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9bmGh032759;
        Wed, 30 Aug 2023 11:17:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dpvv86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 11:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0CgNwjRT4B4dQBUl+CRprVc6AZsmyvgkGAivaLWm6HQH93WzscNvfB1Vvec4DyHGPhOT3uLuY7c7l72gpw7teci8jUszd+VEunX5KqNK8bzb+rfheKT+c7v/msAXQaosHzGYogbo3VFsbMVBbFX8gdNY+T9Gv1/5NEJWqxT3SAptTC7PMmc3E40ljzoLAHmXHUe1H5rmIh6PLxP/sIthGrzGCNMWaI7CMc0WQcxtuvNLoZUXw7Hbi3OUkVpnCbXA/fRYSN6p1ssDjwUYklTsMCnqVPaFEY8qVETmn9RaqXMSu9kvME1UFIPjPBnejz0sOhAimrE3Dd80HGEq1JvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4rPyQY4QyHyygkxAh5qiWdwc40LavkYw011/z1rWFU=;
 b=Ct5Or8oLBni1q3AM0QHXUEQezMqJ420vZN26ymVqHTgX40ieYC5VxiN3Pq8fVn4v9rx5rKRSYPpashWKgJlwo7V68HXJBFqZVTwSPJeQs7XAk5LltimDUpdoHpVry5KbROGnamHMBQ+w2frLciqb5XA8TAaHk4GmU7499NJ2oOZGuU5M8Aaq1mC6qoMc/qMYIs4mShZXqiXo+5hFesUYngzTI9Gp7lWrZghG/vGCo3a7nNuA6bFDjsDt3PXcjPl1sof8PfRuTDz8GdF2JGlgJ65hLWTjP1Lc18QUT0mwoh1rsWBFWpGmx8crUQU+0Hct+Bk09P2BFf3O9KxfXvIrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4rPyQY4QyHyygkxAh5qiWdwc40LavkYw011/z1rWFU=;
 b=QEGV/dQSpYlL507nv7kRs89gIYzTBJqdNMoUUd0BRwdCTEi5VV1mmnjMDUroGCBiCXeI8zu7wTTXuKl+i+J+d0o2kGwyPm+iMmQG1dhDnEUXB8/tFchkdlyaALTjZepSBnTa3Ji8odGHu+YoOYVh9zCL3Yzrprn+Xsg6aC0AGPk=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 11:17:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 11:17:41 +0000
Message-ID: <6bf7b4e1-2c55-f550-2395-f0b7e83e3056@oracle.com>
Date:   Wed, 30 Aug 2023 12:17:35 +0100
Subject: Re: [PATCH 11/12] hugetlb: batch TLB flushes when freeing vmemmap
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-12-mike.kravetz@oracle.com>
 <2154ede0-aac1-c802-5470-3648113fcaff@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <2154ede0-aac1-c802-5470-3648113fcaff@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7373fe-533b-4328-a4f4-08dba94ab9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18ekfwrcervAn8WsjBHzJ35eSK9F1qXDtIeYcZ65+Qg8D7qIwwzmwVIYdUgAG0zrK8uzrFFZ8sVERxRhIkEVICAdWo80Dv8+OgSCdFuy8FIYXr5/23AMSd4hyHzYlmZUrpXBkewXT6l/OC0Sc/u19kvu77RhL3Gu8th3EqZDZQRT5Vqf5Z3pbd8fPtJhyWukstBGlRGfln9lQjRxRF2PqDbBNw2BXe7Z7nClF5BISmdX3Joe7FNZI0dwo9eyAZOyeM7ElvcjUyz5MzODJJ8uG8N5s7gjqfvl0OkqMNynvjN7+8vE1N4DnNpNKdTy1V2dHvPNgM1tg9dScPoQL8/IAk1YoPAnuLApaUj6k5fQEsukvJZUC90sI/NsC4rdYzK2d6cLuGLEVSBPOjSZNr076NRCodFQolld6jGsFA0Vzm9bfJUGq/pLKAqaUcLY09xmG9Y1ab6CsJyLL06JMcCZN+Z6kJRZYTZRpGstrPNkz3gc4e0duEuZMmm6rSzwq0m6EE2ABKeYsomVkU5WwoTKaFhwZtLSmLn0l+n//ZNx3dz2Gr+9e4tbAyzHx7YNC+1QNl3Zn1E6NN2f0pGmtrM9ApmiMxyaGurPMnDLrc3QaNtAMYBIKLcFVpmZrlIGixmy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(26005)(316002)(38100700002)(6636002)(41300700001)(4326008)(7416002)(2906002)(31696002)(86362001)(5660300002)(36756003)(2616005)(8676002)(83380400001)(8936002)(6666004)(6506007)(66476007)(6486002)(66556008)(54906003)(53546011)(110136005)(66946007)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdXOFJrTXJha1dxVllQOGNRbmJpYTlPaG1HTHRtL1Z0OGtKeFNpb3puZEtX?=
 =?utf-8?B?ZWNTZHVEdkM0OFFRTm85cFd4Y0ZtVmhVc21pWXlOemljc3RNMU0xZVQvVk1L?=
 =?utf-8?B?UFBTMmtwVGhzTmJ1OUlIRnM5aUxxNEF1RzdoQm00OU5ESW5nenBpT1JrNzNL?=
 =?utf-8?B?SE4vZ21DOWxRUEk1eXVrYlBpYmRDZi9uQ3hTVEtTUis0VzB4ZkdLQ0dCWXNK?=
 =?utf-8?B?bFJNRE9sZ0pldTZUOVlXV0RzcVBPSXRMbENzUi9Ob3JOSFNBelhJeDJxOUl3?=
 =?utf-8?B?anpvUk1lS2V5Y0RaWTdjTnl5WTMvb1YrMFZRQzAxQzVxVGQ3VEVwdmRTekxw?=
 =?utf-8?B?TzRCNnFDUVYzeTRRbk5GUzRZa1ZKQmh2ZFQxb1g0aS9Ic29EQ2pWZzNZU0Zl?=
 =?utf-8?B?YkY5MWFkOUE3NVNMZW1SeHhXUWlLRU5LS3B0emZaK2I3N2kyR2ZVQmlsalg4?=
 =?utf-8?B?Z1EwUFBOelVPZDFHelpIbjVqMVZUZFV6VVF3bnpPYmNhOTdXdkdpK2JmVzVS?=
 =?utf-8?B?SC9JS3RLMm1jYjJrRHBrY3NKdFBad3htUThVS2oxcXpubi94aTl6K3MxQjlt?=
 =?utf-8?B?bGF1RkhHMGQraHJZdjVhb3cvalR3bS9HTGRPUTN5dUY2Qnh3czZBVXVqRHJM?=
 =?utf-8?B?Z3htS29YN1VkK3hpQmNka1YwR1pldUgyUmhsdGF4WUxvYkdRa0NURWRMQXdq?=
 =?utf-8?B?a2wzeFJFZzRqdGxhQytaTUR5Q0tyRkJXb1VzSm90Vm8xWEYyMGFUeE9HSWJk?=
 =?utf-8?B?aU5KTjI0MmQ3WHBtZ3pkQ2krais5eGIxRFR6TFNEYURRbTJDWlFXZnZxaXd6?=
 =?utf-8?B?N1VZbVBJQ2VqN0ZJUVdnYTVCOFd0THI1NGZJSURVVWppUjdrZ1NXRmJHbG1K?=
 =?utf-8?B?K08wRHpEQ2h5MlBaM2F3K3gwdEUxOE10NEhBZzZNV25lZFpSbDZtc0lvUjlL?=
 =?utf-8?B?S1RONHhDcDNhQk1vejJ6TWowWEYwT2FZNzBKdk91M1FadzkwTmgwWjJSb0ZL?=
 =?utf-8?B?ZisyaWorZ3V0bHZGMUdubVNPaTJuVjBsZlFZWmFoNFpKb2JFSUdaaDBkbGZT?=
 =?utf-8?B?aHpxQkxaMVJ1Tk1mSGswNkN5dFdzVmVObkIrVGdDcVdiSTJYWU5aVUw0bGQr?=
 =?utf-8?B?WDNETThFc3lNbTBxa1Vuc0U1aWQ3OFRGSEZBR0xMbXdsTXJqRStUaU44RUp3?=
 =?utf-8?B?QzQ4UmFLeGVmVE4zU2FIRHczbGpyV1BuWkswOHhEclBpQVU2dlU3aE11dURK?=
 =?utf-8?B?cEg1VGpHSDM1TU9EVWZHY0RnOWJ3K2xRN05KQmVDcHYxVVJXdUh1bHNiaHVt?=
 =?utf-8?B?QlFlUjB4a1ZFRitETm9mNnhWZFVIRWg4Qi92bTQrOXZzMUE0YjNscmQwY3VE?=
 =?utf-8?B?ak1KNnBCeUVHQW5aZnNWaGFyTHVueHpLZUVsU3VJQ0laV0xDSGtQa002cVdR?=
 =?utf-8?B?OFBJbXFHWUkzVUlHWXJteDZ2Q0ZRRHhuM2tvVUJsempqeUtJTnVCcWJsQ1ox?=
 =?utf-8?B?ZXZRNCs5NXlTNmM5STllSGJTWjBseTZwNWpJVWZaS3A4cWNBT25EcjhWMzNu?=
 =?utf-8?B?cmlZdkl0dG5IQmFRQzluWTZCYkFSSjRnNkQrS2FpL1AyRlZTUlpTU3dFMk9Y?=
 =?utf-8?B?U0ZVTHo2VkhobjZDcFlKV3pheWdiZ3R3bG9GK1p5dkhFaEhEcGlyWmZBZ0xl?=
 =?utf-8?B?NVJ4Zm9vb0FzQi80SDdFSG9jdDY0OC92VGxOQXhRNGZlMy9ENGtQMXhTYTlD?=
 =?utf-8?B?dkVrcGkwRWw3c01vNEd4UVYvR2dIbmZkZGVjd3hsSDl4V3BaMG9ScHhrblpP?=
 =?utf-8?B?WFhsS2hncDE2SERibXpxOHlrYitGZlF3aDJDSTVBQzZiMStjUU1hSGFTa3U1?=
 =?utf-8?B?UTdpWm8zNS9vVmU2QVJqZlhsa2IvMTNRZ3Q0bDNtOGFVdVlCaGxYYzZSaXcz?=
 =?utf-8?B?S1VNa2E4c3JJbkJCWkdiNWQ2eG1OK1dWakRpVmVqK3NrUlQ0SW1QN25IK2xk?=
 =?utf-8?B?NldQMlB6Z3M2ek12TkVjWWM3OVlsZVZNUVlLMi9lMGFjN3hzZFRQT0dUbXVk?=
 =?utf-8?B?MWtFVGEwMXdZR21uc1pqWlV4U3lXbStIRDRUSXhtTFpRQjkrM202K09heERJ?=
 =?utf-8?B?ZUFBa2w2eThIYjJjdlRnOVB4TWRjUE91SnJpUDNsNkZENUcxTEtDVUVoR0xh?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WGtVMlBnZUV6WGM4N1QxU1orRzlkcmNoSVBvOERBRDNOUXBRZmNSeEtraFZK?=
 =?utf-8?B?Q3o3NDNadFpnSlJrYXVLN29rd3gzeHIwMWJieFlMZmhsZjBOYk1pejNUbzVy?=
 =?utf-8?B?WEF6UVZ0aFk3T3R4dUFGbXpsOGt2NDMxbk53YXkzV3laTFA4L3V0UkwwckZ1?=
 =?utf-8?B?K3dsK1I0K2x6eUd1LzVTaVNFR0ZyMlBDMUpmSjhkbk1aaWwrT09zc3RLVXd0?=
 =?utf-8?B?WW1Od0loYkFrRklYSEl6UGMyL3NKMTdLRTV4RVkyMWthTDQwbW1GSTV3RTda?=
 =?utf-8?B?ejFVOThFTTNrOUlEOFArTE5mdWlrTHNRelpyRy9NdVlIM3JZSy9MS0tQL0hz?=
 =?utf-8?B?eG1ITk1QWmMxbFY3VnR0THByWXMyNEluaGpSNXMrYlF1dGhsTDNrdENIYjc1?=
 =?utf-8?B?L0Zaa2huMVpsNHBlcFhBbi9BM2xpOXNjY1NaaWpRaDhVY3h1RzhHZ0pjbTR3?=
 =?utf-8?B?ZEFDNHFwYWRtMzNYWFB0cktEcFVSM3o3aG5qSzRqTTFrYXdTUjZuc0pYUnc5?=
 =?utf-8?B?c0x6VCtsdkJxSnJxSHI0T0NFNkN6MDZwN0VDblFqakswWFVJa3FUeE9McWVP?=
 =?utf-8?B?cjlmT2wzOWNYYVUzUEQ2ZzVwdjJuT3FMWTc5VUhMd0c3dWtGL1l4dU9yTWdE?=
 =?utf-8?B?UXcvcDMzUUJnQlIybkFTM0gyazhtOFJFbEhqS3FmYzdWZTRjZlZvUnBvT013?=
 =?utf-8?B?MkpmVTh0K05LVmhLTkRCME92eWlxUDNaU1Y1SGR5NXR3TnYrZnlvZkwvdm40?=
 =?utf-8?B?UXZDT2QxSmJIaTdmaFV1TWhwbnY3OEFUWFYrWVhhRlBaMm5qY1BHNVdBMFVE?=
 =?utf-8?B?bTlvdno4TXJpbUYrU055NnpidFlHWTZlZnllRExWU1JYOVo5cW1SNWk2UWRP?=
 =?utf-8?B?ekp6VTBDVEtXVnArdjk2RklNVkZIOFVzOW5yRGFScmE4WVgxTkhvRldxUmtQ?=
 =?utf-8?B?RUlTWmJZOEw2OEhrbXlZNlRwZjcxTjBXbGdYZWJSV294YW55N2FaWW4zM1dP?=
 =?utf-8?B?cUs1WTRLM0VYU1dMTEtnV1NyWE0rMGMzbjlrSnByaFhDM054a3REVjFxK2pn?=
 =?utf-8?B?a3l4UStrQ3VNOHE5ZkNwVzg3RVpJUlNDVlNxUlFhbThwck9INjk2Uzl5SDQ1?=
 =?utf-8?B?RndKVzZ2cVlYTnRoMmx3dW1wU3o0Z1YvN0Jta0JBQjJScnFYWjhBYUNjOVFD?=
 =?utf-8?B?NTUxdVdEVHdpSzJmU1lqeVA3Q252STBsMWN3N0lnUlFpaVNqQ29ucFo5LzFG?=
 =?utf-8?B?Y01PRDhrL1JjYXdwb0pDcWJ4bW5lSUxzYXd0cVZZcmRPa2lpb3U4MlR1OEVr?=
 =?utf-8?B?QmdlS2w0TVQyS0FOSXJCZjdkNHFwSDRsWGZZdzVhdFFETG5BWG1NaFExcG9B?=
 =?utf-8?B?NWlhY0ZyWjN2OEtOYUZWeXNUOUttOGh1eGJtTmw3aXlLcVpBSTRDWFkraTBV?=
 =?utf-8?B?WkVpbG1EVityZURhOXQydlVTc2V0ZzU0VVhmcWE5bTNNdjZOdTdCeE8wOVMr?=
 =?utf-8?Q?WQKpLizot2lf8aWt4VTEaDWjqJZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7373fe-533b-4328-a4f4-08dba94ab9ec
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:17:41.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6FtwD1bMkXRfBjp+Z+ANtcBCKFxrL0ZJA8JFbsmcvm40c4a/5KI+7qfEtnnridLpXXs/2gSQArYSU8TqjbY3SEAq3WZaqOWo4qKxUJ36Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300105
X-Proofpoint-ORIG-GUID: mU8p1dJe-X0x4VnHlWRFzOXy3iqB2UR4
X-Proofpoint-GUID: mU8p1dJe-X0x4VnHlWRFzOXy3iqB2UR4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2023 09:23, Muchun Song wrote:
> 
> 
> On 2023/8/26 03:04, Mike Kravetz wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> Now that a list of pages is deduplicated at once, the TLB
>> flush can be batched for all vmemmap pages that got remapped.
>>
>> Add a flags field and pass whether it's a bulk allocation or
>> just a single page to decide to remap.
>>
>> The TLB flush is global as we don't have guarantees from caller
>> that the set of folios is contiguous, or to add complexity in
>> composing a list of kVAs to flush.
>>
>> Modified by Mike Kravetz to perform TLB flush on single folio if an
>> error is encountered.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 904a64fe5669..a2fc7b03ac6b 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -36,6 +36,7 @@ struct vmemmap_remap_walk {
>>       unsigned long        reuse_addr;
>>       struct list_head    *vmemmap_pages;
>>   #define VMEMMAP_REMAP_ONLY_SPLIT    BIT(0)
>> +#define    VMEMMAP_REMAP_BULK_PAGES    BIT(1)
> 
> We could reuse the flag (as I suggest VMEMMAP_SPLIT_WITHOUT_FLUSH)
> proposed in the patch 10. When I saw this patch, I think the name
> is not suitable, maybe VMEMMAP_WITHOUT_TLB_FLUSH is better.
> 

As mentioned in the previous patch, yeah makes sense to have a bit just for
no TLB flush and perhaps we don't even BIT(1). We can use remap_pte to tell PTE
vs PMD flush "skipping"

> Thanks.
> 
>>       unsigned long        flags;
>>   };
>>   @@ -211,7 +212,8 @@ static int vmemmap_remap_range(unsigned long start,
>> unsigned long end,
>>               return ret;
>>       } while (pgd++, addr = next, addr != end);
>>   -    if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
>> +    if (!(walk->flags &
>> +          (VMEMMAP_REMAP_ONLY_SPLIT | VMEMMAP_REMAP_BULK_PAGES)))
>>           flush_tlb_kernel_range(start, end);
>>         return 0;
>> @@ -377,7 +379,7 @@ static int vmemmap_remap_free(unsigned long start,
>> unsigned long end,
>>           .remap_pte    = vmemmap_remap_pte,
>>           .reuse_addr    = reuse,
>>           .vmemmap_pages    = &vmemmap_pages,
>> -        .flags        = 0,
>> +        .flags        = !bulk_pages ? 0 : VMEMMAP_REMAP_BULK_PAGES,
>>       };
>>       int nid = page_to_nid((struct page *)start);
>>       gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
>> @@ -427,6 +429,7 @@ static int vmemmap_remap_free(unsigned long start,
>> unsigned long end,
>>               .remap_pte    = vmemmap_restore_pte,
>>               .reuse_addr    = reuse,
>>               .vmemmap_pages    = &vmemmap_pages,
>> +            .flags        = 0,
>>           };
>>             vmemmap_remap_range(reuse, end, &walk);
>> @@ -700,6 +703,8 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h,
>> struct list_head *folio_l
>>       list_for_each_entry(folio, folio_list, lru)
>>           hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
>>   +    flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>> +
>>       free_vmemmap_page_list(&vmemmap_pages);
>>   }
>>   
> 
