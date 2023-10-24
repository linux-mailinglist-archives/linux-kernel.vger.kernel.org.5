Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71747D4FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJXMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJXMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:30:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB40D10C0;
        Tue, 24 Oct 2023 05:30:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJMQK015996;
        Tue, 24 Oct 2023 12:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=M8Uuz8bdELZ9T+76KYyJg6GjwnKBtWysklFa2QxnLf0=;
 b=KI1JaalNJfyhxc8kF7b/YAWe1AUI8d572RfpRXX2/6MjYGobs1H0GGwPjKk8MAvC30wq
 sH6Xhfw5V8hLHvUcn1T81To+QJjLove4lf8aw21slMiiGdlHqWuFf6R6Y7Ktc9kKFH0a
 yPpOhNdZ6e7vN9QGFkLmESBKkJfpewIPZfdWVGX8aNqfBv1Y8rOENU+2uwctQ6HgsmP+
 F2FM1Ds/k9+pFRUkRGGW6OsethX/Fe9WXbv4B0F8o5ksXsNAYCW1mGomVzkR20Y7WUZC
 7s1AtvJQqJQ7QJYK6BBA9cq9elszLH1DwKCHJ9Pdz/xVYuDE9eb4w9P9pEPJq5ZnJT3/ ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e35bft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 12:30:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAUtCR034774;
        Tue, 24 Oct 2023 12:30:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5356d12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 12:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAhREou3Umy6gxLpl7jno6uPEN0DwmZKp9Wq+yT1YEAiNAsP28FIQPkBEzjD2oux7PeJ3bnKMQZmKrITa+fiYMo5V9Bd3GAqwQKuNnGhL/RfnS+Kh1oREUQsUbQyJIhQghNYt30HV5JIAzys0Yr8d0k5yfhlJpjjiefGAIwsplUWmSKGdtSoUQmYqoraUEH297Gh8ZalIAqWNxw39kvayhb6AvT71u7MjuqzIl3hRAsFYrb4M6iDGp1ebSERXmphB5CZWm18wtqL5ZORcbs82H1ersSTOeUc1QKoBMZQcsLP2JZn4zIEmVVIUDttDppHPM9o+UoSENE9x3tPW6/E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8Uuz8bdELZ9T+76KYyJg6GjwnKBtWysklFa2QxnLf0=;
 b=Wc04rJBt/iHrFiykmo+5zask7eHQcfksBniRuv1a0mZbwZ/Feq48CyAPobFb1Tn/xZ+TeIKXYTJuHNJBHcff3wYMGyw5VR9yBa6ijHPm4Zam9sqKlf8edHIlVY17MgqPuaZnAlV8tHcPRJrkrVs31VvVSlmL8w321FXiEbgwYfT/gKmi590WxozRWe+NGCR8VE6+r+0bh+ZoO/rfgujh9YZteaTmkQD3cKtkFEIr5olYlFzw4Nnjz2i3lUV7Se9DEwcMuodNsnv8XpI4qVyjluGcsMHEzj7/AVPyiR3U13Nft/XRsbFNoW0k+PGPGVKUbzR6UPrTYbem2WrfqPKUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Uuz8bdELZ9T+76KYyJg6GjwnKBtWysklFa2QxnLf0=;
 b=S6/T7SlTf8Q6fJ0ifbHavCFdNONYZFuSnHR0ngwGnwPAigUKDFlsss7TwnXiv0u2wEvzGXIUfnVVsyV/lops87JUOzOTkuwRd54cRfizmphfPOOM9Wkw6tT4eU1ONkkykAA5dikB6lc2J4v3uToZMzDbQlYc2zRgTWP3cGryquM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 24 Oct
 2023 12:30:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 12:30:07 +0000
