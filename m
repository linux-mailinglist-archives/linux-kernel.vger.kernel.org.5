Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294677BFF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJJOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjJJOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:50:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C6E4;
        Tue, 10 Oct 2023 07:50:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEle36011544;
        Tue, 10 Oct 2023 14:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YWYHpCB1qTPwyCqD458TVuPmGFNMKhGlk1/bKdnd5CA=;
 b=mQ6YUbyqLprpZrmRY4CpVKbTXX3xsFEgS2JYvC5osiwJwJPoNUaNCikUGnsnbBJ2s37/
 x7t+jOf0sL6kFP7CIajk8CWHZ1Tn+7uhCIN8Gu7PymFkTHrocMYIHDyLBzrYxI4c644N
 40/19OAUSis6YFEg31HG6ffHJ/+/gJXS+lgCRipj0yvF/Ud2v5cxoZMD8zlsAd/GOyOH
 6mPKIvF7JYl8C/DK1NmiTvTVNfN7c9IBWq0a51ZgZtRt8IYtQBiDqgLvpaz1AZYM8abP
 hf540TIRhfa6cAzMa1s11buMvC+JRJBjzK/PIj5AXLKRqMFMxL7vhpdK66+cuGdJ1d89 Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdncd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:49:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEOApN016331;
        Tue, 10 Oct 2023 14:49:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws6ydbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:49:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUzsmqdjHYNZRWG8qxv5sa+WAwZ7gPzgA2zZnk7ieJqE1dO0ICUyzgx7PPM7VIAYneOZ0WEEtHWokLpLNFU+m3qBVO67bFWQFtr+4HeCqhdDvp+1GvGfug5NCeiv1psTLX371P+szgUm85myqBxYLh9TZtNB3vNW8KZ5O5nHo14JbwFFSLXsU4MeDw+nUGuzMHfdW3j14l94zA8oX1QAtvMX5bTtaHFc/gjAdvlD6f7IeNMQDQX1cK8IU0w1R9yndgQZ3wDYxalyI+hv9FqD4m4i4pwNAZlG4Kx2oCb3y2YTXYtLcvPbKuNy7+h1C5CtwoKshPaQ/A8fApdegifHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWYHpCB1qTPwyCqD458TVuPmGFNMKhGlk1/bKdnd5CA=;
 b=ma6N8KY4J7j/Oi5ywYMkLbbgHtS+OJeTK7VGj+JiLLu3GcEIWMLt3Zsd2LHicgF0pDSMbdkykSNd5mfZ8wl/lOZjtyOsVCenrcugw118UXWtTxF953TMh3rPAy25BSUOyGgKXFnHVexmTrm711qCbhnbhJYuwY5lU9G5L7uszTsVM36Nt30zH0ETpIONLQqOk2Qom9bg0eDoZxU5oP1WRCF/7y9ML61yerj4QpciDygZ7ViCDv2RgUL+EIIcRKh5gyiKANVShU+lkFBAIl4uTedoE9BIPD9TLE+C1EfHfq8KZ4QF+wpOrN4y5HWcQr8xdTbiyN+vQCDkUWO0xi+cfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWYHpCB1qTPwyCqD458TVuPmGFNMKhGlk1/bKdnd5CA=;
 b=Gr+Lmax5/4ZSAW1VGFfFqo1UGAkVloWCcHV7W7NH+wjgjOpKIrBd7ObMauygxqfWQmHuHYA5doyuoW9CtPyAe+fMJ7okJr8T9atuNJsKyUSriFl0DUs9zsK8CM4LIQKvvLqjc7MNhi1qiRt1E7e/qKHMwsmk+bcY5AF9QpU+76o=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:49:29 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%4]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 14:49:29 +0000
