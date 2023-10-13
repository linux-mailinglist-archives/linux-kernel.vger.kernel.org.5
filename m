Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0A7C888C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjJMPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjJMPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:25:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01FBB;
        Fri, 13 Oct 2023 08:25:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0ZVv025151;
        Fri, 13 Oct 2023 15:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lZ4sPls0jluqWWv3sTh/togjhimMfA4PNHLSr3m/iTI=;
 b=TJXeELFYPrINrnzj9fisK3SMfdjyixJmm0yGlAYI7yjYE7rUtUKWBc/IGGPw1VBAwVGg
 olMtuLnX83KY+vUuPiMlLTFagkqD74hsQaw4zolUDOumYNWHGg16cserECvQGeBXZBRQ
 pqqF4Sd8h7Xu/aMrL7tVocugNjc+suSAXe6xlJpjLT/CztL6OrkxeYWt1vdt1ZI0Khui
 qXG3nIV6Jp2GtGbx4NECZFCbWtKkRbe+ggo12W0nZHp5i6Vc5wNTU5u9ACwZ+83oJKRb
 tM59ZYf2AUPpNrluZEqB0+Fig2mbDs6+rxNePjsZ0IjdSRdqXINnUw+JaPDyZG3nGdut 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh8a2hsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 15:24:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEoHHr039118;
        Fri, 13 Oct 2023 15:24:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0u1hhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 15:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epo3bMXqclgBook295Xs83SowQcNU12TKH8HgIMhlyEcGYl8DNYNfGTPMU+f1e2LZrMIfC6Od56xr3H7x/SW24fKFev8K2B6kwgifcqslOziuwhOl9wGmf1xf9tiFOJeNVXkQRR8sY3CKL5XjVFmlXnqneuVKZGdPpmKQrVV6jb6MtG+JfM0FgPpFvYeoXLWkMGFGGFR7QSy5H6fOnthe3Sf3idY3wWezglKi9ZnukS/YiUypo7uenXMQUfaBb1bLUM5CJ1ESbHgND3zwFhI9ejkeQC4zcvPV/hIYHlGTEP0j/LVr3UqwyJt6zu5TdPnEW2UedC1df/dF22UZARhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ4sPls0jluqWWv3sTh/togjhimMfA4PNHLSr3m/iTI=;
 b=jLJdzyvOPgA3BHIc8oeBUdv1zsyBn6hic+WHGNVrFs6sIzK4dw/7+KPGwqdbohQX0CyaixFitfsJ1xsdabi+xKCuH7eqpX7uooscprCIyxhLzpwBYm586tre+VrRm9T4f5vNIM2ZREoOZn5Kq7xuUFBxc2zbD5ruHb5byO8yEXwEHlNGBTiMVRJSB7ZxYwccwR3cvsKw9s6l9A9o0suKSIWxOLQDWpIHZCItqY6acAt4VSmIkFgIA+ZHYXpSqIQ9Qw/QI3xC/Lqn5S8jB/eiv/J0dzL5yXv2nlCMfeXuKHhivziIdPjc2nTI3SD+7HsTGPezmbk1LSmxp060gKL3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ4sPls0jluqWWv3sTh/togjhimMfA4PNHLSr3m/iTI=;
 b=QOs+BgPqbGV1IH6tBLUzIjzPrHs3L33nYWg/cklopHhOXWPafrCNuNlbuSFTLK7gMgB2/2Wn0rWsjzsmlIp0qPYMK0nwCHzeo4bFMHrfIpFXIqavZFmQCYnR40WbuDJjomDRWamaE3MyuOLH4/yditPE6xTYLLI6eMYMQJSvdkA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Fri, 13 Oct
 2023 15:24:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:24:37 +0000