Message-ID: <0262fed7-a70f-8782-628f-2e9ded0108f8@oracle.com>
Date:   Tue, 24 Oct 2023 13:30:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, david@fromorbit.com,
        himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231009174438.GE21283@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c168fc-3b8f-4dd9-3b52-08dbd48cf4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hBSGGwCcg/waRvsdD+rc/ESUyQIcbhwVBxJvfNinKsE6MfvfHLXKrsDoZTDgoXiFwlRv4T9BDi89l9/NlUBWFDFrYmJOwsTVibwVZTSk0o+YrlS76UhkM8u6BdSKHisyTfeEgOpsY8EeY31D7tnqSoqNvnYkRLPevqhJVYjr4EcrHV8hCI7GA9I9y4WO9NUkwQFBQvsavO/68UxGzbruukFCgaFByhVxW2XskNbRAL5HTYqPYtoSDeGa9HFMJ1yfy1/PIWZDMuDSUSpHx5ztTGyokZ6qVzgzhLt4wpshA/vNmuY+MV9DZ6SBRh/uKqSHO4ZAQgOWgx9CEKcEyepfZ8/O1Ven9ri8XyQc68eE5hfIvwuVuI/zuW9FM6DM4bw/uyWAtoUYM+1CNCrMnsdcYJLHVmck7ACoetcrPMEt/sg4c3ktDV0asmWPR01ugFd1aQ2AXUIIhAgA8hCZ/j872eUlJL0hDkOZ/oxafSVbm9XvHDq9ly7uT4fi4Jea+ZM30qmIPWy+kv4fwHXOyk39LBGWKZ4XeF7V1A38GNYhIvRrHqGnIlfb6y1v21pOTkbeHTjrP9LH9KD6dayOQn368JiSuku9RUgXj0a2Lc2ry4/x+LSTwH9kZ6RdSTahzj5miez66JqxenYijstUmlNTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(316002)(66476007)(83380400001)(66556008)(6916009)(66946007)(86362001)(2616005)(53546011)(36916002)(6506007)(107886003)(31686004)(36756003)(38100700002)(6512007)(8936002)(31696002)(2906002)(6486002)(5660300002)(6666004)(41300700001)(4326008)(478600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZrZE01bCtubStrU3RIV3prT2V0UXJDaW9ITkxHOVl4ZWdxaHlvK1BGSVJj?=
 =?utf-8?B?cWVaU3R3RkUxR2duaFR5aHY2S2d2VW9qb2lOVmdyLzZ6U2NQR3lVTms0Tm5X?=
 =?utf-8?B?QXljNDE4ZGg4NFhBKzNXSHBnN09Xb2lpVUo0Y2hUendBa0Y1M1kvMWNtUnEw?=
 =?utf-8?B?dXE5TVBVbnZ1SlZEZ0I5K0xZeTZNVFhXMERVd0ZVMU14ckRaZWhuK0FTUGxN?=
 =?utf-8?B?TlN4MEVHbTlCS3VMd05zWXBGS01lMnlwdndnS2NNaVFVck9wNXZnS1RidG50?=
 =?utf-8?B?Z3pWRWhUaG1nUXB3c3VsRTk1d1puVjNXUFN3b0ZPRzhGbGFXN2EwTDhqeG9n?=
 =?utf-8?B?VVlkazNkM3o1eVVsOGNNdGdXaHlDanRiYTRVOWVkN2JuV0o0c3FvK0NjUWFT?=
 =?utf-8?B?YTdWcHpCZTJMWTNuRno0d0hFb2xEUTFOZVNoOFJSV2gyMlVPUEhWYmVLNWlp?=
 =?utf-8?B?RXlReWJKYVkrZ3puUWJxQlhsZWlHMHBsaEVJQTNxWDMydVdRMkZsclVZL1VB?=
 =?utf-8?B?Zzk1QmdRWXR5cWRPSVdYT2swN0FObTc4RUJUVHE2NVZOa3p3UXFhekFhZzJr?=
 =?utf-8?B?QkdvZVVuY2cvM1NCSWF4Q1N0Tjc2SnJGa0NrekZaWTlzMEVVUm9hVEZ6eFRK?=
 =?utf-8?B?Qm1tVSt2UDlIbGc3LzdJWnJadCtBMkdJVm1rRXhINGxSbTlDYkZIdHFwSXF5?=
 =?utf-8?B?TDFnNWpDRDYvVzlyamgyZUZXNmdJelc0elJKekh1OENHM0FCcTJRS1hHQVds?=
 =?utf-8?B?RUZEZkRBWFQwRkxsQmN2cXQvQXZZS1h3Umw5ck82SVpmNjNzMDJyQ3RxeXZU?=
 =?utf-8?B?NXArU1RHbnVxQ1MxcVhLMDJ5UGR3ZU5pbUF4ZWlxM3VGSDVqQVhZeFlWRGo3?=
 =?utf-8?B?cjJsdllSVCt0YVVKRzc0TXFNbmlYS1EyV3V6OENjMkRpUnVUWFlyRVFLNnl6?=
 =?utf-8?B?Tjh2ME0vc1QwOEgwakdEb1JzSFZrd25vb2pJWUFBdWY4ditJNnpOOW02dC9T?=
 =?utf-8?B?YStjeit1eTVXaFBDbnVTZS9ZSG5ua0ZUN3VUVDN6OGxwS1AwMGZIZW5TRDEz?=
 =?utf-8?B?Z29GZlVBRUxPdDBVK25waHB4QXI2SDBNbnJhOVRScm12MTNGYTRSYTVMYlRs?=
 =?utf-8?B?VXlXR1hzWXhLa2FJQmM4K0d6akJUc1pIc0VaaGh6SXNzQTk3WWZVTlN4RTM4?=
 =?utf-8?B?aGxEMDdpZmJuN2ozVktOdThuV3ZKL25NaXlEaUxwTEtMM3N2OS93TkNSRTZv?=
 =?utf-8?B?NUtOUFlJQnd2dDNNZHkvU3VKVEowaG1WZ3ZWeWdCaFJZaVowWHF5bWFIeVZr?=
 =?utf-8?B?MHduQnZFL1Z1Z1JuSUwrY0hmNzhlNmRzNTV1a3hRVEhrYXlSbXNHYWtWemFs?=
 =?utf-8?B?b1dITUcxbkdUUm5KKzZrVnExaHNiZ2M5enh4NlFhemNEOGJWeUlJWXVwTUlz?=
 =?utf-8?B?cWlKVE5jZE5YbE82M0x3emVyYWh1ak5HUUpNNENqelQ3UlBiTldITVdoWFJJ?=
 =?utf-8?B?eElacHlVQWw3L3BJSkFmakVYc2daSWh4bE1QNTdVUXRVQStnbEp6QklKRjJz?=
 =?utf-8?B?VXJNY2ZTSjFrMG12dW1PS0hKQW5CcGRobWQvckk0VVZRU2RCTDhYbkYveURD?=
 =?utf-8?B?UzVpVVg5VzdSckNrUkZHR0lSQzNoQ3FJU01Cbkg2OStFU0N6VHF2UDZJNlNW?=
 =?utf-8?B?dy9GeldPdCtvekFOcnN2STl0a0pjUmx4Nkw5MVhhdTNRbkxxMTV0NCtPaXBX?=
 =?utf-8?B?VGJCaGxtQmx1TWJ5YWd3N3B5VWFFSENUVVdSZDdrUE02MlFQVnNzTWNDOUNR?=
 =?utf-8?B?cHlJRlNJWDZpaFpkYWNhazhtd2tIN2REc01HZUZMOHoxZE9YSXZJNWp0Q2Va?=
 =?utf-8?B?SVZlY1VPTkpWODl6WTNjVkt4Vi9SZXBIZGxzWDZtTXVnaHpEQ3ZVMHFqc1Np?=
 =?utf-8?B?eTdjN2JFYk0vREp6YXh3Nkt1cU96ajFpcmFkVkNiSFYyOEUxZnhwQTVxWjNz?=
 =?utf-8?B?VTRGcDhWQldTRXllMnIxRnZObUt1cERTcVViWUxWN3c5STU2ajN0WEpUOHNr?=
 =?utf-8?B?cmZaUHppUUN0bFpzZERUTkZoM2YySElZK2JReEc3T0d1WloxanpJUEpVaXBF?=
 =?utf-8?B?dWk0Q1NVdWRwZmNpNHlpekJvTVFGdU9jbFE4K1VLSkt3WmNsQ3hMdUZiSFdh?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NpiXTUCDW/rINtmDQeRiM7m3pUOxFI2zPn09M/C5it5XOmFLPs6m4bt5EOlCs/a8kxYkFHGIJd0jUQo6vCEDaekAX+uiRzaX5rfiYEkamK433noWTyP1XHiZOv47jJXA8HpEUKIvoYBn6YiHB8Hgni2v0odo860UlgDY9I7REDLoN/qn7dAaX0f2HmE2HeBO+4Jw/NBzkxIXGGN/MfEtGgTOkO+Adjfe4JEnNPiH16uPI+ZBMX/cKQh0c/lxwIpO0L28s5GJGIRGCSldXfyScitAfFsuoWnvT3tyVbzvrQjDtbmucXP3nbx2xYAjWk3ebHzvvSE1VqcNxFDYT3GmeXZpCe5Mg70QSm9+Bf2cKLmFjdkjACPYCvnnDrLyRKCYyvGk/koY/iRRepMAH7RIwNEJMUowxhZ9//4Lx2t6rEtHA1y9gtwjRdcf/NLofHfHbEdwLhX71pFV0fQ6W0uQEoPeFyYfn+aSd4Tjeo/aiTozCQDF3vBRqVWD+/0m0TQKCSYFJNIEqKYxeZyb4YrBCqnFy7NNiWOLQ2a9Q3Xgt8eJYi/pWvBpdFHtX892LyPr6O9PsbMKuj6dF41FZm+MI0regv/qcfFpou6s+YzIMSlt/p5d8BOkpcJ4X1Lg1NbwlAlnjc381qtm+WEj+9/8be9RyJUUuwPjhQlTzp5fzdKojkQv5eJXLXsJwzKyUdzCaY33E4hnijqL/Og0e58/tBUB3h0+qJfGX5FzVfXxcFtqvut0CtfCs8GV5f9WWaQ0Sr89TXbA9/L8T8PnV/shtyz7Dqd9dSDQUoNOHNLeK8KSg+KU3IJBAp0CVxkak15LdPwolIUo93GLKwyT20sgRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c168fc-3b8f-4dd9-3b52-08dbd48cf4ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:30:07.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NraHlZuwqQS7Pj7IX6WddnZeQ/tPJSH1TAbJzYga6gDynxAqbidvJ7gnVFENlOAQPmLA3BDqxFjqK2mYdaAK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240106
X-Proofpoint-GUID: sjNVi8NUCmM2rTlNkukunIbah73ti2bM
X-Proofpoint-ORIG-GUID: sjNVi8NUCmM2rTlNkukunIbah73ti2bM
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 18:44, Darrick J. Wong wrote:
> On Fri, Sep 29, 2023 at 09:37:15AM +0000, John Garry wrote:
>> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>>
>> Add RWF_ATOMIC flag description for pwritev2().
>>
>> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>> #jpg: complete rewrite
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/man2/readv.2 b/man2/readv.2
>> index fa9b0e4e44a2..ff09f3bc9792 100644
>> --- a/man2/readv.2
>> +++ b/man2/readv.2
>> @@ -193,6 +193,51 @@ which provides lower latency, but may use additional resources.
>>   .B O_DIRECT
>>   flag.)
>>   .TP
>> +.BR RWF_ATOMIC " (since Linux 6.7)"
>> +Allows block-based filesystems to indicate that write operations will be issued
> 
> "Require regular file write operations to be issued with torn write
> protection."

