Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED87D4D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjJXKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJXKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:07:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065CBDA;
        Tue, 24 Oct 2023 03:07:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9PRFN018968;
        Tue, 24 Oct 2023 10:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YEeoIKlzpRD0ruEfSO0C6Nq69vlr9G+zoAlGODch/bM=;
 b=rQldUPtEFYX2RxK+F1Q/C3YGVBfiB54zlp+6uDhSLKcMpeesTFIHmBCJsaHDL9jyXFS3
 ZPUq4H9m6U73FSE85FFOiuiZHhfiN0NVP7SOsSPdaTYG77IHfVSXVKSjaHQp/0wA92ps
 V5C0Uo0+/13sVdhEI1zBleY/xq317a+JZBHbIXo2xEfYpsHhho6Uqcnv7+H9CAggIV7+
 cDyffVjM9Yt40MfLKn93MUIrZecMU9MXQet3j5c8bkDFNocop9kKuBfd+jhMeYI/iMYF
 qpceLb1CPSZ1Yuxu8gSndm+rV7oddDwAXlbQmJ8nfTGH2e7uOdGJU61f2T/8Fwk5lCAj sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e355n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 10:07:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39O7q02M014306;
        Tue, 24 Oct 2023 10:07:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfjbyue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 10:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6rdFWPd+WXDq3dDUEHMAnzMF4XMwlHcRgvhcpFfQQwfvSyHki9OlPN3Vsetk34q/09EJ0crYKQ/DBuilUaFkpm7Ux4rmnf3MO6lVRna0qOfBF1V54DCq2MUUVjTUvelMCfRr6U0oP1RQLWxWQdtX24C31o4COMq3HYdmxotys1+BtTsPvObGw0PzvRFelIVgT2oqdosw1hlYYditpX4X3RFA9V7dk2LZTiBasxv9Ayf0zt/TKgdDsJHmBjY8c48GUOnRI+gso3Oa/lQRzUz5Cn3fYvFFI58x5RjQ2rCACDzrJw7hi8CR/yOLKq3/kpFl9j2k+NF+VLCION4ahD9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEeoIKlzpRD0ruEfSO0C6Nq69vlr9G+zoAlGODch/bM=;
 b=eIkYF3085u1KhfohMSa7dt6qB3GbElzFeJNik61Rx/LPs2zT5YLCnnaXYC05tIS5cO8G3MkmVwxvFyZxDP4i6Cclb41gvUg2g8JF4i4e/BcguqXGgrkEBiN+A4abdAUGKd8IxHvzli/YIqLTbKA+GDpPiRGEr7uxhxc4QBkRlioqmLdcVjepK0NBiqBEWcYwaGFccyzcYDRpjwN2stdN+0OSAU6dKQDSpc8AJtbxbvrlL1sB8y1I5k1F1oiwo9W0cQeebN5mpzS83sXl7Fc2IZglumoXRQ6effahcFoQ3PqkutleBayjkKXUFhVIplI/STV3SudZ1TW4QrjlFQGKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEeoIKlzpRD0ruEfSO0C6Nq69vlr9G+zoAlGODch/bM=;
 b=NhmLM73pzMMKf5U725tbmUJEfrTR3d+nrzQq+yculNfQ16ZPHxsp2STAdRl6gsruzpD4pJQ2v+vtoJyiG7EwtsvOE1Rgv7J+xoojxpHFTHBb7X1T7dxt8kJi/3j6PFNIhW5OrDBt1Bdd+DScHqbfIrPxR+OXLFgoAAojJ8a5Rl0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 10:07:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 10:07:22 +0000
