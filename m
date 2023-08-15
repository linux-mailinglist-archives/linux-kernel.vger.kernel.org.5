Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0277C571
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjHOBvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjHOBu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:50:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4116C3;
        Mon, 14 Aug 2023 18:50:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOtOL022038;
        Tue, 15 Aug 2023 01:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6/NKVx2ah0dxBNj3LT/7D2etNoihMvOh2eiQlYfgwxs=;
 b=td4Ph0Pl01PB0d5GKpC2gR1gAw2VXxZzbgrpSEQ9osnAb5fHIIQFP2l7lWL+NcRuPY1T
 ru033iLJ6+ls08V7qYqaUrBjLfA5uY+EoXdEHzxt53/rRbpQVI2vhLGC7jHCAgTEGJ59
 jgw/2l1b2Y/m8pdg2aZzf5eSBcEdOlpSPJzH4Km886uIQKHBEmOjbdkTjRzBGqDh8NU3
 lPXDbgEtJuaI7h0Ezt0xID+rvrVMIwVAumdx6pBY6jqO9HSUNVvGCPWcvBlENTTZ24V4
 0apvOEenZdlKD8lC6cXFzguy0vxsxYNqfMYMBnsKGB7b8b3VEahbCvZcJKHVPybCyt8V GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30suw56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:50:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENLbuV027483;
        Tue, 15 Aug 2023 01:50:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rkd25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGN8/qtZZS7rWw2Yh3PQKxR8uf/RB9fT7y5BD5Zm99LoaL8xE3AIU4f+dEXn7k8jtrLvtjrLo1lfR9TeHJCj/PrsQjyGws8g83MSv7Ziu9/6oDdBHmHp/Vz/XoxtYzXU+z34XG+qpRnNLhTfaqQS/9FrslZUZBojjpRXUN8gEaUNI7gO/dzAOTFS2+L11lpw5TLmDA+k185o+ttkN2HtF9ZV8qhNI2H7MsRWmxI4LLejlSM8YBo4bvRJIYRJlkQwXVKkFKM6CyPCM4eKUTzwbCYpCDEIfIq4K21FZRzLChOhnWHmYGvRyphNqq216PmLKZTNg1DAbW4T63FpNZd5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/NKVx2ah0dxBNj3LT/7D2etNoihMvOh2eiQlYfgwxs=;
 b=dPoDXtE0BwG9GTTlE3TrETLTl6d0DWLv+85qV6JytBZOlZ1Kx4PZOUizeqlUyBhdLgelZfIqocFy5oR44YrT/rytfyeKbhzIucKihY+IArJOhqJCyOyBDCWXUhmN13bqxj0SubT+B1NACkEuLb0xEx9RP9vg2KvucOp1aq6B15Z2a2Lrmvcj+L3Jwe7Iomzo8R/0GPY5/39gEaSH+G4EK7E1RQEyXlu30H5Nan7Mii+ijgDb14ARsjna2jJJU9ykCfCkncBKjoDvWXINndYCMdWA1RcA2WgRAL+M3o9UJvhxRW16pZcJZ+Uu3k7uy0tujO6k5weynceo67CBEQp82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/NKVx2ah0dxBNj3LT/7D2etNoihMvOh2eiQlYfgwxs=;
 b=qQNVrOaUky/so19MV1jIs6fJAbciM9DQ0eH4IOtD6BiOPR5pqkdK4CmUAC4lv97oTdm51e91UdTYrITCsERwt2dQQbwzf7XdYol4G4axMkDFMYM1KxLtV+nodU3kqdMFMfDTWRiayujVCMWRRGXtCJYvCKcikzIIaj0yMH0UOnQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 01:50:11 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:50:11 +0000
