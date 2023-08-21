Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4EF78360F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjHUXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjHUXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:01:43 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD4129
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692658901;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zis+3IIKZyZwZmjolk5yOCLoQX4cz4siarBi9SfLng4=;
  b=AxnOqy021/ugwoUcoK7c+0GEAqHlwPH3EA9AiQBynFblpsmUBQijlsJR
   52MitAVKEuJBLZtY22C7foR+CLA5zBFWKHTPRX3ggyHje1gOPyZ54dx6r
   bRjrMCYA7Q+Xs0O5fA3SIJY4i5RpoRW1PaQdjkl8+7qjVg9SF5EbMaThv
   w=;
X-IronPort-RemoteIP: 104.47.56.40
X-IronPort-MID: 120196129
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:zaY+iag07Vs68ApdX2ChmlMdX1612hEKZh0ujC45NGQN5FlHY01je
 htvDGiBPfvcNGvxLY91bN+/oE4AvJ/Qzt9lTQs/rXg3FXsb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyr0N8klgZmP6sT7AWHzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQqDC8yZ07T3N6w/4DrRcNTlsg8deTkadZ3VnFIlVk1DN4AaLWbGeDmwIQd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEvluS1WDbWUoXiqcF9t0CUv
 G/ZuU/+BQkXLoe3wjuZ6HO8wOTImEsXXapLTuXhp6Az2gz7Kmo7ExRVDQeYnN2D1GGOBM1FG
 QtN1no1hP1nnKCsZpynN/Gim1aGphkdXtBXHsU55RuLx66S5ByWbkAATzhceJkludUwSDgCy
 FCEhZXqCCZpvbnTTmiSnp+E/W2aOiUPK2IGIygeQmMt6cHLqYUygxSfCNpueIatg8H4AyPYw
 jaEtiEyirwfy8kR2M2T91nNnnSpoZfEVCY84wmRVWWghitVbZCka8qL4EDf5PBoJYOVCFKGu
 RAsncmdquoJF5CWkzKlW/gWEfei4PPtGDLGjFFsH7El9jKw63CkYIZc6S1/I0EvNdwLERf1b
 0vDkQdQ4oJPJnysbL8xb4/ZNigx5a3pFNCgWvWPaNNLOsJ1bFXfoHkoYlOM1WfwlkRqibs4J
 ZqQbcerCzAdFLhjyz21Aewa1NfH2xwD+I8afrijpzzP7FZUTCf9pWstWLdWUt0E0Q==
IronPort-HdrOrdr: A9a23:LMlG4KBsDqgAGsXlHem755DYdb4zR+YMi2TDsHoBLSC9E/bo8v
 xG+c5x6faaslgssR0b6LO90dC7IU80lqQZ3WBuB9uftWDd0QPDEGgF1/qB/9SKIUzDH4Bmup
 tdTw==
