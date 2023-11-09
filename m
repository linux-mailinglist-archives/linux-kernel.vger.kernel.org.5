Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32C7E7533
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjKIXgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:36:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871FBD63;
        Thu,  9 Nov 2023 15:36:42 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYFil011425;
        Thu, 9 Nov 2023 23:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RBjxJZQBkzNhu41efoSis4zWwV2wMO1EXsj/RuEGuQc=;
 b=XZO2M9mchmx5BlYMpAaVVgFrADZjdSjUpVdTe8gpngUA4B7B1x1p+Fd6wCBk9hpI3Xw6
 mDL66EQQAP+aCK2yi6/nHm4M4UvQTtLD0rpXImLSlu9eCPH7OeLUkZp59hOOgktFm/UV
 NzGxCoCgaCaeAHc86yivFiE0CrvXFb4Kzj+ogx4PB8F+5UA4GJRIoNXusEmkpAAb05FT
 HQXjbF9LfnOIoITck83bjPKokoohK/KT+EA6jH6sWD3c3fmjIDnAg2L8XVzW86NyZKgN
 9prgBackQSNmWLxrQBXrGXDJsy4995Qw+5g6OwpGhswV7E/n9R4WHz6tSX5p5htETmMH Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2059wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 23:36:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MwVGT000544;
        Thu, 9 Nov 2023 23:36:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1yp609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 23:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2QJoqt+lDWlDKTxRrB6lKzkQEoZd0lBx+kjGCpBN5ztnpYywxP8nbf9sHIhlcGB0YcPzfXSwCyYkq7BpnmeqDiHySK7sw7LiQykK8QiC+S2GbQqvfMtu1Uru1UHBpSXrqbpWoG52rnT02yPP6K7AUA1qKeXZXrkDltMa8L/VU7acaf6xs16WXOr/bWNLWfk47E42F4J7TNUQC2LevoJfKSExbu1tv/IQrOOZ9VyNG2ISZ3HwBjmG7IeEf/5y5jhB6JsArh97hrR75KXwRLDj4cDh7HdUjA/UqXJRrZ+oz5c+WfcS+Dgn6gCIzqs1r5ZT0vExiPZTYmqg5LBQ2iWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBjxJZQBkzNhu41efoSis4zWwV2wMO1EXsj/RuEGuQc=;
 b=CgrCyPrnPl/6dSTbzR2YBtlYaURYV6PvHpYQRm6kMYFJY+S71Pm3j8WdW9wCwuyuT29FpVc9aB+8Nw+fj/spc+7enM6yhGwD1SeTSkIXUo5y6H9znVhQQ5IdskOrjE4hNkv3UwYbLIemJUXesEn8DE7bZ46ahfDHkU/31D3cOLbHGdDpI5YZ5LM3MbIkLC8wuosrwoaX4Yu6s21EYJjdjfkrjaax6tT84kSfq3YrgIeO1zEQ69/FxodIGnEF/7w5D9hOQjk5ZES8CUMSL8lZs2YyP7g7u/+iBmBFeK4qe3xuLz81/Uq0ATQgtKOj1/D3yE3XaedO5OHC8LvTmIpbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBjxJZQBkzNhu41efoSis4zWwV2wMO1EXsj/RuEGuQc=;
 b=UZuyke7tVuSwmCOhSk1dS72/Bh3PB+I4bB1625ZtTnnTjPiE5l5y1W40sr1pZoEiV5toiYReEGIYOOINTw1Z01gmOCMk2/RsdrHGyMt45thbF5rHQOhs7027MM9bHxGfZEF2BpUAOiciim8FfB+EsUpsm66il27W1D9JizppcM0=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SA2PR10MB4428.namprd10.prod.outlook.com (2603:10b6:806:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 23:36:34 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 23:36:34 +0000
Message-ID: <a131af22-0a5b-4be1-b77e-8716c63e8883@oracle.com>
Date:   Thu, 9 Nov 2023 15:36:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] workqueue: allow system workqueue be used in memory reclaim
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        jiangshanlai@gmail.com, song@kernel.org
References: <20231108012821.56104-1-junxiao.bi@oracle.com>
 <ZU0r3rzjH1cIzqvH@slm.duckdns.org>