Message-ID: <4df8df76-754d-237a-05d1-76654ddbbff7@oracle.com>
Date:   Tue, 15 Aug 2023 07:19:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4.14 00/26] 4.14.323-rc1 review
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
References: <20230813211702.980427106@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: df600d1e-9777-42c2-21ac-08db9d31f641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2NvcPf3fKmPxHGT/j9sR9Iv/NuigGRMDmIAKx7lMP96Hz55VLIvOqURvWVrIYIxNzsX4tvE0jW7Wclkf9Gzy9cLWUA09NShs7QbeUUoWUo3vpam0G58q8meTREJjPAe7Hl4Uy4VifZdOpSTxBQ3yUweE2y8Ahp4/qtOJyf6Zz/tREJ5SVXnHYStN3hyrIZH0HFlF19T5XvPe5mziw/cDP34H9J2prdh8JKOlBpoIfaqrzpTuo9k6vHtd9Y6n+a4zauF/9WqtF+k/GewRDdcRbycXx+tKfgN0WByDyOKP41/mNf41BSd9GXuCNthlIjomPcjXxlDvDWeJCmIz9ZIliT9yCkhrbGr0ZW67ANHIoNKBYHLti/wlgbPuE0vCYX5ShYwCvO658FX5P+hECk4Tf5/fia3kljGd7ms80SEC9u8sUetSQCtflRWEnQ6ulF81WETgD4biZQGBfi+UrBrV8xzhAIk/TyxWOEva4q/3H+yK9t6dfGuT3P795sFxtXOQ+ydiye/9nEFUGKK9Tu6K4gk0CUv/kMEXK3lmfZzgDppXC1lLLqv9T2zLY6fcWqvHxJxboxp3XUo/AUVp9ByN634UNWXOmzdullq6IrCIRUvQbh4n7WFgqb+o15m8UrARWzWw6poGzsmcTCnOcZsJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(53546011)(107886003)(966005)(6512007)(6486002)(2616005)(6666004)(5660300002)(7416002)(8676002)(8936002)(2906002)(4744005)(54906003)(478600001)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pDdmxHRm5tc0ovSVVrK015ZzNMeDRqNUNoVUwyZ2JnR2Jlbk50L2c1eFFp?=
 =?utf-8?B?akFOcGREMkk4anNxU1o2MXhzSUZwWGpKOCtFVlYzVmdmUHgxeVJrOW8yQWRJ?=
 =?utf-8?B?K3VRT0s1OXJtMTBWREQ1a1Zaa0JFSGVWOVd6bjVoYjI0VGF1cU8wTHVOZGtI?=
 =?utf-8?B?RDRXSDJmUm5YTFh6ZTMyMW1XY2UySlk2TE5CV1pHSlhqTkgxRHhLWXZHMDBX?=
 =?utf-8?B?NUxlZE1YSk5XSXZoYjlxVFlaUWszOG9GdEtwaWExYmpGRndkbFpNME40V09O?=
 =?utf-8?B?alB5K25CeDhna0daSDNYRnNmak9uTTZoZVFzY3JSQk11aFgvWkFLOGFndDRG?=
 =?utf-8?B?S1JmTGI0d0hnRVM0aVZXemU4MlQ3MThaS3N4anpGQnNZSGFlV3BPUXZFcFJP?=
 =?utf-8?B?aU1aSXFIa3JJTUxDQ29WaWhqa0NOOGZKbzlhMlNLRExBUEZ4UCtpajBaUlcv?=
 =?utf-8?B?bXRXckRmQkwra3B5MktITTJteDdsZ01WL1g2QnZMZ0dTK0F6cWZlK2FxMkhN?=
 =?utf-8?B?VGgxczJwSnhGQWxiMkk3U09kdDc0UHRFSUs4YTcwTDR0WVlLaUdXbnNHRkIy?=
 =?utf-8?B?eHg4UE5za3luci9XZ3ZWdHVKRVlFU0pPMWY4TmZXNmJwaFdnbGMyV01WdlpI?=
 =?utf-8?B?UjZpbVFEV2hQOVBIOWowdUx6TWNzV2VYQi9XeFpuR1VNeW5nSjJVellFRzdD?=
 =?utf-8?B?ZmFvd0IvcG91V21LL3ZFZjdKb25wRkNTZjJldjFSMUcxQVRLQnBqR29UUy9X?=
 =?utf-8?B?WlJTRVE4em1USFFhakNDZGcxY0lJOEdxN25FMW8yRzNwT2NQOVI5Wk9kcWU0?=
 =?utf-8?B?N2pzeWRLdVh0bGhGM2kxR2NXYnJYRW9vSlV1M251ODlpWVkzNTM0MWVyVDN0?=
 =?utf-8?B?V1VjS3N4cHRiSmNkTFQxUnAwRy91cGFPTmlUOVJrUE12N0FyNWlCUG9vRTY2?=
 =?utf-8?B?MFdmY2pxem9LeGtpMlFoN1VmVmxFYkVqdHBKbG5jOG4zNXRxSlpQMUtMQVVQ?=
 =?utf-8?B?UVNVL1Z0TE1JQjhoUWVVdkw0Ym9DNkt4TzZndElaN0hrdWhYUDB3RFZyQk42?=
 =?utf-8?B?N3A2Mi9XL1Fpdm1aRERFY2syc0tFQnBRbjNldHRpYWUvdUFhL0FzOEpSdGNO?=
 =?utf-8?B?c1M5UzU3ZzYzeC9PUDdYTVgwMU1yQXBlWWV0eVQyNmcwR3J2M3NNL1hvZElo?=
 =?utf-8?B?TE13NjgvanJNMzMwbmZaQTEvd1lEYk5WeU11cVYxL0w3bFNsemJEcm1lVXdV?=
 =?utf-8?B?cExUaGVWSGQvaFE3SjJzNnQrWWM4SHI4anZXaS9yN2lkTklEcGhzMVpyYWVO?=
 =?utf-8?B?RFJuOHp5c0ZBdFlSUHNndG4rQ21FV0tRNWpSVm50K2FReWthWVFPbllWSUdK?=
 =?utf-8?B?R1FYWVNCeVlzN0tNcnc1MW9keUdpZW8xZmoyR0dhaXcxRkZOc1ptNlR3OWlt?=
 =?utf-8?B?YlV0eWJUekp2djhjTEZQRGJ1ZkdVNSt4UVlzbUJRcUNqQk1EYTR6MzFjNVVW?=
 =?utf-8?B?WG9MMDVHRWdxMUkyYkc0cEthbzY4ZnBLVTgzSHB5T2cySFVPKytVaWkrUHpx?=
 =?utf-8?B?OGJJT2dUTGdaa2xXS0NsdVVvL1BLeWwzYlBZb0FraGc4N1N3QTloY1JPSDNC?=
 =?utf-8?B?OGRCRVJTb0hvZjd4elZQcG0zbFk5YTcxSEptK3N6bGpyV1BwcjIxUXRUYUVN?=
 =?utf-8?B?UllUZUFCbG9aUVZkSW02V0Y2T2tacHdUcFphSmhGZm8xNTN2bTh6VHNZZ3lz?=
 =?utf-8?B?ajdFT1d6VE1hTTcrZDJ3eEd4UlJaUDFMNXU5eGpnYkxPWHpNUWlLc2dTOStB?=
 =?utf-8?B?SytQTytTMzk4V1I1bkhtY1dsNjllaGZEUjJmNVI1LzBWb2RrUUhNNHAvVnFS?=
 =?utf-8?B?ai8va0k0Ti9sbTZ3YXdFNXRvR2NMZ2dSTkxxWEt1clRGRXliR3AxVzBCdDU4?=
 =?utf-8?B?VTBSQjNNd3laaXFYUWU4bnhGdk41dSswU3hGSlV3a3BQcWhJWFJFSlZaRkc2?=
 =?utf-8?B?dU9sczBHU0lWM0VoY2YrcW9uK1Y5RXdIQTk4NHVBa1lxSUFoSVQxR2N3dnMr?=
 =?utf-8?B?MmJxZ01mSzdLTGt3czlPQXUvc2MzeDM5NC9UMFpnUjRVdmJraGZEWDlUZExv?=
 =?utf-8?B?SWNzcGlPRXR6cWJOZG9uKzliMno2SEl3eEY4UmE4YTVMMkI1aWVjSURsSnF1?=
 =?utf-8?Q?DYEVScz917L5OJR8p3ldI4A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aVlhTC9BeVR6bXBidkdORklPOGVIYUF1NytYb0VIeVZBdzlTeDYwMHQ1L29R?=
 =?utf-8?B?N3pndHRWMk1pVkJkZ2tyVXNHOEFER2U4Nlo3bHBiaEc1QlhPQTBpamlSY1Z4?=
 =?utf-8?B?QVMrZE0vTDNqbng5RkVDREZwWUdybkhQbWFPQytjWEpncE1BVnhVcGpjVTlw?=
 =?utf-8?B?NDJzNE4yRlgyRVNTVTIxYlpINEtCU3A2QlJ6Y21zVkNTR1lDaSsvYkFHZHVK?=
 =?utf-8?B?VWtuZk5pZWRTblQ1R0ZrYnJwQUpiT1E0bWp6RVZ0SWptQkVvNnNrVXJYaFpa?=
 =?utf-8?B?bElsdytvZjZCWHBOYlNOQUlhSklVRTZKUy9xd0Z1SEo1amo3TEF3SVRvT3Jo?=
 =?utf-8?B?cjJOUDF1aE5jVHlJZTJiNkl4cFRhaHZrenc1TlNqd0xnV0VTNWwrRUllS1Bo?=
 =?utf-8?B?aHJDZWxyeE5vRjk1eElwdWdRaXFIc1ZpRDJUVzZ1aXdkRHFpNVBtRjkvYURV?=
 =?utf-8?B?R1YwWmdOUTRuSkFkN3EzT1JBOE5TT3NkSEhaS2pIckQrRTBxdjBEdW9vclh0?=
 =?utf-8?B?L0w4ek93MkozcVprTll0SS8xaG5zaUx2VzZNbW0raXB5SWI0RFVsTnZVb1lL?=
 =?utf-8?B?NzI1a1NLeVlKbmZkTk1KbGtnT0hOWDlXUFlWZ0Vsb2FqWkVWdGpLeGx0M1FL?=
 =?utf-8?B?dW9JSEZBbXV3aWxJaEdaQlJCbDFqblRYOUhlcnU3SlJ0czNJUW9aZ0JDbzdj?=
 =?utf-8?B?eGgwcnFhZk51d1ZxZ3lnS1pTQ3c0VEcrcHJ6YmpGdnhaeldRT0w1MHQxQVpv?=
 =?utf-8?B?K05sazJPK0MxMlFHZnZSdmQvVDVyRUdZMG1JOTNqeWoxOFh6ZzdmNnUxYTEz?=
 =?utf-8?B?YmNTWk5TZGswWjRsdlp4Q1pBWHRNb2ZCNjlNTUVGQjl3ZmtHZURQS2orOUFw?=
 =?utf-8?B?NUNhZUczaVEvWkZSSWVoZ25tOS9jU0tMYytKeVlaQUVHYkxscHlCUlBnZHAy?=
 =?utf-8?B?WU1FTVdCL3NiK1JEVGpWTXFqb0xTZ2tOc3NPaS9ScCtENXcvdWxhSkRudlJL?=
 =?utf-8?B?T1VMa1k4QmsxRS9HNU9iOFdoM2FsUTU4QS9Pbm02UUlFQ3ExNnBEL1E1dzlY?=
 =?utf-8?B?UlJHQnNTSy9zQnZvZDBYUjNJR2loVWFHZTlqTVZDeiszMDROVE0wWjJVZXVn?=
 =?utf-8?B?aEk5S1ZERXJHZjQrZlBWeEZ1UFlBVnNvL285WGFiVjFEbUFQcTcyTXdpb2dF?=
 =?utf-8?B?WUhTT1NTRC9NbTc5N2R4UGU0UUdwQVQ5ZmtQdkFaYXVFdFV5R3NiMGZGYWlt?=
 =?utf-8?B?SVhaWkFjT1NsMzRHODJoc2ZTU09CMm0wQjFkTWtnaUZrWWdHbVEvSDh5b3U0?=
 =?utf-8?B?WkNBTkpGamVscHZvZmhWOUo5ZmxOdHRTbnk3UTRscUpSTmQ5Zy9wOEFQVkph?=
 =?utf-8?B?Qk5RUUpRNlh2T05sckZxVUtUS1dKMWllM3h1VElJRk9aK2RuOEZHdVlqdGZK?=
 =?utf-8?B?NjdGN0Ftd0xOeVRFeU01N0R1MjIzSzJFRittMjJ6NUFoVkE3WTdCRFYrek5y?=
 =?utf-8?B?Qzc0ZDhmVkV6dm5oa2JaODZiYkN6MnZ2Q1pQZHFvZWdKd09oN0tqUFkzMHVV?=
 =?utf-8?Q?2yBG/Kb0+vPvfwCRpHj1Xt8DzQwSWQmIIob5NG1RqBzW3y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df600d1e-9777-42c2-21ac-08db9d31f641
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:50:11.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn+ttivQPNFFBw+1WgOI1ABh00kJFv8QC8MWQZxjMCVfLS+jEDxxELCLg1MRwABCN4H69uxmL9mkUv/QbiIM9HJrsyZdqC9NFc26pvLUDX6/SwbpLYbdw5gk6eRRQVC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=974 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150013
X-Proofpoint-GUID: hH9VkBAbDuCHA1Vy5xkcAZLU3UXWCZ0z
X-Proofpoint-ORIG-GUID: hH9VkBAbDuCHA1Vy5xkcAZLU3UXWCZ0z
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 14/08/23 2:48 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.323 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.323-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
