Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8E8123AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjLNAE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:04:25 -0500
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 16:04:32 PST
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A44BA6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:04:31 -0800 (PST)
Message-ID: <85bb2e79-5b1a-41c1-972f-9f7f185fac88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702511929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcjJcudoVFhZoBnbTd2oy3gYlnzRnT2DdGzqM7xSf0Q=;
        b=E/udpmFeOtMDg7fVKQVuCXS4tlHdXPSD5Hx+UuArcG6HyHMlzSpbu9pnMZOsJTtOzMSlxV
        +TVVQRYb9SAeQ6QcGNU3STQsgRYcPFhNSrLp6sNFEqUfZLXXYHNg+awGYa/5kdyUaiO+QN
        IWm4nGSMwEIvoEFOWb6yRyaAdDAzahQ=
Date:   Wed, 13 Dec 2023 15:58:39 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/9] bpf: selftests: Add verifier tests for
 CO-RE bitfield writes
Content-Language: en-US
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     mykolal@fb.com, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, shuah@kernel.org, daniel@iogearbox.net,
        steffen.klassert@secunet.com, antony.antony@secunet.com,
        alexei.starovoitov@gmail.com, yonghong.song@linux.dev,
        eddyz87@gmail.com, eyal.birger@gmail.com,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 12:20 PM, Daniel Xu wrote:
> Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> non-trivial bit fiddling is going on, make sure various edge cases (such
> as adjacent bitfields and bitfields at the edge of structs) are
> exercised.

Hi DanielXu, I have pushed the libbpf changes (adding BPF_CORE_WRITE_BITFIELD) 
and verifier test in patch 3-5 which is useful by itself. e.g. Another patchset 
can start using it also: 
https://lore.kernel.org/bpf/8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev/

Thanks.
