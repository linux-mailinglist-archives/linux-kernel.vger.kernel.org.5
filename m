Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C817585D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGRTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjGRTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:50:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF199D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:50:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIESf7031538;
        Tue, 18 Jul 2023 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iqzo3ETqvGZOh97HLwuwlekMuRU+eUvhJgrBVHmwAu0=;
 b=K6D0vFSkMn5q0/vkCq2WRJ08UmRA7Yp8CNzRD1afHgAugNVf40YtBwJ1vRvyuAGo0hgi
 N0w/aV5wv7INPHP2+EB0/bIjHIZYdAVI1m3xmuaxdZVlk9cFXe8joC+a7gWXtgUSYtrO
 aeQG54EJG3bflLQOS5qz88Xgtt53se0FjWDFh5+aUcyCj0DkCepkznOH8RA2o4qwKtAp
 yXQ830MdCJKavbGnej06ER5IOuZ5B2dol6nN8BncR5FOHAcne6yU1ygZHZAtFiDCkrA8
 ggVftwSlOKHC8OPLqTtKC/lsrMLnANZUcCICCE9QAJYvMZSuCJcAwEWMmLSmr/cOwGNh JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a61sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 19:50:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IJVEoL038292;
        Tue, 18 Jul 2023 19:50:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5m8rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 19:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3p6LqeNK5+mhqtuq2kh3p4UUbT3ImTXvf1P9aPshtj68LnU1EZXddlIwwkN5UQD2u2/R1pgBsSEmp9wIzlYV5cXJbcQmmJ3TJzab6QT+1oaRyF7wFLo3YuAyfX4fky7BJKg97XdRKgevt+nuPBaCOuAgPn9L4lq4kKabULl7/aqeNP8v1n6crL4EoIN5Rq4vMg6oCTvSkzsZyDdJ+ojYV/PiEUV8YxUiTGRfqXJmMOImfO1x1BQpLTvKctvkk14NRhzPTb7XUIiha0VJjqP0tM1Z8VPwziyO5Y8X5PemHzR9aiW+Np2IIHM4Ov/EA4OL22lGR9qALNyEp6We/fI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqzo3ETqvGZOh97HLwuwlekMuRU+eUvhJgrBVHmwAu0=;
 b=Lmn+FmAmXbqij2gGMQkAU8cALl5myX2Rzwi4RP6A3mMSVw/SR9BkP8lPU3gCR1HKzwFMTnFLvpQmzE/MBvZbUc6UjP/OUZa39443fckdKBGJHSGtLc9e6fS01keITlMdvZXbntgynODNCxmmR89yR3Syp9mNEq7X5E+k1C88dhPkh30TQ8m7i+H++MEmBIZ4Bhbp9HiL+HHWPkiYENwJWDojmeECEk1+5FFx9G6XL5UxAL2LlrSuUHZAtoDRphtSJ1ZyyIfakqXWxLngBKxyxMo83oT74XEoqx9ayx5BsIwmNqqF8e/vciWQexIDF/nNnikzdBsm0Up+DcrfkuOpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqzo3ETqvGZOh97HLwuwlekMuRU+eUvhJgrBVHmwAu0=;
 b=SELqgoJsPJm3OjVy3t8dhCRKg7qVRCPuZBu4USEe3Q7z1yjtuoF/1TwikW+Ca/prAM+OpcS49TG21ahv09FCyRhKJ8Y1IsRqcqjTn/HL3mgcIK8YRSbcrg49jpo1fJIJ6RtRBoag0s2Iko4Xj4pMHzIUYeycs1Ar5iPQIzslhm8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 19:50:40 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3%6]) with mapi id 15.20.6565.028; Tue, 18 Jul 2023
 19:50:40 +0000
