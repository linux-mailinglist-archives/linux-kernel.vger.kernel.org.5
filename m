Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7475777D68D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjHOXM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbjHOXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:12:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB541FCE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:11:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FMicYu026072;
        Tue, 15 Aug 2023 23:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=CDCjC/YemKPmqY/JWqSLt4922LqxTxL5rsu08LC6AD+QPmpOUUvTLR1FIgPzTqhH3xJl
 Z7oQZq0cqgtgxNCZ+3+sxBZ0AfN/V0DiCFAquhzUV2/PI/vew8ffz5pRtR0bojvBnWww
 vFBQmm1EIbHfQw6T08v0/u5pP3ovJB/0JAL7CtCwHSPL8FnHFtfD8B3hx8nHtc6XFLry
 QcwyjGbGjRalvMKFZiYafpL8D5oJ/JXYZNR4voYlf9DV+IZvukQnq2yPUY6fYsG/Jojo
 50L/2N7sGT+Y3LJZTVcu7SBP85eWp7fTVZNw/Dx2ChFcUXyVKGmjYWbggJ1CRQb35vb9 ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5wty0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 23:11:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FLcQoB039550;
        Tue, 15 Aug 2023 23:11:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey70ngee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 23:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJSMXBlq9FyxuifeKf+qMMafaGVj62+XPLSpjW/4W5Tw/DzEVVzQU3hd0XpngPO0yU0VfXcNwUKsLTHrwLuhUW0Y2gYW1eEB1CMrlKhLEEMkUO/uWWL7CggrSrJpzB/dNzzPWOkqW2WPPBXrRbnc3mCbHSyHvF5INLUH7l4K9qFIkOlR4vcx+EaNFhmDuudr0l2Vi5TFwRaZmuY/j9RMrUJHzWYtrO+C0OuTHGb2VUvCyP3V4j+Gw4gXCLGpRTt1UaZ5E+w6wM/S1ngNqWQx6J5MyBqARDhYe0YKO1x1ZnF0e87k6KU+B1gyhH31smBaF/DiegZpoKs1GxldbSighw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=RUPOlkIGyuKKzSpT3gAadWDkw168ciYTbnxBgv26co0cMHy4RDbmGPO5rDoYFMoA/ujGIPMphA0Khh9DBNsensoSxXla/mUIcxbqilK8brX6V0OJ9cmALlNu5i9Cfy0Y4ODuM97LgtvliyyqpTVqUlHy715/pniiAUkc3dfm7pIxwJ8iCV0DvI792FwZpTawXfKDFIMPOd6UkQHHWNVjJslf2Tf/z9E5nz5vNNU60Es0nOnQqlfx4z2MHx5lZ5d0XKatQz4w1FFwu+URN+vYBI5SxV3G7qpzvdyxbk6YLEjAr5GKVynAeBU28Rg4Kn1hv7ZQhYocQlaILc8QVHEkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=b1CGtt+ffjvWoPVfTyJGB/T2tBkbCr16bPrub4rsHNTaG2X8vt1Kgc375oeBeYmYljzxlUuct77TMqJ7qhUu0aUgVLnNtNMQ59RDzhHyEPrEZZzvhkRrnnRGDpX05IlGfUsolUt4p+5ncDo1Sf3Ym4hYTKklVT7FmifKltK69Bg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4120.namprd10.prod.outlook.com (2603:10b6:610:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:11:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:11:39 +0000
Message-ID: <5f9d33ec-145c-7c41-989a-1d80af3ea19d@oracle.com>
Date:   Tue, 15 Aug 2023 16:11:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 2/4] vdpa/mlx5: implement .reset_map driver op
Content-Language: en-US
To:     Dragos Tatulea <dtatulea@nvidia.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>, Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-3-git-send-email-si-wei.liu@oracle.com>
 <ec351090ef971976f5149ca1a32563b1fb1bb857.camel@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ec351090ef971976f5149ca1a32563b1fb1bb857.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: c36d13b5-3b66-4ed0-ebbe-08db9de4fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcJC4+hW26sVps1H0J5ZrTaSrESmK1puqw01kg8Eku1EHs4teVuPyGLLOAJuoSOsYwAqGb2i0ckcsq+C+lSRVbqmRdM9K/Bybv8gYgSHW1qzLU6TK7SQ9NufDl0Q3Oflui8iKe6RYnA4wtPscx47vF5eyQzaKXLvrM0Dl3zv3JkwLULTWrhiWHtz8t00qoAvrCBblNY3gv/IKFG+jev6aUHJzx/3dsxVWOKhDFTc2VmPD5VUi+Xlx3MIy7WzTcobdRP3GljzpbVe0mCkaVAxPQrtyGwplwMbTCzp+bVz275YSDFwksmCf4IvOyuNZG0e+Yll74rnKT6SKffCfkm1gTe0w/bb8Lw9wjUuJbWtMoGhZ4zR/AL+I16argyyyf6NU7ynar1l5FG6lWyaSGKltoRW8kCsWJyjd9ccgEBTzeX29HYq9EdAFJBuOGSsqrpajRuldmRkfe3GlDGKy7M+KLJELDhbUmo/Wvkm+45bYoqp47sut7Jkqep9H4YKSXoOVGBvq4mu+pBVT66OZEeHTeQC0pt+MGKPqyGf/u81ef0S8qGIVYaqUtxwyAu7kfbRo28b2BGqB0ytB8lyXsAVkyN49S8CH4RQWoog3TYg7Ej+5j5ZCEiOrIZRqrUAs9KXifd0FTC67uD+QGfp5aWszeGbkF54MyKDkx1Y2JWBOZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(66946007)(83380400001)(36756003)(110136005)(6512007)(478600001)(36916002)(6486002)(38100700002)(8936002)(53546011)(31686004)(2616005)(316002)(26005)(6506007)(966005)(86362001)(31696002)(66556008)(2906002)(66476007)(6666004)(54906003)(41300700001)(8676002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lXSjd2Rmo5MzhRd2FPbTBia0o3TkJqaUNsd3FkbzNkYlYraWlSU2lMSVhI?=
 =?utf-8?B?V2d3SHNtVVhKVHFQUFBOdW1ROHA3dW8xN1lIR2g5aHp0VERiZlBRZkVYci8v?=
 =?utf-8?B?WjdYdVMzZHNxdDZraStEbzBqV3pnWkNTUjhac3Zhako5QXNQeG0xK3JtaWJH?=
 =?utf-8?B?MXVlSFVFQm9qWkoyWTVWcUc4eXYvVkVSOGFUUFMrZ3NaSW5XWWVtUHA0WGJ2?=
 =?utf-8?B?RHlYQUV2MUtieU5aKy9nWkU5dlQvdGhMUlRxaEhyNmdQeWhvN0dyakxScmpp?=
 =?utf-8?B?UEtORzdaWEZKajdKNHJ4WCtFbFJQRG13MFU5N0hxa2Roa2Jna1JvVDErWE0x?=
 =?utf-8?B?NnltYnF0U1dGRVZxSnRRSW96TzJsWWpqcjRUT0NDaDNnVk5ZbXpidkdmODNI?=
 =?utf-8?B?elF2R0FHVjFPN1VFYlQzZ2x6QTRadm1uVU4vUWJsdG0wRStSemJ4eERXcGVD?=
 =?utf-8?B?WWpDOVdtM2ZWYTR5Vm5waGZreHppeHlDOTkzVm0xSVhHK2V2N3NjelorSVZN?=
 =?utf-8?B?N05zYkM0MWwvR3d6M3lIaWVoYkxqeTRDTFVOVGphWTJVMERoWUtaVVJmQVQ3?=
 =?utf-8?B?ZjFiMmJpbkFHTldHSTRSaEJhOWZLMUFHQXdkV0tQbHVsMHNibHRBc0NOSGxv?=
 =?utf-8?B?WGVleXpUcXZVaTIzQ21kTTE1cDY3aklvVHM4dzBwVHQxMWw4U0VGblRROWx0?=
 =?utf-8?B?a1ZJUU5jb2FnQ2dPNm9oWlVNSkdwYS9aVHdha2Y5bUtqaDFabWwxbXBuRG5z?=
 =?utf-8?B?YTJmR1JhVlFvSFd0UnJ0cGtnV21sZjBBRWR2NDlmQ0Zlc1hWR3NLNWlGN3FY?=
 =?utf-8?B?akt5WWxnaWNic0lCSmd6c1h0dU03c0tGRkh6VlQxWGRUZzlXK1RlcjBDUW9n?=
 =?utf-8?B?WkpkUHRYaDA2Z3ZzVGV6SEpYcSsxZ2U1bjJLdi9rYWt5azhUY0tpeTkxNlpT?=
 =?utf-8?B?Ti9qK3lJeHBKSVdhL1IvSEcvdlJkbW1DbElycDRjYklkTUtEVG5kN2ZPL1hn?=
 =?utf-8?B?N2dtblc2T1UvN3JvL2ZvSXpUMTBUTU5mcllNcTd3WW1zL1JlenU4VlY2R09o?=
 =?utf-8?B?TzNsazhtb1lydVdTMnpvV284OVRDU3E2ZUtBTG0xUlFRV2phOXArNnF3RnR6?=
 =?utf-8?B?dVZCdGRhKzBWY0pnZjZVdDRlOVhOOHR2VFFwbWRrK0NDeVFGcG5SWjhNMlFy?=
 =?utf-8?B?NUJmaGpEVERsZ0VBM1didGZvdGRNbTdodHdrK3lHRVQ3anpPbWh3UDh3ajVE?=
 =?utf-8?B?TThFU0RiUkVDTTBib3NDKzlNSnRZTVJiR1ZMUDFWSlFJNGFPUzV6dlJvWEFa?=
 =?utf-8?B?YmE4aDhZNXpVTjRlakxWcXhJc1o0bDBvRTFYZU1uTWNQVitMcXdHS3VaTE1Y?=
 =?utf-8?B?R3lQZG9xMC9Tc1duVlRWNFNxV2cvZXRFTDNVWHV3RzFHQlp6UWZVb0ZXd0NM?=
 =?utf-8?B?d1dBTVVuNS9Od1hyY3V2TVFnZmpTb3hIN2htWTdOVk9YenR5UXpxcGdyMmpu?=
 =?utf-8?B?UGtVWXFCMjU4NTNoMDlYV2RVbko5WGNOQ1JzWWdFaWhZYVlZM3JiZHgxYStT?=
 =?utf-8?B?c3VCVmNTR1pDYml5bmVKREpmbFlZaFkxVWRva3RaSTYrSVFKUWtuLzBiN2hi?=
 =?utf-8?B?QXZ6L0tmM1JoVEpZdVRoWmxvLzBoOWJuOGlrKzVxTWFmVEQ2aUhYYXZvVDFH?=
 =?utf-8?B?ZG93Sjl1bzUzR2c3MzRqcXArenRIZjNXV1FpN0t1WXpONm83UXBNTFMxcDVa?=
 =?utf-8?B?WDdKa2lpeVh0Z0l2clE2WTZjM2hnWi9iN3A4cDhTN3phNVRmQS94ZVpSNTBi?=
 =?utf-8?B?WDFENFNNZmt4RXJ4a1ZMYkduNy9aWUlITTJXQnJENGdxSktzMGdrcUx6VkZS?=
 =?utf-8?B?REp6cU1takNKMHI3ejY4dHkzaHRmTis1NzdSdVlLWXg1YjAyZ251NEwvTFRU?=
 =?utf-8?B?dHovdW5WZ0g2QnBTTXYyeGtsZ2llZHpETDJENjRGTUVkYk1Qcm9RcjFFSFE4?=
 =?utf-8?B?MmNXcXFadjJBRzdWUitjbVJUN0RzR1NzTW5GMnBRS0JSUlFHLzdDaUVwWGkx?=
 =?utf-8?B?MmE2ZmZrd3VFeUxTK3FValNIY2dEUnVhYVhRVTNHenFjT2dGL1pVTm81aTQ1?=
 =?utf-8?Q?QPI04Y1M+1F0QMh49Mm4i9M3h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RWdTU1BIQUI3KzJINGFPdzJpcGpWUDZjamNmWGh4U3ZRSmlCMzQ5VTM1ZXYr?=
 =?utf-8?B?NkQyZHN2bGVxbVJUVkdBaFBsSTZMcXE4NjNmeWtvY1luZE1EOUJaaGNyS01J?=
 =?utf-8?B?bWhXY2hOMk9DRjcrQUdEeTZTTVVKMmxxYUtib0YzL0VOZlJNaUc3NVdlTkF1?=
 =?utf-8?B?bGlQN2Q3dUdZSXVFQVY0OUxzR3hTRS81SDhsRm1ZMHlGQjA1WXBRMndLNFM1?=
 =?utf-8?B?RnV0NVh0Y1F4RUZmSmNxMTdHRFg0VWd4NU5VUS81V2FVV1RaVEhBSXNHazdr?=
 =?utf-8?B?RStocnFqMWJnYlc4Mm0wZHFXblhVN2VyeGErMlhLVENXSHdMSmFCWVpwT2pW?=
 =?utf-8?B?cm9QTWdXNnF6VlpJTGpXS0pDdHJ5NDdHSEEvNWdmT2M0M1NZNEhrenBYS2Y3?=
 =?utf-8?B?eXlWUHFMdW9NMlZSNG51K0kvVi9xc1VkWXF1d3JIdXM5WkJxaDFBWlBZMWpI?=
 =?utf-8?B?bHdUVkZkTVltSmgxRnNUL0Q0bzU4WjNVOVpVTWl3NkNueTJ4YjcxNkZzQ1V6?=
 =?utf-8?B?WmhkZjBLcTBXeEJiU2tqcE5xcGhCaWJBRE1GU3pObmxpazJkbEZmbUEwUXN2?=
 =?utf-8?B?RWJVWmw0VDhJSWYwazU3RUZGRklkZFExc05oQS9nalFuTXhmUjM0eEhacnpS?=
 =?utf-8?B?SnlWRk82UmFWWUpGVnlyc2UzNFZHaWhjaktuNk1CUkFoWW1rRXBtVFQ0cUdQ?=
 =?utf-8?B?TSs3dWJBTkQraVpsdkFHV1BvbEhHcWhQZURwZitjZG54bHdUK3hGMXRJRTA3?=
 =?utf-8?B?VWJBN0psNGNvRVB5bkkvaWU0d0I2N1FlQXoxY21Zd25OdlJJZ0p0OVlTOTZY?=
 =?utf-8?B?a2hMb2pTR3A5QUxGSmJxRXdvZjZHV1J5WnBndUhrZTk0QkVaWGlrVDd3QVFu?=
 =?utf-8?B?eVd4WXgyWUUrOGFqUWl5WkJJMDVyTEpUZjRXT25LekkyVmVhRDdlQWVDYklk?=
 =?utf-8?B?Q2ZqL1NPRGlnZEFsNUV3dnk3cDFDay9HeHl6dHBrTmhLWkZVNVNvTTlWdWd1?=
 =?utf-8?B?eXYrd0lHYzQzcmk1WFh0VjlaRk93VlEzdWU5aytPSmNXUTY3bGNLYUU4djFR?=
 =?utf-8?B?OUlLL2dFYXBWbUlNYUZwQXBER0s5cFRpZnpjYXlRVk9TSDBCTGVSOURSUlVh?=
 =?utf-8?B?VEdoWTI3ZVprbDNjV1l3VkZ3eVQ0aHorNy9yRGNlMm1kTWJmM0pBczFINFcv?=
 =?utf-8?B?bGY5eXNQUS9YWEV0djZONUtZUmJuaXF4R3FvNzdZZUgzOFFFOHh4VEx0c1RI?=
 =?utf-8?Q?VYXYHZYXj6V+YkI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d13b5-3b66-4ed0-ebbe-08db9de4fadb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:11:39.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEl3E0T7rXVriQ1K67e/bwnDWWtTbEUlVYmGeee6i0HM/O2HvM9rGqH7LWtuXPmeFUffCkgriM/CGYZQ+2qAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150209
X-Proofpoint-ORIG-GUID: 8zkOgU5OBfM8jBMj79KwZYPdx95-YxFL
X-Proofpoint-GUID: 8zkOgU5OBfM8jBMj79KwZYPdx95-YxFL
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 1:26 AM, Dragos Tatulea wrote:
> On Mon, 2023-08-14 at 18:43 -0700, Si-Wei Liu wrote:
>> This patch is based on top of the "vdpa/mlx5: Fixes
>> for ASID handling" series [1].
>>
>> [1] vdpa/mlx5: Fixes for ASID handling
>> https://lore.kernel.org/virtualization/20230802171231.11001-1-dtatulea@nvidia.com/
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>   drivers/vdpa/mlx5/core/mr.c        | 72 +++++++++++++++++++++----------------
>> -
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++---
>>   3 files changed, 54 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> index b53420e..5c9a25a 100644
>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> @@ -123,6 +123,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>> struct vhost_iotlb *iotlb,
>>                          unsigned int asid);
>>   void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
>>   void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int
>> asid);
>> +int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
>>   
>>   #define mlx5_vdpa_warn(__dev, format,
>> ...)                                                         \
>>          dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format,
>> __func__, __LINE__,     \
>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>> index 5a1971fc..c8d64fc 100644
>> --- a/drivers/vdpa/mlx5/core/mr.c
>> +++ b/drivers/vdpa/mlx5/core/mr.c
>> @@ -489,21 +489,15 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev,
>> struct mlx5_vdpa_mr *mr
>>          }
>>   }
>>   
>> -static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned
>> int asid)
>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev)
>>   {
>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>> -               return;
>> -
>>          prune_iotlb(mvdev);
>>   }
>>   
>> -static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned
>> int asid)
>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev)
>>   {
>>          struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>   
>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>> -               return;
>> -
>>          if (!mr->initialized)
>>                  return;
>>   
>> @@ -521,8 +515,10 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev
>> *mvdev, unsigned int asid)
>>   
>>          mutex_lock(&mr->mkey_mtx);
>>   
>> -       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>> -       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid)
>> +               _mlx5_vdpa_destroy_dvq_mr(mvdev);
>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
>> +               _mlx5_vdpa_destroy_cvq_mr(mvdev);
>>   
>>          mutex_unlock(&mr->mkey_mtx);
>>   }
>> @@ -534,25 +530,17 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>   }
>>   
>>   static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
>> -                                   struct vhost_iotlb *iotlb,
>> -                                   unsigned int asid)
>> +                                   struct vhost_iotlb *iotlb)
>>   {
>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>> -               return 0;
>> -
>>          return dup_iotlb(mvdev, iotlb);
>>   }
>>   
>>   static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
>> -                                   struct vhost_iotlb *iotlb,
>> -                                   unsigned int asid)
>> +                                   struct vhost_iotlb *iotlb)
>>   {
>>          struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>          int err;
>>   
>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>> -               return 0;
>> -
>>          if (mr->initialized)
>>                  return 0;
>>   
>> @@ -574,20 +562,18 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev
>> *mvdev,
>>   {
>>          int err;
>>   
>> -       err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>> -       if (err)
>> -               return err;
>> -
>> -       err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
>> -       if (err)
>> -               goto out_err;
>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>> +               err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>> +               if (err)
>> +                       return err;
>> +       }
>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
>> +               err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb);
>> +               if (err)
>> +                       return err;
> I think you still need the goto here, when CVQ and DVQ fall in same asid and
> there's a CVQ mr creation error, you are left stuck with the DVQ mr.
Yes, you are right, I will fix this in v2. Thank you for spotting this!

