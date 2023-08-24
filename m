Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE0786C86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjHXKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjHXKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:02:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90A1984
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:02:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwUUm025866;
        Thu, 24 Aug 2023 10:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AgvR4we4/CFelnaZjLL5q3SEXoq6ycxE0FsMljvmCnQ=;
 b=GB7TtpUNdDU5c0uRDrpvMqIRROM7PyaJ6qv7G/ZpdxBM6Nb2r+DIbBRZVaGpWGNCkuTE
 /CzUZ7UBJc1Eky3g3LocqxQVxT494x23Nh6z4fjDfcTiPZtSs16Snb2bzNtFaMauFSUV
 hIx/YV9R3aWoMbUC7vszM+Wej9kGx1Zu48/B1kUcuKrV6Hh+DucP500faIJospEDwQ7M
 0jteHiNcE/Y8i/iz4TsJVTYpbF0jMpPlxBghU5BH6oRJ0KVAT/LvYjLws5ZvalGBQ1pm
 042t8+kp35O+TVKs5hGvww2lYhywLYmackAEaJhEtcPFTz2AF4ZxxgEa8zMceNT9xlTG vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvuqyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 10:01:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O8YMv6033218;
        Thu, 24 Aug 2023 10:01:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yw97h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 10:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN79jWTwfqNXIKKe2eCjb8EE9q16oQp8GxaXsxV3imLgHP1vGKKdh3rNAGGWUd2Ufs0xiFD2xAjfGbuPbhkiJjfUCrB0tjUqGaXaRzLwrYGjUOPHW4HuH8tOYjwTJdwKIc7S3VhhM3JbCJ+lQi8EqAday75Bz6yrc39N+38tiCppYLg0Kr7zC8P4+fMCa6bBcCQl0djUan0ajpLFPJvC0TZnCQrf8Krwzu+1AwiuBCH62wQ03i6jtBOcRy6CAZO61J50EFzXOk9O7Ky5XiDjxzwS2xohCvCH+nRrAEmtlzwlT46P8vkX9ff2cbZ3mNc1Qyla89TJguEWqRBD9HBURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgvR4we4/CFelnaZjLL5q3SEXoq6ycxE0FsMljvmCnQ=;
 b=fqGqzfhE+Oci8h7OxAdK5OkoHyPpsbhITefLChfQdCAYyW+4OJySqxpciQ3x+Kelh5ldyZfqmH5SuEVN1yLX/5LG6FJFsMD68ROTCGP8zf1zDvZr4RuovGz2s9My6U8sFCpkXESmIUNL41lTyfB2xSTHII/1B9fKVIqSjLb904Kdc9Phe+UsIz+vnuzbJiNGz/bA5gmdjBjOn0kxsXqA+XavTGTtG4Ojsom/s5Qnfg8ZUXeOvZrmBRev/4i1sMsdEMI16l6CHYTKJ8apvYzskHn7Q/xo3pv3IcV7u5CN8IoeJTJYDB0LuF9pobk/fgCQwdyA2jYjYZIAZKZYy058CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvR4we4/CFelnaZjLL5q3SEXoq6ycxE0FsMljvmCnQ=;
 b=FY1q4hs6DuokhT1i8Q9Om2IjGwtfSwapdS1d53U84n0lS1pSh5jpPcual2gv9xcWhya7h8kmJK+yPYswVWe2P5V5VY+VOzeHJNA6YHwt99p/NNDmvpddQ3IVRqNpvDxYVQE/xlk/euz/HOGUDgEKYkpGocOrXXAGPwRR1hEtWJk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA3PR10MB7070.namprd10.prod.outlook.com (2603:10b6:806:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 10:01:51 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:01:51 +0000
Message-ID: <a482222a-8ade-1b31-09bd-1977171aae08@oracle.com>
Date:   Thu, 24 Aug 2023 12:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] pcpcntr: add group allocation/free
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
References: <20230823050609.2228718-1-mjguzik@gmail.com>
 <20230823050609.2228718-2-mjguzik@gmail.com> <ZOb4Mwv5eFv2n7R8@snowbird>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <ZOb4Mwv5eFv2n7R8@snowbird>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0047.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::22) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA3PR10MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cd2b86-19b8-4dd2-69f8-08dba4892322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI+5nlNA5wHRhYzW5Mon+icupSkOkHzh4OwTOov1lpF0y7kghpGC7M9LMIpz92IvKw8vPSxhjatSLKA/+aLYhXGWkZ+gqoM5FiqDhD9+JaCmw2EeqHG/Wmx4ECegOr020j/JibsdpDElb1g+xijWxusJD12VbaG6zfvZYg+aFZAWN/Lkhzq0FX/RnQzziqrt2Hp2A8hNRFQ3kZCv3S/1aV5K0LmBonaAxACfgP8PXr5pMIncJHM2Cl/qwCIiIX8HwbXlcpYb9t9cR8o6Zb9uS6AeOHw8/wMWFetLROR//f5Eqfy36Qtvs/q+jpqF+HWy7vsh1Nqu9IWRYkBVUrn+b85FJmENbD9ekxnjUkl8Zd+yLAgO3AGCcCQ1LmUWk4aL47AxVL+jxAxxViuRcb0owLFqqq0Gr4sneAT8PDBmKHb/d8RerKDA6BiaruuIQSlbpFCS4wPwvLhD34z4RKIejeFfKJgaI/ILgd9Y31uuv6agiR3yhiPowYXtA+nHkzsNzkVGAfkxRBY4emWdBZrWs4YYkWmQS15lTsyuO/iQsflE0ARBpRjYM7QR+E2sEJnM1/+Ih2kURMSoiEFoj7YFRTVY+f4reDui1o39lKFwEMXjsWw32TL0yBjjcUGcjvzXebbdgzsDQLYpvW3Y59PdkPyA+uWYYksLMgKLMOPcS050KJlsGjhOyIOYffIt5E1/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(66476007)(6512007)(66946007)(66556008)(110136005)(8676002)(8936002)(4326008)(2616005)(316002)(36756003)(41300700001)(478600001)(6666004)(6506007)(53546011)(6486002)(38100700002)(4744005)(2906002)(83380400001)(31686004)(86362001)(31696002)(44832011)(5660300002)(26005)(133343001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUw4RFFwdEF4b0k3QXF1Qy9HU04zdCtBbm9SM290dmsyMlJSRkRzL0IzTW4r?=
 =?utf-8?B?eGJ2SmcrdUZZR3cxSzJBVHduS1RHNmpNNXR3VGpTWExXWE1nL3AwYjVuNmFQ?=
 =?utf-8?B?TC9malhaL2FpcmtxbjFNamk4MkRQTXRRN00yUmh1clRWcmxja0JyeHpRaGU0?=
 =?utf-8?B?amo3QmdSY2pod25WdVpRY0dtc1VwOUxBbmc2eGtXQXA2bkttdC9pNmhvZ1hL?=
 =?utf-8?B?WVlRMGZBT01ndWtEeXhabzBpaDFqaTUzS05rdEhMMUtlVnlHQURJcTVsdVA0?=
 =?utf-8?B?cWxSMysrL0tWZGw3NTB2NXFvRnBkL2tOUEJyUzNIL3paYnFMa2xZUHpPY2Z4?=
 =?utf-8?B?VWNDSFFwUWRoMnROUHRya2UweUxEaThmdjJVeE5nQm9MVE53bElCc2tRTDEy?=
 =?utf-8?B?MmM3bUVFeHFobjJvM3NRTkNERDVaSEt2djVxQ0ZyWTh6eTZ3ZVB2WklrN28r?=
 =?utf-8?B?VXVVK25DZVBFT1U1cmY5bGJFczhEd0s2aklTKzdkYVhSSVlNUEs0TnhJZmhv?=
 =?utf-8?B?VFR3TzB4NkJ4MmNzVG1pZEJ1RVROakVEQnp0dHlXVllWZkRLNVgwZnQ2L3Q2?=
 =?utf-8?B?T3d6bmZVYmk3UHlienJxSVhlWHoyL2dOK3NHMldFbzJxVnhMTGhDazFadUli?=
 =?utf-8?B?Z0tlb01tTlg1bXlhK3BkNitYbk1LNzlzK1k4blRBMzl1b0I1UTBMT04xSG5S?=
 =?utf-8?B?aFJYOFN3N0RRVGhJUjRRRGcrMXFYSnhMRUZiYk1oYVovY3k3L2Q4OVB6cE8y?=
 =?utf-8?B?NSs2bkxJdHlGbHNNRTc5Wng3S3UxQUlmVXV5REpzbUFkZ0hIMGZSZU5ubitT?=
 =?utf-8?B?Y3JaTkFWdlpNQ3FaQi91OGg0TGN2K00vNEFYQ3RZQVgrQWZ0YlVqYTduY3Np?=
 =?utf-8?B?VHQxSy9qaUVZSmIxRXdqbzcwNXZROXdNSHhMSkpLVDNXbzBzU0dDdXN3aGJl?=
 =?utf-8?B?VFUvQ2tKVnJGekxETTNSbDEyWWE5THdzWG9iVWtYMEJySDhRdGpMTFNtTGZF?=
 =?utf-8?B?dHpMNnRybko2ejJqc0FLQ3psZy9KNTljSGxtSEl2d0c4dDEwNXUvaHZZdDFD?=
 =?utf-8?B?dXR4bU8wTWd0VHR0cVMrR243ZExGbmhIenIvTWNIU00vaUVEcFlnbitMdHVH?=
 =?utf-8?B?OFlnTlZiRFRERnFNd1FYaXRXWXpNZ0U4R0xtR0w0ZndvbktpcHZiMVZKZUlG?=
 =?utf-8?B?OXZHZXFEMzNpQWhxbDVzbTN0QWFuUGJJb2t2aHVvMS9iZmNFT0ZWWlhyR2JT?=
 =?utf-8?B?UjJvRm8zUW53WWZPK2xuYjBtZUJjVVlzSXU0aXA1MThZNHVGYVpyM1YyVXdJ?=
 =?utf-8?B?WVVpYVpVdFRIZjkyL1ptMFI0NUZLMTFxdStUNU1MQmVOT3lnb2VDOGZoNjNu?=
 =?utf-8?B?SmtRQUFJV2tueFZVRFFZM0JnWk8yUTN2Y0ovSW9OeWVqdjN0WDlubk9qSGFG?=
 =?utf-8?B?MGxlZi9aanNUM2p2TGhsMHBQLy9iTzJyaXBuV1hsOG1EQnFPQjJTbEJ4WWlR?=
 =?utf-8?B?bTZQTTNrRFM4YzUwZnRTYjhqWGxxUlp1RzhQOTNqOFF3b2orWVBpUWFBNWEy?=
 =?utf-8?B?MURIaGV6VGtpVmp3Y2JHbEl2WnBsOTc0UEEzQWtmc3lTYlpuYUoyTDNjN0t2?=
 =?utf-8?B?N3c3MER6ckQzR3BOOVd1Qmg4TWcvMDdEMmo5REFxdSt3Y01oaXpxNEpTc290?=
 =?utf-8?B?OG9FR1RpU01rNE5XeGQ4ZEdPV2RoTlh1VkdYMlIyYVVZdXV1SnZTUlp2NzFX?=
 =?utf-8?B?UlJKM3VBcFFWK2F3VldGZkFVb093V2FZWG5tNUJpV0h2WlNrdklFYU1DckpJ?=
 =?utf-8?B?djg3ZTBtZGplem9QTGlzRk9IcDRSSERicUhlK2dyd056SXphSWxnUjJEdnRp?=
 =?utf-8?B?M3ZTWmp3ZWRTTWVEdkJnRHg4MC9IUlRRcjdxeUdjMW9teHF0NEdVTWFlV0JF?=
 =?utf-8?B?YzJmVjc2UmZLc2RhY0FTMmxhWVlPUUdweVd1RnVjMjJObXJzN1RMaEFvM2lu?=
 =?utf-8?B?Zm4wdGhmK1ZJVHVTUTFVUXB6aVB2WE93cmJiVWN2QVRSUnNOM2FINWJHS1R1?=
 =?utf-8?B?NkJ5aStQWWEwVGJUZ1BkaStKU0MxUXh4eUw2SHZKb2MwZDZLV01DR01NOUF3?=
 =?utf-8?B?TTl6Z3hNZE5XeU9wblFIVmFXWjlUNGNTUHo4VjNZTzJmVGEwZVh5OFU1SXZi?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ck05ZHNyemVmRTloSWFCeW1BZ3AzeEg2QVVxUVYyVWlkRTdXNGxwRm0xZXRS?=
 =?utf-8?B?YlB0dGRIbTBGWk9ua1pqNURLNDdkbXJjbEw5L2FIUndueWhub2Y2NkgzMmN4?=
 =?utf-8?B?cUtzT0FoNk1vUDFzSFpqWlZYQnBZYmFSUEsvWXl4eUE1RjJBeExkTkhtNjgw?=
 =?utf-8?B?bjJsSXEyK1VaQW14Mm9aOFBZVzRoSEpPbStPNlN0WTlzbU41b2E3MStGVG9u?=
 =?utf-8?B?U2lRNjN3SThCbXY4WlAzdEh1c2t2VVFJdlhNWXRRdmx6blZxdGxWcmVlcFFY?=
 =?utf-8?B?L1ZFRFpRbUdBVFFDUXVXL3hRdCtpSDRrQUZ1OFdyNFlkN296bytDM0dFUXpM?=
 =?utf-8?B?UUYzU0d4OWRRT1lMV1gzaUpPOGNCaVpnc1JrZWZ6ZlFWbmx5ZVhtak5RS0Uy?=
 =?utf-8?B?WTVyMUJhTXU4OUpWaUtTKzUvU2RuNDJDQi93YW1zV2FzRmJoeWZybTZuaDRr?=
 =?utf-8?B?S0lUWWUycWdpOFpMYTZlT0hvTWo0RlR3cnNibzlDSis3TzFOV3NPRVFTWktJ?=
 =?utf-8?B?OGM3UEM2Qk1WS0k0UDV4cWNkL0R0NDQxRkdSMTE3dW0xc1RCd1IyTWJvY3RG?=
 =?utf-8?B?aGJjS2hPbXJJcEdWUVF1MTkvVjM4R3lYTHdRbEZsR3lrZklWRHhOYjNyMTN4?=
 =?utf-8?B?NmQwM3JDZmlWcWk5VEZwbVo5dHBxN1dHMWFMYXhrQzJJUE9vcW9oQjBRWG1y?=
 =?utf-8?B?R0F4Z3ViZy9UbUlBcUFNOFVPVnNoMUs5UTFXSG42aUtNR1NWeHZqVW90MFR1?=
 =?utf-8?B?OHliWkhYSTk5TzA3TlNiRExZT3VGNy9WSVcvVzNoSWpDZkJYNTV3ME9PTGJI?=
 =?utf-8?B?TVhvblQrZ0hpYmVTOC9ZS1d0RGJEY1FtUkRQQTh2R1M3eHZBdGhseTllUmlj?=
 =?utf-8?B?V0wwT2ZONkZQbU4xRWZqVVJQRjY3cVhQY2t0OXRTcG1ZQW5kUHVIazBkR2pB?=
 =?utf-8?B?WEZReHFtUWVsbWJkMEEvTlJJZWF4Njd4d3ZNKzNjdnJXeDlSaGtuZVVDdW1s?=
 =?utf-8?B?MEVvYVhCV3JCV1NnWHBzLzJmVjFqWWFLTGRHN2lwYzZPV2ZQZlRQVzluZDQw?=
 =?utf-8?B?YjBBc1k5b0daaEE1M2tUUmE5OFpiQ1VBZ1U2R0NvakxFR0hPWkxNT1V1Rzlj?=
 =?utf-8?B?S09pbTZUMGhDQ1M3VlhKSVdMcG1iTFFweCs4a0pRRjJKMTRRTU1zZndIbnhy?=
 =?utf-8?B?OU9VUW1ubW5mZVloTmFNQTY0K2ZUdnRBeUlWVU8zTXdDdzBFbHpISUEzZUZH?=
 =?utf-8?B?YXpCSVhNQ3lLZzlCSW5Od1RRd1p3NmlTeWs5bmtVclN2Skp3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cd2b86-19b8-4dd2-69f8-08dba4892322
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:01:51.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuCpRjqQ5jQf3wCXuIcA14RuhWa/WR+9guy3KCYo2SImzeYf1nThVqSb1dNVL78H6Bqxn55ii4773gZyyem8aofwdYnBPzxvN/nubxcrsaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240081
X-Proofpoint-ORIG-GUID: 8zFoXKcEHVMgDl1xf60pRUpRL9VfQkPF
X-Proofpoint-GUID: 8zFoXKcEHVMgDl1xf60pRUpRL9VfQkPF
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 08:26, Dennis Zhou wrote:
> On Wed, Aug 23, 2023 at 07:06:08AM +0200, Mateusz Guzik wrote:
>> Allocations and frees are globally serialized on the pcpu lock (and the
>> CPU hotplug lock if enabled, which is the case on Debian).
>>
>> At least one frequent consumer allocates 4 back-to-back counters (and
>> frees them in the same manner), exacerbating the problem.
>>
>> While this does not fully remedy scalability issues, it is a step
>> towards that goal and provides immediate relief.
>>
>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> 
> I'm happy with this. There are a few minor reflow of lines that I'd like
> to do but other than that nice.
> 
> If there are no other comments and it's okay with Andrew I'll pick this
> up tomorrow for-6.6 and the corresponding changes to fork.c.
> 
> Reviewed-by: Dennis Zhou <dennis@kernel.org>

FWIW, the new version also looks correct to me.

Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>


Vegard
