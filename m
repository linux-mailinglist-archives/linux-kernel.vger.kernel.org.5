Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672BD7FC299
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376314AbjK1R7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376262AbjK1R6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:58:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC23850;
        Tue, 28 Nov 2023 09:55:49 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHnYtV013619;
        Tue, 28 Nov 2023 17:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ul8hgaa8nMNRqp1XcIruVj03cj6sX8lvf4LQz0CLyfs=;
 b=nIhn5+Dede2ZOPH5SWl8SnXGtGyEBri5oEOXqgsiUAWe8clPCWc/hwuzDOIWcsJzdIZ8
 UTddV93GqoOolGTsHi1vapXDZNfwgA7sL8uLVgnHE9c0e+DmJQvcvBP/IDiQUMc4JVOX
 KfeZrX9EujE7EraUPrj0QrpwSiqaPS/1OgD4WjPuvFuGCG/3LG/aynf4temhuDOLgce/
 faaT43x2GaBJSIDVXloNxFpwmeMNjFhOrU6Xgq8maa27s2SBjH3ULSMuGaSyrkeiJbVo
 YjYJD2Sset3PE59nX8rGKnDn4oLRHchM0KXCZ7JCWaXjboC4HtOooB76n7CBZwHUXJH/ 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucpds1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 17:55:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHK8LA012652;
        Tue, 28 Nov 2023 17:55:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c7j97u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 17:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu0jp0K/fdyTcMnZ5dsoRLcbxE9izksWqpnQqNSLc7eWTNHKWEPUmsCovAcQDYWxte4UZot40G4YLDKY0pCnGXc9+BGjPINOr2V+SVTttSrq7pxWBAt5PL6galCQotYuph7zGPJuZaywy/Pfl6JB7aTh1qykJoDPDM3kcS9UXBilr6BDPjQQA0hJJen6XvjQKYJt2XGOoBUUk8a378YlxkMKVbTV16geVfdwO88L1H7N7kuWYKS6vpA7WczDcLNbPqb0BoZjct4nMmAajb8DukR+qhUFDqR+lbJryHL2BVUYM0s706Hl4pQL8L75LSdYWX0wTBH3k9vsMkWpEu93uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul8hgaa8nMNRqp1XcIruVj03cj6sX8lvf4LQz0CLyfs=;
 b=bzohXi9wWxKgpjXsnknk4Ll8NTnDt1BtIfZXk+z7pD1i0afxMc/1h3MEK5rfXA8GrRxu7FMf9R3kJDDAMg1edPpXe+SH1TqmA3LMcTpRl8ZVa9fQDZC5Ya4i+6RN1Hu/pL/IGL6lEPVROSG0RV18MaTNltNeZKB+BeSdYEuNzQ0F4z25wS99FaVpNo2X8umJjg8sLXQbsCqcbj1iXK+PWbuNniSMFPFqIdoSjrjrmdpEk0pSymWg6lk0shCiYxwiek1IhHNnXSfVLFekDV9//d1UM80eoDJL8I96STGbXY3e47aGvA8Mlx1CJg9fENxUDwFlUKbvTW+KU90RZAIXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul8hgaa8nMNRqp1XcIruVj03cj6sX8lvf4LQz0CLyfs=;
 b=a0Bt8sCFZayyO4hK3gRSFVkpRZ++D27AbPwUpDMC5flEtZwBSIuE9YuX1vMz5wVEa6jnoeLn4Bgvdo8RSIna7vN/8UcKa+Ta/zw9mdPnbthrSJ4VG7fWC37pZ2z5hAfZjRFd65wLvEifZp3gnc/DEu89nVWuEy7O7+S6y8L1bSY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 17:55:24 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:55:24 +0000