From:   junxiao.bi@oracle.com
In-Reply-To: <ZU0r3rzjH1cIzqvH@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SA2PR10MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9508e464-c49f-4560-5670-08dbe17cb561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2nO6EwhqOaOSjrxJbrJ7Lp6JGmZEh20rZyp44G+QM2TuF5UXcVZ6aAyNfOeOuj+qzCFVVhoCSeqXHwoM5sfDF9i3RHZ5YHRlXUyK/zXtnjPsyv1KjQwDmfOu2RvYfFgCs1q/1ICGe16p8cc9veSupBzbrYDdITeGDJqTJg409LfeDVuK8iP3pBA6AKWhhRTlr58wytLeHEM4PvlgxqJBeoY0Aps/0S5NG+9vup44jrl0eaFOeJFixVKsZeJDoth9s5tZ9oClEad0Xb/UxZI1Ls/kF8RXOVqwjKTlG3IJZwIUqqzcxgVNEU6tNZHFiCJcWUEgp9ojmkIesXp2raRW89qtctV77f8Y5JK0tx6N33FUfsUOA/GUZlAdWggCk9twL9O4RO7rJlcXXnwLqeDSTnHhe6aOqInCTRz3sBXkuWObIHHkJYg56b3bsaQyFOuYieYn+ScEUOvtGRqf9bR0JwHt3LoTLAjf6+027vIVCiZPEtrS04sZohN/91zO9LZW5/vVwXAch93VPG2ZZuv84WL8fIlsjb301TpoIJANaxEVdd1BtNuAXCwI9z7QRgKph0ixZlaXtrgLBRLKYl07zGD5IjkrlxGRzaLyYyHXQMORhUfptvJ4sm7B1Jup06Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(478600001)(6486002)(8676002)(5660300002)(4326008)(6512007)(2616005)(6506007)(83380400001)(8936002)(316002)(2906002)(26005)(66556008)(66476007)(6916009)(66946007)(31696002)(38100700002)(41300700001)(86362001)(9686003)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpuUmtSNUNXWGwwZitpajh4NjBrVFY1T1BnT3E2MityV2lJd01UeVhNS01m?=
 =?utf-8?B?VUhvemp5RHNtd0ZYR0RpeFZadDc5Yzd0UmhGWis5WkJkNGRUL3ZxTGlnUlBn?=
 =?utf-8?B?R0oxOGNqaGVTYXB4WGczeVV0czdhL1JRRmNZZEloOTNjcDVSWDF2VjlFL1Ft?=
 =?utf-8?B?ODBMZDFLT0FSM0gwZ29tblk5V29hQ2w1NndDZmFNQ2FWSVpqYlNuZ3YwNWpn?=
 =?utf-8?B?eXh0c2N6MHNKNlAxbW5HWVBqZEdOMk55cWF4V2VReEZWcHM1WGlhTTJlOGFG?=
 =?utf-8?B?MHlYQ2xleHdOTjN4RFJjREhTRU45UGdXSnMvQTVWSEVKUW95b09tanJBSjVy?=
 =?utf-8?B?S3U0MXFna3hKa3U3TkJIcktMUlJNbWxEZ041WGFEdEFMTVcrOHJ0NTlERHJZ?=
 =?utf-8?B?bWUwNTlhTHdIMWI3Tmpnak91R0ZXbG94Tmo2eDhyMWVRNmEzNGU0WllNcWNJ?=
 =?utf-8?B?TzJHNlFxK3NVbnhiRDlxT1RPcU5MMllxalF3MXdhMitKbEtqSmZxaFBBTnN5?=
 =?utf-8?B?ZWpKT2EyNk1ob0xFb1kzTnpvYy9SSGlieTVuMTJ3RTJzV1ladExwR2I2RThV?=
 =?utf-8?B?RWZPSnlBa2hubUJ3bUJnbWtXbUpZQThLZDhqdG1kY3ZXSzlqWHI4T1prQ1kv?=
 =?utf-8?B?RnNxWllUZ2Rzd1c5cmNLMHV3ZjlvV3dmeUdTUmJRMUsrckowOGh6MGMxSThi?=
 =?utf-8?B?Zk54Mk5qRGk2SVdQb3g0QUEzaVVsQkxkMm55ZGp1dFNCeEJ4dXJCQUVrODUr?=
 =?utf-8?B?UU9WaDFGTUlOSUdRbzR0UlFoTFAwUG40Z0tSVFNzR2hRK3lsWGxPQ20xMzE0?=
 =?utf-8?B?Y1JZei9NY3pqaWdrTFJVRHZxeUV2d1VoT1ZrU21uMnZ5MVh5cDFHaFU3dzY1?=
 =?utf-8?B?MW9jS3lrY05xTjh3MGhweVNXeklVZW14M21iSVI1YmcyWk9KYldvdS9OZnBI?=
 =?utf-8?B?Wm9aUC9YT2w1TjRvTEIyQUR3MWcybzNNZ011UGJNd2pURnB3WURRcXEvR1Y5?=
 =?utf-8?B?YUdualZwcnpmU3JiRXRnOS85R0dPbVZPOVZZTEtTbjVWZmkwTGM3c1htd2cw?=
 =?utf-8?B?aENVSVlIT1EyUC9YS21UNDJVbVBxbzBZN3E4aWNaanFPVExmcDZoV3paQ2ZE?=
 =?utf-8?B?aE5UcmoxQ050QXhkY3UvamVwaTRoeGZCRkM2bXVmY0t0anFCMGFlWHcyWGFE?=
 =?utf-8?B?NzV0NE4wWjdORExhenRTWThsYkYwbVAvZWN0VkZZZjlGZ3pKc1dJYXB1MGh3?=
 =?utf-8?B?a1p3b2Z1MU5HTWxKcVkvUnRSSUgwSjl2S0phMk1QKzBsQ2JObXRGWjI2a2FG?=
 =?utf-8?B?cTNpa0orQzZ2bndvejB6bkg2OEVITUNWekQxbG1tOUlPRHlVdkUzRmUwRk1V?=
 =?utf-8?B?ZExMeXVVdjFwalI5RFd4eVJPNDFDaWZOZ1FERkYyU21qVTBad3RkRnludXEz?=
 =?utf-8?B?RmJCOXRZUCtzK3l3UDV6UjVza1BsWHd2SEd6QW1OQjdIYkQ2TysveitYUVpX?=
 =?utf-8?B?cGwvcHNiNG04cFBZMFpCanZ6OWpMSUtmaG1WOE93Zk50TWlKQVlDS0tNeEpZ?=
 =?utf-8?B?a0g0ejJXOUxxTkVCWXBsaXNrTmdvaTBIOHRqNHlyZTF1cHg0akJGbVVpbDZ2?=
 =?utf-8?B?ZzlnUi83TnlhYzNRSGZxSzJ1eG1QL2kxNTJhcGUyanRCV1k2Q01SUFNTOGJU?=
 =?utf-8?B?SkxYOGtpa29wSnYydmpLZXVDTDdiNGN0cVl3SmpGQVFqMkxUZElybHBvZy84?=
 =?utf-8?B?WmdxTC9GZHF3RzYyN3ljQkVlcnFmeWlyMzcyVVI5UXBRdnpTYk9yZmpCY2pN?=
 =?utf-8?B?VG9sUEpYYndmNTM4RW1HOHBVMFRtM3BMN3h3cXZaZW9OMU1tSjRKc1REWWZV?=
 =?utf-8?B?UkNRK1FWbHhKNWplV2lBTkw0NDNmRkZPamNLWDJibFBJVVVWSzhGTnZDMEN6?=
 =?utf-8?B?Sis5Z3J5bitGYlkwNjgzSXZxSFB1alVmYWhrQmR6MVhQSkIveGl3Ty9Tc2tj?=
 =?utf-8?B?N0tFQ0dpQUIvUjlsMklXQVY4WHlRa0szVG02dGdhVGJNOHVxSDJoR2xaWkxx?=
 =?utf-8?B?YnJ2M1RZbSs0S2FaVys1bFBzb0tKQmNPM0JhdU1xdGorRDl3ckFBL2R0bzAx?=
 =?utf-8?Q?8upQyczxZoY7GaXxWSm9JhtZB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QZRRUGD/AST+DCT/G7Yvtvfx7DyGgcINayU8ugP1A09PYu44+2hhIMD+S3UxGiG0iszcepMoZp3MqdybuGfSoOQ05bfxpdjtb4eNE/T4vYQUg/WnfxV4XjlSNwdRIAeJaXMmjEKODvSJMTkiDA1A+1WgYpt6sc++MXQfOH159UzHsYJsm1kL1nxdF4icwAX+bs2z0cePNnN8isGsM94BV2+1rRNVkcArVf8HHPDQos/ZJ1AsCsMC2EMj4f0D8ZYzVhD9xcofxqotTlTRmXz6F1tFIWiQfjeyLr+m1FxhgIGAt9n55ITbFvRDaegLZy9SV+8qN45/D9lmG9Q9mdgOMGaOsvHR/rQU61F8AztX1GlaGCcFbOy5P9SG53vmpzdfStN92il97S7jA7Rb4QY1rmHr70F1virNwz/sTi8AorKnrb582NAQx8bZT/ybhj/0iVZzgOkDRI7IP1MaKBwch18r3+DpcHrurrC12vCPCXHsyOQDLX45/IZzqyXYqpjbYx6aVbXwbfydXVUWyUO6pjJQjnuzEbUZCnpp5297RzGYvGeYN/XYWMhXq9ILiOMU2jvkek96pCP5qmxDyygxCmoWc54wlHUzULjkcAwWRfC4TGsgDf2/61YNVuUQq8tCdEgkJL+BiqO+7NsxU2YVkdKOqfgYfPjxyzxh1OOZAO6VIHv9Ji32UP5x0AeeF4WRDl59R8QpGRGtvpG6fN3TyrkIluYHAmj2Qlw3zpLIHX4K2M26ruxW+96tBko0hUHYYzZiMtvj/HPsHiPzx8xCPkkqa8FPbtbw26/jiJZXAIGbqWdEN1sW5sci+IjwRWKi
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508e464-c49f-4560-5670-08dbe17cb561
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 23:36:33.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79JFvfm1rTJpL1m12+XUuQL08O3KbXACe56Ta+akscPYg9Tk1B/qrSjldVHieUAAoM25dUH26iGoNZU2/aiLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090173
X-Proofpoint-ORIG-GUID: ah8eKPEq7mlm17iAW2QMGZHpTszG5EQI
X-Proofpoint-GUID: ah8eKPEq7mlm17iAW2QMGZHpTszG5EQI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/23 10:58 AM, Tejun Heo wrote:
> Hello,
>
> On Tue, Nov 07, 2023 at 05:28:21PM -0800, Junxiao Bi wrote:
>> The following deadlock was triggered on Intel IMSM raid1 volumes.
>>
>> The sequence of the event is this:
>>
>> 1. memory reclaim was waiting xfs journal flushing and get stucked by
>> md flush work.
>>
>> 2. md flush work was queued into "md" workqueue, but never get executed,
>> kworker thread can not be created and also the rescuer thread was executing
>> md flush work for another md disk and get stuck because
>> "MD_SB_CHANGE_PENDING" flag was set.
>>
>> 3. That flag should be set by some md write process which was asking to
>> update md superblock to change in_sync status to 0, and then it used
>> kernfs_notify to ask "mdmon" process to update superblock, after that,
>> write process waited that flag to be cleared.
>>
>> 4. But "mdmon" was never wake up, because kernfs_notify() depended on
>> system wide workqueue "system_wq" to do the notify, but since that
>> workqueue doesn't have a rescuer thread, notify will not happen.
> Things like this can't be fixed by adding RECLAIM to system_wq because
> system_wq is shared and someone else might occupy that rescuer thread. The
> flag doesn't guarantee unlimited forward progress. It only guarantees
> forward progress of one work item.
>
> That seems to be where the problem is in #2 in the first place. If a work
> item is required during memory reclaim, it must have guaranteed forward
> progress but it looks like that's waiting for someone else who can end up
> waiting for userspace?
>
> You'll need to untangle the dependencies earlier.
Make sense. Thanks a lot for the comments.
>
> Thanks.
>