Message-ID: <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
Date:   Fri, 13 Oct 2023 17:24:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, backports@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, Willy Tarreau <w@1wt.eu>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
 <87bkdfg2ds.fsf@meer.lwn.net> <877cnu5jy0.fsf@meer.lwn.net>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <877cnu5jy0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0276.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 401de64f-6ed4-4b37-e18c-08dbcc00830e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdrNhtqk377myFK8elJMSsoqlQHNYk4eRMuegeNIMAWsRJUyibRoAh7PX1b1Wk10y4fKU5DJSdM46/xW2TAV8M4RgIemmxjkj0r4eIqDKiBNCA5oxKQ3KX2qoRynIWcj1g+02IfCl/Ge7iFIf4AaS397ItJqkK4XJ1RuPpzB5RyMj9rvm7jBtOaXP79hnAxejXRyiHrv9tY+E46VRibVQ35D+uJxsI2MkTJVbnxRhkGOVA2j5llFYGR+rG0zx9E6mvHAjquGOhTIKeLg4U7q4gwwdhO+oGmRhekcQ9kMvw9zJBBNo+jd+YOejs/YylcdCr4Gad2dR3vWGjpKKuf0OJuTN5Ek5bMsX0xIgbp+zOQBC0JrAdrSw2JJ0SKPWMrS0iCfh59ECaHO8YZDc2QWh61Tyyce8IVRr5zDloMz6OHFKcHEpqgSpadfMDpxbSoJAcC7ORRzR+sGfLJ+4kK0L9EP+nC3ztCqlVtiHSmYOCmMhl1v+bDxnL9xI/9zrCZu+JYq2UHVg3E0KbMDbce+h9OZA8ipJ2I8D4h3fW1SwYpuNuGRHdeHBmSgDlTMTj5qm1fexLd0ZQaJmUvageFBCi+knfDD/xH6VE2KlBayEpobgY/HVfmFGudMnPtiUZpYHDrSVIhflR17is/6260XydzO3ufbu6RS3YhLBE2G5xIG0n2daMDW1D80uTeOJaYY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(966005)(53546011)(478600001)(6486002)(2616005)(26005)(316002)(83380400001)(2906002)(7416002)(54906003)(6916009)(8936002)(41300700001)(66476007)(5660300002)(66556008)(44832011)(4326008)(8676002)(66946007)(31696002)(36756003)(86362001)(38100700002)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VrM2wyeU81QTNDV09adWZUNVpsYnBvQm84WGJqMmw0ZHROT3NCempOczV1?=
 =?utf-8?B?WmxKcGFOc0RNckxVOHVveGhybllxZG5zMFJCSkcrMXFsQkQ3YmdZUUxIejBE?=
 =?utf-8?B?UUMzV3RNUlNqY1BZUDR4ZWJmeW0rVVQ3eEpPd1Yvc1EydDVtWFhDcElQc09m?=
 =?utf-8?B?U1pyTk1KdVVyOXJKSHY0Rlg3Y2Nwd2duMi93bkJZY3BOczA1SU5DYkRFU2hT?=
 =?utf-8?B?MTZxQys1ajVMVThyckZXUmoxR3lJVzVZanRnSEdlRXZpdkZndGROQXdOcnF0?=
 =?utf-8?B?T05NVWJWY1JmK1FhZHZYMTN4ejNHdkdEekhPRjlIb2Uwby9CMU9VYkRZYzI3?=
 =?utf-8?B?eXpMRjM2ZEJlL1RFRTlwQ0diVm1hQVVWSlJuMmM2dGxvb2puYnczNnlEOGR6?=
 =?utf-8?B?UXRiaUVzSFg2cFloc3o3bVJ4c2ZnVUJnVGhWMi9CRm5jUE1KczlmaDI2Q25n?=
 =?utf-8?B?ZElOVThVejlMdmg5ZWExYllkMDVUdWV6RTVjTng1bXljUkVUOEdQeDRHTWtF?=
 =?utf-8?B?b1hsTDlQdi85c1BPSkMyWWU1S0o2Q3d2T3NEQmQ5NG1OVE5LRlJCdEMyVnR1?=
 =?utf-8?B?dXpielFSdHRNNnlHWVZMZ2JQM2o3KzRkVmRHNmVsWk1mcEhGSVJpL25haGNX?=
 =?utf-8?B?MjRzQ2YzcFVDUlNtd01pWFZobDBvQUxvL3RySkltemNXemlvN3ZTbmtkVHNz?=
 =?utf-8?B?dFdqK0FtdWpKejFweXFOeTI3NEtFSXNuK1JqQ3Fsd01hMXpoYTNCYTlYQmt6?=
 =?utf-8?B?NzJjMFp6R2ptWDJEcmtyemVlR1I2T0dwQUl6Ujh4T2djTzRFaG44bE4yVnJk?=
 =?utf-8?B?UTk5TFhSeVlSYU52S0ZzLzlYUzY1cjdUL0Z3dWl0NXE2elc5YVlKRHFzc3ow?=
 =?utf-8?B?MnRBY2JZdWFDWFNicm9DZHV1VXlpaFcvY1htL2l6UldmNGczZUhaL21DeXE4?=
 =?utf-8?B?L1E5c2g5bXhQOWE4cmVnc1FWSzFOZGVHblhRTVRYKys3citFS29PRDNIMWFG?=
 =?utf-8?B?dDZOQkM1WDJ1RlVITXlCMDhNSGxXNEZxc1h2dVF6bEtoOUhYblFDQUVkVFg0?=
 =?utf-8?B?NHl0VTVybDBvdGpXQmhKSUhoR3RJKzQzN3g2aUo5Y3JRVnZSaE5NTnAvZXpp?=
 =?utf-8?B?c3ZUUW9xcnVIZGMyaE0yZTcrM0ZMOFFydEYzajVYUmtsVjZFazZZMnp5WXBl?=
 =?utf-8?B?OENqTDgwSURnWnFBU1VDNkhvMDRoZlZjcHpXVERQYUtPRUZ6cnRXSlppRzBL?=
 =?utf-8?B?a2k4bCsyWDVxSHB0c3BNRUtndGQ4RlJGbXZjbWcwbkZCNnM0MjFnY0srR1NY?=
 =?utf-8?B?V01zdW54ZDE1UkNPL2orNHNtU1VTOGhZbUFFT3RjSkJHU2RxYXEwVGNJNlZN?=
 =?utf-8?B?TnlMOWthOHNoTE8yQll2alZZd21lS1ZPaU54L1VGUHJHYjF3MDdhK2RQUXMx?=
 =?utf-8?B?Ly8yYTJBWG1KOEhLR3VNQ0o2Skt1RENubjBtT2hjWFhSekU3cm9EbDZPaGlS?=
 =?utf-8?B?dE1IRE1XdERSdXN6c01Zb2hEOTN6d21YakNGMkFGSGYyWkw5TEExb0lFRnRR?=
 =?utf-8?B?RTZobWFkcjc5eVUwZURiMEhkbjZlcnhYY1JQalI5YjZWN01uSUh3KzdRbjM4?=
 =?utf-8?B?U0ZtZy9FWWJJMjNBWGx4UkJGU21JMXFnYnplT3RwcFNHV0Jzck8venpiTTR0?=
 =?utf-8?B?ZEZZV1psbzhNdGlMRDlUT0R5OTRHQXNLOXJ4VTZNK0c2Q2ZQOFRMWDJJNTcz?=
 =?utf-8?B?bkh6NFZqT3hZUXZ3eVdaVjZVanBVRFRHVVJYYWtVSDFoRlQzTnhLMlZKWFhO?=
 =?utf-8?B?VzM3UVh5NE1BWGZJTkV2dm8rNUpNT3Y4Y3NMV0FtNTZzdENjNzlWM3pBSnB1?=
 =?utf-8?B?bVZ3SG1jT0NINDl4a0xaQ0xydDViUlY5QXV2b09GNXZ5NVZ1QmpuUERoY0FU?=
 =?utf-8?B?YjZqQnludnpxNXJjZFpZbXAzNEdtcCtiOWEvYmNCTWVCQW5ZMmtUNFQzbVNl?=
 =?utf-8?B?TXc5MndDMmt3RmRnNlJQSXQ0TmYzdEowQnJGTU5URkUzb29icFA2NHpBK2dU?=
 =?utf-8?B?UU9vTkhGZmhxWS92bG1VQ043ZGl6RmFNbnNBVnB6TUVHQU4yKzI4QWs4NHp1?=
 =?utf-8?Q?IWxAda94fWF1mQwFtpnt9TV+z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TlFEeFdDZHJvNC9kbGwwbGQyNFNKUHlCVU5BbHJ0VndsazluSzdyMmdicDZB?=
 =?utf-8?B?VWFUbFFjZDVhNTFpNlM2T0YvbGtjSk8yeldQTThBRWdFN2c4K0MzUjEyOGI4?=
 =?utf-8?B?bUxTZUcxaEw5YkI0cmMxK25laThsWmR6NGpDaEduTXZxbHp5NlNMMC91L3A1?=
 =?utf-8?B?V1B3dWcvREtlVkYrNWdnQ2hUOEp4NGNSN25lRmo2R2NoWXNpeFphQU5lMm5K?=
 =?utf-8?B?UEdJanNBM0IvSFdRd3NMMFVkdzB6c3lvSXBNbDZkRnBkLzdZZnlBc1RSWmli?=
 =?utf-8?B?YTBtR3UrMDBucWY1aXY0U3RhazNxRlUvdW85NUdLYzRJdWRoZ0xzRFZHUmli?=
 =?utf-8?B?UjFVaVd2NUZQMWRIM3pVcmdSd1hTNndnVGU3ZGFJbGE0UGVtZkRaeVFCUmln?=
 =?utf-8?B?dXloMFZ6dlR1b3hJcnJhNFlkajVDNWdLTVhZNGFGVXBaUlZPK1BvK3J1ZmlL?=
 =?utf-8?B?MFRmNVlJVHdiSzdQWXlSbkVVQS92aS9oNVJnbC9pWjV1MnorQ21aQ2N4OHVR?=
 =?utf-8?B?RTNjVEVHejVhWE5NWnM0RjcrUTRIbkplcGJJRHo0bnVpaGMwOXJMaUNuay92?=
 =?utf-8?B?Nm9MUUNIUk9CWmFVbWVuc3ArL1RGOFZLMGRveGFLVVVYN2JSbHk3djZYeEtq?=
 =?utf-8?B?RVdQTWVLSmxXd1RNU3N1YnBKT0pRbWw2Mm1JQSt3VUsvNGFmdXdqaVRaMFpk?=
 =?utf-8?B?eDg0dlNrZjVMT0p3ZUZ4NWhDL2M1VTRIUFI3dzNFTkhHcVVaanZMbkJaYzdp?=
 =?utf-8?B?ZXNodGQ2WjJXNnd5R1I2WCtTTERXZWlaWHEwbkJPdG1IMnFDZVpkeU1xVGRF?=
 =?utf-8?B?QVZPeE5sb3dLYzlnTFVBb1padnhMTHl2UE8wNmtTNGRLeXVyN0treUd6MzEx?=
 =?utf-8?B?RHBiS2VBOE9aYXNlY0FrODlXemVaelMxRlBrVFEwQ3I0MVdoa1lwc1Y5UzZx?=
 =?utf-8?B?QmtrS2crV1RFcUVCTnNjaEM3eWpaT3pzYzhoSFYyWDFWZHBwWjhhM0M3d3Z3?=
 =?utf-8?B?NWVvNUt1RGplcm9NYWUrc3oxUnJaSFBOSVJGb242N01WNmpnUmVNQjlyKzQy?=
 =?utf-8?B?cjNUZVRTc0c2NHg5Mkh2c3dvL08yc0pXZThVVmZJTUF5Mnd4cEpQcWQ4YVJt?=
 =?utf-8?B?UE5sODZtT0JxcWVkQTNtbmV2WmhTb3doV3hHa2cyY0dCYmYzTi9zbkVOT3pX?=
 =?utf-8?B?dlFwSDNGelFBUHI1S0xVS3luQTZ2cGdPQk5pUG5DV1hTUDNRWWZZR294WlFG?=
 =?utf-8?B?aXc3cDVqWFRXaFVKUHZibi9SbVVmY3A3NUZLUDdIL3N6QzQ3dkNXc1hCKzBU?=
 =?utf-8?Q?5TRCJjgrG36Tk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401de64f-6ed4-4b37-e18c-08dbcc00830e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:24:37.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8L6ZgWB/G+q5DrJg18tSqDp+xymKHDr6wY+MdetHgamZ6LOqOQ8UY6d3bmq2rZ9eGvU8aEDU5mk478LUs4PxtFb2T+54g5T18zDwQen+M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130130