Message-ID: <e102ba93-8fb9-1754-1881-0cd322c808d6@oracle.com>
Date:   Tue, 24 Oct 2023 11:07:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-8-john.g.garry@oracle.com>
 <346bdffb-8a59-445e-a352-f3f1912fda1e@suse.de>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <346bdffb-8a59-445e-a352-f3f1912fda1e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7c432e-016a-4f16-2e55-08dbd47903e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le7S0CFL7eBrasbWJKHBblFBpjVt0UD411dP28cVhcxJrum6FEX0FCz+PMwtm9MAU0SDv2XJZ3xTwxwFig3G0rNc+RVs0hUYJ3jCf7HPx8CqocceywFzKyTgEphu9HcCikcrWwpupNgjyflv9NzdXGeJWS4Bc3ICAhiUQiQBlgwWQZXBx4hFsAK3+7LLcx86Jzzm3Zi1140CJ0bqex63FP7bpCjhqzqve4Pxe4eEYbcO9lz4N8ADuf5p7hDdV2cphin9t0IWVkfREtLAk46Ry4Z/nLBZYoYkHkqaGpyP06j1s5s//71tC997q6NieY09rrduQqZyV2BDsUdT1GavGPeVizCm1BDZJ/o3jvwTD3T8pA6vDuixy7PNMidQbPBjQEcIaYVu6QOyg5eHElAZPBiPCKLbhBijjxV/QtINtjf3VPiVWb38LcnYORPvnfhjlTwygyag+lZf7wl85GyORNSvSL3hyny9QDYmEc66JZVy+6qo5ZzbX6MAoAFF9qt+/3w2QqOPCWaVJNMsjdVq08vOUUdJqXtxfM3QlmGpamDSMZ6nblo+7lO5OJepxONSq51DdG62ndqxHD7X3kmoShGWsJx3ArwUqlVM4ICMG9fN51K8IgZqxY3LMdNANBNm6fHOEuBfFBjPiAAv5S8cVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(8936002)(2906002)(4744005)(4326008)(36756003)(26005)(53546011)(8676002)(2616005)(38100700002)(36916002)(6506007)(6512007)(316002)(6666004)(478600001)(31696002)(6486002)(5660300002)(66946007)(86362001)(66556008)(66476007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q20vTUF6NUg3MkM1a0RKdE1XZXJmZ2RMOXhtbHhCRmxPWHNWS3h0ZkU2WEE3?=
 =?utf-8?B?OWNuUm13ZTZwa0tka0Z4WFZCeTExdlBPOWxsL3YwQURqY1NrS3lQaXBtOTVW?=
 =?utf-8?B?Y3J5Ni9CWTFkZFZLOUVReFZEQ3BJODhSVndZMjBFazJ0OXZKYjBidjU1dnlP?=
 =?utf-8?B?MEprSHVFeEYrY3g2SlZWTzkrOFBWTVlXcmE5dG8vTm5LSFZscncyckRUb1Q2?=
 =?utf-8?B?M1Q0anU5WnphR3ZVVmxYK2NJYzM1NlNkWlRPdjcrV1RJaVUzT0phNGVhdWhN?=
 =?utf-8?B?MjIzc2Y1WEpPTVVrY3hTTHRnOC9udzJGWW1xdElKS3MveVlhalN1aGZ4VExT?=
 =?utf-8?B?WEh4TUU4QVB4b1ppaUNOa2pBQVFqOVZFS0RVZ0ZxQ0p1TDFCbFBlc2o3RmVw?=
 =?utf-8?B?azh2QnNndmY3aDg3Mkh3VFA5SmpDNm5UVGpzUTRsRGZxWTFqc0xhbzhUN2tR?=
 =?utf-8?B?cU5tSWlScDlDUzJNZ25qRWE3aVVOTktMbVlkY3Y5V29nUi9meWxOb3pGU3lU?=
 =?utf-8?B?NVQ3ZGlnTlJTTkR6azFxMjQ0ODA0cVZudHJmUjNXT3h0Q0Q5TURKK1NwUHpX?=
 =?utf-8?B?R2pZQnZwdEFCU3R5Tkg3ZXVOMjNQeldlaXV4VUM1eVhSQUVaY3hZVHVIS253?=
 =?utf-8?B?eUQ5MEQ1UXJLUWZWUXFIQkNoYnU4a0gzSDIvZFQybE5ZYVByN1IxQStmK0RM?=
 =?utf-8?B?cTBjYzVGTVRhRFU3S1FRNEJhakpJbmpQQW5zNU5OdHY2c1ZOVWFSeDlPMzdl?=
 =?utf-8?B?bjRrMzVrVEJIQ2Z1djZKOXk5ejFMeDVlWmt5K3RVcVZkRkNFQTdoeFJJWnBV?=
 =?utf-8?B?V1hGSmdwdjdzejZMK0ZNM2VyRHZsa0tVNmw5YlI4T2NkU3lhMHRoYUpta0JQ?=
 =?utf-8?B?bjkrckxBUXhiSHZKbWM5dWtyMUNWWnpuUkVFVjUyZ2FUN21mVUdQbHRmVzJp?=
 =?utf-8?B?STVXZjBtK1Y0OWZlU1oycElIR0dlOUQxVDdKZjNtckIxYi9LcmJiNVc5eFFs?=
 =?utf-8?B?WVZHNm9ZQ29MRjBzcDZHWkhTMi9Eb1FTMVFUV1VuS3dqR00xeVYzSXRQU1Qy?=
 =?utf-8?B?V3pmR2hYaGo2OHRFQjI2QlJTbS8zdzMwNk96VmNUekVTNWIvWDRma2xzVmpL?=
 =?utf-8?B?OVVraXBmeFJ6YWNoT0dBUG5kY3o5ZjZTbDcwdC9jbnRuRlNHYmFydUJpZ3lD?=
 =?utf-8?B?UUFJaXBDMGV1MFk1YVhHMnlVZVU4blN2TFlUM24rOEphV3pZVEJXQ2JRNHZj?=
 =?utf-8?B?cU95Qm9NcnVrZitsR0l6U3hXc0pNc1U1dXZsVDlHOVIzSWxzRGE2UlhNREcv?=
 =?utf-8?B?OXEwbFd5Z2NveS82d2FkVTJXdDFwZFZuVSs2Y3BoR3EvWVB2eUxZTytwYjdN?=
 =?utf-8?B?QXZEUGhwTDROb0NGLzd5NUd6cjV0YVgzbFdSbmtoa2ZTTnh1R1J4S1p2Rytv?=
 =?utf-8?B?c3J5eW5ndHJOeW8rK05RclI1TUJNbm9WVkIyVnA5R1pyWGE0SDVoSWZUK2dQ?=
 =?utf-8?B?QmROaEdMWVJoS3VQZzl6NHF6emxPUm1XL21CNW1pRzUycEdCMWxXaHFFTldU?=
 =?utf-8?B?YzZaVTZVMXhVTlBIc3RMU2d4c2ZsVkV6alUrbWlOYW1ac2NuQmpCL2Iybk5X?=
 =?utf-8?B?QlRJVEhFZEFsdGdyU1FYbEppbU05V0RTYkREOERwaGJxUjEvTmhPNnNkQlhS?=
 =?utf-8?B?cXBXY1c0bGRIcUx6TjJqY1VxWFFYbEVwc0p5dzZoaTNNY3lORHRHbnR3R05r?=
 =?utf-8?B?Zk85ZW5oUWdkQ3B5RGZBK0VXWjhPeGpHb0N5Q2xNTGgvSmd5cVkzSERLZ1Nx?=
 =?utf-8?B?TWF1NWszT1puOTZTSGI5ZEdJajJEWnV0WVl3NVJ2YTNjR1ZnbHo3R0d2MnZL?=
 =?utf-8?B?OFcyTGV2OThwQjI5a2ZsRFp4YUsydEhmMTRMdzd1RjBRL0VDdW10cFRFYXRu?=
 =?utf-8?B?d0RRTVpoYTc0S25hV1U2a1MwbC9DaUxSbVJlQnZxSWpUNG9IZDBiaDB1STlD?=
 =?utf-8?B?U0xUcDVLUkF5cHowYVMxMWwwU0tPUmNKTHM2SWtlVVVIMXhzVjh1bW1rallK?=
 =?utf-8?B?YThNQVNSRnR6ZTI5RG1nOFVkNnFFZno5WVU5VnFUVjBSQ3k3d1JRU1lWemxj?=
 =?utf-8?Q?/0nTk3b6khZzL3nZ6CvpFRNe4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZWJJa2ZpVkFuSVpEdUQrbGZHamhaTkRNQ0V5akljT2huY2ltb1ArM3d4aHZJ?=
 =?utf-8?B?N3c5YXBuc1BUaGlMWmVzcjM1V3NqblJneXJ4NHN1Q1hZS0ROOGhSTHRBUTgv?=
 =?utf-8?B?VUdlRnhSTCsyT0RYN21vSzdUZ2lwZ3V4UnkzUW0wd20wekFZaWduY0FCczYz?=
 =?utf-8?B?bGhwQnl5Y0VtNHQ4OERFVHBIdkhZSlh3UGUrand4NTNWd2dJcnNYSGs0a2RY?=
 =?utf-8?B?Rk9YY0NNSGJvUjc5L0Rycmx1ckJvRUpEU3hnUGNUT0VUV3V2L1dmSEpDSGRZ?=
 =?utf-8?B?K0pMNjh2djNqZDVVTXMwVmZuNWRiNUNVT3NaRlZOaXFxaDBadXlxTjFFdFMy?=
 =?utf-8?B?MGhSVnJWT0Z4L0NmVk5OWVd3amE2Vm1WSElBN2t5WUhnVEFFbzIvNFFKbnU4?=
 =?utf-8?B?MmhOcTQ5c3poaWpRRXVOOVdSdHovV2FmbmNDZElTdmlhZFhPQXRpeHEvLy9h?=
 =?utf-8?B?bWZXRHZZOTJoVzdXSHJySFlqYU1HWjhUNFM4MHg4R0dqUlpYTmgyRzU3cm1M?=
 =?utf-8?B?d2pnNmhEVTlsMm9tOXE4a2NqWHJxVkZhS1FvYkdxNkUrYjl1Tm0wWkdOWTVt?=
 =?utf-8?B?TzcwWlJ6elJJYnAzQ1crVEwrNnpMY2JBU3hCMkpVeTBJR0NBS3NhUzRXeFIy?=
 =?utf-8?B?RU5OUS9wdHVLZ3hJZm96emRpdTFxRjNPSWY3TzZCQWx0bWlwYnNRT04yT1dM?=
 =?utf-8?B?S2NSZzhBRk9vOG1kbGIycSs1U1JESndMYVlMNzhBNXp2c1VSVnFCa0NZLyth?=
 =?utf-8?B?ZlltNForaXVKcENYbXFsR3ZHVmF6Ujd4anBnallTZHFreEZIV0NwMWIwcVZu?=
 =?utf-8?B?S3QzVHpmYW1UUy9uSStzZklNY1JGTWVlcGtuUm1JcUUxOUlMbndjblBFT2p3?=
 =?utf-8?B?ZzdPYWYrb25EcWVuN2gzZFk2UnJaTGRXQTA5Y3ExQVlJaEFzWGFtd2VDTjhB?=
 =?utf-8?B?VmlGT1ZGWW80Vjc1cndseS93RU5zZUFnSU5xTkNxZVlmNVRhTUVMcDZlTHhP?=
 =?utf-8?B?eCtFdk1oYU44RTZaK1RSajRuZ2txZlM4SXhoMW5hSHF1SDFBbjlCeFJzNUhD?=
 =?utf-8?B?dUtxNk9Oa29MV1JkdlVNb0lDWjZwbUFZRWJzSERjc1RnNERJNERxek0rK3VT?=
 =?utf-8?B?R1pUb1RKemtjZGZCSTNsYWlpaStKbCsyeDZRQkNkazgyaVZXL0hFTXF2eHIx?=
 =?utf-8?B?OWdoQStidkxxQWJob05xdmtIRURXNjY0S1RjWXBaTkYrM1dQUitoT1VlYktS?=
 =?utf-8?B?MTR0d0VMaTZ3Wmd4TzRBMjVsMDhGeDJnNE5rSmpjT29KVjJFMEo4T1FtSkFX?=
 =?utf-8?Q?o/OQ7/2ke4RDk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c432e-016a-4f16-2e55-08dbd47903e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:07:22.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlavcZoweJAQ1vKazTM7WF4/xJGiHKXRvx7O+OD2Kb7BiwVP7f0aAWD77+d7MFduXH3xYZ81l7+VYRX4BQ1KBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240084
X-Proofpoint-GUID: lCpvgk8PIdMoO9gpCN-G1ztD-z5Xrijg
X-Proofpoint-ORIG-GUID: lCpvgk8PIdMoO9gpCN-G1ztD-z5Xrijg
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 07:55, Hannes Reinecke wrote:
>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>> index d77db53cbd8d..5b2e6932c564 100644
>> --- a/include/scsi/libsas.h
>> +++ b/include/scsi/libsas.h
>> @@ -565,7 +565,6 @@ enum task_attribute {
>>   struct sas_ssp_task {
>>       u8     LUN[8];
>>       enum   task_attribute task_attr;
>> -    u8     task_prio;
>>       struct scsi_cmnd *cmd;
>>   };
> Hmm. While true in general, we lose information on how the 'prio' field 
> is coded for the various drivers.
> Would it be an idea to use explicitly state TASK_ATTR_SIMPLE
> in the various drivers such that we know what to fix if we ever
> decide to bring task attributes back to life?

The HW encoding for these drivers is the same as in the SAS COMMAND 
frame - Command information unit structure, right? So the amount of info 
lost is reduced. And we also have source control history.

I'd be more inclined to get rid of setting task attributes similarly as 
well.

Thanks,
John
