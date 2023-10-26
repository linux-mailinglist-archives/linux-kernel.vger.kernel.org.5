Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348C07D89BA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjJZUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjJZUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:33:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510461B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:33:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QJsfK8032413;
        Thu, 26 Oct 2023 20:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Eu7/R2D76u4koySaln9FLLoCdfpGmvdiTLBl6HCxt4w=;
 b=Fl0z/yaFJtSnCKxAVKxzA3pwrKMf3U0joBvsajB9q6kzLV9Unt+/lIZmDZLgZEQfeX+/
 oGld0faiyWRNSWHhO8Vwep9vfpSfGfHgf/G82ZuwhVSXnY8r1vyxC9J3775OWeSb0BaR
 e7nqD7YXc3pWfJ3YeflKrj7ldkFqZM2igXtPVaSTlaseksnmvDJVC0lKJcpozCW+VzZK
 XvZbv6xkdZoUFc9veOSUbg93pxlK58N0tp08bIYY+YYrwooozZes/8qd0ravxNChY1EM
 zyBN/4O1NWdXdPQz1qPe/cAWY2J0RuD1FOuVUv84k0csuDWquZOrBJvonduMy2SPMPwI Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx21851b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:33:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39QImmjC009162;
        Thu, 26 Oct 2023 20:33:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqhuqd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLaEaaFmQMIBKR1gynJRHBquVuee4/dbf9D+nn4I9Jx6Vn0UnjnPuCXoAbPVxk7wXdLVGndMDhC1yCFpM8nZKVCDUCq1hpLo88KGsLmjCHoF9W4vdWLJF9DS1eJKODFQjCidDTo2WgX6r2KqJyF5597yrLL/mlbkbVqSoDn6Q4/NAZ0ceqDITP5GH2RI/FqlpKNOcZK0AWsxj0UGGu2u6avh61CIc0xCUPQiS4X34grnQVUuIBhMrBjRON0HaNpUn4hjJ7opPKQigQXXe5BZUF/eZi7xCmkHA5Qy9XgTGe9wJzoqoAhe3VKG+Dbz3r3i+tKFj4E3U+FVGcmVoy7TIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu7/R2D76u4koySaln9FLLoCdfpGmvdiTLBl6HCxt4w=;
 b=LeA75aHErJgj4JYbWBqKM2T4af52q4+v+nIe/qblhegXPFCmndBRbhXsruMYcM2qQeQQetDo6LFX7jSZrNesTXv/Th65TnoMuMS8OnLyjWVjzZGnesak3ooBQBSBljpgriEBGoQG4Ig/+lpFYTyelhGKRP+0adI8x3uWC3sGnJXR0ENlJcE8JwkkKISQ+v+n2cyzcLcWmrlo7lk+I2pBlpMrLYkWa1Be6l+FBV6YvJekD7SppBVtDYX0v7xtyh9GMU2mTj/zXuuQhYv40fVkENcgGSe5MRNfA4wKcoonbe57QmvlclNAViCzaEJ3AEUKQppkD+/4f8m37N2aMNu8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu7/R2D76u4koySaln9FLLoCdfpGmvdiTLBl6HCxt4w=;
 b=ITn+MGET5CIICCLGhbsoX4awO1wSzm8YGWJAaFTD4W8kgHe7AIk/o2m1RDfQJ+o4C7uh1YAbMzPkXYIdOSiTdnEhxrqq8qrehSmPW59TEXbdmSE0/KfuNOj2POyREMqr4sZrDsCkqC/1UflFhVXz+zv8ZOlAvtTIM4z6Tv82/tU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 20:33:09 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 20:33:08 +0000