Message-ID: <f5a5d92c-ae9d-c9a7-8278-7f91bb91250a@oracle.com>
Date:   Tue, 10 Oct 2023 20:19:15 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4.14 00/55] 4.14.327-rc1 review
Content-Language: en-US
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
References: <20231009130107.717692466@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0c700f-adff-4f02-19d7-08dbc9a01b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLe95gaI6D/PZwp6y+PFWN6U6hPinP5s5e3lOXDy5v391k0nrkX1kuVTGPfHxaLPqlrHIBPvJboya4MOMJIJMUfdOSlD0RxZzUpraoNLFb7mEWeQfMuYL5uk8iFq7R+ye5ZhMYrAa7EXZ2ikDOSBcJjLo4GwHISjU8e3e3sTNn3nxWAvNicHojNKGMaoLt74oQcXAslLdbsCN88CRAvezECB3qVBjL/kst1yrCMpHbCNs38FxEij2u5unGOucyc1DWenovhn2qffKde8EfWQl+rEhx0URy01JgQwHthExy78pbuvsXO5ergrm/21+sOfX8PIyEN/tVk+uEJJr+b7IRekwettHPpLzOkSc1nntoHGA2BCWb8zGQNFLWBJPaUkhnf8JNK8t970JQANPIMuKOlwgEdCeFLpsJzM4nqUGkHv7m53LD6mSnFD2TRXieZIkHEs6IpAfcISVJkELiBmVeRhKCFM5vpXdxh+mvtL1Ofu+gQMWDdKTsVlcKakoey6Z8Jrh9UAlMnymVRw5KJu7a4zB3MYsxz5w1AoAHeIgj3vDoVOqJh4l24IlI9p/st9FoDsgwlxaCz/KJIROsu2umInipamCNmAbVye9+a/1QzKv7Y3jnjvCn7Y42H6Y39g/5uG/wH8VHPBTG09VT6x+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(31696002)(38100700002)(36756003)(31686004)(6486002)(478600001)(966005)(4744005)(8936002)(6512007)(6666004)(5660300002)(2906002)(8676002)(53546011)(4326008)(41300700001)(6506007)(107886003)(2616005)(66476007)(66556008)(66946007)(316002)(7416002)(54906003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3gzK0dQNDRkMlJBanQ2Qldhd1lXZDhvOExHeUFuRGFCcXg0YzkyVmU3MGFs?=
 =?utf-8?B?SCtya3d5M2JwTGF6di9iMGZEMzVpOEE2RUVJaWp5RWVuSVRzNE8zNUJTWWtB?=
 =?utf-8?B?SWp1ZXpBSnJVSEpSSDRsd3g2SDBlODk0TGpQamxuelEzUGxHeS9SZ2ExcGJG?=
 =?utf-8?B?U3pHS2JlOFFZNTVwYjlSVFQ3QUhlSHFneW9mZXFRR2crR3B2bDFLT0ZobXFW?=
 =?utf-8?B?RTBiaDArbVJ0QTkvWlNCVGtxdElkVklOQTU4K0drdHpINS94eWhhZUlNb0g3?=
 =?utf-8?B?bytoZzJ0ZG9aODlQYmU4MC8vaE9Md3prazR0VVVkLzNpRmpoMkJ3dWZHYjdK?=
 =?utf-8?B?dGx0NGZDUXBPdy9GaFIrODdaYXJ2WnMvNzZaaWVKMFZDRmdCUVhhYm5nL1RP?=
 =?utf-8?B?aDF0N1VHYUhwM25ncERxZzNPcFZZNGx0RGxXRDR3Q2cxU3UzYm85S0E1SWxy?=
 =?utf-8?B?N3VnU0ZrN2RmOWJsY2FTN3A2cDRxOVRPY3crY3lSZCtGMWJiNlliMkg0d3Jm?=
 =?utf-8?B?M28wUVpqSGZaWE5VR2gyRk5lMEdUcS9pNjRzeWR4TDAzUUtDdXo2ODBSUThq?=
 =?utf-8?B?NW1tN0ZTUHNzOHR6Z3RnY29LTDA2a05SRHNnK04rNnlxN29rVkVvek1mdHlG?=
 =?utf-8?B?Y2xCL21DQVVSY0paUHY5bGVTaWYySHh4MXJnUGFUTlV3VGlITW5UNlRBNzhG?=
 =?utf-8?B?RUFHM0l6N1cvVTJwRUhMVHAwajlUUjlXZDI3VUJ6Lys5QytQUXlsT216QVhC?=
 =?utf-8?B?dmw3N3BtamI1RlJ5NDlkdkRTbHBQelRUOVA5RGVQUWtBNC9EQ3daQkRyMjNL?=
 =?utf-8?B?bjI5ZThVQm5vRnIwOXRRbXVtWmxCZ0hQbGNiVHdIQk9YY1R3YkxUQk5wZ1Bw?=
 =?utf-8?B?OUc0RjBuc3dnNkRtV2NibXdpRHlhdkdWRDNLYWluTmdQSmkwb2cwd1ZyejFh?=
 =?utf-8?B?MHFNRkZCTGswSHFZMmFyTG5vUDAzWkFyZUVGa3NvYUVaK0h6VUZHWE9XSlg4?=
 =?utf-8?B?MFpaL2I0Rm9tcWZxRjF3OGZQdnI3RHFkWTV3OElvWCtrSnJPWUZTdURyNi9u?=
 =?utf-8?B?djRnY2JiZXg4MGNBSzMyVzFHOVc1Z29kMFhUcEprak5uUlp1cDl2YUxWS1hM?=
 =?utf-8?B?Nm0rb29zeGtKeFpZWjErYlBIVDc3aG51WDIvNWxRWFRaNUZCZWk2UU9rUlVv?=
 =?utf-8?B?M0lMNXJxVDhYQ0kwZmFkM291bTVRejJUdktxVEZJU0ZPU1ByVUFQYTJmUTRI?=
 =?utf-8?B?Ti9sWGtFVG1BT29UMW9jSGdUbkVGUVJSSzdaTDZRZDVaRE8xamZhcktmS3pw?=
 =?utf-8?B?eC9TTzN3MEQ1QWlLeHNLbTc1UlFrN25RNHNFeXUzc3U4NFlaZlQvektCazZR?=
 =?utf-8?B?RUlxNXF2WjNqNXUvWjI2ZGk5dHpDQ2NDNTlOQ0VzRzRncVZ2OTloc0swRytB?=
 =?utf-8?B?SjJRZjlKL29ISjNJZGFFSlBNOXhJZXl5YWlEU1Y0SUFyT000RDRPT2dFdGxs?=
 =?utf-8?B?NHYzeGVieG5VejZRQ2Q4eXBHUTNjZ0pZaFdaSWFsbGwvZDkwV3hYdVQ4UHor?=
 =?utf-8?B?aVdKM2ZUeWFxcE9DRWxsT1ora2IzYXdvU3U2bUxWcmlzckJwemdvNkZnZlBj?=
 =?utf-8?B?NHJGT1Nxc1ZxWmhSdVBQQzduZlNyclMxV01aMWNQaVh3c2c2SGtURndQT2VJ?=
 =?utf-8?B?cUJSSlIyK2RMVnRHOHNpbFZ0eGdvN2Y4NHhudzVWbGhSTy96SGxxdmNKYnYx?=
 =?utf-8?B?ZC95N243VVR3Y0hEeGcyYU9iUTRFNHhvdG1LVmFKOVVlMDkwTVBGVjJ0SXNR?=
 =?utf-8?B?NnlrUG14eDljNDdWQXdrZ2c1ZmlER3ZlUEJpZDNyQXh1OUIzTDVqVXZkVitr?=
 =?utf-8?B?WFNsdDZPY3A4OXpDMGNrVm56dnN5cmdBdWg5ZFRWOXByM2JUYndmcFRMcG00?=
 =?utf-8?B?SU9hU3Joa2ZpWUpiSERVRkhONEJlWktiR2MycU4wcmZmMWlpNHNnSkVRcGpy?=
 =?utf-8?B?MEQySXgxbFhXbVpFeU5mTTI1aklLTTc1VDRJSEZsRStZMzhCd3lWRzZFTGFU?=
 =?utf-8?B?VkNnVStoYnp6ZnhwV1JTOGxLa2VDRi83NHd6eEhqamVnVXNlRE1Lb1hUY1Mw?=
 =?utf-8?B?c283U0RJYzZVekx5RWUvbWNyRnVFK2oyWGdXYm1XSzU4aE5VaC91cmpzKzk0?=
 =?utf-8?Q?PvbOMvC9RSCygubwtNtaFHU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFgzSWEva0N0R0ZmRG9lZzdMNEg0blU2cnM5S3JpYnV1NHNld0loQnBBK0lS?=
 =?utf-8?B?US9kc2RmazFGVzhxaHo1elhZT0dtSWdmNGNMVGxOQ1psd3d1M0FOSDJWTWNK?=
 =?utf-8?B?R3pNNkhWVkh1MmJMbElUNFVGRkpZdDFhQzh5eU1YY0FCZ2RIdUxKNEdlUjVl?=
 =?utf-8?B?SVhxck1xaklqemFPNHltdWVya05GQW1qVmloS1hJTmYzWmw3SkpNZUozWVRS?=
 =?utf-8?B?RUNNZEkyYk5qUndhVHUvQjdnVU1wTU1obGVNM1BTY2NOcDFTZ2FVOUtRWGRm?=
 =?utf-8?B?eldJUVAwUlc0eFpHRi9ZTXZPSDk3OWVjS3lqMXBpM1UzTGFzaytQQ1M5Z2ZY?=
 =?utf-8?B?ZkNlMEpLdlZzN1RJbDdOczRaSloyeXBhRnN2Vkx3cGpVQlpSK1E0L1AvUHd2?=
 =?utf-8?B?QlBETDBFbjNNbUw2WnBjNHFySlZvenJtY1dtcVVGM0ZYQmZQQU9RMEdJZExj?=
 =?utf-8?B?dWV5ZGRVU25veFk0bm5acVArWWZpUHBPRVVPdjRWUDRLaDlFSS9vZGRjV0ZQ?=
 =?utf-8?B?SFBnSmg4NlRvejRCS2FIMGFnejNDSkZuVkdyYjI1eEpKVmVPb3hxSkhUQWVh?=
 =?utf-8?B?dHhTUVZKL042cHZYRWNmWDBEbXB5TkFSWUoxWGdQYVlLci84UHJPRk5LZitk?=
 =?utf-8?B?TldYamlZeGM0WDNBTGs3aEltWWNiaDVkQ1JIazdYZy92Qi8wVjNEQlNxaHZW?=
 =?utf-8?B?V28xQkZEWVpKMU1xeUkrMkpCaFJhVlRMK2prNkRqQSsxMll4Zm9leWJxWlNT?=
 =?utf-8?B?eUo4aElPbWJnaDljQ3lyWXBjbWhMTGRhTGJ0WHVzUUMzeW5qMmpURHJFd0hM?=
 =?utf-8?B?WEJLeTdiU3RRZ25zRnh3NHNhd2Zjd09uT0RQdkdZdUwvcXVXRHZEdWFTd2cr?=
 =?utf-8?B?UjJIL1djY0dpZmhMZG85TTlRMXdQOFVTY3QxUyt5dEltM3VRSnVQRVFxTUxp?=
 =?utf-8?B?K0RXL2hLT3hCcHRVNHJlc1NFeklndjF0Nm9qL3QxZGo3c2x0MTY5cDR4NXp4?=
 =?utf-8?B?aldla0FtSm5DVEp1aUNuM2g0V2I4WGRsUXplVlhFaFZaRklmMld0aU9hZnR6?=
 =?utf-8?B?TStGbCszTWxsanZMWElLdjhYYkhFTXIvQnVPTnBPcEcwdUNtZ3BTSWwvcTZa?=
 =?utf-8?B?RUdiQU9MV0FxY1RBa1pNOTlzYm8xWHZVOXFSNXpQT2lyTFh3dDl0WS95L291?=
 =?utf-8?B?L2hLU1pvbnV2K1pCSElhQVhPdFo2WERUU3poSVZ0V0d1ZnplWG5paUZrU2NB?=
 =?utf-8?B?NFZ1TGY2UWRqalh2bEJ5R0FjSHhrOUZSdHJSVGpLZzJ6cHJBUlhHWVIvc1VV?=
 =?utf-8?B?NENPRjJ5SHREN3VFcmdmbjVMdW1qQnk4K3FpSHRTUjI4R1IyTDlSa09ZblJG?=
 =?utf-8?B?dDZLSzliOUtuNjRqM2tGM1dNOFRWbnAxSVlNdXcrMDBITGdKYzgxK0V4TlNQ?=
 =?utf-8?B?ZTE2aGd6SEluWm9SWERuL001K2xzUEt3cEFJdnRXbFIxNk1wbGpWZkZLSXFT?=
 =?utf-8?B?UDZHYWdiMURrMXhxYzdCdjkyelBxQjNiOHRtZzdncXYwMHpUUUFBMUYrZXlW?=
 =?utf-8?Q?2/g+wZSzTJSKJwijsZKuA6DdShzTQ4D047LdSnDfuBKAJY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0c700f-adff-4f02-19d7-08dbc9a01b51
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:49:29.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmMISfhjZ7c/3evWgX+XRzz4/2/tCnwr0qm6LSdpb7BLqGT8Lf2QxUd81FBWx/pVw99inq6M/JpWDwXtCS3+nkMrCCwpjLBYvfkoPkKz5stTyC68o2dmCiyN6QVJZkXL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=978 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100108
X-Proofpoint-ORIG-GUID: 0eQ2TgRlXcbsahRGG4SBOoQWlu4gTCg-
X-Proofpoint-GUID: 0eQ2TgRlXcbsahRGG4SBOoQWlu4gTCg-
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/10/23 6:35 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.327 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.327-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 

No problems seen on aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 
> -
