Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28E7DBF71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjJ3R4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjJ3R4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:56:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB35D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:56:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UHOHwd017042;
        Mon, 30 Oct 2023 17:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=znPj6Kl1otpRKnxzZknFRGXhJjgLvfq6lw8oIZ+a4z+QA+/oj4x/kV9uisTipkTKVsLw
 mZJB30uB2a2RkVrjbr6dIyaQPqMJ1V0jhc2ECt3x20dX6V7/dAlF4QW0FeqaCA+ThpEJ
 IvQID2ePh8lCn2AY7NN0ITI7F7UKcaPGO9iSsSDwZQf4bo9euab3bOWMQEHlX7leUhQR
 n0yElqNTYTeXepLbw0uISz4t6njBkJIJGJsQkuPRpaXviZuZlGP5MqSJg5zg0gvIaRk9
 iPTDjhsD6PuJAKvqC0Aisp6JWut9HF83MskbGukQ3di6/V4wTr7lCRqcn/FTD9xws5xq hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqduds2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 17:55:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UHNpiZ001008;
        Mon, 30 Oct 2023 17:55:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4yqp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 17:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwz+Wnv1xvSflArHYts3z1ZufzmEJx/VOdQbF8N8WZt6KrnhI6iSxe2kFL6Cf5EMmv7o/2yXzhNXKNYEaIj4GTwVX+5UHZ9c9bDyoPRDF/v6T2Khu7Wi32eZ0v9bLycW76gmBiDJga6GKbr2oLo8xwKH3+OFb5cd6R5vCKKe+wlusClY/dA4RNbjfsNzNn+C72wb4TjWAPW6BGSaFaXefAfAiZt6QafjETJu2+jaOTGoWpMEQGTjggOYvMK5rGMxcVGpVnmEmlekQsuGrXtNy9Nsgz3n2GXJipFawFTb0ODA7J7KOve6qYdPdddZbprGpft82z21ZK+O96lRKtBbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=cuTWrLeld08GuWnEHZ0qukpSVgS/juqcnrzNqIeq9Ys3jAnURfZfUj4oPX7fgxOSCd3mxNY5D2RBvSu3A9LK+q3iII/PfdhjchxUc64seZHBEo8s1wea2zOSXvb7/bZ0KGBK4j+3+PCCKr9RZ5lB1SQXbPLKQPhwjPjHpvVfp8OtG0KQPfSkLYS9fvT8C2yngiiNew6xwN3ql1yW/R+3H0b6KmquaYCW17Cm783o7hjVZCXWR/Z7xaqTXwIwpg+pMMhxzSWuqcftR+KBJZB7XD0OGKyPg6GIgXW5TotdDw1JvyZGBOG8hFDk6MHJ4q/eZbm5q5zGrVZcuttYbX0jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=aF6BimXYwOkyXSc1tnPj0HsgDARQ912bXoVjvdWJRhqpoy7O1pLKJanlUGWYEKGrKtI+x20QNsQmftSjCgLkFRzvoxq1QnAwQxsIt+8zShd3KJYUW7YIHGjcZOVxoLPBFMmUE4mPsVlN4QN2HLxFNO2e9jEqsDLz+HQgajly4sY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 17:55:40 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 17:55:39 +0000
