Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35678E21E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbjH3WKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbjH3WKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:10:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288BCF1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:10:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInwvh013285;
        Wed, 30 Aug 2023 20:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fyC35XwkAIpSDknqMeQ3tDY5EkZGmCR1dqEykA8APME=;
 b=QUBnFwPgTJ7JobzP8ekXO7FbzH9lrpwqEk//e3yYKoZg+anJ5hsmPNs2ZNHKldOghMi9
 bYHUZeF4B05L8iRyeC93MlWqoqqQ7hb1rhCOyf3HMTjDcfKxiJK5PWhqDHYCqVbzLEfk
 eO5joDx7ZWlz96CpGhrSHyN0bsb5qXxlHSLekPhNtzfZ9fv9Y3WR3NcsjVrElyGbTdzw
 fL/iwIX33ImFCuVMgM6aIKEHnVpEQyRkp1wW4/gTl8I7SVGd9G8TrUMR8quINlGMn4a5
 H1XysdyR9I6yOyXIngQkLOmT+tkWWJ3R2pMBMIkhMfBL8Frz3tkwjn5ybmesm1HJws+j lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcrbch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 20:20:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UJPVka000581;
        Wed, 30 Aug 2023 20:20:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gd3bxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 20:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8JpZlDtU8eruF/VsnMCpdDsatG2PCXFvDqOswEahNN1eD78yY8HYLoE9uVJWC97A39Wy0zRszz8Uw1lLGiJtz+/QdgvJoeprOVizEebFR2XCsRbRdh1qW1CqQyVg6AxJFCEDOXeLwDPgPA6mhcIDLo14D8UJLW50gCqqwP3Hw5S5AiDzBW44fpSQocsOA63JX1xqJP++BDWSfm7QuO+j6YNe9p7G7wAvd+oc+NV119pJZtj0F2zMc5CER4sdNWUSyr+XKnMJ89qEQX1OM1lZHAiSXcD4pv0qrLabmTkwv+uGCOHVlt29qdqKG9rtPnEd2klpfJF4RXsBv67rI6B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyC35XwkAIpSDknqMeQ3tDY5EkZGmCR1dqEykA8APME=;
 b=HlzzOHrS2PrCvYkoZzacEVYQtsOOcbPLQPPLx5Jsc92dIo4oeg5TsT6oJdQV7Vzjar/auESxUQYpc2wExuSrhPqwMl5dEEc8grl+h18h2AB9qL0k0uz8PEsl9A61GSs8XO8g+4B07sB+1UayWxu48y4aEw9euAOFnkRPed+ewXTEM99EQ2L3xdeb/dVjTBouVGU27SK/AtFXYWmeqpkjptrqaG+B1iwqOXjH75qwx6k8/cD+e/+UtLosBk2aSdurLd/sZyoZYBIweGvxJUBb6SLTMIrex0QeJNKqis6uWkr3lh5flcarA1PviTB47MNTwaS4IKDKIrAHGBieLC+FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyC35XwkAIpSDknqMeQ3tDY5EkZGmCR1dqEykA8APME=;
 b=gXsWGZZKiztC7YbPD1cEonhdnqqno2ePV6fC0ncbiCN3qZjqZd4G9Z4AjCGqptfGZrLEJgkIykZ7xu9tcTbFNgCWYDPR8NQGij6ztr93nCLkv22X4g9ZkyHgxDTRyvz/slGSx+0dc9D7+YSfDPGHL+lk/g6E9o9Bud6dIqJYBnQ=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 20:20:10 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 20:20:10 +0000
