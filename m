Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23F7DEE90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjKBJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjKBJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:00:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D7132;
        Thu,  2 Nov 2023 02:00:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A28321w003845;
        Thu, 2 Nov 2023 09:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EYrWXC9pP454QrHLL8SHybhsndkwGJ1oWf90ivDFlmA=;
 b=FdTGa8f/dRlfJNk547U51jS4HyOyaQAeDKEtaSP9q327gIsUgj8NXt7yI7lVYEXBDEHY
 lTLv1oss0Kw0pnt+I/REIKSJLR0rMNlYtEOrSEouL6d17/+JS7Nx3CYFIJ8g/tuQ0SMk
 d/ID4mNppkAPjk1isxfBgzo3RT9k3rm7xNQcwD5Gvhh662gA32Icxcg3RVfGZfsJ/3MF
 3ASAqzObxgofZPgJ3T2OIi7Uwaq68vSAYYp+G0h29NhPpDrboZ6z+P2bTX+ME8QZOgZx
 TbzVCujbtltxCNK/AvuKsvaIjdITIYVdrhe8ZwGQVXiCo3kxyV1aNiA80yh9NchY5G0x 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe18xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 09:00:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A288qmZ020301;
        Thu, 2 Nov 2023 09:00:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrefp01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 09:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXHf7WoTPQd2Y7+bBOJn4IuUckL3UP9QiI3YInbk25zNrCQvxL9ID11+UvzsWzD1aJSYsUXfP5DHsdlD+DHgnp1ndxEECzV0NgMeMNzX0K2h8OvH6qx0S1X0m80gwJqgN3epirPpXxppIHbUDVRrkHkpCayjqKj9GG+fu3Y0Qkir6qjjoeooSpGgJS7z7VGtTO0nbuV2HSBI9OlGL17Tpe2ZP+FKqKMteRmTXVDw3fJGlD/E0+KgxlFIyxcnVB7PSeZHC4YAXg/n6bZ/729ycoCDmUFdB7ZUhMtjCnaBc4TJpEorfVD4PAIVtS16MrGV5x7mnABvHMPtKLmM6pYbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYrWXC9pP454QrHLL8SHybhsndkwGJ1oWf90ivDFlmA=;
 b=gjgT5ZwBskxJYPUf5xVVHw+ndGYIZbBOOS9Dfa1vx/xFDhMh5l2HKaMhgBpbCBcn5NnGbiIFluq8TKNr0jTLHAfNOR2UOKSDvIMT6Ebnqx32kaaUFMuPYaMEGG/7PsVhgp62wcWqS5EztdUxO3OVLgbG/SOtYN4MArQI6qqnG0TgoXVr3XxcDkHoplxi3yQjd6ZKA7U1EuVOi4lTJ+w4VDXL4jY39cBGxr5k54o9QymtTGv3fGo8jbrhgHjDxWO8fiLgGyV/SmrPqT7Cpan9q8qjmWkTIdYJ3jqDpKS2eCL3fX7nAHu5iNmvb6jFOxSlmIt3VCdhSCyI3mGNmonjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYrWXC9pP454QrHLL8SHybhsndkwGJ1oWf90ivDFlmA=;
 b=LsUpv3ATj8+RVYYJtWc4zxeOPjZpsN7hp6wblEHSU5s3jaOcBD1klK5gA+fSFKEBdrycLPIHRjvegOkPW70tk3tZAge/VKXWLTwrRHtBQr0ocViecKb1l8T2p0rBkCpS/ek7x9UxjfgDdU90Sb/sHBqjNmTHiVn1ejHnxgPYVzE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:00:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 09:00:30 +0000
