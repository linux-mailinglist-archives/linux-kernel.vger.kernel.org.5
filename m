Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C797CA9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjJPNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjJPNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:37:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97667194;
        Mon, 16 Oct 2023 06:37:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GCcxX4025332;
        Mon, 16 Oct 2023 13:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Xo+okGNkM8LWWi9eqcu00N079ZcLhbGr5TZHHhuPuWA=;
 b=bCrlWPyhyfQO7TqV6uZwaFJNu9Exd1c4kjZoNlY6LtXZ1PCUZm9AX9mflljM3rmzULbG
 uTDtwijJmijPP9qv08HowAoIo+lSdxNJ6rC8EnCzA29ebOSWN0ton+kY227GfGiV2KYG
 36xkjiowV0NM3teeDaFAaIv2k9Sbj69UwaqBnqQIK0LG61kcBsx9ESBNFjU851Z/GPqr
 IMsYuwASFp6l7T5mc4sLPYqYjzmw3Q32u+kzPeiI63IP07x8lTGI6Ji86FhqB5jm9UlH
 zdoLpR/W+ZttXFMSrY2EmZVfKeXSgnBtREHkDnl2BXzz/WlAn7jzgVgAyeNNTjwfKDsy Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu2qmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 13:36:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GBjtKJ021691;
        Mon, 16 Oct 2023 13:36:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg4ykt9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 13:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZEsvFZEEtNCkPeJi1LuD29+Z+Yns63aBsx1yDJAGCQdn7cNicblAJ17W+8wdAIbySkMMNHsP0lyQr8GkzVcG/Yi2vcvDTMF6UktJGiZi7lUqlhDQ3fnyTifsBP0NtZ53q1oKuxYKFYpMSg6W6/uONBFeR/ackbqSQD5DyW2wZgMJ6vFDW3CDPObUIs3rxRd+d5nXTKPrHl6yF01bFJ0cFnG/uaRKzlcfHm5etb5J7xHLEDb3JiZr592XCBBjvJDk6U8uzNO6FvkAAF7LAzB9N2TKBtJE4ndCnyQiUb4cXZzZEtace0k1Qex5zNQeUUZxIpCCYx6FmXCgwmQGivVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo+okGNkM8LWWi9eqcu00N079ZcLhbGr5TZHHhuPuWA=;
 b=ZWIukJPIwK/KySDoxOXy3AjHLTLOd4Uryf9poeGl62sHEb+UzVKvX2wHTJZ9VJPpcbQz5ylrebmt6jy8MT75Q1S8ZY64ZfQTuL4BGWXJGxdl6Zh4CFPTQLqD+3LjTeQ5Mdi9hO8A3dKZBeXLOXeIFOIp4B1P1KPZjE24nA6DUmBOp3NHLXyz78VFleegZk24JAsscw7ePdg6swT0zKAATVCDmmKJAMqKgsq5Cbo4hLEgTDC5/yRpRnJBhT6Bb2lYgz845JGC2wpPdByrT4Mgn7XaOua/hKORCpb5Gzlz6Khz7DGJJaO6eL2Yc5shmw1Nsw1cXXizuKmwqcZFTgWmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo+okGNkM8LWWi9eqcu00N079ZcLhbGr5TZHHhuPuWA=;
 b=zUqRQINWwTeUzsl2Y4DTNFIEhhzuqr1dXrgt1guX1EqEgnAf7vwsGxG+wy23H0Q2icpaATjbWimiz1hroNZ7My1ZhTrLFiIWNSNOIiAC+ntoX/3G8iTOrc+dDjoyeJLRtscaj06FIATdLINOgxtgmiUZEQYQL+E70cFebJsBxrg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 13:36:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 13:36:34 +0000
