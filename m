Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033B8123B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442686AbjLNALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:11:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31FDD;
        Wed, 13 Dec 2023 16:11:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5633E3200B69;
        Wed, 13 Dec 2023 19:11:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 19:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=fm3; t=1702512700;
         x=1702599100; bh=VAqYPxgc+/bKFX3mKOr2AnsJnWJikiX4oD9KxuWgxIo=; b=
        byuu6jSjOxjC+6XDHeFG1ZaEupTQmCuFgV0DOt7qy+j07zlLKyF0jnc528VrLrpt
        TCZtN6GFGeGgszzhnKckZ3JDLHvLEIrjjjr+1EdrFP4l04IszvRMAh1a6MLTSw4o
        znV8LMdLRX0PeFiW7NLKS0KU470oVDid33bJ+uhnM17IV5Mv1KoBZ/7HqmI/Dtrz
        lfvHgdabRyv5NRNYB+GklM15/p+w2qJVrbl2qyO6aAVypQFaH8t4pR56NwJM8RC6
        M5CAQ/gKgVNu9ifnNHZVdLAlHktykFF+y0RW54m7E/IIwzk3fnCznVPEB5+u79A8
        GlF91Vqv0q+dsqtqxkvKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702512700; x=
        1702599100; bh=VAqYPxgc+/bKFX3mKOr2AnsJnWJikiX4oD9KxuWgxIo=; b=U
        29m5jOibtqGsH6gPzE+6te4lbuhC1mza/WeIFvjyWNKrd8Up3yvCx1uhSXRmCnQA
        fjoWrTxIhETsvsi0foyo6gtWUqL/2uS2yrrLLdr4jdWfpu66IhmQalr3BcQR1X9J
        ZeNcWKKTa2dwe6hWR63Z5dcP1CdoWYIajnRHLPwCCWi7NdagUXoF3Iv9M403s+Ki
        9ACHT8VA++iGJZ0E9rJLOz1vyDzdFCiYfBO4wr1flFw8OuTnXfRW3i+3CGW2FYCu
        b2H2gK5r5xv2BMUGdIPdAbapRA1PCOLrcfF8V2QTdEA89LNh1T3SLLtYt1FXWNtV
        AMPPg437q9XnVB+8Q22DA==
X-ME-Sender: <xms:PEh6Zdymy-Krp3814Gq9xeI5GaDzdJYyjMHvDzOk8glGj7XFjyX4vw>
    <xme:PEh6ZdTPZWvJYiQmxZ4xhsqbvKf1Pgqg427T_1TA1bG-0V3Bn67_eccIZzotgg-0A
    GT7TauKpBtK>
X-ME-Received: <xmr:PEh6ZXVN4pkxW8_cS_wS2EOa7HvCzazLAzk1edLEQeOCCFz8NvkhnQNkgGciuw1-cDgihG-bQGobWBpsC6Ab2pUABfJdq-eOF78odOTKshREXCpD8NSnNCzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:PEh6ZfiEsfkJYjADCg01VSaPm2RGOXer0rZx0pOMVCPsS5MoQUZkEg>
    <xmx:PEh6ZfAx8K4RqeMO9shaZWPB19c-4vHbdLICQ_S7VKtaYcfvoOpUnA>
    <xmx:PEh6ZYJ_SfOmw-OLivmtAYsWXr-4JWzZF_sNxDk2kxrIZKWkGvufLw>
    <xmx:PEh6ZT19wwea3jB5gmKMmSdB1_n8bqs9y2HKDXqaAh0cNVGlVpIV-g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 19:11:36 -0500 (EST)
Message-ID: <6608665d-a255-7b1d-653f-1d13d2b3fa2e@themaw.net>
Date:   Thu, 14 Dec 2023 08:11:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] [v2] statmount: reduce runtime stack usage
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213090015.518044-1-arnd@kernel.org>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20231213090015.518044-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/12/23 17:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
> and copies it into the local variable on the stack of its caller. Because
> of the size of this structure, this ends up overflowing the limit for
> a single function's stack frame when prepare_kstatmount() gets inlined
> and both copies are on the same frame without the compiler being able
> to collapse them into one:
>
> fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
>   4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>
> Replace the assignment with an in-place memset() plus assignment that
> should always be more efficient for both stack usage and runtime cost.

Cunning plan, to use the work efficient instead of inefficient, ;(

But, TBH, the libc integration seems complex but I also feel there's

no choice and this looks fine too.


>
> Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/namespace.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d036196f949c..159f1df379fc 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4957,15 +4957,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>   	if (!access_ok(buf, bufsize))
>   		return -EFAULT;
>   
> -	*ks = (struct kstatmount){
> -		.mask		= kreq->param,
> -		.buf		= buf,
> -		.bufsize	= bufsize,
> -		.seq = {
> -			.size	= seq_size,
> -			.buf	= kvmalloc(seq_size, GFP_KERNEL_ACCOUNT),
> -		},
> -	};
> +	memset(ks, 0, sizeof(*ks));
> +	ks->mask = kreq->param;
> +	ks->buf = buf;
> +	ks->bufsize = bufsize;
> +	ks->seq.size = seq_size;
> +	ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
>   	if (!ks->seq.buf)
>   		return -ENOMEM;
>   	return 0;

This looks much better than what it replaces IMHO.


Reviewed-by: Ian Kent <raven@themaw.net>


Ian

