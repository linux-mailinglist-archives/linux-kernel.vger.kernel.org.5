Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4508C766731
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjG1Ibl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjG1IbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:31:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207713C04;
        Fri, 28 Jul 2023 01:30:25 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1glAI002133;
        Fri, 28 Jul 2023 08:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lY/pc/ORJ2uTaPIcyb59DvxRDlEW0QHLq1XDjV0xhO4=;
 b=QtFSxmwiau9mmKNqMYV85KaaH4XhZbJCIDUGw8C95f0lZNoF3GdG85/gZqGTuGCcflqp
 UHArpvLZ0Bzq40jhVP1d0MqB/58uAEI0PPSBh4q3s3JE928DltP/pYS3y26Pe1f+YsE0
 qXuycD8Xr58VtUNVu0oyuKLpyWM18VKJuXiDjIEZCTP5KA/UshiJAD9d+p577pzkijgC
 T0zvVjVDILVGuzguxYZ96nn3CrYkl/CDRKfl+PjzZIL7QXrAxGK9zxas7Z5s3Bl6h2l6
 xDJ4W5pOZoxMf/isDQuLvkw4FPRMVFgiiBvbDKdB5wR9oET8I3jxJ076wcsURUQlfzXI 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061cbgrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:30:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S7IOZZ029437;
        Fri, 28 Jul 2023 08:30:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8r6rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTKtqEe01OG3dLNVPyOyseWJp+a/sZlBWKzcEO+d+xMrnlI0GvRLFlP7lWrN7fLZCzBj0Rf9zYI7XSVqpabeerzDKwMpj285LSiw8rmaxMpHBGijPZFe/BNfGi0cXxiCa/nGvqA+qtFQJsGTTIE0nA24PzKzr0tGK3kOgnPNQtDSdsBCJoVjhAyEqSiM/uimrud10I8I0n3LnNug82NfwZa/HyLmi5ss0Hbhq6dzlbXH82DF2dCqsIwpUU9Gg4+iCfiVgNnSEQqB53o8MQPxPvCioi90LPP96nlvDoMMLYdy8DO5MxYJRVOlo/y5R4iUjWHBcnTeMtY2/u7Lv0apmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY/pc/ORJ2uTaPIcyb59DvxRDlEW0QHLq1XDjV0xhO4=;
 b=AsR5FB2D4XlKQ6RaHwFDFV/uS/iz4N+UZGQXF/MMVi9uyyZVXnK3t+WTU2h303PrLluPiKNZHJCcNwCm+st76zRWnmlQSjebL7BuGXOqCDWu2z3NgXG6zPI5OHm6W7JRymOZfv613K/ycP1zropt3EcURoC9U6uhInnoc72sth29AFDakqVbDxu0BGgGvQ1b+vHuAohDk2fyrDREMwbRObRi+K35zSa7aqxM2uuhTtS5Opgxc5Ff6Wz0Lfth1/8sgiKUFdckwvimjdg8UjSB3RIUPR4uP1BY8rmOdVpPZaXJ4593zIgDkjKl5nhBdaPicJm0+HtO2/x1SNYTlltw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY/pc/ORJ2uTaPIcyb59DvxRDlEW0QHLq1XDjV0xhO4=;
 b=sLdluOjBByjh7MAnd67rLyAsks24Kj0bjLqhQMWDKAeqLwwS1XvWaCe6iv7CiugenjF1VlyGvaY2m32OarlzCYKOQNNDEC8YE4crEHJ/Q/rXpa8d68LtZjRYIRJYycGe6Upj4rIVwXQ7MH3QaAYegSL6RoeJqTlA30hOqrMcpgI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:30:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:30:03 +0000
