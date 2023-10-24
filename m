Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8557D5BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJXTm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjJXTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:42:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5710C9;
        Tue, 24 Oct 2023 12:42:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OHcv4K002966;
        Tue, 24 Oct 2023 19:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=op7osgc7zep0T/pwFPb0wD3+tMOcp5Bgv9mrUFYv+bI=;
 b=sQt3e+hLvQEGsTiCf9vymItFSnNAR4fhD0zleQM0EbXydjNCDXUHbvmLQTzpQ1GkdaZF
 iKoR6SMSiBsbndTDHSkrbiUtXPmBYtnCrS8cNqIO96ObsrqPrkyfyb+M1ko1LZCYLxTs
 pnzhe+V5C2iF8M4uWExUvse481+ql1OwSWPYAIt52Stg1AQAqoD1oA6jDiWgdBtNRcKQ
 RNMdAeygXkamSDPwsJaR2DKWczgPwu1fDxkb8hBSvGzCHYSTeYcWGRQ32mD6RUm37dNC
 5PK/ywrHDecFE8uK6CelrW+jluparef2UM6ATqndEwKxruRGnxGgtETzv8PnzxCTsiHT mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68te9gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:41:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OJ6F8k014154;
        Tue, 24 Oct 2023 19:41:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfjyup4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoeECOP6zQxfVVuASN1WEjE0qsnZRReQo+T87qJhKrHRGvkZaIjOa+8TIHUIApDMYJ+/5gu32lJi/j0S8JvZQqwRq3FaLSKFzr+1xnecVzckeCJBh9WuYKDu/qUo9a++gx/H0oPgW0mkzUhV68+mscSV0CKpoQznsr62Y24s1MfJc7FPyKoN7oiQDGwBT4zKW5loOmTRHW2Wfx0YCagMxzG6fNIvbshyMhV1fbNAYKltw04ihl1iWRbR0fVeOWhqySj6TZLj6ZofPE/u0o1iPW220gTcFJrLdDNrnKMljRAWEv5QFRHqGN20bswzBleGBXm9HGv4wlwVaus8Wjo6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op7osgc7zep0T/pwFPb0wD3+tMOcp5Bgv9mrUFYv+bI=;
 b=m0VVaJhlMM5TqBgPxWrHbbZXZiqNOzBfvlVVYLfIEyssKEJ/QzKNkA2vCaqE0taegyNNLGFpP4CzRV7t7MvzXbS15387WdjCPPGefg1TXABHSxbXiEL6RRNADolkFgLwJRJcgbhJViCAQVRkrj8BYIZiEatg5oMaFmcW7NkYqrXoOjPVDhwHYOMO9GsI7Q2PIdJ/26pkTSxX6hrZ+1uwuiDmd8ERmuOgZtCvD9GG8L7yhqHSYHkiPWH7n7hcxxW82GULbajS/cnbI8Bu2Z/U0dkJiCV1wt4YZ45QrqiSwWkA+wiC9n0Kln9EmvFxVLgPF2ZDCmlyZbjOLC1lrl/C6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op7osgc7zep0T/pwFPb0wD3+tMOcp5Bgv9mrUFYv+bI=;
 b=KA1r5St1qjuEJHHxusPkdMIIocBdCoQ/PO416h1yk7BngTC1jNtsbJ5edQIyGHIeJvGipSvuCXNtNsdeNcVRiThGGOdXw9obQh+WaRz3ZFKY8P0j+QMtNvJ12rHqZ/buCx0KRXuddidv+Psmhp6khq1ShyEjhJLleHLg/2OC/ME=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB6681.namprd10.prod.outlook.com (2603:10b6:930:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 19:41:45 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 19:41:45 +0000
Message-ID: <f4c941d1-9814-4fe1-a0d3-3aec9347ce04@oracle.com>
Date:   Wed, 25 Oct 2023 01:11:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20231024083327.980887231@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: d57fa0df-b7b6-4386-8371-08dbd4c9410c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rQyL691C/sttaqDEAVGDREpw9QQJ+cjVfKLXTVyroG16YO6kwMqWYI/NFa4NSxUZTm4bIcJYs2eqKKXpoiFyMIFFQglucRVtT5M3DbjTMopGAC+/a192Arcs0Cgv4jevWVZm0VSnc84CUVEUVddA2nKUJ4NlrfftXbM5BKp6ktNA0mmsr9vs4awej4JTb9TG4tb/2GobXJE3eeMV5Yeh0REH2+/Rb0fkDGIhX+3JgRumSWVKPzVy3alt5FPb4RleBgzUGb2Tu8IOuiW4BwJ693nqpNA93/x4sHbuYaCZK5box7T1/ULkPKr+uYMU4dAScgUsQlEW8AnVLmytLobYrGR7oatIYp6ws8Xexd4rAelpginXT8O8Xd5ymSJujgXCWPdx9r3V+PLk9AggfJSDf/BfIIhYBW/SediTUqcsAJB+nyjiFJZYQOTWQ1B9iDqr2sRMBm+y+3a0LPlp4g9Gx2Spkn+Hw+SQIhHH4RnfupfpiCnppkmYvfuZb7Tx53OhP/w3WiCDBqKfBVJJFz33Lx/6D0gCbsime99yuEgF5FLv916jBiwp4nLgeANacIN+05RNH3ahCEmfIjVkkc5SCWSolzPOKkCcbSFpczv0Z+oiMEvrWa22YjOh7ui/IuKLN2a89IFrgcZlzfy2/RBTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(26005)(38100700002)(2906002)(36756003)(4744005)(7416002)(53546011)(6506007)(107886003)(6666004)(6512007)(4326008)(66946007)(66476007)(66556008)(8936002)(41300700001)(5660300002)(8676002)(86362001)(31686004)(31696002)(6486002)(966005)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmV1RE9rRkpMZTBxSFEyZTVqVitqWmtWNk10NDlXNTZrUWlMaWVvaVRkNUN6?=
 =?utf-8?B?VWVHRlB4RjZRZVJySlpxakpvLzUwS2ZCVGRHeWhZSElqek9EajVBYTJEeGpQ?=
 =?utf-8?B?NHFOVjN2bWp1VTBINU9BWHRNZnFYNTVMZWRjS2lWUlFXdmhScWlzcExoSk5F?=
 =?utf-8?B?Y2VOZ0srVUF6bEJXbXZrUVZxODBRM3krZmNZYlpNb2tpY1JKVGFPTU5zREtV?=
 =?utf-8?B?WVk3S3BMS3ZsS29hSGZYdGRjVGdTU1E4cmJPeXpDQUJqMDNremdERW9ocXRs?=
 =?utf-8?B?aUc0TkdTN2VBcGZ2UEVhUnA1YURrditmWDl6SmRPcElUU200VlN2ei8yRGM5?=
 =?utf-8?B?T3NLT044K1oxWVZ2aGxXVDJuQXoxUHRxSlJyM3NuM1JGcGhOejVjZzIxUnZ6?=
 =?utf-8?B?R3hkR29vaDJFK2FyWTRnOHhJL3NQbVIzbUJJWFlDZm9GOC8vbDcvOFVGMXA1?=
 =?utf-8?B?Q295ODJvSXcvcVJ3UjZIOFJGVE5zMWV1cG1OMDYwbkpjQ1l1ZmhORG5ZUjNH?=
 =?utf-8?B?R00ybVZXcXVUVWxUbzlJVHBHci9aTXBQTEVyVGZaM3QzNTlpU0ZIMDhCRk03?=
 =?utf-8?B?RnJUZWxZSkE0V24yWHBSMWVUUnZocWMrbnRGRFpmd2lPb0t6YmZHUHhzNnhJ?=
 =?utf-8?B?TTNOcmhUVFZNMDVLVnRCM2U1U0JoREZNbGdqaXB2MGtYOFc0MG1OUXFZTTZp?=
 =?utf-8?B?ZEttc0VMUU5CNFZBNDZvMXltVFlEeGxnemUvemtzVWVnSHJ5a3ZJeTlJcHZs?=
 =?utf-8?B?eHZsdWo2Q2x2bXgzZ2lnN001V0JqVW9SejcwMGttanhxY2lNb0lkY2lkTFMx?=
 =?utf-8?B?UTVZbnZISlV0Rm96TCtyRngzVFBKQTRoU2htODJMcUphT1d2Uzk3clFXeDBx?=
 =?utf-8?B?R3lROWdoekh5L0FhcTlOUzZ1RHc5OEdzdHI4aXlYZ0w3N2VPL1BkV3ZodDNm?=
 =?utf-8?B?ZWNRemRqK29CQ29Eb1VVT3VkN2liZDRzbmNMSnNTWThvWUg0Z1pCSjExdnFQ?=
 =?utf-8?B?VzNoSk5mbis5cHVXNUdqWDdjRTRJdkFXWDN0Wk9GbU1FRXl2UHEzVElNMVBG?=
 =?utf-8?B?VEljU0dJUHl2aTFWOEVrenJBRUVJb2ZTMHVQKzZxU1RLcTlBVXF2dUp0YmV4?=
 =?utf-8?B?SHR2OXlWRHJLb005NEZwc3hMSDZtclYzbnVtd2p4a2x1TjBqVkR0bjEvR2NQ?=
 =?utf-8?B?K3JHYkZDWnVoYUFEOFg5cGMyT25USkhRZTV3Q3BIT3ZZb2hkUEdWdGk4SzNq?=
 =?utf-8?B?ejdZQXBENnpkZ0pkK3pZYk5UbmJnSlpmd05PT2kyUXVKZkFqR1J0Z3U1aEpi?=
 =?utf-8?B?QXZuNVBTMFZQU0NDeEFyb1N5aXNWYXB5cVhCdnBnS0lxb0JZMGJQRFN1MWRP?=
 =?utf-8?B?bXk5ZlFoeFp2ZFBHblVoVTNSdVhzVDRZYXZBRzh2RWFwb3BpMFlqYWtMVjFZ?=
 =?utf-8?B?Qm0vSDc5U3Z3bkpISDU4WEZ5ZCtTZUVlVzhKZkllT014enNRMG1icS9wUWFx?=
 =?utf-8?B?d2pySjJidURTWEpWRGs0U1pHelJFNEtGeGI4TmswMWFkVlFkMWtIbUx5RVV5?=
 =?utf-8?B?aytZZ1hRdndTdVZoaDNPcGh6Ym9yZXQvbnYzWDkzUlhML3V3Q2JqS05UdFdS?=
 =?utf-8?B?T1hGbFBPSklaUHh2UTZjalpOeDV6UkxZL0tHZjVUaThyL1MrWnV4S09UYzFY?=
 =?utf-8?B?OGFzYkZpU1hPQjdYKzdTazJUcTc5eThNSnltWm5PdXBYTDVHTnlTdnkwK2FD?=
 =?utf-8?B?YnNLVno4VnJXZCtZODROTE1WaDRqV3lUdXQ2SzhVck5sSmlCSUNYb05OUEg3?=
 =?utf-8?B?UmJVdDN2NDF6NTh6RVVHeTdiMVg0bFJyNHhNbVdyOUdZdXBobUZ3QjZaOXVH?=
 =?utf-8?B?Z2x5cENuKzFKbUE3ZVllYnpKMXZKaDNCYVFUb2FpWit2VW5oSHl6WnRKSC8z?=
 =?utf-8?B?ZmJHeFljbWZnYzdUMFV3c0FMOUVDa051MzQrQ2Q4aVZwOEJ0NVNDVnIxcXNl?=
 =?utf-8?B?U2YrSDV4cUNwTE1QWVJJMnpVYUlLaks0NzFWbFlRWGVKWTc0RngzNjgyQW5G?=
 =?utf-8?B?djA4SFgwRExNSUdTUWh6RDhNeWdIWkpDUitQbGFtelI0bmNaZXE0WGY1YTd2?=
 =?utf-8?B?Tmg0eGZKU3RyOW1JTDVSRmJheGZyQ0pnNnkySmVpQXdwMDlhT0IrcnpaNGNV?=
 =?utf-8?Q?HXNAL+qZ5B6gJUSos31pxZY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bTZtYkNOQUN4TVdiSlpVRVRta01OLy8xMjBSS1hBZFpTZ0srZ2RrdmU4RGk3?=
 =?utf-8?B?Q05qN2Rkdnc0L2o3bnNUblRZbG9DOFZlVVB0ZW5URmNQY3dXSUJGY2k4d3JT?=
 =?utf-8?B?TG55RjlMRThLZUNKS2REdEtGRzRyQXdyeENQcy9xYVpUcWgvZVFJQWRCMkFh?=
 =?utf-8?B?WEk5R2ZDVzY5dzFoQWdrRlZ2L1ZBZVEzOWVZZHZSWVFFNmNCS0lJS2Zzd2Vi?=
 =?utf-8?B?L1VDTnhzM3FtbHZueE9qWTdvenNxVHUyNGhzeVIyMlJqS3hNblBIN3pXVGVp?=
 =?utf-8?B?TmtISmtOb2FIMDI5Y3Y5YUpwbDB5UC9pUVpMaGRvSk9GWjBndmRzY1dPYStQ?=
 =?utf-8?B?ZEk5a1RYOGFnemRKYU45WmpEdVFIUktsang1UjdjRXlGZkNqbmZtMlZVU04w?=
 =?utf-8?B?KzNiSk8vay9pNjNaVkJxZjBwTVV2T3R3dzJvc2ZteE9aWlhSaDVwK3R2d1pz?=
 =?utf-8?B?dkFnKzJXdGU3UWRqbEhpaEhzK3ZKb0dwOXBYMDc0Tm91dmRnQUd4b3VYalNp?=
 =?utf-8?B?dVBtbHdJWUhOaDFuSkdhQmViZ1ZXUlBNQ3MrTUV3TThmMUpYSUxsYVp0bTNP?=
 =?utf-8?B?eVNsV0d2Uk5QNERKdmJIMlhYRndaaHQrQW1ILzZ5MVB2eHFsaU94OFllQTRS?=
 =?utf-8?B?MUtnRE8vdTA2K1FCR2lNSnFEMktHTVJPSG1GSnBoUnlsOUlidHNTejNkUkUw?=
 =?utf-8?B?RjhLMTljU3F1aEVFM2FBR0VBakhxQVgwQVIwZkdSR0gvY0FHa3ovdFNJVnZW?=
 =?utf-8?B?ZXcvcytaQkZVUjVIa083dEw1Nlg5L3FyV0hmdVdRZlQzeG1BejEyTWpPUURU?=
 =?utf-8?B?NzhtaDhPUzRqMityaUxZN2J3RUtrRDlHaHFUaVpzSTVBcFZPcEpYVmZsWEgv?=
 =?utf-8?B?eEZSY0VmUlNIcjVjekpxL1hIVlA3K09YczhVMU9uTkZYcmQ3Z1h0and3cy9V?=
 =?utf-8?B?dWx3eUxBRnYyeHVFSCtNZDhDcFVzeDg4c2cvRXhTZ01NT3doRlZkZnBmcnI0?=
 =?utf-8?B?T3RsUWNtbE15ZlN6S1p5bzNSZHhBMXN1SzJXelVRR1ZFRWNhVG9jOFpOaE1p?=
 =?utf-8?B?aXUzaG5MdXBzTCtJVGtlcmVhQ3dHbXc2aGVTdWk1MVE5dG5pUTlHZFF3Nm9L?=
 =?utf-8?B?MTEzQkhzNmk2QzZzTGwwZG40ZHFjbXhCSnVYbVRIajRtbGxxQUYxbDBGR2hl?=
 =?utf-8?B?TkxzSllXY21HVGd2cURUSmdGMElHbE0xby9YbmNqQVVTZytWM1JrVUFGbmRl?=
 =?utf-8?B?V2loNitNZnlDbHNHSWl5cTVIYWM2aVFrNXBwK0paOTV6MU5QRlE1YlRyUGhX?=
 =?utf-8?B?Ujk2Z056eWpYb09GdmlpdGF3dGxBOFlLYzgwME83ZjJaendmaVVIUno1ajUx?=
 =?utf-8?B?dTNvNlFYQ2g0ampuYmF4cHhGclBVbG9VUkUyUmRhREhFVXZZaStxVEJ1RHpK?=
 =?utf-8?B?ZUhNeUJHRGZCVVpDYVIzc2FNbWFlcnRrL3dxZmtVNFRTaGFtWDNmWmh0bVdk?=
 =?utf-8?B?SEZsM3Q4VG5qM1lIclB2V3JEUUF6aURWQkgram5NenZ5MFFUbjlBUXgzVkJa?=
 =?utf-8?Q?LGM+2ESQDQr+3NSnNiMNB/tnEHw7R3gX0ZlGoZjWbsYp4i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57fa0df-b7b6-4386-8371-08dbd4c9410c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:41:45.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ9RdfmWjC4SGm//xbRYAZJdA85F6yUIDp7vz2j3KMA/aw2wqmldIvZG5g67xYzGzT03YZOSpddLxN26Hp8dTUhEEl0qoYr270ozXtMHfBWdxq7qsChJh3GIe5TnsNf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_19,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=984 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240168
X-Proofpoint-ORIG-GUID: bYa-4pHox2d1DNeUoiVFfUD_3mfE8_D0
X-Proofpoint-GUID: bYa-4pHox2d1DNeUoiVFfUD_3mfE8_D0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/10/23 2:06 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
