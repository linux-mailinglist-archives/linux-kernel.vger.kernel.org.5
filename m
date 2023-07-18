Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD5757F16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGROKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGROKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:10:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97B92;
        Tue, 18 Jul 2023 07:10:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7pYw024299;
        Tue, 18 Jul 2023 14:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dFY79IM8g97xrlbb1vpeoRvr8dg/hGosHch+8AlNYo8=;
 b=2uYw9ettKeDXoznmld+hCeayVYjrSdJB9A2hMdvNZGb2ESxB5vrnVXNKUGEQo0Ogh2cj
 qXpXZodrOtp35hSBStdH3lcxdeTRpR1xgBBTG0l5/crMNjtcQwFHbz2aDJVJUaD6kbnZ
 9N693jFPZUsPhhR0MMwXn6me1V7oJoMQahu96T3LnPNMAr3I2fyVMQuIVy0QCH6feaCR
 5amUga2W7aIt62JCjrLjdwXcmGimNpGW1haTCAStbqfJWgLDriSgTV2SJKc8aRHvTqyj
 hX7sy08rCTvlpLb9BduKINZ8jDfu51Hfm/wtaL9O2rpqZkLoRX/dG7He1lrBrxkU0eqF jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a57pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:10:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ICe8ma007852;
        Tue, 18 Jul 2023 14:10:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4wsrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRtV/kAF0HVbf2TwHrVWwjDLZCSaQVvOAH0p7aNJnvC+VcJ8luOxy2DRUsITzzTRxIRfjZQ3JZmNlZJyKaNHPqCRdAShhE1RAW6MlC8AHRUPUeKo+oKyap9dF00Km6ohdCx1/VLDCp/XYygJmxGKnW6xtli39sGWWzsL1irOgvXZtfib3YO00PwGVjRNOJbmZEIzK6n9phU98iFNP9JZOSn6FQ9+n2qgViEN+6JaQzTqlqb19NgDZQPrZf3+GrPvWr9mH0Pd3sSF8FLoDKLmyGO5UM0PmFlzND2/1LZg2jfYYIRUczHuCNAEyKq+f5R0FSXX39ry7Pderbr5dYWREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFY79IM8g97xrlbb1vpeoRvr8dg/hGosHch+8AlNYo8=;
 b=OCeU7u5acdU78yqjadYI3jD/x0gpEyOtd9yiSCnalaY+Uv/0rFHi2+ytCnD+kNPZFJdl+qACoy3NBKFxGT+y6gppb+DdmSTJYWA0UMfUE/4Y40x+QHxIPTqBCn36PAHBT2G4flvAcnOdOD11obzrPrH+WQvqwUKCX+oTfyIdV23nD1ObYIMQDtMjodsVfe4UP0HirkgnIPfGpaX5FQ/ibYgbjQ2pF70+PU6Zc9NFRKbin3cZ0+JbM7PdGaTeIZSArwLMg3oCY+TpaU58sJzD/cgjDtnKMYQIS/CbNpN34+IR9f4x+Sh4njre5I+stpHDmyiLIWm40TOZu+FWIqEZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFY79IM8g97xrlbb1vpeoRvr8dg/hGosHch+8AlNYo8=;
 b=O8e2z7IYw41FnAUVD8u1Tfa7Pf53SruNShmBDgOpx4qp2XHUU5QfXMyYhgIvSAcfmeieEZvfbMy6Te0jvaRxZ3881oomew0eatsHFchaxvA2ZHWMvBu29NTUEKEx35p+sAy/ekM+xr7+hiUXCk5IIit3dQeEOIsu7eHC6X78w/g=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 14:10:31 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e28:d652:3a4c:b1b8]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e28:d652:3a4c:b1b8%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 14:10:31 +0000
