Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69120804B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjLEH0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:26:18 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC1C9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:26:22 -0800 (PST)
X-ASG-Debug-ID: 1701761167-1eb14e538b29f60002-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id eaXEc7WsWmXBPLdu (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 05 Dec 2023 15:26:18 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 15:26:07 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 15:26:03 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <96fe2155-5ba2-4b6b-9cf7-433a8d1d9e38@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Tue, 5 Dec 2023 15:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-ASG-Orig-Subj: Re: [PATCH v3] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
CC:     <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <seanjc@google.com>, <kim.phillips@amd.com>,
        <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <Leoliu@zhaoxin.com>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
 <20231122064355.638946-1-LeoLiu-oc@zhaoxin.com>
 <ZWmnAPlJrkaNE4QF@gondor.apana.org.au>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <ZWmnAPlJrkaNE4QF@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1701761168
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2329
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117671
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



在 2023/12/1 17:27, Herbert Xu 写道:
> On Wed, Nov 22, 2023 at 02:43:55PM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> Add support for SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI
>> Instruction. The purpose of this driver is to ensure that the application
>> has both high performance and high security.
>>
>> ---
>>
>> v1 -> v2:
>> 1. The assembly code is modified to be embedded in the .c file.
>> 2. Optimize code style and details.
>>
>> v2 -> v3:
>> 1. Increase compatibility with i386 architecture.
>> 2. Optimize variable and return value types in some functions..
>>
>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   arch/x86/crypto/Kconfig                |  11 ++
>>   arch/x86/crypto/Makefile               |   2 +
>>   arch/x86/crypto/sm2-zhaoxin-gmi_glue.c | 158 +++++++++++++++++++++++++
>>   arch/x86/include/asm/cpufeatures.h     |   2 +
>>   4 files changed, 173 insertions(+)
>>   create mode 100644 arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
>>
>> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
>> index 9bbfd01cfa2f..974d4c3806ff 100644
>> --- a/arch/x86/crypto/Kconfig
>> +++ b/arch/x86/crypto/Kconfig
>> @@ -519,4 +519,15 @@ config CRYPTO_CRCT10DIF_PCLMUL
>>   	  Architecture: x86_64 using:
>>   	  - PCLMULQDQ (carry-less multiplication)
>>   
>> +config CRYPTO_SM2_ZHAOXIN_GMI
>> +	tristate "SM2 Cipher algorithm (Zhaoxin GMI Instruction)"
>> +	depends on X86 && (CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN)
>> +	select CRYPTO_AKCIPHER
>> +	select CRYPTO_MANAGER
> 
> Why does this depend on CRYPTO_MANAGER?
> 
Yes, this is redundant and will be removed in the next version.

>> +static int zhaoxin_sm2_verify(struct akcipher_request *req)
>> +{
>> +	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
>> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
>> +	unsigned char *buffer;
>> +	int ret, buf_len;
>> +
>> +	buf_len = req->src_len + req->dst_len;
> 
> What if this overflows? I know you copied this from the generic sm2
> code, but that's still broken and both should be fixed up.
> 
> Thanks,
Yes, you are right. Thank you for your advice. The variable types will 
be adjusted according to the actual needs of the code in the next version.

Sincerely,
LeoLiu-oc