Message-ID: <b1fa28b5-a93a-4580-8f50-b27f975216d3@oracle.com>
Date:   Tue, 28 Nov 2023 23:25:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/sysfs: Fix calling kobject_put() without kobj
 initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20231128130952.3372794-1-harshit.m.mogalapalli@oracle.com>
 <2023112824-cupbearer-salvage-b064@gregkh>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2023112824-cupbearer-salvage-b064@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c56219c-009b-471b-a596-08dbf03b326f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Kgb/vGSiQ9T5B/RkZtxuwyF1XL0PF4FZkm2bHgb9ths9dzTDmJJidqkXQfPWE3dQbN76TJucBLSeFJB3qY3QElYOFb43pkZ4YXkyOFng25mTmK1Q033n5IGedwoRG1MYdThS+bxBHeb7D78bwCFRYCaET5dc2J8QzDfxn5JhbPkSwmXhgQ4qQ539KjaAy6BUN1WW/Y9zZxn6qB06dhwIf9L+DNyWaHjhXU7lphLehZ6/2JDPno1rmpA+mUzJX06kJHEswLvk3nNZxPrPHt3AcnSzmtRyRTzzCvGt8zOU6xBPp+V0mSGhISuQmRfxfBt16CBq4hHS4FZt4HLlMVErTfeNZqed9rNKaaWh+S2mF+Y8yYzQDM8heVb1rR8bqA9PTEnLTEdnOsf11kTKtGu4VHgW4/qRuwkz1OCyDhfvEByZP1bl0B6//hTVQcTjAzb8waNjffy47zPFABDJNSVoeqMnkfJQbBps1JStPe6zaT+g9IyPHRJFJfDq2znoK6M3NnrNnXr6Hm2PBRlv3XmQS9hvDOQANzdXX+ytH3UZUtd8XvXuUvI9hnfKabeQ6ZSzE7191wB2tLFyva4ZakSaI2Lt7VbobG0Khe4hszyGPZ+DszF/+0SEVMLhJZuF2fGvue+DgW+m8CQl2H3QbjIx1Qe1yzlWd9KzVwm3HACh8d7WZ8pQAUwTNPu/G3ThSBt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(6506007)(31696002)(6666004)(86362001)(31686004)(41300700001)(36756003)(6486002)(478600001)(53546011)(6512007)(2616005)(7416002)(26005)(5660300002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(38100700002)(2906002)(83380400001)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG54MlJtUjNXYlhMM1drQXA3eEU4bmJhS1pDT29HRnhpaTlDSEhFQ2gwZUNG?=
 =?utf-8?B?V1VCWnhyeTRDOGlEb1VCempnenJidHE4bzBzWWN2Zi9zNlh3WlBnY29tSkhO?=
 =?utf-8?B?RkhnaGJuNnJMcXVaTWFYWStDc2M1QW53MEFPdmV4clI4VE9NM3hwZlhTTjgv?=
 =?utf-8?B?bEdqNkVPRjdoaDFnMlloU3E2VmdXaFk5TDFqbVY5c0dtNElFN2UyOHAxSng4?=
 =?utf-8?B?SHBXT0FEOTZuaERPdnNpZUc2RHZTYU5rSG1tbGtGZWkzbGgxUTVjNDg5Yk1I?=
 =?utf-8?B?MjdtMUttSDY0NDJTSk1zUXN6ZEl5RDFKQ3FaQzM0em9TOHlCaktXNFlha2pQ?=
 =?utf-8?B?TWJKUU5SaXV0N0lKc0taMnhqdEpxcW5EL0lPSmVlUnNFTFNRb29HemdtK3p2?=
 =?utf-8?B?ejFaaUk5T3JHUWg4dnk4S1FmV3I5SmpncG5vVHdFTm80TXo0K0owTk8rUGZM?=
 =?utf-8?B?c2U4SW1qSTVCUXpYOU0vME9mMkxzS1kyenJzNGdEd0lNTTVlWUxPUkVURkgv?=
 =?utf-8?B?Q0dwUkpkcnFWWEtuckFMQm50eWlMYlJqNEV0REtBWGJVNHBYa3ZseHhxbEdi?=
 =?utf-8?B?a0o3a2JKaTVkVk5zRk5KVVN1OTRlbU5lVjRuQitVSjlRUEpNbXhPTDhlSDFi?=
 =?utf-8?B?MzFybGxIcm5PSHpjN3lnVm9Fd2Q0REI3cS9LNVJKMk1TaVpBaUxORTdMb0Vw?=
 =?utf-8?B?M0dBYkJodzFjMDBuV0dmcjRSR3EvRjYwUVREN2Rrd2I1RU1mbjJNaDA1cnQy?=
 =?utf-8?B?ZnpNTEZmT3EzOVRGZVdMY3luZTRDeXZhcE9UWlNJY2V5R0dMc09WZVZqU3RX?=
 =?utf-8?B?bmtndXpDNjdJdzM2WWFSVEI3ek5LRjMxdzJGWEpnTEp1dTNaR2U3bXUxQWFm?=
 =?utf-8?B?OURMbmw5Q1pQZE45eXhuY3FDSFpBaFRLdmZkNjhzdnl0WFdSVTRlNSthRnAv?=
 =?utf-8?B?bERoQ2EvczNjRE9OTkovZ1k0V1hIT2JOM0R5NUh1YTdURTZhZUVZYmZ4QTZk?=
 =?utf-8?B?YWpRdDVJVWZSOFYyZjZKNWJpK21rS1RmcVRRQ1VJenVxN01FdEw0c2NlTXN3?=
 =?utf-8?B?MFF3WGxnSEZmWGUwTGxabFZQYlV2em5helFRUFVZZTBlRVd4aVkxWWZwbEpv?=
 =?utf-8?B?eHVIallqMm5KNWZLUElyc2VWcGRJb2t3b2ErTUlsUnBCQVp3dlBmQ0I5OSta?=
 =?utf-8?B?UVZWekN5UjUyT2hKeHZ1a0FoRUFVSGh1WGdTMlN2UlA1S2YycXlLdnhyNEtl?=
 =?utf-8?B?Y3dCTFJnWVc4RXp3WklYNnBUQyt6RXUxUWZjWDBNZ0NweVc4aVJKc3c1L0Rn?=
 =?utf-8?B?U2wyazg3Q0pXU1pyTk55WVhhZFVXVFpXc1FYcHVYdDA4TTdWTG1Sak1ZYkcy?=
 =?utf-8?B?NmFDTGcrVmNLNkhoYy9RODZ0MmtSWEpueTFZRktmeFZSTmFMUi9NbDRBejVa?=
 =?utf-8?B?cTFOeHBkVC94cm15eDVqb0J1MXVTSytYSjhXUkpORFY2eHNYV3U3cmFxVEd6?=
 =?utf-8?B?U0xndnQ2R0p2RCtoeEx0M05QUmZxOCtLTjhOVDI4MElQSVFBMG9VZFZKaDJt?=
 =?utf-8?B?cHZOZjh5Y3lTRXN1dTN6aFo5dXZ6ci9nam9QQVNEdUphYTRFM1hKMS9QdDRK?=
 =?utf-8?B?ZXBVYjVLRlhYTVVSWU9SdEhxa0I5dHhWalBHb0VXdE1QcU1DMWZSTDFsT2ty?=
 =?utf-8?B?ZnBhY2M4YzZhR1RhYTcyZTF1Q2ZiTTBtYmlTRVlSM2liNWI1WHlYNGpia2RZ?=
 =?utf-8?B?RTI4Qy96YzlQN24ybU90SzFzSUpqRFNkeGhoNFJSUmV1Wkcwc25GU0JPVDZ2?=
 =?utf-8?B?eHhjQmZRN01zamVPcTRBQ3p5cGVTQmZCazJKcFl6UWNWbzhXWldLYjJ6NDQ3?=
 =?utf-8?B?dzJ2cWRvbjNrQ3g0RDVRd0V1ckZ0WDF4VmJzTXJLV29iSGdGQU5UTk5TcVpl?=
 =?utf-8?B?T3EzWTdqak1RTXBRZmNHUWhJb1hRaFpIS2FiMXNpUXlsc28rYkZkKzRYeWVG?=
 =?utf-8?B?YThiN3hEeDZPaDhtaktkMXdZNk1LQXVZVmNaa3ltZXMwMXNmZW9pWEQ0N2R1?=
 =?utf-8?B?cnN3Sk5EOHJ0d0ZIeXVSUklPOVRhMXdESGlhUnZKMVNnK1Zvdmh3K29iZndH?=
 =?utf-8?B?ZklEU0ZVYlVMeFdHSnFGSnhGT3poT241V3VjN3U0SGxaa0lWTFNrRlltMks0?=
 =?utf-8?Q?5HToHfvK8kWyGg8ull1o3eA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RERoMVpET3EwUm9iRTBKanhGWDh6ODArY29NMHdOSGJaWjNNVmtzcmgxY3Ay?=
 =?utf-8?B?aUpmWHZ4R3IyWTRDUDdMWWthWTJ1RjZNKzA3NTMwL01ucmZ1cS9YbGhtbjVD?=
 =?utf-8?B?SmgwOHpQRi9QSkNXcTNVaXB1U0U0dDNLMzV2SjhqeEhMN3NOeGRPSUdMYjZ4?=
 =?utf-8?B?bVVDSFRVTVdXN25YUy9DSlVvdVRiSHRSYlk4MEtVK2lhK3lWZmR5YkJVYXFL?=
 =?utf-8?B?Z0VTSkl4enZYWUswUy9QTVNrNm1MUWdlUTNBeEdaVTVNZjJwQ3RTYjdhRmZv?=
 =?utf-8?B?NWZ3RHJKcHB0cFRINXA2VTc4OXYvL1pybDcwT0tUT0JpekoxQzlxSXFhSmph?=
 =?utf-8?B?dUNCV3orY2R3QVdKNHF6WmFtaHRtd1JzQTZFZGpuckc0ODh2TE1RR3J6NUMx?=
 =?utf-8?B?S09xWVRxTURlNW9xb2szQ3F6Q0NFSlBpRFZLbFJHKzNZL2Q2MENPaTh3eUsv?=
 =?utf-8?B?Zi9RSDVuNURoVFY1blhGQWJFcGcyQXNuUFhIenFkMWtYWUhwS2ljOUYxNnk3?=
 =?utf-8?B?SU5NeXRoeW5tWkpobzlFN3NraDEwSGxmMGRMVGtScjM3aHlad2I2U21HUXh0?=
 =?utf-8?B?NjUxQnd5eW5RV2V6bVk5eHpORUR2ZFdVdlU3MmFlN2NxUmhTMjErUFZFOVll?=
 =?utf-8?B?bFpRUHBNRkFEa0tldGluWGFmT3ZzVmpoL3A1eGFGRjdIdzJ3TTFTVjNVSWgw?=
 =?utf-8?B?REpZTEQ5b2tkdXFCSkVTQ1VVY0Z2ZjRqbThSUFd6Wi9SMUkyVnNJeUZ0VW85?=
 =?utf-8?B?WjV3OVU0SEdHT25YVVFNL01zdk5SZmhSNHg4ejUvY21BQWdiYVZobGZkalhY?=
 =?utf-8?B?Nks3K25uV3RCOS9DK2Q1aFEwMlFFT29wZ1lqRWxqSnVuaG5uYUlEQVk2eWxS?=
 =?utf-8?B?SWd3akROdmNYOFJydllDd2l6SHlZZksrbHFOeVNSdlpmaEhwYW1ROVlCeTJ1?=
 =?utf-8?B?c3EwUHNvR0NtUEROWWJ5cHdXVVdrTUQzN3lJUUYxUEp6WTBzb1lDaFNWMCs3?=
 =?utf-8?B?VXhCWDRkZFlCZVB3ZFNJNnA1Z1UwNnRtY29VUlU1TTRHTjQ4dFRLbTZtUGJN?=
 =?utf-8?B?L0hBeGExa1NUQnV6TGNrSE1JZzJGeDZNWXg3Y2JyMklZZng3UHJwZVQrUDk1?=
 =?utf-8?B?Zll6NndTb1RFU0tQNE55eG5jN2RsdEFYalBXZG1PaEFmUDlYd1kramRVSVor?=
 =?utf-8?B?S0hoZ08zclpPckxHZ3piYmVwUm5saEh3Vy9qTTdXbGs4R3JvVjRRcGNIVXY3?=
 =?utf-8?B?bURUTUdDd1NsdzdCK1RyQjJJWXZBSm9DTFU3djNCdDU3dyt6clNHOXhKV29W?=
 =?utf-8?Q?pWqbSgSRT35q4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56219c-009b-471b-a596-08dbf03b326f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 17:55:24.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s4Mx1Zu8A2vR0aRre0wYZT8xV8lUk+jCItFyggMaPiGQpxQD/JlnNlYBl8mmKISsvO1SQVSoa7dR4I6mLXAF5el+vRohKDKf+WNfxbjsvwrjdFRI3MJIvG/k9ZgUo+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280143
