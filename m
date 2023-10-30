Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B457DBC48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjJ3PCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJ3PCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:02:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE939D3;
        Mon, 30 Oct 2023 08:02:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UD2CFT011859;
        Mon, 30 Oct 2023 15:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sfDfOLNJxxvpzAxeSq/mJ5YS2el4c3XNiVwirNqA+qY=;
 b=0lfC2pM1mR2W212auWTpLdks6xnPbHKBEi1hYjjkwspGl7POgTEnQwRfR30ahtjOyFyl
 /KbMZWHd2DbJvilu1FpuhldEhA5DMGNcxY7mgmieyeD46mUC10qyvOZ/n9ItpgH06DFU
 Z5WjAHBqRIsjYhZqKv9kak+KQA0tUOZvTVV6lkmU+lno7x+qRl9f+VOKGzeFKw2Tv2vS
 xvMpJykqeR4ID14FRM7sd6uTxa883rx/QuO8tZe2RhgW67RhVeGEuMOtBPaIv+SXMLLn
 Fa43hCHWOWZdvtZ6M8xPGTlffSrrag5bs7TXXRWFRwmQvZkZPfnZGQP1l4u3W1edHR9F 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33u23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:02:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3SLs020090;
        Mon, 30 Oct 2023 15:02:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4ejyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYghRon7vBlWYUmu1sXrVUKnzY3KqUz99umtkEvZ33f7/Ks525Jxzhhuz5j+ZFR6M0QKy4trxnhezTaBigIzW7T0nWt4hxlM2QLZVClTRIfT6BKJQt0wHS5EFyUNP/C5X6rbLC2ItvxIipGwzPlygD0e0twDXXVQQqqCuDQrGLjsDwZNJYPh6fMRk4U74V+xISsOlnb3CISRI1QsJ0rAuS2Gh+L1xRDtwLCOW17GkiFIiGIRWZ4nU/QfYT3Ps/vpc4ZKH1bV7ahi9XOq0yO3235OIknEW4CCvI8Uk+H+Lr6lAfxk7b4WKl38mOPZ5MVqF8HTkeuBE5wzH5AhFZ9hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfDfOLNJxxvpzAxeSq/mJ5YS2el4c3XNiVwirNqA+qY=;
 b=PyNFTJRklsA3MUNBxYUmT4iNeT9v64eWlukdpcbapIFQkfoTqaTrjI50+BcegRifJSgNJf5GqEJgOi/AuMiA1GKbI+4aKC7hsvcP3NrHFwkgxKWMuHjNHhqBnxJIALjI9CC8d/BjAmIeQa8kL7SRdqvgsO/Iqq+6vDpCxTZOmgYvH8g6flOZVrLUpeAO/oRV0jTaF6dEaFaXk0+JpvaS/fOO2agua1/JwgDP+4u6gy6ZLsUjUfBAiogL23ke51ZQvo06O1u4EeuGfd/yROAKvhDSdd1y8VebcDG2W5q9X8msdFiD89vMD3I5swOhvy+diILxwk/RisSpZ2qmwtWhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfDfOLNJxxvpzAxeSq/mJ5YS2el4c3XNiVwirNqA+qY=;
 b=mQVPX6I/e1+0KwxXl2uC8Lk8tXoZZoJ9kmqWo6kPb8Xv5jQ7LWQHp5im5trSV7YPuiM13Hl2m++kRxIYuc3kV0maqpt9Vf83/x1/FkWg/JYFOvFTKRp9ZAa5x6udU0lN88JnGylyxo0dRV25SGph1+Cm8gjoGEmzSUkELfNTf8U=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Mon, 30 Oct 2023 15:02:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 15:02:26 +0000