Message-ID: <6ccc182f-5b1f-43ee-aa61-db0bc9a3d1ab@oracle.com>
Date:   Thu, 26 Oct 2023 13:33:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To:     Steven Sistare <steven.sistare@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
References: <1698351075-415989-1-git-send-email-steven.sistare@oracle.com>
 <389942ac-962f-4198-b87a-14bd6dd3e188@oracle.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <389942ac-962f-4198-b87a-14bd6dd3e188@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: fe533b16-c7dc-4c29-1a20-08dbd662c3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +on1OMdpwfmr/ZQIkNoQ20Y0TS0hkKpTTUPwUm7mXVzQIgBuIDp/gV++sJfxORTNMkItpKKwos9PuW8mQsao72Ji1swhpK/w66jz/MWHnCy8O3CtL0M6v9Wmq5hs8D4uog4S4jxYVHMmmQRcujcPdlsPurY5VOALRxEMYo9x4cPF5ITE+tEW2MwMvcRrSNVF5mGfH9lxnbX1uoQO7HymSrfeew6Wla/pxb6Gr7pASxmndDZ9JjH3mSYvE0xKW+ui006yF3cGWzT5QStGglkhgoB0XKmQPRBVA114p1+WatgU2RtlUN4sL+TmHuoI7MAxIA3r8aByivdn9hrAsNH44ANMoGBqBQ670UJPO7kBbzoqImNOdWFgVTSkxS0EIHdwRmda15/Zfd38giVUm6MGH+6JqXiVwX64ZzOTqX9sm33L4B3pxGfZa/09cGIdRK9HQZIZeUoY+f4UxgmoEwqsqqpY1Kd7IQzWL2tmoDAF/IHm94N4fWLE2mWNl5MeB8XgH7q0W1nep74dz7K1XgJ8WhVMID9MSN/aAk9tNsUs4khHtLKOL30ybXwR1AOkJd1N/KT+f5hZgzN83udhCz2YkJgXhbXX1oYgct/LBqf0D3YzMBSOD15BYLxhvdfa5u6F9KvSAFAoqF1uGO7HiwpGEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(83380400001)(38100700002)(5660300002)(31696002)(86362001)(41300700001)(2906002)(2616005)(26005)(6512007)(36916002)(53546011)(36756003)(8676002)(8936002)(6666004)(6506007)(478600001)(66476007)(66556008)(54906003)(66946007)(6486002)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGlCbTlJdzJMbUFHMkZtaGJkR3JHZU5QajdKckpabEtheFlsL09ob0lnOWRw?=
 =?utf-8?B?TnJ3UXdFWkdzdEoyRzBTTHA4YjZLWmF0azJnRzNIRERYTXVOTGE5RkYvY1lB?=
 =?utf-8?B?b2ZjdU83T1JIYTNuUjdUZzlsemk3TUpFUWM1WE1GTmwzR3dwb0QyQlY2dWl1?=
 =?utf-8?B?L1RQK0dmeXlSeTJVVkxGWVZEWDM4RiszZXptUVl0QUNZNUhIKzA5SGZqTGRR?=
 =?utf-8?B?NWRGN04yQ1dqQUlHd2Nsd1VLRFppSVFrdkpkTEtWRGNYQ1gzaldySm00WnN2?=
 =?utf-8?B?d3pGRnpYckl3SFJHOE90cTRjQS9TT3F2TmFlTWZwWUNBbWZENktrN1A5T00z?=
 =?utf-8?B?WVJPTnM1UkxFRHFjU1lqbGxaNHg4bTRmRDlxWTdSSldVWjVZNC8xalFsakxJ?=
 =?utf-8?B?dVZjSVNxZXV1aVVrcUlFSGNWMWlBZDlBcWZxZG5tbXAyWHZJczJRdEx6cGtv?=
 =?utf-8?B?TEl1YlZvd1RBWVRNRkNjR2Y0TjBLdXlrZnUwVGM2MmxjQzVDKzdRVWxmVnBF?=
 =?utf-8?B?TUNIaUY2bGRiMkR0alcyVnJHR2hvRzVjUGx0YVd2ZmROcmVFcnJ5bG1ZYkhS?=
 =?utf-8?B?TVNlUXY5Mm5EMVgrNGl6LzJ2dVVZWWlTanY3YTZpaUlyK0N6NHpERjJnVHNT?=
 =?utf-8?B?a2tteVZ5RTFpaXdrM2g0VldsV0tVOUFBaENEU21SeEhMRTFMSWtsNllmVm9j?=
 =?utf-8?B?UlB4c0hhWlVEQ3ppRFVlNXZtckM5bDdFSDNzbi96SGU4bnhuWmdwUzFxMEdS?=
 =?utf-8?B?R2w1QmVZRUFUWXlBdjVDWHBheERlc0RuRE5LR1hnNWRUd0lLMjdmMFEwbUlh?=
 =?utf-8?B?Nzd6cTc5amZpUkFPVjhXWFdQSTB4L3NHak55YmZobGFEU1ZjdTBEZzk3SWRT?=
 =?utf-8?B?NlBHYks4MFE3b2poUWlyL0dlNkhBZUdpdVBNWkNqbDBtbUNTdklKUTJaVzhn?=
 =?utf-8?B?cmxPZXF0YmRmbWlBNU4wRjZ5alNKRlVsSXJLRmswZjd5cWtFckVTLyt5V1FL?=
 =?utf-8?B?SjY4VG9BYWxHTFcxNFhxRnQwTWNyR2tOYytTaXUwMXA1aEQ0Z0RvQTJYSjlz?=
 =?utf-8?B?ellacU91aWlPaWE3WjJZS1dsSDY0TExJZnkvNngrK3VmUFVIdUF6SDdDNjhY?=
 =?utf-8?B?c1cvT1VIM2FIbkcrQnVrUVptUll4TE5FMjdneDZQVVR4eXFjOGZzLzBFVTl0?=
 =?utf-8?B?Y1JmaDFtZ3cwK29jckhpdE0wSktZb1lVZG9uak96TFkySHdQZjNyNjg3Nmlv?=
 =?utf-8?B?cjdMSzJJalhHUnRZV0M4MHhVWWtGZ2xUUmdTazRPeldLWWV2OStQcHRHUFlW?=
 =?utf-8?B?MVI5SVdQbmdhUUpudXhGb3R5dEhZTk9CNC9LV0gwMGRkZnB5S0NYQy9wcGtR?=
 =?utf-8?B?K0E3akVXQ1JYVzR6UGNseFlCd0Y3YXFiNGpGRVJZMUk2bWVSTEppQWMxWTJI?=
 =?utf-8?B?eGExR29TRHJad0paVlFKVjJsNEtkblA3UnVIck51TE1PMkQ1S0xqMmJYa1F3?=
 =?utf-8?B?T0dXVnJtNXhYLzEvWklvejlyQmwxWmpSZUJjVzJLcmVZQVQwblI2L2JyVXcx?=
 =?utf-8?B?UzZjVHlGZG9VSHkxUnZKcEdNL0gzSEIzSi9hbmlGdlQ0alpJVjBrTzFWTElp?=
 =?utf-8?B?cVFaMjYvUWlTU0IxeEpKYVRzb2N0MnpVak92TDdPZTFyeDErRUlrU2ZJbWhu?=
 =?utf-8?B?Y3dVQzgxdmlBSlZKazlRVG9KU0lEU1QyVGxLUVlBZi9FRGVrQUFQNDd6Q0Zy?=
 =?utf-8?B?Q1RaczdTcjAvZnBhYXRsTktNcDhJSEZKd2xGWUxjNHJNc213a1lmdWR1MEtk?=
 =?utf-8?B?eDZoMkxnam1XLzJIL0tVblJ3azIrQnRLQlpBOXlqeExFc0dhMHVvdktjWEpL?=
 =?utf-8?B?c1FBc2tROVl5R1RPSE5iZmk4Q0t2dGt1ekppdEJYRStyWTVFUnNpVTczZytC?=
 =?utf-8?B?dDdLRkxwcEs3RmljWkcwL3czL3d0VFdYNHFUcWxaZWliaFViYXF2Yi9yb1dj?=
 =?utf-8?B?TGNULzJtazYwTVMvK1FMVjhuZERLb3AxeEorYUphUWJxakpEVkpQUTMxQ0VS?=
 =?utf-8?B?OXNUM2JZeEFBQzV5cUR1WloxMUwzNVZnenY1V2JxVEpIMkU4NFV6T28rN3ZC?=
 =?utf-8?Q?zI4+dqf0Hw8VQIreV7IB7G7xM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OHNDWTM4QzJlN0ZONVlTUnh2TFRSMTFTeTFjdGk3ZXdIQ0xNUGtSQnJrdDNv?=
 =?utf-8?B?SGFiK2dmYXN5QXlnZ2NNYUM0dVNQZTBNdm1HL0pzZ1ZHNXBaWDlkMUo5U08x?=
 =?utf-8?B?WEhPY2JHbnA5aEFjY2drdXR3N1J2SmxjTXVCNHUvTEFMTVY0MVdiTWxiRU9p?=
 =?utf-8?B?RzRacmVPQU5uUVd4UFlxeHF6ODA5Wnl0MThFbyt3TDJmOHFvbWY3LzFUMWE3?=
 =?utf-8?B?MldrUG9XUXk3VlZFNmxoYlJiRmlPcFdZaDBwblA0NlkrMUE4WUcyUmljWXNP?=
 =?utf-8?B?eklFL1gwT3NIVm93VVpIRjM0KyswRnhqUEo3cUxBS09LMVl0SlRGQ1pFUlNH?=
 =?utf-8?B?dXdnU3crZGFuNU1ZZVl1MklsazRrZC8xTUUzRTMraGhldzg5dmpRNCtSNW80?=
 =?utf-8?B?Zi9NbU1tdlBKWVlzeS8xeitrTU1FMXdRKzZBdnFIYThjemRDVTE0bm5Ed2pU?=
 =?utf-8?B?ekJUUEs1SVl6L3U3cFVmNUtqd3pUcXFReHhUSGFGMkR0VDBFczZBNDJsNm04?=
 =?utf-8?B?Qk5hVVFDZjFJcDBCb0FYS2ZCZThhVmdva3RydEgreHdhTFl4QSt5bEtDb1VR?=
 =?utf-8?B?NUNDRCtqRUtPRjBrR0RGNUYxWTZlQlZwUkhjdyt4NGdtZlFNZllhRnU1RWZm?=
 =?utf-8?B?WDkwc2ZPZHE5eGJlSzlUUkV4QW9yZmFZbFh0SmFFK01vVHdtL3FxVGt0eDhH?=
 =?utf-8?B?TlpCVGpoWWhMelNkcG9aUys1Tm9HZXJDZDZaSFl5L2Q0cXU4RkpCc0NUbElk?=
 =?utf-8?B?cHQ0a1pPUnh6Rk9zSENRSlNlNlJBL3NKTXo1aG9tSm9TRlJ4UnNjN28vT2xC?=
 =?utf-8?B?elczWnpreXdCWnpUTVR3THZQMGZsbm1Udi9ydEl1aG5nM0E2K0M1RVZSTGxI?=
 =?utf-8?B?aUlYMjhsN3YrYUhOQnkyM1hra0xBT1RiUnVCcytOaWRUL2ZGbEI4S3BxRmdJ?=
 =?utf-8?B?YUpoc2QvVFJqRVpabk5kaXFpOVA5bkFrVWNjVVVQVEJiYkVET3c3Yk1nZCt3?=
 =?utf-8?B?em1PTFcxQjRqTW9VMkFXSDR3OXBjRWlqZVhOQWFLbzBXd1FnbnlyWVhEc0I0?=
 =?utf-8?B?RFZFbWZLUW5KYVUrOGVSOXdaZTB2c3UrMU9yMDU1dzZyUmNrYWNPZWszV0g5?=
 =?utf-8?B?V3pMVFlCTTNRMXQ4ZGFyR3dhVmFLL2ZZVzJyZkNKU1EwM1JWTWU0UHRQR2Uv?=
 =?utf-8?B?S09Ib0ZkZzFsdnJQZ1lTWmo3ZlgwTVZCdVFMVFc3TUM3L3I0RXVNUFFWWWc5?=
 =?utf-8?Q?NF8IkkuzOJCATGp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe533b16-c7dc-4c29-1a20-08dbd662c3dc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 20:33:08.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWvyLfdpEl/z4Zap0gxprI9wEc3FkjHoaf/oW5GTBDPeah0to6LYa9Yn+aH3/Ypb9DdS+f5qh01mrmwM/8JMhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260178