X-Proofpoint-GUID: 8mVJTWJpLZrF-seDBe2SVaTZonm7PKoO
X-Proofpoint-ORIG-GUID: 8mVJTWJpLZrF-seDBe2SVaTZonm7PKoO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 21:57, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
>> Vegard Nossum <vegard.nossum@oracle.com> writes:
>>
>>> This is a new document based on my 2022 blog post:
>>>
>>>    https://blogs.oracle.com/linux/post/backporting-patches-using-git
>>>
>>> Although this is aimed at stable contributors and distro maintainers,
>>> it does also contain useful tips and tricks for anybody who needs to
>>> resolve merge conflicts.
>>>
>>> By adding this to the kernel as documentation we can more easily point
>>> to it e.g. from stable emails about failed backports, as well as allow
>>> the community to modify it over time if necessary.
>>>
>>> I've added this under process/ since it also has
>>> process/applying-patches.rst. Another interesting document is
>>> maintainer/rebasing-and-merging.rst which maybe should eventually refer
>>> to this one, but I'm leaving that as a future cleanup.

[...]

>> - I would like to see an ack/reviewed-by tag by others with experience
>>    with this task if possible.  The lack of complaints is a good start,
>>    but not always indicative of a lack of disagreement...:)

I tried to include people and lists who might be interested in Ccs.