-Siwei

>
>> +       }
>>   
>>          return 0;
>> -
>> -out_err:
>> -       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>> -
>> -       return err;
>>   }
>>   
>>   int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>> *iotlb,
>> @@ -601,6 +587,28 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>> struct vhost_iotlb *iotlb,
>>          return err;
>>   }
>>   
>> +int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>> +{
>> +       struct mlx5_vdpa_mr *mr = &mvdev->mr;
>> +       int err = 0;
>> +
>> +       if (asid != 0)
>> +               return 0;
>> +
>> +       mutex_lock(&mr->mkey_mtx);
>> +       if (!mr->user_mr)
>> +               goto out;
>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev);
>> +       if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>> +               err = _mlx5_vdpa_create_dvq_mr(mvdev, NULL, 0);
>> +               if (err)
>> +                       mlx5_vdpa_warn(mvdev, "create DMA MR failed\n");
>> +       }
>> +out:
>> +       mutex_unlock(&mr->mkey_mtx);
>> +       return err;
>> +}
>> +
>>   int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>> *iotlb,
>>                               bool *change_map, unsigned int asid)
>>   {
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 61c10ba..399a690 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2816,7 +2816,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>          unregister_link_notifier(ndev);
>>          teardown_driver(ndev);
>>          clear_vqs_ready(ndev);
>> -       mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>          ndev->mvdev.status = 0;
>>          ndev->mvdev.suspended = false;
>>          ndev->cur_num_vqs = 0;
>> @@ -2827,10 +2826,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>          init_group_to_asid_map(mvdev);
>>          ++mvdev->generation;
>>   
>> -       if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>> -               if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
>> -                       mlx5_vdpa_warn(mvdev, "create MR failed\n");
>> -       }
>>          up_write(&ndev->reslock);
>>   
>>          return 0;
>> @@ -2895,6 +2890,18 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev,
>> unsigned int asid,
>>          return err;
>>   }
>>   
>> +static int mlx5_vdpa_reset_map(struct vdpa_device *vdev, unsigned int asid)
>> +{
>> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>> +       int err;
>> +
>> +       down_write(&ndev->reslock);
>> +       err = mlx5_vdpa_reset_mr(mvdev, asid);
>> +       up_write(&ndev->reslock);
>> +       return err;
>> +}
>> +
>>   static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
>>   {
>>          struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> @@ -3154,6 +3161,7 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev,
>> u32 group,
>>          .set_config = mlx5_vdpa_set_config,
>>          .get_generation = mlx5_vdpa_get_generation,
>>          .set_map = mlx5_vdpa_set_map,
>> +       .reset_map = mlx5_vdpa_reset_map,
>>          .set_group_asid = mlx5_set_group_asid,
>>          .get_vq_dma_dev = mlx5_get_vq_dma_dev,
>>          .free = mlx5_vdpa_free,

