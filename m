Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927697857DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjHWMWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:22:52 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C906E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692793366;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1897+tXoaCMui5Du0UAPEmDPfyvvi/ZosEeAVaoH/o=;
  b=hGdmNhsbiPht9pMFgOYQzvPcfvJLyXdqD56l8OCjbXL7SjSjbGknELo3
   we7A8SpsKs99eOMTNfDCmNl8PM2rYkX2oxbrU9i65qOZn5mtQhL5sKoxg
   OKhx8/SOHFnbyv+8ShPYcHECalnG/lmVbz5BMq9v2Qyk1kMFL+6/dYn/Y
   o=;
X-IronPort-RemoteIP: 104.47.55.177
X-IronPort-MID: 123069257
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:PGOhz6jU3Giww2nwKE7yqvFRX161DRAKZh0ujC45NGQN5FlHY01je
 htvXG3SOvqLZmuhco0ib4i3808EusPdmtYyQAJp/CgwQX4b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyr0N8klgZmP6sT7AWFzyB94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQjND0CVFPdhN6I44LrW+lDj/4fNuL0adZ3VnFIlVk1DN4AaLWaGeDgw48d2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEsluGyb7I5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6TefjrqA72gDMroAVIAYGa17mgtO3sw2/YcheG
 XBN5AsfjpFnoSRHSfG4BXVUukWstAY0Ut5RHutqrg2AooLW+wGYA2IDQxZCZcYguctwQiYlv
 neZz43BBjF1trCRD3WH+d+8qTK0JDhQLmIYYyIAZRUK7sOlo4wpiB/LCNF5H8adltDpFCvi6
 zGMojI3i7gagYgMzarT1VrOiS/qo5/GQxQd7wDbGGmi62tRfISiYZ6p71nz9/tMLI+FCFKGu
 RAsgMWX6uIFJZ6KkyOJTaMGG7TBz9qMLjzQx31mB50o8Ryk/nLldodViBl4JUQvOMEeeCTuf
 mfIpBhcopRUOROCYrV6bIGxI8Ary7XwG9P4UPzdcttJZN52bgDv1D1hYV6422HrjVQ2lqc+K
 dGXfK6R4W0yDK1myH+8Qbcb2LpynCQmnzqMGtb80git1qeYaDiNU7AZPVCSb+c/qqSZvAHS9
 NUZPMyPo/lCbNDDjuDs2dZ7BTg3wbITX/gad+Q/mja/Hzdb
IronPort-HdrOrdr: A9a23:xAuOzKjjjnr/bXX3uK3ovRrUPXBQXv8ji2hC6mlwRA09TyX4ra
 CTdZEgviMc5wx+ZJhNo6HkBEDiexzhHPxOgLX5VI3KNGOK1FdASrsSlLcKqweQfBEW2dQtt5
 uIGJIObOEYY2IK9/rS0U2VFMsh3cnC0I3Av5ai858nJTsaDZ2IlD0JaTpzy3cGPDWu06BJb6
 ah2g==
