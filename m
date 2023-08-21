Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884957835D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHUWbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:31:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F9130
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:31:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxu8m013645;
        Mon, 21 Aug 2023 22:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=CE7oFlAsxNQPA0dFsMJG4SRQUbNneS/SWWRHnPpLCThmyYcRsYwY993uKjv4dWCccY30
 ozCupgNfzmo88+J25OoyHmoI1fFDRM9o/ZiR0hppNMXmQEXKLAIWCmygBIJfbfO71P3d
 ztao6wI1sT6lADAg97B3ytNASd9vC3n+30w/FJM1jUO8ItJFONwNq7PdsjdYeY64e5R+
 JQ6WvU//yucxmoxJqPvFXyNIzRasjmc0Z+fDYxDNolE9BLJsF21mAv0smJq3GdGOICBF
 DEIgGNl1E9fPp2rMxtku3mM3rzm98zj+L137KYFDQhAbTyye0CaHFXl4TSlHTQAcbN0A 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1v1ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:31:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LM13r4008022;
        Mon, 21 Aug 2023 22:31:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm642x43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEpeUepZc6fukHpM4PgPwnW/66NH6lhuXzpfWabY+o90mjVgW5K9z+3NfSXAAXk4Iaag5mIc5ytl1L7ExEQoRafaU5eX5uW+BngaKdEImtDbAP6hP0EApgqMzA58x9BzxmsjvELgSZBSTp7O4eROgEkw+RNCQ0HIPn++6XYvmYj6R8TWkW7PSzGERjbw0X1s/J52f8MhFVyA5SZw2V1LzqlpQXStJ+ly1bXZuZT/42uapkqep4UdBn1aAmTQ9+2i0n/eAsC6C48KqhSNbVuR6dEhku1bxmLasz1qlssSE3/+ueJk+nxP0+FYWioNAUu3ONs1eZFqxX2uKaseXMWdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=DvRwNSDLStYQShh8r/dRVyfDmXKje51QRWVM5pKGfL9eQT8t2UIcfrpdVCpVHyldXWdvT93leam3l+C/IIxdIs7IXFbEi9HRrNnIeUAbSdgSXCM3Zdtkm9R1S6Wu83vQRcWXlOe3HLbuy028ucGtTruMkFsWnOv8zxf/OYcZrly3kBsV6XWpi3EpQS47dNHBOu2J4MhQKpLSK14lBCamlvX8rkSnKnOw88b1ckH33zfhAi+MzOJ7ohE8S6rV2V9M3vvU7u+FbmdKGtmECV4SY/bTo8QsVW15bzTZ6SwP5/Yj/nonaARebFR7I9vjQwizifHmxjBV8Wo1SxC9Al359g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=hvR6Y4q2aDlrPq9TF1NQxmrpboSE+hzUUNYu3dppYkZOZHr84K57N9mAZmz/CzqF0qBfoafA7G2ZqXatbbTlEOkOB6eZCSUg2nnrIrYChSCUzHPKagxk1ZbH4iqQsuosCTybPq7dTPosFs4dHhx3qK12spUyVEt5s9cjqhPwB6Y=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB7738.namprd10.prod.outlook.com (2603:10b6:806:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 22:31:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 22:31:32 +0000
Message-ID: <e1b5461f-15a5-6647-6473-80b3e8defc48@oracle.com>
Date:   Mon, 21 Aug 2023 15:31:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, gal@nvidia.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
 <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
 <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
 <CAJaqyWeC=G7fbgvmyCicnuGLYD84G5+b37tVA1KqzrSHO_AGDw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeC=G7fbgvmyCicnuGLYD84G5+b37tVA1KqzrSHO_AGDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb81dbc-0658-4d55-98a7-08dba2965edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATMEdA5ZT5MYvgKNoSrMNSDTaEBMLS/J8rcpGt73gPpHkwDoDchnUxXmqx8FNRwiZOXGqr8cmKc0kckEUJDHQLPFFS8JPmLP4b5D6higY6M1aat0ag1s9nrrzCyw4U3+PoGvUOI0cvKZdpgL30Ok7yXOyqL8213N5GhxEWUQXNQVbtCOOQUfXg7n2LmCy0yzLc7K+wWSZ+SzQuIR9x0aXln5CbmmkgGW68888XvNPSlNQ5qNG46qUdeq11A3rlsDKBj2p6iDGJpp2qTf2kd63gX+wleoqVxifNHeAJM+Dt7Z4mX/naPjSTQGRo2nKp/myQfZEyBm8JvLYWU+pUYQT/s08c8fP0llsZ5S+rJelBqaFJ3+q0K5oX4DnFpirIytf95klNhYR60xxh7p+RonCQX6w+SPUC+/b/tOTTUwrrxm8fNy1oAlA7T4LK4mGdMTCPgh7NrrRMrRtAMdDOQcUCHCyeVMSQQ1aR61iKHYHwoMTGWQ0zIHdiocEaMlY33UiJrOjt2kTFSBW3rUtyX38T02Ih8OcNCh0YfRl9tbT270Kz9jbjXOdNQCpx4LvrX3D2W6ZrEF6Q+Zs4KhZzX1ZoqQF1IaYnOH7ZKbSq7deuBZKvc+YO66FlAvnDPKKI499nxettdPI/DpG9wWz7wB4xD6Nv4SjkVaFEV/KmXZegxfIbPS1XQxIlMw+DkhALSb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(5660300002)(66556008)(2616005)(41300700001)(66476007)(2906002)(66946007)(316002)(6916009)(31686004)(8676002)(478600001)(8936002)(4326008)(31696002)(6666004)(6486002)(36916002)(53546011)(38100700002)(6506007)(6512007)(26005)(36756003)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWM1OHNUaHBEUnpsMk9Hb0ZPY0Jla0dRdW9xVUpDeUpvaDlJdmVQWnpHUW1r?=
 =?utf-8?B?QjM5TFppSnR4TVMwdlRISFhESnRicWQ3RDZVL0ZZejFMOTExQ0FqL3FNQStZ?=
 =?utf-8?B?Y0dIYjZXNEd1SWFOL3JtUXRFenVOVFJjekRYbTNNeXRJTUFqNG1HNjRoMDR5?=
 =?utf-8?B?aDFoNVM0aVVQNVhRUWdZR01VY3Q1VXFPWDdlTmMzMmlqbktOOTlTWFJLNkZk?=
 =?utf-8?B?OFBDc2xtN0szTW5VQmpvK3lFbytmY0VjQUUzbXhjUVpyMGpjd2FiaVFtSldY?=
 =?utf-8?B?bFFFL2krY2syZUkrZWhOazFoZHBHOE9jV2JXbGlQQm1RODhqZkY2YXpvUG9p?=
 =?utf-8?B?R3FCWVJQU0dOMzhkd3lOMEdzbVhJMUo4MXM2SXBPZ29tTnBKUGpwUVRzVS9J?=
 =?utf-8?B?cVFEQUs0U3N4dnU2NmlVcGwrWXgzK0xZcVJEOCtJbU1oNDYrUXdBdmFuRnk3?=
 =?utf-8?B?OVI3MVNybCsrWUJRWDFGUDZJRnk1eU5heW1XT1dmU1pleUZBZXNGdzVVd1Ba?=
 =?utf-8?B?SEdKMFdNaGI5VnJOdlJ1Y2RKOWxDYnlNTnlyUXZYdXhHOHB5cWo2K1JML0NW?=
 =?utf-8?B?YWJ6QlcwaHFuNFArSk5scHdyeE5HMGxxc3JycFNFYStJVUd5OU1KenJWLzZU?=
 =?utf-8?B?ZzFIdVJDeTJhNzRRUi9zdUNVSnljTHJPd1ZZbWhITkM4K3ExL3pra2xkV3c5?=
 =?utf-8?B?cU9CRHlXNUw4ZE9Vb2tqVzN0OFRQditFZTBURkppSldqR1Y5UmtIcGhPU2w3?=
 =?utf-8?B?R2t0SGt5VmRLM2RGUVZCN1ZVQVFleHVIU09EUlgzWXcvUFdRL0lrZWs5MTRj?=
 =?utf-8?B?c2RobTVvMWJ3Yk1Bd0E0cGdFK3BCYXdLK3M3elVQREZRd2ZCd0RSa2FoeUVa?=
 =?utf-8?B?dk9FTFZnYnI1QjZmSU80aDIxb1RRckdtZnBlYTdpdHdZQlZkOTJsTjYxQkoz?=
 =?utf-8?B?VEpqbzV2MWxDZHFHKzhaSkNwZjU5cWRYc0E2WTJTSjdWMkhpb3lzTzExaTZQ?=
 =?utf-8?B?NXFNRWRoMWFYcERucWFhK2VmNThyRmhKSDYrWG5tbHB6OFQ2dk51MUhEMWpH?=
 =?utf-8?B?Uk5FY1BBcHkwcnRGSnlWWC9QZDNjQnpkbjZSbFAvN1FPaXQ4MSs1UlJzMnJu?=
 =?utf-8?B?dzRNR3NJaVFXUGZZY2NWT1B0RmlieElEWWdTTXpEMGFyZGFjaGt3N0x0ZFhL?=
 =?utf-8?B?QVFFOGZrWEdBM0RwVUNyN1kwZis3T21ScnZEemdLN0crY0poUVQyZWZTc2NG?=
 =?utf-8?B?NTNhcjhvNnIrcVE2bEsrYkRvaVluSnhRT3JQYmxFVTYxaFFWTTYydTVYUHdZ?=
 =?utf-8?B?TWlmTG8vNGNEVzdnRVpZMW03UDIrd21HZ1NtZWdOakdJZWtkbjFtWE9mUGhh?=
 =?utf-8?B?M1ZJY1djdHV2UkEwOTFvK2VOS2VadWpJUXZrbzdBaFpXTDFWYUhqNm01enZP?=
 =?utf-8?B?T2VRaU16UFRmUS8yY2V0ODh1UUN6b3hDV1YvSG1WVnlLaTl1SHlyMk5kWW1j?=
 =?utf-8?B?QVRZWXNyb2JsWEgzenpER293Sm1oMUIzVmZObWsvaG93c2Z5ams1bHdTS3JV?=
 =?utf-8?B?T0pYUDdEdDByOS93bGk1ZlZydE9tZVc2cUcvTTRVZ3ZTQVNkWWFvR0U3Z1NP?=
 =?utf-8?B?cHY2WlcrVE1DNWpIMU05STMwSXNISVJodjZzQjV5aFVSd1ZCYUtKY0ZpUTQy?=
 =?utf-8?B?OGsyQTlXZnc4T28vTnE3R3drNnYrV2FZdEtSMndhSGkyUHQvU09Fc3N0aGt6?=
 =?utf-8?B?bFd2Q05WV28vNi8zNHh1MmlyRmRRL2k2elhzZmJlbGh1cjRnc0hmSnlkR2tY?=
 =?utf-8?B?SFBtdHg5UWQ1RmFrc01pWTJHMjkzVXBCcno5amVWbld3WS85YkhkRzRiTUNM?=
 =?utf-8?B?eVNmWjUzdDd1QUZSc0MxTldZSkI3eS9jVVF2VldXaXRwb2dJT0ovaXA1ZVRN?=
 =?utf-8?B?TVIxNE5mR2N1bTFyeStuSzdjRUFPb3ZKOGJ4cTE3RDZQVFYzVHgrTitMNUVk?=
 =?utf-8?B?UWtsRHNJZi96MTRHTkU2UFpwOWpSSVk5Qndsc1hJYUg0bjE5Nnp4NkdlQnRq?=
 =?utf-8?B?Z1M3SjB4UmQrTFZqTDFwNGh3QnArckE5QTJISjI0aHBrbERBV2JjU3J4RkFz?=
 =?utf-8?Q?gTAkS/r8Satst25WGP0gutn/O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V20rdmNFYW1aVGdFSFBFYzkrYmd4NHdkVUFZbWVUelBJVGV1NEoxSGdVME92?=
 =?utf-8?B?REFTeGVXY1lMYVdXVXRVWDNzVUVaOHZCVmVQQk1HeThIcjR0dStreDBRNGpJ?=
 =?utf-8?B?eURIYXhORXQycnhrV3BDYmhoNGw0MENVbkxjMlFFN0ZRZ1JDYlRkMmxSQjNK?=
 =?utf-8?B?c2tpNzRFeG5OdGc2SWVaUjVkWEpyL29TMlYzNVU2Q1JwVVBZUWJQbithWFdU?=
 =?utf-8?B?ZDgzWWNqMlRselV1dVh2N2RVWkpHY2IzeU5ITnphWGdPWXh0NytSWGYrZVNv?=
 =?utf-8?B?Y3hpQU43M1k5aHBhRXZDaUp5d0wwVVpVR3BZVjdOdnBIWFlpd3R1STZacnpE?=
 =?utf-8?B?VmF4Ylc1em81VzJsVDF0c1QxNXhXZXlmeTFVUjd6MmI2TUJDc2htQU9KdTBF?=
 =?utf-8?B?bVBraG9wakJuQm01R3A2WGZrakZvM1dUR2NGdUxJTHcyejZlN2lLY2g4YnRS?=
 =?utf-8?B?NzJ6VkNVUi9FdGdOMFM0LzdzTjZBSDRQaHJCZDlxNExtanRTUzhpTE1FdlRX?=
 =?utf-8?B?OWg0dUlVNjJBVkdWNzVEWmlTZU8vRlczK2h4NDdtZmJrRWFCVzd4dWNQc29Q?=
 =?utf-8?B?SHBrNXRyT21CVkpZa2tGa1NXOFdFeElJb0VpV1FCb3ZoOVVaSFdZRkNVd2lk?=
 =?utf-8?B?SFpVakMvY3E5QXhSM3o3TUlhUHZ2VEpBVTRyc21iTWQvNU9vTmZacm02MmVx?=
 =?utf-8?B?SE1abEo2RW05MzBRNElPSklaRTdZaEI0Z2dHZjl3bnVzdE5kcWFxT0NsRldu?=
 =?utf-8?B?R21yb3lwanZwWHFYc3dZdWRTaVNjWTdOZlJ1L3laTStIcklVTVc4YWV2YTFU?=
 =?utf-8?B?NndnNEFQaFBncTZIQ2FwSDNURDJWWmlWMWhzVFFCeEN6Q1BWQS8vRVJ1Uysz?=
 =?utf-8?B?L1hKc1ZKdXJsV1h2VUNLVjNFVW5wd2p6bGthaWFxbHpuYmd2WjhZMU0rdG5J?=
 =?utf-8?B?Y3VWSlN3SC84MHFsdnMrMlRrTzFpODJGaGVydU1QSTNPSWNhdUk4UXFjdC9U?=
 =?utf-8?B?dVhzUzJFUS9ZWXQvZHlwRDJmbS9BTnRTWTVlNGdYbFJkekVZZmpUdlYwYWtm?=
 =?utf-8?B?MEkzcndkS1J0ZVdnNVJUMWptVW5nTGZRTjhET1NsdnRsNHFHbk9tS0xzekxa?=
 =?utf-8?B?eVpUYWJxY282TCsxd0lZU1RjNWc4SnA1eCtFN0RpWDNiTmU2SzFFZGp5NVNB?=
 =?utf-8?B?V29wZ3YydTE0dmlhUWhzeXFzYkc2Y1kxV29uODZDOGZ1bGtJUWVNTURDeUIr?=
 =?utf-8?Q?3JxaS9xckB6KoGg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb81dbc-0658-4d55-98a7-08dba2965edc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 22:31:32.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nC+wh9vhrHeLCExerr6memAQLKQt67Qr/zr/lwr3CD1Q8CjXOrW49T4F/KGNLCvUTTlon0ySp4MKCe5Wu+gmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210207
X-Proofpoint-ORIG-GUID: ii03pm1Db_OElBnWqDcAsiVyaKeWnUIv
X-Proofpoint-GUID: ii03pm1Db_OElBnWqDcAsiVyaKeWnUIv
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2023 8:28 AM, Eugenio Perez Martin wrote:
> On Thu, Aug 17, 2023 at 2:05 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/15/2023 6:55 PM, Jason Wang wrote:
>>> On Wed, Aug 16, 2023 at 3:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/14/2023 7:21 PM, Jason Wang wrote:
>>>>> On Tue, Aug 15, 2023 at 9:46 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>> ---
>>>>>>     include/linux/vdpa.h | 7 +++++++
>>>>>>     1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>>> index db1b0ea..3a3878d 100644
>>>>>> --- a/include/linux/vdpa.h
>>>>>> +++ b/include/linux/vdpa.h
>>>>>> @@ -314,6 +314,12 @@ struct vdpa_map_file {
>>>>>>      *                             @iova: iova to be unmapped
>>>>>>      *                             @size: size of the area
>>>>>>      *                             Returns integer: success (0) or error (< 0)
>>>>>> + * @reset_map:                 Reset device memory mapping (optional)
>>>>>> + *                             Needed for device that using device
>>>>>> + *                             specific DMA translation (on-chip IOMMU)
>>>>> This exposes the device internal to the upper layer which is not optimal.
>>>> Not sure what does it mean by "device internal", but this op callback
>>>> just follows existing convention to describe what vdpa parent this API
>>>> targets.
>>> I meant the bus tries to hide the differences among vendors. So it
>>> needs to hide on-chip IOMMU stuff to the upper layer.
>>>
>>> We can expose two dimensional IO mappings models but it looks like
>>> over engineering for this issue. More below.
>>>
>>>>     * @set_map:                    Set device memory mapping (optional)
>>>>     *                              Needed for device that using device
>>>>     *                              specific DMA translation (on-chip IOMMU)
>>>> :
>>>> :
>>>>     * @dma_map:                    Map an area of PA to IOVA (optional)
>>>>     *                              Needed for device that using device
>>>>     *                              specific DMA translation (on-chip IOMMU)
>>>>     *                              and preferring incremental map.
>>>> :
>>>> :
>>>>     * @dma_unmap:                  Unmap an area of IOVA (optional but
>>>>     *                              must be implemented with dma_map)
>>>>     *                              Needed for device that using device
>>>>     *                              specific DMA translation (on-chip IOMMU)
>>>>     *                              and preferring incremental unmap.
>>>>
>>>>
>>>>> Btw, what's the difference between this and a simple
>>>>>
>>>>> set_map(NULL)?
>>>> I don't think parent drivers support this today - they can accept
>>>> non-NULL iotlb containing empty map entry, but not a NULL iotlb. The
>>>> behavior is undefined or it even causes panic when a NULL iotlb is
>>>> passed in.
>>> We can do this simple change if it can work.
>> If we go with setting up 1:1 DMA mapping at virtio-vdpa .probe() and
>> tearing it down at .release(), perhaps set_map(NULL) is not sufficient.
>>>>    Further this doesn't work with .dma_map parent drivers.
>>> Probably, but I'd remove dma_map as it doesn't have any real users
>>> except for the simulator.
>> OK, at a point there was suggestion to get this incremental API extended
>> to support batching to be in par with or even replace .set_map, not sure
>> if it's too soon to conclude. But I'm okay with the removal if need be.
> Yes, I think the right move in the long run is to delegate the
> batching to the parent driver. This allows drivers like mlx to add
> memory (like hotplugged memory) without the need of tearing down all
> the old maps.
Nods.

>
> Having said that, maybe we can work on top if we need to remove
> .dma_map for now.
I guess for that sake I would keep .dma_map unless there's strong 
objection against it.

Thanks,
-Siwei

>
>>>> The reason why a new op is needed or better is because it allows
>>>> userspace to tell apart different reset behavior from the older kernel
>>>> (via the F_IOTLB_PERSIST feature bit in patch 4), while this behavior
>>>> could vary between parent drivers.
>>> I'm ok with a new feature flag, but we need to first seek a way to
>>> reuse the existing API.
>> A feature flag is needed anyway. I'm fine with reusing but guess I'd
>> want to converge on the direction first.
>>
>> Thanks,
>> -Siwei
>>> Thanks
>>>
>>>> Regards,
>>>> -Siwei
>>>>
>>>>> Thanks
>>>>>
>>>>>> + *                             @vdev: vdpa device
>>>>>> + *                             @asid: address space identifier
>>>>>> + *                             Returns integer: success (0) or error (< 0)
>>>>>>      * @get_vq_dma_dev:            Get the dma device for a specific
>>>>>>      *                             virtqueue (optional)
>>>>>>      *                             @vdev: vdpa device
>>>>>> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
>>>>>>                           u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
>>>>>>            int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>>>>>>                             u64 iova, u64 size);
>>>>>> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>>>>>>            int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
>>>>>>                                  unsigned int asid);
>>>>>>            struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
>>>>>> --
>>>>>> 1.8.3.1
>>>>>>

