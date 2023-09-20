Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C407A836E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjITNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjITNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:30:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34268D7;
        Wed, 20 Sep 2023 06:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI3YMOsqL6ELdn7rxHgMUiW07n4rkfnpKa8F4ucADaGxGYC9JWj88EJes+iJq754EJBlTosC3EubTFIVYfI8QFVm60TO1Xi00Xp8+P2e/EPaK3nPJe3OfpjRrmg3pgVVl+5z3FVoL75ANX02xr+dAe4FVLLD/oC+Y9iPf5a6KxNpgjkiapKLYkQ1TCnAb8ZCtdaXukDbjzaIjXmi0Ikp4+qn3YBLv74S6ljCA/FxaWAtr93vRjnQ9+4QHuRfptdAS/kR/yVQUpv3Y6JDDX9EnnqHcE8CIRk52fBQ+l4QCiK41PiuLQw3fQtD9MD7Bf1yJLKXXSIY+raaDEjfKOxxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=788qhL1zjY4VG56iI2o5ae9pKwUoREfZ6b4eOJdzhVE=;
 b=G1jTPjoTmGlX+70KDZbtytzhyGyd3Xwq/k8HVwj7LB8EP3jPfhrf4v4zhvX8fYpLyirqzGvYVuArm+/SDqSnhNecO6X1yhj3wA/HbukZ1UBydpwfFdDk7kwOnb+xO2PRib3rKBrBVkSIw+ih7Rh1PdEHA5lUoVKVLFlDKeT1KjoyDpMykrd0bRo3iuHELlsXJxNa2kIJexICYEPlz0vaSAbOeiIEpNGDicCX1X+3MfjyrRqa3pDvV2fJx7jUmW8lQWGQI4iFju7D5J4/xjML6asnNApdZXpQhB6UDCCF10c+AwgInOPz7IqW/nU0njEXDSVStyd4Yn/5dPUxy7f4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=788qhL1zjY4VG56iI2o5ae9pKwUoREfZ6b4eOJdzhVE=;
 b=VJZ/39+JQfxPOX2elHC57qN63nVu9JuMJUC86Z18uEeji6r+ajT52x5f2oszyoQewEWPRaMhInp4LprdYO5mT8rObTzF5IaFX27hEOY5Wxu73HhVZHVL+3zdCyO2guI7gR5UjxQ0y32FscEvvjtycruE5okAIB1s7W1GSIhXc9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 13:30:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:30:44 +0000
