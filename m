Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C979C3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjILDFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjILDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:05:07 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C7218C0;
        Mon, 11 Sep 2023 19:39:40 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C2MvVE020752;
        Tue, 12 Sep 2023 02:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=subject:to:cc:references:from:message-id:date:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=WY1u6aX/Ykp26SCAxxvSqeLGKoCEDyff2+UHdZ1ryDE=; b=
        Kb/GPBy7dhcbVz+gPYRGHDhnjZxa2+6f/pcDJ/XqVHCkbeb54VCQNKl8dtE1xIK5
        Ys0x1DIV94VfbbptCSbi8Ov3r/lnH4rvtuW5hakJx5+VDGhBAoR+U5yLFFkaa0R9
        1La+V9ESgKZ9LDdxi+xBPVaD7johNhjpDV3gd5ubRrnSd6VC0keMEEhI322WVAJO
        0MsQoW16LTEDkI9zpN4J+gIqfC26BTE2zhn27D7Ux98eTM5/aneO1XlK+EMxdVJh
        2BdouWWpr+mgugCxvwxhMLmnB+DziQS2OtsTUBKiKj/henAFASSyLpUrdS4AuMVX
        EOXqaGwcTueT098jv7iJ2w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t0dwxta2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 02:39:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn+1SZdQeGk//9Y2uJ+m3+1332gLnhPWkFIrrie0YrlvAMQq9oP2t9Lph6tgHyE7TKvyceTJBz0x9p3ZoZOrD4zx2DUcdH1W0gHPyl3w4FuA1/+3XSO1zQcvN6A+zbAzWZ68BRJ1MBLL/L+yQ3tnJAN+5QJihB0qH56PcjIKx8jFBND06G6QVNDdPVvHrO6GPMryzAOfUXUAuPUdxlNxLp1os6wPS3wbYi6O0t6Tv6Do9wMFVpvotKYwU1POd0WvuYG7BgJQ7eULY6pWH5awYkvv+9htq8bMw1uJVrF6T6Ql/X9Xfk+SoeJIKy479C0Y6vuu0yDA1vENRWADG2FEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY1u6aX/Ykp26SCAxxvSqeLGKoCEDyff2+UHdZ1ryDE=;
 b=YV96249Ik6gS4DUzeUWjYeKamtnDRHpEzcow0qkb2Yicr+wDhkiECnfCm1H917V4mm6Xp9xvX5+Z1zSQc8i84a+4juBJpuDEM1tSAjjnImcRC0wGBrfCZoIlas8gB9NCEUyPB7rOtS4/5GaOmLAQfBW+ERa10CgwodielAAo2C3iDuevazFmZ2TmlbWotSzsoH7VZU/DdfXuehLbaIXn9elM7KLbuekKGoVYWjadqPVgs3Cgv7kuXi2oceIGDo2TwNL4ApzjqgVKx0j93KcKJ9AevjNHRrDIxXTZVkGzggE2KcnQJajP8fkIuKqP6RhYF1sXFmQPVY6gNaHLX8jhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 02:39:21 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 02:39:21 +0000
Subject: Re: [PATCH AUTOSEL 5.15 10/19] usb: cdns3: Put the cdns set active
 part outside the spin lock
To:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pawell@cadence.com, linux-usb@vger.kernel.org
References: <20230909003903.3580394-1-sashal@kernel.org>
 <20230909003903.3580394-10-sashal@kernel.org> <ZP7lIKUzD68XA91j@duo.ucw.cz>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <6738b9d9-c172-8323-a144-79f7ae46bd0f@windriver.com>
