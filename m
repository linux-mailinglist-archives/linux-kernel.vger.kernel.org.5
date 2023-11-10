Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EA7E7E89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjKJRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjKJRpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01885A752E;
        Fri, 10 Nov 2023 05:27:58 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AACC6hl022480;
        Fri, 10 Nov 2023 13:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jNuWjQNbHrBmYEBzJC4pLhPmNZ89rBGRWqKXWgESAyU=;
 b=QsIhwLgrMkvS4VrJowhk1tEew7QiaYsFEruoiaJdOwzWqQWSw6eR/O30czCeXaueKUJ8
 bg80oChp+V4B1WUhUOZeM+rha0WtQi7aDQf8tNfwNXaqJgKTiYyvHA+MrMwmXKjxdjDT
 Slyz5p4Bb9Qy00nsevCdvcQmOE/ktyA2xkM227e9wOBn3jNdgzrPO0TkNYbPuKfER8AK
 Dx9jaaSXlAt7OWAVy+d3zl21c5BsxNYRceis0IvCOcrEIr7B/5HqMjh2zSyZSJsLiZA9
 hkPqDRQYCziGnE3GJhLxJ0Efb9Ii4DmqFBJQ+YRU6KsOVdz4DIBv+6tJIGaXwSaPY40r 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w216cg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:27:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAC5b5c018195;
        Fri, 10 Nov 2023 13:27:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01vaks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:27:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjyuF+JQQHf1gVNMixHSMIu3pf3hiLDKEFbXCEiT5Nbn25HkXu3kUrJFggqLpiRckrtds9CNXkcap/potqCD+q3dhaGXifW+B7di5noOYleSNITnJ1DXITRFOHGCsTQQgJiAZ94aJWlvOZCSnudxONqYTDBll5PiRrgXDmGhkJp52puiJJWxUjOkR4VJunDww88xnldA8e2Uz9bEn3jYUYJ9VXM0W+cXk282COpXQ5FC1I2ftNjtOJsrUh+z+j8WtthjHBTwX1+lHwoHlOu509Otb4Ta5LMNv7MKWjvtie8DilrTw2Gq8cEz7M1cxipcVCLVOCTa/KR/6gGmzbFinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNuWjQNbHrBmYEBzJC4pLhPmNZ89rBGRWqKXWgESAyU=;
 b=bisl2oYX14cE96H7rt4W2UhGbeHaaewmfbvsdP1qtx05FhvMByVp7yoHGzCycW3kpnkqOJPn1aixYuKB5/560FNcyRzu3wyIGpxX6GUb5Cj+wpz4dqgHBfxdgxXxRKZbfEmpM2oQMZ88w2YSRH6Hl6EkrqKAfnqcZXbAzRvuHlvy01QSXYKGA5pTmYyVvUkUTvTTJZj3Hak6THjPCDR6U7siaH/qoCGJn73nUO7HDjypTzE0FbYjcfOpB2tANEz5JTPFxNoItlYZcCfrgDmcyxXMK0jTkA6uz8gwXSFT7n65GPrbPhnOPGMXLm+retJfTCnNOcqOvK26tvbyKzF59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNuWjQNbHrBmYEBzJC4pLhPmNZ89rBGRWqKXWgESAyU=;
 b=Qxqjy4SwJshignvmmK2vzYNbQV4/2W+CuobVEPBNdCwm8lPvIdp0rqfHSWtzbgk2qT5wK1HRHBL+vC/0PaxxGs/wYWfuq4h39Yhey9hSa+yjPwPEJsgJEBjWFFBKD2MS2Q8v4Y4NDedvggdp86kZnEPdVZYEF8FRDxvrXDw944o=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 13:27:45 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 13:27:45 +0000