X-Talos-CUID: 9a23:ydfJG2HLVF7JEVaGqmJc6EMbIIN7cUHj70eAMk+XAFxVUpaKHAo=
X-Talos-MUID: 9a23:x2Y25wS9D6v3MmVSRXT3lA9naeRC7Z3tCXoXkKc64telBA9JbmI=
X-IronPort-AV: E=Sophos;i="6.01,195,1684814400"; 
   d="scan'208";a="123069257"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Aug 2023 08:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUT9MAkp+at8frzP+6PiFeG1XPEz9GktYi5tsNF1verbFh1BMI0qAvtUaznhneVJGedFEvkAa8w22mFYZA83o6aLKAVqmRT4AtYcc+dxlW/Vg+y6TlnFEBTBs2txdTtu6CS2fRc8ExOUiRlQbQD45GXirrQZp/xsSu3YxNmMOZFl0tncCcps4lqifhYCVXQ/zeQ01/DsI7n8J0gkJlzTh2zgud+qTRXyeSWQ51zvkipfQwutr7+tKnP/Oh0kjKwWwnszuXJgcsAAgohWvOVJ7nOOTrOVLWuMUKVKlDn9KpppkiUSOHlOd/XdiPUh0b7HrJa2GHukVFTV9i/48QQ1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1897+tXoaCMui5Du0UAPEmDPfyvvi/ZosEeAVaoH/o=;
 b=HAOvDnXsLyc6CJAULjdmfyuPNUUdjr8vUic3OABvpYrvfanxy2nS4+epYYr1hO8nFtEPojYHxY4Xh0r5CehchenaqVspw/RBR24PMcO/JAe4VJ8GE8CjroVKTXcBBAeWoB5IxOWtpS3nlJr9r9EOwvA0ZgK9oRzbOWvUys3meSjSbEU27ic5489UAPn6QS3V9G+JZmKOKBcLkzoKeoo5nMuaY3yZNgOsDGv5YdZrNbepBulwndqz4amJY8WiGIsbkPXn2JHG+CpfqjPz2D7Alsq095vG+5DwwzJ4RUslieIjkbeQFalZJ7ZxufEn3zzIWq2yiyBlt1W51X3M5m/+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1897+tXoaCMui5Du0UAPEmDPfyvvi/ZosEeAVaoH/o=;
 b=Klf50ZKPILpB05regeBn8v7/hk524MXv/+kGmytYiuMt6uJylSOVTWhfblPTHgHDHrrlF/2sMEyXsa/lXV3KW1CDrsNlxATSRFaeaQimPIagAHAxYxeXJ1+7Bt55C1iw5pY3eF/sMjKUeGLepBsBplMKl0UNqUQh5eASm7VZmDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ2PR03MB7139.namprd03.prod.outlook.com (2603:10b6:a03:4f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 12:22:41 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 12:22:41 +0000
Message-ID: <22eb07b3-6de4-9fc2-fb05-2c7ebe6dc951@citrix.com>
Date:   Wed, 23 Aug 2023 13:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
 <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
 <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
In-Reply-To: <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ2PR03MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1ede2d-3035-467b-96cb-08dba3d3a55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDtQGZgAZdsuXXjsjHOMH9B07RSMG7/2R42Fqpywsh5nG6wAJENDFiB9i0fN6/2B3ntzfvcbF4FRprn8KN5rAcftMJ47NZ1VWMfH0/5oYYc0+5c2uq7gBf8nT08zPGYHlaH0Ea4K+RYdVE9PtZJAt9Nosu3TsrCXpB+8TpIWTGG+cDNnuGdOovcwz06VsTVs6VDpsRpq9BudC8ObzUGjWNMok1uVVG830BSTU2SbvzsXiUVd3Ny/zCtcoRUCNbO4GH3VD9UlzA4vhzoBjCGzeusaPAIKoFMrMchhWmxPKS8eJoNoeCl3ZPuja6lkOQMzwGS5PzplEpGbIt4NMDJ7s+ub5H+2ek9w06rSHt26ZwhgOxn+6LYpqHUQZUPgplTIEm13wSPvOTJhNm1nT/sWUr+Wb58TQPJ0q3Vvshk6o/T3BrKu8TclNSFEYVMbRerccT4gO0LCkAud7rbCjfI32JYz71HAq8luKSNQVlubvlDRyoqV0ZqxfwEkknskW33c1EpE5/WR0RRdPu7VxJnVA9m/Y5Mufdudn+C27+z1/ecHvigSV0r4yI03aqWyEYvOE+AFd6YnFe4TNG9UauemrCUzWDkg6L5g0M/CNm/Ff7VC+WkJg0Idar0mVZuGwCPUQPlX+TWFlbVN90V0kWyVwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(6666004)(53546011)(6506007)(6486002)(2616005)(6512007)(86362001)(66556008)(31696002)(4326008)(5660300002)(2906002)(7416002)(38100700002)(82960400001)(54906003)(8676002)(8936002)(66946007)(36756003)(41300700001)(6916009)(66476007)(316002)(478600001)(83380400001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNBTzNFQmlYSThPaS9IbVpGLzJhbE9uSzRHRzJXQ3JESnZqOTJ2MTlkSm5C?=
 =?utf-8?B?OCsvaTlBK0tJcllDRGt4NGpoVmE3SDhUSHpNQ2xBSXhoejczQ0NRM0RDR0N0?=
 =?utf-8?B?TGg5K3Q0K21qYzhocjZ3TmU5MlhpLzZEQkw4SXZsTVhIa1cyQ2E2Y2w2ay8x?=
 =?utf-8?B?a1dEWUtpbXduVi9VWnh0OWlnc2h4QW1aZ0NlRXozNy9yTnJtZjM0RWlITm1C?=
 =?utf-8?B?MGdPOFpWc0JJbUN2NlM5MHBQR3pPTjJTdXk5YnRnZWNVNVNJeTNwaFYwalds?=
 =?utf-8?B?N213VjlGNjRQOEFVUkJYVC9Td0lFeXRRdFM2Y2pWcXlOUmVHZTRPNTBiWUpO?=
 =?utf-8?B?RHJLTnFkaDBpamRPYXNPWk9QcWNzd0RSdWROZ0dpZnlRcktXV2xQZ2J0V2Zs?=
 =?utf-8?B?dmtUSVpXWkwxS2w5cGZpZmlpTWlvMGQ3QUhJZGMxWEN5NHM4TmN3RXZXdDg2?=
 =?utf-8?B?aDJnNS9xODFUVFBLaXU0MkFmQzlwa3RnSDRLYVo1K3lDNitpWFdWWktrbmlw?=
 =?utf-8?B?eUhNdTEvNzV0Y3lKQkY2cXZtYnlMZExoZTF6WTBSSm5iT0YyTkljY1hMZXND?=
 =?utf-8?B?L0dHZmJtVEUyL2ljNC95dVo2eTE1azdNT2RtWUdzUzQrUmh1ampYN1BON3Fp?=
 =?utf-8?B?UTlkZFJMVkI1TmhYV0hmTXN3OWs4RVdVQmdBOHZVaHM3RWxtcFhCWmNDanJH?=
 =?utf-8?B?cG0rUVZqQXc1dXowSlYwNDVmQUxwcUZpZWN4Z2lScThZUTI2S2dTTHYrcHd0?=
 =?utf-8?B?UHhOSUxxSGNMbDk5SEpwR2hDRDkxdGRkakg2WDM1NWR3TG42bEFtS1ZaWThE?=
 =?utf-8?B?QzBDamJsbVJyOG9oWm9VTUtEd0NUTERsQUxUemg4M0RhblRNYVY5K0F2Q3Rz?=
 =?utf-8?B?Zk5iSDV4YW9BV1pxcW1IREI4VW1kNmVXVEpDdzhmeHVYR0NuSXRBTXI4ek1I?=
 =?utf-8?B?Tkp1bEZhZkFxRE5JcTM4b0ZyeDNPdmJ6b3ErL29rUDZWaVFFVU5MVXBmMXlG?=
 =?utf-8?B?M0RoYll4UG9wd3RFbXA4ODlvcWxmQ1dGRGRVMWxSZkx6YTFRT1lJVEo4OXR6?=
 =?utf-8?B?dnRzMEliS09ZbFJBZDh4WURQWEUxY0J1bURKY3hDMUFSanhjZEpIYVllMkhL?=
 =?utf-8?B?WW8vekV6NllYSDRlVFpTMkYvZ3RBaGZzaG80aGVPN2tYSlpyeE5pVXNrbEJE?=
 =?utf-8?B?Mlo4UG00czNVR0Q2VkJqUmduL2gzYjQzckkrYnNaL1F6aVcySnd4RldjT1pV?=
 =?utf-8?B?aTZkRU45c1pFWDFMV1hMSlNlTnB1VWpyaEt0Z1dzb2RCbzQ4RXY0RlNzU29N?=
 =?utf-8?B?My9qd3FLQkRnR1U3Q1BtcFdUbXNFT0tkTE04dm9UT3diZTFYcjB4ZW1oUzcw?=
 =?utf-8?B?NjUvdEVNaW1ZZVVJL0ZCQzJUbEw3ZU5yVmpBOGdUcVpPZEliRy84R2VZNkY2?=
 =?utf-8?B?elErdStnMFEvY1IzYWd5dWU1eWVRajNvWjlCTldaVGw3bjFDanordVo3YnVs?=
 =?utf-8?B?RzFtek9pL0ZWNHlGeThMU3MzR1BwNWRsd2tCRXl5QXpOOTlSU2VCa1VxaHRs?=
 =?utf-8?B?RWErWU4yZHVwWWhxaWtNWEppbFU5bU82b3RKRHBiREJiVnZkMG50T29XTGt1?=
 =?utf-8?B?ZUxmd0RGTTRUeGwzOTd2MUczaUd5U0ZqcU4zbms5WWxpdjRpd0IxYU1CSXha?=
 =?utf-8?B?Y0g3WHh0SjcwNHh5bHBPSXZsOXptbDJQOTRyb1Y0aC9HQTVQaUVGbzlrTXdZ?=
 =?utf-8?B?bnVscnVGcDdBUXVxR3lEY0FZamtnTlVYN1NOSGxNVFJUV1VFeFlSYzl2QmFv?=
 =?utf-8?B?RzcvSlg4V0M5M2xkdDBaYWxzRlNwYlZMUFk1R0RQcWdab0dsYTU0a3gzbmFT?=
 =?utf-8?B?Q1lwbHQ4MENabkZoTEkrK1krYmRnVUc0OWNpK0FDSDlHc29KUGZSQjdWdlZn?=
 =?utf-8?B?WllKWDRFVElnSmxJNG5OUzdzSDBTVFFDRXFGUFd0djZpZFR5eXVLNEpscTBl?=
 =?utf-8?B?ZXdlV1dKQ1RiV0JEVzRRVmV5R2RncDRGSm9zNlVBczBqWmhzQkJHTTVGMHdv?=
 =?utf-8?B?dWdUcy9nd0tvZzRVUWpJd0xhVlhXTXVaUXd3OWY0STJqMUYweXg3OVk0a08y?=
 =?utf-8?B?cjQzci96M0xSUjZ6NTJOaWdCMUJ4Wk81ekdmSzR6NXJVS0J1ejFocHZHdnBB?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TGZKbk12eE5WQk1BeE9UNnhteUtoQkh6ZHVnTWl2OGY4RCsxamJ3QnBWZnNT?=
 =?utf-8?B?cHdHMmNWeHVNbjNlZlNEVHZsdUVlbjkray9IQ2tKMnlhM0tYdzg5VmdPbVl3?=
 =?utf-8?B?VnZjV3VSMmd1RzY1WVN4NWlidnpKL0Z4eVVvaU1welhwRWZnWW1HTzRYbFBQ?=
 =?utf-8?B?TFZkWU5PdklhVXUzUjQ5cXJKNkRKamVFZmpiSHlzOFI0TWkycHJ6dzlkMjYr?=
 =?utf-8?B?ZzBuTnF6YmxybmUxU0wvU3RLbGhOemRsR1IrVGxKZEpOak9WeWpLLytvQW85?=
 =?utf-8?B?UGhCclp2aWJoZ2VvS1pXSjJmc0RMdkRNenQ0VFg0RnFQdy9JT0dvNmwyWWli?=
 =?utf-8?B?b3FBcHJ0MXBudDRuWEtiaU1seW5nbm94WHpiTERkNmFQNG95b0pGeGdWRG1B?=
 =?utf-8?B?ejczOXVGRkV1dEowc2d3bExKWURkTVJxRWY4S0J0akFZbWVFb2twaFZkenJE?=
 =?utf-8?B?WWp2YW8yZGtqWGU2WFJnaEtSckZqWS8zMW5ETlYvMy8yc3luaytkekxHVFpt?=
 =?utf-8?B?RjJwZ1haYVNpUkFOQjlrRmhNVzdNU2NpN0FIMFF5eDBLd0p3b291V29jcXNz?=
 =?utf-8?B?OFgzM0M1MVNva2QxVHhFNG94QkNNblA5b0dQQmh6Rmt6WkEwZDVNam55cXV5?=
 =?utf-8?B?dWkrMVR5Y1laclowUWlyRU8zMENOWlVLbnJYa2NzczFLdWQ5dzhrb0lPd04w?=
 =?utf-8?B?M2paRWIrdS80RnV4YzZySDBIbm1Lbm56TkNzWmlCbkNhL1hjeW9IZTFOY0tX?=
 =?utf-8?B?Q1VEbjE2Mk9NdEJZSjZtWHFJeDhWNVFjRk5GUUhYbWxOTXhFQ2JmSzFIY2Vw?=
 =?utf-8?B?ZkgyemRGbndvcXNZNWhxbzB4WjVLY1p2OHVNa3dXWmxObEhBaHNheTBHclJm?=
 =?utf-8?B?bVJKT2JkYks2Rlk1WFFsWE1NNUlrU0xtREMrRXgyMDhXL1psdHE4a2VPbTVZ?=
 =?utf-8?B?T1hpRTNibnVva25aQWVnNERyUDk4REwwLzVXbVZrUUVGNUZETndFVml2WUta?=
 =?utf-8?B?M2tnaExqYk1rVlk5RGVnd01SZ3JhdzhjemZJMHVqRVV3UlFwdEtDWG9BL3BE?=
 =?utf-8?B?M3AyL3NKeTRDaEpuZmc4dEJNeHdPSE5MUlFVTEw2YmwrSlRKREpjSXZOblkw?=
 =?utf-8?B?emtRQzIrL2l3RC9zOUc0aHFXYVY3a1ZSTktTNVBINmhTekZSVHpyaEdiYm5o?=
 =?utf-8?B?azYvdmF6TXRzQ09XYUNCY3h3RnJjOG5kS2hGaUJHNTQ5N0FFaHdoUTdQWTdC?=
 =?utf-8?B?UWJzVWxwYkFYUUJPUnVKSnBmV005cTBTQVYzTUFsY1VSR2d5NGlsWWVCM2h4?=
 =?utf-8?B?cnRBVUlaT1Exb01rczdPUExxQ2FjL0gvTzRJR3hLMWRTbjUrV2p4ck1qeFh5?=
 =?utf-8?Q?f/3dEI8uJMBX+uBzd2DlK0LlznbUd2PQ=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ede2d-3035-467b-96cb-08dba3d3a55f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:22:41.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCPDRrhyTC14jtZ9C/+HREfzXvO9WMU6M+g7sCKaVyD8wyavoa20n0zbW7oI5am0DyO/wvUt5n7/qOPbRW7+OWOeFWmX5+nF7FtomPNBTK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7139
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 6:20 am, Borislav Petkov wrote:
> On Mon, Aug 21, 2023 at 04:06:19PM +0200, Borislav Petkov wrote:
>> And I still don't know what exactly we're going to support when Linux
>> runs as a guest. For example, live migration between Zen1/2 and Zen3/4
>> won't work due to the alternatives patching, for example...
>>
>> IBPB won't work either because we detect those feature bits only once
>> during boot, like every other feature bit...
> The lowest common denominator of features exposed to the guests,

Correct.  This is what a hypervisor will do for the SBPB *CPUID* bit.

> should
> work, as I'm being told. As in, Zen2 and Zen3 should hide the SBPB bit
> from the guests, for example.

In my previous reply, I explained why this goes wrong when Linux ignores
the CPUID bit provided by the hypervisor and decides to probe manually.

> I'm thinking if anyone cares really deeply about live migration, anyone
> should say so and then we can see what cases we can support upstream. My
> guess is those who do, have enough engineers to patch their kernel the
> way they want it...

No.

You don't get to take my code, break it when integrating it into Linux,
then dismiss the bug as something hypothetical that you don't want to fix.

It's not *me* needing to patch *my* kernel when this goes wrong.  It's
me (or VMware, or HyperV or one of many KVM vendors) getting a bug
report saying "my VM crashed on migrate", and then having to persuade
Debian and Ubuntu and RH and Oracle and all the other distros to take an
out-of-tree fix into their patchqueue, then release another kernel, and
then come back to this thread and repeat this damn argument.

I'm just trying to cutting out the middle misery here.

~Andrew