Message-ID: <4bfe8125-660f-4ac2-0aa6-aa7a5b6df2e9@oracle.com>
Date:   Thu, 2 Nov 2023 09:00:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/13] Introduce support for multiqueue (MQ) in fnic
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231027180302.418676-1-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c6bda7-1295-4111-dace-08dbdb822a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTE6rgF0tbjV/t6BJcnkwf8PsN8TSu0lwGKs+LhaUgTj5K/H4CMy6fPYSt8NGa9dH45SCIrZupHAFeGZHuV5/HoVERwwD8nx/yQjZj6VRXVnfrgC22Fwv2hG3LGf6fMSibeinN9dCwdfJM2z0ZUuavaYaOKDRTtQquNtfVpzL/KZeAB62IU24FfPfaONnaoW0FhfmntC6wz7rQWIz+sebWj0K2VhuDgiJvX/sfP7BmuO7eMMBD8BI5DAjXEkvapU3z+BSXHN4vV6cdOEylafstzo1e0aF8ZaX1rKdaab+1oKMuOf8niWcN91sFtKyrMUew0usUeTcV/rC1FJvC8adgG4XOJOEKtIkFYMeT+ewNWGky61Ih7JEEOmYcrWI0bw94KfYiHkKW7mJJqERowWUNYjdaecypsokEg3kEvOEDwW3x5KERrBm83Ehq1WksFyfNr5lcBF9K69gPKeH+arLhLHnqu1MOO/MsnAvmTRaQ2bgvQ7VmZzgEt3Rzcw+SVWXslDzNRd2LoSu1pfMylRY1TecT6bGIkL0AhkF3i06IUrV4raNDkzPrE71Q1lyhQlaxuSsI9FE18eK/m0IHHK4la60xRxSvlnIgS9PVmwyGzz/nZ7L2nFXmYAgP7qRblgGKrKFHeuQ8QyCNtn04aQAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(6512007)(2616005)(26005)(6666004)(31696002)(36756003)(86362001)(38100700002)(2906002)(7416002)(4744005)(5660300002)(53546011)(6506007)(66946007)(8676002)(4326008)(8936002)(66556008)(316002)(478600001)(6486002)(41300700001)(36916002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxLakRCWnNRVTU4YnBTa1h2SW5pZVczQUVvVXovc0RFaEZQaE9ZOStzR2tH?=
 =?utf-8?B?bnhrMHVhUmFFUWkxUUhtNDA3d044OEdudEZNd2YyRGd6cVNNWjJaOUhtYWtr?=
 =?utf-8?B?NjlGL0krYmIxWk9UcXFwRDFWWFFlVWxXKy9nWGJhR1ExUlZkbFVsRzI3eThH?=
 =?utf-8?B?Z1hmMWpHeEVScTBVVW4xOUViSjNnMjVjQWRlSVd2VG44Q09DTWMwUFBEKysy?=
 =?utf-8?B?NDBGbUZkWFZJVVNJbE15ejg3ckZOUGNNbTVFcFBaZmprRFVJVXdZdkJheDZC?=
 =?utf-8?B?UlpSWElzZDVkSG1BeGc5ZGZEaTB4NGZmaDdGWWN4VWdLZGYyWTNFMVU4YnIv?=
 =?utf-8?B?VVJMTkxJYXFiREpidElxelBGdlMxNXpGN3AvWXJrd0huS1pZTkxHQ0I0aG0y?=
 =?utf-8?B?aXJaa3NRenFJb0dacmNra0tobnB2ZVBhSFRtNUQxMktCTXMxNU14ZkxuYkZI?=
 =?utf-8?B?eEV5NjBaN1pTQTNtWFBtVEtVbi9LdkJvWTBRczBkWm04NGFlQ0pVeEkyZzVs?=
 =?utf-8?B?VEE1MGFUb241RiszNm9DQXRQUWlYUWIvV3pjcHZ3cy9KUzlDSWpjcjlzM0Qv?=
 =?utf-8?B?R1JHbzZJVHY3cTY5K3p0TVlnVnhHWGhUaUhQdVpweFk4bmhWQitqY1ZXL0NF?=
 =?utf-8?B?RUwyNGZhY2p5VnFJa016T1hrN1JMN0x5aGRZZkt2SnhwTUI2V3VqVDZudWVX?=
 =?utf-8?B?UWV6UjhDemZ5UEJqMlVrVXlKdi90VTRjeUczbVlTNUxJUGtaczlYcUwyRVo1?=
 =?utf-8?B?RGxvbExpemQ3SjQ3emE2M0lxY0gyQzgxMUpydUQ3cmd5VlNmV2ZKR29jR3JB?=
 =?utf-8?B?dzIreUtURXRpT0ZnUzQ1WlkydXYreTZwRjZuV0JnbWl0NjRxQTJqUTJSMGZa?=
 =?utf-8?B?SG5LaU9saDQzZzBBSWdkamJQQUJ2blF4QjNLMTdRbGFjZ1N4eUx0amtKemg2?=
 =?utf-8?B?ZTB4SHd1Y3VYRjNZVHJ2UUUzRHYzcDNoNmk3d01sWnYrUUpqK0QxY1JLZ0xi?=
 =?utf-8?B?cjE3emlKRG5nS2lkVEtETEVGS1FSTDBJMThFUUUzSllzSytmem1xbjdrSko3?=
 =?utf-8?B?eFB2QnNmRUNEMlVsdEdpNzhrQm1DN1FqM1Y3ZUplTGMwbVorZHdnSFFLbnhC?=
 =?utf-8?B?MWh2WldzNXErdVNxdndnOCsrbVlWT2NIdTFhZytTeEtTYnFhMDlOVHY2VkJ0?=
 =?utf-8?B?Z3pNNkxuS1E5UEZBTkVhU2pxTFQ1ZXpmRzJ3amxUQ3FnanJ6bFZLRStFcHBv?=
 =?utf-8?B?TFpkL0RjYU1vMkswRXAyWDhZMmVucUxuS0RpSSswdHpta0ozTVNJZ1AxazVx?=
 =?utf-8?B?akEyUVd1UjZUME8rWmtWdGx6dTNIQlBWNDhkdHh5WTZ1UVRodm9SYi9oakl1?=
 =?utf-8?B?Z25VejB6Nm1CWkpqcjZvdGR0RGxKOGhkT1BadU1aS1pyS2hSeGd5T0p4eFdw?=
 =?utf-8?B?YnRIT0R1S3RLbmhrNDgwLzROSWF0cFlFWnJIalNMT1NibkhCZ0hPNjllRnRC?=
 =?utf-8?B?S2JwS3VLT0psN2R6RjZaaDFBdmNSTUZpOXJ2RGtyemlHZDBYcUZwUlVQYTVQ?=
 =?utf-8?B?SU1ra3F3dVpPLy9UUGwvZ3JyVG9CVlRZOVJoakVFWTd4N0E2S1craE85RkQ5?=
 =?utf-8?B?amZxL01uS3lpMzczUmk4WkZWU0QwZldRL1loZGIzcFRGN2lBMG5PTTRBY2Rx?=
 =?utf-8?B?Nk4zU09ocENPQ1pPRnJKTm11SE4ySytvaFJJcUxBaHl5MC9OYmNRNmhnV1RV?=
 =?utf-8?B?cTFiWjZqNUJCWHZvMk5NSjZFVGtidVFkUXRFQXo3TTREL2xyR2JVcXJFQS8y?=
 =?utf-8?B?WStGOW05OUYzeTd3SXhOSURWSnFpQnRpS2RnMXFGbnR2QTNEWGtEZjF4U3Fn?=
 =?utf-8?B?dEV6OGUraXlDL2ljQks0UjVvZXEzTytVUGE5VDdlY1Y0NVZHQUVwS0dYZXpD?=
 =?utf-8?B?U3RpNXF4dmt2aEM1WE9vendHMm9tLzR4WlE3TjQrbnNocWNhcHc1NmdMaDEr?=
 =?utf-8?B?Z1hWZU1iZ1RGSVJnWW9WUU1hMUx6b2UreUxCQUEwRGhvK2p5SllKQWxPSzJJ?=
 =?utf-8?B?ZkR5SDByenFBSklZc3A2SC92eG50UXgwbnNncXR1M1p5d0lDV1BqQnJHV1BZ?=
 =?utf-8?Q?SfXh/jGXSY5L53N8WOyfSfzhD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HPkh2aR8aRvRF4LjM7sJQYhCJgGqYM+HWzJvy3ZTLQhhOe8jz6zi1YJO3eOs8Qh2yVcFyS0CGUd/e3hnv19d49dSUA5gsiKgb6W3yMEVfa9IsNSKSiJfhzKOxfapH4AnH2cx4GkZH2PY+uXKBkHIhGBnzo+H0CLElkdb4dSUxHrTMaeoqW+TtrQs0BBkX0MaSyAZg85VRkWYxy8vUnp3+rZ83dGt1pfvy7EcKlAe0wWSxXXzL5gjmaA9CpBLu28WB7346OXfl2NHc+TOFjaYCRnMGx6EiNB2DlURdXh8k2ygkhv7Fw3QvzCGQ+vOg7XEwZ5QKi2NTdCwX9vzvHTqe/oiOpjDRXiE5nyFPpX5YOK4kZKuJrw/aF9+eHyIZQ7xX3OLsui5+NwXB/cFfl0HEKz1CsMP+iLcCA2pX8gK6RJ1gGTT2Unl4cxZaHscbDO9r4689A+ZHf2IPwe1z+MmUd//9MAOdflnuRMZK0HjTtSaMN2nmwSUZIyeUxc87PSSdOZ1JG2Op5d07X16xbRrDvsNyhiV6UfyPJWYdabkcKtTFZxlvN5m+H0G/kTC0f2SrIJaRxFE33WOWGu7Yzz94FPmCMUfPwwtCY9NnPXTLHEgk6JrWeSVMSH+89LI4o9HzLZrcolFSJOv4oSy+rPi5OrK2Gfz+GQ2cJJ3Z6Iiyg4pVZQ3sYB+6UT6e7fV+QkE8UDZHhzyxtzDr3VSzBs7fyxj5gAQooIOnzPxESVZuRpubf2pKxNm/9iIFmxPpzyDETP79K1ffa+Q5DtAcAPEJCLESfM9I1AAQjPCyyi5sFNXqeS7qHhx7ftYWuCv0ar84CdRRGxyqE5aRM4jZMSNrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c6bda7-1295-4111-dace-08dbdb822a5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:00:30.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/btTc9Cwj+JwTRq+RnMc3JQdh7lN22wieX2HmxkUiXuYRO+1A6L7r/QHtKPViQdzV96+6FIyMjRfYgfmHkAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=974 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020071
X-Proofpoint-ORIG-GUID: iimeBBMGvX5NWOeb4Drjv9woIu1UDiOY
X-Proofpoint-GUID: iimeBBMGvX5NWOeb4Drjv9woIu1UDiOY
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 19:02, Karan Tilak Kumar wrote:
> The number of IO queues to be used is stored in a configuration file
> by the VIC firmware. The fNIC driver reads the configuration file and sets
> the number of queues to be used. Previously, the driver was hard-coded
> to use only one queue.

In looking at commit aec95e3a8ded ("scsi: fnic: Refactor code in fnic 
probe to initialize SCSI layer"), support to set shost->nr_hw_queues > 1 
to enable MQ seems to have sneaked in already - what's going on there?

John