X-Talos-CUID: 9a23:kfS9/Gxh2TlB6jKTobWvBgUmPt8aeyONl0vWHH3oBkxWWLGKEHKfrfY=
X-Talos-MUID: 9a23:MHeZqglwk6yiQg56YVHLdnp5PYQwv4eTLHpTvqVZpNO2cnVcayy02WE=
X-IronPort-AV: E=Sophos;i="6.01,191,1684814400"; 
   d="scan'208";a="120196129"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 19:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1kMe2cMokWzbKgFmTrIv2ONZ172BVkWr8Nj7+Att0Hcfu/t30fxOrGnI3eGOPRTAx5cl/MuFPGo5mwEguki2jRAj/RCmKyVY4WWuu1pjeLY7dNRHJAAZ+VZhLGUjAw4YaVFaT1bOwRIw5tqZEIL6NolbIdv9LDr6M2FjGXV3kKm6s4st9fNAj0r5wcArH1gLLfvmY1sq2mpkPRGe64BZN8DLKUnYS4iXMTbcwpsFhVeskpPNGQxThRgoVHeNRouk7O2Jo7ssuTS5wKwzTb/hoNS76le/H+JoI40TWNIpgaybaScS0T4WZxkFfe2X81jvB9iOIlbZ7EN1+tl+/Juhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+wiM+UT2SnZbNW0YZV4umRkeaoLspFFeuPUsDUMtf0=;
 b=anL3mPATFrm3TncRuk9reDZsrswXKYtWe4SuWM7wamqsHo96yToaF31diFYHsrExVBFWOn8COcD/I33zVlhpbsJY+x23fZ4GbcMHUtTCwBFi71XgsPUOiAFw1xvXkXy7kjl831dlX6xqFN0U/VSV75+M8pRI3gj5Qh5XBYcY0VOpn14IIR+Pp8MP39fDqvFmLuik7P0sxFVlqBbwnvjrYNavxJrV3tss1pqFtHKiz1wJ/RJEWGdzaPuTs/H3a1MSVRYVqg1vxKUCoOyGkUqH7e6tYhZ7fgtbLutjIlgrrYgS7R+tIxsLGWSgtsdSLsWyhJesOFYTBG2QxvuAu8PyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+wiM+UT2SnZbNW0YZV4umRkeaoLspFFeuPUsDUMtf0=;
 b=OsrQLZ90CJx13CXZ+zAJxsf/BhtjH3hmTnBuwT/evWDPq4ioKhNC6HRLbmQGyCD5XodFBkfAVN3OC7xtmt0JE4yCpd2fozSAmgvv7Wb4YXsP7/S3kmIU4gxEC51JNonfg2p6mxMAp2/o40nBrtUdBEunA7643SQzDVro+IqtsgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6254.namprd03.prod.outlook.com (2603:10b6:a03:3ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:01:38 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:01:37 +0000
Message-ID: <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
Date:   Tue, 22 Aug 2023 00:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
In-Reply-To: <20230821151636.onk2e6tlhmjg5yz5@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8f3f1b-c980-41fb-d931-08dba29a928d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUYUwxCXhjUpGGB6FcBVoPXve3gVn5Gxh/hB8RGrBQHEPwy20cjpoTNFfR5ApNLouocYi5Q9HGGLY8mb2ByVdVLbNPrtkoRnio+WZZn8Qj3ThmyY/5z9RrXqDLVMACikVSOprDkK9x8cFCsqKh2j1kEcwmEIXsNRsxAghDptyR0p+dW7wJB8DNG99YitCqOMEHuvWvaLX2rteJ6YuclxTGXoPwcDlYtUECys9X7rVLTz4xUT46wU1dD9/4s79IKmeM6M3jfP1U2giGsm7Z5WsyxWx+9TY0Q8v5eFbYR79cbKEvjU8m0dYo3CE+Su4FIBbCaY1lbuQA0jsW/LURuyjw0kJyWLSz+N8xdNzwQdUH0tzhKrvINzr+C1x1a8w0pA2xgeUCOewouvSQZT9JGYKwpwws8NZ1RAEcJqtICbt783+XV9qf/WcXnZ+uXU5Nac9mrZpe8CChaDgCKabBBdsnzZMkPuLZLvIsHoHTrxJAUh04f7l3MiTwpRlv6JTpqdPfU6yHn4uzkkfyeU2zs34G5taL6RPfwjUQC1tUu4yJq7pmzjWGMnzXb7URtjHbm1JAGt7dqVyuKg6pIzkfVgz6XqkpSEeMQdTy9knXG4JRlqQ6poVplo7egSgjxUx/O6vMoxfzfLsyB3x75Am96ptA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(53546011)(6486002)(6506007)(38100700002)(5660300002)(26005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(316002)(6512007)(66476007)(54906003)(66556008)(66946007)(6916009)(82960400001)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VkdzlmSWdlRFdxTXpSOU1FbmE0TjlCL0RUWFpZaWNtTFNsVXVsMzZyeElV?=
 =?utf-8?B?WXJCdEg3Q2dPTVlEUHEybUk1MXg1WXVMMmV6OFZMQ01yV29WdTBwNlJhd1g0?=
 =?utf-8?B?WTFOVHY3WGdQRjBYNm5qQkM2aEhhY0hLMk5xOTYycytlalloS0tyZ2RTeStT?=
 =?utf-8?B?RjBScHdLZUk2bWNjWmtuck1zYzRId3ladFFiMnFZTi9iVWg5cldxWWRycjlq?=
 =?utf-8?B?aXoyMWxLV2l5WXpqb3h5dlI2dzJJcnhiNzIrMXQzdlBoVndWc3lIVjEzemdv?=
 =?utf-8?B?WHp4eXh2UHFoc3JwVTZKUU1IR2lNdnNacVk5MGhZdXVacWFDWjRkbFlzNEd6?=
 =?utf-8?B?VUdtd0JGcmJaVU9HZTl5OUMwUm50YWt6N3BiNnV0a1dqK1VOQzViME9wcU0w?=
 =?utf-8?B?UVk3M0tGcXVqQStGZDV4bnBEb0RnRUovakZsbkFGVWVXSVc5MHFLK28wQjR0?=
 =?utf-8?B?U09KS29kemNrdWNyMVlReVBCak5xL0h0eU5HclZqellqbEsyNzBjZGh2c201?=
 =?utf-8?B?MWw4a01WRjhvVVJaaGRHNkRITW9OYW9IWENIb2ZaTzFETUI3cFFndDhlaU9N?=
 =?utf-8?B?Y1phNndCMnZrTHBQcnR2MG0ydGRqc01HSHA2emNUNEN4L3pBdUVhSVVZNU95?=
 =?utf-8?B?cGNSTitJalFrT2FXWHJyM1V3amF0N3V1U0wvamZqRlFNcWxaT3Z0YmNDU0ZO?=
 =?utf-8?B?ZTZ2SVRNVUZNdlhZdDYzSFcyMXZ5cmpqcUx2RHNZQ3hWNFNXelVpS3VjTHBF?=
 =?utf-8?B?akVvMjBPNTV6c25nOHliNE5Tajl6WVlFRFo3cm9QV2NobUxhNlV2WHF5NDN5?=
 =?utf-8?B?dlBUdVNpL3hXZll3UDhOOXJmVkd4allKYmgvVENnRVEyMHNISGlyaDFDWEtt?=
 =?utf-8?B?OUFlY3huVzkyWkRJaGVpYkJkQTR4S0JodHRQMzBpWkRCKzlzMldiUHVMM013?=
 =?utf-8?B?R2JObHlhQTB3RmVwbnZTWlg4dDZodE9kWWxSS3NoYzg1S3ZsdHdBWHl3UGJM?=
 =?utf-8?B?V3VDRzVKQzVhVDRrbGp2UTVhclA5K1JZRkRQUkhnY1RWNS9iRFU5ZzkyVDQv?=
 =?utf-8?B?bGsvYlBTUnpLUU1RMFh5SkI0dG9rRjhrQTRHQyt1MWRsRnl0cTREUG9pLzIz?=
 =?utf-8?B?Y2VhSnJseThDc1FEakFqdFJGdGUwZGI1Zmc3bUxrbUp5d1FXVHd4ZXdNOTlO?=
 =?utf-8?B?cWc2M3ZDUHAvc1JOT0RPbnpTRkcwejZGUDk1MU1JRUl3L3dCeFJFd3g1NlRk?=
 =?utf-8?B?dXArSlFWSWZFZFc3UHZjd0plSmdkcjRzU3lncU1kcHlDempNNGFWc1o3REJp?=
 =?utf-8?B?VGF1bFdsM0xMZmUvMTdRU0JBeXI3NVZROGV2NlVZRjR0WVdVWmlJcTdVU2hO?=
 =?utf-8?B?by93YWwzRGRkQ3o4UUJlMnUvWEFwYjNJaTAyQXJJbXhScVQ5NGxoMXR0bkdm?=
 =?utf-8?B?VjMrc1pNT1hZSnpER0dmQnVhODlUamp6N2pJb3hGRjFpdWtFaEkwV3hoNmhZ?=
 =?utf-8?B?OTcwTFhoTkNaVnlHcSsxQ05QZnMvSU94cUJLbVhGN3EvT2VvQzY2UWZMT1dS?=
 =?utf-8?B?YlJoUmlJMUxyNlg2SWV0VStEdmlZeTd2YVRMMzhZcGpUcnBUVmpBUUM0UUpV?=
 =?utf-8?B?OHpGeHZPeGI2NGk4MWxKZjVxL0Y5UEY2Vm1UNkp4TUNreTA4VGxXd1lvN3FR?=
 =?utf-8?B?L3pHck5QS0FzYmVvejEwRm51YTBycVJOTFdCY0FMdXg1dDJoRjJ3aitEbGNz?=
 =?utf-8?B?R25xUnFraXFCdDdRUWRHbWpqakgvdHJGdkQyQXBTMnJlRGEydVphbmFaZGEv?=
 =?utf-8?B?aTBkZVdBY0trWHhSWVlYOXVhVC9UdjZOTElBRCsxZ3VmNGlOYlE0YVJBeWlt?=
 =?utf-8?B?VlR3Y21qbE5jSHc3dHBIS0NzRGpMakhEVjNpU1JxTWZiZm9tQXZOZkZwRkNk?=
 =?utf-8?B?L2k1QmNwUStOdVorc3hya2l4Z2ZtQTBXRnBRNkc4aTdjdUJLUG5sMUdkUDBj?=
 =?utf-8?B?bzR1K1Y4M3l1cnBkYlI0amJmRktHOXhVUG1Hc0dLbE9CWmg1eG9GNHl6TG5i?=
 =?utf-8?B?VWphYlM0bm9yckllcW52NWJaeC9Tb2cwQStORTIvazFmTExnci8zV0VCRDl6?=
 =?utf-8?B?djZyTSt5L1NoRGhKWGQwVHRJano0L2lvL2VNdCsxN1U2YWJiblh5b0xWY3NM?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bGxjdUdGUG1maXdLWXo2QUpKRTIzeHVTeW5HMmV5Y3RrTWxvMGEvVU1NNktx?=
 =?utf-8?B?MEVHZFZGeHhGWVFVcThybHBvRVpIaWtWWFc2b0Y1aElvWWhnaHc1MXFvbUJo?=
 =?utf-8?B?ckRNT3dBd0o5U25Bc0k2cndYcHM0d3Ryc1g3RjI4YjV3Tks5MXJSdG8rdk03?=
 =?utf-8?B?WDIyYWRDZk1iK2xXNWcrWnExVnJBUXNvVUc3V09zVm83NVQ2b3FOWHFRUFdY?=
 =?utf-8?B?ZHdQS1RIWThZNHUveHI3QjF2Y3drTU1zVS9lR09CeHJPMVk1ZUYybXZsUGVY?=
 =?utf-8?B?Z1h5clBuZG9oajJSN09ubkZhK1RpNksxNnlDT2p2Z1YrMGlqRlJ1czR2QTl4?=
 =?utf-8?B?K2x1TVdYdC9mMFR4NnU0WDFHRjBRV1dmMDdnbFgya210ZWpLLzhKWmQva2V2?=
 =?utf-8?B?UFZGS2VYbml3YXhsc2NIRW11ZFZrbzVBUkc4aWxhWUs1d0E3cnB0T2xnR3J2?=
 =?utf-8?B?YkRGRDhyMjZFZTBoNExZNUp1WUhqMjVnekhNY1U0Qy9uNDVPU1N3aUYwc00x?=
 =?utf-8?B?aEJYK3M5U2tiUmI4dkthUnZKV3k2NHVlZlhYWnVvV1BKc2JPUUhXKzZCK2Vn?=
 =?utf-8?B?QjUrOHczckl2OGFvdEpwbFhSV2hyb01peXAveG1UK2R0MHBkYTN4K1NMNlIw?=
 =?utf-8?B?UTh6MEluMTB0Y3pKZmEwUWR4SkRET3A5NnV6ZXJ3emNYbXcxYmhmQmJtSU5C?=
 =?utf-8?B?aGl2NmRyM3JlRzBLSzc3RXBSN1cwejdlRmQ5UnM5S05JRnNvL0UybTBVeUxv?=
 =?utf-8?B?eFJlMmJuVnJJazNocUZpTmIyeVpTdyt1cDVIcERabFBpRUJwRXZRcktidWcx?=
 =?utf-8?B?aWlJVUxJNmxINDVTaDZJRDFRVy91RzZ0c2EzSGFjbnRqUVAyTU1TVk9SdXhi?=
 =?utf-8?B?Smx0MDV6SjRjbk92bkRzNEhQT21iaGc4dEhZZHUwN3Uzd1E4V1dQcm1OQkF3?=
 =?utf-8?B?cDltRVl0OEE3YVc5RnZPTVp0KytUTDJzcGNna0JwNExUek9ON0hZVi9jN2ZQ?=
 =?utf-8?B?MFZyYk1IYzJFVG5tWGFIUkRhdllsUGlHSUxXb2tmWm92My9OR2hlMlRWOTR4?=
 =?utf-8?B?WTBSdjdJNFRzeXgrRFRhRXNWM1B3ZWdEaCtROTA4TGdhNk9QMC9uV0xXaE1q?=
 =?utf-8?B?aGJWQTNJdG0xbFlCMXM1VFlsdEFRWTZsUmZtZ0M3dDRnVnJpczY0SFBBK3Bo?=
 =?utf-8?B?dDFTbFgzWFFrQlIvc1JnOTNXNnY1UlhNOXB3MnpCY0duV3dYck9LLzFyK1pB?=
 =?utf-8?B?eUNVNXdDTEFiNlFwN2hUSU9PSlVGcDMzT1d3N0JzQ05yOG52ci93dGY3TTUx?=
 =?utf-8?Q?N0qQVx9L9qB+rKOHoRkzLYjxL/kwb0ihzS?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8f3f1b-c980-41fb-d931-08dba29a928d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:01:37.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuMEQh19cLdoJmxoCNFX9fFsVXUUulCU6nHh1/9Ky2NMhAbAHfD9SvmkE7sfwGd+/fvkdWHdfub1xNa1zy2UocpVU7Jn6pdWoKHIVW8T1yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6254
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 4:16 pm, Josh Poimboeuf wrote:
> On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
>> The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
>> has been made safe in the BTB.  Specifically, there needs to be no pertubance
>> to the RAS between a correctly predicted CALL and the subsequent RET.
>>
>> Use the new infrastructure to CALL to a return thunk.  Remove
>> srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
>>
>> This removes one taken branch from every function return, which will reduce
>> the overhead of the mitigation.  It also removes one of three moving pieces
>> from the SRSO mess.
> So, the address of whatever instruction comes after the 'CALL
> srso_*_return_thunk' is added to the RSB/RAS, and that might be
> speculated to when the thunk returns.  Is that a concern?

That is very intentional, and key to the safety.

Replacing a RET with a CALL/{ADD,LEA}/RET sequence is a form of
retpoline thunk.  The only difference with regular retpolines is that
the intended target is already on the stack, and not in a GPR.


If the CALL mispredicts, it doesn't matter.  When decode catches up
(allegedly either instantaneously on Fam19h, or a few cycles late on
Fam17h), the top of the RAS is corrected will point at the INT3
following the CALL instruction.

When the CALL is corrected, speculation continues at the real
destination (the {ADD,LEA}/RET sequence) where the {ADD,LEA} pops the
"wrong" return address off the stack and lets the RET take the next
address up the stack.

The RET predicts to INT3 following the call (which is safe), and
eventually gets corrected to the parent return address on the stack
which is the real intended destination.

Therefore, rogue RET speculation is always safely contained at the INT3
until the RET uop can execute, notice the mispredict, and correct to
what the stack says is correct.

Of course, relying on the fact that the {ADD,LEA}+RET sequence doesn't
have poison in the BTB, which is what the UNTRAIN_RET sequence is trying
to achieve with microarchitectural means.

>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> ---
>> CC: x86@kernel.org
>> CC: linux-kernel@vger.kernel.org
>> CC: Borislav Petkov <bp@alien8.de>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Josh Poimboeuf <jpoimboe@kernel.org>
>> CC: Babu Moger <babu.moger@amd.com>
>> CC: David.Kaplan@amd.com
>> CC: Nikolay Borisov <nik.borisov@suse.com>
>> CC: gregkh@linuxfoundation.org
>> CC: Thomas Gleixner <tglx@linutronix.de>
>>
>> RFC:
>>
>>   vmlinux.o: warning: objtool: srso_fam17_return_thunk(): can't find starting instruction
>>
>> Any objtool whisperers know what's going on, and particularly why
>> srso_fam19_return_thunk() appears to be happy?
>>
>> Also, depends on the resolution of the RFC in the previous patch.
> I can take a look.

Thanks.

~Andrew
