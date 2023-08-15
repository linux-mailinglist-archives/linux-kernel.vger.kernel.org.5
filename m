Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D277CEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbjHOPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbjHOPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:17:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7F1FD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:16:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FB3fk8004806;
        Tue, 15 Aug 2023 15:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3tuTkkv8mVMrDcrH5V9HSfUKTFe0LSveXEXyEhcEsL4=;
 b=B4luoTrphyTb7tGtWU+h0A68UKki6RciqGFIWUik7Ib7A0HL0pDVM5rSYZulmVaw3fZh
 c6an+Hom8pa8Ll3MlZLMCsTUreaYhMrSJ9XTQ4Ds8SNZE5UE+fAECiB0mx2IgL5uVSFK
 euDJmCVNE0Cictu4n4mAj0/fE4fXun11NjIjQEjVFd1DOSCXKrm7aJU+NYWczhlT1c+r
 K8Bi0jX6FF9pXyEe5yWxprChL92DO8Lx8I9qtgISfEv62fNNj2Z81nmRM7BA0HqNOc/1
 Jv4oOLw4RkgYPbRDhKqtkVjtjQ9yBa25lwL9RdU6YrdAfziPbpX64rrKkEgw5zY7uy6x Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349cxnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 15:15:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FECIA6038913;
        Tue, 15 Aug 2023 15:15:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey706cma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 15:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDSocWBZ0Ilson1+lgqIygX8amppveaNrvpRrPObzjXY3c0x5Cx85J6t478tA4lUyZ8kJ6JbjAc7+mx3phL36czejhpk3lgV1WzQeUcp74WCOWtTnfVSXRCg1QfchdzkSsmUelo+kspraLYdA9/hKNXjEhoutOYjvWToL3vxzZHMJyTG1Afh5QX3l1Eqbv/A9/9fTc8f8ZYSKAiGKo6w37bUmGTd8DqSRPqPqdrkWQYRqlFs4v6bWq/bQZ3UNCAsOc32qdb9oZnB+hGfYHzp1vguKeqNV/urdqTaagokD7B8DWznpkKwFW1yOfTQjo3SGGuCNukX5xZJZbr5nDj7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tuTkkv8mVMrDcrH5V9HSfUKTFe0LSveXEXyEhcEsL4=;
 b=eajlCpdIhMujcv0/zPLfTA8TvOTUjwzvQdX3zXzIw65Xa7HiX9ECQM8OIfsyu3t3mW+v8KqP7B/FezIM1zydsXAyGvjisZtLf4T+7O3oAgObnanvZ5vChov+DF92jlxdp+RxmhOCuNcqAIgrdMFmVK+t4CUiIYg7CwcjZSaNL6OEQZ+KllDCooUgpR2kDHaFBR2hUbaX7nwhad1jndsxwUyOcqL2UrgilbN2jDrEMG4fc8hgMxQ7RjLFBpznRQm5kg4it4xyL1L6PwkAJZ5UYE/0oecTcZ0jG/vFQZV90yr6T0xbm9FFAvAlEiwr5+lGfliqXqEuphpYqiHqYHQMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tuTkkv8mVMrDcrH5V9HSfUKTFe0LSveXEXyEhcEsL4=;
 b=xWuKuvCwETb1dYyLd9VTwTNLNnK3NDcP51Ojyac61S40FDcwOzQxpDyAVSsaFLv4Vm1uXn/QQ3co0KuLIc7UwVNtM65WtaI7mX8JSBbxBzQ71xW6W8zRh9xMYiJ73CDl+/3DfTH2w/lNJRN9R1bHTyeDCH/29UW6OntdBi7Jhqg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6199.namprd10.prod.outlook.com (2603:10b6:8:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:15:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 15:15:47 +0000
Message-ID: <99d905fb-0732-bb7b-f631-f08c897f1d8c@oracle.com>
Date:   Tue, 15 Aug 2023 16:15:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH 2/2] iommu/iova: allocate iova_rcache->depot
 dynamicly
