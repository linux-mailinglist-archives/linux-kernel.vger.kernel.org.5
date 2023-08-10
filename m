Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D45777591
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHJKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjHJKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:16:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344E83;
        Thu, 10 Aug 2023 03:16:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A7aD0J024587;
        Thu, 10 Aug 2023 10:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DKINuWe8nhU3KuPaU7jCA9Bm3tnGlqEfB6zEijAuuLo=;
 b=s5pvyLwqVarC7qh3Jk9om7ktZV81rJ2ZZNgjI/3JijY649oDMQLybz2Ha5OCyjHfwcc/
 cljLf4CiumNHVTdL+JGvSFc6+mVl1flhIep/JFdijFPbFKh3HejoheA6XAT5lf/5nHlr
 c93K6ostzrEDc8Nb6ds8xR+0RUhxHJjGqi4GkQUdvJjQJMVbSsFIKZY6KqGEuZJnCn8S
 FFeZk4vIBcu9kZr9gxqDMCaHPyRvuXt508JcU8xZb/3zX4BSbgaorXcNQNA1UoDWyjXA
 DQpFRYRBCXyPU2qWIrL8o9pEf0U0eGGATiFMSTRK6J5AacoezXlMSswiLe4X17n1oFxr aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbcaueq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:15:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AA3v5t039716;
        Thu, 10 Aug 2023 10:15:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cver3v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zic/Qh5PW9jZOcSmUgoSgRC2G2APYOpjtT+ecRZNjh+0fqnv2FJqmyW5YzxVYv5Mv8iSsSJbM0At73roKdsRRAfZ3hatvlEp4m+sk/mYLt7xqxRsTSp5gSkJCe1jYcckd261EULPu8Xi5KLasmAUy4PkHuKYazBsX2GRr7E95FdcOo6apR++rl1+DWQa1IIy3CVZHJyDPpxi99HtljkYhAGdybBl//+Ftmidnn2QqrVuGevzKmM2k3Q1IDWxnB/tCdELh3q88n8VEWsWYuNkNOpL7Y8avevjzRSk2CmrhEzYw9jclka3Qz1zWrD1k5JmkED27SCtzs3lYUQgNoYzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKINuWe8nhU3KuPaU7jCA9Bm3tnGlqEfB6zEijAuuLo=;
 b=YncDXG/Q7ncRvb8PcC99b/hAPVn6/sB6ZP14zYKL/GqBiV6RYMIT2kskBiTfULbXZxG2J0DzF0fb9zHTP3BvzQbOXnCyDpa3/o0KHN/mTm9URhz/7wHrXnEfTVzmWNbN/NBnJ8fj/hLbMaEK+5oFIQFjvhZPnyEFLlNdi27XdG5ZvQx4afQ0OrIPGZTTL33xaGfOLLG48yc0x7EXz9kt76jC8spAfl9H9Gy4ltpgPqrZF1CI5aQekDWiIiuWlSuG2ZV5FEzlls2vbz/sBXE+zWVMAetfFIcRcvn/Kg7VQK8zGHMltMyBk++Mw1vp4oj7nxkETwoNQgGOqk8oekogjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKINuWe8nhU3KuPaU7jCA9Bm3tnGlqEfB6zEijAuuLo=;
 b=GpvAYwrwS+UcDYWyp+OUU4v9oDrDcluXU4mon2H8sAtSea1ULBrHlvrIOJT3A3as5Gw0HIWYoWbNqy6EGDe9kVxG58/63IzxWRwpDqQwojpR28AdpL6Ou1tQ3wqAufVfHbdsrYqXqchwiNP5Wfq40ebkumqh/NRnLEod1oE78Pc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:15:19 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:15:19 +0000