ok

> 
>> +with torn-write protection. Torn-write protection means that for a power or any
>> +other hardware failure, all or none of the data from the write will be stored,
>> +but never a mix of old and new data. This flag is meaningful only for
>> +.BR pwritev2 (),
>> +and its effect applies only to the data range written by the system call.
>> +The total write length must be power-of-2 and must be sized between
>> +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both inclusive. The
>> +write must be at a natural offset within the file with respect to the total
> 
> What is a "natural" offset?

I really meant naturally-aligned offset

>  That should be defined with more
> specificity.  Does that mean that the position of a XX-KiB write must
> also be aligned to XX-KiB?

Yes

>  e.g. a 32K untorn write can only start at a
> multiple of 32K? 

Correct

> What if the device supports untorn writes between 4K
> and 64K, does that mean I /cannot/ issue a 32K untorn write at offset
> 48K?

Correct

Do you think that an example would help?

> 
>> +write length. Torn-write protection only works with
>> +.B O_DIRECT
>> +flag, i.e. buffered writes are not supported. To guarantee consistency from
>> +the write between a file's in-core state with the storage device,
>> +.BR fdatasync (2)
>> +or
>> +.BR fsync (2)
>> +or
>> +.BR open (2)
>> +and
>> +.B O_SYNC
>> +or
>> +.B O_DSYNC
>> +or
>> +.B pwritev2 ()
>> +flag
>> +.B RWF_SYNC
>> +or
>> +.B RWF_DSYNC
>> +is required.
> 
> I'm starting to think that this manpage shouldn't be restating
> durability information here.
> 
> "Application programs with data or file integrity completion
> requirements must configure synchronous writes with the DSYNC
> or SYNC flags, as explained above."