Message-ID: <6fec5512-66fb-4d94-b225-1351e6d5e8cb@oracle.com>
Date:   Mon, 30 Oct 2023 13:55:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe7463f-e64a-4ef3-93a0-08dbd9716d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjqvbnpQ43n+3phmmrXXxBsS8dlLRK5rPm7ap+LVSwEyqiVtWPBNhaLB4HalLZZ0N2yn4woacYtpTYrEs3n38yHEtvPdzIR2DvF9WkpUKoZMcQ7oruJ1so2oyFJgi4bU5NKgSm6yfetL+G6G+37DNuroLP/yA6mkjhRJcNLjXpm7l6IWemViWfpOcfZywsR+bjQVF3LUl26yfAMO+oJB0H998F+Hoqr8ba/6rG4JVMcvAXrswz7+tJD959LjeoQ+gxVCKRNbGqdUub3nE5Y+yeNlfrq9AYZ3WTsFM9iK7O0sFVC+bLzqcb1iZVFy+lQ+boZBSK53jJGSxXDOx80Dc6OxetgzewHYnJwBLDCV+qOZMAzg5esqk+aADl4epIs6Os6cx/7NiJRMWFnfMZxDs864i6dyoYSrt7RPZh5TiBNerBF9Rb0uPOwjtusVnDrL/DFRVYLGy68n0l554YP6OdZLZKh4tWXEnp6rurlvvXt1nvdX+txQn/Tlm3MKcUXt0/gg/qDEO+6empldPESu67VG+quw6bPKR6y26DQqM5TyZ5u8jE0/Ko7WP4oAs+/jsHLlrXK1IfaoiUHSdV23uLT35yf20aIJXrU0+SWGVTfo8ByeISo94KTyXcCnwSwByUhNzmFxys5diRJOcp6/F6aSS0qMpxKhNKtOe6gbfpfYSpSht+Z8uQGotTAh/xBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(478600001)(6486002)(8676002)(6666004)(6506007)(966005)(36916002)(83380400001)(53546011)(26005)(2616005)(6512007)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(54906003)(31686004)(38100700002)(8936002)(5660300002)(31696002)(2906002)(36756003)(44832011)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFVckNjbnpITldKTTBNSGt3dm53MHlOTC8vQ3lQd1lTK1RyQ3RZVkk5M2ZQ?=
 =?utf-8?B?RCtEUTJQSGIvbVRNYi8xYWNmMmw3NCtYVnB3b0RjWEwzNFNtSE5QdDExUUJ5?=
 =?utf-8?B?Z2lkVkNaems3dFBGL2I0UzlBeG56cEd2UURUQlhiekZMa2Y3S2dYT3hqK1VT?=
 =?utf-8?B?MWF0MnpZZUVFbnFTWFdIYVJ0STBqcnh4VmpRanNVTHBqaG1OK3VTU2YxUlF4?=
 =?utf-8?B?cUxHSXJibkFpenF5NnA4eGlDKzZBQ0NoN2Mzejh2OU5iZU8yZUU4U0t3eTcv?=
 =?utf-8?B?bVVDV0ZwcVc3cXZXdjk3WjY5eHZPdlRmKzlHMXJVcWpRVHllWTlFb0Q1U1BM?=
 =?utf-8?B?VkFTbG1MTnlKRkRCVUFDalQxYWdncFR5UDFDS1hpK0w3NmZMaTgzYnRRWkxN?=
 =?utf-8?B?b0g2U1l2V2RRa204ZzZlZjFxeGx1YVlXYlVxRVo3TWVNVTdBNTBrRVhsdldN?=
 =?utf-8?B?c3hhRzM5Z3hURWFiNGN5c25BalB4SkNlLzBRQW5QRWFyN2l2a2VaRjkwNmJs?=
 =?utf-8?B?azZpelZ4Ry9mQitEaVFEa05RcGJSQ2tJSi9KZU9IU3NwYlBBTEh2WHI2Q1Jo?=
 =?utf-8?B?MzdqY1owRVBnbFR2aFdUVW9qZ3F3aS9ma0h2M1pxb0xuNStaeUhkTFBXZkhB?=
 =?utf-8?B?dlVCWUFrNTFsSHorVmZKT1FDNnhyc2MrUm9sQ2pOdjR2VElZZUlXYlFZZ2Zq?=
 =?utf-8?B?ZXJNQU14T0hGUEVVRmJPOFcxeVFjVnk0Y0VkQjlURkYrOFlEaHZlT0d2RWZq?=
 =?utf-8?B?REhvUXdSdjd2TWMyRjlUSHREemo2MnpWNXhoeEtseXZlaHR5c1JZWkVPNSsw?=
 =?utf-8?B?VUJFTExUQ1lPQnpZTUZrWjN1WGdDM1BQSFpYS1Ntd0EwTzZSZHlrYWN3Uk5p?=
 =?utf-8?B?M2ZlQ2lwdEpZOGdsdndWRjh1UmowajNmc3JYdmZ0dGlnY3dMYVlnRHozVVhM?=
 =?utf-8?B?aW5uMWVnakxOTHhVMDc0N25mVzczK3ptZjN0SkVibDZ6M0JHaDFEOFY2S0JD?=
 =?utf-8?B?bVB6alFJRUczS1REMzA4Q0xLOFd4eGNUZUhiZmUwc0x4RWh0a0lSYXJJUFBM?=
 =?utf-8?B?QUdLZHJTb3RSWnJocnhXK1hZRklPeUEzeEtJVVpTWUZuZitoOTMxRU1QRjNz?=
 =?utf-8?B?VDFRQ20xUVZ3REtWemNOUWc3TU1OM2ZtSXlDOUU2S1dBbXdwMExqOVlkZDh5?=
 =?utf-8?B?aTdwWm55R1hDV0NZWjVuNmlvSkl1ekZPdlRyeTFWalNnWmlQMmJTVlZDb3dx?=
 =?utf-8?B?V242Y2huZzRHcStUUzk3SGIyTHh0MHM4QVNqMlJNdjZOZnhXZERWelMxSUJH?=
 =?utf-8?B?dkQrNzVlVE4zaUhLMGhHZ0hRRHY2b1IxRHRlcURWRUplOENOZUNNSkJiUnpC?=
 =?utf-8?B?ek9iYnZZUytERUJGSFA0NlhDUnliUWp5SGJ4NTIvKzdQY08yQURkeWVOZGRL?=
 =?utf-8?B?emNCd3ZFaHMxR3RjNFJ0aEp4YkpCdW9WOTkxY3g0cy9lVXl1QUdjWHhXNGxR?=
 =?utf-8?B?NmVsanBoak9xMGVLUEtONVc0dThPT3Y4cTdibDBMK2tCNktJeXQzZWxQVCto?=
 =?utf-8?B?RXU3MzN3VjNEY1hvcXhHT0JBSmR1MkExOVM4THRabitqS1A0RE5kQ2NPcW03?=
 =?utf-8?B?S2J3L0VZU0l2UjJXdmVzNUliTkNaVnFSd0huVkx6R3J0UnBiS0RYSytKNENY?=
 =?utf-8?B?dlYrY2FYNjgvanBXc1pLdEhmT3U2L1h5TDliVmJBVUR3bi91eUh4a0xZcFVN?=
 =?utf-8?B?VTZ2OXhCNVdBak9EQ1IyQnZQaFV1UWhjY3FMaDVUSTNRV2lIWmNDM1M3MzRX?=
 =?utf-8?B?RzV0NWQ5aTJSWDhFRzM4NTFDd1JaQkFqS3lwYjlWWGUxQTJib05PZncxbHBM?=
 =?utf-8?B?cU1WWm4rZnpTaFpWUEsrWXhNRmFZMnRRbWJzb0haWEpXNmdod0R0K1BicVVl?=
 =?utf-8?B?OGNqS01KcGM0b1hQL0h6Wk5LZm9SMitidEE0ZUZHY0NPTVFqdk03b2VRUEQ4?=
 =?utf-8?B?ekRBWFlhODVHZHR6NXQ3MmgzV005TlpHZ1pDbXhCeDNXdWpaUXY5ejVDQlp1?=
 =?utf-8?B?eHpEYWI0U1Z3aWJZdGdwRm90d20rTEdHdmNaZGRWQklyRlowMGFTMEUrMVBT?=
 =?utf-8?B?VmowNmpEZi9kcm9hckQ2WHBpSFU5S2I4UWFiYW1BSDBVNnpjamloQ2g1d0FK?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MjlQekZLcTJkdkkreWlkSUo2OU5OZXplNHBSMWpzYXZsWVREVVBnU2E2Uzlj?=
 =?utf-8?B?bTJGZ21VelhCQVJCR1NBcUZiRUpkOHN2eTVSMmFlR29PdnBCOVUvNUNBRGxi?=
 =?utf-8?B?eDQ4N3BsaVkvWWsvL3RRanhFNWZ0L0VvV2lSbXlRa3NIWnRkelUrNTVmQ1Vw?=
 =?utf-8?B?dFJ0ZHF5SW95WW9MaUQ5SUxTeE1IUzRvL0dkdDE4Zk5PRkdwQ2dEbjBpYWpx?=
 =?utf-8?B?N2piQnBxeHhlWmZrRkpaOEpTZFpHWEdpQzZlRmgvUG90UVIxMnhxWVloNkhG?=
 =?utf-8?B?bTRJV3J2WURRWGhoSFUzME4zVHAzUlZ0RG1XU0VqMkdITHp4eVE1cnovUldi?=
 =?utf-8?B?ZlpuMkFxajY5a1BacHo3LzU5WlF5bXVZWEtZQnNiWXlJekxhd0NhK0wwNnFI?=
 =?utf-8?B?THg5N1lRVldIcXd3aHkwUG4xVXhGemlwT3lWb3RCMEQydmJSR1hHbXZhQWxO?=
 =?utf-8?B?b2Q1WUxmUWdTcTZ6NzdYeXlLNVZMVnVweDR2Z2ZiVnV6aUFvdTE2OEdYZkVJ?=
 =?utf-8?B?ZFhkaVczRVp1T3N1eXBZcitDNENhSVcrdnI3eUUrVmNkdlVlejJKVmMyRWI3?=
 =?utf-8?B?Y0QxRWdONnUvZUg2SG1jTmtKZXByTHdXZUN4b1lsei81STUzaS9VNzhXOTl2?=
 =?utf-8?B?RkpqYkNCQXZwTDhxc3l4amQ1NWFxS1ZRUkMwYyszQWMvL09CZlpvWXJyZzh6?=
 =?utf-8?B?VkhFNTlOdzlqMXk4Rit3V2tGY2oyT2xvdG9mb1dmbjdZVm9pcDhzQXgyb0xa?=
 =?utf-8?B?WWs5clBQR0c2bTN4Uk9pZ095eFRNK0pCUUh5NFRJUUI0SjZ6dDN2UllsMjhi?=
 =?utf-8?B?S2wzR2ZVTlovZ3hBZUdjdVkvR3pSd2ZZSFlTaG9tdkdGOThXUWhHclIyUkd6?=
 =?utf-8?B?ZDVBQlJDVGIyaHpicjhaZG92U29ZZVBjQzI1MnVsOUZBR29hdWJ0VVBrQ1pE?=
 =?utf-8?B?MmUxeEFkS2lsVld0Z1JqZDRkNlBRSlZWSWxXWU9sUEtrWVdKcGt4SlIzOGtL?=
 =?utf-8?B?SmoxemlSN0xxbkJkZ1Rha0lLc05YRFViL3dLYllsSWh2T1RlbXJiTUlDZ0gx?=
 =?utf-8?B?ZDRJaDRlNjBmbnpIVWRpQVV3a1p3K2xFRzJ4OGRiQmx6bGFjRVU2bFFrK2ww?=
 =?utf-8?B?RGM5djA1WXM3bm95WnlGQ1pxMkMzSVFrSElLd3JzYnVTQVI5ei9ndXNGRmFp?=
 =?utf-8?B?RnkzRG9jdHdTL1VCQnJvWFVYbGtJTVVyQjhhWTZPbXlOR3plUFZVcXozYmox?=
 =?utf-8?Q?PGFTCjS5NdzgtIc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe7463f-e64a-4ef3-93a0-08dbd9716d88
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:55:39.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqcme5xHmFNTU4inuydB16l/lNNwq4TTFA2Z3PJ6wjrTElWT3e/2XkYTTFi/x8dQuh8rB7YfZTJJ6J6eA/RFYovSRgIbpWgq+7igpV3nXDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300141
X-Proofpoint-ORIG-GUID: fkvzldiBVObLpMSSulEbVRBUUdpVHL3F
X-Proofpoint-GUID: fkvzldiBVObLpMSSulEbVRBUUdpVHL3F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2023 11:12 AM, Eugenio Perez Martin wrote:
> On Thu, Oct 26, 2023 at 10:09 PM Steve Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> mlx5_vdpa does not preserve userland's view of vring base for the control
>> queue in the following sequence:
>>
>> ioctl VHOST_SET_VRING_BASE
>> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>>   mlx5_vdpa_set_status()
>>     setup_cvq_vring()
>>       vringh_init_iotlb()
>>         vringh_init_kern()
>>           vrh->last_avail_idx = 0;
>> ioctl VHOST_GET_VRING_BASE
>>
>> To fix, restore the value of cvq->vring.last_avail_idx after calling
>> vringh_init_iotlb.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
>>  drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
>>  include/linux/vringh.h            |  2 ++
>>  3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 946488b8989f..f64758143115 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>>         struct mlx5_control_vq *cvq = &mvdev->cvq;
>>         int err = 0;
>>
>> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
>> +               u16 last_avail_idx = cvq->vring.last_avail_idx;
>> +
>>                 err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>>                                         MLX5_CVQ_MAX_ENT, false,
>>                                         (struct vring_desc *)(uintptr_t)cvq->desc_addr,
>>                                         (struct vring_avail *)(uintptr_t)cvq->driver_addr,
>>                                         (struct vring_used *)(uintptr_t)cvq->device_addr);
>>
>> +               if (!err)
>> +                       vringh_set_base_iotlb(&cvq->vring, last_avail_idx);
>> +       }
>>         return err;
>>  }
>>
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 7b8fd977f71c..799762c83007 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vringh *vrh,
>>         }
>>  }
>>
>> +static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
>> +                           int (*putu16)(const struct vringh *vrh,
>> +                               __virtio16 *p, u16 val))
>> +{
>> +    int ret;
>> +
>> +    ret = putu16(vrh, &vrh->vring.avail->idx, idx);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = putu16(vrh, &vrh->vring.used->idx, idx);
>> +    if (ret)
>> +        return ret;
>> +
> 
> I don't think VMM should be able to modify the guest's vring memory.
> For vringh it should be enough with the next line, no need for
> previous.
> 
> If I'm not wrong this was solved in the simulator by [1] and [2]. Am I
> missing something?
> 
> Thanks!
> 
> [1] https://lkml.org/lkml/2023/1/18/1045
> [2] https://www.spinics.net/lists/kernel/msg4705724.html
> 
>> +    vrh->last_avail_idx = vrh->last_used_idx = idx;
>> +    return 0;
>> +}
>> +

