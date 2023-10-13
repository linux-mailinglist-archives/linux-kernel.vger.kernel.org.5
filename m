Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FF7C88CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjJMPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:36:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38809DE;
        Fri, 13 Oct 2023 08:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAniwEErpq694bqyoEOONx+3px/tf/gRTw9K3q6Ua0xZEfOpc1GU2z/pBjsUwXuLgTNKrnwMZHwpMdFZacr9lywrYKQMD8j0Ogs5twG4cBId/lNXJBSwQtTHxkmSxxwJ8x4GwkTV9hEz2zB6WofpFJizQrzG3aiU0iwSrQpmtkGRNLH90w0i/nalYOIeImg270bFZQSgQfdb5es/NRyD7ev3mdIvvg63KpvQmbEcb47usexLCY4Mkxrtn1ieKPyjQ2A9qRDvctaFONNcXZm0vLq29jYauIEIgnMlTC6Bd5ClKy2gaYqHxCxAb3pM13X+fGfHq1e81+TuR6Wu40PO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLBmvTpanSSOqpARwolTTWQmrEAfQk3m4zPUPI5BA3Q=;
 b=Ib9ajWkqUKwqP21dfnd5/o4hnmdj/Tuclj3UIDumgRtSCyIyrXXQtcE42yGhlHlOH4nKFYk3Mc3WApquz2Jr+SKzEQi3SzKGP8u8BInds9wr1OBbyE+9hlbIkSeEDFH3sDE+J4HRZxEV6FYN2cuNw+4DSyo9SnhZ1M3uURdtwwT7kk4BbQia6rUCM5JH+8O1/skm+CW1AZ97rc9cVu9fb1XWllo7mFamnjPSqImh3BI5TqWkJpHYSVdjUtiaXe0YSH8hAyQryU0IMHrn/ddR7Lnso5U8b9zekM25R+Bmvk+VD7oBy+S/LRXu9llIwaqG1Slpt2cTE32hlBqpm+OvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLBmvTpanSSOqpARwolTTWQmrEAfQk3m4zPUPI5BA3Q=;
 b=o24uIjTgY6co2QQaBKz9R8idpnwC4YhzeAbiNJt0yla2KJyEWF+chxJhvwf+dp1NcC1qr/hjZpuJqFkWeVZ9VtMn3WHdebE1S5Ge2Q0rzd8O+R6Kc6fZzc1fx6/AqjIP0bRvOmJ0P/pXlxRprLKE2dopgdEaZs/U9n5eivVfmtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:36:10 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:36:10 +0000
