Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD376F0FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjHCR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHCR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:58:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A61724
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:58:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgOr9006891;
        Thu, 3 Aug 2023 17:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=CblwxWmj6hYwY25OrNbny5Vcwyo0HWS9PAbm+yEVE85wKh0liIrF0Kl+QXf+r8y/h5OV
 hihe11r9ZO5sdvWXPz4QCkdynzLJCTzBd46zK2LjWeqOqp+4hZ1q84xr3w4ar94325F1
 hrvBGTOUcAosXkiEsqkDInUl2apYkYYeA+fwoEQebC0m+YBzzhNihzP20hILkehjUy6H
 R2amFV5NQC8Y/kB4THRfhAtGOYdYFO2I98Vkz34e5Ue2jYnQ7OX8wRMtppFctARTYp0T
 3+4xY4LzVa22tHscxHnrdyLsjOaV/AmHLQgOSwnSnqI0Uz6rjwMcGnUDg+xwzjWTIMip aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav26qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:57:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373GQAoV006687;
        Thu, 3 Aug 2023 17:57:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79tjej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKGIM3HJXc7OKzCyfAqhvteKdfyV3NxOZO2GAv1LmPITYDCALCJJkNJchIFsGLJkoPi33nO+Xx+SRJMUOhpj0YlPrBYtOfaB9rW8DSSaYOYynmhudb+3q0kF6fc4mzuFu8+knTnxs6EQA/YDap1ZCvWYoN+fnH/FiMkGGFblDoJBJYm2LIsvC/lUTvlUQHNmkBc6WgPzXYtn4zSzCZpdOyznJEflCwkhx4gcq2LjoFqAByyMKRaVzFEjSAS3jxFfIr/IhOcJZPJVaI4o2YN6AAbFD4v92MkyLwfebFWwofR20VoJcbsqt6D73v6/soadadre5ay38RyFAusgwSgWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=lFGbs6pUFsK6MM/trB+QiAbHhWqC1xBxtO4Fse3uwpK0ymv/uNOISX7N6RGaPq+tUEG01KRm/p+B6RF1lyDQz3HmSGCTC5KONNYYUIkqXb2BVyyu1d2pm5qIofqOTMMNq0vwhocG69REsik9TiCK4kdvq3hV3iRu1MLEiLsM6/FKiycsiSfq1NcOYLy/CTSHSHHZbbxrj/UQGUvrJA089NzKx4ydpqUX8pPGaCpTYYVZ+vqhYYRolhE5TN0lGlsIxDc5dvahoRvrpwrhHq8TZ92at5wQECp9+tZTPwdRVOJHSkAApOVykiVnE5gprHnBzCcQRY9PIR2N/k/etwCD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=kXyR8D0hozaHgf2fGdR+0JHjZudnuC8HZ39ttQWQcIBhg0D4THrUpMjP39neyMxPasAyN0SycijpvwhSgWYswNFqmCkI3jPdXarWb0fBsYi5hX5746D8/hF5juO19mhE4JZpV+5ciVU3fnFvzvogVbCu43sMwEdwAFidxRRD0WA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 17:57:55 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:57:55 +0000