X-Proofpoint-ORIG-GUID: HeITk5H6VYNdePh_hzL1F4Rv9b37sndd
X-Proofpoint-GUID: HeITk5H6VYNdePh_hzL1F4Rv9b37sndd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steve, I think this is a loose end that I myself am not sure if worth 
fixing, copy Eugenio for his awareness. Reason is that when CVQ is in 
place it always has to cope with device state saving and restoration 
using shadowed virtqueue for a lot of cases not just migration, and 
that's the reason why SVQ is always enabled for CVQ in the latest QEMU. 
But I agree this is a nice to have, possibly there could be value to 
support vDPA VM instances without solely depending on SVQ for e.g. for 
use case like memory encrypted VM. Thanks for posting the fix and lets 
see what other people think about it.

-Siwei

On 10/26/2023 1:13 PM, Steven Sistare wrote:
> On 10/26/2023 4:11 PM, Steve Sistare wrote:
>> mlx5_vdpa does not preserve userland's view of vring base for the control
>> queue in the following sequence:
>>
>> ioctl VHOST_SET_VRING_BASE
>> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>>    mlx5_vdpa_set_status()
>>      setup_cvq_vring()
>>        vringh_init_iotlb()
>>          vringh_init_kern()
>>            vrh->last_avail_idx = 0;
>> ioctl VHOST_GET_VRING_BASE
>>
>> To fix, restore the value of cvq->vring.last_avail_idx after calling
>> vringh_init_iotlb.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> This is a resend, I forgot to cc myself the first time.
>
> I don't know if we expect vring_base to be preserved after reset, because the
> uapi comments say nothing about it.  mlx5 *does* preserve base across reset
> for the the data vq's, but perhaps that is an accident of the implementation.
>
> I posted this patch to perhaps avoid future problems. The bug(?) bit me while
> developing with an older version of qemu, and I can work around it in qemu
> code.  Further, the latest version of qemu always enables svq for the cvq
> and is not affected by this behavior AFAICT.
>
> - Steve

