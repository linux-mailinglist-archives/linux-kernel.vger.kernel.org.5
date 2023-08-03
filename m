Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DD76DD87
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHCBuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjHCBtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:49:12 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C5830D5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:49:07 -0700 (PDT)
X-ASG-Debug-ID: 1691027343-1eb14e747a09830001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id aqJqCZXaJSdejAKn (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 03 Aug 2023 09:49:03 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 3 Aug
 2023 09:49:03 +0800
Received: from [10.32.65.162] (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 3 Aug
 2023 09:49:01 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <771b24c2-1cc3-94b4-739c-56ff461b4f32@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date:   Thu, 3 Aug 2023 09:49:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] crypto: Zhaoxin: Hardware Engine Driver for
 SHA1/256/384/512
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] crypto: Zhaoxin: Hardware Engine Driver for
 SHA1/256/384/512
To:     Dave Hansen <dave.hansen@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <seanjc@google.com>, <kim.phillips@amd.com>,
        <peterz@infradead.org>, <pbonzini@redhat.com>,
        <pawan.kumar.gupta@linux.intel.com>, <babu.moger@amd.com>,
        <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
        <sandipan.das@amd.com>, <linux-crypto@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>, <GeorgeXue@zhaoxin.com>
References: <20230802110741.4077-1-TonyWWang-oc@zhaoxin.com>
 <bc950efd-b7f7-5fc9-b41d-ebddcf4a459e@intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <bc950efd-b7f7-5fc9-b41d-ebddcf4a459e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1691027343
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4190
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112238
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave,
Thanks for your review. will refactor this patch per your suggestions.

On 8/2/23 22:20, Dave Hansen wrote:
> This code looks pretty rough.
> 
>> +static int zhaoxin_sha1_update(struct shash_desc *desc,
>> +			const u8 *data,	unsigned int len)
>> +{
>> +	struct sha1_state *sctx = shash_desc_ctx(desc);
>> +	unsigned int partial, done;
>> +	const u8 *src;
>> +	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
>> +	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
>> +		((aligned(STACK_ALIGN)));
>> +	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
> 
> All of the different alignments here are pretty dazzling.
> 
>> +	partial = sctx->count & 0x3f;
> 
> "0x3f" is a random magic number.
> 
>> +	sctx->count += len;
>> +	done = 0;
>> +	src = data;
>> +	memcpy(dst, (u8 *)(sctx->state), SHA1_DIGEST_SIZE);
>> +
>> +	if ((partial + len) >= SHA1_BLOCK_SIZE) {
>> +
>> +		/* Append the bytes in state's buffer to a block to handle */
>> +		if (partial) {
>> +			done = -partial;
>> +			memcpy(sctx->buffer + partial, data,
>> +				done + SHA1_BLOCK_SIZE);
>> +			src = sctx->buffer;
>> +			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
>> +			: "+S"(src), "+D"(dst)
>> +			: "a"((long)-1), "c"(1UL));
> 
> Please look around the codebase for examples on how to do this.  We
> usually try to use real instructions when binutils supports them and
> also don't repeatedly open-code the ".byte ...".
> 
>> +			done += SHA1_BLOCK_SIZE;
>> +			src = data + done;
>> +		}
>> +
>> +		/* Process the left bytes from the input data */
>> +		if (len - done >= SHA1_BLOCK_SIZE) {
>> +			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
>> +			: "+S"(src), "+D"(dst)
>> +			: "a"((long)-1),
>> +			"c"((unsigned long)((len - done) / SHA1_BLOCK_SIZE)));
>> +			done += ((len - done) - (len - done) % SHA1_BLOCK_SIZE);
>> +			src = data + done;
>> +		}
>> +		partial = 0;
>> +	}
>> +	memcpy((u8 *)(sctx->state), dst, SHA1_DIGEST_SIZE);
> 
> What's the purpose of the cast?
> 
>> +	memcpy(sctx->buffer + partial, src, len - done);
>> +
>> +	return 0;
>> +}
>> +
>> +static int zhaoxin_sha1_final(struct shash_desc *desc, u8 *out)
>> +{
>> +	struct sha1_state *state = (struct sha1_state *)shash_desc_ctx(desc);
> 
> What's the purpose of *this* cast?
> 
>> +	unsigned int partial, padlen;
>> +	__be64 bits;
>> +	static const u8 padding[64] = { 0x80, };
>> +
>> +	bits = cpu_to_be64(state->count << 3);
>> +
>> +	/* Pad out to 56 mod 64 */
>> +	partial = state->count & 0x3f;
>> +	padlen = (partial < 56) ? (56 - partial) : ((64+56) - partial);
>> +	zhaoxin_sha1_update(desc, padding, padlen);
>> +
>> +	/* Append length field bytes */
>> +	zhaoxin_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
>> +
>> +	/* Swap to output */
>> +	zhaoxin_output_block((uint32_t *)(state->state), (uint32_t *)out, 5);
>> +
>> +	return 0;
>> +}
>> +
>> +static int zhaoxin_sha256_init(struct shash_desc *desc)
>> +{
>> +	struct sha256_state *sctx = shash_desc_ctx(desc);
>> +
>> +	*sctx = (struct sha256_state){
>> +		.state = { SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
>> +				SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7},
>> +	};
>> +
>> +	return 0;
>> +}
>> +
>> +static int zhaoxin_sha256_update(struct shash_desc *desc, const u8 *data,
>> +			  unsigned int len)
>> +{
>> +	struct sha256_state *sctx = shash_desc_ctx(desc);
>> +	unsigned int partial, done;
>> +	const u8 *src;
>> +	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
>> +	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
>> +		((aligned(STACK_ALIGN)));
>> +	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
>> +
>> +	partial = sctx->count & 0x3f;
>> +	sctx->count += len;
>> +	done = 0;
>> +	src = data;
>> +	memcpy(dst, (u8 *)(sctx->state), SHA256_DIGEST_SIZE);
> 
> That looks familiar.
> 
> This patch needs some serious cleanups and refactoring.  It seems to be
> missing even the basics like avoiding copy-and-pasting code.  The
> changelog is quite sparse.
> 
> Could you spend some more time on this and give it another go, please?