Message-ID: <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
Date:   Fri, 28 Jul 2023 09:30:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] perf test: Add pmu-event test for "Compat" and new
 event_field.
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4ad68c-68ce-44d8-02b8-08db8f44d731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dlf/rVAGHQUyx489Sob/dmGRejmm3sZTVv4tKMKg72JEg4a3tpAYgKEsPm4CPrD5t5hBkjXuOIollVpGAAe1hqxEoZ7C6GLEDboHJ+sN3lTXwuNr5Q9n77/kUkfb9+Jdb2kCflTmdxXP7P6MWWIJg/rN3sRwJYI5c+Nheyfuuoz40VOQsHlS1Df+62FtDkMyq20827ra6efvuq9GLNDFvB8r5zB/DCwt2ffV+TrWrQXu/D3RatI4ri+vhH/bGFwZH0D9+da0REhGIptrHbLfEsBcWOcqG518oE5vkuGGJ3/8DYOsOA5UUDNrf3NeLzXc2LjGUq4tj2zMGiKfprlLWT4/y5kAZQSOA4MbkaBlYg/gyzr1L2TcaTy736fJOfHRnCCK3jeZHvLcAgyuEP+7pF0QQ34qWIBzuOxbyy1yCGXDtVNSiboUm5J9owoulMl50DXudNHvztRo1ut6sJtIuKaAra71AUTZmwr1DzA36SBOCO4NGqsUZ6I66oiGotzsVXFrGusXTASVpsECRbqHsveyZdKqIziNp4dDi4TWySdUbBjs76J7q51uwfEO+K/ltssHkC4CxGZbdP5Si8h9hORGQ4TYUb/h87jMxg7uor0wsD0q3moGePtReWgYtTBWaK6Jm/yLuy95uUD588PbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(2906002)(6486002)(36916002)(2616005)(36756003)(38100700002)(186003)(5660300002)(7416002)(86362001)(83380400001)(31686004)(31696002)(41300700001)(8676002)(8936002)(26005)(316002)(6506007)(53546011)(66556008)(66946007)(6512007)(66476007)(478600001)(4326008)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdPNDdkdHJ6SDJhY3ZEZHFkdEcxS3V6SFY3WWl6NDhmUi9ySlc0ZDZ6NFNY?=
 =?utf-8?B?WEozczVuOE5BaDVCOUNwTjVoYk1GcEZDaE9jUVFLcWRyZUZla0MwSlg1UmVV?=
 =?utf-8?B?dTBESi9UVmthb3ZuSjBqQ0IzM1Fyc0NQWEd3VndNbjlnS0phcGJzZXpHNjg3?=
 =?utf-8?B?b3pwOFh1QTJyN3IvbVJFUkJtU3Y5QUIxUUZ0N2xRK05QQWcwdVlrelR4OFF1?=
 =?utf-8?B?ZUNpQTlvc3JtbzV0OGJ2VjFjZDMrZE9xZ05iaTF6VjBIbmNSYXNTNEFMK1lk?=
 =?utf-8?B?YTNqcGs1by9Ud2wrb1NWQjRyWTJEYndqYm1uQmZ5NlZvZDVFcy9SVlBqZktx?=
 =?utf-8?B?T1YwYnpUYzFnOVhYaVk5WlJMbVUwN0JrSXB3Y3d5bjlqbW5kZXVPaWRlajl2?=
 =?utf-8?B?MUtQRytWVEJ3WHk2cXlWbldQWXB2VnRuZjluYmkwblU3aVMyQkJLeWU1QUJN?=
 =?utf-8?B?b3UzcUo4RFNYbGVuN3VBN2dBMjc1SWtOM2VUcFVVNjJYc3BuR2JNZjNaWHRP?=
 =?utf-8?B?ZEEwbWU1TnhmN3A1TEV6c3V3RWV6K3lIaktER0QycWIyMVpSYllLQ2RERUIv?=
 =?utf-8?B?WkpHOGdIQkFVVmN5UTZkVlJFa3VKV1EzZVozRnU3OG4zOFJsRkJ4MUdjdFF5?=
 =?utf-8?B?Yk9kZmhocnJGNjYvWGU4UTZKY0xjcXllRktZdnZJQnlPVU5nM2lJL0FtWlVO?=
 =?utf-8?B?eU5rQnBNUDBvak1QaktHbTNPSE8ySVJVUEFuUVJVVjJ1UDVkZloyRTdIYWNh?=
 =?utf-8?B?M3pINU9qajBTMVBFa1B4RVJ6c3NCMjZjL0xtZUIzSW5teHRGTit2b3J6dVBo?=
 =?utf-8?B?L21SMnBEL1REYUVMMUFUT3Z3R25VM083WDN6MFc2RjBhRTVGZ3ZLVllITWVy?=
 =?utf-8?B?M2tEdklrc0ZjMGx1TVF5aVc3ZGIyQmxYd09sZmt5MVoyVHBRTFE3RmwvYm5s?=
 =?utf-8?B?N3hMTWt3RW9Qd0pnZVNwT1BNRnhkUFVPNVlXajFZZGo1NUFmV1hLdGx3UitF?=
 =?utf-8?B?SnVsandha2g1eWNrN1NwUUtOeUowUjNEVXhGK1EwdGJ6UExSU2c4blpOazJG?=
 =?utf-8?B?cmtrT2VabmNGU2daNDNaaU4wNFZ5b1NvRldnUXhIWXJ0K2dZdktIS2dVY1hK?=
 =?utf-8?B?dnRKNlAyQzJ1LzBIWU13SFJvZEN5S3YyS0EzSU8xMWM5MGNJdzM0Q1RLVlpS?=
 =?utf-8?B?VFVVM3gydzFBbXIxVDNMaGdac1JBeTYvc1QrSUM5KzNqYlNZb005UUdLenJL?=
 =?utf-8?B?b3RNZTM5and5UG9BZ3lheDFVbXJ0Skp6em1sSDgzbFJBa1M4aXppcnE2RVEz?=
 =?utf-8?B?SDNnSHRKY0FBR1BWQTR2T2hvOTdnMHBKL3AwbFFITDRIM2ZKTHFkd1VqYzg5?=
 =?utf-8?B?L082dzAwemwvT3RjcjRESlFZTGlmSTFWckorRDFRS1FZNExzMGNFMUhUTm95?=
 =?utf-8?B?ekZ3d1pYc0RTakhydGpHZDlkdUIycGlxamlLWlc3c2pxVkVGeEl2NGJRVHE4?=
 =?utf-8?B?b2tGZ25yaXhXd3N0VC9qaW1uTXFhQkk5MkNkbytkY0ZWRDg1d3RsRUFEM0k1?=
 =?utf-8?B?amJoaERNVXJnSnhKMk1hMGJVbmxIQm11MUNlSW1NTjYxTDJZNjJ1VXNwdEhI?=
 =?utf-8?B?RkR0KzNYZThMTEZxNEQ4TVNXOTNLSkJEWmhUdkFSVFdXbFZKcllhZWVuUzBz?=
 =?utf-8?B?YkRJQUE5TWg2TDRwN2lqN1laNll3ZlVUQkFwNUp5anpPd2s0NzJYUGs4Tnox?=
 =?utf-8?B?cXNrNldSQlBYSks2dWgxZGtZeGJybDJUNFdoMnVvYnBWREFWZDBGYjR0Wk1K?=
 =?utf-8?B?R1ZNYkxobHV2bk9JRHlBZUh1N0kzQ1lHeWV4aWd4V0t3NHQxbjNmSEErYXRp?=
 =?utf-8?B?b3RxRDk3ZXBOQzU5SkI3UUxoeWZQQXF5VGZYZzZicDVtM1JxYTlKNSsydWl5?=
 =?utf-8?B?dXBvK0ZEcVAvcG5HWTB0L2NiUE1NRzdya0J4UnhLaXM5VmxvMWxER09SZHln?=
 =?utf-8?B?RDAvTmVWTEZNV2xQU2lxcVJxdVdnWDhDSWlkUm9TMnUrR1NoTW5TS1lOTEhQ?=
 =?utf-8?B?NXVKdGtwR0xSQ3NUaDRWNXZDMGxBSERqMjdZNGFtTjJRS0cyeXVGWDJualhM?=
 =?utf-8?Q?fc0Hhkw1Ou4cSCUCylCJX6fZI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qkd6T1NjeWFaY25pMURTSnBYekJiOTh5VDJpS0R2LzA1QXdYUUYvb2JIMUM5?=
 =?utf-8?B?SXprc3Z5OHdCcHVVK2x3bU5HSjJpMk5qZTE1V3R4OEp4N09odzhsMURsK0J6?=
 =?utf-8?B?N1plUmkxekEwK1lYUms0SmVBVk0vZVhpNUxIWXYrcEpBSkp1NDhUNzNuMkpX?=
 =?utf-8?B?b005UXR5c2hUWm9Ed0ZrZVozK3g2WE91SUVjODlGMDlLalNXdEp6cXY0ZkdI?=
 =?utf-8?B?V2NDZVZsZFJJbFVLek9oMTAvTFZhbEM0MTN0eU1GVWdhL3ZpZ2NlRXlyQ01K?=
 =?utf-8?B?WGx4RnhrMlZOc3hsaUZJemdkNkxMVmlrZHhTaWo1YkRtTHlmbExnSHU0TEZG?=
 =?utf-8?B?cTh6aVU3Q0pobkg3b2JXR0h0VjVWQlNudE5ib2FIdzVDODJySFY1MkVXNnFK?=
 =?utf-8?B?Mi9NSFRmeTdPRWU5aDZhbUhTeVhyb1REZ09CUUlONGw2K0lRRjlrWjY1V1M1?=
 =?utf-8?B?RU9VVlVJYTVDQlc1QnYwSUd1T1l1SWZrOEwvTVNDS2V1REhVWGczbnlMb2t3?=
 =?utf-8?B?Q3ZGMGlxcVRFZHJscHpyUmRxNDdQbnNURXZRUkdDVncvRHlOZ3I4dnV4Q3Yx?=
 =?utf-8?B?dGwyNlBYSkgwMSsvbnUwR2FxNWFzSjM2T1JBdnhrTzVwbUF3N1NSTWd4U3pR?=
 =?utf-8?B?cWVRYzlqc1kwSVB6SDdSS2xvYVJROFRvRkRMSlBRTWU2WkZFbjc2SjZhZGtk?=
 =?utf-8?B?SjZnK3FSS1A1bnp2N0V4RERzZHM4OU55ZDlxU2QvcnovbHI5ZkpaMng2R0ZC?=
 =?utf-8?B?Sm9IT21MS213R0VITE12UXB6aEZySitkbUdnWHdqWWFYZncwRmd6eVdDK3JF?=
 =?utf-8?B?L1l3TzlhTUpTOXVidFhDSWNYZzRuanB2ZXBmcXZ0SDFQNXlIeS80Y2daRWk0?=
 =?utf-8?B?YWJITEovN0wrLzVwaDVwTk9GNko4c0JRVm1Hdk1IbDhFR3pMSmNyN0c1NjZj?=
 =?utf-8?B?eDRETmRReDZtRTVRU09EUkJUZDV1dkxWYThtYzRPRndSOFo1MTBjTzhpNGxp?=
 =?utf-8?B?dExoaDNhNzJkU3BDQ3hhUERmZVRUYlhNNU9PUkVFbUUveEg0NlV4RjJHeThk?=
 =?utf-8?B?R2NMN2NrWVRWTE85QnZQNzhlY0srRFJjU3NaMC9FRVhpQkdSU2ZUZkhlWmhq?=
 =?utf-8?B?NzJ5SGVhaFlucDhuYW9oeFRhWHlpRXo5WFhtaC90Y0pQSEpGQ3dSb0lDSml3?=
 =?utf-8?B?S0c0amdabGlUdllCT1hsT3lEMXljY0FKcHlHQkgzZ3RkNDlnVmhBSHFIOXp6?=
 =?utf-8?B?WW82R1FaMmJtYkxiNUNoU09XVFQ0VVZ4ZVJma2h6WWNZdGpiUit1RnM5M2VG?=
 =?utf-8?Q?PdDkzZ5fm+ytZx3x19aK3+xDCefyqJuLhe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4ad68c-68ce-44d8-02b8-08db8f44d731
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:30:03.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEOZbLs8/zlD29Tg5OTLHSu7oLtyhCPSU9Z6VRvKKN3y9zh9jeCNXaXAQuM+5xkjhCHPse8AtRNqMzUaNc2zHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280077
X-Proofpoint-ORIG-GUID: 4Hm9cVJb1Yytd9tI7D7j3nzZDhvuD6I3
X-Proofpoint-GUID: 4Hm9cVJb1Yytd9tI7D7j3nzZDhvuD6I3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 07:17, Jing Zhang wrote:
> Add new event test for uncore system event which is used to verify the
> functionality of "Compat" matching multiple identifiers and the new event
> fields "EventIdCode" and "Type".
> 