Message-ID: <aa66b946-8d97-db50-bc3b-7f1694de2cda@amd.com>
Date:   Fri, 13 Oct 2023 16:36:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master
 and MAINTAINERS entry
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
 <20231013-january-caliber-2e7acbee15ec@spud>
 <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
 <6fa74ee3-a2ef-4d76-964f-51249f53cbaa@linaro.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <6fa74ee3-a2ef-4d76-964f-51249f53cbaa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::9) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db9254c-7268-4cea-c1be-08dbcc022031
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wReVmhKPE78AuZnEZ5Zhlsr083HweLm9RRzQPXCBtyiiJd2jKhGRmoH/7MUuhqQxmv9lRHxX4MNfWDKNnJ6AqK9MySiGESpS683lw+nDSluHQSgry1tvFMjXCrECTcfboG8xLZC0kbTi8HFrhicaCF5m8+O3/MOLDF+ngRQTeB7qS874ZTUADqUXiYPsHSWpn/5nRZ+TxPoFzTWp1s6noEqVl8NzqRjnze2IakgexmvLiYY+RkA8mbCRyGdoJcxNITr1R6aDiZ92xsZo1squtP/6Jb/Sm9kZWffKX7rhr+fgy6JTsJPBvzYsSWkseqBzmNMPjYx644fhJTlHoCidZmGBEjyG+u20vot8Jfwfc432uuyZzE9aNys+HNZ8MvyXoXPwdl2sPPbPv5aj2A9CWcDTnEThdPuYnp6y+l0vOmr/jGzjtfyow6DurC0v6+faqrkvaj6Io2embCq/nNVFErqAM7b1IIWIXVM2gjGx8G/YLiXe70BTPFaf8klgUP6lJ/iVsF8ZmVs5/a4NaRVO0T1HF++GiVottZv6K3llnA8h6KSmbpq2wMKGEbiHHX7IAu+1YQJnXPj56zZTow2kE2vluC/HngvxfpqEmu8hi2De61p+62lrSWwkLTykshxicAFO6RjPDPvZ+xYC8hUDBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(53546011)(6512007)(478600001)(6666004)(6486002)(6506007)(31696002)(36756003)(38100700002)(86362001)(2906002)(83380400001)(2616005)(26005)(316002)(4744005)(66476007)(66556008)(66946007)(4326008)(5660300002)(8676002)(8936002)(41300700001)(44832011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akUvazd5RkdOMVI3TjBTdVlYWjRxT01OUlFRZEgyektaY3FNbEExK0lja1ZK?=
 =?utf-8?B?T0lXQ2VRRHR0c1hEUThadlhERWVPMzllQXZzMEVrcHNPeVRPM2F0cDNMUHUr?=
 =?utf-8?B?K3BQNFd3MVoxL0JySzNGTG82eFRtNlRJc0hiN1hSRmJBdzRLSzBhaE9hOWxz?=
 =?utf-8?B?LzVpT2swQm05M2hhNU5GbDV5UGFuODFDUjBUeGhHRHBKTVo3ZDZ5VlViRzYx?=
 =?utf-8?B?QnJRWFJESkxVbFd1aHVWSUsrZU9CM0NQK2RFTC90MFBodFo4T2U3YjZXa0Vt?=
 =?utf-8?B?N0xxUkFBZUNFR0dZY3VQemt3NjlzSjNLUWF0dlNyOTJaNVM5SERyZGlVeWha?=
 =?utf-8?B?ZmgrYlJIdzZyK3puSUdlUHh3UVBqSWNWb3piU0QvYlhLdkJsTDk4RnR0U2Nx?=
 =?utf-8?B?L2d2VTVmL0hjRnQyalpaYlVMTnprTUhPVDRkVmF6TFpwRXFnTCtZUlc3U0Iz?=
 =?utf-8?B?Zm1ra2diYXNnUVA3MEJUVzBFR1VjNlRrSFBseUp4UWtXNFc0R1ZMSDNsK2tZ?=
 =?utf-8?B?b2ZsN0tBem5BdVFMNHBydVI0bHB0VkpXVFFlYm8zZHQwemdsZmZOcUVYQ2Iv?=
 =?utf-8?B?VGFqbHVnYUJJWEdLV21oZktUV3Zyd1dyNFN4Ukk3bkFiZmwwNTd0ZHlLY2ZB?=
 =?utf-8?B?MEJtSWhBOGNtM3ZjdFNVVkZQdVpRVzlVZUwweTN3THMxeW8vK0xNSnYrNFM1?=
 =?utf-8?B?OVlVZXhxY3p0TWtrU2ZnSXk4VEtpeU9sZERXL29jOCtVUzkwZkZ2MGVEa2NK?=
 =?utf-8?B?clZOTlZBWkY2Z2JObzBMQWI0eU02SkJNaS9SelhaOE5lWTJHRmlnaTBXSWtU?=
 =?utf-8?B?TlJ1d3MvMndOWENiRG1KYlhZNlEva0RBczUyakNmbXJDK04zRlFpUm95MWlO?=
 =?utf-8?B?K202SWZid2doNzRsdWo3bHFJUTdaci9Od0RmamRsQVFJNUZJZWdhTkxNeHRj?=
 =?utf-8?B?OG5NTy9CT09oaGlkaWRYemwzVGcvdENYRW1zZGs5bSt5UUdua1BkZmNBYXZa?=
 =?utf-8?B?em9NbVJ1RjJ3V2ZJU3NFM0luTzJFOEM3NWJnVmQ4NXMvWXk3Wmg2d0kwd1ZE?=
 =?utf-8?B?dWplTHVTeHVSME4vdERQem5HcUJpWnc0UEZoT2ZHMitzN2dydFBvSytuMCs2?=
 =?utf-8?B?TEZWQ2NVT2FZNG45RE51dGVsYWN5K1l6WklsbC8xalJCMGlocE5xMER0bSt4?=
 =?utf-8?B?OEF1R0UzQzdvWW1WeFdTdUZKVDIyRHRWWGRFZ1YyMUZFemhVS0dmRG5GOWp6?=
 =?utf-8?B?Y2FzVU5Ud1RFYUZ2R2tTdWZBVnc2ZlBSNUZpQUVseWZodEZReTh2UWVXSzMv?=
 =?utf-8?B?UlFDS3FFSWF0cFd1T25tMnlXT0dRZzdPWkdDa2JXMGpxam54MGc1Q3dud0J3?=
 =?utf-8?B?bm84a3ZCRWNSUm82ZGRDNzNSTWFwclpzdDB4YnJqd2k1NjFxVjBkYWkza0ZW?=
 =?utf-8?B?MFY4UlZVYkU2OExCaitKV0g3cUZGL3JCQWQ5WE52NlZGejlVUCsxNllUUGpN?=
 =?utf-8?B?c3JXUGhWZnNFcGlNc1NOdzg5TDdiWmlseFRUTURqMkM2ZW4yWEFLWmYwQjFT?=
 =?utf-8?B?b1dqTFdPZHVaV3l3cXZGT0dEQTAzYVExT08zTFZaVHlTbzlvMjZDYnNrNU1w?=
 =?utf-8?B?c04wSEphMWt5eStwL1BZMkcySEM3dGtXMWllaVg0NGVvNzcraXVuRGJDSHBP?=
 =?utf-8?B?VE9jVDhRcktzazZUMXFtbSt6MVcyWjNiZDNEa0pjOHJXRnRpN2lDZ0p5ZGxS?=
 =?utf-8?B?djFkenJDWmYxOGN2b0dESDVneEQ0amV2dTdJc0pzeU9PbEMvVkpYZmgzMXNn?=
 =?utf-8?B?bkRYRDU5b05EU1N3UWhiUXdLdXVsVEZXdnBtcHloSkhNSEF3WkppZ05vdmRX?=
 =?utf-8?B?dm1YRXhMbzZCSEpCVndwMXlQY3BRZkFqejNIMzNKTXh0RU8xOTBGUS9kN3lx?=
 =?utf-8?B?ZEpyTUh5NnQ3dUROR0ZyMUtPNzNZLy9pQkJ6WTBsNnA0cVJ0cWdtVzJnNmRu?=
 =?utf-8?B?a0x4eFM3RnRYek9LbTJUakFMa1FSTldINzBEczhuVG9ka1JXc1plT2NmYVFZ?=
 =?utf-8?B?QlZqci84a0lMRHZSa1lNUU53a0hBSjd0aldHdTM0cmVWRGJkR2NYNkM1Rloy?=
 =?utf-8?Q?VwIBaK4y4UTPgjQICFb2es5cl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db9254c-7268-4cea-c1be-08dbcc022031
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:36:10.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLJ95x7EYw657TxJcBL1yhLlFxC4Ojg13+xC095HStbZvD3z3TYTtM6wdERiTjUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 16:29, Krzysztof Kozlowski wrote:
>
> AMD product managers are highly skilled in naming things. Sigh.
>
> Go ahead with AXI 1-wire master. Any future - from now to next 100 years
> - product from AMD which will be different but sold under the same name,
> thus creating conflict in compatible naming, should be rejected because
> of that conflict or renamed to something else. If that happen I will
> propose a name like "banana-wire".
>
> Best regards,
> Krzysztof

To be fair on the product managers the IP naming from a hardware 
perspective is in the context of the ex-Xilinx development tools, and as 
such there is no risk of namespace overlap with the rest of the 
business.  I'm not against changing the binding name for clarity in the 
kernel. Would adding pl within the binding (Programmable Logic) assist? 
Ie: amd,pl-axi-1wire-master

Regards
Kris



