Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC678A922
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjH1Jo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjH1JoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:44:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D001AA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:44:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S9O9CB014053;
        Mon, 28 Aug 2023 09:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=q9xbdqWraSZrYLDDQTqVwpxxK3LfrPREcw5rSuw2WTU=;
 b=HS8grrxf8Jc6fae3lgIhyDoIc2upuSAP6wIftJQOPNx7wQUExZy9bS2nZoXtRSZQtaPF
 AjEZ5HNgvXgDzWg962LqVxkP+QLa+I7lOcI60Dq+7xzL5cL2cXAA+C92iD/F6UwkBoTH
 5rUOEXSBe02xcOs6rBl7puLGTrhYwSYeXwL7qqFfvgVRkbU+Mw/apGTOd6+QxuTquGSb
 1hGP4+z4aEyVVbXiDeG4xVsFml4H2UdQtfffotjKUmbDwg8QRLahX0eo6HWLLFnJddOU
 tbg78ZJuh1U8kww70Bnan3e9yTaOoSF/4o6XXY1anYCQS+JYJEQ95hVjppMhYkIOouOt lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcj9w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 09:43:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37S8ZKbM026369;
        Mon, 28 Aug 2023 09:43:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hkfw2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 09:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBjqFnEoNs4/3/90WYvRoKAl0uB2xy5UpdWt1IgGaro2eCUNT5w20qxlCrjs22VIURuHvcEiEBi+oQWcSVPTs4v1n/X3TO8zNqQifQB1BTY+hrSSpE3xjPMxOPCKhaZaAiTyDWbhU9+ZZcpMm/Bn0WQB7dgABPtGV1zQPVuY7mxkrE/2B55mofDA3KRmAn2pz40gKOBgeeslu22+gJ+4IMMW3ksPY6XPHEPl1AJgHUEkFnKwrtgXUpc5NQkEDf6+rgRrU8t27HXezLHB/6VQxc+HtNkQHRlTNXIZCTlOoE0gH1vPD6qU24dkQ6a2I2EF7uuWN7e1/dHxlgJ8mpDAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9xbdqWraSZrYLDDQTqVwpxxK3LfrPREcw5rSuw2WTU=;
 b=Q67CT+/5A3Lm3ewddJV66PnaNTGN6ES3I7I0DKgDcR+qO/tqQyHWrGgIpyEyVfNm3FWeh3nPn1OcNgauG7l68nJrnS9ieNyYYIDnazqr+UMcHI06UTm8N91zUtx79wmNPKiMcng1chaatX1kvEwve2GZzh2BW+dXsMHiLnzYh9HoNtl1hyO8OCvXgvzMBuAWzDQfserNJK3gXUNsNuKK9K5Na2OPiuVYve6CuCH3mzfyXGAPj58erw4db1unpDrmBU7brm7V/tbgj2d9zCe+2sUeNX6Mx7BsxahfHm4nu15pHYDDhLCWT9bUihjfpH3nP+py2INaTHrQx5eauQq4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9xbdqWraSZrYLDDQTqVwpxxK3LfrPREcw5rSuw2WTU=;
 b=j14PH0OtNUy5w9Ve+F6bh/AahhwnyzzRJmMqVW0wc1AZy7xfM0YnfrmbMHNfoh+FMiB1cP2HSk1f0afRva/gJPYUuP8nKN3k9TIvdWW+Hg6KXj3DeWCZNOorQFnCXDb4iMEFkmvBreyv3gwR9ZIYEkp3rsIblH5yAsmKVgAacpo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 09:43:00 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 09:43:00 +0000
Message-ID: <d0930856-15cb-559c-4205-5d1352b075f7@oracle.com>
Date:   Mon, 28 Aug 2023 10:42:53 +0100
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
To:     kernel test robot <lkp@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Muchun Song <songmuchun@bytedance.com>,
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
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-11-mike.kravetz@oracle.com>
 <202308261325.ipTttZHZ-lkp@intel.com>