Message-ID: <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com>
Date:   Wed, 20 Sep 2023 23:30:36 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel] kbuild: get rid of unwanted "+" when
 CONFIG_LOCALVERSION is set
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230920015559.1877441-1-aik@amd.com>
 <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 50678f50-3b5a-4cd8-b34d-08dbb9ddcac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3asJVLGr+nOBgZFij0fiJYWsjh40HODy52Sd0soekNdli2E/IiLFcLBmKO3bMv+yD86OwTuiTgfquAKV4kmQ6TWVtjvF0wCtQIN5qURQNV2veRBUzlDktfiSZR0jGD6FUTjJ/SVkhaZ1x+TMxgdrYwzncBGyyXiOag6A9frgic1EFTg9qkCdO0bIpzqLBkzmwQS3eQxnXvRNTNHnzxhB54VZ8iaVQKJcZqG3ylW6z9iopi5WyMxxHpMS3LVK4K50ZnMfou2PCd6YkdSfEfqFnSABKAok6tuWme87DB904HiXxYpgGSFYCM+cJO/pwHDJo5sL71s5EW9rUdGp5mWQQT7mVfOIliEIW42/ub9rqvCtLedktCPz2QyntylBnO6tf84HympsWQgPBtfmvkkjkHb7t9qW1/uqX203ZHD4oBKGIYopgZm/yeamjgSlXYPjFRJ3d2T8vLE5xwpu7R5NtrwfOIH/iJA45gDStrsWYoQu36a1geEEbYxpWnWZcpHlMjzybZBezUfDLnKPck6sBlW8KEiosUjLxHkXhgeCUqqGc3ir1lfbMIKckdTdZDl4qoL4EgyroTg6A8qmGboZoI5mAVZL+L8grxSHKL81p1WkPpIsudRdVx7feJwGme4XVzKXd8BeZnGOytyl9txxrI/sLgqAoWuzZPt0TfmAu/SNQbek1LHEzFSYTh3LWzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(186009)(451199024)(1800799009)(6486002)(53546011)(6666004)(6506007)(6512007)(83380400001)(478600001)(26005)(2906002)(2616005)(66946007)(66556008)(66476007)(54906003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(316002)(6916009)(31696002)(36756003)(38100700002)(31686004)(26583001)(26123001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjM5eWJGSzJqaEFNci9YbXl6YnVLalVLdC83OEFDOFZaTW8wYndUZUlEQ2Rh?=
 =?utf-8?B?dHhIRHZQd3ZZUHo3bUNiTjUzMTc1TytnK2F0YUt4ZTd1VFJMZXpOK3FCeUdX?=
 =?utf-8?B?Y2Y2VFRFM3ZxRVVKL1pnc1NMb0hWV3lVQWRyUzgreGhzR1Nmd2E5aHpBblZ6?=
 =?utf-8?B?MlZhWkE0eWl2V1E5NHVoSVZFRVIyc2JqaTJqN3djZmZJWTBQUXQvTDJidHNK?=
 =?utf-8?B?M0ltQVFsNUo4ZFgwcjNZNDF3dTNEd0VEeElRRjNHNjA0SUtBd2h0QmhOOWRS?=
 =?utf-8?B?UUc4UW8xQklDMzNqRkZTYnJEaVpCRVBFaHB1czVZbkI0RFZWajVnZWd0dXpY?=
 =?utf-8?B?MjBPRWFockVrbUgrWFJyM2xTUFpkNDBWV3BqUW1qMHIzUzBMNXdDY2lzMXpa?=
 =?utf-8?B?citzUEN2ajFNd2tpQ3I5d3Yybk82a0dVZHRIVEs2blAxVEt6OW84am1BVkda?=
 =?utf-8?B?MldYaEZLRkdvVktMYXF2cXdReU02a1hlUkVWSEkzV01GTU0wazVuT3h3dmlR?=
 =?utf-8?B?YStYcUNidi80dlkxMUdIYWNSbWxPU25qVGRNWUpGTHlmd0ViNG1IdjNsNVNU?=
 =?utf-8?B?RHVIeVpoTEtkbjJmL0F1UFppSE9vTjVwTk1wbjJjMi9sYk1sV01NdGNJMklN?=
 =?utf-8?B?bUg3NEp0c3pIQ3piWVhFWExGUVZneGg2UXJUbE1venN1Tm9VVUh5QVJQZ0Iy?=
 =?utf-8?B?aVVicVFyellST2VuelpFakM0eUFUMnN5RzRnU2dSNVlUL1FUN3JqRWZ3d0ZL?=
 =?utf-8?B?NUhYNEpIM3BPRGVieHR2eWdwSnJaTzR2L2VldTlqUnhzTThFNTJMNFo2OG9V?=
 =?utf-8?B?YldvWXlKVlV5THhRNFNFREM3NXVIVWh2anpmR3ZEeEk5TTBwc3BpZDJ6VUtY?=
 =?utf-8?B?RCttZ0hHaEZhRHN0d1JpRHVSMmVwckRna2NzbCsrVy9yclVhaTd4dWpKcVRV?=
 =?utf-8?B?djNsM0IyV0pzNnlHR2hCU1hZdU1mdXROZVBoUEF2aVVoYzlnaFVidkRWc0Zn?=
 =?utf-8?B?ZnNEcHU5cllSUUhpQzY1R0dyb0lxTThJRE5jWEtKQmFJSWlxZmd2dG9Da3dG?=
 =?utf-8?B?Q0lCczdJS1RkVk9CYzdKZ3FqZVRKYy9vdUtETkhxM0ZJSUVhZnRVaXA0bUw3?=
 =?utf-8?B?NnAybUxKL2s3QzhhZkdzRW82Qk14dWtVR1ZMMGN1OEdjbThLUG02SEZvNndQ?=
 =?utf-8?B?YU1EMTYrU2pmdHJEM1ZLZTFobDBrQTZtWElWbFdxMkJWczlQeTBNUU5ZVzg3?=
 =?utf-8?B?UjdoUjdrd1UwVUVMOHUyUXdGNSszbmtLYW5ONG9BVXpYdzAvMmxQTENHWC9R?=
 =?utf-8?B?K1JDblJJMFBYa3ZPN0xyVEprYVl6b2dJd0VpOE5iamNBK3k4bXZiaDhXT0NH?=
 =?utf-8?B?dGRjSXdyY2syN0JtMzd6Q1JtanZpMVhVYXRhejJxRm5VTlRRQkp5MVlLZ0pl?=
 =?utf-8?B?bzdqN2toc3RWTkxRZys5b3AxR0Qzd29lOTdDbXVva3hGNG9adERqa2EvMnVs?=
 =?utf-8?B?RjlyNHhzSHBQcy9pYmcxSnRoUGNWNHZHS3ZHbHJTeE85N1k1UHdMTkNicXY3?=
 =?utf-8?B?OEZGVm5EWjFzR1JMY0lCYWdXNGcvYng3UmdUejF6YWJ4RW0rVXQ5a0YzRGN3?=
 =?utf-8?B?SHJxQnVCeCtuMklqT3BRQUV6alZTdWVTTFJOSmpLcDZ2VmdsMjFwUVpmeFc3?=
 =?utf-8?B?b20rdW9EUWFVckZ4dzJodWFEb2s0b2xpZ25FYkppSWxnZ1lsTkhPVkZ2cTFV?=
 =?utf-8?B?M0ZWa0tIVmw0cWxVcldVZktRbG1IcEJFKzdvUVJ6cDZBWXlPVnRYTUtIUmM4?=
 =?utf-8?B?Y3dVOGtQNFU4SGNFU0d0MGZLdkdKaVdJbnprTEZlNWVHSWN3bTVrWGxZVm5C?=
 =?utf-8?B?d3EzNW9jbEtVZmJxL1JmVFFzdUgrU00vRDJaeW5JYlJiMVB5OU1WQTlOSVE0?=
 =?utf-8?B?cHJnZFYrcllyT1F5ZlBObndrZUdXRW1vQ3lkdm5jOG5xeGpXSWk3MWFLQWdi?=
 =?utf-8?B?SHJ1U3RPOHZtZmEwMnJ4Y2VZNzFka2I2ZVRFSE91bTFFRm5DdUJUWXJKYS9r?=
 =?utf-8?B?Y2JsTllXQjIwUythK1dsK21rY2Z3WHhDa3NvdVVlbVpiYTI3ZG5RRHQySEYv?=
 =?utf-8?Q?eu/sGLRpuOMRsLX1xsmhflCJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50678f50-3b5a-4cd8-b34d-08dbb9ddcac7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:30:44.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwIc9nNxblpc7SxZwxGLJpd+PZQxDqlU1EMT1A+Lz97oKHH1onYTEo2Y2psLtXSeRPXgkEiyCoX1Q6js02CIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/9/23 21:59, Masahiro Yamada wrote:
> On Wed, Sep 20, 2023 at 10:56 AM Alexey Kardashevskiy <aik@amd.com> wrote:
>>
>> The scripts/setlocalversion script correctly tries not adding "+" when
>> CONFIG_LOCALVERSION is defined.
> 
> I am afraid you are misunderstanding the script.

Possibly :) I should have read of "+set"... sorry :-/ Thanks for 
spending time looking at this.

> CONFIG_LOCALVERSION and the "+" sign is unrelated.

How come?

scripts/setlocalversion -> if [ "${LOCALVERSION+set}" != "set" ] -> 
scm_version --short -> echo "+".

Where is that LOCALVERSION supposed to come from, and when? Is not 
LOCALVERSION related to CONFIG_LOCALVERSION?

>> However, instead of grepping for it
>> (as it is done for CONFIG_LOCALVERSION_AUTO=y), it relies on LOCALVERSION
>> set in the shell which is not.
>>
>> Export LOCALVERSION so scripts/setlocalversion could see it and not add
>> unwanted "+" at the end of the kernelrelease.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> 
> 
> So, scripts/setlocalversion will always see
> defined LOCALVERSION.
> 
> With your patch, LOCALVERSION would be set to an empty value,
> which would make the following condition always false.
> 
> elif [ "${LOCALVERSION+set}" != "set" ]; then
> 
> 
> Your patch is equivalent to deleting
> line 175-183 of scripts/setlocalversion.
> 
> Of course, that is wrong and unacceptable.

Ok. What is the right way of getting rid of the "+"? Thanks,


> 
> 
> 
> 
> 
> 
> 
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 57698d048e2c..fc45bed69790 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -368,7 +368,7 @@ include $(srctree)/scripts/Kbuild.include
>>   # Read KERNELRELEASE from include/config/kernel.release (if it exists)
>>   KERNELRELEASE = $(call read-file, include/config/kernel.release)
>>   KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>> -export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>> +export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION LOCALVERSION
>>
>>   include $(srctree)/scripts/subarch.include
>>
>> --
>> 2.41.0
>>
> 
> 


