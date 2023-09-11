Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABCF79B320
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353802AbjIKVuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbjIKQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:30:10 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A6CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1694449803;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DdWMFFVHgn3UwA9w85tG7eDlRHmfMxOqYT9IMSekmYU=;
  b=iEPBqmP6d5AJRwlG4YOfqxxEvneXW7SGY3zfwtxoCq8ENm+ffHrxfh0q
   PFKWRMXXlC3tQ+oyL/JVK45CJEqLniYFfuFvgJw14eiKyFCR2dW9H9mWT
   xN2p2xV2Nyph5mhIU8AUFYsRAsQcABzOmxcMMzuDdtn4t9Rb6X/clzxdi
   A=;
X-CSE-ConnectionGUID: kKvD7ioVRoKG3NzF50eikA==
X-CSE-MsgGUID: A6Pq6k/KQwqqOlhcp0ywjA==
X-IronPort-RemoteIP: 104.47.70.104
X-IronPort-MID: 122705713
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:7x6ylqyjTJgx14Xdy356t+dHwSrEfRIJ4+MujC+fZmUNrF6WrkUOz
 GYbCm3Sb6neZGT8Ld8iPNvlo0JSvcPQx9UyTAVvriAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjPzOHvykTrecZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EkHUMja4mtC5QRvPKkT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KWJt6
 9BHKTczVBegqLmQ0pzmEuRthe12eaEHPKtH0p1h5RfwKK9+BLrlHODN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvDCVlVQtuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiAthNTODnr6UCbFu77zIrEUMVEniCvuCgrUq+UMoHO
 lMW0397xUQ13AnxJjXnZDWgrWKJpAw0WtxeCeQ25QiBjK3O7G6xDG8eTyUHb8c6rsgoXj87/
 liTltjtCHpkt7j9YWiU+bedsz60NTIca2weTSYBQU0O5NyLiIszhwjGUt9LGau5yNbyHFnYw
 TeM6ickhrAWpccO2+Ow+lWvqy6joojhSg8z+xnNWWSk/kV1aeaNfYuz9VXX8d5PK4GVS1ia+
 n8elKC26e8JF5SEkgSWXf4AWr2kj96aMTnYkHZuGZc7/jig8nLleppfiBlgJUFiP8AYPzD0Y
 VPPvh954J5VNWGtK6htbOqZCdkwzO7kGNDhV9jOY9ZOa4Q3fwiClAlrZEif2Ej3nUQsmL15M
 pCeGe6sFX8yG7V7yyDwTOAYuZcnzz4zg2PaQ4v2yTyj0LyDdDiUT6sINB2FaeVRxKmciAzR8
 ttZZ42Gxn13VPDiZQHU/JQVIFRMKmI0bbj/qNRSXuqCJBd2XW8mFvndyK8gfIojmL5a/s/Yr
 i+VWUJCzlf7w3rdJm2ibnFldaOqWJNXrmwyNi9qOkyns1AnYICy/OIceoExcL0P6uNu17h3Q
 uMDdsHGBe5AIhzO/TcAd9/06oV4cw6irQWUNiGhbX40eJsIbxDO4MHtegf03C0PCDen8MU5v
 rus3x/aRpxFQB5tZO7Vb/S1xl/3onkZm8p1RULDJtQVc0LpmKBoJDb2leQfONwXJFPIwT7y6
 uqNKRIRpO2IqYlq9tDM3PiAt93wS7c4GVdGFW7G67rwLTPd4meo3Y5HVqCPYCzZU2T3vq6lY
 I250s3BDRHOp34S26IULlqh5ftWCwfHz1OC8jlZIQ==
IronPort-HdrOrdr: A9a23:2hTi6a7NMI8kzpPIfQPXwAzXdLJyesId70hD6qkQc3Fom62j5q
 WTdZEgvyMc5wx/ZJhNo7690cq7MBHhHPxOgbX5VI3KNGXbUQOTR72KhrGSoAEIdReeygZcv5
 0QCZSXCrfLfCVHZRCR2njFLz4iquP3j5xBnY3lvhNQpZkBUdAZ0+9+YDzrdXFedU19KrcSMo
 GT3cZDryrIQwVtUizqbkN1OdQqvrfw5evbXSI=