Content-Language: en-US
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <202308261325.ipTttZHZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 611aa160-671e-46b9-f867-08dba7ab2a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNuA/2Kmhs3IHz6Bzz2LOXEaF+n3wsDE8R0taK/oi2H596Wesf6hDWIZNljn+OlxazXig6bMC/IOPndqynoXmFACPSnzEeAhrMXYZ5Q0LP18gbpPYUBoWaUBp86UvfvREVhmoEY3u9ytMQ6DuKTwg3eRpy/80Lgy/o51ZCVvgu1vJRC2tnpF9rCCTARf29LoIPtyF9NtoJFEk3t+TE7PSNFKTPI97nf/lD3L3eiYMaC4sU28qz4yoA2wVHhB6gVLg7B3BAE+lV090O/uBBSwD52mLXS/cPu7gsGDQrDtw1xWtbNz93pF0xSAR49bn3ZafAFkzF4fcoFXHipAbhZTes3ysJgpdG3Liprgnse578u04/Aocy34wz3i5W+UucufmTzg2X/a0tAqHeWmi2pcoXbQ4mNUzHvJNsw8Or7EB0tgj8/AkRxJYKryIBE9Hwg3eG30qVCt0nTMwnwSVN2LoJGe5sQZJsWWldzIQaRr66DTXYr/0tXJeI5u1OaYIWdfAywYakHUe5TCX8TUe/gLM1/qqrspViZAwhYTgoO+I2aiEmoQCT8EZGFiDWednumGPspQho2S+SIvV+/4qJ/uNDdfY/P8b40Ddfq8/GRUc480MkovjmuoOcNeKkRvOIDxpRdTDps/4ViWbdUwHCEp7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(1800799009)(451199024)(186009)(54906003)(66476007)(316002)(66556008)(66946007)(478600001)(110136005)(26005)(6666004)(38100700002)(53546011)(41300700001)(86362001)(6486002)(31696002)(2906002)(6512007)(6506007)(966005)(31686004)(8676002)(83380400001)(8936002)(2616005)(4326008)(5660300002)(7416002)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnBzbDhCWWVEOUZKNUhsSDR1MkNFVjdLVGZ1ZnZDaEdVSWpJWkg0bFlueUl3?=
 =?utf-8?B?elpmVHJOOWpiNzVUM1JiOEpaYkVaOWVVRlZwNFlBZHlWdFFWdm55SmF6dlMy?=
 =?utf-8?B?cWppTkJOY0Y4akdScDdKNkV1amNzMDhjYkVOaStQaTVma09iZE92cU1Kd3VR?=
 =?utf-8?B?blp1VVJHUDd1QWwvaTJ2THJtMERHcmU3Y3RSYjhYVURnOVM4ZEkxYm56RFJr?=
 =?utf-8?B?VkoxVEJkQ0YzTHhRQktqdit4UVhKb1dKd2w1Y2lVMHJsdWpmeG5VYzhoZlk0?=
 =?utf-8?B?QkVGOS9LV09rWXk0QlBLZzRRN00yVWJoalFLN0JKYWpLWEhQdmU1dDBxSUtm?=
 =?utf-8?B?QXczUHdCUXVnNDVlOTdHeldMYUM3NkV2MXNKUDROakFqaStJdExidm8zWkhk?=
 =?utf-8?B?QnNnRkVGSVZYNk9STzBYSnJkcHVEQXdydGN1SzhVdzlFaW9SUi9iZ3J0OFQy?=
 =?utf-8?B?bE1MNDVRZWJsVGdNUEV0NVM1eEo5eFRNQksxMEVJenB1bElmSVVLUVYwU0lH?=
 =?utf-8?B?SWdJeHFSMjdrWjFQTGNtVk1wTWJERkVEMGhiWmhkTENVZ1pDOFhpVnBmc1JV?=
 =?utf-8?B?K0ZjNHUxWlhRMkE3bU0rVm1iMy9CajZuRUZEaW42Sk1KUmg0RmhONE9WMmJv?=
 =?utf-8?B?RjF3bVJQVmsxd242SVJnUndleFpxL3NuS2NkTysyNmhnbmZhMDJ5MnRhVTVj?=
 =?utf-8?B?Wi9LZUNsNmIyUGp6L0d3QXJEajFxQWFtR0xva3QzdjVETlZOcVZhVlNoTTNk?=
 =?utf-8?B?a29SUjhZLzBNVzU0dWJMRkFPS1BibzkyaVF0KzlBNzNmYytLNS9LTXphVWh3?=
 =?utf-8?B?RjhyUkVNa202TEYzSTcrK3dUS21jalYxMEdvRTgzcUg1cTZKUDNkNmFheTJp?=
 =?utf-8?B?eDAzanZid1pNRUpNMyswcTNLbWYvV1V5QWNQQWFBVEdRRlVRTnhNL0NEM0JB?=
 =?utf-8?B?RGpxN1ZyKzUrQ0MxR21yR0p1YThiaERZNy9SWHR5UGo1SVE3b1lNRzZzVzRw?=
 =?utf-8?B?ZWx0a1RWWFp2QkxPLy9LK1JpQUliZkptWmlMbUpXeDZyVFcreDc0YVRtWm5q?=
 =?utf-8?B?V3BhS0hYNkh2Rk16N1V6RS9hZ01CdTFrTEd5b1hnU2oybUt1YmFYTXFCM1Fm?=
 =?utf-8?B?ZG84cUJGODFKMWFVMVFDS1FDMlVleUY3ZEdDUTJjeEx6bDcvZmo3SlEwNzNN?=
 =?utf-8?B?L0ZJc1N6MDQxSEczYnhodzdRM3pOSmhQaFREb2E4NGltME9QTkNzWXdvNjdp?=
 =?utf-8?B?QlM2ZERGRmN0WlZjOTZ1dW8rc2ZMQ0JzRlJ0NzNPMW1hckd3TVZWMURQamZz?=
 =?utf-8?B?NHFlQUpLR2o1UWZvTWtrbHRNU3JBaEZXOXU2RWUwSkdxVFVNT2hQZklodnY1?=
 =?utf-8?B?ZWcwbkg5T3NlVE5UcEROV3luR1Y4STFxcmFSM241M0lWT1hKYTdkMHN3ZWFo?=
 =?utf-8?B?UjlhbFVMREt6M0JKeXhmR2UyZ2JJTjBidWlwb2QvSmZHMDZDQUhGNlRkekRv?=
 =?utf-8?B?NzNYd2Y2c1ZQdUE4U3VIdWh3NlVHOEdqcm9VYjdGdVZBY2M1MTROM1NLQmdY?=
 =?utf-8?B?N21RQmdLeUdSV3NSdGRmTFpGTlhZcC9uNlJTNkIvWnNNbzdYZWlmWmJRWFdp?=
 =?utf-8?B?TjZRMCtwblM5QnJ6REdOaFI5bERhME0wVTdaRlRLeE1Qb1MwK3lQY28vMFN3?=
 =?utf-8?B?NlEzMFdMTmZKVHFaTEF3UENHZE5jdUI0KzdLYUNmckQvbURvUFhrOTNJa2Qy?=
 =?utf-8?B?OXNtU3I0OHFlV1FXUXExa0lLUldnV2dRYTFLVytJdDFvalAxRUVhS1d2UnNL?=
 =?utf-8?B?NnY2aVRRM3Fuc3llT3piY0lSWVZ1UGhndmxKNXhMZmI3ek5yK0NzbXhuNlAr?=
 =?utf-8?B?UUFtTi81ejZYR1pRcjlxTzRPTlBpWXo5YTB2bER1aXZPRm9sdG1QT0Vldm0w?=
 =?utf-8?B?aTNZaHcyWWdQWDkyc3pobDI2K0wvVGNKQmVWYytuR3Uvb1dHbFNiTVc3NGI3?=
 =?utf-8?B?WHhEQTcrb3EwbnVwS2pzbGFrZFRDbGxaMDBvdWJFYkVEOU5vM3RVUm5wUEI0?=
 =?utf-8?B?TmtVRG1FMWJvY0hEM1RkWFdTSU9lQmxXOWhUZVI1bk5RaDVWSFpxeDNxY1B1?=
 =?utf-8?B?UHoxS3BhU3pZdjhjZ0ZQbkFIV0Fpb1FjRHJkNmczU3ZZZlMyWmpDeEhOVUFE?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dDEzbytlSDh5SXFvV2ZDQXNmYTRscWpFbTZZcm9vZGNtTlJXTzJodGpLMmJG?=
 =?utf-8?B?KytmUnhrRWpObTh0Z0FyOWJJWWtKay8zeHhMZXVZK1ZQM09zbEYrSjQreU5M?=
 =?utf-8?B?bCtEM041eGMvUHkvQmVvWDBTdG1PSk42QmNUK3YrWkxBdXN4M0V6empLVi9E?=
 =?utf-8?B?SXNsS1I0ZHpKa05PUWRySUZPZUlqVmRURmU1cFFZaFl2ZFE4TytyNVJQZ3Np?=
 =?utf-8?B?NmZGSmsrMnMxK1ZJbFRnYWYzZHh4aWw2eGJKL2Nyc0hRcHVhZkZQWk1CbWw5?=
 =?utf-8?B?MWVCMWJxTElPVldna0hESXk3YWZqclRBeHB0WUhBWm9UM2ZSbUs2WUFUSVZm?=
 =?utf-8?B?TE1idXcweXJmdFF0TUNaOGRSVjR0YklrZGk2WllHQjlXYnVYdUszejFSbllT?=
 =?utf-8?B?MDZmTm1LaE9sZEllb0VYeHRkN0p3SzNxKzBscEtPZHlhalhLaUJuMnFGbVZq?=
 =?utf-8?B?SWp1RHRCNXdCYkVjVnlPY3BPblZVeVpKa3dUWTV3WFlHN3cvbVpKZGM0NlJT?=
 =?utf-8?B?R2cyaDFwcFRsZlFsUEFTaS9QUnVDMGtsdnhGWkFtNmZsb0JEYVg5ZGF2ZE9P?=
 =?utf-8?B?QmpzMEoya2MrZlZrWk1jODRvZGVZdk56a2pvalVBWjdQalFwaGZ4YnpMVHFw?=
 =?utf-8?B?R1hndUpiY3d6d2xKYmVQWnp6d2d1KzJ3WUZHMWN1T2tWWk1uTGZZTXpZR2VP?=
 =?utf-8?B?M3QxVzdWZjlVRTRkRGh6ZXFROU1oTUljL1I1WkpmR2FBSlEzb2hueHd5aldC?=
 =?utf-8?B?WUJONU44bnZyZVZVajdORHZUczZZZlk0a0lyMlRTYXRJR1BDUXBMWTFDaE1h?=
 =?utf-8?B?OVFhM1FwTVJjZTZkZWx1L1BmZnI0cG43eU1WcUljbktvQU5CSWY2Kzl0SFhy?=
 =?utf-8?B?aHpWMGQzcHN1enFFYk9Wc3ZLcFd3Tlp3WlNzRng2S2tyWUIwVGNsOUJ5VGVC?=
 =?utf-8?B?cmdVN2VQaHZBZ0ducmZzd1RENFhqUFpJWUJabW80VUdqN2g3cFNuc0pqZGhs?=
 =?utf-8?B?djhQcHpPRDU1aXVZNkVJK3dIdDJpQWZFVDFtZmRnS3l4YzJwbTJZaHNJN1U1?=
 =?utf-8?B?aWl3Y1JOSG5Gc0o1ZkgrK0xZKytSOEpOcHZkS1lmdkRycG9SMjkvOHMzbkNv?=
 =?utf-8?B?dFRxc2p5akRpTzB5N2V3ZlZNRzhPK2JLUWZ1cDJvMkNIUHErVkxqeFhKVU4v?=
 =?utf-8?B?T3BKUnZqSzdHR0RNbjhGVlMvcWd0ZHR4bVU2MVhXL1ArV1FtN29yRlpNYThs?=
 =?utf-8?B?Q1pkV2VIRUdZaUZSL1ZPaUo5ZTMyVlVRd1hBQ1VJa2VidTd3STZBSFVDOUEr?=
 =?utf-8?B?Qnl0bkFhRUpwTkEyQ1dOVmZBRSs0RDdoNDA5STNYQk1ha1Uxek52bXNpa3o3?=
 =?utf-8?B?elBKTzdlT0ZlenUzZWlZTVZFbUFveFhWRVdoTm1mME5oNlh4ZnhTY3FhWHVG?=
 =?utf-8?B?R3U4SFlpVmxDNFFJYTBXK0g2R2RZSmd4eDdMM1lQT0E1SXBScWtGUWpuK1NZ?=
 =?utf-8?B?QStFV21uVlNyZXRaM3R3UEVaYk1sTS93eDRHak5nM2cvaFRYd0xrcXl4MXd5?=
 =?utf-8?B?c2NkMUpCREN6SkhybkxubXk3Y3d6OTJFZjZ4ZGYwWUZxUUZDVFUwZkF2QWtu?=
 =?utf-8?B?TzRxQzkvTi9PV2c4OXpDWlFrb0NzMGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611aa160-671e-46b9-f867-08dba7ab2a9e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 09:43:00.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erpiL4bXiFa2yGk/yyReQo2vrjgXvBX0513NLQv3Sfd6Rlb57Y+PYQIKADLFwaymAJey8j9NUc+ccSZym7JOWDidjCQDFMfPiByeNUZ/9TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280087