I've now added Steven Rostedt and Willy Tarreau as well on the
off-chance that they have something to say about it (Steven presented
his conflict resolution method at Kernel Recipes and I think Willy is
experienced with backporting), but this is in no way meant as pressure
to review this patch. Here's a link to the top of the thread:

https://lore.kernel.org/all/20230824092325.1464227-1-vegard.nossum@oracle.com/

I feel like in the worst case, somebody sees the document down the line
and vehemently disagrees with something and we either fix it or take it
out completely.

I'd like to add that my impression is that a LOT of people *fear*
backporting and conflict resolution -- and it doesn't have to be that
way. We should be talking about merge conflicts and what good workflows
look like (one of the reasons why I was very happy to see Steven's
presentation at KR), instead of leaving everybody to figure it out on
their own. This document is my contribution towards that.

>> - Might this be better placed in Documentation/maintainer?

I can see the justification for that, given that maintainers probably
resolve merge conflicts more than plain contributors. However, this was
intended primarily as a guide to backporting stable patches, which is
not primarily done by subsystem maintainers, as far as I know. I'm not
sure where that leaves us. I thought it kind of fit next to "applying
patches" under process/ but I trust the documentation maintainer's
judgment :-) In either case, we can always move it (again) later.

>> - Colordiff looks cool, but I'd at least drop in a mention of the Emacs
>>    ediff mode, which offers (I believe) a lot of the same functionality.

I don't use emacs personally, but I would welcome this addition if
somebody were to write it!

> So I never got an answer on any of this ...  I've gone ahead and applied
> the patch on the theory that it clearly hasn't upset anybody; I do still
> think we should consider moving it to the maintainer manual, though.

Thanks.

I also saw a bot complaint about a repeated word; can you fix it up, do
I send a v3, or do I send an incremental patch?


Vegard
