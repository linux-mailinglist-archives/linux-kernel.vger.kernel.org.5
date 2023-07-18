Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87746757F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjGRO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGRO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:26:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40BA19F;
        Tue, 18 Jul 2023 07:26:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7ds6005635;
        Tue, 18 Jul 2023 14:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/OuJEL4GHsY/4ofLeygdv7pptQPlYzuorgrUli2W0ys=;
 b=zf0o88//M9pWvmcKeWf9R67TSuDD8y+9WSsram7d4tbnqERxulm48OjqwReZFFdEPsJq
 heT6KuQnPhNRQkidZvtoP0DkKu4LnUDv4vKPOboSZWU8h7jO1TC3Na5FhwM52HQk2dJN
 LN1+0AQ540LWl72rqPStIBm6XMBRVDYweDc12qPP5OGjrLxkvLQSrCdDZw4DY92iPBkc
 3rYySvbCstNb7+udKls8ut4jO3TuOt3wQ/VGXzl25yj9tdwNLollmJQ1bqVC4MM5RdOb
 GYyJrc7HbonbwgFcM/SFRsg4gdXJlX+N/SipHZGeTlz+XUecLxCjNb7KGV10zuvqzcRv fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76w8eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:26:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IE9ok0000782;
        Tue, 18 Jul 2023 14:26:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw566pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbBMljtofjcvS5f5N84/zJQiSvONPopJSN1ft5VPZk3eLb0uc6Lg/4gsmLXd8GHw+d9HjeTdQGvj8q0dR6vgz5FuyMCkgkybLK9BYmr5oqkRl3D7EYusUUYW5Y6b/24foRjd0QSYFWHBIqS68PIWyqOB0RXdBdiEmUQO3FingM+DfUxZHBz6edSpHQ8NPeKLkXMWZKDDw4l390kxr8TCFSVwkbY9A7qY8x7zuaWpDm/2+S/7fAmOYPunBpyWGS6XxHrcTQPSDY1tu9kfU9lWSINnch3TMCVzaMlI0ajAimZfNxgv1MXLq6WGr76j4ek0hWCemJp27ZhQDMjcVlsSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OuJEL4GHsY/4ofLeygdv7pptQPlYzuorgrUli2W0ys=;
 b=IPRdLjawHqSPC/yE7PxKh8BV84rQILRruWcavSbGnr0T0D0XuLAMMVInRYLXuHfDMtxUhgf8nIPsavrjb9ySV5tQ8NfyyEIlrKRPQlUYfkQSY71C1dLVdfnTqrWoXn0Elc0gJMk6otrKe3yO4gm0DrKed041oaMvu7nImiDPzixzqsTm3vQWTXOsORGcV3fYcn3/7FvuLkdytxkqwnLXqIO47INu7EOzfLd7YCXJvJAE8+fMZrp5sr14GW1iNsKlkbV3RP6Jg3S+nNdyJOZDLo9i1Tf4Vkqo8mpnt08bDkuCo4cIf3as5sUJkGAcivw5CzKTDQ5Z/w2652holxXRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OuJEL4GHsY/4ofLeygdv7pptQPlYzuorgrUli2W0ys=;
 b=wW4Eb57recm05aJVd1LE9q+WUL4UangXBYVEgPbKKcsj2UJx1mD+EsByIirvysjWPGmAuHm4igWUAvOSmcQVny8o2oBGlPEa1+qEwIyeApHyo4pRAkVmU/Jnv4+5tW+8KCkWPjqqQcSRQigCgMKbRciHn0Sxp8jWMnF1jM9nJnA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:25:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:25:57 +0000