X-Proofpoint-ORIG-GUID: EpHTa36S0IWY5gny9PzsN8TMe2XVAUhH
X-Proofpoint-GUID: EpHTa36S0IWY5gny9PzsN8TMe2XVAUhH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 06:56, kernel test robot wrote:
> Hi Mike,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20230825]
> [cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 linus/master v6.5-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
> base:   next-20230825
> patch link:    https://lore.kernel.org/r/20230825190436.55045-11-mike.kravetz%40oracle.com
> patch subject: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
> config: s390-randconfig-001-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308261325.ipTttZHZ-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 

[...]

>>> mm/hugetlb_vmemmap.c:698:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
>      698 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>          |                                   ^
>    2 warnings and 1 error generated.
> 
> 

TLB_FLUSH_ALL is x86 only so what I wrote above is wrong in what should be
architecture independent. The way I should have written the global TLB flush is
to use flush_tlb_all(), which is what is implemented by the arch.

The alternative is to compose a start/end tuple in the top-level optimize-folios
function as we iterate over folios to remap, and flush via
flush_tlb_kernel_range(). But this would likely only be relevant on x86 only,
that is to optimize the flushing of 3 contiguous 2M hugetlb pages (~24 vmemmap
pages) as that's where the TLB flush ceiling is put (31 pages) for per-page VA
flush, before falling back to a global TLB flush. Weren't sure of the added
complexity for dubious benefit thus kept it in global TLB flush.

> vim +/TLB_FLUSH_ALL +698 mm/hugetlb_vmemmap.c
> 
>    666	
>  > 667	void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>    668	{
>    669		unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>    670		unsigned long vmemmap_reuse;
>    671	
>    672		if (!vmemmap_should_optimize(h, head))
>    673			return;
>    674	
>    675		static_branch_inc(&hugetlb_optimize_vmemmap_key);
>    676	
>    677		vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>    678		vmemmap_reuse   = vmemmap_start;
>    679		vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
>    680	
>    681		/*
>    682		 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
>    683		 * to the page which @vmemmap_reuse is mapped to, then free the pages
>    684		 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>    685		 */
>    686		if (vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse))
>    687			static_branch_dec(&hugetlb_optimize_vmemmap_key);
>    688	}
>    689	
>    690	void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>    691	{
>    692		struct folio *folio;
>    693		LIST_HEAD(vmemmap_pages);
>    694	
>    695		list_for_each_entry(folio, folio_list, lru)
>    696			hugetlb_vmemmap_split(h, &folio->page);
>    697	
>  > 698		flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>    699	
>    700		list_for_each_entry(folio, folio_list, lru)
>    701			hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
>    702	
>    703		free_vmemmap_page_list(&vmemmap_pages);
>    704	}
>    705	
> 