OK, that makes sense.  I just verified that the idx I pass to vringh_set_base_iotlb 
does indeed match vrh->vring.avail->idx and vrh->vring.used->idx.  

With no need to putu16, the fix could be confined to a few lines in the mlx5 driver:

setup_cvq_vring(struct mlx5_vdpa_dev *mvdev) {
    idx = cvq->vring.last_avail_idx;
    vringh_init_iotlb(&cvq->vring, ...);
    cvq->vring.last_avail_idx =  cvq->vring.last_used_idx = idx;
}

However, I wonder if re-syncing with the guest values would be a more robust fix:

setup_cvq_vring(struct mlx5_vdpa_dev *mvdev) {
    vringh_init_iotlb(&cvq->vring, ...);
    vringh_sync_iotlb(&cvq->vring);
}

vringh_sync_iotlb(struct vringh *vrh) {
    getu16_iotlb(vrh, &vrh->last_avail_idx, &vrh->vring.avail->idx);
    getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
}

- Steve

>>  /* Userspace access helpers: in this case, addresses are really userspace. */
>>  static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
>>  {
>> @@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
>>  }
>>  EXPORT_SYMBOL(vringh_set_iotlb);
>>
>> +/**
>> + * vringh_set_base_iotlb - set avail_idx and used_idx
>> + * @vrh: the vring
>> + * @idx: the value to set
>> + */
>> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
>> +{
>> +    return __vringh_set_base(vrh, idx, putu16_iotlb);
>> +}
>> +EXPORT_SYMBOL(vringh_set_base_iotlb);
>> +
>> +
>>  /**
>>   * vringh_getdesc_iotlb - get next available descriptor from ring with
>>   * IOTLB.
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index c3a8117dabe8..e9b8af4e6a5e 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
>>                          struct vring_avail *avail,
>>                          struct vring_used *used);
>>
>> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
>> +
>>  int vringh_getdesc_iotlb(struct vringh *vrh,
>>                          struct vringh_kiov *riov,
>>                          struct vringh_kiov *wiov,
>> --
>> 2.39.3
>>
> 
