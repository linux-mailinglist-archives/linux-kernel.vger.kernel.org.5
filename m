Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0E776D30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHJAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjHJAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:41:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE5826A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:40:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379IiRI2024562;
        Thu, 10 Aug 2023 00:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=nIPYkjpf4V7ty7blOs5azHr6zUz1bYVmIKs8pMtr7Rci9cUgRk+DJAAKXD8fLtGAcN9q
 wwM1Co1T4eH1sMAMK5Ses6m+rOV/YzGgObt9sfdK1GvzT0s/5gGTmvnUTkJcDUhxWsRa
 +n9unnRmehwDeYiSWse2DtN06Z9SK9Fd7msJ/xZVQgbDOk794X1Wgw1le7rIsZL1NLxw
 oDuRpqC5J2ZNK35kDRaxY77Tya7yXVfQ1XU4OH5ObuB6Rw/f7uBEWMxf4LNtrbvUSk2n
 /2Ki6ugD+/jLOSzQP9a5SzDl4zbcRXxQGfCzhvrGVeXpZf0lpwreMS+3PotutYvvRB44 Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbca25n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 00:40:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379NoDaE018751;
        Thu, 10 Aug 2023 00:40:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cve9k5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 00:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWqAvB8o3FcBaP5pCglwhIWb8oTbIpoho62tK1qZWoPDK/CpsiWSqVJGQVnb4JinH3g8EranDjaSGYMTITa2XF9qyp0cZ16O6ihZY38Jwy00kRsBJrF0aEaI4stQ+ti2xeqT98J9Vn/4rHVy/IFpfIDOSzMBOigxiFfVmyVkicMsPZSxVA8gt/mMESO2dRHwDdmfveV6341qWIq2I+mmcKeiiXdZgm6FXOcB49oBZ3w3Qb6UAUER08sIsjPDR3MaX8qsAHg9y8Twzr2K3aL5X3aupyaisHsZCyOnv9NB2fukDMHO/EmRwL31S6i0YbLDT+DoW09CdSWsPVDIESd71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=PqAl1Ygfj908kQ0a+shLjUYWqGp1+l1AWyaK96ayZH/a3WP/NLbaCDanPKVFDphPOQMQuHlp45ahRs2nKjILNFrsWKnJA/Ouk0Qy2NFW83QZMX/Pdeb3l7nZiBSVQZ4pb3eLTal2iDPZYrEYXRhienMUF5i+V4o/zrUqZ19ncWTWr2Jp3xl/952d1rcS7bSknMm+piDpxC2V3HghYQy3DxqaM8zc3UlZHAnGfhyU+6I1adxs0ZzpDbhEf+mIn3n3gEBLzVQLpQ8t22lkZebEZ0GCvMkaI+LiFavA2v4xvnqyzmvq+v/0UILUleaDJO7/au2E/6h8VaPv3GvY7wlmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=EeJYQCpXNYeNsk9gwuSjUSlqPBRpMTtS8DHovbFEtJ7RRSbCToTg4nyeaN7Qd+IUPmN2c78N7naiTq+/oEV4nQ3VBg2UG9obslCdKfxPWYlX65EQobFaGfZuoa1ckwJ8WMn4YIASB/k4doSCJkJBRdzaFkE41YFyoaCv8JgEV1c=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 00:40:09 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::7f3d:6dd4:15da:d3a0]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::7f3d:6dd4:15da:d3a0%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 00:40:02 +0000
