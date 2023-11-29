Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB077FD052
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjK2IEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjK2IEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:04:35 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E21BE3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:04:38 -0800 (PST)
X-ASG-Debug-ID: 1701245075-1eb14e538b241f0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id pbUlX32vwyUxf8ir (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 29 Nov 2023 16:04:35 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 Nov
 2023 16:04:35 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 Nov
 2023 16:04:33 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <f9a1d0d9-12ae-45ff-a030-93615df21ec5@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Wed, 29 Nov 2023 16:04:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
X-ASG-Orig-Subj: Re: [PATCH v3] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
To:     Dave Hansen <dave.hansen@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <seanjc@google.com>, <kim.phillips@amd.com>,
        <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <Leoliu@zhaoxin.com>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
 <20231122064355.638946-1-LeoLiu-oc@zhaoxin.com>
 <aa7bbecc-dcd5-4757-8f8a-1eb2ab0d529b@intel.com>
 <8c2cca04-140a-4b0c-b478-5bdc437b5413@zhaoxin.com>
In-Reply-To: <8c2cca04-140a-4b0c-b478-5bdc437b5413@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1701245075
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1034
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117411
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/29 15:24, LeoLiu-oc 写道:
> 
> 
> 在 2023/11/22 22:26, Dave Hansen 写道:
>>> +/* Zhaoxin sm2 verify function */
>>> +static inline size_t zhaoxin_gmi_sm2_verify(unsigned char *key, 
>>> unsigned char *hash,
>>> +                unsigned char *sig, unsigned char *scratch)
>>> +{
>>> +    size_t result;
>>> +
>>> +    asm volatile(
>>> +        ".byte 0xf2, 0x0f, 0xa6, 0xc0"
>>> +        :"=c"(result)
>>> +        :"a"(hash), "b"(key), "d"(SM2_CWORD_VERIFY), "S"(scratch), 
>>> "D"(sig)
>>> +        :"memory");
>>> +
>>> +    return result;
>>> +}
>>
>> What version of binutils supports this new instruction?
>>
> 
> The instruction has not yet been submitted to binutils. It will only be 
> used in the Zhaoxin sm2 driver, and we are evaluating the necessity of 
> submitting it to binutils.
> 
> Yours sincerely,
> Leoliu-oc

Sorry, Correct a clerical error. "Zhaoxin-rng" --> "Zhaoxin sm2".

Yours sincerely,
Leoliu-oc