Message-ID: <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
Date:   Thu, 3 Aug 2023 10:57:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To:     Jason Wang <jasowang@redhat.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
Content-Language: en-US
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::10) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa81e52-84dc-4824-4ff3-08db944b2967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud+d1cwkt7OboxTxNx60E/HpYC+c8TcpZniihg3d+zomDjfCVaxo4z0+hDUMdqzn/CD/DtFrY5OdksZzqbwlQlHmn+8rhJaIopEp330qoCGY2cdeZSR+Qtolz6rqA95+wOTwdF6h74/23Q67ea8HrKQ462hJMvpCKSo7hBqGzhwp/RpoU7KjUCUuvbMcYuXwxtim51VjU7IqX5Dz63/Bp2Sf0lvTB5NWMG6MbpE92KDxNUDMA9B39x2j7pwQGA7h7IyV8THCMpbrOdkcQZRbJHem+Al1ZacqwSRlKN6Wsr4JmLN1I+yM59i3faaODONHRbNCL1HvK/Ba7Rek+gNRYaBZmLrJSn4KkKvrrymIihYxLzioBEbURnE0pkWXhOpVm72j9fkVLCcwcGLmRfQ+5X7dtVvNGvBw50j0Q7AYw+ViswB5IpTaPzhxZcf6P/iroHF6cnEaTW3UccF3BadABpWj1Z0AakzZ4Ei6zMQJHuXoEaQKgBBHVlMuzF53e4LZtfChwSEy0/wmwQn2JFcBAsu5BCM5ZBX18yRccNbYPCpFYjqAZJVpaloVxHLxPDrYb7ZiiAYUbktAYyroSW5yfxRfYVr4qJLPLtQhaLa04LB179eMkZGQxXr82qwc0NN5zwdLCuHhJY35RteS4zTylodPDv/6tFXS0s3X/HZbRgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(66574015)(2616005)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(66476007)(41300700001)(8936002)(6486002)(6666004)(966005)(6512007)(54906003)(110136005)(478600001)(36916002)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxTTElBeWltU0xPQUM3WDcwcGFlcGozQUd4V1QxdVhpQU5oUFpnMXhHdnVS?=
 =?utf-8?B?Yk1za2NQemFNR1JLTDFmaGF0L2M1Zld6dVdncm1tazdZR2g3dVpCS3crRkZL?=
 =?utf-8?B?WUxUcWQ5aVRlNWZIRXFGbUI2ZGZNZGhlNFdwSTFIVWo1TW40ajN6ZG5KdVNX?=
 =?utf-8?B?aE8rZTRTUmdkRzlvbU5taE5TRE9xTTJyY1FqRGExZ1E4OEhUY1Z0WHVuU0wv?=
 =?utf-8?B?cmVXTUtpY0tOMUxnQm4wcGc4djQzb2ZBYUh2a3hmeW15U09wQ0VEamQwYlBp?=
 =?utf-8?B?OGtodVU5SmFvbEZVQTJSYkFuTTBOQTVQYU1VVTVIeklXSit5RzBWbndaQm9G?=
 =?utf-8?B?M3UxK2JsaUdzOFNnclp4Q01Sczc1N0tXUXUxVkNKUms3Q0lPVkE5Y3F4b2ZB?=
 =?utf-8?B?SGs0WUwrUHhpZEpZUWVKMElCclY4QjFoTVVaOXk0SEtEdjAvSzZQMEtvQ0N2?=
 =?utf-8?B?dHlnQWlMc0VoYjc1S3JYcGJLT1Vyb3hrTzlObGp0UGFJNWlyVkorWGxNOSs2?=
 =?utf-8?B?eUtna1l2VDc4cmwzSndJb1UwTTVUeS9vRmpKQkVUWEIrckE3NXQyNUNwQUdC?=
 =?utf-8?B?UDN5Q0FldlN3MGhoRFUzTlRONkRsd1BqZ1ZLNS9LeVRkUHpOeWZieFk3WUtk?=
 =?utf-8?B?ak0vNjdZV0p5L09MNjM0dWUxaWpTU1IxRko5eHBKSEpGTVBGUmFTcUFEVFRm?=
 =?utf-8?B?elRldUtGdUpFbDBSMkVmR3UzcmhDbVRaR3ZPclBEc055Y3YzUkZaL3dmQnBk?=
 =?utf-8?B?ZlB1M2pSeldjY0pWNWQ5cU1WVnA2TUp6dmtKZmppYmM2a2NxNis1Z1lCL0g1?=
 =?utf-8?B?S1pXcXlVcTFNZTdqNzA1L3VOaUtHUEpibWlWenBRMm1lV3FHNHRza0Q1SVpE?=
 =?utf-8?B?SzBHVkhKa1N1MVdmdi9aRU5OcXFxcFNDVHpTR3FMQlYxbzRLSU1BUytYdlk2?=
 =?utf-8?B?ZmY1LzVqQndUUHVma3VRd0Z1Q2laV2xHOENMbnd2dHVJNm03dlNwWVllU1VU?=
 =?utf-8?B?K3J3ZWlJT0hadWFWaVhpRmlySVhPSCtjd1pRYzFNdytnUDdHdFdYTDRTTjFG?=
 =?utf-8?B?WVg2NXQrS0EvdkorNTQya3pHeWYyUFYvb1FudzM2TzF6L2dybFFpWWg5SzVR?=
 =?utf-8?B?T2wwQmZwbE5OU0VYT2dKcGJhR0R1azd3MDB0NlBVNFovZ3RzdjRjdGh1aktk?=
 =?utf-8?B?L1k2RFRLeXVvQ2hoNkNuQTRWaG9IQ2JFZWVLUFBHM2RyT3AxTkRhc2w0OFFQ?=
 =?utf-8?B?Snd3bElNNFFIcnY4blY4T0kyc3BFcHhYV0Q0M0RIL0pHRTFlSE5UN3c1UzBl?=
 =?utf-8?B?TVQ2N2xPcld1SGRFOFFQbU5SRytETDhiYzk3b2FKMHk3U0kydDk3V01jZ1NE?=
 =?utf-8?B?OElWb1dGcE1kQTlaOWtmSURsRU5pYVBBdzFwU1d5V1I1cHBkUnloaThvVUlv?=
 =?utf-8?B?ZHFXR3hsY3NzNlpJd1FhR0ZhR25ySld6QWJ3MnArVVBaSlJINEFoVTB1QzdX?=
 =?utf-8?B?ZzduUVZsenZWam5Cc2hFZHpQcjhLaW5QL0ZIeUYrWVJSTFREMGx4aEd1cG1k?=
 =?utf-8?B?ZEZWOFBDR1dsRTB3aWNsRitCL2RyYm1KUzN1WFNET3RhUFAwbTdUV2YveWdM?=
 =?utf-8?B?SWlQaHN2SWg5TVNtUExjN25wZ3g3OTIzbStVYzY1T0tNMlVJYUthYnJ0SnlX?=
 =?utf-8?B?Z3BEVXdYUHowaFNRcStreWhaRHdleXdwSUpsTWNvZUpYVVJMNkNCbFg2Rmhq?=
 =?utf-8?B?aUFrRGNSTjJlZlV5MEY3OStvZFhiT0xUckc1WFAweWsrZm5wU0pIVGdXZmJH?=
 =?utf-8?B?dVdYWXU0REFncVhtN05SZVpPVDc1L0VSRUVGUnhlcmVOVml3eTlOZGZTRUhu?=
 =?utf-8?B?S2hPY3pSSXE0WnVyN2ZVK1lGOXpzc052eDNJN1ZXOGNzNnJmL0pWUUx4SVZN?=
 =?utf-8?B?aHVWMFpFaHVLUllORGJ3VnlocVFVdUI5UVB4RjNxcGEzcXRMenhXTFFlT2lB?=
 =?utf-8?B?dUZNQkxFUnRnSzlRbXVKYTBuUXhOQ1hsY0x3dlRPZTZVQ0VwSWVmMDZDZ2h3?=
 =?utf-8?B?aE5UeWVsaXZpUjNTSG1mc0lLYzYzME13WnliN285cHVuM1g1Z0JlWTZOcVl4?=
 =?utf-8?Q?3f+j4U+Q4mQhMYby4B4S/efOI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ui9qaXNlRm96enl6ZFB6YmJoYXFyUllsSkk1YXpSSlhtTEhUcXlBcC85Qmgy?=
 =?utf-8?B?Rk5rS1Y3VHl0U0pFNEVON2Q2N1Vvc25McVVweHhzdk1jU3pLSG9Vc05TK1lM?=
 =?utf-8?B?ZXd5a01ERkxNdjBONWFFSzlZRXRURk43QmZjSDcxVmRjV01WaUZXOEo3a0Zu?=
 =?utf-8?B?ZngwR21xL3UvTE9aTElIQzZKTDMrQ1VGYnFFUWdqS2kwT1RGMEJlMGFWa1VC?=
 =?utf-8?B?eEdkejVhdDhLN09DMVliSVF1bVpZeVovY0hDYnJuNk14ZVRIcU91RzE1azNI?=
 =?utf-8?B?VWRaRENyK0lDeFJBU3M3dUlMc3A4bUE0QkwzdThYcWhEQkpUc1VLSXdpb1Rs?=
 =?utf-8?B?SU1yZ1VISm16T0JBSWtnbUpldmZpeGJIdWVGMmh0MnZ2RWpteHpWb2Q4OHN4?=
 =?utf-8?B?NThReXRHTEkwc0tkVXlCZFQ4ZnZoMXM2Zlg1VnV3aFJ3NTBYYmZ2U2lzV1U0?=
 =?utf-8?B?VUhDMHBhZ1Evb2MwZEtaVE5ZZUZkOGxGME9BVHg5bjRkV3J1LzFwNkViazgv?=
 =?utf-8?B?MkVXclhZSVUrMlVKbkFQOG5PakQxdElnNVltdFhKeHpqYlcrQVdlYXFNOEpD?=
 =?utf-8?B?MFRVNmpaa1V4c25Nc3oxRmlmVmFJNldFZ1pqVjFkdTcrZC9tbDlZZnhMOUZO?=
 =?utf-8?B?bzdQVzAxcXl2ejdnN2ptVkdqM2xseHNUWEgyODlCSDVQUTdwYndvcyswclRE?=
 =?utf-8?B?UGIraDViMG5TZHpIeEdySlFoYkFmazBHWDdaVGx6VlV4Qk11eUZ1d2p0RzYy?=
 =?utf-8?B?U1JBUmJPVFRwUGF0MG12aUEvdUt3R0JlbmVhSVlJNVVMRy9EM3l5VWNFTS9L?=
 =?utf-8?B?bzlHMXQ0N1NBY0l1cHRDajBGdlVoNnJXbFBiL1oyYXl1NGNsSGlhbHpmT3A0?=
 =?utf-8?B?MjhsSDAwV0x6Q0FNT3U5bzNvdTJOMGozTEwwSU42V1ppMVJwWFRxU0tzNUl3?=
 =?utf-8?B?NnlKS0t4cU94aGxuZG5QZ2JwL25sZXJibktoVVNnUEo5Q1A3K21IcUREajQ1?=
 =?utf-8?B?QkttbkpKL2FobFVoZk5nUXZta1RnYSt1VlRReTZHSlRxdzR6Y0FndXlIMlh0?=
 =?utf-8?B?Tk5LTzZ6K2Ztdk9BWjhVd0xoTEFtUWF4Rk5jZGdMb3BEREo0OHIxNUp3d3RT?=
 =?utf-8?B?Wk05QTFFU0FzYlVzbHByVm81bWZmSnJkd1FUaDhlTWNsSmxaeFRDZHBCNnFr?=
 =?utf-8?B?UHdRNGM1Z1FMVjUxRDZzMnpkU1J6RXE1VWxubmg2c1RqMHZMZ3pjdThQYmwy?=
 =?utf-8?Q?qGFmq45v5zA1FS0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa81e52-84dc-4824-4ff3-08db944b2967
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:57:54.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR1RehG4avLSGBnDbvF2Txrteft2JJqBzbHcdl4TWZaTSaGETuYR0pce/bn7PekaDIXu7rwmPpGkFMFmIuoEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030161
X-Proofpoint-ORIG-GUID: Q5SkywYJSud-9TR17M_lPbkTtSnihClJ
X-Proofpoint-GUID: Q5SkywYJSud-9TR17M_lPbkTtSnihClJ
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2023 1:03 AM, Jason Wang wrote:
> On Thu, Aug 3, 2023 at 1:13 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>> The mr->initialized flag is shared between the control vq and data vq
>> part of the mr init/uninit. But if the control vq and data vq get placed
>> in different ASIDs, it can happen that initializing the control vq will
>> prevent the data vq mr from being initialized.
>>
>> This patch consolidates the control and data vq init parts into their
>> own init functions. The mr->initialized will now be used for the data vq
>> only. The control vq currently doesn't need a flag.
>>
>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
>> split into data and control vq functions which are now also ASID aware.
>>
>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>   drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>>   2 files changed, 71 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> index 25fc4120b618..a0420be5059f 100644
>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
>>          struct list_head head;
>>          unsigned long num_directs;
>>          unsigned long num_klms;
>> +       /* state of dvq mr */
>>          bool initialized;
>>
>>          /* serialize mkey creation and destruction */
>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>> index 03e543229791..4ae14a248a4b 100644
>> --- a/drivers/vdpa/mlx5/core/mr.c
>> +++ b/drivers/vdpa/mlx5/core/mr.c
>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
>>          }
>>   }
>>
>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>> +{
>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>> +               return;
>> +
>> +       prune_iotlb(mvdev);
>> +}
>> +
>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>   {
>>          struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>
>> -       mutex_lock(&mr->mkey_mtx);
>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>> +               return;
>> +
>>          if (!mr->initialized)
>> -               goto out;
>> +               return;
>>
>> -       prune_iotlb(mvdev);
>>          if (mr->user_mr)
>>                  destroy_user_mr(mvdev, mr);
>>          else
>>                  destroy_dma_mr(mvdev, mr);
>>
>>          mr->initialized = false;
>> -out:
>> +}
>> +
>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>> +{
>> +       struct mlx5_vdpa_mr *mr = &mvdev->mr;
>> +
>> +       mutex_lock(&mr->mkey_mtx);
>> +
>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>> +
>>          mutex_unlock(&mr->mkey_mtx);
>>   }
>>
>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>> -                               struct vhost_iotlb *iotlb, unsigned int asid)
>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>> +{
>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
>> +}
>> +
>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
>> +                                   struct vhost_iotlb *iotlb,
>> +                                   unsigned int asid)
>> +{
>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>> +               return 0;
>> +
>> +       return dup_iotlb(mvdev, iotlb);
> This worries me as conceptually, there should be no difference between
> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
>
> One example is that, if we only do dup_iotlb() but not try to create
> dma mr here, we will break virtio-vdpa:
For this case, I guess we may need another way to support virtio-vdpa 
1:1 mapping rather than overloading virtio device reset semantics, see:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html

 > Conceptually, the address mapping is not a part of the abstraction for
 > a virtio device now. So resetting the memory mapping during virtio
 > device reset seems wrong.

where we want to keep memory mapping intact across virtio device reset 
for best live migration latency/downtime. I wonder would it work to 
reset the mapping in vhost-vdpa life cycle out of virtio reset, say 
introduce a .reset_map() op to restore 1:1 mapping within 
vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we can 
move the iotlb reset logic to there without worry breaking virtio-vdpa.

Thanks,
-Siwei

>
> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
> Author: Eli Cohen <elic@nvidia.com>
> Date:   Wed Jun 2 11:58:54 2021 +0300
>
>      vdpa/mlx5: Add support for running with virtio_vdpa
>
>      In order to support running vdpa using vritio_vdpa driver, we need  to
>      create a different kind of MR, one that has 1:1 mapping, since the
>      addresses referring to virtqueues are dma addresses.
>
>      We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
>      supports the general capability umem_uid_0. The reason for that is that
>      1:1 MRs must be created with uid == 0 while virtqueue objects can be
>      created with uid == 0 only when the firmware capability is on.
>
>      If the set_map() callback is called with new translations provided
>      through iotlb, the driver will destroy the 1:1 MR and create a regular
>      one.
>
>      Signed-off-by: Eli Cohen <elic@nvidia.com>
>      Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.com
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>      Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>
>> +}
>> +
>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
>> +                                   struct vhost_iotlb *iotlb,
>> +                                   unsigned int asid)
>>   {
>>          struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>          int err;
>>
>> -       if (mr->initialized)
>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>                  return 0;
>>
>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>> -               if (iotlb)
>> -                       err = create_user_mr(mvdev, iotlb);
>> -               else
>> -                       err = create_dma_mr(mvdev, mr);
>> +       if (mr->initialized)
>> +               return 0;
>>
>> -               if (err)
>> -                       return err;
>> -       }
>> +       if (iotlb)
>> +               err = create_user_mr(mvdev, iotlb);
>> +       else
>> +               err = create_dma_mr(mvdev, mr);
>>
>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
>> -               err = dup_iotlb(mvdev, iotlb);
>> -               if (err)
>> -                       goto out_err;
>> -       }
>> +       if (err)
>> +               return err;
>>
>>          mr->initialized = true;
>> +
>> +       return 0;
>> +}
>> +
>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>> +                               struct vhost_iotlb *iotlb, unsigned int asid)
>> +{
>> +       int err;
>> +
>> +       err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>> +       if (err)
>> +               return err;
>> +
>> +       err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
>> +       if (err)
>> +               goto out_err;
>> +
>>          return 0;
>>
>>   out_err:
>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>> -               if (iotlb)
>> -                       destroy_user_mr(mvdev, mr);
>> -               else
>> -                       destroy_dma_mr(mvdev, mr);
>> -       }
>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>
>>          return err;
>>   }
>> --
>> 2.41.0
>>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