X-Talos-CUID: 9a23:Yi2w1mEbv834pG3GqmJk11A4RcEiTEfa71iLBV2WVD5kSb68HAo=
X-Talos-MUID: 9a23:Q0DUzAtDH2nvtDId5s2nrW9aLZlrpIeXF1kUtpEGsNHcJDNyEmLI
X-IronPort-AV: E=Sophos;i="6.02,244,1688443200"; 
   d="scan'208";a="122705713"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 12:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggyKuufq6Rum7BxqkYH7M1H7pf8r1b21TwOlU5l+XUnQhbZhfSl9lvuG84X7+PRdt/hIOopnypoCNOrHS3JbwmYmw+dF0hC6zjUk05aB/tLA/nk/xM+ZFRClOBhno/O6Xe9ONSAD4PKnIlnPnLog4GnicdkRQMSk6R5iZ4WtGvtlKVK1yer4OjOJpSlPPqJFy4Ky1OU/lo40XKTrBD67P3rKO2PAYPqBdO68mhRY7ItcOSnT9Y13CIZwiQmJazYFXZ9v7EY75NljW3PbvQFwOCq8GinU4cwxE7Fbi2pXpyr+XQVrEM1+agYUYWoQYzbmZPw8s6gGnwKuBZFd4xfl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdWMFFVHgn3UwA9w85tG7eDlRHmfMxOqYT9IMSekmYU=;
 b=ianGJnaCj1qeSSwUR8fZl/9krn9v5CxCzvtRpblyKyiJNeH8dnJ/kGsfVF4DfBV3kcbjNOCm8GuZJTw4oxHebNktqCn+kO7/MSJwE4CRf8oce+QbGp+grP5UQMB9GCmBRHOTql98p+AXIhCYQISnHihrDRSJV+Tlgsz0qnylOczA7QMHN1+4TWbE8xywz10en5mFL6Brl+sQ4RxRd7fQdHUmXg4t/1rrEFP9KZvkAs1hxL5vNoWBoaE4hjPqPCn/MJ25AZhWzmIeUty2IU4UxPFEZP8AUhlijHu+5wEy1+4FeTUKB3TGl1450FkRvVASo/EdXtpQOBnfo0pAU2w4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdWMFFVHgn3UwA9w85tG7eDlRHmfMxOqYT9IMSekmYU=;
 b=j63jlKYVASgvyma//Dhqx6GkiEGTK8UbVqeOH41cBNv+2yeCSvLpc2j/pFyXIeMqyT5WUtYtl0X3Azfn9cG9L7UZq5EG4ni/BacD3KW9sWqRx0QvXNWi7LuCZUdUsKsplLFqJDdvzFZdlenLdmZQR1/5tqFaTQtcMCGO3UGfRAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BN9PR03MB6171.namprd03.prod.outlook.com (2603:10b6:408:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 16:29:52 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 16:29:52 +0000