ok

> 
>> +For when regular files are opened with
>> +.BR open (2)
>> +but without
>> +.B O_SYNC
>> +or
>> +.B O_DSYNC
>> +and the
>> +.BR pwritev2()
>> +call is made without
>> +.B RWF_SYNC
>> +or
>> +.BR RWF_DSYNC
>> +set, the range metadata must already be flushed to storage and the data range
>> +must not be in unwritten state, shared, a preallocation, or a hole.
> 
> I think that we can drop all of these flags requirements, since the
> contiguous small space allocation requirement means that the fs can
> provide all-or-nothing writes even if metadata updates are needed:
> 
> If the file range is allocated and marked unwritten (i.e. a
> preallocation), the ioend will clear the unwritten bit from the file
> mapping atomically.  After a crash, the application sees either zeroes
> or all the data that was written.
> 
> If the file range is shared, the ioend will map the COW staging extent
> into the file atomically.  After a crash, the application sees either
> the old contents from the old blocks, or the new contents from the new
> blocks.
> 
> If the file range is a sparse hole, the directio setup will allocate
> space and create an unwritten mapping before issuing the write bio.  The
> rest of the process works the same as preallocations and has the same
> behaviors.
> 
> If the file range is allocated and was previously written, the write is
> issued and that's all that's needed from the fs.  After a crash, reads
> of the storage device produce the old contents or the new contents.
> 
> Summarizing:
> 
> An (ATOMIC|SYNC) request provides the strongest guarantees (data
> will not be torn, and all file metadata updates are persisted before
> the write is returned to userspace.  Programs see either the old data or
> the new data, even if there's a crash.
> 
> (ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
> updates for just that region are persisted before the write is returned.
> 
> (ATOMIC) is the least strong -- data will not be torn.  Neither the
> filesystem nor the device make guarantees that anything ended up on
> stable storage, but if it does, programs see either the old data or the
> new data.
> 


Will respond to later mail in thread.

> Maybe we should rename the whole UAPI s/atomic/untorn/...
>  > --D
> 
>> +.TP
>>   .BR RWF_SYNC " (since Linux 4.7)"
>>   .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
>>   Provide a per-write equivalent of the
>> -- 
>> 2.31.1
>>

Thanks,
John