Message-ID: <3e3c2ed8-22b2-4987-b229-86e19c1148fd@oracle.com>
Date:   Fri, 10 Nov 2023 18:57:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
References: <20231110090408.3383881-1-harshit.m.mogalapalli@oracle.com>
 <b821c9e6-ecac-4682-a624-1b930a671bca@redhat.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <b821c9e6-ecac-4682-a624-1b930a671bca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b21094-3932-45ef-4f88-08dbe1f0d31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RxuA/dhR8ZfrtQ70IiwW1SUgXgImxj6894kzqUd9q3LMBBJd5/r5VMlTFZ3ZMh7MSRSPNKt5IyqO/qs8ce3L/evoufXkyDMaq5I36dllabODeV2bUgUfKBfG9BJF5zcukWP4UrZ+T3HVGnRUDwQUonozT+WYy2Lg+uzUTPgSUZ7dv0GxduryfFqQvy/WH/1hovBVhDEZRpp6OulNLU0Ezo2Eag3ZnIYdS0Ak2QsPpt97wgYA+Aupe8X8E+AEeEo+vEcfKNDqeKvy6y5BgVK/hpUdzMiLce1OMrDq1023V/9aNnsU5pKVmNnU02Si5dqZlbGqWbIx91GP2IbE0TwCV3BNXxm6rH2+ekG3sBKoRYIGy37nJLJPSJ9YC0HD1Ygsp0ApQIiEGe6Fu5FfEAUc1vCLX+xrT/E3Iml63/OinYY9NTsUP6HOeaOgGiCRV/oO8xR9I0pLZ2TOlqiZwZpSDZgUGbWFHHm29NLwFk/vOq9CDTY/Az1HpC8w8xJccdcl0lY00j6Rwsz5Rz7fLVH9XxNp7+JnD5LTN6MePTmgIOux4aU1Roj6hqCF2d/n3bziYtOlB5seh8DLkmbUn9zOO8QmIQMYzNRTFUbiFlAHuVyov0hM/fekZmgNxOXfAT8LVY2k4LGMOqg5sQDHFvoTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31696002)(38100700002)(86362001)(36756003)(966005)(6486002)(2906002)(53546011)(478600001)(5660300002)(6506007)(7416002)(26005)(6666004)(6512007)(2616005)(4326008)(8936002)(8676002)(316002)(66556008)(110136005)(31686004)(66946007)(41300700001)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ppanRXVTZNN2tyb0FZd3J1SEJLN0dtWHhlTGV6akdCeENYaGx4OWJpZWRn?=
 =?utf-8?B?Ymtjaks1M3BnTEJnUUZSSmd6dkJ0ZEZLa1U0WS9aUWdDMXg2N0xQc0VxMnJw?=
 =?utf-8?B?SjJ4ZElYNVd2NjdqYlhjb3BZOTI0dVdnZ24xeU9EVmJxREVCRmNGbm1PQXpJ?=
 =?utf-8?B?RFc2ODYveEpOazAzYy85OHc5MFBXRkRUWkNnOFpOejFpbmw3OThBNUJQZWVw?=
 =?utf-8?B?V1l4UCtMd08veWMxNFlFd21wVVFkNndqY1ZLbUJWYkN0QkZnTTRSNVI5T2lQ?=
 =?utf-8?B?aUFTb0d5bjVMTE9xaE1jYUtaTGo4L2wvQXNqNTY0RnQvbmhzRlU4eXZROFp0?=
 =?utf-8?B?WE9NbkNSOC9WdGdxZ01zMkZMS25hcnhnM0J4K0VqREhPTndPMjA2eEk1WFdR?=
 =?utf-8?B?cnRwZW1TakJscE1BR0NrYjgzRGZDblRzSm1aOThaSk5YS3JWczhuQmNDNDJj?=
 =?utf-8?B?YWJDNzRYdHlFeUF0U3dKYlJNak9uR2d3QThpbjNRUlZMMGNVMXV5Q2l2RGpx?=
 =?utf-8?B?TkdYOE9wcmxmSWVkaVptT2lBQVd6TysxdFNFd3NmcWRoVm5QT0htNHZESFZn?=
 =?utf-8?B?c1h2VWVVaXV2VU9xcUtrdkJueHF4N3o3SnVJeWFkczZzVlAvNDROSExRQWtz?=
 =?utf-8?B?cmlGdVYwMWxiZjBJM3ZzSUFkWVUwVk9lVVpURUhtSGlJeXh1Q29YTzJxblB5?=
 =?utf-8?B?RWZmUXBtUERqL1VDWC9qTnhLWkJiSGF1K1Jmait1QUkrbm1aOEpiVUdkRzhY?=
 =?utf-8?B?K2ZDbmJPaFZOekFpajFRcHRJaXROL2o1blgvR3RYdXRadjZxa1UrRmhjRFFq?=
 =?utf-8?B?cTJhVG5JVTZOMUR3eTFkc3V2ZHNtanEvVkxyV0w2cDdiNHZHcG5jMUdqOXE5?=
 =?utf-8?B?cnJ6NnVPSEdJeFlQN1czdW9oVmJQeU5KR3B4cmpGSklqcjVLcDRRZ0lBclNF?=
 =?utf-8?B?NXpYa3BUa2NPbzdscC9aRjFuNHdHbzRKdlRUYUxKY3RCUUpwMGloYyt6TEpR?=
 =?utf-8?B?a2FFNk9sVzV4SXRyM091ak56UFV4dkxFc2lTaVcyYVVxeExuZkZFY2U4dDYx?=
 =?utf-8?B?VmE0ZngvbzVlQkdkMC9rRG5URm1tMlYrRHIwYVJ4dWRnVVErRDBWMmtZTVJr?=
 =?utf-8?B?SEZGdVVDRVNVaWRnUWYrWWUwVFliZ0ZCekgyQWJweW13RHZiRDdWd1VZaFhQ?=
 =?utf-8?B?aHdsVDd2NGdTY2NudHl3MytJRDMxS2hSUFkrclc5a2V5ejNqSjN4SkJuL280?=
 =?utf-8?B?NHVmTC9PRE9XNGlCU0tDM25LcFdNZDVsOXlrekdaWU1Zc3ErbGxQVFY3T0Ez?=
 =?utf-8?B?TVRZRytkcEVYWjdSU2dDb3FMTEVtbE1CT25jejJudDdmWmNyMk9iTGlpb0RU?=
 =?utf-8?B?Q0dONStnRm1DMDY1a09uSEJqV20rUGlvS2dJL0pnajZkS0xTb2NoZzJXZFpB?=
 =?utf-8?B?Nk5JcTM0WkM5akRYd0RYUmxhejc1bjA2QnBFalNScEVOdTRrbkkyRklPempy?=
 =?utf-8?B?ZjhzVk11QXFhT1NiM3VVQWx0eVBrbXYyVkU1TmFIV2pDOVJ1aE5TTUkrVm95?=
 =?utf-8?B?MEZjWmJZREl6ZnVxRHo1RDdLQklkT2tqUHpmMlRhbFZSRTVYUFZRd01nSlp2?=
 =?utf-8?B?NjZKczZmcVhqTldHRnFmckl5OVFvRXAzZ3FBOEpGdHFXQWgwaFRLZzlyMFFP?=
 =?utf-8?B?Y1AvdlFoU1Bwa2VncmZTdGVyYzl5a3lQQmc3SGd3L3lMdEhPOC80bklMb28x?=
 =?utf-8?B?SmdNU3FvaXk4UEllU3A0UHN2Zk04SGZ2ZE5sVm5URG0xRDBFWTgvNjF1dWJU?=
 =?utf-8?B?Z0JSQ1NXeFFFaU5hejlObFJUTGFUS2hSTTVoSEVyR2NyN3MzK1R2blNvbk1W?=
 =?utf-8?B?NXdtamIxbDJLeVZ0YU55eENuOE9vN2Rmb284bENRdkxtb1JmMmw5NEJ0bnNi?=
 =?utf-8?B?Y2hwUE1YVyswbHJURzA1L2xhWC8xT1JzM3hQa3AwNi9KZXBHSVlKQ1MyYUJl?=
 =?utf-8?B?cmZ2SURoTkkvNHFydEFwL0w3T05WcUNTRjVhTHhKWUdBTGtLcHBCZ29vSld1?=
 =?utf-8?B?VDZFR1M4U2puU1ZUelBza09DNUFSdDRLRy8wWU83Y1Q5bHNyTHBsVVZ0a3Bi?=
 =?utf-8?B?M3g1ZXpFZlYreVppYmxyeHB5U1Q5ODg0VjdidjZzdTJsUUVNdkdmR0dmeHZS?=
 =?utf-8?Q?qreK9ibq+3D6rXsVCnVdOFk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NUUyWDBGL3BqTG9sSkl5UTJYRE5iNlBpSFVEZUw0UlFIdE5wdTE0Z2x0UmpT?=
 =?utf-8?B?d2xTY0VRWGNRSm1QUWQ0bU5PdjVjWkFmNS9wVFh5Qm1pWEY1Y28rZG10RDNX?=
 =?utf-8?B?aVh6U2JiZWk1eVJsODRYT2JwQ2hYZm5LbE9qR0FXT2x1T0NibFRPODV1WmRL?=
 =?utf-8?B?UHM4ZjQxd2VXU21Na3p1bysyWTdOY2JiSmdsVzVVbm9wYVp4UnZjTGxPN25N?=
 =?utf-8?B?VHBnb2xmUFA3SFVoOTQyWU1GTU0xcWFYcUNpKy9HaGVVbGU5K2g0SlNsQ01x?=
 =?utf-8?B?VzFtcjR5TkR0K0plQkY5eElpOXh0ODR0KzNDclJlbDJSRXVZWnZhczhQcGJR?=
 =?utf-8?B?T0JFenVNTTlCSlhwUmk2WUdVNEdEeUxyaCtqdm9xRFkzcHk3bmZIOVFNbGoy?=
 =?utf-8?B?T2plbHY3RXRCa0h1MklEZUF5bTh6bm5BWG9lc3V1dTF0UmtDWkdCSEo1c3hM?=
 =?utf-8?B?SHduWHRnaVY2RFVFOTVrejVzWFI4VmVYT1lDZDZDcEIyeFA3SlM3VGtmVGd4?=
 =?utf-8?B?NGV0Q0FnV3JDWW9VZWtrMnd1bFlvTVNQTHRHL0RSd3NOU1BoTXVvWU9OM0Y4?=
 =?utf-8?B?TVIxQ3h0OUxOQ0VEc1VFaHozc0d0eXlLYmVkSjJJTUttb0xFbkFraTZSbGFE?=
 =?utf-8?B?SUp3VGZLazZ5NHNmR2FvcENINHJHZGJQMWFWT3VLd3NTeXF4eDF5NW5xUUlC?=
 =?utf-8?B?d0NOZnFTQUJwYnRZUHJzVGlPWHhmbkEvZjZEOVcwVUtLelNQWGV6NTNtaHFj?=
 =?utf-8?B?WGJobVJXQWcvd0tGcTBrbFZST0NoaG96ajlYMWMxWkU0dHlxUTNvWS9KYTNU?=
 =?utf-8?B?UXFQQlhKSnJkMTBDNFVxcnk0am9wdE5PVTNQeVRRenB0RVdmZk9KdExGTDJm?=
 =?utf-8?B?TmhKSkNyZU8xU2NaYVQxV1lPM1B5ZXU3dVNMTEt5Y0Z6WVNaTDhYak5ZZUJw?=
 =?utf-8?B?Rk1DcEtXeGtsQjBIbWJSRUNVVEJJV1ZDcFVNZ0RPUExjVUVPOHRTUnFwMWg1?=
 =?utf-8?B?RzZQUnNMUG9yWWdKQUo1d3FnejhCOEErRE4xUUdFWWg0ZTRZWGtyanZJelBM?=
 =?utf-8?B?Uzd2aERDZFk2UGhEM1VMZlJVYkVPWEdScUFsK1AxSi9EYk9Pb0FXY3BXTHov?=
 =?utf-8?B?ZVZ4alNHRFI1cnpDWCtINWJQbzk5ZlRRekx6bE8xNG9meHNvZk8wK0MrVWxl?=
 =?utf-8?B?S1FzOFJ6RTU4Umc3TmVRR0tSeFZoUU5GUUUwanM0S1JZQ3h1Um00TmpVOTJO?=
 =?utf-8?B?THBIam9ZVnRyL1luYTUvRDYwd3p5Q1k3QWxpdEI0b2NHVVFpNTNydmxueEdS?=
 =?utf-8?Q?9/BP2p/EjDRAe/5vMeeKLLnna2pBPasTIV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b21094-3932-45ef-4f88-08dbe1f0d31f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:27:45.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpbKoa3/c7e0VGZM95hXxWZeIw5KSBCApEKgYDRlfVpkcY/DPFsSULr7HxVvAM6qRxUHEmD13ewt13dPMQabw+2Z+Q13GjGfGOBjH2FMwrBn7JLZC58ecXnnkGlTCTLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100110
