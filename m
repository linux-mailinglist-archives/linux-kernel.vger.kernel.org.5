Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB017EDE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbjKPKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjKPKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:35:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD928D1;
        Thu, 16 Nov 2023 02:35:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9J2Oi025506;
        Thu, 16 Nov 2023 10:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ysRD3xYVpKU6MiHIfoT5CJQS1O30ORDpRLkFTDcqy6k=;
 b=lFsTMZ8MD5XkHXhHANRDrHpMmYMBEDQuOR8gG3FjjAU95kzqZBpg51C97bloU4wLrBVJ
 DbuADbtVp/5jheNWkFDLFJvayVR3CdSEf+atIfBKjnsq43oCJBUyjtbBVkuiiVxL589J
 1o18GaHrvAjyVpJDmyaEeUVqTWEL8ol6QRDfbGihR4lbGy2GSzaLbuUezJDYaRGcVHZD
 Ww9RZOasfoXkwPoN1uOZYmLuphPGrEfNH2lk6NOUM3mtnhTnwcanosoeBSi7XOn9hwNI
 c4fOUv1NwvcGRSrjB5PEmkEYc+MeaGzl4axPIjhpFTATb/MVQzx5Ih5AKOXzIca3EKS9 gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na2rjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 10:34:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9bapr035371;
        Thu, 16 Nov 2023 10:34:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq2mf0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 10:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQOjMvXQAAoVzEIJHaASjjgipbWv7he/aSdvQl/tVLfOTS4YFi0iQTmcV1MEAfItj7rR+tpAq+/aO0ZXra6sAAlgXg+V8mkqGiQeLfTBdpq0dzXIKpME003BB4bK/35t/m3jlAqnelr3Oao+dAgZfG/t/LZCTO69UkG5dvJp0EIrOf0VUdd5GcCEYPI7Y4etdVzduFd+jAWmKWgvv/jfVwEhwi4W37E2qco1vFS0gqBiiuUU25+vphHqhwYiNk78EzuaHEDOjXvJ7XOX8Wn75Mwsr+tPFjKVIv+F/H1bL+gG72yR1+5ADKy1hfayuwi9t5dZfhMze2mmY9fd0kiDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysRD3xYVpKU6MiHIfoT5CJQS1O30ORDpRLkFTDcqy6k=;
 b=mN+ULOxKz5NLdh5+zUyLEjNpZRN6lPjbXEZHBznZ8nQOMetVGOACSZYLLvPVXRm2MkqGyo/C+Cufcv4KegtCEx3T2FZ32uGLE3jAeUBwDTxNd1IXulYP04t7/SL5DQNMN/tSvbd021gFzhcHzWohOmodFKXia4pBrylQ5C/y0Ds37MMNJ93mZKX9B+S+fEQkmQNN/uV9yOPE8twRGhT+1MdTG5layv7iMoS1roglCk9UhibP2Ro5S05a96cbBtJJvsw4H0PPG7ykeu9yzxVb0KhKROIJzLv4lYnixyWvU3pt75RIspbs+DbPqtD2XtPnnHuTbM8/Z2/7/5rp2C/kAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysRD3xYVpKU6MiHIfoT5CJQS1O30ORDpRLkFTDcqy6k=;
 b=xAqMPHeCaHHbrLt4PXPsptKhks8oHTfc/j+tc+D99EAyXucVl/mC+WUHcWF22wG9yAIOlEYAvFXwU0Yr7gRq0W7iVK3i7QTz1M7gWuD92zLD+Lq69rDRGGkZ4XdycB2x8S0P6H/cTgKcmxw16uz5zwNpgve/LjCdKjzf1T9di58=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB7523.namprd10.prod.outlook.com (2603:10b6:8:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 10:34:23 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 10:34:23 +0000
Message-ID: <77fb5f38-d4d4-4334-aee9-e5af585728f0@oracle.com>
Date:   Thu, 16 Nov 2023 16:04:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231115203548.387164783@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d392f2-4e58-4722-b7d9-08dbe68f98f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znxsI8EUy9owoc8taKipsI+WHZyI9cYhRcnnx/BRwULvTnwfoiqS7HTjzYT+M6UHhkK6Om6pYmRUSjgf2sFl+GirPGj92Lg0Q5L9ODjY3SL4fum8wTIEZ7R9w59Sb5ZzfC8/2Uqg1IyfOkCkM+pqvq290auGOOEz7WCeyhpVdVEH6ptYhuxJe0Pr4m5tw2+MtUDdrMQy7z3DlTp//JrjyskcYQ3k0ACWNhEv4iGme4BOlhVc9vwEpLvzIeu8ZK9p75QknIpOhuPLIwi6znskmUJMC8zMReTIk1xFKmi5DZMgNHCVJuBRlmE8xmED0LcA6vFL6bgIMFVE/LNpNEMkKGiyP1U+DPBkQjdI5RnJOlzkXosjLQR6o1Nj/EpO17uw3o0zkwTJch7ENfMu1LrLKuRZi/v82flpPSwH/L05jO/UjBolS7MZT8NZAoQPKXqlm0xySza3ZmAUGTlc5tcgZRDLa4FY2wQrCk1SX4o3BnaN88gtaSVZ4qf+/eHYAXot/Py4+mkdGXPCaL1NXORO6xpHY5rCzJBIEPeu9YFRkWuH6Y7Krk7kc38HgdPxb1WoJHPv3tPKiQx3eZVWnFMyTKjswbbbOvra9v2ho0lbIWp7J+Aj5G5az6sM0b3szRZpOXTxJqEVJrw2ZrgRlGHz8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(8676002)(66556008)(4326008)(54906003)(66476007)(66946007)(8936002)(6666004)(966005)(6486002)(36756003)(478600001)(41300700001)(86362001)(31696002)(5660300002)(7416002)(2906002)(38100700002)(107886003)(2616005)(26005)(53546011)(83380400001)(6512007)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21FZ3dMUEVPWlBRcVVkSGRuTEZ4cnRUalVVNmxPa2g2REN1V0hMY0M1SUdF?=
 =?utf-8?B?bHJGNDY0WUNoT1VWaW1yNFkxV21XVEZkdVdsTDc5YnMza0FFeEprN2Z2T3BP?=
 =?utf-8?B?S2NRdU40L1RRS2hFS2ZwOEowelp4MFNxajdVeTlYTWt6Uzd0VGVmMi9URit2?=
 =?utf-8?B?MWVxSU04NEdLbFlXNmMzQkNvQ3ZoVFlYWEJvWG8xOUJJQzltWDlMeFlhVHVT?=
 =?utf-8?B?aU9FcUxxSGZ2RHNUMlVWaXpBTzV6N1ZQdHR0Nk9nMHVaQkgwbjkvYnZENjAy?=
 =?utf-8?B?LzF0T2dJRElKN0gzaXQzRlRWS3c2SWV3N0YrYWZMUkZGVytORmsrTTB5YzNh?=
 =?utf-8?B?bWd4bFlqSzBNdk0wVlVxbXl5bTB2b2hIczYvcVVpVUR4VG9CKzIwNndaN1F5?=
 =?utf-8?B?U050YWhEMzlVNmcrV0lna05EWklFczlhUTNRVktVVXVuNTFpZ3NtNTdIQWhV?=
 =?utf-8?B?RjBsR1piUE5pZHNoUk5hWXJCVWE3c2pEQ2cyOGNmcHJ1UWREVnpmWjgxZGJB?=
 =?utf-8?B?bFBHQ3ZmaVRJbXZtU3YveTViSEhrNFNGV0ROMVZxdzZSQ0tzbVFIa2tYdTNh?=
 =?utf-8?B?VHVHeGUxNzhrWmttQ0s4dTJaSktpQmkrd01LN2NxRkFySms2eE01MDlLaEda?=
 =?utf-8?B?N0xNT3ZjRC80UU84Sm82Nk5jVGVJNi84TlVzck52VUFkdjV0eVZqemxHZ1Vq?=
 =?utf-8?B?Qmp5bDdBalhLNUU0dFJwcW43TVBxN0M0MjhUU3IzU1gzZnhXYkF5UTd5dUZi?=
 =?utf-8?B?VlFON2F1bVE4cjJPbDY1S0VlcUl6SkU2M0NzNFNXdUQyblo2TzhYTlZJb2hu?=
 =?utf-8?B?aThvK29LMWZtMDh2Sm5oZVlISFdMTVFWempxMWMzdVVra1RHT09pZlE4WThS?=
 =?utf-8?B?WU1SNFpveWRDc01kZFBXMXFmMjhUZGtnRHZXc2hrRk1hS01GN3p3aEFQV21I?=
 =?utf-8?B?TGI4OUFaSVZ0c0tKcU53aFBjVFlDWFVmZ05LUzdOWmFRY0ZXTlZCYk94OTZj?=
 =?utf-8?B?ZmJEUktsOWoza2xhVjIxNUplNnAyU1N1V3lDZWNxMkxmMzM4dk5RcDN5M1lJ?=
 =?utf-8?B?TnMwdkVtd2pRcnJPTjRadnptNmJBY25wNm50TS81bVpJU25sWFZHRnduTlFr?=
 =?utf-8?B?VEZUZ2FtUWExdW1yWGQyaS9Ebmlwa3NOSzg5ZTNtMEJCODV3aUNQLzJFRHBM?=
 =?utf-8?B?QjZ2S1pDR0dPZUpxcTcxbk9NRkVyNWRzQ21yVjRwY20wSER1ZXZRM0dqNERV?=
 =?utf-8?B?SE9qNWJSeGhtVnM0Skc2QTl3VFd5MnZvZ1RyeUtBYnNZWWlpZ1hCRzBCNHRJ?=
 =?utf-8?B?bmxsV3hlYkxPTDlyT2Urd2UwcTNRMzdkTXl2aW5LZEtVZFd2ZktkNE5wTjdv?=
 =?utf-8?B?dXpTekVFM2orVUQzcjFCT3lLajFPQ3F6S2tNeHBPQUVsSmZHeCt0U1ZWZUJv?=
 =?utf-8?B?MTlVSkdoZDhGRFdNT1Q2QXB2RzNOWEoweENmRFQzRzROQ25BWVVUSUZLRTkw?=
 =?utf-8?B?N2laOFRNaGQzb01lS0JhZ2UrZlE4M2JZUkJLNlNjMjlXckd0SHI1VlpoZC9y?=
 =?utf-8?B?L0VUQnNYU0NTWWpsbmErYVZMS3huWmMrdkdWTFRyOXR1U1JnYTlXZllUcHJX?=
 =?utf-8?B?N2kzSzdvNEtKL0thN2VnRHJ5Sm1iNUpxMkFBNjBjV0F1ZHo2RVlqZzFzMFdH?=
 =?utf-8?B?VDN0UjJ4bzU0YW1WU2hQMXZRcWRLaUxLUWZRUHdtVDd6eHkya1FTS3JxRjRU?=
 =?utf-8?B?UDRBbFRpc2FtRlJ1SmxqTkxZNVdSdy9HMThiVnkvUUJvK1E1em12cXE5NFli?=
 =?utf-8?B?ZW9iN3BVcFRHaFh4c2c4Uld5SUpPdUNQR1JVTUx5VDdSSnZkNENlakhEOXBH?=
 =?utf-8?B?L3k3UXo2OHpoQnIvT05acTUwTVp4cXB2RWZmR0t0UXhnQm9UWjZBaitMeUJh?=
 =?utf-8?B?R3pNT2QwenFsY3g2b0JITzdXRFN4bW1OMXhIaHZwSlJ0cVJsVVBxeDlnaTZq?=
 =?utf-8?B?U0tXN0N5a2NQMGFXN2dxUnllRmJXNlNFalFzbjNzV3FlUUxWYjhKenJoMEVw?=
 =?utf-8?B?MnIzaUZOUkJjQ0wySDVXbXc2TnQ3REZjWTRMZUZGR1RwVG9NT1lxaDk4WFpz?=
 =?utf-8?B?RWt0RjFzc2w1MmJhalh1aXQ0Y0JTTWRrUjdGaFVobVB1Ym1MYUhzK3p0UXlw?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cUVQaGdPT1UyVVF4WndGMnRIN1NwZlNEcisrQm5kQ0N5eS9oMlJlQzRRYjFt?=
 =?utf-8?B?ZEd0SlBoNnN1ZncwaUFYSXRpWUNkKzE3bEZLUWs5SkR1bTZva2d6WWsyejRM?=
 =?utf-8?B?REJiaGFjdDRNeXd3cmt4angxSFhObHZobGVIVXd6WlNtTkxaVG9aS1NyT1hS?=
 =?utf-8?B?WC81UVVCeHBTYVpTVURTUEJyRVVxWWlBcGo1dHhKM3Q3RlkwdmtVRXl6M2ln?=
 =?utf-8?B?ekZJT2poNTEweE1ZNWpWSVlTbG1xSFdrcFVJcjBNWC9yYXFRWEQ3bWU0USs2?=
 =?utf-8?B?V0c4TWNpTkpHRlFRNm1hNk85S1RRdUUyOFpBaHJpY0t6Tm1LYUdzYS95OEYv?=
 =?utf-8?B?Q3VhT0wxdUxMSVR2dDJxZVNiV3IwaDAvM0xVaDRVUFZOaE44WWRaVFlFVWNI?=
 =?utf-8?B?djhmMDBSU3NVdGhYd2Q2aWo0cExvQTNqZzlkM0QrZWcvclV1Z3hSWnkyZHow?=
 =?utf-8?B?emFqMWMxNXFDcWVmUEpscWt1MWNSbUtFbzBQa0xaTDBkWkZUc3RvU2RZeVNq?=
 =?utf-8?B?QXZvNjFRdnZud3V3d2xycXF6akF5U05Zb0NRaUY3NnZXcnVXZmpRZkN6aEo5?=
 =?utf-8?B?emgvRUxHMUJSb0tXNXJlR0NsdkJ1Unp5VXliSTlPTkgyUFlhYmlBemhmZHJo?=
 =?utf-8?B?QXgvNDc1Sy8yUTFNVFoveWNSQzB3Q2hDUWJMV0hQUTJ4NFZvQVJ6RUtwVjkw?=
 =?utf-8?B?WG1KQjJUL21tdGpkcmZRS3RHQjVRTzNMdmxUc2J2eElhNVJkR0s3RzJlSEg2?=
 =?utf-8?B?SEdRekkrWFlteWpUaGtyT0Jmc2x6YXpBd2U4ZlB6NnRpNzdIZkd4U2JFYXNp?=
 =?utf-8?B?L2wyVUpZc2RzWThtVjJZckk3WGpaS0ttNVVpTUM3QVFEWjhwbUVXTmVMT0hs?=
 =?utf-8?B?NnBLUkFuOG9TMW41YWlVc1B6Rk5USzRkVWx4Z0xtbjJaWSttUnROcjNKNHFy?=
 =?utf-8?B?V3crQkZObmU3d1F1ckdYRk12NXR1bndaMlByeE05NndFT3krUnFaenB1SVJP?=
 =?utf-8?B?RHhwd2syeHNrOW9FNVRCM0tNczg1WHBZVXRlbHRUd3B5bThWY1JKNWFjdlJT?=
 =?utf-8?B?TGV0NXZQc20xbUtSOHVwQjR2ekhNeUdsZ0RycWtoYmNQRC9Kek9iUVorYzJo?=
 =?utf-8?B?c3hCazlkRUU4NDQyd1paL0x1QnU1OGJ4SFZkanpiSXJZZzM0M09wR2MwZ1lY?=
 =?utf-8?B?djA3ZU9mbjV6dVpGZE5NeEZoNURER21yeEkzRDNtTHFoME5SOGlnQXo3MEU5?=
 =?utf-8?B?WTBjS2VJZFZ5dXM4NXI5NUUvVjd6WnlmR2RyY0g1V3lObm9jQXh0S1BxUEF6?=
 =?utf-8?B?WFhnZGV0T0ZwZXpnRmt5MUtRS2ZCQUU3TmRtWEJ2UFNob2RxZlhqajgzVTNN?=
 =?utf-8?B?STVUNmYzSWMyRFFHSGpKcG12eXcrOHdmNDYvNi9RNXA3RVJGSVdzM2xIbG01?=
 =?utf-8?B?STlIQVNXbDJxT0hBRjI3ZjhHYjlzNmV2TzlLbXJtT1JOeVd1cEdJOUJFSUcz?=
 =?utf-8?B?V1FqV3N4UE83c0FsRm0vTUt6c2R1KzBnNmRZZkx2U2pYMDZBQkhzY0JtcXFN?=
 =?utf-8?Q?UzVoOUtqWoPbxQAzKg9T4Nv7cI3k5yvg9yZlkOwduLleKS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d392f2-4e58-4722-b7d9-08dbe68f98f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:34:23.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVDwoca55T9POAVQ9Du7vfyMLsHBD504N6tPkUhUaV7tiIkMUO7fLLN1f5zKgA8GMzQVcAn51ni9V3QfXyzSNvv1eJvi3qyPm5sesVMiApAeWF0ICYddznfCHpJwTj+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160084
X-Proofpoint-GUID: xPoRFEUpCLa88KiIkUD8k7EdMbMIyAcP
X-Proofpoint-ORIG-GUID: xPoRFEUpCLa88KiIkUD8k7EdMbMIyAcP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16/11/23 2:03 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.139 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 

As Florian pointed:

I am also seeing build failure with perf, which is same as the previous 
cycle.

BUILDSTDERR: util/evlist.c: In function 'evlist__add_aux_dummy':
BUILDSTDERR: util/evlist.c:266:31: error: implicit declaration of 
function 'evlist__dummy_event'; did you mean 'evlist__add_sb_event'? 
[-Werror=implicit-function-declaration]
BUILDSTDERR:   266 |         struct evsel *evsel = 
evlist__dummy_event(evlist);
BUILDSTDERR:       |                               ^~~~~~~~~~~~~~~~~~~
BUILDSTDERR:       |                               evlist__add_sb_event
BUILDSTDERR: util/evlist.c:266:31: error: initialization of 'struct 
evsel *' from 'int' makes pointer from integer without a cast 
[-Werror=int-conversion]

I think we should drop:
3dcc2e4843277 perf evlist: Avoid frequency mode for the dummy event
4898cce349953 perf tools: Get rid of evlist__add_on_all_cpus()
a6157c9aa899a perf evlist: Add evlist__add_dummy_on_all_cpus()

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 
> ---