Content-Language: en-US
To:     "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, robh@kernel.org, nicolinc@nvidia.com,
        kevin.tian@intel.com, Robin Murphy <robin.murphy@arm.com>,
        joro@8bytes.org, will@kernel.org
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
 <20230811130246.42719-3-zhangzekun11@huawei.com>
 <a190ba95-79d1-e9e2-1f62-97aa94a4be7b@oracle.com>
 <36924a4d-e62c-68d5-3cb0-375b7fe1d5c0@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <36924a4d-e62c-68d5-3cb0-375b7fe1d5c0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: ba460be1-a740-4272-e345-08db9da2807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeQf4yJRiGXIIGsBwbeS7stnbIYzW76V9fe/IsOPL2WJJJmGm9mi1Mc+w+CZtv4aNIv1T5VxHoiklxM8Pp6/0VcvCTMGwAYtuHKhtcqNSvSh+f3B6O+qP3iNWZo8n2bFCBn8Hv/lkNWHcUqOqfqqp80+qBRPufuPNIiJmT905Ym7vBNgjiND8lqVTzq0ZQZNzKxVwbZ0wtucGzgsFwgzOgLYe71ZDol45wrLIaNhQzg/Yn/yZHln0ysAuzT5Sl9Kr8t8bUQgaZYq8A3KAuA3Xxfgt7oMMqFDuQrcWWBq7kUD4Qhzd1jjsFDvCRm//gDa5QeA/IxGdHrBMpL9iwcRy2ewD+ypdF1BHcU08fRqxcw1XVT0FNMZsDYg0dnnZ9+dxmfuZEqNsj16FBqHHgCbC7BF8G+ZHuOdS8UvVIOc+t1hTsh1v5MMPzFp3bFv3vTDFWpV767HYBdqEqflr6AnLSr48TGoO0jAndP3dkM/PZqGVWzj046SvwSlWDNgmUN8WsBuUkMQi43wpIUt5ArXImpPk89gGkKxNXXqGVZ0GMpBY2wfXZDMKdPS7Pd3/UfFCqsWvuclbuFWGX6I6pWvCesKT2OjgkX6Jm4nphAzBCmoEepFsNE1JQXtyYJBqEUKsl2dYViM/SrfdzKDsveu5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(6512007)(2616005)(26005)(6916009)(41300700001)(7416002)(66476007)(2906002)(66556008)(36916002)(53546011)(6506007)(6666004)(6486002)(31686004)(38100700002)(8936002)(4326008)(8676002)(66946007)(316002)(31696002)(86362001)(36756003)(478600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFnRERZa1NmelNXcEZ0MnA4MktXSmJoMTM2TW9TcGdWSUE2UXM0U0NCWm5B?=
 =?utf-8?B?d0cvWmRoZlBheVk4MVdEb0JZc0VMVnE5alpUbmlaMmxVK2tXc1FMQzdlYStZ?=
 =?utf-8?B?YjlXaXQ0bFdVZmYxdldWWXBKbEFTWktNSkpwMlY5Y3JWWUxoTG5HckgrQ3Nj?=
 =?utf-8?B?cnViNHZ6QjBzeENjR0w4Q2s1OFdiN3JveE80THVKRlhoVFVEYkFLa0pUTi94?=
 =?utf-8?B?RklvWkVGTk1NTEpqWGRwN0laUWdsNnRTclp3WHNlVVlOR2Flb2dMR2hwWW1z?=
 =?utf-8?B?Z0xsZXBRbmlKMzNEeUx0ZDBpYmpZSW9YUGFhSm1MRy9OSTlBSEF6ZVJIbHhh?=
 =?utf-8?B?am5kVC80OElZSVBQclZsbGFLMU15SzJKT3M5eHA5bzJvK1F2QmtDdldqMWtI?=
 =?utf-8?B?eDE0azQvc1hubHBIL3h5M003Tm4zYlNCNDF2UE5qSG45TjM2YVorNTVZNEo4?=
 =?utf-8?B?dEJJbmxXVTZjVWtUZzRialZNalVCcTdaQlN1cWl3TVQwWDFhREN1V3Bkc3hw?=
 =?utf-8?B?dHU4aURjcSswRjYwQWZpMVhoYWtDL3FORitRL05vUEFKOFdDOUZ0L0R1WXpE?=
 =?utf-8?B?VHVQb0xPY0NYdGtpeFZ2Tk41TW55SUIvRmpkSHZTSlY2Vjg4WCtBa2h1UERD?=
 =?utf-8?B?NDFlOWlqRXJ0UUdremtIWEFDQVJZK1A4clV2T1BPdDF0Nyt3WlhSV3dPb2FR?=
 =?utf-8?B?MEwrZWhGYzB2K1pWcXdWd3Avb1A2cGIreUowVWkwbVpqZ1dvT3MzTWtQMThv?=
 =?utf-8?B?TmpOWVluTlNiVXpkcE5GakJQdy8xdXNoVTd1VFRVVTBzNHhNSStjTG9YLzU5?=
 =?utf-8?B?UDVBSVp0RnhPallTUWdwaERjMERUeXN3TzR0MXVpUmVCNy8yTjJKSlFRL3Q1?=
 =?utf-8?B?Rll0K2d6NGZVdFRYUmRZL2dSbzRJZEFsNk81SzJqZWQzZkw0VG1QeFppZmFk?=
 =?utf-8?B?OGxuU1V6eEVGSkNHUWQyaC9lOVZTTXVlVUFPMVdLTEpMYVpTcGhtTDdJYlFE?=
 =?utf-8?B?ZzRtRFFtZDZ3RlhzN3B1eXVDMWl1OS9Od3hIVUlucmVLVnhqOVRmN1Nrc24z?=
 =?utf-8?B?NXJ5NkduaW45aG1KK0JKK3k4QXhiNVVGNm0zbU5zb1ZlVlpkbE4yTHBaOGZm?=
 =?utf-8?B?ekp4Y0NOSk0wblp2eWdRalp3TDBkWG03SlFaMk5pcG02bWxIZ2dXN1RLeFkx?=
 =?utf-8?B?OXgzbTBHZzY1TGkrSnNTaVpnMlROSThCUEtJR1lRcURPN0lhT0VnbnhGOGpC?=
 =?utf-8?B?aGtzWlZZYXJlYkZBZzBONkZvTTBJMnFPdmdCUTBiMmVlY0ZHVTkzaDZ2T1lO?=
 =?utf-8?B?bnpxMGhyRmE2bUo5UHJsNzQrR1VxQTY5ZnFubUdSa2ZrWlV6RG03UlFWU096?=
 =?utf-8?B?VEtYcDR3UHMzdDdLd3Z3bXFJLzdOYWZrcGdiRFFFY003UGdHUUtPek14b25j?=
 =?utf-8?B?TmtSdmphTlI3UmY3UVFwTnEzTHI1eC9oQzhaelN0blhPdHRkeFMyUnMrRDNu?=
 =?utf-8?B?cVlCSGYrTnNPZ3ljTlFsVWRqeTY2U3JPRjJLeGNyUjEzTExpd3lxdWw5dmFF?=
 =?utf-8?B?NmJnUFBzWHc3SUVEU0dGNzJITjZyTGhQalBrMzBJRHgvZEdjN1NtRmdHaFlO?=
 =?utf-8?B?UFFtNkUwWFRLQ1k4ZHdNM3VkbWdpWFVLZ0pIeDlYaDVsODFZSVlRTWhwMGdZ?=
 =?utf-8?B?Uzc4TEE4Z2t4dE9aTS9YN0ZrdTVJZGJZNjdURHI2dEJsbitMQUtVdVVHOUIw?=
 =?utf-8?B?T0l1VnFNcEU5b3daOENCa001dWg1blJ3RXBrNG1FQ0FMU09va0xEczE4YnVz?=
 =?utf-8?B?QUprOGVFK2t2SnBFRjdadkN5TUZOcWR1SVZnZGpsbVN2TkFWT094ejZ1NnRU?=
 =?utf-8?B?cTlmWEExL2RIckhXWEhxSFJSTTc4cDJVdTJRMVV2d3NtVHlMeVY0b2J3VHZj?=
 =?utf-8?B?T2x2U3NtUUxxckw4RmhMQW5WNjR4dEh1VHp1MDVPaUF1Q2hCM2hzc3Z2MlpE?=
 =?utf-8?B?dGFodDFyNERkK29XWWxsSkdyTlQ2d1lFa2lWTEQrY2UxNXZrVzRkUTdYZlVo?=
 =?utf-8?B?bWdDQWQwYjRWUzQyYWZ2NndpelB1cC9lWjQxanJKTkFraEZDL3Q5Rm0rbzZs?=
 =?utf-8?B?YnFqVFUwZXBNWlNVbDFTWjJXVGZFWVcrTk9HWG1zRmZjZGlyVDZFUzhkRjh5?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZzFaVmxIMjNzTktOa1dkOG9LaE1UTGdDRXR0OVRma1FGNUxYYU56NU1RVDd3?=
 =?utf-8?B?Um55REVIMGxiMEhGVHlHR3ZjMlU3dm9ybFVtVGZ0Qm1JZnVoNTMyUEc5Z0F2?=
 =?utf-8?B?K2ZHQ0R6dmd0aVNncUdBdkw1S2VUMW5qMUs3d2EvMUxxandCZjczM3kvYTd2?=
 =?utf-8?B?dXYwVTNpUXk5cW1WQ0t2NFpzdVV0WHFaSStCblBmN3BJeHFKSnF5RWlxbVBB?=
 =?utf-8?B?UWZnb1dLTDhIMDdNazAxRVVRTVRKemRvZUttYWlheFVIZnI0emJvd3Vxa0VJ?=
 =?utf-8?B?RkUzUHdaa3BXNmEwSWlSM2d5N3k5RzgwekVvZ3p3VGZkUm1vbDlNOU04ZGxP?=
 =?utf-8?B?aFY3SlJjWHNBckFWN0I5cUhRSVFIT2kxNkNsSk1EODdpU0dnV2dJZjNuNldq?=
 =?utf-8?B?L21BREx5T3ZKc1ZlQ1RkVEZPR0VadW4yNXY0a2NVU3hkaEowK2I3TjRuWHg0?=
 =?utf-8?B?ODBmU09wVFhqVlJKbmdwQ0V2bld2blFySVdicXJpTi9DRk1TYXZFZjBkVi9I?=
 =?utf-8?B?cmpKTDcrNEtGMUpyR3hUTGFHNm1ZU0I3UkVtbHpRQVo3aWRwTFNNYlVKcE4z?=
 =?utf-8?B?Ym5GWmM3QUY1bEJ5NnBVdm5RaWZLRFFsakdteXdZMmxvUGRoK2Q5bUxYK05l?=
 =?utf-8?B?SWZ6MURzRVMyeFRtSlN1Y291NjBwQ0RkV2NxK3ptR1dxV2h4dkVYOEEvR1Fv?=
 =?utf-8?B?QnpyQlNQeFdBK0ZXOFQ5WUMxY1dCZzZyaHkrT0s4QUlzSlRadE13WWk4Q2d6?=
 =?utf-8?B?QWZsTzJTaW13YXVyNEdWQmxOZUpHMDIyTTVTbm42N1YzSnp5ZHlJcDhiYm41?=
 =?utf-8?B?a0R6RGJTOHlYdHRBV1Q3K1VTK0ptWkxYUjBTd0NSUVN6OHpPQU96aGJlL1J5?=
 =?utf-8?B?NU5rRkIvaFhHaU1YSmExZjZVakl5YXEzUnRRU0I0L3FyYVh0cDVqS25uKzdp?=
 =?utf-8?B?amlmV0hmZWZsRVpZUDAxbnJHWnhQVG1xRlljZjlaeGRmcGh0QXkvQko2NjFl?=
 =?utf-8?B?ZDFvVDhpc0orV2VMUmdSdmNxS0VVelpNUFphNnY2QTVJWHpXZW9USEhrVXI0?=
 =?utf-8?B?WUN0dUNYaGRwMDg1VE13eWZXL0FiaHovZUFDZVB2RHV1d1pPczlqSGpucGxI?=
 =?utf-8?B?c244MXd6eWhXVDVCL2FzMUZ3NTZSS2ovaDdQdHcwcU1TMStrMTl0UjJTMEY2?=
 =?utf-8?B?NHJPOVpNbFlhbmtPNThCUy9meDFOMDAxMlIzWEVCcndiWnpqbFNKN3QyZ2hl?=
 =?utf-8?B?MUM3UHFrWStDeEw2S3JJbHFCd2NYY3c1QXRxYWkwdEhDaU43Wm1odnZXNEQr?=
 =?utf-8?Q?cYgZ2sURWNxa1cRkExNDEuXL6Wc8OIYgWJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba460be1-a740-4272-e345-08db9da2807f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:15:47.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCcbdsSMVQ0M9wWU3+u0e7H0At976WCnF5U9knZPqaNCfYWhl0a2oXWqegKP1cDWPneHOLrpxQTZzcRGabZBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150136