Message-ID: <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
Date:   Wed, 9 Aug 2023 17:40:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
 <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9486a0c2-9b2f-441d-d1ce-08db993a55a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiLZ0Rz28B4hTOIiOb5aCl13qptJNwGoamoICs2dKoB5m/DY5NpirI3r+ZOdZrwzqqXlBr+WbCIavq4KHr3+UowVL7HuxbJW86TKTnQOIMFLPdiGWWZsKRFT2gcIHRiZV+59kjdQNJ+HcBqWJ2RK4o1Ma6mY9HUIxRLQfBrp6iaDEFzPSU0d4naZdRbbYh8AX91uj0+k+T4zReFm2WMjp4kC6GrNTmQc6BRv9xd0j4JroTSvEU/ZMMSs5Efgr+LEuxFwwBVQKQ9XRXL+XQ8o+4fEqQegDH41oWUVtTTguUSSbTnhI3865AkXFFywh3Y0XPCrM6+sgaqCS+D04RW1RX7l589aCd24AefMi6PKbKuukM4gSHt3j8hvb0+AfeE/J6y13OVbMSY9OeSY7b9LwqwGpSEvcJlaFwc6tQF2Uprtgm3/L9vNGI+FRLxa2XXwbjE79mt3WXtSPklWVsf9RSAxc8hXZgQ2BfpJeW/71epPWjAXdQfhC+RtXjMJzLkOY14CsFxLC1CFQBQVjkDctqF0sAqcQBODCcCdzX2529dKIeert8jzddRUxSJWeph9YCA+aOhLOaXb9UiDONTI4KA777NMDAOPiImXCeZJ60Whxd6bZPbKQTVDJsKbf119WhoRjJiw4FUI0+Phvpd0BQJB6RzjHK01bNhCRImiWjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6519.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(2616005)(6486002)(6512007)(83380400001)(66574015)(31686004)(478600001)(6506007)(26005)(53546011)(36916002)(966005)(54906003)(38100700002)(41300700001)(316002)(5660300002)(8676002)(8936002)(66476007)(4326008)(6916009)(66556008)(66946007)(30864003)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFSWGpHWnNCMGxXSUtNY0VCZFVjV3NZai80YkU5MU56Vmd0dXJCNWtpTmRN?=
 =?utf-8?B?V1V3Y3BMZ1dGSXFWc3BsVmZ2UmhENUtoekVrb1lEcnJkUk1VdU1oL0xNWFVV?=
 =?utf-8?B?RHRTM2NpbUZGNWRGWXpXTWlmVENsempzeGI4cDZiazdGb2N0b3Z5SEE5dnpI?=
 =?utf-8?B?VTRDeW1LVEpIdFhOMUtOZ0VqYWtrRkpEa1JwRXczODBDckxNR2FPYUV4OWtI?=
 =?utf-8?B?cmYvNXRacHVBK01vNGlSTWpkaUxLSXVPekpmdEhaNVUvUGtuT3lJNkw0M01D?=
 =?utf-8?B?OEw3d1ZnQ1pPOFVqa0pEM0VQMlBQbmNkNkRSVHJJdS9hQlRLdk1JVWNQLys2?=
 =?utf-8?B?Nys4a09nazdsRDMxSWs1Wm9LY0xJYWMrMUo2ZWFYeW1Zd3dJOFUrSkdhQnNP?=
 =?utf-8?B?ZG5KWUdwbEZJNUJjcjJZQkNuWko3bG4vQU9tZ3kvUU45b3Y1dVMvRFVwOHhJ?=
 =?utf-8?B?VEg0TFhpZWZjcnJGSk52REhGUzlFaVdYcEtJRW9jbFZSbmNnNEx2dGxyRUkr?=
 =?utf-8?B?bVIzS0F2REo4eWFvcXhKZEZZVnA0L1l2bXVXVGhpalUwbnB2WU1JNzQ3UGFP?=
 =?utf-8?B?bFNVNWIzUU1qUEhnbjhsZXBad2JPeldHeWh5MmZIaWlMZ0hBNUFTOG82YXBK?=
 =?utf-8?B?NVR2ajVsaGY0a09QUGM2Q2szVE1POVpRUDJsR3VNTk5mMlBzbGlrZkpBUHVJ?=
 =?utf-8?B?L3VabW9jemh5WVc2b2VUU1FwY1pxZG8xcFZwOTlJUWtDQ3dXSHE5bTUweUY0?=
 =?utf-8?B?QmJPYTArVnd1cXY1RS9sYTkyMzlXUGZJZ0phNE1VQ0JGcE83dHVBWnF2cWRF?=
 =?utf-8?B?TjZnTWEvTWUyNW54YVBwTEdRWTBmV216NVh2UmduNDM0emRETGI4VXJXc05p?=
 =?utf-8?B?c282RnY3TklLNjIrTDQwQUw3MS90NjJ5RHROdlZpSEVLdVh1OVpzMTlSZ2hi?=
 =?utf-8?B?STg0cTNFV3hRanYyeGJ2RXhEQmJiY090RGk5NlpJNTVBdTYrS2FKSnFRbnAw?=
 =?utf-8?B?S1FSUHdwd3BLV3AxOXdYYnZ1di81M2tZNlNoNHdLdVFCM05XVlhJZS92ZEhm?=
 =?utf-8?B?Q3R1ZjI5UEV1eGF3c3FLT2hJeTVCQkdVakpjOGU4QXdPY0xlWTc0bFd6L0Uw?=
 =?utf-8?B?VEk4YXNBRGFzY1JrcjNReEtFQXF1QzRmLzJEc3Urc2VKcGdvSTlTV0V1a0Qx?=
 =?utf-8?B?SWRxRUd3MmE0NEx5a2twVE00Yi9heUp6V0IwRTNIbFNvVjBQS0RmNDArdlRS?=
 =?utf-8?B?amhZVDlVczV4VFVvOTd2NkhZOGlWS3YvWHQyVUc2ZncvaDZXSk9BZWhjZzNw?=
 =?utf-8?B?MVU4ZDE5cjhWb3hZZHZCTGp1bk1GUHRHb1cwWGJXU0xEZjBtbTh1SS9CcEZC?=
 =?utf-8?B?UXNyOVJESytnUm1wVmhuWXY3ZVUwaG5YbWdZSjN0a2FJN2lCbWF3MGdaT3l0?=
 =?utf-8?B?Rks0aWR6aHkrbzJNdkxHVkIyNWxKL0N4UEE5TS9iVjJ6dFlyUTJ5VlRaOEZ1?=
 =?utf-8?B?QVBtK01oR3cvMk1VQXZrZVEvYlV5b2V2MzdtZ3NKSEk4YnpOYnRYbkhCYThE?=
 =?utf-8?B?QUNkS2h2Q1ZxOUErMDYzMUYzQlhKbjdienpZNVR1TmRlcy85QnExVnp2RWg1?=
 =?utf-8?B?eGgzcXFUU05kZXMyaVJTK3pPa2xrM3Jzclh6dnlqd2ZGM29iZDRpTTg2SnJj?=
 =?utf-8?B?U0kxUGZIaXRsTmFDUkZ1elBiV1NnWkVPNUFXUVAzTjZkb3JoZVdXZ1NsQm1L?=
 =?utf-8?B?NysvVjRDUS9tcnN2KzVQTitrV0NtZXBSeW1yNU0zSTI4NkZrZVFNNDErYVI5?=
 =?utf-8?B?VE1BQy9qNE5QTmd0NTR4V1RiTDJlbkRVUW5lQnh5ZEFWVnJxQUlvaGVicXZC?=
 =?utf-8?B?YVU2ODFrM2VYSk91ZG1jSERUTjhJeFJpRmxvck9VUWhUQjB2QXd3UElYS21j?=
 =?utf-8?B?RUJNTy9UTXM3aE5yK0N6Q3BOSmloZnJBc014T2dkSUk2eFlJdi90b0YrR3hJ?=
 =?utf-8?B?aXFURWM2VDJ0NXBUZXc0TmxkckhzbGl4T25tYlJRc1hwQlUrWEUrbTFwZXow?=
 =?utf-8?B?ZmNmVDZKTUVTTm4wdlJpRDVmaUdXMm81MEdPaWt1VFZmT3F6OUlqbWtPVTBU?=
 =?utf-8?Q?x6KuzjdurqVkHA6pNYecqXbp+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eFhTazB1OEJWVjZZWURsZ0xzZzhoZzlhVXVCbnhYZy9MeGRHWnpReGJ6S3ZZ?=
 =?utf-8?B?bTR0R0VBNTlVWjZqYjZGZzB4dUpZNlhnMmV0dElscmJ1SnVDZTB5NnRsZzlr?=
 =?utf-8?B?aXJ3c1RUL3U4a2lIcEZrTEhGclkzOGJ3R1FJaXh6U2N0RWJWcDIya0ZpcThi?=
 =?utf-8?B?ZkFJWlFUZHJFOStXZURveHZwMjhxbjMxM0lQYitKRThneENyZUtNekQwekt0?=
 =?utf-8?B?M1dZSWhiRWhHOHRCYytBdjgwV0JVbnZ1L2dLVVg2SXlmVlczb01Bay8zb1ha?=
 =?utf-8?B?U00vSy9uclY2SEJEdkJsZVZrN0M3RjdIV3NtUVJRUE5TOHl6YkwzMUtSNE9S?=
 =?utf-8?B?YUE5RkprdjNCTGh0SFROSzV4UTlrb3lGRjNrVmQ5RnlGRDdaYktzdGR3VnRl?=
 =?utf-8?B?ZG5HU1AwNGhrelMzYUhSOEZBZ1loOWFTWFZwenJPUnI2SGh6VndOZUpIdXln?=
 =?utf-8?B?dUluTVFQZ1dENlZ4bGJLdmRyanoyUHN6SkhVOUVZQURCOVI4dHI0dmwwOGNw?=
 =?utf-8?B?bVp1cXU5c1JPYWd4Tk5BSUFkOGh1TnExODFhUHhvS3llTElDMFZnRDRzUCtP?=
 =?utf-8?B?d1Vubk9zdE9ZS3FuL0cyU2ZaWTNJUTg1dU1kYXQ3L3hhZjlKaUtUQmowdm00?=
 =?utf-8?B?YTFPLytiY0ZMbkd4S0h1VTBzSytJNEpqVTIzRVBZYXIyUVg5cS9JYU9NSk9w?=
 =?utf-8?B?U3VSMjZHaVpPOFUvaExZdTR5dkRueG1oWWo5MU51Q1F6UzJTdTQ0MG5kUDFo?=
 =?utf-8?B?M0h2aGprSHlPcXplbk5ncGxzb1RiYXVrVWtjR295clptU2U5RGI4cHVSbHlq?=
 =?utf-8?B?Y3FJVmhGMzZkR0lLZkRoZXJhR2ZHN1BVaXRMcWtBWDZaR3B3WkZLNXVkblV3?=
 =?utf-8?B?RjdIUjNPdGZuWU1NdUU5SkpwTHJSM0ZrY1pzenJUbUlxUWxXQlBsRXI1bGtC?=
 =?utf-8?B?OE8vZHByekNhSHJ1alM5VHM0UURDaHNDck90dlQ3TmpmTG15WTc4S25hL1pC?=
 =?utf-8?B?c2lmalp4QTI1TkxOQkltTlhnTkFRTkNGMTBPUUVGeER5N1Y2aE5hMWlkSU9j?=
 =?utf-8?B?eVpaQUtzakFqU0dwcURZWlovSG1acEhYeHZuN1BKVGdFaVlHL0NmaW5TWHBI?=
 =?utf-8?B?elgva3E2REFZYVYyR1lQT2tIQzAvaW9ydVlRYlF6TStqSWdQakdtbkJobDIy?=
 =?utf-8?B?UnprcERHdEFsSmdOd01mMUZ3T0JwcVNkcms0SG1uRGZIZEVyaWNCdWlwdENT?=
 =?utf-8?Q?C0G30dTcF4wOTsy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9486a0c2-9b2f-441d-d1ce-08db993a55a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 00:40:02.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 638+1QaJ8KQLR6cC69vgq4fzBamHAKnMUJbyR6kT9y37g4PUoH6M41kn9Xgig7Rh4zG3lH9lFu6kB0pzVX8Xhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_20,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100003