Message-ID: <750030f4-f396-57e7-3afc-23a206ed78a8@oracle.com>
Date:   Tue, 18 Jul 2023 19:40:19 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
 <ZLaanLVc22iKg/xV@smile.fi.intel.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ZLaanLVc22iKg/xV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH0PR10MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a58ba4-b253-414b-59ea-08db8798beef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIrw9qusCjZWRXXYmM/YBUEvomqWohnYb9WAQa9Ix71C+p+1rVD733xJEv3mVCoEA2RgX79HDiolUd96JxYdPizUanDbfe7XUALTIqy6hUnhtYND5eUFzwZ+/p0Px15W2NoZVT3emtPQP0GUQ/rB7xsJRfkF85SDWsQ9RgpFunqxb4Bt1pFR4ZSORUuIijwHOHIbIMt1VqZMaO7JZW/ltjr7li+yR2Z364YTNNcwG3+AnMnmk3IRBV5jKZyUT0wIOKRg9vCt6QFYDzLkCfMb6wAsEkJ8utFGtrDcPqkAujztv4TSBx0aggKpGVSTJXgul0dqGb28OfaAjkHU/Kb9WDDN9RAY12nx44j3eNmteXtVWynBdY9kve3Hb2cljWD0k+e+y4kzKAZA53xqD44gVkhludHzDOUQaY9nLhDlSV3sGinl+OY4k+VALwbZAJarZ2mbOPEMDr9fOIb7S3pmMycqjkEtoMTBqWNs3wJrpxXqt4fsJIv1wicD2uiwy0CvfkTBMVVQboCSWdMks6RYJkWSmSVuACafaY3SGPn+5ZomLA1Qd9HfqZ2u5hvjs7+cHQNRDmWyF2wFQ8cNN7kFUUOjGARB6cAgqAZsPp9NsXJLH3vEuV+PuR5ZM5O0thTq6iFLeEbqm1+v9OcnZa8OPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6506007)(478600001)(6486002)(6666004)(54906003)(53546011)(186003)(26005)(6512007)(2906002)(4744005)(41300700001)(4326008)(66476007)(66556008)(6916009)(5660300002)(8676002)(66946007)(8936002)(316002)(38100700002)(86362001)(31696002)(36756003)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFUraHBsa2R2TnpiaTVrTWFkY1hFNVMrSHY3K1JzNklJT3FtQzBKUmZEOXBO?=
 =?utf-8?B?aWFaOXdaQmZXSmVxUS8yZUYrTFVzK1o2cmlVVUZEc1VBQ3Myc3hCYytiVkxo?=
 =?utf-8?B?NTZmc0RTRHlGbFRWUlNJTGgydWc1d1hCZVhUMjRoYk5zZTZaZXJ1SWhvbG5Z?=
 =?utf-8?B?VEdydFZ4V2FpV2wyODAvSXdjNEx1dkVpSkxJUElYYXRLY3N2VHBBQUxZbXFY?=
 =?utf-8?B?MXhGTWlZQVA2NjZyVTc2R1RaTUU5SWttQmtpWFFPdE1xOHhLbS9YWGcxcWts?=
 =?utf-8?B?MHRsNDg1N3RPQkJId2ZhWlJmYng5WFRRWG5weFdiVklhTXZ2M2M1dUJQdFFw?=
 =?utf-8?B?anV2Q3Jnano1VnlKcUZja1ViVXJkYXFMVW14TTRlbUtZY29QYUQxS3docHdG?=
 =?utf-8?B?NHNKTlpmdWd3dWNpV1RYbW9Na0FPRG80dDc3WmRFekl0YmJZMHNSOEFJYW1l?=
 =?utf-8?B?Z0pmejRIWC9MRFJQU3J0QXcyY01MQTUwek4rRXM4SDRUK05MTFBSYk0xVTBQ?=
 =?utf-8?B?OU4vakd3VTNiT0FIUGgrb2VkbWYrZWxWZEpmcmxhVUc0eW5sMXI0UWFvVUd2?=
 =?utf-8?B?VlpSWVJURWN3T0FnOFZVc2hpdjZMalFBMHpGOEpVaXd2cXJDTGdjd1VlbG5Y?=
 =?utf-8?B?SnAySG5ESHM3Z1MrajBacm96eXFINW1aY0tBTHF5OVNNMDY5RHJIMEV5UU5Z?=
 =?utf-8?B?aVRQQnJodXE2ZEozZ2w5aE5ldElxKy9QTnIrZDJSNjBoUmllVkxsZEI4Ykxm?=
 =?utf-8?B?MDdTTzE2VURaOVNaS0tObDY3cEV2RkJablFTZk5tc0JqY2ZsUm1nV1phUngx?=
 =?utf-8?B?UitaYlZwZWorOXNhM0lCY3F3dDhjWTZmejJUWUxKekJFSG1Ub2JqQzNaUDRY?=
 =?utf-8?B?ZEN4MEVDVXlJREp3aHpWSzhqeGFxaFpLZ3RvRzdJZzdpNytsak5pSzJFZnFw?=
 =?utf-8?B?TnI1cWwyd1hjb01td0phM2M0Y2tSTHVaTjBwaUlQbDJKQ01hN0NvTXh4MUM0?=
 =?utf-8?B?OTcxR3dxSGZIenFOdmRXaVZGQ2cvSDB0cUthTjNlTVJvcG50QW40WE1ERGZl?=
 =?utf-8?B?d1M4MitCUTc3YnJiMXhDWGR5U2Y3Yk9kNjczZFE0WGVZdGV1ckNyVmtTZmNi?=
 =?utf-8?B?MjBreHB0WFlLZW9qbXZwdGZNcHBQajN4ZkNQamtad2hYYUhJa2N5Z3gxbExP?=
 =?utf-8?B?VE84b0hWbldpa3l0elAzeXovYVNqb2tnQ28rOTRLdVJsMmRVMG1kd214T2xv?=
 =?utf-8?B?YzFMNUhhenMvT0d2Y0xoL0VYbk5ybStmdDBYR1J5Q01MUWNHMURvY1VuSFNM?=
 =?utf-8?B?ZDhybU9Ic0E0VWdQWFVxRUJYTysydXBIdi9UQnE4M01sV0s5WTM2WnNNcFJ0?=
 =?utf-8?B?WDluWkR2dithOEw4QTRzbHVHd0ZobVNqT1JqNnNCRDJWWUVhRkw2bE1OWmtC?=
 =?utf-8?B?Q2RPd2hML2ZLVEtvTzMrbUJ4T1RtYmFQRW1jSGh3ZGxwdUJwcVlmUjhGMVdL?=
 =?utf-8?B?TW0rUVo0dkRTQzgzZjMrcytnU1g1Y2JzUTNrK0pPZTQ3TUtTSGdwQjl6Qk9r?=
 =?utf-8?B?M2QwSFh4MVQyMWs3eXhaMDVyZkJPdllYNFRFZTVpRG1VbGpGbUdaSmhPaEtD?=
 =?utf-8?B?dVJXaWY0SEkvaXNPcDBTNHZkVjNENmRyc3J3dkZBbFVaTUhCMTRpZlJtYlkz?=
 =?utf-8?B?dnB5RVUzb0NZWEFjU1BJb0ZhMUgvKzZEOHZPS2hPUUFMdDB3YmZzekFZQXNk?=
 =?utf-8?B?dGp0TGg1SmxGZEs1cmVXaVBmVEpuekdoOFY3SitQejhBOXpJWUp6aWdKR3lY?=
 =?utf-8?B?U3czUFN4WHRuOS9ZUjJtMjhGUEFidVNmbGhESy9Qdm9mZGNzRmdUdmRNZFJh?=
 =?utf-8?B?YzFBRlpFUkFtMzFKMEpvS1labis0bTh2dlNnZVZmNkZzNTRxUTZxeGpiNGJ6?=
 =?utf-8?B?ckFzSjVHWjcrOVlKb3g4MjMvdDFtNTNFaUNwamhKWkJBSlhKd3I0RDBuTm9P?=
 =?utf-8?B?My91M1VRN010NUV2L3YxVnhaODRYanR4UVlGVXRZKy9XN2lqYmUrTDdWOVZz?=
 =?utf-8?B?OTl2UDJjdWE1SG5sdHZrdWloYlI2RjV1MWNFUWhGUGpsNmIxYjNwZnpHVk9J?=
 =?utf-8?B?TWVKWlVmeW9MNWQxcHhnOUZ1Z0luNkxFM1dhLy9JWG1UMjBGdVd3QnQrM1Uz?=
 =?utf-8?Q?SCOSHeSFR1eXqHyWuf6Znr4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXM3cE5mSnQ2Uk00VzR5QWpwZ1hjQzBFWUxHa1d2SlRXY0tuaDVpQUdOdThY?=
 =?utf-8?B?VnlaVWNUVmQrVDVaZFlpS1NVMlhXWnpDZ01KUVE0eHF3bThUTi9HZlhibFZo?=
 =?utf-8?B?SkxXQUVCbDJpSVZSa1pFQVJ2TFRuUGl3UXFaMkt1aWw4aUtuVmpCeGtlamwr?=
 =?utf-8?B?eUM1WGJ0S2I0K29qd1p3dmxGWUtXN01lTllBOWpRb0xKYkVYVVdlUTU3R1cw?=
 =?utf-8?B?TVAwVUsyYW5JWXpPNnhBcDJOMXVFLzF1cjc0bGRSUjdIMHhHRFBtQVcway9C?=
 =?utf-8?B?YldaQU1aTzUrMWhlWXBaRzVza2pBbTZlcG5iTURMTTZDUUYrMm5pNHFJbDNy?=
 =?utf-8?B?L042ZDcvTDN5dVB4RWVUM0psSUU0bWVhZjNHRHBBUHRiVGVpNkl4YjdMU3Zs?=
 =?utf-8?B?ZFhqMzRmUDJBTm80THNKTUk0eWxpdElDUUE5dGR1cm5PaVkzdEgrbW8xdjVq?=
 =?utf-8?B?alV1TnlNcGdQTmd6RTVSbWtmVCtlcklkcHE1bkF1dGpFUmgvQXJxTkdxRjhB?=
 =?utf-8?B?QmozZVZucDk4c3RxUkhYMjREVFRrS1JjemFCWmwrUm9rRnd0SXM1Mk1vQS9n?=
 =?utf-8?B?SUxKdEFnSjlsbWdsdkQ1aDRVMXpDODU4SFEraVBvTmRuZnBTZ1ZHaURsZm1P?=
 =?utf-8?B?THdrUnN1QkpMcGt2Wkh6cUlsSVJyNWlrRzl2UFA5M1psNE5oL2ljRFRwTGgw?=
 =?utf-8?B?Q0Zkek1VR3d5ank4Q2RaSkxqenJ4R011dlBWUzZPWU9qQ08vVnJab2hnbUNX?=
 =?utf-8?B?MWd5QzBuWUw2Q1FkdkZNaHRacDZjYVZ0Nm54RjR6OFA1Y2ZFdVVtc3BLQVNl?=
 =?utf-8?B?Y2VscjRiV2hYbmN1MkQzQzBob2NtcXVjWnBRV3pTczlKMzlqUGhQUXFOaVRH?=
 =?utf-8?B?a080MnRLdWUyby9ZQnZNYm9nK0kvM2ZGejZxREw1WFc5b2ZOd0pieThNTGVZ?=
 =?utf-8?B?ci9MYmtlV2ZPeTE4SWhSQkt1TUZIUU5oekl2akRycHhjQkZmeGxtZGJ3cnFB?=
 =?utf-8?B?dkgzdUpNVmxDQWF1TG9CS2VTNUU2VUZFcUtnTUZJVVNnNzJseXlDMUhYa3dP?=
 =?utf-8?B?VW5zMGlIN3dsRUNLSklydTVVeGQ0WnlFdDRMSHZPNkVrejVxd2NlWVMxYUY1?=
 =?utf-8?B?aTgxREFtN2dxeGh4YjJoN1FCVUdFN2F3ZXVCMDBycDlJSzJCV3lhUGsza3Zi?=
 =?utf-8?B?WDNweDJNZCtVZmJXdlYxTXJtY1lCOWdvSzZjeGVoNFp0Y2RYTHU2QW84alB2?=
 =?utf-8?Q?d7wW5iIZpzQPN6p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a58ba4-b253-414b-59ea-08db8798beef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:10:31.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYOQ3IGSASsRs4QbYWXe3T0JkchzV0EbxE3GOVJohEb3d+v/oZTubgM8AkLFBRjF2zxBTKkVPzItMQqKsemXHFAm1a9M31DoMQDzCY3gKyHladjsbtPb4Ng0OKJuK68O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_10,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180130
X-Proofpoint-GUID: GXOvUUtXpzWfkNn5LTxqhV1UszAQ_hC8
X-Proofpoint-ORIG-GUID: GXOvUUtXpzWfkNn5LTxqhV1UszAQ_hC8
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

Hi Andy,

On 18/07/23 7:28 pm, Andy Shevchenko wrote:
> On Tue, Jul 18, 2023 at 01:58:46AM -0700, Harshit Mogalapalli wrote:
>> Smatch warns:
>>   drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>>   err: 'rxport->ser.client' dereferencing possible ERR_PTR()
>>
>> i2c_new_client_device() returns error pointers on failure and in
>> dev_dbg statement we are dereferencing error pointer which is a bug.
>>
>> Fix this by using IS_ERR() which checks for error pointers.
> 
> ...
> 
>> -	if (!rxport->ser.client) {
>> +	if (IS_ERR(rxport->ser.client)) {
> 
>>   		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
>>   			ser_info.type);
>>   		return -EIO;
> 
> It should be changed to return PTR_ERR(...);

I just sent a V2 with this suggestion included.

Thanks,
Harshit

> 