X-Proofpoint-GUID: vzfpcv4-i7bUqLMJ5rHrrGAKoa9a4W6v
X-Proofpoint-ORIG-GUID: vzfpcv4-i7bUqLMJ5rHrrGAKoa9a4W6v
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 08:18, zhangzekun (A) wrote:
> 
> 
> 在 2023/8/11 22:14, John Garry 写道:
>> On 11/08/2023 14:02, Zhang Zekun wrote:
>>> In fio test with 4k,read,and allowed cpus to 0-255, we observe a 
>>> performance
>>> decrease of IOPS.
> The normal IOPS 
>>
>> What do you mean by normal IOPS? Describe this "normal" scenario.
>>
> Hi, John
> 
> The reason why I think 1980K is normal is that I have test the iova_rache
> hit rate with all iova size, the average iova cache hit rate can reach 
> up to

Sorry to say, but I still don't know what you mean by the terms "normal" 
and "abnormal" here. Is "normal" prior to the drop in IOPS which you 
mention, above? If so, at what time do this occur?

> around 99% (varys from diffent work loads and iova size), and I think
> iova_rcache behave well in our test work loads. Besides, the IOPS is
> behaving as expect which is acked by our test group.
> 
>> ? can reach up to 1980k, but we can only
>>> get about 1600k.
>>>
>>> abormal IOPS:
>>> Jobs: 12 (f=12): [R(12)][99.3%][r=6220MiB/s][r=1592k IOPS][eta 00m:12s]
>>> Jobs: 12 (f=12): [R(12)][99.4%][r=6215MiB/s][r=1591k IOPS][eta 00m:11s]
>>> Jobs: 12 (f=12): [R(12)][99.4%][r=6335MiB/s][r=1622k IOPS][eta 00m:10s]
>>> Jobs: 12 (f=12): [R(12)][99.5%][r=6194MiB/s][r=1586k IOPS][eta 00m:09s]
>>> Jobs: 12 (f=12): [R(12)][99.6%][r=6173MiB/s][r=1580k IOPS][eta 00m:08s]
>>> Jobs: 12 (f=12): [R(12)][99.6%][r=5984MiB/s][r=1532k IOPS][eta 00m:07s]
>>> Jobs: 12 (f=12): [R(12)][99.7%][r=6374MiB/s][r=1632k IOPS][eta 00m:06s]
>>> Jobs: 12 (f=12): [R(12)][99.7%][r=6343MiB/s][r=1624k IOPS][eta 00m:05s]
>>>
>>> normal IOPS:
>>> Jobs: 12 (f=12): [R(12)][99.3%][r=7736MiB/s][r=1980k IOPS][eta 00m:12s]
>>> Jobs: 12 (f=12): [R(12)][99.4%][r=7744MiB/s][r=1982k IOPS][eta 00m:11s]
>>> Jobs: 12 (f=12): [R(12)][99.4%][r=7737MiB/s][r=1981k IOPS][eta 00m:10s]
>>> Jobs: 12 (f=12): [R(12)][99.5%][r=7735MiB/s][r=1980k IOPS][eta 00m:09s]
>>> Jobs: 12 (f=12): [R(12)][99.6%][r=7741MiB/s][r=1982k IOPS][eta 00m:08s]
>>> Jobs: 12 (f=12): [R(12)][99.6%][r=7740MiB/s][r=1982k IOPS][eta 00m:07s]
>>> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1981k IOPS][eta 00m:06s]
>>> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1980k IOPS][eta 00m:05s]
>>>
>>> The current struct of iova_rcache will have iova_cpu_rcache for every
>>> cpu, and these iova_cpu_rcaches use a common buffer 
>>> iova_rcache->depot to
>>> exchange iovas among iova_cpu_rcaches. A machine with 256 cpus will have
>>> 256 iova_cpu_rcaches and 1 iova_rcache->depot per iova_domain. However,
>>> the max size of iova_rcache->depot is fixed to MAX_GLOBAL_MAGS which 
>>> equals
>>> to 32, and can't grow with the number of cpus, and this can cause 
>>> problem
>>> in some condition.
>>>
>>> Some drivers will only free iovas in their irq call back function. For
>>> the driver in this case it has 16 thread irqs to free iova, but these
>>> irq call back function will only free iovas on 16 certain cpus(cpu{0,16,
>>> 32...,240}). Thread irq which smp affinity is 0-15, will only free 
>>> iova on
>>> cpu 0. However, the driver will alloc iova on all cpus(cpu{0-255}), cpus
>>> without free iova in local cpu_rcache need to get free iovas from
>>> iova_rcache->depot. The current size of iova_rcache->depot max size 
>>> is 32,
>>> and it seems to be too small for 256 users (16 cpus will put iovas to
>>> iova_rcache->depot and 240 cpus will try to get iova from it). Set
>>> iova_rcache->depot grow with the num of possible cpus, and the decrease
>>> of IOPS disappear.
>>
>> Doesn't it take a long time for all the depots to fill for you? From 
>> the description, this sounds like the hisilicon SAS controller which 
>> you are experimenting with and I found there that it took a long time 
>> for the depots to fill for high throughput testing.
>>
>> Thanks,
>> John
> 
> Yes, it will take more time to fill rcahe->depot, but we don't need to fill
> all depots before using iova in them. We can use iova in rcache->depot
> when local cpu_rcache is empty and there are iova magazines in
> rcache->depot, which means "rcache->depot_size > 0". The larger depot
> size will help caching more iova magazines freed in __iova_rcache_insert()
> which means more potential memory cost for iova_rcache, and should not
> introduce performance issues.

Thanks,
John