X-Proofpoint-ORIG-GUID: bU2LF3ehltgtBONJRoxoKiqqx2wxfAFf
X-Proofpoint-GUID: bU2LF3ehltgtBONJRoxoKiqqx2wxfAFf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 11:52 PM, Jason Wang wrote:
> On Wed, Aug 9, 2023 at 6:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/7/2023 8:00 PM, Jason Wang wrote:
>>> On Fri, Aug 4, 2023 at 1:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/3/2023 1:03 AM, Jason Wang wrote:
>>>>> On Thu, Aug 3, 2023 at 1:13 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>> The mr->initialized flag is shared between the control vq and data vq
>>>>>> part of the mr init/uninit. But if the control vq and data vq get placed
>>>>>> in different ASIDs, it can happen that initializing the control vq will
>>>>>> prevent the data vq mr from being initialized.
>>>>>>
>>>>>> This patch consolidates the control and data vq init parts into their
>>>>>> own init functions. The mr->initialized will now be used for the data vq
>>>>>> only. The control vq currently doesn't need a flag.
>>>>>>
>>>>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
>>>>>> split into data and control vq functions which are now also ASID aware.
>>>>>>
>>>>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>>>>> ---
>>>>>>     drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>>>>     drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>>>>>>     2 files changed, 71 insertions(+), 27 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>> index 25fc4120b618..a0420be5059f 100644
>>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
>>>>>>            struct list_head head;
>>>>>>            unsigned long num_directs;
>>>>>>            unsigned long num_klms;
>>>>>> +       /* state of dvq mr */
>>>>>>            bool initialized;
>>>>>>
>>>>>>            /* serialize mkey creation and destruction */
>>>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>>>>> index 03e543229791..4ae14a248a4b 100644
>>>>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>>>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
>>>>>>            }
>>>>>>     }
>>>>>>
>>>>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>> +{
>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>>>> +               return;
>>>>>> +
>>>>>> +       prune_iotlb(mvdev);
>>>>>> +}
>>>>>> +
>>>>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>>     {
>>>>>>            struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>>
>>>>>> -       mutex_lock(&mr->mkey_mtx);
>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>>>> +               return;
>>>>>> +
>>>>>>            if (!mr->initialized)
>>>>>> -               goto out;
>>>>>> +               return;
>>>>>>
>>>>>> -       prune_iotlb(mvdev);
>>>>>>            if (mr->user_mr)
>>>>>>                    destroy_user_mr(mvdev, mr);
>>>>>>            else
>>>>>>                    destroy_dma_mr(mvdev, mr);
>>>>>>
>>>>>>            mr->initialized = false;
>>>>>> -out:
>>>>>> +}
>>>>>> +
>>>>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>>> +{
>>>>>> +       struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>> +
>>>>>> +       mutex_lock(&mr->mkey_mtx);
>>>>>> +
>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>>>>>> +
>>>>>>            mutex_unlock(&mr->mkey_mtx);
>>>>>>     }
>>>>>>
>>>>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>> -                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>>>> +{
>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
>>>>>> +}
>>>>>> +
>>>>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>> +                                   struct vhost_iotlb *iotlb,
>>>>>> +                                   unsigned int asid)
>>>>>> +{
>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       return dup_iotlb(mvdev, iotlb);
>>>>> This worries me as conceptually, there should be no difference between
>>>>> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
>>>>>
>>>>> One example is that, if we only do dup_iotlb() but not try to create
>>>>> dma mr here, we will break virtio-vdpa:
>>>> For this case, I guess we may need another way to support virtio-vdpa
>>>> 1:1 mapping rather than overloading virtio device reset semantics, see:
>>>>
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>>>
>>>>    > Conceptually, the address mapping is not a part of the abstraction for
>>>>    > a virtio device now. So resetting the memory mapping during virtio
>>>>    > device reset seems wrong.
>>>>
>>>> where we want to keep memory mapping intact across virtio device reset
>>>> for best live migration latency/downtime. I wonder would it work to
>>>> reset the mapping in vhost-vdpa life cycle out of virtio reset, say
>>>> introduce a .reset_map() op to restore 1:1 mapping within
>>>> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we can
>>>> move the iotlb reset logic to there without worry breaking virtio-vdpa.
>>> It looks to me we don't need a new ops. We can simply do set_map()
>>> twice
>> What does it mean, first set_map(0, -1ULL) with zero iotlb entry passed
>> in to destroy all iotlb mappings previously added, and second set_map(0,
>> -1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but
>> doesn't do harm) apart from vhost-vdpa itself can do unmap twice anyway,
>> this is supported today I think. Why there'll be such obscure
>> distinction, or what's the benefit to treat second .set_map() as
>> recreating 1:1 mapping?
> Ok, I think I miss some context. I agree that it's better to decouple
> memory mappings from the virtio reset. It helps to reduce the
> unnecessary memory transactions. It might require a new feature flag.
This I agreed. AFAICT QEMU would need to check this new feature flag to 
make sure memory mappings are kept intact across reset, otherwise for 
the sake of avoid breaking older kernels it has to recreate all the 
mappings after reset like how it is done today.

> Regarding the method of restoring to 1:1 DMA MR, it might be dangerous
> for (buggy) vhost-vDPA devices. Since its userspace doesn't set up any
> mapping it can explore the kernel with that via CVQ?
Not sure I understand this proposal. The 1:1 DMA MR is first created at 
vdpa device add, and gets destroyed implicitly when the first .set_map 
or .dma_map call is made, which is only possible after the vhost-vdpa 
module is loaded and bound to vdpa devices. Naturally the DMA MR should 
be restored to how it was before when vhost-vdpa module is unloaded, or 
if anything the 1:1 DMA MR creation can be deferred to until virtio-vdpa 
is probed and bound to devices. Today vhost_vdpa_remove_as() as part of 
the vhost-vdpa unload code path already gets all mappings purged through 
vhost_vdpa_iotlb_unmap(0, -1ULL), and it should be pretty safe to 
restore DMA MR via .reset_map() right after. Not sure what's the concern 
here with buggy vhost-vdpa device?

Noted when vhost-vdpa is being unloaded there's even no chance to probe 
kernel through CVQ, as the virtio feature is not even negotiated at that 
point. And it is even trickier to wait for CVQ response from device 
indefinitely when trying to unload a module.

Regards,
-Siwei
>
> Thanks
>
>>>    or do you mean it would be faster?
>> I think with .reset_map() we at least can avoid indefinite latency
>> hiccup from destroying and recreating 1:1 mapping with the unwarranted
>> 2rd unmap call. And .reset_map() should work with both .dma_map() and
>> .set_map() APIs with clear semantics.
>>
>> Regards,
>> -Siwei
>>> Thanks
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
>>>>> Author: Eli Cohen <elic@nvidia.com>
>>>>> Date:   Wed Jun 2 11:58:54 2021 +0300
>>>>>
>>>>>        vdpa/mlx5: Add support for running with virtio_vdpa
>>>>>
>>>>>        In order to support running vdpa using vritio_vdpa driver, we need  to
>>>>>        create a different kind of MR, one that has 1:1 mapping, since the
>>>>>        addresses referring to virtqueues are dma addresses.
>>>>>
>>>>>        We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
>>>>>        supports the general capability umem_uid_0. The reason for that is that
>>>>>        1:1 MRs must be created with uid == 0 while virtqueue objects can be
>>>>>        created with uid == 0 only when the firmware capability is on.
>>>>>
>>>>>        If the set_map() callback is called with new translations provided
>>>>>        through iotlb, the driver will destroy the 1:1 MR and create a regular
>>>>>        one.
>>>>>
>>>>>        Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>        Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.com
>>>>>        Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>        Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>> +}
>>>>>> +
>>>>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>> +                                   struct vhost_iotlb *iotlb,
>>>>>> +                                   unsigned int asid)
>>>>>>     {
>>>>>>            struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>>>            int err;
>>>>>>
>>>>>> -       if (mr->initialized)
>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>>>>                    return 0;
>>>>>>
>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>>>> -               if (iotlb)
>>>>>> -                       err = create_user_mr(mvdev, iotlb);
>>>>>> -               else
>>>>>> -                       err = create_dma_mr(mvdev, mr);
>>>>>> +       if (mr->initialized)
>>>>>> +               return 0;
>>>>>>
>>>>>> -               if (err)
>>>>>> -                       return err;
>>>>>> -       }
>>>>>> +       if (iotlb)
>>>>>> +               err = create_user_mr(mvdev, iotlb);
>>>>>> +       else
>>>>>> +               err = create_dma_mr(mvdev, mr);
>>>>>>
>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
>>>>>> -               err = dup_iotlb(mvdev, iotlb);
>>>>>> -               if (err)
>>>>>> -                       goto out_err;
>>>>>> -       }
>>>>>> +       if (err)
>>>>>> +               return err;
>>>>>>
>>>>>>            mr->initialized = true;
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>>>> +                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>>>> +{
>>>>>> +       int err;
>>>>>> +
>>>>>> +       err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>>>>>> +       if (err)
>>>>>> +               return err;
>>>>>> +
>>>>>> +       err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
>>>>>> +       if (err)
>>>>>> +               goto out_err;
>>>>>> +
>>>>>>            return 0;
>>>>>>
>>>>>>     out_err:
>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>>>> -               if (iotlb)
>>>>>> -                       destroy_user_mr(mvdev, mr);
>>>>>> -               else
>>>>>> -                       destroy_dma_mr(mvdev, mr);
>>>>>> -       }
>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>>>>
>>>>>>            return err;
>>>>>>     }
>>>>>> --
>>>>>> 2.41.0
>>>>>>
>>>>> _______________________________________________
>>>>> Virtualization mailing list
>>>>> Virtualization@lists.linux-foundation.org
>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