Message-ID: <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
Date:   Mon, 16 Oct 2023 19:06:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 378ec67e-4938-440f-cd24-08dbce4ce9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j99XN+Htn3RKr3xYREYvNV5hXOgKkTTGdgJudU2glzD9C4bzaeNibr8M0CuF6Lqfbus7wyOo9nZ5NjdLGD/0YTq97Xljt7VQ7zCI+PWpZG6Zi6CuisKzQmnoLw+qEucna4y8dBDLvueDYmL9XkaMZVbmGHgOZY4wT6v6o5rfD1HvaHnaI9c2eNYA+PB24zZAvRUbWgG5D+ZwnFezUEUZfWzU8PC7fJErN0iTmXkVkFCVGzSB9Vp9Q9RU6DvRdRKD1SA7gwGoigKSIMdA52QiMZe4AcMhdhD4QMNuhg+22nycBfj61fvm5/+8/06redc/uvbH22IXfb984AybNVo4QA5I2UmfF1SfRKvnaJ8rU1ID1cypIvTt3lpbTSrEjJvtDvK1mB14bKdd4OBsU88FpOB+Aza8LDJrJbgAp74rNlb+W6POHzMYYoJ8WDx4wLzUwi6VzLZ25TUeTvDWCyKRnepGXTCFaHYwMEKri0kmmiHAVy3nVGQf4WnGpub9EBWcYqWj20Mhdk/eiqBab/L0Eevyy3k1N3XJtPR6BqLxBgyAcYrpW7ORvqKHvaCWAzkWvGmCc9Cj7VZNVRjUR9/1cujDOlO2FxeczJJ16P/lx/nTs7QZUIacSP2Dkwa6KmWgBCfTStzb83L7luynL2e33Xf64iopiSaUYpxUpZTLJynX5IAKWhOuw3YLO05VIgao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(966005)(6506007)(83380400001)(53546011)(478600001)(6666004)(41300700001)(66946007)(66556008)(8676002)(8936002)(5660300002)(2906002)(4326008)(2616005)(110136005)(316002)(66476007)(26005)(38100700002)(31686004)(7416002)(6512007)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFphaThFR1lNK3NGd09pQTZNQXZlYm9uNFBORy9SZlEyU2ZKYmluZGN3NlFk?=
 =?utf-8?B?Y21Cb2IzY0NrMUZCMXNmRUFlOVkrcHZlSTRUcGsvRTl5dlpwTUk5bG5GOHl3?=
 =?utf-8?B?MkFWNGJKSTM5bFFwbnZ4d3E5Wk1KTkpJekJ2U01xWmlwTXNHN3lGNzFTa2Rj?=
 =?utf-8?B?WWxRRE95RWZRTjIrYzdQdFJJQTdqU05TalAvckxRYy9NMFBpcU9TdlhXYVpm?=
 =?utf-8?B?R2xTT1VPTkJMS0pCNHZ4WXAwWXBVN2RhNWVKcVdiRi92QjQ5eVh3UUEzcnNw?=
 =?utf-8?B?QzVFVU40Q2RhaWExdzdlbjNlQ2FSb2swWUZoNnM1RHNTNllXRzZKRE9OcVd5?=
 =?utf-8?B?b0hBbGZaVldvUWVxckNINU1RSDJkZjA0U2kyTXNpVE1vdFRMK0kzOUZvZXhF?=
 =?utf-8?B?SlJZMm9RNGFUR0duNHN5bW1oTEtyRzMzcnBEVlN5KzRMZTFzSW95RUxCb3VD?=
 =?utf-8?B?M2dCeFJGaGxTck9XNTVZR29ydFlsc3VmeHY5enE1ZTcxTi94K3pEb0U1M2xu?=
 =?utf-8?B?aVIxTVpYc0ZaSmR5Zlo3TmZkUmZ0b1VYeVo3cUxtTVVhdkVGVUt6VmhObGl1?=
 =?utf-8?B?c0tyNGhzRTdQbUJqbGZsQkx1ZE5yUjRRTWJTWTMwNEVlcVozMk82a2l5Vzls?=
 =?utf-8?B?OExyalRVVHlFdmgvUVZGaGtUMGw5bGdwelQrckVOYkRoWVhmcGVUNm16UGI0?=
 =?utf-8?B?RGVCS1NWbXRFOWNBNjYzVFZnZ1ZvS2pBRitxeHpSdjREK1ViWDNoOXQ4d0Iv?=
 =?utf-8?B?VkFaVmduMmdVNFdXbVQzQXJNMFFiWGhnVk8wdVUwNHBQRFRDQXBrUFFuNm5G?=
 =?utf-8?B?V2pJUkUrRkdwaUtLMC9VUmZQejVaYzZzK1Evc0JEQTZIblIxTTdKL2tETy8y?=
 =?utf-8?B?Z1ozUDV4MThtQWZLd1AvajdpWHYrczRGZ2gvaFNuVVlobHVkbzNIczJvNElR?=
 =?utf-8?B?SW4xQlZtSDd4RTk1OUdUb28yTGd2cmxSeFNVZGdHWDhZTDRtUUU2MUUwdjZp?=
 =?utf-8?B?QXNMVDZUWDgrYXJhSkhYSXltZEphVjdZTVZkREVPODQ5UjArUUFHWFpmN2Y1?=
 =?utf-8?B?RWtkaUVaS2taVndGYW1TZnU5Zlg3c0pzQ3VpNTNjMk53cEl2TEhxaWo2SElO?=
 =?utf-8?B?NlZNMGUxNUFqbVk4MHBtK000MXFHYXQyZFgrZDVMWjZaYnBsbGUxZXQ5NDJ3?=
 =?utf-8?B?WGUzbWtzalBzZEtWUjRDYmpjdnRta2dYMVJ4UzIvbnFScnM1YUdkSHRaUElB?=
 =?utf-8?B?MVBEU0c1eVlHbjJ0WWNvNENpYmVZb3hZNmFOUExudlpna0hYMSt1b2hVVnNy?=
 =?utf-8?B?NzRVNzdXTjZVeVltcXY1Z012RENWUTRYcm1GT1BEY0ZHTTVXZzVTLzdKa3RB?=
 =?utf-8?B?RnE1TzY5UFgyMWZEbHU2dTNYZk83YjI3TEJ2andGSmR0M2RTTHQyZlM0U1dZ?=
 =?utf-8?B?TGdaVW1LQXR0VFp3VmVITFVKRlA0SjZ0VVVvMEsySEQ2c0NzTXI4bnMzS0I2?=
 =?utf-8?B?czVOZlNiMlNxUExxNVBxUjkvVkFHazdSdFd3KzFTUGNNRVFuSUZuZ3JiREl4?=
 =?utf-8?B?Rm5FZFN0SDJSVy9ncTZBbUZnZXJ5VEYzTHVoQ1pOMmZjWlZGNkpNLzlCOXV0?=
 =?utf-8?B?aktYZnV2NzNUOXd5bzB1NHAyT2R4NS9mSmhnb2xTLzNmRFRQUkRkcnNmUmdB?=
 =?utf-8?B?S2NwL0ZOekYwd0JQc052citjMmRJRnNtczROc2Mzai85WW1qaUY5S2JuMzA2?=
 =?utf-8?B?RzZER0F3cmZ5dm9BOUdxcC9pTWQvZ2RXbFZMV0pCZGlFMnJyQmg2Tlh5cDg2?=
 =?utf-8?B?VkRjYVk2WWwwQ3RyNENqa3MzdUd3Vk1NRkpUREt1RzR4WXgrblAwZFJrZCtI?=
 =?utf-8?B?aDh3c2h2dDhpWEpCaWkvaVBlS1FWZnlBRHdIOGRLTFYzdGZJVnVSS0JyMUht?=
 =?utf-8?B?bjJoTkJMQXdIaGxLTmZ0SSs3ajRXYVY2aUhlUkhBMVdJL2hxR1g4aXA2V0VS?=
 =?utf-8?B?dSt4WC9vQkRKZHUvQnFWSWhBaDltbDA5RERaSGg2aVltNmJLNjlpWncyNkdY?=
 =?utf-8?B?ekVMdEFoMVEwYTBTK1BzVWNSWGNjQzA4ay8zejlYMWpkRWtYVEFKU0lsUnZj?=
 =?utf-8?B?UHVvandJb01HSVpoeFRWdUt4VkNqS25ETjRzcVc1eVF2ekVlL0ZCTEtFR3hW?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WEpleGlXNnVtUHcwdXBVVThUTXphUnpIcTFjR0xTWGR4SUkvN25TTWY2RnpY?=
 =?utf-8?B?eFRYK0Y0amtLQzRNbzkwN2JRc2pYdWhTWitobnFzQ1lGSDBrcHRNZ1dhZVU3?=
 =?utf-8?B?Q2ZQdnIydUd5cEFtaEI4QlppMmVteGp1cm5EVVRJSmNrdDN5OVFDUmN1SG56?=
 =?utf-8?B?aEhYS2dRT3hXNS92QjZpSURaMjZCN2xucHd5RDAxY3ZDSmw4S25heTEzblFR?=
 =?utf-8?B?aEhhK2lmb3ZuUm4rL3Ftd1hjWExjaGV6cDBlRnp4NWxuMC9YQWNBbGdKT2lv?=
 =?utf-8?B?VERFR2pVQ2NSdnQ2WVBBeGRPbDAySTVXSU8yMERVOE9Mc3JyVWE3aGdSN0tF?=
 =?utf-8?B?OURlOHpEUk1qdWFZU0JpUDFMRzU2OVF4bVFTSGxENnBFZVBUUnMyeDVGS0lN?=
 =?utf-8?B?Wkp6dHNnU0NaQUM5WEhxRlRIc0hXRklidTgzV1pIZTVGNjN6c3NpWTZWUFp6?=
 =?utf-8?B?SmZHVC9ZRW9ZOWI0ajFqM0dPYXVjVURkTmpDVTVjdUxjQ3FDYWpqNG1zUWth?=
 =?utf-8?B?ajliZmdOd3IzOGg5ZVh4Ym1KSDFRZWdML2xhWHVqZjREb2oxNG5ZM0tEbjJr?=
 =?utf-8?B?aDhWSzIvd1B5ZE8zbWVucEhGY202WWcwc2oveWhQMVBLZlp0Y0JVMS9iTktn?=
 =?utf-8?B?aUIrNVlKa2JhUE1vSWZ3bnhuSklDMGM4cXUwUTQwSlYyU1RPbFZSa2RlVEZr?=
 =?utf-8?B?YVNLUi9Ka3M4NmN0RVVEbGtTL3lxTzRwL3NnTXAzVHM4VE9xY1ltaExMSWU2?=
 =?utf-8?B?YkFpQ3ludlRGai9IOS8zZ05JbGRyT09EN09wQXBnM2FQcnpPUHZvb0U2M0pV?=
 =?utf-8?B?UGYwNVhtY3BWWldoT2k3eERzVnZPR0VjQUwxU2l4SHBZbjRVV1h3c3l4N2dr?=
 =?utf-8?B?UW1weG9uc0tLK0hCSWJJUDQydERLMno5eWZaenlDNzhTSlNWVXhjU3pBL1kr?=
 =?utf-8?B?SEhYSmUvM0EyZlI3TjZoeVBnaUhuYm0rc2thNldwRWNnYVFIYy9qZm9JMWw1?=
 =?utf-8?B?eFlrS1Nha1Q2OFZuS0pOaGFxZ082WUYwZDNuVXpqUEtqTjJ1OG5Db3RYVXgy?=
 =?utf-8?B?Mk91VFNYQnROWFoyVmE1NVpFby9YRWlWd3B0RTVzWjd1QlhaQktRWGxQVzIr?=
 =?utf-8?B?TU1yVHh0MkRma004TXFia0ZxWXRiS2NKWG1lYnFTdEI2R3BXNU0yRjV5ZVlE?=
 =?utf-8?B?S2ljR3Q2RUk1WmlYSkN4SDdNMW44V1I5TmxjYncrc0NFWThaRm1hN0laL1J3?=
 =?utf-8?B?d1BiZE5FRFhVUHJhNkRPQVRqV0RuRmlna09vSW5kNnRpd2VKQTVkeUFsakQ1?=
 =?utf-8?B?K0FwZVNlMWRIN0FmemFMRE5NRXBIa09GNlkwVStqTXgyb2o5eUtuSjAwU21u?=
 =?utf-8?B?akllbkJZY2tZWk04Q0poc09FYnMwdldhUkdGRUcwRm4yejI2U2hoV3RsTG9z?=
 =?utf-8?B?eU9yS1dmQmExRjB5VUtYOVd5QTdmbDQzYU4yTjZHdmVUYldyZ2FERU55L2c1?=
 =?utf-8?B?aUFlbXBWaGhYMmg2NHg3QjdMNkRXcGhjejBJZWVuSk5yczJRU2w5WlVIQlQr?=
 =?utf-8?Q?07BGGTUHV+6+oq57vZrRhM9Nw8mHmQSoI0S2x4B7u81B/r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ec67e-4938-440f-cd24-08dbce4ce9fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:36:34.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JPF0Cxyu71SnJBgqKrWp4DdomWJwSC2XgKr8DPz/sQtv8pL61KfF36SP5P0IDt5CV6XXfK8jHEDTn+NqiRR60tpD/L6oVVNB59RBg2OnHp4egeyzcwSQCucu5075JGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160118
X-Proofpoint-GUID: hJTIL8pmx0I9HqObr7BOdiC_MaVvtHtW
X-Proofpoint-ORIG-GUID: hJTIL8pmx0I9HqObr7BOdiC_MaVvtHtW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16/10/23 2:09 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 

I am seeing a build failure while compiling tools/perf/

In file included from tests/genelf.c:14:
tests/../util/genelf.h:5:10: fatal error: linux/math.h: No such file or 
directory
  5 | #include <linux/math.h>
  | ^~~~~~~~~~~~~~
compilation terminated.

Patch 43 in this series is causing this.

Why is this not reproducible upstream ?

Vegard bisected the commit which makes it not reproducible upstream and 
this commit is missing in 5.15.y:
Commit: d6e6a27d960f ("tools: Fix math.h breakage")

Backport request for this was made here:
https://lore.kernel.org/all/CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com/ 



Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:

> Adrian Hunter <adrian.hunter@intel.com>
>      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> 
