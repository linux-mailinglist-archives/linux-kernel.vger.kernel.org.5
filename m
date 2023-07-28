Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FB76792F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjG1X55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjG1X5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:57:55 -0400
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B41BE8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:57:53 -0700 (PDT)
Message-ID: <e79da177-361a-07fb-710a-967a19d5c7a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690588670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vmm9PWjiIr44mtk0aK3RfwDQJ7qs4MHr/qIjINwktmM=;
        b=dYK3bR4jfVJXnzSRaMfZqtnW4gFU6mfQxSiBrWTH7pkmIsrNZe3P7OS3MRTRmLB2PV/QqV
        9N2vHep1i4010Eypia8/71Gglslv0Pb7EADYRUDwiM4izode8w4ZvoKo877JOqYSLuQQp5
        bC4NKn6bn4uBus7aXZze2rnixJxZLd4=
Date:   Fri, 28 Jul 2023 16:57:43 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, Lin Ma <linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
        void@manifault.com, andrii@kernel.org, houtao1@huawei.com,
        inwardvessel@gmail.com, kuniyu@amazon.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 12:34 AM, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 10:33 +0800, Lin Ma wrote:
>> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
>> does not check the length of the nested attribute. This can lead to an
>> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
>> be viewed as a 4 byte integer.
>>
>> This patch adds an additional check when the nlattr is getting counted.
>> This makes sure the latter nla_get_u32 can access the attributes with
>> the correct length.
>>
>> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> I guess this should go via the ebpf tree, right? Setting the delegate
> accordingly.

Already applied to the bpf tree. Thanks.
pw-bot seems not doing auto-reply for the bpf tree.