Message-ID: <5f443d7f-970c-eb44-fb64-38ef01cec80f@citrix.com>
Date:   Mon, 11 Sep 2023 17:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
In-Reply-To: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BN9PR03MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: db322047-0000-48e7-895b-08dbb2e452f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8AUZppKZ29ZRS3I3YHXld+6CsFwUN/tgla/ZOgUfQpfjlKXdMSKTr/jRGP6rEOEdTZiBQ1fU+EaRPoIa0hGbBhtd+yCA3vNI4wfDxWVenltUaV2vIArGIv5+rhhJoMCFp3lUpDtAwDfgsg7BaXe3ET9T2TL7ztDlyECfBlGZv7ZoxqwtEBRf5E9lG9kBUDvHu3aokRQraLQnqonepCMHatBcwWfJr5z6l55sYl3YfPLhWj1NsZ+QVw9fS991pQPEPIWyFsXBdqP7SrHDemtJq+CLSxfKVGAIJBKHiCuwbqonReg+lwQtPpsH/HWF9rZsUi4nU1IhX8xi/lOSVOekvKci7AKy5k+2nUBZO5CcmigBpNjiu/a6qPW5cUJk/zvsVlw/iCbkGa86SRjjzeOVEegMf92rwa1X0+UwBiJcWwCIYdjl4u0cEXLcmkxiNWn56+pS8U3Zc1M1E8hetibg8JPXXGRjIyVcqxE1QxKNz3qtuNimRICi9ihXo59SCzZOyJx2M8hu+Mq6GpId07yE4vCf9u8CxDkEoBZn91QnD9y4Yh6np9/NYewS8//IfE7Npodtyl/2oHWdjktz3Eli9Dr9/Cw3iEjTBgeEAnTnX/NjcRPaIV6PCOudfBVkr8J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(41300700001)(53546011)(6506007)(6486002)(6666004)(6512007)(83380400001)(9686003)(478600001)(2616005)(26005)(7416002)(66946007)(66556008)(66476007)(2906002)(5660300002)(316002)(8676002)(8936002)(4326008)(36756003)(82960400001)(31696002)(38100700002)(86362001)(31686004)(110136005)(66899024)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VEczNkbmMwMVJnSUJJVDRlalRsL2NCcWlsNXNhWXlHaERwZDRicTE3Qng1?=
 =?utf-8?B?bEREeldKVHVwNHhsVFl4aUs3N0RkSFVTYTFYcVBDdEpQLzJLODc1b0lYRFQw?=
 =?utf-8?B?ZTlQYkRHVWwwcUh5SThSNmVHU3dudUF1dzJzQ1E3eGFVZ256WW5GWC9qWkRW?=
 =?utf-8?B?dFUwWkdJRDllZUkyd2lmc0I1bkU1Z1B1OWt3eVcxNk1KOU0rTVhGa3JOYkRm?=
 =?utf-8?B?VzR0V1lML0NBWnVjTmswaW5taFQ2ZE1wOXVxQUdmTU5xUXlML0NpTXBQWUx0?=
 =?utf-8?B?aGFOQlhENjVkT1VoaUkyTjRkRS9nSXJtc0tMV3NLb2FrbnBtY0R6TDVRQzNH?=
 =?utf-8?B?amJoK3IwRTQ2cmJET3Y3QTFoK2UrcERWdmFGdWdKb29waFMwa1kvMkZSQk9p?=
 =?utf-8?B?R2F4L1N2Nm1haUM2Y2hxVlN0TThqK1pTY2pDcG5MVHp2Q3dNVGNMUUxYcXdF?=
 =?utf-8?B?eUY0SlpvMkJjenAxMklhVE9WRElyb3hKREhJZHJTWVoyL1o0dk9qNklwQUJO?=
 =?utf-8?B?VVpRN09LR0dad0QyNHJtN012MTd1VmkxdWR3UDlTV1lETldqNGJLemJnNUtp?=
 =?utf-8?B?NnNxWm9TVDFmQ1ZWdlVhMzZWNTlpOGR1SnMxUk8zelJuaWhYVjFIaFFhYk4z?=
 =?utf-8?B?ZytBNFhYNFhvY1hTbjNSL3pCWHp3OWVwV2IxQnc5TTBUNFRMYjgxcHdBaE5C?=
 =?utf-8?B?RGlnZ3k0cVZZd2pxU2Z1SWtJbFk1NmFyUlZDZG9vempRRmNvcVZrR3F5S2Za?=
 =?utf-8?B?YkpOL2pWb21GZG1TUDJHRHkwSUJyOThYSWdPblB6d21vYnFaWTBYRUVEUnMr?=
 =?utf-8?B?eGI1dzFhWmdwbDRqVitsT1YvSmt4L1o1T2RHazd6bTdFMTFMZGMzMHYyaW5C?=
 =?utf-8?B?bGRBWUo5ckJ1ck1IcTFYZkhXQ3Z1clk4Y2cwSlI5SXlrY2xCalFIMnJIdlZq?=
 =?utf-8?B?TmhQY29uVTVWYWVsaVVEeGRxa1FFOUY2d1djeXVhZ1VDSHQ2MXV1dlZEYnhY?=
 =?utf-8?B?SmE0VmlTc3YrSXg2VDFLamoxZkR5Zngwb29FdCt3bzdjNlhmZkoraThKNlFR?=
 =?utf-8?B?SzBiM2JBYTFFNkMvek9BaDhBNmkyQnBRU1Z2MzV6NWxyekJHczZ6MTZnWDRt?=
 =?utf-8?B?NTV1SnFBY1JraGNsNzBwUGRXLzZBK2o3bXYrc1RTdCt5YjBWQTdQb1F4SUpU?=
 =?utf-8?B?MlJNSitodHZxZHB0c1dVdEM1N0QrWFJsZkJzdW0wU1RXaytQbVBvR0lIQzdi?=
 =?utf-8?B?TzNRVTYxV2ZzM3djQWdZcUpQNWx0c1o4Yjd4S091bXpVbys0c3NqWnpFc2VF?=
 =?utf-8?B?Qmo2eHZCd3ZmSkNUUjY3cUpPSEQxYnpTQ0wyNEZraWlYNjlMbEVVUkc0TDNB?=
 =?utf-8?B?T251dzRFZlBDVWNlUlB1am1ZZEZkN2x5NDhuNE1WYUlQZFBsaW5MOUNOdFd3?=
 =?utf-8?B?ZnloZ3RVbCt6b1ZSM2djeTd5VVZOeEQ5Mmw3a1lXb2ptbTIzNFZlMjZySWx2?=
 =?utf-8?B?UjRYVTNpKzNNN1dnME1FditGZlpDWlRJcUJTRmhUamEvbUFvc3cwR2djMGwx?=
 =?utf-8?B?QkpwMnJ5YlRSRWZaVWdSbktWcVE3ZWxZUUJDMVNyMDZoTWlpRy8zKzQ2QjdF?=
 =?utf-8?B?d2hHRUZ6MW1vRTh6QkxLUUpyOUNISVg3a2RRQTh6bDF0RERUQVlyMGlaUExZ?=
 =?utf-8?B?a3lCbk5HVlFtZWFSc1JaS0dhT21kUFN6MWVQRm9wc3NGU2plMmFDZnJJQXRm?=
 =?utf-8?B?YldCVFgvWmFTWmtmYkhrSVIrMEZIVUdyTWZiZ0xtYkxSK3VkSmpaR1VFQ2dF?=
 =?utf-8?B?WTBjcTlWZ05uNnZPcXluR2o4bU1vbTRNc2FjNWdPNFNjVjNIQ2RvNzRzNVNi?=
 =?utf-8?B?VXJwR2tqa1VxMVlHSGJUT1pKOEdra3lmVDZaSUp5NkNFbUNsSnFPMGpudWc0?=
 =?utf-8?B?SEQ1RURyL0R2QmF3eTZsZjFwY0xlRjU3WjdweE9XcjZMQm1QeHBPYWtwZUVM?=
 =?utf-8?B?c3JOUnAwRWVrWEhwVG4rbkhRMTVFSFZSQ3BvUXdLYzFIaHMvL0N5RzVIVFh1?=
 =?utf-8?B?T3c1NUJudE1JYTF3Q1IyeFBaYUhRSWl2WXZnWjZQWHV2S0RReFdITGxWcUQ4?=
 =?utf-8?B?a2p3U2E4NlNsTU4zcVR4L09DazlicENLUjNRaE1UWTgvdG92a0huSnlkQTNj?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NjZXZzh3ODVYbllRaUFaQzZ4dlREdFB4WlpONHFZcmhKUVdDVkhsbUo3VVpE?=
 =?utf-8?B?ZGVhRkExSzJDcGxIeW9yMTJWM3l4ZXYxNUZVQjhiWnM0M2VBTTFJRDJmNDlI?=
 =?utf-8?B?M0MyazVpaXZLWDlEdjVoTURRQi9EUTdzZlIwbklIR0p5Z3cvTVM1dDdBMjIv?=
 =?utf-8?B?U056Y01WLzJzNVQyc284WmZmZGFXUWpmWk4xN2czYVI4OENQZHNXZUdIMjNt?=
 =?utf-8?B?bG1zTnVaUzE0c0hnbzhuMlkyUE5MTGVMdlVoT2JWMkJkNkRCZVN1ZlN5cGRX?=
 =?utf-8?B?bHoxajhOUHorSkxDSHlkOWJ3cUgzbHhMcTFYdE54OEk4ZUdHS3hSRU8wUWh1?=
 =?utf-8?B?ZTNsTjA4czUyTlZ6SnY5L0tPaG5aU0wyMWN2NFBYa3I2dm8vSDYvbDhFTEhy?=
 =?utf-8?B?ZTgveVd6dllSM1BjRE1EaFFLQXRhS0JYYkg4K2w3eDFSSHkzbmRiMEdhYnJT?=
 =?utf-8?B?NmZVTm9UZjFlVWVKOHJHNHFNZmw0dmVGYm9Dc0V4c050NnlVdFVyMHByRlRs?=
 =?utf-8?B?TjFHaE4zRUNUa0lCTTVLZHZuTVFXRnJvOE5oK09TQVFvbVJZcWRXSXp2SElC?=
 =?utf-8?B?d1VNVkIvaGpzYklORVN5bDJlRzhGK1U0c2ozdW5mNkZpUmQxVzAyemJQMVQ3?=
 =?utf-8?B?UUN6OHorZ3M0SThpb0J2OW9wd0tJZ043aE10cks0SEdiUllxQ2dSM1U2U2xa?=
 =?utf-8?B?cEk5VjcraUpVb1RJcGpnWVNyMGZzbjkwWFVBSGtZUGRHOXlRMkhCK2N1OEFu?=
 =?utf-8?B?MWJkcFZ0ek5aeVJxOStoQ2szZ1lvN2xPc3c4cjBDK3hXQnNyeE5VWGZNRS9R?=
 =?utf-8?B?N0xjNk0zaC9VaDVNZFVCVFo3N2RZSVNZVW1UWi9MdVRrdHYzSFhGckRrcnk2?=
 =?utf-8?B?dUJvSUpWYld5dXF3ME96ZjRTUkE2dCtKdnYzS0xHSHBkUnN3L3p1UlhTSytm?=
 =?utf-8?B?VWp6VGsvWXJERXFNWmJYVUd3VlgwdTRiYWYwMkdRam5ZV0xtQ2VUMi81WUpV?=
 =?utf-8?B?Vi9QSWVOcXFKQzJjL0lGenN4TnhTdE5Yc2QyY1NNdW4xMDk5aFAwYVJic255?=
 =?utf-8?B?RHFMQlVFbWg1Z1FzL1I1ejNJV3ZuL2hGOGJPSlNKci90Qk5zSDRDaVdieWNS?=
 =?utf-8?B?NUJVMlJhYm52UEdpUUVEZXRpSlJCOHlZQXpLYlc4WFlZekZhRnlQUG1OeUtD?=
 =?utf-8?B?WW9DbHdpOHlSRjMyUnJieStrcWdaREMwNGlMcDNaa29Cc3lHSE55T09NcUpP?=
 =?utf-8?B?RlNhNkpFaGFjWEsxZGg1WkNRcUp4VHBGSm1pSGRzbFJpMWZFZkIxYmUxeEhs?=
 =?utf-8?B?OTRUOEl5VG92TXpDQUlia2JGR0JGMGVYT2MwRHpveGFyeVFxak9xODI4V3Vx?=
 =?utf-8?B?aXVRenpVTGVpUmx4YjF2L3ZDTGo0ZTNaQWl3MCtyTkZZdFBWRENYWWgvSytN?=
 =?utf-8?B?VnVQV1BuaWZIcTV0RDhMcUlWNE5hMDJ1NDk1bUwzWFZYYzhpVmpjdW5kbFlj?=
 =?utf-8?B?ZDNkOTYwWkVqWWpuc045MzVhbThVdjRBVHlxdldiZVNGOVY3VzhRc2hSUGo4?=
 =?utf-8?B?VVI0NUYrQko0dHNHUzRMK1dWU1ZocG1kWjZOMmF6MTR2dkc0UVNjeUJlRWIr?=
 =?utf-8?Q?QVXvIJSj0ftRBwRiV24hqUQWdxh5uePEXjXAQx6ntgtY=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db322047-0000-48e7-895b-08dbb2e452f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 16:29:52.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htmxD1hD3Bxj2r95DCQdn/yjzyVKJ2tTwrAykneuAiOdLq4MhaprAG9fvQ/CR/NicUSvFE7gpzLBWObsQ2Qoj3KGdJdfQNG7ie/07LNEnoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6171
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 4:04 pm, Peter Zijlstra wrote:
> On Sun, Sep 10, 2023 at 11:32:32AM -0700, Linus Torvalds wrote:
>
>> I was hoping that we'd have some generic way to deal with this where
>> we could just say "this thing is reschedulable", and get rid of - or
>> at least not increasingly add to - the cond_resched() mess.
> Isn't that called PREEMPT=y ? That tracks precisely all the constraints
> required to know when/if we can preempt.
>
> The whole voluntary preempt model is basically the traditional
> co-operative preemption model and that fully relies on manual yields.
>
> The problem with the REP prefix (and Xen hypercalls) is that
> they're long running instructions and it becomes fundamentally
> impossible to put a cond_resched() in.

Any VMM - Xen isn't special here.

And if we're talking about instructions, then CPUID, GETSEC and
ENCL{S,U} and plenty of {RD,WR}MSRs in in a similar category, being
effectively blocking RPC operations to something else in the platform.

The Xen evtchn upcall logic in Linux does cond_resched() when possible. 
i.e. long-running hypercalls issued with interrupts enabled can
reschedule if an interrupt occurs, which is pretty close to how REP
works too.

~Andrew