Message-ID: <6c3ed3dd-25e5-18b7-fd17-d126975b6b50@oracle.com>
Date:   Mon, 30 Oct 2023 10:02:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] scsi: sr: Fix a potential uninit-value in sr_get_events()
To:     Shigeru Yoshida <syoshida@redhat.com>, bvanassche@acm.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230531164346.118438-1-syoshida@redhat.com>
 <c459dd2c-a281-7fc4-90cf-36a71e9548bc@acm.org>
 <20231030.171317.1096475355592607869.syoshida@redhat.com>
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <20231030.171317.1096475355592607869.syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab94eb-571a-47b7-d589-08dbd9593a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5Tq1xct55GCVfNn2ysy/15We25qV7I76gIxobl3/WmrVjMzHjgoK2GZNOx9CJZRkvhshwH2YdIgHFaxkHdWCyEnx+ayUtkoLDjlzoZVBnun0Ci+UiH6Sio5vKJCD61Qjdg8RVE6dMT084ZChWoajk/YEyLBhQ9DAwn/uy5S8ON1hvqzxJZKn7rZtaZ9DjOLw+v762akmq085JKILX8Vjn0yCJ4O1tSH1ceBZtt+4eA9vYlhDMYImouuV4PROtM7PRkc/dbBhRp2fCLto50Np/MgmMXHuPHgQKxsl+xRzDZ1zb3p9xV38nfL9G/j1QHBCP9qkF9h1jNLLhK68wEhScZSpv5kZJerQ3/GiXLCeUsX4Y0dJwDdxThYTJYhP497rOGD/LT8u3woVhVFip91SFoswsFA7es2Dbzkc4VjL3XAaITeTCjHzAxcX91ETk4Jwx/eNewRZKlyvajXu7hhl6FSRo2/gAs3N5WUYeBk9VVpjyas7eBXEaPyIDAmyLcdqM4xbRUM8ayFwTsW8DDGURqEsMaX/n/lQmj3OyzwUzJrBHX2IeLEycS4baf6vvIyOKr0Shm/7LCWiX7WhulL9EjjD8PcaRHeZMOJAAWq+Po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(316002)(2906002)(5660300002)(66556008)(26005)(41300700001)(4326008)(8676002)(83380400001)(8936002)(38100700002)(66476007)(6512007)(53546011)(31696002)(9686003)(36756003)(66946007)(2616005)(6506007)(478600001)(966005)(86362001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pYQ0p1VFV5RXFxMzJXRlJJRWdsWDlvMjRKeVJmVkR5bDEvblk5VkpXQkVE?=
 =?utf-8?B?MWxNN2pJbVFxaStIeWx4V05zQU9nQ2xrVk1YU24wdDVTejZ6ZlNUYUtSWDZq?=
 =?utf-8?B?ZDN1NzZEbGlRbkY0Yjh0Nkw2bXdkTDdjTVVDOHp4Vy8xTVRMVXFHazV6Rk1S?=
 =?utf-8?B?Zi9ad295Q3dBK1o1Q0NZVklNV0hyYmJIY0piWHZ5S053c1MrK3Yxb2NYZTl6?=
 =?utf-8?B?SUVwRjhheHV6MXFTdEtOZXh0OC9uaFFVTXRyR28rRlV2MkdkeDFVRXFFM3hr?=
 =?utf-8?B?SjBaeGJ0MkpycCtaSlV3YklKNmFydkpvWjByR3p4encyVHZuNzdsdmJoWUVl?=
 =?utf-8?B?Y29HVEt0eEZmK1JyWXI3dHc4bm5uczhWWkhKMmh6YVMvdko0MVRrUHdNd2pF?=
 =?utf-8?B?SFppTWhYVVVITW5mMWxNTXNoVnJvMWgrbTZ6UHVIRlMwb0dSTjl2eXFJVHBS?=
 =?utf-8?B?NytLVStMV0NjbFlGV2FkZE5nMkVVNk9oK05YR2h0VmVEcmlsNmtSaFJ4OVMx?=
 =?utf-8?B?MUYycmVqN3VmM1ZjUCtYTk12MTZFb3I4ZlB1SHJ5bUp0VjhFMHo4K1AxS0Fo?=
 =?utf-8?B?dW9Ld29scVIrU3BxNTFOMWhOVnRkeXhXL3kyVmRYcTlESzBjTmFuUDk0WEpL?=
 =?utf-8?B?ejFDc1VsU1RaeG5OMkhYeUh0S2RqRWxvSDFIb1QvdU9Gam5xN1lCL0F6dGlk?=
 =?utf-8?B?ZmJNamhRVVROdUhZQkRKY0E4RCtrTFl2TVhtMlhRb214M2VBUGhsRS8xRzZB?=
 =?utf-8?B?ZGpxaEFSZTZ0K1hmMlVKVjRlSnJhODhSTlVJTXVTRklaTWt0TkRSdVZCdkt3?=
 =?utf-8?B?S1VrYXdqZTA0YWdoK3AxL1RIR1plY2ttbS9NUGlCNmxiMkxjUzRsaWdldlpj?=
 =?utf-8?B?ci9pZ3RtYzdDRHRMNC9IRnRrdzU3UzdzbTdFR1FycEZuRkdEb2xJd200cndI?=
 =?utf-8?B?cGZsaGJ0LzFSaW9xNWFJOGhaNzh3QUYrUlNscTJCYkFMWVR5TlU3VDBmUExo?=
 =?utf-8?B?RDRXYXNicE9aeVZpcDJLZGdvZVJEdE1oSmplWEFjUGo2TEpEM2xhWGRrN2V6?=
 =?utf-8?B?eU5BZytRYUJKRVMxUHkzOWZnVjdkZUJjVmo4TzZoNUtBeWQzd2xFK2lCcEtD?=
 =?utf-8?B?M2RjL0g4THoraWMvTHVLQ1h3cHU2VWp5SXRNK0J0OUdZdkpqdlozcG1vNE5o?=
 =?utf-8?B?Z1lCZWRtK056QkE1ZWFGTnY4TUNsZ2hjWlRDeFJwN0JVMUpiTFB0Lyt6bDJS?=
 =?utf-8?B?K0dDZGJwa1lETDhLRW40aUg5UlpaS0NOZnczaTFCbVY3SmZVMmwwNmNUNHZW?=
 =?utf-8?B?bE8yR2hSa2p6QVdsVGpKcnNGRDRsc2tsMGtwN0pxVHpTRGhtcnBwYkszTDFG?=
 =?utf-8?B?V3I3OVl3dUNOZndTUThLMzhaeXdubG5qYXZuLzR0VDFCRFc2elh1c0NlczhD?=
 =?utf-8?B?ZHU0WGZrejVKaCt0VDZJSjlMSXRSd2NKT2pINlVFWkVSb2ZjV0hPSnY0MVll?=
 =?utf-8?B?a216NUt4TXkrUHhNelZacWpnSVpNSERQdEZsSlowWWEzd0xkSGd5NkZGbDQ3?=
 =?utf-8?B?UmQwZXhOeWVva3Y3VDczOUxOc2xKcFp1elNZVklJNXRRbVUrMnpQaDNyS1FS?=
 =?utf-8?B?S1BtZFJVU3RFSm5pSVd1YjFnUDJNWGdWRGVjWENYMGhJMkxnQkUwK0U4L1o2?=
 =?utf-8?B?Qkp0bTRDYlVrTXN3SGpqL25jUGtLYjFwT2dUc0VrbFY5N1V2OU9sMUx1UVYv?=
 =?utf-8?B?RGxjYlhKZjNQaUhZNXNHNnJBRUVmNUc5MFYwODFlWklBTTVQczVxY29pQS80?=
 =?utf-8?B?TitQc0dCbmIwY2llZTV2OThpREorcXlLZWNmR0VGN0dLb2xZOTcxdkdoeHNs?=
 =?utf-8?B?T3hBWVRORGk0MDUvb0UxNnQyWk1TczNGSS9Nc3BvbDI3OHpMRk5rR0dpRERX?=
 =?utf-8?B?TEtQSmpUa3lYbWpod05zMGdyR291VFhWTnNKcldlWTNQR2tMQ1JpUkFaZGRi?=
 =?utf-8?B?UXZ3c3hYRDd1VlFtWHRoM1N1ODc3OW12RjBHZnVwTi80NTdsTUxDREw1bUFt?=
 =?utf-8?B?bmZubUJJMm4zY1plNXNHWGxJMWtidVRzWkgxSU9wQjVLdWw0SG1zN3dHSDVL?=
 =?utf-8?B?d0xqS2RqVHIrYkxaWk5BYWJLaWg3UnBJRUVaN0NKYlFIM1hZcTZDbVB5NVUz?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 04N+fU5ueZqHNiGgeOTP0qSDvXrsYQw1GgSpWK/WTGo0U61sFjvqMP1BPBYpt658u3n9Dhs4C8jchCxtmC1U1Tf80MyN9pGQi8TNbeLOJPOixVN5VIw2u2y6EIfYM96jZntzp3p3UQ7o6TQ1nb87wHd16aiT22X2qAbVfzG76Law9uG/A0qtFaGlW5QQmtjdYede/xE4JPwJzR1Yp1E34oCg2k6wgonkxyv4+wgrOlV2qra0mWFjqnHVa01Fca7uhM+EvXUxsGglxmEVlNtbw8/nvqimq/BukdTIsN0NDQxZpMLwEQdmAEl6Lbd2YqRX6eu/krjqnyIBzuC/Vo510VSguKyb3Q/PqCHGgX3RdfAhVG1C0Rn7YpsgexQ3xnEjOzx+n3hjvl8ZGDvkRebQRG7Y5fiAlq4X6gCrO4vAN5EVt2OdtWD81fxH9F6+YYbMi/y7ZiOotOpe2imkJpqcYI3aEup07zg2BA36uB/1XPzuW/DdJoQxW6mAUCe4M2fI4dvPcGhe9eCF/AgAI4x0Sss9TOzSdtkdAFJ9FSfG+xHqFJTyuPaTxYcSCf9UULmcsxBFuhdtsPMsfWrCGRQeJUKTPG5Fja+g+n0aWHvVO2/6KbG9D/XaTXLcA4/LY0w6l9gtnbPFa5/NhKEaZGvFwXoW8Hox71rbKYmo0tBZ3BYnqoAkN7xeLUt3ieBFIOQgqvACwf9/yTNiam2RS3dGnj3qdC+SbF6r2xdOSfQd8xJZYQmeimXITjMAT0+6EJ58iODcPAMreT5qrRU2kVG0diKARecaBblgUbNBI8ioWQwrOvT8nOuIkTgbofZ/FojmibWdNpgF6uLnjeRXqVeq+VokjffMozisd1s8+2vv4oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab94eb-571a-47b7-d589-08dbd9593a9e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:02:26.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFDukCzHoNxOa4i0WKtYBWMQ+/KA3sbarOOEWawaFtIppsOTkCZ7NwGy/vONgBBZhIV5IdwsLF8FrQdsvpG85Hr8LmjW4T+PAw/+zEAH9Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300115
X-Proofpoint-GUID: yceGmQaDfHBXOK7Wp98uVWDhInGY5IqT
X-Proofpoint-ORIG-GUID: yceGmQaDfHBXOK7Wp98uVWDhInGY5IqT
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 3:13 AM, Shigeru Yoshida wrote:
> On Wed, 31 May 2023 15:44:17 -0700, Bart Van Assche wrote:
>> On 5/31/23 09:43, Shigeru Yoshida wrote:
>>> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
>>> index 12869e6d4ebd..86b43c069a44 100644
>>> --- a/drivers/scsi/sr.c
>>> +++ b/drivers/scsi/sr.c
>>> @@ -177,10 +177,13 @@ static unsigned int sr_get_events(struct
>>> scsi_device *sdev)
>>>     	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_IN, buf, sizeof(buf),
>>>   				  SR_TIMEOUT, MAX_RETRIES, &exec_args);
>>> +	if (result)
>>> +		return 0;
>>> +
>>>   	if (scsi_sense_valid(&sshdr) && sshdr.sense_key == UNIT_ATTENTION)
>>>   		return DISK_EVENT_MEDIA_CHANGE;
>>>   -	if (result || be16_to_cpu(eh->data_len) < sizeof(*med))
>>> +	if (be16_to_cpu(eh->data_len) < sizeof(*med))
>>>   		return 0;
>>
>> I think this change is wrong because it introduces an unintended
>> behavior
>> change. A better solution is probably to zero-initialize sshdr before
>> scsi_execute_cmd() is called.
> 
> Hi Bart,
> 
> I'm very sorry for the very late response, and thank you so much for
> your feedback. I'll prepare the v2 patch as you suggested.

We actually just did this patch for the next kernel where we just
check result before accessing the sshdr:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=6.7/scsi-staging&id=f7d7129c6c24168b9be7709b0b37767b5f743cf3
