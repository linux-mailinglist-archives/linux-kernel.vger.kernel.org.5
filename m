Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417376FE66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjHDKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHDKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:25:47 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FC2118
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691144746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=asdRHLg9E03BV0goCJes0z0YYo3VDOKNf3DeHTfVyu8=;
  b=hfBZRAk3T6HIR0crl+sLjuz5Rk9ViAsb/mS0JhcWOtCxnSAkNSr4XGZW
   B+ZLLAiKIOSm7YrGpwW3LerusYhJmF3R6TkJAX0/6HS61pPif96QJj1EN
   Je5PAUwiLppaqeoznXlilszPZwihreFcaa/pwS1Nc+vHoM3mdJm++vCrS
   k=;
X-IronPort-RemoteIP: 104.47.70.103
X-IronPort-MID: 118931483
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Vvh8yql9LkdbPAZUFjh/WL7o5gz6JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYXG2Fa/6DZWDze9B3YY+1oExUuMXTzdFgS1Q9+Hw0FiMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgb5AOGzhH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 dUYdyAXLSCFvvvs0be4F81zmIcIFNa+aevzulk4pd3YJdAPZMmbBo/suppf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVk1Q3ieC2WDbWUoXiqcF9t0CUv
 G/ZuU/+BQkXLoe3wjuZ6HO8wOTImEsXXapLTe3prac20Ab7Kmo7DTYoUQK0kNaF1U/jff9cF
 2Uu9wwXsv1nnKCsZpynN/Gim1aUvxhHHd5RO+w89AyJjKHT5m6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq15rqS6D+/JyURBWsDfjMfCxsI5cH5p4M+hQ6JScxseIaxk8HyMTL92
 TaHqG45nbp7pdIE07WT+VHBni62oZ7IXkg5623/W2Oj4QRRfoOpZ4W0r1Pc6J5oJp6xR12As
 X5U3cSThMgCBI+A0iyERv4AGpmt5vCYIHvdh0JiG98q8DHF027zI6hT7St4KUMvNdwLERfpe
 Eb7qxJN44UVN3yvBYdvbp68EdYCzK7uD93pW/nYKN1UbfBZdgCd+zp1TVWNxG2rm08p+Yk1P
 o2aaoCrFmoADrp8zyueQP0U2rsmgCs5wAvuqYvTyh2m1f+UYiGTQLJcaF+WNLlht+WDvRnf9
 MtZO42S0RJDXebiYy7Rt4kOMVQNKnt9DpfzwyBKStO+zsNdMDlJI5fsLXkJIuSJQ4w9ej/0w
 0yA
IronPort-HdrOrdr: A9a23:EqKUSK/rMsot89Ppk8duk+Gydb1zdoMgy1knxilNoNJuA66lfu
 SV7YwmPHjP+UossRAb6Km90cy7LU80mqQV3WAuB8bvYOCLgguVxcRZnPDfK9OJIVy3ygZyvZ
 0QOZSWIueAe2STtK7BkUKF+zxJ+qjLzEnQv5aW854Pd3ANV0gD1XYcNu/BKDwAeOAuP/NQf/
 DwiParvwDQBkj/LP7LYUXtcNKz6OEj/6iWBCLuaSRXizWmsRPtzqLmGB6F2RokXypI2qpKyx
 m5r+Q5jp/Txs1SRXfnphvuB489oqqa9vJzQPaUgswiIj/wigCuDb4RKYGqjXQOuemq3l0ji7
 D30mcdFvU20WrYelevrQLqwBSI6kdc11bSjWWAiX/Uu8b+Xz5SMbsxuatpNiHB404Xptt7y6
 5832WF3qAncy8pF0nGiOT1aw==
