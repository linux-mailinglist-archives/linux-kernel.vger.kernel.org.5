Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB7764248
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGZWxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGZWxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662422719;
        Wed, 26 Jul 2023 15:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA40961BAF;
        Wed, 26 Jul 2023 22:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0C6C433C7;
        Wed, 26 Jul 2023 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690412027;
        bh=Gc0MdxE9TJLVJnxGVdhAqK+Fa1GdL+sEgIBIAagN3WI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oEBJXlrReZWTXlTFcPvCxDjoBxAqHNi8Z04tDXBU62cESYZGcTVYn7pVunAmoPiVE
         kY8YsvtXo3hJNgxD5EDAZQW5D1EL3fdBPccEpMWpdohKA71/dPySkAEeEIAQ3rjxul
         vqrLzxe+kCSaA5Z/5r2Y01XBZkGWTLIenin/9+5sB/K+o5U3wrNhm8HWaETVQ2qRnY
         BTUHqs0HjJZS8NpXNMDCymr6Z1hY3UugpxeLt1FqxfKxu2lb0v6UeRgnrv4bf361Xf
         rSUUEY4f9zTTXpfUiqNL/DQQzBeKkJC3RzV65LBNXARVru0PAlIr/caAX4cJwQV4g2
         9SKNEy6XWwU6A==
Date:   Thu, 27 Jul 2023 07:53:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 5/9] tracing/probes: Support BTF field access from
 $retval
Message-Id: <20230727075342.43f600a1850810f6e1dd6c2e@kernel.org>
In-Reply-To: <169037644255.607919.6218637643155663128.stgit@devnote2>
References: <169037639315.607919.2613476171148037242.stgit@devnote2>
        <169037644255.607919.6218637643155663128.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 22:00:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:


>  
> -static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> -						   struct btf **btf_p, bool tracepoint)
> +static int query_btf_context(struct traceprobe_parse_context *ctx)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);

Oops, kernel test bot reported this is wrong. I have to remove ERR_PTR().

Thanks,

>  }

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