X-Proofpoint-GUID: 7DF3l6_uxO9WMP1RG2IU3riLNXbstILR
X-Proofpoint-ORIG-GUID: 7DF3l6_uxO9WMP1RG2IU3riLNXbstILR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,
On 10/11/23 4:50 pm, Hans de Goede wrote:
> Hi Harshit,
> 
> On 11/10/23 10:04, Harshit Mogalapalli wrote:
>> 1. acpi_object *obj is unused in this function, so delete it, also
>>     delete a unnecessary kfree(obj);
>> 2. Fix a memory leak of 'attr_name_kobj' in the error handling path.
>> 3. When kobject_init_and_add() fails on every subsequent error path call
>>     kobject_put() to cleanup.
> 
> If you are fixing 3 different things, please do so in a series
> of 3 patches each addressing 1 of the 3 things.
> 

Issue 1 is solved by cleaning up obj, so that can be in patch 1.
Issue 2 & 3 are solved by using a kobj_put(which also takes care of 
kfree()) correctly before returning on an error path, so issue 2,3 will 
have a same fix. This can be done in patch 2.

I will send a V2 with splitting the patches.

Thanks,
Harshit

> Regards,
> 
> Hans
> 
> 
> 
>>
>> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is only compile tested, based on static analysis.
>> ---
>>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> index 5798b49ddaba..b28e52b64690 100644
>> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> @@ -588,7 +588,6 @@ static void release_attributes_data(void)
>>   static int hp_add_other_attributes(int attr_type)
>>   {
>>   	struct kobject *attr_name_kobj;
>> -	union acpi_object *obj = NULL;
>>   	int ret;
>>   	char *attr_name;
>>   
>> @@ -596,8 +595,8 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
>>   	if (!attr_name_kobj) {
>> -		ret = -ENOMEM;
>> -		goto err_other_attr_init;
>> +		mutex_unlock(&bioscfg_drv.mutex);
>> +		return -ENOMEM;
>>   	}
>>   
>>   	/* Check if attribute type is supported */
>> @@ -614,15 +613,15 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	default:
>>   		pr_err("Error: Unknown attr_type: %d\n", attr_type);
>> -		ret = -EINVAL;
>> -		goto err_other_attr_init;
>> +		kfree(attr_name_kobj);
>> +		mutex_unlock(&bioscfg_drv.mutex);
>> +		return -EINVAL;
>>   	}
>>   
>>   	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
>>   				   NULL, "%s", attr_name);
>>   	if (ret) {
>>   		pr_err("Error encountered [%d]\n", ret);
>> -		kobject_put(attr_name_kobj);
>>   		goto err_other_attr_init;
>>   	}
>>   
>> @@ -647,10 +646,9 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	mutex_unlock(&bioscfg_drv.mutex);
>>   	return 0;
>> -
>>   err_other_attr_init:
>> +	kobject_put(attr_name_kobj);
>>   	mutex_unlock(&bioscfg_drv.mutex);
>> -	kfree(obj);
>>   	return ret;
>>   }
>>   
> 
> 