X-Proofpoint-GUID: GWurYeJBfS9Zkdjw0dimmhMonHc_5RCG
X-Proofpoint-ORIG-GUID: GWurYeJBfS9Zkdjw0dimmhMonHc_5RCG
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

On 28/11/23 9:58 pm, Greg Kroah-Hartman wrote:
> On Tue, Nov 28, 2023 at 05:09:52AM -0800, Harshit Mogalapalli wrote:
>> In edac_pci_main_kobj_setup() when dev_root is NULL,
>> kobject_init_and_add() is not called.
>>
>>          if (err) { // err = -ENODEV;
>>                  edac_dbg(1, "Failed to register '.../edac/pci'\n");
>>                  goto kobject_init_and_add_fail; // call to kobject_put()
>>          }
>>
>> This will cause a runtime warning in kobject_put() if the above happens.
>> Warning:
>> "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."
>>
>> Fix the error handling to avoid the above possible situation.
>>
>> Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is based on static analysis with Smatch and only compile tested.
>> ---
>>   drivers/edac/edac_pci_sysfs.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
>> index 901d4cd3ca38..71a0d4b9c2cf 100644
>> --- a/drivers/edac/edac_pci_sysfs.c
>> +++ b/drivers/edac/edac_pci_sysfs.c
>> @@ -370,12 +370,14 @@ static int edac_pci_main_kobj_setup(void)
>>   
>>   	/* Instanstiate the pci object */
>>   	dev_root = bus_get_dev_root(edac_subsys);
>> -	if (dev_root) {
>> -		err = kobject_init_and_add(edac_pci_top_main_kobj,
>> -					   &ktype_edac_pci_main_kobj,
>> -					   &dev_root->kobj, "pci");
>> -		put_device(dev_root);
>> -	}
>> +	if (!dev_root)
>> +		goto kzalloc_fail;
>> +
>> +	err = kobject_init_and_add(edac_pci_top_main_kobj,
>> +				   &ktype_edac_pci_main_kobj,
>> +				   &dev_root->kobj, "pci");
>> +	put_device(dev_root);
>> +
>>   	if (err) {
>>   		edac_dbg(1, "Failed to register '.../edac/pci'\n");
>>   		goto kobject_init_and_add_fail;
>> -- 
>> 2.39.3
>>
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - This looks like a new version of a previously submitted patch, but you
>    did not list below the --- line any changes from the previous version.
>    Please read the section entitled "The canonical patch format" in the
>    kernel file, Documentation/process/submitting-patches.rst for what
>    needs to be done here to properly describe this.
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>    this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

No, this is a similar bug but in the edac_pci_sysfs.c file instead of 
the edac_device_sysfs.c.

Let me resend these two patches as a patchset and change the subject to 
make it more obvious(EDAC/pci_sysfs, EDAC/device_sysfs in title).  And 
add a CC stable tag.

Thanks,
Harshit

> 
> thanks,
> 
> greg k-h's patch email bot

