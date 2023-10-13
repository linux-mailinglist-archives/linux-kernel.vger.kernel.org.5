Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915D47C84C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjJMLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJMLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:45:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4FBD;
        Fri, 13 Oct 2023 04:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl64TowclS4iozfeMWwhJcaPBAUlwIcR6p4MuDEc1+cxiauF+R1sXzG0lq+ZtVRprVp8asK/1ryNhkWzGyrZePDO0VPx9NkMNqlgBfMF+BQahdI4if46txV9g6msiu7/AC8gFmRLEhLDBT7XQyTX6VA/Zm+C5Vuc0hlnMx2uAjRZy6hUVSbTpnJIxNf3T9AKNeiMOs8mcLnn+PBoaRnZA6NUqZcHAIWtGmTuZaX/V9214qxSB6X8la7dxFHUEqgNWJxyFBBU3GKl2/usUf+qFzzsUPS3An/7hm32eBVYHTan8sbD6vrtpVIpiBrXDo47Mu4+l6o8CUWv4kTqNESgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHoqflSqsNoHqX8+WspC6YSEfahdFNBGeHPVxAnk7l8=;
 b=XwEkZj7rFYEaYqTWZeEOC4Dkjr4n3J/NuGHoy/WxzhHCHxcpo6KHqejzW3tols2MukBbJDCu00zLFS6kDzp+7UPDnSp9e7o50+kpFLnG6TB/XIqsWUsKh1sfOjcWSjheOwzZLqhYGjOLRznizyLZg1kLRhKYho4ihGVtyxyCEQZqq5OsCyqshMepwpGYQZlySC0nAjYWQ5J0wAq2gTGyzsK1iozuBvG9wWGGPWRrKeqRE/cnhJym7ohomSHHov0Z7N+TMXI7hDTLU0LuUi4lc6RQ1eiy9BjjNdhDHu9tdaep1VneQ5mdnNoWP4F8lppure3PLC/1kLjN7x/EW+ATUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KULeuven.onmicrosoft.com; s=selector2-KULeuven-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHoqflSqsNoHqX8+WspC6YSEfahdFNBGeHPVxAnk7l8=;
 b=lacdVuyDz+Wn3DrbY33wJgWM3dJpB0BlVZWo8tTwtI3+lAHN105kF1ewdzeQ5A0E+XXetWIPrz4yjFOvTZ05Egi0IMKR+e8Nf8Z3BJmINPcP3kTWJ2kHrkz9DXbup08VSAX0seme5u7I9kbx3RBDC4AqLVtHN+xdG4e4IS7PLyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com (2603:10a6:10:3f5::20)
 by PAWPR08MB8888.eurprd08.prod.outlook.com (2603:10a6:102:33c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 11:45:34 +0000
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::f21b:70b2:5484:6a31]) by DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::f21b:70b2:5484:6a31%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 11:45:34 +0000
Message-ID: <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
Date:   Fri, 13 Oct 2023 13:45:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
From:   Jo Van Bulck <jo.vanbulck@kuleuven.be>
In-Reply-To: <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To DB4PR08MB9334.eurprd08.prod.outlook.com
 (2603:10a6:10:3f5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9334:EE_|PAWPR08MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e8e24b-762b-462e-d405-08dbcbe1e903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SR864t2seVZAs8JPRf+0NqWW1iRy2tK44EMmH0I+wyg930owAZXw1IH1uDJWEwIyhO1hUnqrx5Q6bZUA+zFXa//UGKFYHjzFtVmqQrLRhIlqrvLXvxVIGkW0PMU4f8mM0p2wg0dpN8TAPL3m59DDroHgLjFFZWhblQd+45Cl07gdV+/ccHJjQhRb20VTmowe55yI5DJcbY5KEq75CwejHWBdUk0moes4F75+Bl8PNa7KZuwO9w+h6LeECzsMn4hIMBA8yDtSrunAWZa81VpR3qIKuvhGzYxn/LKfXVlPL1aoFIjsv2c0p8/u76VX/0HBCdkVM79uWGWZ6W45QB7erzOPRPkUh5yHT5SPnL5tbU1eTYDxfzgIpGxuPqH0wkcnNfhQihMNXX8quICFiquf3usAY48xQ2qyXfXO6FbWVidNxi60jktza4Um2OUL12GWlH0Eu5daUu0amKZ4/vvnAGQBnrvArui/S8glyFGfmMNOI9+6pTSjSEUoWSNFJMmE35Pd8e989hNUX9OkHVwTF7omXSYrw/GkpbT/wEyVUec38btVY4TJT1vdi3W8wLcnWrgkndRbFckwY2zJe+qoyeNlRJX1SNHPq2yapMae1daChbdrG27n12Ri+KXA4eb89wiBoPAyuIIMEmraZTXRPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9334.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(36756003)(786003)(316002)(66476007)(83380400001)(66556008)(66946007)(110136005)(53546011)(86362001)(2616005)(38100700002)(31686004)(6512007)(6486002)(478600001)(31696002)(2906002)(5660300002)(8676002)(4326008)(8936002)(66899024)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJ2RTdBenBGRGhrQzhlT3N1Kzc0OG9vV0tHYTRFenozWGVUTzA5VHVEdkpn?=
 =?utf-8?B?M0p4d1hZN3RRci9mekZ5bVRKL1pzQVM4bGY3UGdjQmZ4dTFmbm5XN2M2dUw1?=
 =?utf-8?B?aGE3bG9aVHViK0NMd3BnTDJZRFkwK3BkQ001MVY3THBiTVcyS2xxbkpsaWFy?=
 =?utf-8?B?SERDZmxUVGhtMnBrZVJOZGE2bWJ2R1dTUUVxMWF2MUZ3aVVOaGdhcDJ1Q2R3?=
 =?utf-8?B?eHQ1MDNsNWFycWtWeE1VbVcxMTdSaGZWVGh3WkpsMzlrWjAwdHhaNUl4V1Ev?=
 =?utf-8?B?ZzB1TlFsY2V0VGtsdjF3Y2dUTHRDRzNRa09BcFJFRXZHNmJSOG5rYWU3cjZ5?=
 =?utf-8?B?TUx1WS9EMzFpekt1Rm9pUUdMMGhCRFZ1QWh4bXI4ZHE2em5OWWFpK2RHbmxF?=
 =?utf-8?B?WXR1WGxZQWpycy9GcXhyYVpsYi9YN0xHMitHQnEzZ2x0UkJGWG9yU3k3WmJE?=
 =?utf-8?B?S3R4a1hyelJyT1BFVmJTQzh4L1VyUUxQc0d2UnNQUTNGTlFSazFQNHpwUnBY?=
 =?utf-8?B?d0NKeGF1alRwb21yQTVXb1lhOXJOajIvS3VKSjVsSkY2c0s1eTVFcit4NnZH?=
 =?utf-8?B?QmtpbmdKdXp2KytyVWY1eEJRNzRsdXZvY1U1S1VpNEZweWY0ZW5UY0FCWnYx?=
 =?utf-8?B?Y2JRS1c4OXA4cVRmVUlkTGdqMUxkVDU1VkwzVldReVp4Yk5sOWtjU2M2b2ZM?=
 =?utf-8?B?V2gxeExYb3laOWZxSVhLSTR1UzFLRXhMTW9uZUtHYjZuTWRHVTQwWUVGWFFN?=
 =?utf-8?B?dHdqdWUvdFcreG5lUXVLL25OSDZoVDlWWE5HZGdLNCtvRlA1a1FOaDZvNDZF?=
 =?utf-8?B?UFAxcUZpOFVKODNnbjRraHZMbnZhMDQ4UGtHVHVhYWFFc3hMZVI4dEJldGRK?=
 =?utf-8?B?RW9JK212N0JZYk9tM3BHNnh1K1lWdlVqcFprY0VuRWFsSXhEb3VUR3FWMmQv?=
 =?utf-8?B?eUhTWWRYenBTZmE1WjVXK1NZZzBTRmpzSmR3L2taV3lKeDVxZHJ4Wnl0NTAv?=
 =?utf-8?B?WW1iOXRJWEkvcVFha05ib3dCS0c3UzBJWW95RkNLRGdXQ2pnUlJjUWNpWnlH?=
 =?utf-8?B?OUlMVmhQTmJrbEpSVkVRRzFtRTBoVlNLUGZEamtVdUZQTWlHZU1Md1llY0wz?=
 =?utf-8?B?OXlWb21VaHZacXJtbW9QcXFzbDE1VVBwamYyUkxTUDlLTWdMb1VSNENab2pF?=
 =?utf-8?B?ZkhXc0FGdmZHazhPQUR2dVp1dis4Z2oxc3dSakg3WmI4V0N1QWRkZTlTQ2Rz?=
 =?utf-8?B?bmI2a0swbFRzdzV0UXo0TkhHT3h2ZC9wblZkVkE0bzRscUpxeDZaZW0rdmVC?=
 =?utf-8?B?SFRsYkx3Z0tXTXhiRWVEUDN6RVpyTVpnaGJ3RitnclZJdEhZaDJYZXBmR3VX?=
 =?utf-8?B?ekh6WDI1V3dIbXJxSU5vakVYT2tYZ0xQMk1aUzFJdVI1a3FQNis2SVZhU3VS?=
 =?utf-8?B?dXhwZk5hSnJWcEFYTUNSSWhsOVpBZWlVSXN5L0F5cHlhZGQvSHdIQTNvKyt1?=
 =?utf-8?B?SmRwMzVMQ2lQTzhibjkrLzBoQWdwYTlKbHB5TGU5UnpwR3Y5S0NwNlR1WE5s?=
 =?utf-8?B?WmZxWG9kSlNyeTNHZS9kVmxtZlN0OFFKVy9hUkQzRmtJZU9FUkZ5MllTOXVt?=
 =?utf-8?B?RVhrbFlubW5hR055YUhoUjdMUWtGMlBXTk8zbEIyblZOSzFoMUZpMVVKcjEx?=
 =?utf-8?B?M2FEQXBMaTB0dkhBNEJuRXpGTkEzeWRnMi8rVW9qQkFGLzVicUZmeFZwMjNn?=
 =?utf-8?B?VWIxalFMV051Y1AzRGk5cnpHM0cxUE5FVTJyQzEyaWtKTkx3aENzcVhVSnpy?=
 =?utf-8?B?RC8ycUh5amZTS2ZMUEdkVnlzcFlDYTBGS1Jxdmw5cDVUZnJleHluUldma1dv?=
 =?utf-8?B?ODhhek5ySkpCeU5Mdi9JY3o5MDVoVDJKZjdBb2w0WVhjdXpxTmVPUmpBUzlo?=
 =?utf-8?B?U3F1ZEw1RE9NT1JGZmZPckdzemhwSHRBVHluVGRSU2w3YUFDMDliUFNRMHBI?=
 =?utf-8?B?SC81R3FLUDhlRmpaM1RNR1BpZ3U5SUhDQnUzTGtXNWlBT2gxWEZNYVJTdzdI?=
 =?utf-8?B?aE4wT3lIRWEva3kwQ25qOWJNUmRGdUIrM3BvZytOUWxMV0IzZWZkdUJuNEhM?=
 =?utf-8?B?dGx5TmIrOTVadjdDMkRCUDNZQTZaaURWQzNseisxcmp2OWtHWk15dVlQVGpV?=
 =?utf-8?B?YnJzUUplMUl5NnUyOFBzN1dBTnd4Y2MzTXdPUzJ1ay9KUjhKdWpoUkJiNXJO?=
 =?utf-8?B?VmVLaERuZlhpQ3A0cXgxMUtIaXNBPT0=?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e8e24b-762b-462e-d405-08dbcbe1e903
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9334.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:45:34.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inTfj5Co2yMZs26PuKlTDkZ1vh56uPMZ2ermdnwpyHBakVJiLnMlcutQwjoKRVA2Qz4BqPSbWiv5ZSvGGhmsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8888
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.23 11:44, Jarkko Sakkinen wrote:
> Folks (sorry for top posting): I've now taken my old NUC7 out of the
> dust and tested the series :-)
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks for testing this Jarkko! Not sure on next steps, do you want me 
to re-post the series with the Tested-by tag for all commits or will you 
add that? Let me know if something from my side is needed.

> Off-topic: I wish both Intel and AMD straighten up and deliver some
> "home friendly" development hardware for the  latest stuff. Just my
> stance but the biggest quality risk I see in both TDX and SNP is that
> the patches are made by an enterprise and reviewed (properly) *only*
> by other huge enterprises.

Yes, I totally agree on this. It is really unfortunate that things like 
SGX are not (anymore) available on home consumer hardware and you have 
to buy expensive servers for this, which also change every new CPU 
generation. Having some kind of "developer boards" like is more the case 
in embedded systems would be a great and very welcome evolution, if only 
it were to happen..

> I skim status of both from time to time but yeah not much attachment
> or motivation to do more than that as you either need a cloud access
> or partnership with Intel or AMD. "Indie" style seems to be disliked
> these days... You can extrapolate from this that there must be a bunch
> of maintainers around the Linux kernel that feel the same. Not saying
> that particularly my contribution would be that important.
> 
> Sort of even if let's say Intel would provide me a partner access I
> might not be that interested because I prefer my own (physical)
> computers.

I also understand this and share the concern. FWIW for some things 
(e.g., uarch attack research) remote access does also not really hold up 
to bare-metal access IMO.

Best,
Jo