Message-ID: <de34306d-450c-019c-db43-55451e7929c6@oracle.com>
Date:   Tue, 18 Jul 2023 07:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        stable@vger.kernel.org
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
 <20230717120002.8da3920c4006295bfb5234cb@linux-foundation.org>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230717120002.8da3920c4006295bfb5234cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f247baf-74f3-458a-4e58-08db879ae6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyFhBU4eZnDjWIZorXmvJhuI0ZtSxpw4Yfp+P2MBmowZ1VpTuQGuAHMsbdDwcp2rkcXatmmSKU4v8vRmNYLbLAWkvv/0UIIwIZOPOFbZz6BoBZAAS3ilDgxBgwciugBR0bD4Ha8dDhPw/MViIwPAdZas/x1YwH7ClF0MCEQLPPs4ofwy3tAXxNxWeAUuGXZKZ+zLsvzyVIlFWudC7b4wQ7RTdx0TQ1KKP83Qr080IlVP09xyIWjYIMuXpWfzCK9OubrhHkTFu4qJ1mfVaVE+XZzPF2SYfa5SJ6yFsnuCBy1CZ+nCpxzDUieVxfZOP4dqKcbNixUWEUK8XvGuNQmr/nfSxz0S4dxVCieTieUnzZUCX/QhBRUBvPY5TTbtiXbaNSblZL3Ulz5QDlrz774D/qTn45NWQEumWCLcxHVgvKpi9LBypgLwyAz4Gv5wOLvklSIKXous9jXlUvv4a50XAhGOheGiXJ3cW9kSfPWq99pYWdVVPU7EQQk7PB9CuwqhLb6/RbD4iTtDVkMmINk9BfWRoRe0ByBQzzXrgFBqC2gK2TiiC1lmQfkVJ7T6eGSEM2a2j7ZZ7xmeekhdHh4wVeVsZmdWxIyQzFnizrP0CPGV0Ks9kVwL2qYYu3h2RXLwx9xE/PztV4EA+FFK8vOqsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66556008)(478600001)(6666004)(6486002)(6506007)(36756003)(186003)(316002)(6512007)(2616005)(4744005)(53546011)(2906002)(4326008)(44832011)(66476007)(41300700001)(66946007)(5660300002)(8676002)(8936002)(6916009)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFDVVJrSGpHaVIzOVRGMGN5T3RSWjRWZE90OE5xcXdmSTJhaGxzWW4zdkNJ?=
 =?utf-8?B?N3VkMnQyUXZqejJaaUxHY1R0NUk1SzJPTWFmam1pYy9OZFhkaENuS2RSeCtI?=
 =?utf-8?B?NWhkQ2w5Wk9RZjFmRUpLL3VlQW5oVkVCdmdMdElIRGlNOW82ak12dUZpc2tn?=
 =?utf-8?B?eTE2MHZMOWU1SkJmRmFObjNPV1o3Y0dLY0ljbmQ2R00yUCtmZ3JBaFVSV0E1?=
 =?utf-8?B?OWpZV2JYUTJzbjFVWUVLUG8rTHBqVHZiQTlRQTN0dzMyR2hERW5oWGtZeE43?=
 =?utf-8?B?NEh1blBTSnlWY2NxcTRaNkJGdkppS1EwQitnYXJzTEVtU3FwNEFHQXUvNFRB?=
 =?utf-8?B?TVdHOVlVckd6MXh3bUkyNUZHQy83eUYxVFk3TlBEZzdvMTE0RVllV2RjYURV?=
 =?utf-8?B?ZXEvWEVhNjlxeEEwc21nM1dQNXBvUW55YTMwN01zWHNjd0F0SnVKTFdMeGpY?=
 =?utf-8?B?TXhtSGh5OU5Yc0p3SjhocllXSlZqTTNYaFo0UW9JK202UW9QVzJncjgrRW51?=
 =?utf-8?B?ZExFcXkyNXU1WTBXbnJkUGZrOTJBWjE1bDdWQUxFL21TSXVjQksvSjdNVGpE?=
 =?utf-8?B?Z0lRT0JURzFDc2Q5ZW1sYjRTdjl5S1Rvb1o5OHF6WWJRQ2k2bDhlZnlBaDNq?=
 =?utf-8?B?UzlLaU9hbzZWdXdXYmE0QTlDUitzeGplMWtiVGNrVUdnT3ZUUVBvd0VwRUZB?=
 =?utf-8?B?eUdvVU5Ld2w1aWpvK05oYlZqK2Y5VHZIS0JmWWhIRjZEcXoxbE9lOENOdGhF?=
 =?utf-8?B?cWJZVGpoYkxxNnowRHN0UHI1YjRnd01LZUhRTlBxcUhrazNvL0dTWXJhMFRh?=
 =?utf-8?B?OGtVcmNwaS93TmhsOFFqUGFQaGpyQXI1bGtlOFlvWXFHVTViM2JLUUJManR1?=
 =?utf-8?B?KzY5NWRhYXVNK1lrdFVObjdGZUY1bWJlRjJPVHFaakZrdTgyUVRBb01jemgx?=
 =?utf-8?B?WkRhNVQvWW5FUnZISVhWVlM5eXhVTUkrS21MSzVkZ3pxQlo5UUF5dEpVYkVq?=
 =?utf-8?B?Nm90MVNTRU5nTzJzaG9CNGNSUk9iLy8xWWIwcjdEMHBaWWpxRENwZHRZcTNt?=
 =?utf-8?B?M0ZVOXVEV0NNSEVaSjZsRkFydDdHY1lBQnVVM0hUOFc0TXd3Ny93bDFUV2dU?=
 =?utf-8?B?YUp3L1Q1cHUwWkRVaVRWS2JwN05Od3RTUmZKL2ttN2RXbVY2ZkNSRHlFdXdZ?=
 =?utf-8?B?aTRNNm5JWDhjbmRMYWNwQ2x1ZnYzbytCNXo0RE83dDhlT3Z6WjBvaXB3TGY2?=
 =?utf-8?B?MnpTdmErUDMra1pZZWl1MGdBUUZ1cDB6Rnk1Vmc3UWZZYXdwQ1liVXFIbjZR?=
 =?utf-8?B?NEJ1Ri9pMkNnNkJ4Z3pXeXBhMTQrRmUzSzdZcnZxbjZnUTVkd1hab0p5YjUv?=
 =?utf-8?B?ZWZJN2F1YUt0S3pHcWVrR1RSUytKQXVMdGw2TkJQNjBiS3JxaHdOcEk1WEw2?=
 =?utf-8?B?VEF2SVA0enFqWTVkWjM3S0xSRlRocUFMVTFoZXpqMHMrVkp1c0VwSWdkWmlN?=
 =?utf-8?B?a213ZWxiemlxNGtLcEJVK2ltOW5uMnpRTkp5eVk1cG4vc2YwUnVEZk9qVW5n?=
 =?utf-8?B?ZHFLUm11TE8vWHZjS1pjeFdrYldMemhCRkZtYkZwS1hSblhyNDh2QnF3cUhx?=
 =?utf-8?B?eWhGcllRTE1FNHFkOS9TNWVrSUlGTWhUbjNWdGN6c0EvV2ZRN1NrNm1id25V?=
 =?utf-8?B?bTErY1F2dWlFL0dmdE5oVU9EU2tEM0RLUWx6VkIxbjBicFBwZ0EwK1owcFdn?=
 =?utf-8?B?UFJ3b1JKblMvZ0ZjajcrUDRNSWlNSDZrVjl5WEtNNjBVMDczZk80dXpTaEJD?=
 =?utf-8?B?ZVlYenZITlRRNm9tYThsZ2huSkZlSUZoSEVKek5YU3lXaEVhY3dDV0d3Vy84?=
 =?utf-8?B?ejhaYWRDQ1hPU0ZKVnRlazJ2VE5DMkZVeDFJdlRjd0grdjVjVlc0NEdLZ3FJ?=
 =?utf-8?B?VHVkSjM1QW1FbUdUKy9GN1laTThIVmFBWDI5Y21WU2pHUERtYU8xV0xPQVJ2?=
 =?utf-8?B?cHYrMjRiWWF2b1FCT1RLVEN3MkY5L2toM29IYjFNYk5ZS3ZDN1JSRE9FTE5s?=
 =?utf-8?B?U0JrOVFFNUFSb1ZxUXNNSnBrNW5hUDZJd2d0S1pqb3hSNVF1dFg1R2Y4ZUJL?=
 =?utf-8?B?aXBqQnVBdHo0Y241Rml0Uko4bi94TEdZRjYzaVpGY1YydDJMUGxaVHNqcDBZ?=
 =?utf-8?Q?UwmU6NWz/wtE7B8iNU2OPKk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V1hOWTlaK0JvaGN6NitvZVBDaHptS0FQb2RaZUU4ZDlqQk85a25XU1lUTHRQ?=
 =?utf-8?B?RjVSc3lrcVppc2E3UHRjcHArbEQ5Y01iWXlMWmM3WXQydkJ3U0tHWmsyb1BW?=
 =?utf-8?B?cjFGZ0dQMWtqZUpraXlNNUIzLy9tNjIvcklUS3ZRcEF5R25iOWx6cGs5dVpk?=
 =?utf-8?B?cGllLzMzR0JJcmpzNG1uL3JPMDlTYjEwaWVCOGJidk1CZW5oVW5sMjNReFRM?=
 =?utf-8?B?S1lhWkIrN3phNG00M282NHRKMUNYMjMyejhjV2o2akpVekNURzJkc3RNTzcv?=
 =?utf-8?B?SXdxRkwrbDR3VWJZWGcxbG1oVGpXMFd4VXNRYVYxYmhSNFQ3a2pLSWlvUDNo?=
 =?utf-8?B?ZG40djhMdHM3bzlydFA5djNNWWhIMjdnSmVFWFFDVHBZeTd3bUFIQmdGM09l?=
 =?utf-8?B?NGdTWEFsK2VDZFloaG0xSWVyTGpMMjkwUWZ4eGNqZ2VQNklJNUtLUG0zOUNN?=
 =?utf-8?B?dFlLK1o4NDk2TC93dzV4NE9qTHRSQ29NMi9PNU0wWkdHYWdoaXcycGpyQnQ1?=
 =?utf-8?B?NmdGSkF0WXVVS3UySFo0MHkrRi9xajVUVmdzSHlVUXJWWUlBRURKNkU0YlVS?=
 =?utf-8?B?REltTTdEVlpUQ2RBZTdhU0ZQNlppR3h0OXBqUlNqVWFRUnR1aXVyU0MzSHVs?=
 =?utf-8?B?M1lBUzJkYXlhb2FtQ3puSTlQenhiL3laVGphVEZzQUlwM08wMGJ5M2RKelVS?=
 =?utf-8?B?SFNXdnNsM3lzY2RNRE5sSEFHUWZIZmRHV0NTK2FoYlg4VEVFd2RpS2xhUlVX?=
 =?utf-8?B?K2l6OVRDbzQzcWczRGRaT1dTbUc3ZG50UGZBV2xVRUFjZ2FRbXV4ajlkQllN?=
 =?utf-8?B?eE9ydkVKbWt6b1pTaGE4eXR4TWcyMWpxL3RORUNQTHpNS2hQYnJ5QS9jam91?=
 =?utf-8?B?SnJ5Z2Z0eE9pZVFyRktiUlJEYVAxRUxWSEZpaG9TRlpLeFYzY01OSzZSU1hG?=
 =?utf-8?B?N0phdWJ2TzFRcVVUaFBlVmZZRVV4bVVDOUREYjdhUEVueDBMemtrMmZzY1g5?=
 =?utf-8?B?YmNJYWlQZTFKeWQ0N0dkd1h4c2hWbmdSMEVYSm9WRlJYQmZoNzVwVEJDTVBP?=
 =?utf-8?B?d2tFL090b29ZN1ZaK0pNV3lhQ1BUc29rZ285Q2xMMnpuUm9hdEdPc3E2ZTJH?=
 =?utf-8?B?dzkrWXErUWxCWjZYeVpWdEV1VS9hdzlqUzBTYnZ6b3ZGWUEzMkxocmpxcjd0?=
 =?utf-8?B?NHZhUFdTM2Z1M1hNWXhlVUdaS3E4Wmp2S25FWTVmd2FGZWx4NUNvdTJIbFhw?=
 =?utf-8?Q?n6Vbw+UQLXFA4n/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f247baf-74f3-458a-4e58-08db879ae6b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:25:57.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itcuty1b+IxbCANOdFSM70/wBdmnTWG1b/WoWF+eoI6zObqAgvTwYAKqvlICMQBHnPSQ4NiYpQ6xjsGYGX1DSTIGgZyF6I94jOKZWhDYYTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180132
X-Proofpoint-GUID: cNfx-Wx9_z9Fv20BMIUrdz5PQUj6I0AQ
X-Proofpoint-ORIG-GUID: cNfx-Wx9_z9Fv20BMIUrdz5PQUj6I0AQ
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 12:00 PM, Andrew Morton wrote:
> On Mon, 17 Jul 2023 11:18:12 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
>> It was pointed out[1] that using folio_test_hwpoison() is wrong
>> as we need to check the indiviual page that has poison.
>> folio_test_hwpoison() only checks the head page so go back to using
>> PageHWPoison().
> 
> Please describe the user-visible effects of the bug, especially
> when proposing a -stable backport.

User-visible effects include existing hwpoison-inject tests possibly 
failing as unpoisoning a single subpage could lead to unpoisoning an 
entire folio. Memory unpoisoning could also not work as expected as the 
function will break early due to only checking the head page and not the 
actually poisoned subpage.