Date:   Tue, 12 Sep 2023 10:39:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ZP7lIKUzD68XA91j@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM8PR11MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcf6964-f01a-4e65-c55c-08dbb3397825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sql0UhpY0Z1oU+7Hck2lsc8wGknOZRpmYtf+OSLXk6dkJ/TAfHeAEBNsqBBngXmmqT5Mv4jpIShGdI/cCXZ8AW3EurpSCUaYOrK8mCbH8Jtl8MZgJ27yKf9pcnGqx+M2SKXKUamRR51NmORml2nKnglFK5mOuOAY5YfVdoz5kjiInRbW1sLIYTAM4hhm7K9ejYzDZCeiucBIe8wVaUqHagkTn56DJOsd8UowdRan/6a0M23OIHYxk7SgqKf3tqhFc1my/4SGsDqd4FOCGET/0uPLAuCDT1hVVZNmXAkl9+DHYGSdE4fbS6s2c6qBa8Cocby5x6UwaqTcSq4k8Gx6WkCKQmvdFH8omKtd3h6yRHZLMhhAz1+oqrBNRyWOqjCTP5s2aPtknJ5n1f+0ZTMKBLWS6SGotQd+gbU0MlxnuKF2jODet5nuULu19aok/fA3Vdn10gKY3U4g+JSHAFfpe6Y3jN3DBfmPCU0oYouJK2zYlKj5PdEphFoVxJdgbEXL+O0ZC7Q8/h6V+ayjzSGeBVJMk8Bp9bAmyyVt1BgUffkE8Qn/DF37PY/gofvRLIwCrSYfHW1lmi3vfqgVwIUEEBooSUN/iF1rD1ChqjMImILyyhAdlq75nzqDwEkt3tGLGaghmj4x/ZG1nlfZinN5X/4Cde9Tssi7oK9z0AXwqsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(186009)(1800799009)(451199024)(26005)(83380400001)(2906002)(66946007)(478600001)(54906003)(66556008)(316002)(41300700001)(66476007)(110136005)(2616005)(6512007)(6506007)(6666004)(6486002)(53546011)(31696002)(38100700002)(5660300002)(86362001)(4326008)(8676002)(8936002)(36756003)(31686004)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?nhBPCb9dz/wwJrD1pgtbVrc6R/OrlHUTuVB44cB1em9pCqxbONJYTueA?=
 =?Windows-1252?Q?Rfmf8r35j+hFfl/VYw8OVxbKqrZB6iZ/9YvLVnQWxAkXB+PwLqDzVIXF?=
 =?Windows-1252?Q?DKDqWYoOibpASogrSnpwJhztVlfhgFdtJ5TPM20BqkqjOruttb4cJspw?=
 =?Windows-1252?Q?m5c1NM3LZXNOOWEe/gci+U8J84kQYCFITKA/5xaH+OAiv29KCxYyFNAH?=
 =?Windows-1252?Q?DT0kpYrwOa/qKd6EmMjwkUsheVriiwn8/sNHs171Vzmz1C/WN1OLddNu?=
 =?Windows-1252?Q?vgOF8mrilZSt+sMipWr9mhEfaXu68VBqnc18hPD0k3oYx/h7stu8NDGc?=
 =?Windows-1252?Q?tlWc323URSmMUyN3HhWL9Dlq4zznMXedTV2/DZ6G/MMuRHdEczCVRCFs?=
 =?Windows-1252?Q?yzEI11EtRqFtaGx/L0ZBEE2Ql+nz4QPT2m2aeDA3yJcOZPMFtn3k5I8b?=
 =?Windows-1252?Q?PnWeyOc72fyGvCK55ese62NywWtC05zlDs1BNFO95h3SiJ/9iKo8lh9b?=
 =?Windows-1252?Q?JSzUUWM0yKV/G9mfM3iLCBNiD9ALQqpsy/0o68umMDzdV7BQDiEkxJrl?=
 =?Windows-1252?Q?fq7InnpN/TbgehnzJTMHjWWglcXFGbKQ7GseYmda7pobaO970w5EFNVQ?=
 =?Windows-1252?Q?Db3927cn6UQqY/yJB8/6rDBb9cYBiTnyQtNkmkEAzowjdp0atIdXJi30?=
 =?Windows-1252?Q?odHi//QDBjH9/FWjgEuFZLHa6Y3a49rvpooaGuE1v6vGCE2ciDqsQRdJ?=
 =?Windows-1252?Q?2veoEbNGkb/o4hQV8CjtZcQ4HN0C63qfmTB60KKJuWbIlZj0yRvCMM0t?=
 =?Windows-1252?Q?dcfDn7ctmfPTCjTqQ0rvn2zNilQUNaX6pFxOqjsRFirEwe6FX9hXmkfk?=
 =?Windows-1252?Q?a1UOHmHDReHEzZRE32yvBgUYwhQXSTmpR2owTTRIvjB6lVvXMFzgJpK3?=
 =?Windows-1252?Q?tKqX5kcKIKtx30ZexOGfU26zOG8d6AZ5YDZ6VacRRMqLxjhSkOGh1ZGm?=
 =?Windows-1252?Q?JNVn1+igb+i9U2bEIV4IT4ydie8GLxhPhrW4UKlOFsO8MLBKjkKzKgqc?=
 =?Windows-1252?Q?a2U/z1VaJC9BLNlYvJt8O+e4nUVPCYySU4vBLGna7XD/SSqPaFRrrNSQ?=
 =?Windows-1252?Q?Y7uApFeQOaP2StqSIFyfUQyW/QqTwnnCF3HhT7hKw3yYEp6Uc+DS4E7X?=
 =?Windows-1252?Q?31NVt6jwGjzmCu1R40E1GTf4FkUJOzwRwnUEGPPN+wl8fwRH1qubSJw6?=
 =?Windows-1252?Q?0dpLCiu4bY/57OdGlEv4Z9lYjHHRv4oza5lSTZFlJ51B+fVDH5HOSvev?=
 =?Windows-1252?Q?o15TmSzToLvecXz6M6pLb1jsusSSLV1lexm4/jlp6ys0CzLcS+iMsyWO?=
 =?Windows-1252?Q?lK3n9faVQsX/Ybg+5yCBgso2YxnfVj0KzFF1MgA6t/6D8bSFSLh2uGzY?=
 =?Windows-1252?Q?MqH9RZE04wLrmMyecpAB6TGcmCbcZvnaichJuKHmiJNjwK4LfbnmBo8d?=
 =?Windows-1252?Q?N0xwT28bqtJ42er97oN911a7klUQoYzSaokeYQr3DOYzPnkIN1XZ3T03?=
 =?Windows-1252?Q?L4y47xesuyRMD+1QwBHlZbSUDHrFMo6mMLMW8MMLr4A/xJsSpUdE7ybQ?=
 =?Windows-1252?Q?jeT5ayN6l/W4AEYs0XoWif7yVcRr80qh0nz4Jeo7QpZpmXPv0y7lJ6Xh?=
 =?Windows-1252?Q?4ToSwEZRkiiPSofuw9pF3XCJ+v9eXr8hdYYhPNfZtZ2fEcEwTE3tKA?=
 =?Windows-1252?Q?=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcf6964-f01a-4e65-c55c-08dbb3397825
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 02:39:21.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfVHmvUQUlBJZnxjuO6dVDnvRuTTlg7t7i4lCO0qykji13b54WrT1xie7Ch4f9i5e0YGB3l6l/WmKa8uUgckN/mdYaplo1L4jYwcQVt9FjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5671
X-Proofpoint-ORIG-GUID: xAMryr4BX13eY8z4dPgUGLbiKVWS_r8P
X-Proofpoint-GUID: xAMryr4BX13eY8z4dPgUGLbiKVWS_r8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=705 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1031 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/23 6:00 PM, Pavel Machek wrote:
> Hi!
>
>> From: Xiaolei Wang <xiaolei.wang@windriver.com>
>>
>> [ Upstream commit 2319b9c87fe243327285f2fefd7374ffd75a65fc ]
>>
>> The device may be scheduled during the resume process,
>> so this cannot appear in atomic operations. Since
>> pm_runtime_set_active will resume suppliers, put set
>> active outside the spin lock, which is only used to
>> protect the struct cdns data structure, otherwise the
>> kernel will report the following warning:
> There's something wrong with this patch: cdns_set_active returns
> either void or int depending on config. That can't be intentional.

Thanks for the reminder, I will send a new patch to fix this problem

thanks

xiaolei

>
> Best regards,
> 								Pavel
>
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
> ...
>> +
>> +void cdns_set_active(struct cdns *cdns, u8 set_active)
>> +{
>> +	struct device *dev = cdns->dev;
>> +
>>   	if (set_active) {
>>   		pm_runtime_disable(dev);
>>   		pm_runtime_set_active(dev);
>>   		pm_runtime_enable(dev);
>>   	}
>>   
>> -	return 0;
>> +	return;
>>   }
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
>>   int cdns_remove(struct cdns *cdns);
>>   
>>   #ifdef CONFIG_PM_SLEEP
> ...
>>   int cdns_suspend(struct cdns *cdns);
>> +void cdns_set_active(struct cdns *cdns, u8 set_active);
>>   #else /* CONFIG_PM_SLEEP */
> ...
>> +static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
>>   { return 0; }
>>   static inline int cdns_suspend(struct cdns *cdns)
>>   { return 0; }