X-Talos-CUID: 9a23:vxvFCGEMaxxcV9s+qmJO9BEEAIMVdETElmbVIBKcFngqY4WKHAo=
X-Talos-MUID: 9a23:vjExfQtSanRevblMcc2ngRpcMJ5n0ouSV0FQt7gFh+C+OApJJGLI
X-IronPort-AV: E=Sophos;i="6.01,254,1684814400"; 
   d="scan'208";a="118931483"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2023 06:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5oOcpmufWTYNaSvVcYX9X6aw+WpHWr6onFKuTGj0hvp/GE/wp1yaauEyIPaXgqBUvw3RqhL9rHVEx2jTOARJGOCY9CCEqrrhVI8v/k+S1y8fRVlfKS5rf0SBtlHf44am11smnw0gutvDWty0qDvdqVs/SdCE9GE918CjFsNNvQhaIrrLph1o+O4sj5koph6HojhDT3mqgf3+DpS2INirzx5281Nx/lOidFmg3lWO64318WbWsbw1U43W/85jyTjNs0n/e/46fvY3mklsnDYp5wypNYqtWz8VKJm60WR7jfzhlddLS3l9l3KrCb7tGYpicZMYSUUUOlQ1/s/csyrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asdRHLg9E03BV0goCJes0z0YYo3VDOKNf3DeHTfVyu8=;
 b=V935yzrLbPEkztoH+R1GZhfdkbpQ5lQrRjY4UFM8KcWO+7Qh89Uhr6s7D51F+ei3Rbw820YJ1QW3v8qQtQtq/x9p7Z4hUWcK6fCdyayOzImg2JPHT3+/77cRyfaK2zIHPCSuMM7fveUhi9HiEzjhYC7Y14dbWFno7ppF9co4brrY3zWemzQFoDTJNSEIgoBvFjPodGI7wxczz/3W/KXa6mjH3kGivd+sGYxDrRVPW9n5MVy+WtH4R/SUOc6FzLdABHmzLUFHDkL0mJHi2pghq2LCGG8JTOi9joaQabMJoVve+e/6j1MLFx+2AGC7StMgxRG2Jfbz5N4ofmDEW+oNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asdRHLg9E03BV0goCJes0z0YYo3VDOKNf3DeHTfVyu8=;
 b=JPFAGyvL0dxSepAjWFhC5WJOfAdLarLPtLd0bZRkfmG1E68JzlFV0tZ8q4qauCbaSFsFQLCNHLO9ORERylKHsgA0eiLi5wzv3zZCvdUa8ZIt21IHNgFoAIKPE7IKiWpGnjdllbhEhz9VPT08GT0fDJvOW8cSJH1yBJDIRdZUR/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA2PR03MB5930.namprd03.prod.outlook.com (2603:10b6:806:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 10:25:42 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98%4]) with mapi id 15.20.6631.043; Fri, 4 Aug 2023
 10:25:42 +0000