Thanks for doing this. It looks ok. I just have a comment, below.

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
>   tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++++++++
>   2 files changed, 63 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> index c7e7528..879a0ae 100644
> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> @@ -12,5 +12,13 @@
>              "EventName": "sys_ccn_pmu.read_cycles",
>              "Unit": "sys_ccn_pmu",
>              "Compat": "0x01"
> +   },
> +   {
> +           "BriefDescription": "Counts total cache misses in first lookup result (high priority).",
> +           "Type": "0x05",
> +           "EventIdCode": "0x01",
> +           "EventName": "sys_cmn_pmu.hnf_cache_miss",
> +           "Unit": "arm_cmn",
> +           "Compat": "434*;436*;43c*;43a01"
>      }
>   ]
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 1dff863b..e227dcd 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
>   	.matching_pmu = "uncore_sys_ccn_pmu",
>   };
>   
> +static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
> +	.event = {
> +		.name = "sys_cmn_pmu.hnf_cache_miss",
> +		.event = "type=0x05,eventid=0x01",
> +		.desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_arm_cmn ",
> +		.topic = "uncore",
> +		.pmu = "uncore_arm_cmn",
> +		.compat = "434*;436*;43c*;43a01",
> +	},
> +	.alias_str = "type=0x5,eventid=0x1",
> +	.alias_long_desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_arm_cmn ",
> +	.matching_pmu = "uncore_arm_cmn_0",
> +};
> +
>   static const struct perf_pmu_test_event *sys_events[] = {
>   	&sys_ddr_pmu_write_cycles,
>   	&sys_ccn_pmu_read_cycles,
> +	&sys_cmn_pmu_hnf_cache_miss,
>   	NULL
>   };
>   
> @@ -699,6 +714,46 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>   			&sys_ccn_pmu_read_cycles,
>   		},
>   	},
> +	{
> +		.pmu = {
> +			.name = (char *)"uncore_arm_cmn_0",
> +			.is_uncore = 1,
> +			.id = (char *)"43401",
> +		},
> +		.aliases = {
> +			&sys_cmn_pmu_hnf_cache_miss,
> +		},
> +	},
> +	{
> +		.pmu = {
> +			.name = (char *)"uncore_arm_cmn_0",
> +			.is_uncore = 1,
> +			.id = (char *)"43602",
> +		},
> +		.aliases = {
> +			&sys_cmn_pmu_hnf_cache_miss,
> +		},
> +	},
> +	{
> +		.pmu = {
> +			.name = (char *)"uncore_arm_cmn_1",

Shouldn't this match some perf_pmu_test_event entry with same 
matching_pmu member? But is perf_pmu_test_event.matching_pmu member ever 
used for any checking???

Thanks,
John

> +			.is_uncore = 1,
> +			.id = (char *)"43c03",
> +		},
> +		.aliases = {
> +			&sys_cmn_pmu_hnf_cache_miss,
> +		},
> +	},
> +	{
> +		.pmu = {
> +			.name = (char *)"uncore_arm_cmn_1",
> +			.is_uncore = 1,
> +			.id = (char *)"43a01",
> +		},
> +		.aliases = {
> +			&sys_cmn_pmu_hnf_cache_miss,
> +		},
> +	}
>   };
>   
>   /* Test that aliases generated are as expected */