Message-ID: <19d0fde9-8a56-41f3-a898-c10f18b79b1e@oracle.com>
Date:   Wed, 30 Aug 2023 15:20:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs : fix shift-out-of-bounds in dbUpdatePMap
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, liushixin2@huawei.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
References: <20230827050513.364567-1-ghandatmanas@gmail.com>
 <edf10660-2e8a-4f5b-8eb5-16038f8adbcf@oracle.com>
 <e655b722-f610-99dd-16c1-ed3235860a80@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <e655b722-f610-99dd-16c1-ed3235860a80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::26) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e503f66-e9a2-4714-2774-08dba9968283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpgPpRr6wGcHRArS1Xg4w+jgPRPA/CHMTfLjQ8/de1VFne1qeKM2epWYXlKNRSeBl9u7rzeoWTcDVF0EZ9eCdDTYyDymNkGiA7seto0X01zMl7gTHnyhKBPfOSPZDI8qme48te8pOK4fkg/vOV27GL5j800iA7vFj74d7ehrdFvdG4NA0/s2O6H/08g+7a0KjGglEwx/xudKcIls/Tj8lAYRyv2/4/+nc685SX36dtaViBVRCWoVGNErMJLNXyuJxXlVqleC5HqU6irP85h2uRsTzHv4C0azVGNwhtqCiKAfBMOKky7EAZm1/J687WPn+p8TXRY6IE5PHKuDDAFtBJEfuHFT5uZChdWwaTbdX5pM0Q3FJV4zacUXCXpW3QB+0gdAVKR69jGz/8v8mUuHq+vAvyGfqIdGCz3ih2baav4PKKdw63SP4/tMMRBjLrUkfjUUxV6juo9VhBPOM8CZ7AftIMcjunj14IDMcx1wdAuZiGiRwBhJIiGWSmPDbQ+X3tIX83YsfYn3juG7pu4pd5x98ULnZnsKD6uys0izoT98OmewvuC/dAB+E27BpuoF9ZsNF8gO4b+W3GPDe3GIWb12SIv6PDWZ6BMBQ+8V1O3fqkzFajw7A6++sYXQFXZDVxKYvj5Bd5OnA8sW220DBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(53546011)(66476007)(6506007)(66556008)(6486002)(38100700002)(316002)(41300700001)(6512007)(26005)(44832011)(5660300002)(36756003)(2616005)(8676002)(31696002)(2906002)(4744005)(86362001)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFkxeTh2bWoxamc2UFRXcVUzeTRKbFJvdHVGbmJMbUVsZ09ia2dkeGR0QzFY?=
 =?utf-8?B?VUI1Z0FjVk40VVJGT2FSenhodHh2ZTI3S1p0ZnZVQXNHOC9OOGNaajdDM0JD?=
 =?utf-8?B?YkJYeXE4aHFuK2N5dDBnWnQwbXFCdDl3ZEFEUmd6YUkxVzJUY0tVNW9yUkhR?=
 =?utf-8?B?MVJWUnBtbHFoY0cvK0JkZk1qY1hvd3RZUTlJQ3QzV0xSL040V1VCVEZOaGNT?=
 =?utf-8?B?TXYzNnNteUphYlV2UGZTZWQ5Wk9Bd2NXWTF1aHFHVWlXK1dMNWVEOW5Rcnpq?=
 =?utf-8?B?T0NCRldjeWI0T2UrRG5qck42ZkVNUktUUktmZnhQQXVqeHMxaGQ4YmpoTFpG?=
 =?utf-8?B?VVJiVzlPVzdXNmh3WUpWTzJmNnhjM0NBMDR6cWhCNHdKT2k1bXkxeER4ZmFu?=
 =?utf-8?B?SjhNQitPOVdDYWprM1NFWk03SDFZT05TVE9haEhJekhqTGNxVG51ZkFZZWw3?=
 =?utf-8?B?ZEhjTncwRVJIaEFZUmZJcWQxMnZuM2doUTc5bWY4a01rUWdCdzJsQ3Bsbk1X?=
 =?utf-8?B?VWRJUGp5ZkE5QmpwQXhVbXZTUDRUMkNLd041WmlXbHB2b3gzVzJJSHpGOVRl?=
 =?utf-8?B?WlpGSXlLZHU0ZGhJVkQ4NjkyVTVCNWlsMkZmSURvMWx5V09HODdVWC9MQVRm?=
 =?utf-8?B?Mkg1NWw0VC8wVW9VcVQybXNuMWNUMWx5UzByNWhqT2psOEI2SDFucDhQdUo4?=
 =?utf-8?B?QXR2b2xKZEs2WTAvU0hmQ1diOUd6S3ArbGlXTWE4YW5nb2Qxem10ZStqT2VP?=
 =?utf-8?B?WWhvWEZkL1JpTjNsOVJzYWQwUFpaVGhlWUJMN0JnaEEvellTQUZjYXdMTEZO?=
 =?utf-8?B?ZVJmRzFzU1hRTU1xeVFnYTU2RlI1ZGt1UGxJOEYreWRpbzVDWi9VcERBS0x0?=
 =?utf-8?B?K3BET3krUkE3YXdXM3E0NFRJS1lub1FCNnZBR01LNGJzOGJXemxWZjZPT29v?=
 =?utf-8?B?NjBoNElVSHVwUHFJVDZNV2Z5a2d5NGUvQTRzL3VpTGxWYU5EajdBT1d0S2kz?=
 =?utf-8?B?SUdpVDBld0pEQ2c3Y002Q25zQW9TcmV0eDFuTTBMcWZidnBEajlhSytXRmts?=
 =?utf-8?B?NE0wMzZnb0xKTGdGMnZFd1pzRFdITml6MG1ESlN4alVERWRpdWY4TTBESnFK?=
 =?utf-8?B?enNEUVp4ZHRvMjVZTjJ3aDJVaVZIMzhtTnNIUlh0cXNZV3FLNmVxYjQ2V2M5?=
 =?utf-8?B?d3Fjd2dFL1pPRmlMSyswcEovcGlGM2hNRFdnODdqRnNZQk5FVC84TjFGWjN5?=
 =?utf-8?B?eGpYdFZSQ3VVK2xwN1RmQXM5TWJjaGlXU0l6cTE2VjcxUUtFTTExWHRzRG1Y?=
 =?utf-8?B?QkxNR21HdjRpVCtoU0hNeksvZ2hUMWNVVFNGNFRydFFvcUcvOThzTWVuOTgx?=
 =?utf-8?B?c1dJbWs2M1JaMHJsOWJQajFHb3FvM3NsOVA4WCtDMnRpL1ZTcG9ncjFaendu?=
 =?utf-8?B?TFFaRjh1bUVNTm81c2xuLzB6SU9FbDFsMExUQWRGVzJjYVZoVm9sT3VDMXVM?=
 =?utf-8?B?MWdsdHpJdWZSdGFkTklnKzNpWE52aXp5WmlPcEJzb1hzOHFhdmVFSWErVGRj?=
 =?utf-8?B?b0lQdnk3a2ZFUzFtbENxZFkwVlhoZ3ptRHRZNVhpVmxoOTdNZXdGN0pvcGRr?=
 =?utf-8?B?d2M5aFhEQXd0ejc1ZGFkbXNLZFcvandIQkVvSTBaM0drU3JUdzlpZ3Q0MVhR?=
 =?utf-8?B?NlUvK3NvYm5UcWwxM1J4bzQxbFhDNzNzYzA4YzdFN2w0cmRHVDdyVnozby8x?=
 =?utf-8?B?N09ZMTdWMHBTSnRHMlc2ajB3U2k1ZEVXUTBtV2RLTURBV25rcG5tRDcvNDdL?=
 =?utf-8?B?YnBhVEI0SXJta1kxVmJ3Vkd6U2Z3V2EwREF4elM5VzZpSGJ0ZlJ4WkcyRTg0?=
 =?utf-8?B?MEZtQ3VraUR0amluWThzaDBtcXFldG9RRWhaWmRIY3FFZFVZcHY0MjBvUlgv?=
 =?utf-8?B?ajJXeUFTd2NNeEFtbkxETUsrM3plS2wvWU9iQzNleVRxaGszcXRVMWV1aTNm?=
 =?utf-8?B?WW1wRG5XK1R5MVFGVHBpcGRyWnRPVUhVR3lxeC9SRjZObFhwZHROL0ZTRUJE?=
 =?utf-8?B?T1BwRlBNQTdkVi9HV3BtdEFVWXFCWERSaEE4STJrcWZaZ3d4U3lNZzBJaXM1?=
 =?utf-8?B?VGtHUzE5K3FPOFA2WmlQbUVlaGhLaUl2bnAzMjYzZXhVdjlpRWtxclg0L0F5?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3YxVEx5YUJ1em45QWdRTUQ3dXRRakxQVnlPeTJvT0RVWk11cVpBRzNXa2hI?=
 =?utf-8?B?NlY3SFR0ZkhOVWxaQ2owMC9BNmFuRkQzNWFPSEVIM3FBaFUxdFFDVW5zRUlm?=
 =?utf-8?B?WVJzVFNrS2xla3g1MmhublZTcTNyWHdOZUkvbnFMT1NwT0h5UWREb1VLU3ZL?=
 =?utf-8?B?VGhFMndrZFJzZllLN2pFYVBiNzNTUE5ROUhvS3ZoM21jSmpKak54Z0w3TXVL?=
 =?utf-8?B?MFNzKzVlcFIyRWN6bTlUR0tmWnZMcDU1aFFYWVAvN3BtNGFScnFiM2lEUk81?=
 =?utf-8?B?c0ZQNHpyL0RFclNLeXgwVTRZMlVmWVRIQ2RmUlRZck9PMjVhWHI1TU1FOEdl?=
 =?utf-8?B?QjZKc2pjMmVndk9JeTZwRWxqb3dpZFBUd2ZrNWlPSUlSY0lXSHloc3FWdG4x?=
 =?utf-8?B?K1lwdExxSXg2eUV4THB4NysySXE1V3orWUZpMFp2Y2xFQnBKeVpYL0Vrbkxi?=
 =?utf-8?B?VWI3ZmpoZk5tOEhGenlGZlFYTk5pZ1ZxVWNFcDE5RFBydEtyR1hxb1d5aTg2?=
 =?utf-8?B?VWpNUHQrcGtOektaeWFZb0ZNZjJmbTBVRHRWaFRXSjlzSUd0bWpaSkFVQmJ0?=
 =?utf-8?B?NzRzejlFK1FiME84aW5MUkZ3N1p1YjFPbW5DZUh3N1h6aW1ZdTVWcVQwVFVr?=
 =?utf-8?B?b1hqQW9WTFE0cGx5NjZiTEVHRzJhbURzSlhtT2lWWGszaUt1TDB5Ly9od3po?=
 =?utf-8?B?eHdsV20xdkZZUHNybGE2YXlNMkl4Q3k0RGlvRXVvQmRCRFJ5eEVLbUJsQ085?=
 =?utf-8?B?aEs4b3g0eU1YT0dHaVI4aTVYc0hwdENGMzBBdHNFeGhiRXZRaUtIUTZ4UytY?=
 =?utf-8?B?TVFvWUQ0c0V0QnlVTVU3eUk1TTlqNHNIQ2xGTDZ6STRMV0V6U2tncWpJVytt?=
 =?utf-8?B?UmNXYVdGVXN4azVadExqUVpUQ00rODZzdUtyMGp6LytiUHIveHdYUWNiTEVM?=
 =?utf-8?B?bDZSWWZmUkdjRFFmcVlOd2RiZXc5bjVxeTRkSlhhUGtwZkt4emRHWDZUc242?=
 =?utf-8?B?aTJydzdoallXQ1ZPMTF1dm9OWGtmcnpoWWFTSUorczRQOGE4bGJndC8zWUJs?=
 =?utf-8?B?NjZ2L1dxNWxDM21NcTZmOVdZcFdIWGlud1k5dkxYSDhWNEkralYvaTh0UXlp?=
 =?utf-8?B?OWZBV2F6M09CN3FRakpTc1B3b2RlR29pRzBxWUhuTnJENm1KdFdVNkhEMmsz?=
 =?utf-8?B?cG5zQmpYOUVTVW01NmMrM2t3RFFhZU5MWlRKL2JWWFUxeDNHSEQzRTJLRStS?=
 =?utf-8?B?RDRiUXptZ2RQelBudEdYbEtCQ2RoMW9OMmxwdGM2dFJYZmREV1oxU216cTNW?=
 =?utf-8?Q?WbebU6SXgpRA6t4jlYA3m4yxgIJLdGtCj4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e503f66-e9a2-4714-2774-08dba9968283
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:20:10.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvDs+Pyx9LVtKw5RJgHyVWZUL3Qk4comhMYDE4j2FUQxQ5jeovr6rodrpeCDuBqNwrxUVVKN/AMFaMwXuF7CHwrtlnpY9IFkCW9oSRX/wYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_17,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=650
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300184
X-Proofpoint-ORIG-GUID: eysjFbEzF-3dHG8JJ8WnhZu2pKN2kTus
X-Proofpoint-GUID: eysjFbEzF-3dHG8JJ8WnhZu2pKN2kTus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for verifying!

On 8/30/23 11:58AM, Manas Ghandat wrote:
> I checked for the v6.5. Its fixed there.
> 
> On 29/08/23 23:19, Dave Kleikamp wrote:
>> On 8/27/23 12:05AM, Manas Ghandat wrote:
>>> Currently there is no bound check for number of logical blocks per
>>> page (bmp->db_l2nbperpage). Added the required bound check for the
>>> calculation of dmap.
>>
>> This should already be fixed by 11509910c599 ("jfs: jfs_dmap: Validate 
>> db_l2nbperpage while mounting")
>>
>> Can you please verify if this problem still exists in v6.5?
>>
>> Shaggy
>>