Message-ID: <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
Date:   Fri, 4 Aug 2023 11:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Content-Language: en-GB
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20230804075734.8372-1-xin3.li@intel.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20230804075734.8372-1-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SA2PR03MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c5db4a-7190-4d06-9414-08db94d527ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCnx/9T0tESYbj50B2cLLzDR2fsdpHWRt/RMHiIGpDvxKAgkjDQU5zr0szEj1Yv+VUVf+3j60QUk+NWj+gWNOiMtB343H18/Ky94h+DdWJBirNCi4krv5kCUGZlfyAMEe1Yu7qeKHaG+oDCUdp6D/HhOTJzcaryvKJbdfNE7YDj4lJWE/kvy2KHSspd460RlHVh8lx2qzcnO9QJESSiZQTix1lJfjuGSyJi7dUmY5CJro6kbxtFuUs3XwvycFnNwys43D83NaKIXJOVQZfdqiCu3H7UcLdZJAIMSR1rTo59AunpG3Zf0mhCIT6/Bmkj3QQ5wWo4XsUTcSStbPTGLQo4mmkY+ZR+m8aMDkbGK//2R/17mWfM531UZLk5VxQ7FQa9ai2vBRr+QnG1Fpz5af2RVdKtWUyPT+uTfWxvqDELDU4P3jgkHAtM2De4iV9v1rr9kBea6qVv7CcGZUuxbvBE4i/uVkoxh8GTBqOtAZ8i2Y3RTwWVKLzuUoQ7jfqGzehVlyzasGvFDqzkhLyCXR89fwlrVF/coiuRrcygQt2TPsaNHTrr75ff2WvQa2/yNFNkjP7jEs8x4Dj9l1lY+XRZ5d+0ushcCJHNU9jp86KJaeWps9g0x56pLeeKacFxmGWX5xjQMxN3qq978K5hyVyPpQwx/U8Ow2xZCO0OQXUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(1800799003)(186006)(451199021)(2616005)(53546011)(8676002)(26005)(6506007)(4326008)(2906002)(66476007)(316002)(4744005)(66946007)(5660300002)(66556008)(7416002)(8936002)(41300700001)(6666004)(6486002)(6512007)(478600001)(54906003)(82960400001)(38100700002)(31696002)(36756003)(86362001)(31686004)(26583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGV2VjJ6Z2gwYW56b0dqTWdDQTRNQThPSGM4QUlHTzQyV1RHNEUwbDJYclRS?=
 =?utf-8?B?di9MTFZPMW9Eb08zZ0Y2TEZEdDBWM2xtSzhFb1FhdGVISy8wL0swL2VpbDU4?=
 =?utf-8?B?WUJsZUZYdVBCWXk0UFFlMndqTkRhcXNZZklZY0ZlT05RVGpMN2FHdHlsV3Ix?=
 =?utf-8?B?azlSK0dPS0VPai9LN3NDenpieGxkQThUWCtUdS9wOU56QkIwQ0M0ckgrZHpX?=
 =?utf-8?B?NGFMMnNYWjZ3dmlYaXVOV25wWExGUnMwSG1YeTNRYUN0TGlXeTYzUVRzVERL?=
 =?utf-8?B?Q3QyYnVnYm0yb0ZDczBBaWN2MDRxTjFNaG9qdEJtY2pzUi8vSWFxbEl0NEJU?=
 =?utf-8?B?Sy9rVU5ETktUcGU2dXg5ZS90VGtCRDc2Mys5Q29QckwySUJtT2xlQ3YrZzhl?=
 =?utf-8?B?SmdDSGw3NndMTlFncmh3R1NNbGQvdDdsQmtLcndPaExjNWdLRVdIYStPcmFD?=
 =?utf-8?B?WWRFZW45ZG9xcW1ueWZqc0pPd3lESXNYbnVGa0JObFRnRldNbWkraEpnb2Z3?=
 =?utf-8?B?cXVqc29RencrbnhQb0NYRnhlMm8xMGVaNE9TMkZNSWxQMjFKRFVoRzZmQU9p?=
 =?utf-8?B?THdmOUU1UmRxVzdxdkFRM0hwZ1FoNlREeVBURktsMXRxVklDdDFRemhIY1JT?=
 =?utf-8?B?aDhUWm0xUFRHNmpNVEJyZUM5dmZLc0VxWnZPRjRjQUlxSFRqbm1HUHIwella?=
 =?utf-8?B?cWsrSHh6UUNMUEQwbVhUOXVZcWVFTTQ2Tys1NFI2eHB4YWpMNE9CYUo3OWhY?=
 =?utf-8?B?VWxiRnBNaWdkaCtOSDZ6Vi9UVUJ2RjN2blFKVExCQmdoMnpkSVBScUFKSHdQ?=
 =?utf-8?B?eUl0aXJBR3VMelRhSDJITlBabVhYQmNCTFRtT3FKWEtOelZRS1YyeTVFdDhF?=
 =?utf-8?B?bElLekVVQnFqNTN3T3VXZHN4UHdCYVlUQlN6NmhybHhxMU5JdndQUGd6UG5r?=
 =?utf-8?B?ZjY1SmQzUXhjc3k4dThlbzFkTUpUTHBkS2xaZFFOZHV5VU05djRBQ3AraEZ1?=
 =?utf-8?B?Ym5EOGJNNUVvbzdyMmdaVEJSMUxlMVEyWFFTRTdneWJCUDlOWG5QY2RUUWZX?=
 =?utf-8?B?SEZBb0FKRS9qTThVa05scEpTZjdPQ1J3cDlCd3RDWERPV3FXQVgvNFU5OW9v?=
 =?utf-8?B?SEVvckRnRkJmYkI5Q0c0YmpNd1cvVDh0c0prVXJjSFBRL3QwV0JLY2FQSWFw?=
 =?utf-8?B?SzNod3Y0V2RmTTZtejBHWTRXWFI1SnJwU2Vad3NUdG5SMlh6bjQycUN3Nldj?=
 =?utf-8?B?aU84SjlCbHVYZFpDUjBlOGRESEI3cW9KaEQrS0ZYSUY3bjFlRXdwVjVpZGh4?=
 =?utf-8?B?OHdqQ0Jvc29laENEbHJmTFdCYnNCSU13c29aVGt5SWxrMVlSZ1BBbE5WdlNa?=
 =?utf-8?B?OU5OenVwbG94ZExnUWRlZVdRSlI5bFloRHduK1NnYTMzOW9NLzlsOTVYaXhV?=
 =?utf-8?B?R3ZSRm16TkVEajdDWTU3emJhMEcwR0VqcjlaK09pY2NsWTlaM290dEIrODBI?=
 =?utf-8?B?MjNyZko1QTc4Rjd3cXBQelBTY3lOUmFTSnk1MUNDdnc2T1NQemppZllBS2hN?=
 =?utf-8?B?dVZEUWQ0eDFYTUd1eWsvMnhGMmp6Yy90dGt5Qno0NWpGa0FGS0RaLzE3cmtX?=
 =?utf-8?B?VXhzZ0o3UXdEWmh5WUdDUlFIQmJoMHAvT3RJODFka20wRU94Q0JsMStiNjZn?=
 =?utf-8?B?MEU0WTNRSlJlQW9QTStHM0ZQYkJmMVhURlJVNDdkdkVkSndDa0d0N2NWT3A0?=
 =?utf-8?B?NGtiOG5uT3VWODZvWjNNSHlXTTRCQi8ydFU2dWp3YnllS00vUFlrK2lJUllm?=
 =?utf-8?B?TmJEWlJPVTlJOVJ2d05oaTFxQzltTFF3b1ZDcHl3ZnVXbWJVSlZyNkZ6ZTZC?=
 =?utf-8?B?NTRHQmgzOCs3WGhHblgyNjh1c0xVeVppbHpDaFY4RGF1VWlNTFhTdFlpUmRY?=
 =?utf-8?B?MlBFTHY4WkxZNmJrNVc2RjhidnBQY0lZSWQxWXZmdzB6c0ViN0dsYTFXV3hP?=
 =?utf-8?B?RHNPRjNLTktCTzh5L3lzQkZQUVpPSGFjZjBaZjl6VHVuM2swa0dqWnJqQnVT?=
 =?utf-8?B?Q1JKd2pWb0tDYlNzY1NaQWkyb0ZrR1RMVzMvOW5MTklRajNSRHc0cHZ2VHZR?=
 =?utf-8?B?U3hWWTMrVDBQbHppcTJ5OUh1ZzhzNE9HM2lUYmxJNHpvTG1yQ0RMdXlrVFVi?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RmxCaUZ5TmNKa1JaSXUvNnhzWFgzc2dIaG1CL0czbmtreHFjYWcvSW1aVTJy?=
 =?utf-8?B?eDhoOFdPd1RBdTFVTGxXcGE2TTlaR2VNMko0UFZncDUwam5IU1FRUFRHaHBW?=
 =?utf-8?B?UlZqaFFNUkV5amhOUWNOU1lpS04wUFgwTmxtdWhwZHorZ1lJZUZ6ck50dG1w?=
 =?utf-8?B?WjR1OTJHZG1UQlBZRjgzUmp4aG1yaW9FZzZuTDZhY3JGdWZMcytoNkkraUxD?=
 =?utf-8?B?emdURXUrdHd4WHpMUkt6MG9mcDdUcDlkUlE2dHBvUHlsWkoxS0VzTTNRUmFM?=
 =?utf-8?B?eHlOL3YxdEtjNDhtVXU3YXFqRmdkd0Z0c1QzNEk2YSsrek5uQythWjhJVXhN?=
 =?utf-8?B?WXljYWNySXpGelZmUHZWTUw1R0lTeWxpamk2a3EyR3B2Zy95MkJPQ1BJU1lj?=
 =?utf-8?B?THZFQnlkUStBcXNXd1Y5Q1RJUzVNbE00WHNoY1M3ZXdkVEgwRFJXVlpONlFp?=
 =?utf-8?B?b0lqVDZJZkIrRjJGdVY3cTNRbE1CeGxxOXExMmRsdyt0bTFiZUlHb3dKU1RE?=
 =?utf-8?B?b3ZTUWo2aWVpUEw3a1lmb0ZRN3UyY2JaSHNHRGtZYWVGZTRqNGcwV0JJbUZ2?=
 =?utf-8?B?YzhNajZEeS83cFM0Qy9nRVlWaDRvNm9yd3BrdCtuT0RaODAxN1JSbUVLeFNX?=
 =?utf-8?B?Si8wRWlLWitJaDJiQWZxb2t6N3dxaVVyZC9NRS9tRkpQODluV2hGSXFLcEhJ?=
 =?utf-8?B?cU8vamJyR05naUZVRjMrdzUyZFNEYlRGazM5Q0dEelhDM0FaNzM3M0Z3QW5k?=
 =?utf-8?B?b1UwMCtDTlBJOGNBRnJpT3BaNnBHTUVSZ29jeHpONHBWdFZxcWlKUitwZFFQ?=
 =?utf-8?B?dGRBekVsOWNCR0FjeFhjVE9iVkE0TGpOZVhiRVlRQlpib1dtWmFGUVdKdHJj?=
 =?utf-8?B?bFAzcFAwT3NlZHhLSEV3ZU0yRFhKVmxsNUtoMFEzQzlJN0JjZVByL3IzZ1pI?=
 =?utf-8?B?NGZHWHhxSy9KUE1DaGE3UnpTT2V1MFRwY0R3ZzBLN1prNzIwU2hTUW1odmhu?=
 =?utf-8?B?SFhYRXdUUTZUY0x4eWQyUUFLbVc3R2dybWgzOENyeUU2NWJScmtXUjBYUENs?=
 =?utf-8?B?WVNDZFlkd1VtcFJQdzFZSnV5QmhxbHRoRzFycXFDTzlvOE56dmVoLytNR1pY?=
 =?utf-8?B?dlpmMW5mSS9RaHhaSnc2aEQ4WGZVWmIxM1QxbERQTXJETGhRV21HUU5NRHJu?=
 =?utf-8?B?VFoway9tSW5ldEpFdkkrOTJiRkpJb1Bvb2xxUzZSWktLOExtcHRRT0R2SmdC?=
 =?utf-8?B?M2dRSGxOUmlNbFVqcDJjYTZzNU44WUorRTc0TG1DanN2SVRUVVBpSkc2bW1j?=
 =?utf-8?B?U1J5VERncmltMy9jd3djZGV6djAxRVpXVnFnMG51VkpNeit3MUdBc3Fwa015?=
 =?utf-8?B?RUZSS3IxMk5hbWkvVHpZWVhnRXFnVktObEtuZm0yOE9Lamlyc2Fwa2ZOSkQx?=
 =?utf-8?B?aWgxWU5MVEU0V2RIK1VwTTlkNjBjUzVtcXcza0NkbWd6TW8xQW5iUzJWTVUx?=
 =?utf-8?Q?mmUgOx1HaoXdDSvDDpbzPoRIftz?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c5db4a-7190-4d06-9414-08db94d527ba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:25:42.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF7lCuqTeZPlvyP9pId2nuylIZctqXii9duR/H/f7A0SUvXEZ8oqXUlwged9gKxdeg0uxXwlW6n/G5Vs4UffK11SjMGdc/xj4aUdLt/AR1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5930
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 8:57 am, Xin Li wrote:
> I haven't checked Xen implications with this change, i.e., does Xen
> hypervisor need to adjust how it passes arguments to PV guests?

This is an internal detail of how Linux handles data on it's stacks,
isn't it?

The Xen code in Linux will need adjustment to match, but this is not a
hypervisor ABI (which obviously can't and won't change).

~Andrew