Message-ID: <f3d82140-7003-3094-0433-33e1745c009f@oracle.com>
Date:   Tue, 18 Jul 2023 14:50:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FS: JFS: (trivial) Fix grammatical error in extAlloc
Content-Language: en-US
To:     mirimmad@outlook.com
Cc:     Immad Mir <mirimmad17@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CY5PR12MB64558542113D0368DD98FA62C624A@CY5PR12MB6455.namprd12.prod.outlook.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CY5PR12MB64558542113D0368DD98FA62C624A@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:610:e7::22) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: e64844c0-5244-4242-7e44-08db87c84376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azqtfqCxOLKKYpmMLzusv+UmquJ64WMmhZifksaBASdsUCNMAl38S2iKqlL5vB+PAietso9f0neeN3xqy0zGYdEXU7TeRK9JKtbwUgzKM/1GEFbvt0O6oBTkIruOnvDqQprOxoEjaS3BVAdqcngUgz1oj89/APTkhBmt7B8tzKyv3LQqLulXpGIHyPA1hnYdvqHDLY0NnnZ7XZhi/3sRpsmP9PzKITXaEjzUV5SuOrOuD5IyaTgKl9GqaTJ+E8vK1gkdmLwG8dKHDORUw3WUH5cJ/FBLZbEk8rYxTpaQM+wivcEDEtWL5qJZabkNRt+sll4OfXLpwoiPSBOwuRAVC7k83Vo8z+qa3pqsbQE3mmFEc0TcbhOo0M000tGKK4Es4kMYKozbw6iLheuo0zOatzi6tf99KtOxjfFRxxwPmSZ8eBEMOkZz2mtNHSuY8Ol8CMqNJuQZp0SPd6SiBINm6w4KoTTFmBtbF8I2Z9ncChup6+EzAxrrjSkDiYu+n2VcoBlVOVv1WGJbUn8rZY8yP+ZKRemNxOfzHhZKpAqSDyMnK0/3t0fzOIkIb1jb+XBSqag3OV0bdXED67qWXyZ5tz3XBNLbx8RvA8baJLaQ1BF+q7PrhMRn647JU5w2XSGi6VVrs85U0dukabfJfgZyRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(6512007)(6506007)(26005)(44832011)(36756003)(38100700002)(8676002)(5660300002)(8936002)(4744005)(4326008)(2906002)(86362001)(316002)(6916009)(66476007)(66556008)(41300700001)(66946007)(31696002)(6486002)(6666004)(478600001)(45080400002)(2616005)(83380400001)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJkUG4yLzZleHVNODNUZUFGTU15UDRWeGV3NytPTW5rVWhVUThpbGJQck5O?=
 =?utf-8?B?aVhlZEtpbXA2OER0aW1YRGlyb24rQWIxYVpSSHo3YUM2MzdkTjBiTERqSDll?=
 =?utf-8?B?UXg3Zkk2cTl0Y00zUHQ5cUV0SUgyeWt4b28xeU5pU0t4WXJFVjhyNmpMWG9X?=
 =?utf-8?B?QXFLL29MVjg0ZW5jOXVRR2xwMFJqSUtIUlB0cnErRDVZRlFyYjQ3NHdtbTBY?=
 =?utf-8?B?VlNGd2xTTTZNRnRFTkRtMmFFQkRhbTdQYWVld01MazJDcStGWDZOLzBLTGRk?=
 =?utf-8?B?Nk5DZWUyaTNsbnpHNjFvNkhwcDBXYitROG9tQ28xOGk1dlcvbnM2M3pEYUcz?=
 =?utf-8?B?WktjU0J2UndzbXV0MHZwTmdxOUZWallsOWZ1L1FlSHlTSVRIMjhzcnpSeG5V?=
 =?utf-8?B?aGptbS9UaHlDNzh2UzArcEg1c24xNnozcE5pdTJVU0RjRzE4cWVQQ1JDOStk?=
 =?utf-8?B?cGM5R3hFZ2ZFNzdra1k1dGVjaVNTVXg3YTk1ZnRCejFoUlNPZVJBQTRrTVJN?=
 =?utf-8?B?OEFEeGNFSG1iMFhUYzloQmtTVllNeHlHNkx1KzJseE16NEIxdkp3UExZVWJt?=
 =?utf-8?B?eDU5VW9LaVVHc2YvYnJpRzFFdm14dTQ1dUYvY01GaCtWZ2FsNjZndEtBbUIz?=
 =?utf-8?B?RWpLa3I0c0ZoaVFhYkgzeDRkUkx0YXRBS0tscWZrMEUrektoUkF4Nnl6cEs3?=
 =?utf-8?B?SjNFMVpNclYvbFlkcFROVTA3Rk5ycDdJckZnV1FXYlVrWVVJZ0NhQ1YwSm9x?=
 =?utf-8?B?NnMvZ1NVS1FjN0hnZXplOVVtSTZJajIwQ2pmWGZKWW13NVpnZFZhd2lqdTlT?=
 =?utf-8?B?WS9xaXcrdU8wUGJsODN6Rm1VU3ZYT3VHd1Q4emQ5czZJWnQwOFQ1NXc2WVJL?=
 =?utf-8?B?QkMwU2xkcmRMalpleDZnTWpoMWJTR294MTJUUjZyQkJ2aVFqaUlHS0RNS3Vo?=
 =?utf-8?B?bmxVYlozck5XVWFUYnZBckN2RHBLSElwbDhCRHVyL2I3VVlqdnpzZlI3Z1RJ?=
 =?utf-8?B?cTBKZzV1L0hvK3VVN29IZzdZL0NFRnRqblBpM2czSjZlbGRFdldSeng4d29J?=
 =?utf-8?B?aGdjZkFaaEFoV3FRcVVPdURYQUVFVWFqZFNrWjdUWktrbzl4a1JZTVlzK0FB?=
 =?utf-8?B?SU1nVVFDVGRRYndMYWF3c01adG1xaVIxNEZxZ0tYeU85R05aM2JVRnJ6VW56?=
 =?utf-8?B?aGdVaEhlbWlVZnNYMUw4b3hBOUExZzBjNXdxb0llSHhadjljbFVPUVByYlVt?=
 =?utf-8?B?OWtTa29DQktndXJ6NGJ0cmZjMDlvYWVhUXYzV1diTTlDWFRKeHJDTnoxMk9Q?=
 =?utf-8?B?NzJpY2owYlN4QmltUSszZVRIdGpUS3R0NENDOGU4N3JtYTBtMW9iaXljSGlK?=
 =?utf-8?B?UVJmbGZMMi9xT0RuWFN0cXJaNGh6a2xvVFljbnZsUy9UNTZod2Rtc2JKZC84?=
 =?utf-8?B?R2d2NXA2MVVZT0VmRzBBZ2dmdTB4aUtUWFgvd2dzU2QxSW1PMGtDWmkvUFh2?=
 =?utf-8?B?NERrQi9uS3lBYTU2UnZHVTNRamhxRFdCeWJOZ0hieXM0TVl0NFNFOFBaUUgr?=
 =?utf-8?B?cFpLYnVYbkowUWkrWko5aWczNks0L3FkTnlLemJmQm1HSUVMVHlYRU9peFBL?=
 =?utf-8?B?ZlpMVUh6VS9HeVBNUHZ1VVExK1NjN2QvNkE2dFNCck5XaVFSYTFHV25jUzl0?=
 =?utf-8?B?TmdxNXZCMWZwQ3NSTE5CSHE1S3pSVmptMHZLN21MWXhUYmVlN3N1SWx1WG5n?=
 =?utf-8?B?SkdxMXFyOXlDYytESWlPZUNhZDBxL3MrU280blRoY3AvczVGZGlCbnZBRmx0?=
 =?utf-8?B?ME5WbHlWRHM3dk9iVk5VK09IQlptV3NzMGQ1WUt3cXRYVEFTaTI2bytWeGc1?=
 =?utf-8?B?NFZRSGMxS3MxRkZZWjd4dnduWk1JeS9kbEQySGJDcnB4UWhwMU5Yb01Wam0y?=
 =?utf-8?B?MEdGQVJyNDVnOCtFOE4wTVMvd2tOSXNsajdaTW9vK0tCWVBEckY1dHRoYXUz?=
 =?utf-8?B?RkpIcDUrY0oxSDZDM0orZHRoWWtlRjVnQ0J6TjN6Z3BMaVFGZ2RjaHdvUEhO?=
 =?utf-8?B?eWFFV25qa2JvbUtCT2FMVUJMSTdMNlFEanZXckVDRjhjSzZ3VTRaVVFsRkJ2?=
 =?utf-8?B?cUdtUjNhakkzM3NxMm5oR3phMUtHYUVqZGV5N3hqYWJwUmhzTjNUNFovcmMv?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JnKyl5QBQtoOLtU3ffDtAX2NAAgdYvbBmda5H3mtrxuCpwonmflgD3SRf0WmvwjIIe/o/1jWbPrIYIRyXkyGXTNFhIMQfzexhCLoDEE5/bflnMP4cWdlqKs35RnaBYtw9RHwF6xtgQ7wBbwO/VuIRpMp2pPixMTBsxh0l3t3ruXTDNfMJzQa/ocxcCxI5fQio4L8w9Rl62HK3wH3A0OvWgJW2TFEg7roiuKe3vkjvJaOXqG5EcQzdoaauA6a8k1IlurFKUr+B5FNysAJ0Q0ynjHWGfWuFZr6IZNjQ2uj7/HirrWEFjVDXQqVm3cZFLFW8D1RTkJNA6Hr1yDYRt4a8THWM/LWc5Che5T7t5ZQaQcv/hLFRgRzYSJu2CjxOCYSkvDkF9KVVEyDminjUNuBA0i7S+bakpgSzQp5CAaO1A3/7ozN1VeRngGGPoZBuK5VuOBIZWoEAsrYbeat+vBP1i/cNLxi2BY8LMBQBQFFxVhzt7T7qpratgUxW2nji9K1qzhF9hmM8Q4kd2AsdIlWq21tfFTMz1X8zTtnCzdpEji5FHYCl+vCVXkN1AIw7S/95WP7CnQgqHiTMjqvYJcAm9i7bCPPMKiKfDlQ39VCH8M4bOUcvrpq6RxnKWbN6dV2f+toejw+kX9uTRAamDopuUeie+pUavnAkA+iUgzAz/nl7Z93jlHFRY8Ip90HmH2bkLvroCrRHIhrPM0FQb2iOHWkh754VnQVe6fvMeaFyDPEkH9pMjBYc9uKgQX+ntOtKWQQWKYBMT2LZPml5Haau8pMOAAQQDZnyYAgY1rzbXQmltM5F39ElcJOZwrEui/Xu2CifI71hKqIbi0WfuyngHBq9vRNnJfZsoxRj0AT1Zs0rN+yTMd+gOtFNl08p+ED
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64844c0-5244-4242-7e44-08db87c84376
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:50:40.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mkhX4yBRAFQo9KYQQnPMPyhhcCSt9JjKV4lXGhxxS3ml1DuRFgfY4ctAnRIywytx2PZr9MI42n8wTaSZ19zBDnA99eFZZpYnOZbCSrUZkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_15,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180180
X-Proofpoint-GUID: 6vWFsku0DE-f2jgEVsy9xUNVfxTX1n_q
X-Proofpoint-ORIG-GUID: 6vWFsku0DE-f2jgEVsy9xUNVfxTX1n_q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 2:44AM, mirimmad@outlook.com wrote:
> From: Immad Mir <mirimmad17@gmail.com>
> 
>   There is a grammatical error in one the commnents
>   in extAlloc function.
> 
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>

Applied.

Thanks,
Shaggy

> ---
>   fs/jfs/jfs_extent.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
> index ae99a7e23..399492308 100644
> --- a/fs/jfs/jfs_extent.c
> +++ b/fs/jfs/jfs_extent.c
> @@ -166,7 +166,7 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
>   	/*
>   	 * COMMIT_SyncList flags an anonymous tlock on page that is on
>   	 * sync list.
> -	 * We need to commit the inode to get the page written disk.
> +	 * We need to commit the inode to get the page written to the disk.
>   	 */
>   	if (test_and_clear_cflag(COMMIT_Synclist,ip))
>   		jfs_commit_inode(ip, 0);
> --
> 2.40.0
> 