Message-ID: <c1ca3a3c-5657-48e8-9dc9-c92c9b084d6c@oracle.com>
Date:   Thu, 10 Aug 2023 15:45:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 000/154] 5.4.253-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230809103636.887175326@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d022913-b87e-4654-b94f-08db998ab32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lKZgd+IjJSXf54mqvwsecDdr8PDtyw7eTnp+Y0cPuFmspXGxhfqNKb+MyHJ5wEvc0vsZC0LRNwqgD21F3iHqTz4yWd67lkyYSLJ3Aj6ICJBfO87aNHna+KBUyhAePLqJtmahwTyIfxwRosVgBnWn99Haj8SAFvUZpxQef2yOEBwtgRZ7XELvW+xvHDH3mr3Ky47MoemPKQnXzfoZexWRBBo0omBERDmJpkK4VnLH9mwFljErxCRo0EgYO3O/5E1CD0nj7CS9OgdzZIpZ4sVbx/3hO4wOwuI4vbEdkn4Z325eDufZQG6df5bb2hjMtZXppDENrsEc9xr5DtnYfgZKPY6dMnDTpeo25EFesQWDjGflG86alHh9Ma/euV6uUx7H3H4zXXdyY13ihKhQtV0+E3j+qZ3mvDK0Hm1IzD6yAJ+Rj76dzkhrRdVR6p2+wqUjgt7X9a3FsP96UAQtPZh5FDwuXrv6nrAztCt/mHX3aBLhBTeclqPpuZc9lwMYTgro9dD6mHxtzbkNFocnJ4ynq+aKN5Wig+3xMCsSxorZnyZGeAfNDOga9UREDruj53NL0u3aCqI7Ywcb0I9qJ5dEFGN0W4nFDjZPzfd7mh52SBbmsSAbq7EFApYnhWyMJVPhlLKPcuCpbRneAZzH1wtVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(1800799006)(451199021)(478600001)(6512007)(31686004)(966005)(4326008)(66556008)(66946007)(66476007)(316002)(6486002)(6666004)(41300700001)(8676002)(8936002)(5660300002)(6506007)(26005)(53546011)(31696002)(86362001)(7416002)(36756003)(107886003)(4744005)(38100700002)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5ERlo4NTY2bUd4b2dkZ3Q5YUhUcVFweng3dTN4a1RqT1pxbDJMbkRvNzNR?=
 =?utf-8?B?VXlnanJKNUlrK3FORFVJV1YveEJWWlQxQlR0THZmZ0k0clVld0lMdjZsc2Ex?=
 =?utf-8?B?bklNQUliVElwSWdCUzVDNEFQZ2tKQjJVT2xWUFpiWlp5bndiWml3UWg3dGVu?=
 =?utf-8?B?UXQxdi9jdmZCUWdYN1hTbXJPU3RtS3BMeXJ6RjVoOGhScWMxOWVad2xKOUk4?=
 =?utf-8?B?OW4xUEdpblVwNDZmSkZOWEloQkEzSTI3YXMxR0YydG9MWUdKZTcyeFo2Tk1D?=
 =?utf-8?B?U0ZDVHFyUnBHaGpycTVaMTNQaXZRanNqVDRjYm50bFJqNGhjdXpnK2ZRR3Fs?=
 =?utf-8?B?alUvdlpDc3VDbFNZTzVmVk9RbENvbjZHU29TRG9FTkVaOWZSVnN3bUtDSFNK?=
 =?utf-8?B?bm92Um9QNDU5MEVWVkRsUGZRVDBNczFVL3d5MTlhbWNRdW1NT25JdVRaeFFl?=
 =?utf-8?B?RkpPemkzTFNoVXBYS3czdzQ0bU96Z0FJYzZZOWlLUXB3aVhIVUswZHdQaHNw?=
 =?utf-8?B?UGtnYU1nY1ZiZ0dURTZwMEZmMEp6OFVoYjdhYStjMURNaldXTm5ObWUzM3pC?=
 =?utf-8?B?c1ZUN0VVTmI5V0JPd0ExejdmTVFuTk52ektwRG40RFZycnJpK0pwUlh0M0dR?=
 =?utf-8?B?cHZLb1cveDFwenQ5SWhNb2x3WExyMFl4UFVMcjVnVm9XOXZKMkJUR0tERFFt?=
 =?utf-8?B?WitFanpyVFp1a2lwZmlGaUc1VE9YQ1JYQUxBeUQ3d0R1dGlLWVg2QlNNZmJ4?=
 =?utf-8?B?eG5zbHA5SzMwNUcydHV4OFdTQ1NLelY5L3VxL0RHSVJQQ21xNjZPcEI5bzNP?=
 =?utf-8?B?cVBaVDhEclNZeWlrZ294UFYxZ1VkczVIcEdFZlFJSGlFb2FXcGJaekxPOG5G?=
 =?utf-8?B?RXlsZXZoTlpTSi9xU0tNOWo2a210NldMbzQvdkc2S1RmaHgrNC91KzFEZGJS?=
 =?utf-8?B?cStzRk8wNGo4MDZOUGcvamQrcjBSTGlpbXpzbk9kSTJzUGF1MExXZUYrd1ZT?=
 =?utf-8?B?UWhvN1R3Z2VDajdJR0JNU010d2FOcmRQTE9hblE5bDExZm0rMGsxLytERXBK?=
 =?utf-8?B?dnE1Vk9uVld6clpqc3ZUMnV6V2UrMncxK1J5MTBmMVUyRDJkYXhUZzlPNEVI?=
 =?utf-8?B?V29rQ0tTZnJ0K2M4TFBCQ0VXK1VrelRldU9rUWFjdGtGUVAyenhMYVJNb1B0?=
 =?utf-8?B?c2Q2YzhGcmtDQzNmSGxGNmNGS2J5c1hjaUdUQWFOSE1zcjlwYXY3L3JDUXlX?=
 =?utf-8?B?aVlUcXMxRXVKZHN0dXBPbzFyQ3MyMDh6RTk5QkJTM29tVFFueFMwcDF6aEJo?=
 =?utf-8?B?THB2dGV2clNTdG1oejd4bTc5VHhENnRSZnpKOUlhU0ovWks0UWdDNkJSYm5t?=
 =?utf-8?B?VmppWVkxekFXWEZoMkcrc2VDMHpTaFBpSjJ5cTNSMHBMeEh2eEo1d3lmeGVF?=
 =?utf-8?B?Yzc2TTI0bTlCMW51dTRWYlM2UUQrTU5ZRzRSRWs5UHp6bWUzcUZQVU50bnEz?=
 =?utf-8?B?U3M1OWhlREhLTU0vdU85aGpEOW5KclRWTDF6QW5qRU0wWEFIUHpESVg1bGxo?=
 =?utf-8?B?WEFBamp4Ymp1S3UreG9aK0FDbHpRYVVYa2ZDNVMwa1hBQ1hGM2JwQlZqUXp2?=
 =?utf-8?B?TEc2YzZwM1g3WWpWbFVkRm5KYWRia1FFSEwwMTlyelRKZTN3UTRMUndQbG5X?=
 =?utf-8?B?ckJ4MHJjanhKM0cxeTJtT1lNSmZpYTBGRndWZFM4dm5PeXRaUkplVmVsNG14?=
 =?utf-8?B?b2kzajlWWVJCbzl0dWZQdkswSGZKczBSd0dXTWVGWWVhNXA1RE9QeklrVVpM?=
 =?utf-8?B?U2FYNU5yVTI5TUYrSEY0QithOUJ3MWRWUnZLRnJ2OHd5MytvdVFzN2gyb2th?=
 =?utf-8?B?aXVNUjZTWndaQjkyS25pT3U5U0dRaE4vMVhpbjFHM1FTU0hWM2pIRUZ2eE5N?=
 =?utf-8?B?b1Y2UnVtKzdtR1UvVkxaNW0vK2pMSklTVWRsTkh4Q1B3UFo4azdEZENrYUpO?=
 =?utf-8?B?TnAyVWgzUCtPV3pEZTZWQk4xbzVmWUZTV3phVkRaV0ZOcFFIV1NSbzVLNDhG?=
 =?utf-8?B?bUpseFBCa2dsdkFzTDFaRjh4R3BIcTN1L2FOZmlDZFFJR244YkhtVzhCclJS?=
 =?utf-8?B?VFU3Wkh6YjFDRkZhWkZWYkRpUEJtb0pLSHgvSE10YytaeVdDOE5TQmRHelpL?=
 =?utf-8?Q?pzTyZ5MV2G9Qgf4hzZ5a09Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bGNoRkNXL2JvcXBPYmVtaUFKeG1Hd0dFeDZUZFJCRUNHTFUxS1FOQ1ZmTkpR?=
 =?utf-8?B?OVlHZDh6b0RwUW9QSmFmY1IyWE1XZTJ5b3JBNUZlMExMeURFQkQ4NjJiQzVN?=
 =?utf-8?B?Rkpmc0c4L3NaWlRqZmxaQ2E0SDVJRllWR0pJcDU0ZUdDOWRjTmw5UE9wSm1u?=
 =?utf-8?B?aXJENERWM2JreFd6Z2lrNDhpM3NFZXlJem03WFRaWlFxWGNwRy9ycU5NY2Vr?=
 =?utf-8?B?STA5Z08vWXJ5N0VLaEFGU3hqeU1kc2p1aVI0OTA4cVNtS05PWFpuRVgraWFB?=
 =?utf-8?B?b0pOa05rNERycnl0dngwci81UnA5OEZBbEVkTENGZy9pQ0N0V3hrY3dPSUJv?=
 =?utf-8?B?TVowRFBPUnlyQ3dhZzFUcTdEUUJFWkZBRjY5Q2RKUVpBUkZxZlUxYVViTWpj?=
 =?utf-8?B?VHExNDZyMWlWc0FUWnQ4cFNGZEw3N3dpNWtPNFhKVVYyRStIeFh3SS9ZcWFl?=
 =?utf-8?B?SDVSeTFKQW92cFIvdU5maHp4VmZtOVkvMzNXQzdBSy9wbFZLdHAyQzVENmg2?=
 =?utf-8?B?SWdSY0swbEljd2FDb2dVK2tzMEtCYWt6RGRnRWlwTHhKejNyTTNKT0xEdXdT?=
 =?utf-8?B?RS9hVCtIeUJ6V0FhV1NMZFVuNkZtVlRiR2RiYUpYM05uRlZLMnYvRnBucFlS?=
 =?utf-8?B?YXhudmRCVmlpeDM5NnVxN0U2SU9pQ0JlSkZLUjYwdVp0UzZNTTAveGgwRUVM?=
 =?utf-8?B?UkxPdnRsRHRNclN2ZzFYOFhDVWxHNDRkWjh0VytYMmNqV1RpYU9Qb1ZFdzRZ?=
 =?utf-8?B?SytQVkx3cms2eEY3dEMwUXVWbXFoVFMrUzhwMHl1OE9iWVN2TTI3akJsbTFH?=
 =?utf-8?B?bzlJaHlOcG44OHJKODRTL25jdktTalFmNUdZcDNpMXNDMEFoM1RBR012ejZt?=
 =?utf-8?B?V3h5a0ZpWWRpQnFpOXBZWkRmYlF2TVZPNXFFZzExcENiM1U5TTB5Tk4rdzBJ?=
 =?utf-8?B?MFdlbENPU3FwUVN3aGEyV1RyeDJRQ0pzUEhFN0RVV0xVTy9JbVQzUkdXdFJW?=
 =?utf-8?B?dFRoY3J2Zm14aGdCNUNianR5MFFtM1RnQUVXYTVTZlU2eEdVTElEMWFSS2Z1?=
 =?utf-8?B?TEk3bEUzcS84Ym8yaHlqbXpYRTYrek1EblhYSFZySXRCbGZiYkx2Vm9QZlVq?=
 =?utf-8?B?K0tWdnhhMnl0aHd1Z2VNd0JQbFB6YXdlRnVzanZRSUNubmVtRDRCRlFqSTNa?=
 =?utf-8?B?NllIQnZGS0hCNEl4cHZMWS9aS1oxV2ltYU5DaWIrcDkzL04xQm5jUXhkZmFj?=
 =?utf-8?B?YzBBL0Z5ZEZlWDdsVS81YW5vclpIeEpsMEViSkE2RndBZmFyY0dqQmliSGpu?=
 =?utf-8?B?NzdlK1ZOTnpjVWhXVkxLMVhDOXA5Nk9RTmV3R0JJbVAyOTRydFlvdVJ4c045?=
 =?utf-8?B?T0VkcG16cjhhci94cWhpU2VLWG9xUENIRHc1bFE0bmw0UFlZOWNuejhvSjFZ?=
 =?utf-8?B?NU9FZmJVMlRsQTMzYUtjRW14WVZYSVZRUzd0cngrQW8wYk5aNEZmSWs1WTYv?=
 =?utf-8?B?Y0d0MDRpUEVOcDVHeXRvemkxTEFDMUxBUmhWY3AzRXdOUGdmUmFFNk9NRUdF?=
 =?utf-8?Q?5PP9UFyFTN3Ih5JACWjfFJnVw4P3upOGtGflmWCQor0njp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d022913-b87e-4654-b94f-08db998ab32f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:15:19.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EJGIeJN8IVtSE9CtVhMzjJ+8+bwuMeHjnwrE3k9h7GwSkgxcAuTXQWvQ0cDZOgC0O53EjmM2Hm1/uBfi1Ntf2rj364iUzJ8o9zpC+NsjSTryVbuF9PwWEb14BtvO0Hk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=975
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100086
X-Proofpoint-ORIG-GUID: iVP3wdzVkxzWPwCP1CNOUQ5WWDsNsgws
X-Proofpoint-GUID: iVP3wdzVkxzWPwCP1CNOUQ5WWDsNsgws
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,
On 09/08/23 4:10 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.253 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.253-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
