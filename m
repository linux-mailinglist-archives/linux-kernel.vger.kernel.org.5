Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DAB7FA2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjK0O33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjK0O3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:29:05 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706CA191;
        Mon, 27 Nov 2023 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=vYJiZnZcNUBYGYtSR2ZD0f7WcY21+xweimfWC3eYkvM=; b=DM3W8Idf5ng0oAfNazlB2osNZr
        GwbiDbEze9kGbszuzYAlmV9YOGueadSfStJQb8bc65hAWpQN/2NqRyJxFqajygiYDW2v/vnzlYZYK
        k2v/khuoNbSk8YqXPVf7/K/kHCXdlmM9Bumi3xNqcGL9lfk4BUu0eAKKPDBlqnmdXEQ5Z5FZMp8It
        32e3vHPJy7e5/QDwpVt1c45tjv6z709Kev1/42r59QrfIwQs+X6bQy+mDolr24M7Rqvi3EvExww8S
        l0PYKGYbr5H/sNTbcC1oi77ThruJGAkj+o/9DeXOpatG2gcKNWbLgAE7niZ5WFgNQVdPJlNrVi459
        Ae6MFZjQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1r7cTR-000CGz-E6; Mon, 27 Nov 2023 15:20:33 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1r7cTQ-000I1q-SK; Mon, 27 Nov 2023 15:20:32 +0100
Subject: Re: [PATCH] bpf: declare bpf_sk_storage_get_cg_sock_proto
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sdf@google.com
References: <20231122081317.145355-1-ben.dooks@codethink.co.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c9628533-52c8-b497-23ec-e373768a6243@iogearbox.net>
Date:   Mon, 27 Nov 2023 15:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20231122081317.145355-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27106/Mon Nov 27 09:39:12 2023)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 9:13 AM, Ben Dooks wrote:
> The bpf_sk_storage_get_cg_sock_proto struct is exported from
> net/core/bpf_sk_storage.c but is not decalred in any header

nit: typo

> file. Fix the following sparse warning by adding it to the
> include/net/bpf_sk_storage.h header:
> 
> net/core/bpf_sk_storage.c:334:29: warning: symbol 'bpf_sk_storage_get_cg_sock_proto' was not declared. Should it be static

Please add Fixes tag and Cc author (sdf@google.com) as well as bpf@vger.kernel.org:

Fixes: f7c6cb1d9728 ("bpf: Expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK")

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   include/net/bpf_sk_storage.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
> index 2926f1f00d65..043155810822 100644
> --- a/include/net/bpf_sk_storage.h
> +++ b/include/net/bpf_sk_storage.h
> @@ -22,6 +22,7 @@ extern const struct bpf_func_proto bpf_sk_storage_get_proto;
>   extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
>   extern const struct bpf_func_proto bpf_sk_storage_get_tracing_proto;
>   extern const struct bpf_func_proto bpf_sk_storage_delete_tracing_proto;
> +extern const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto;
>   
>   struct bpf_local_storage_elem;
>   struct bpf_sk_storage_diag;
> 

