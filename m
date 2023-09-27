Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAE7B0C72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjI0TQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:16:11 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30858DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38RJFaMG2909858
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 27 Sep 2023 12:15:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38RJFaMG2909858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1695842137;
        bh=s18+eLVTjLsv4CJZXCk3CBfJS3Bs/nded3iVDh14DxU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PmAuyNSp0pHArexEAkemrY0qtq5HafRGvvtj+iKQZRZhVZ7Axsn7UEAMcWbzroh1j
         pqfD1JQ606SniXv0gpNS5MYkxjjGz8fCAaoD8RL+F3nY3TINcEzgD3ojW+mFU6wCGr
         /w+oNXr8qOw/guQaXW8goCEAs5kXETGXQ4crgRj0cJo9Rp0rbAVh09Bt9n1WMXPS9n
         qHGqh6DP1D66hlD7f+mww6flomyrpzcd5k5950vLjiv9W4roPQKzhK/K6Wv1CDoMkP
         PGKiNc+8SMoFT/W7uWRpck7S+BhZ6UFuGIVfRVFg3UsHna8w1UgVFloeWFhydFLGHv
         0Yc6gcXi1lL3w==
Date:   Wed, 27 Sep 2023 12:15:34 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@kernel.org>, xin@zytor.com
CC:     linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_x86/entry=3A_remove_unu?= =?US-ASCII?Q?sed_argument_=25rsi_passed_to_exc=5Fnmi=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZRPif+9R8pp1v+m1@gmail.com>
References: <20230926061319.1929127-1-xin@zytor.com> <ZRPif+9R8pp1v+m1@gmail.com>
Message-ID: <0EE710EE-C0A3-4D29-BEF3-5FF888A5AD01@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 27, 2023 1:06:23 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrot=
e:
>
>* xin@zytor=2Ecom <xin@zytor=2Ecom> wrote:
>
>> From: "Xin Li (Intel)" <xin@zytor=2Ecom>
>>=20
>> exc_nmi() only takes one argument of type struct pt_regs *, but
>> asm_exc_nmi() calls it with 2 arguments=2E The second one passed
>> in %rsi seems a leftover, so simply remove it=2E
>>=20
>> BTW, fix 2 slips in the comments=2E
>>=20
>> Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>> Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> ---
>>  arch/x86/entry/entry_64=2ES | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>
>I've split this into two patches, because the comment fixes
>are entirely unrelated to this patch=2E
>
>[ I've propagated the SOBs and Acked-by's to the two patches,
>  as I presume is fine by everyone involved? ]
>
>Thanks,
>
>	Ingo

Perfect, thanks!
