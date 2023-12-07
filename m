Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B6808152
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377662AbjLGHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:03:56 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB7128;
        Wed,  6 Dec 2023 23:04:01 -0800 (PST)
Message-ID: <8b173550-c077-4506-ba7d-51d1a51344b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701932639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=od2iBZ+DhosKBwmyqP6nyM1tm8diqGtlq9CWOlRdPRg=;
        b=q3BnKA7HBUpa+L67WxI0hukeTxFT74uBMq5lYa9bbsjMxjoCIGnZb6O/cT5bkDMTZ2GdIt
        DDIco1FPNu8W6uq+eBnQo9dqUqs0POdaQxrBo6q29WDeeNmXop9kytQFIvYGhsxKvhxZFb
        I+7vj2Mjd8nRmBOGbmcQoM6XAPsWZcU=
Date:   Wed, 6 Dec 2023 23:03:52 -0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v1] test_bpf: Rename second ALU64_SMOD_X
 to ALU64_SMOD_K
Content-Language: en-GB
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231207040851.19730-1-yangtiezhu@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207040851.19730-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/23 11:08 PM, Tiezhu Yang wrote:
> Currently, there are two test cases with same name
> "ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
> the second one should be ALU64_SMOD_K because its
> code is BPF_ALU64 | BPF_MOD | BPF_K.
>
> Before:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
>
> After:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_K: -7 % 2 = -1 jited:1 4 PASS
>
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


