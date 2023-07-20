Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCE75B5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGTRpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGTRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2881726;
        Thu, 20 Jul 2023 10:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A9261B86;
        Thu, 20 Jul 2023 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D634C433C7;
        Thu, 20 Jul 2023 17:45:04 +0000 (UTC)
Date:   Thu, 20 Jul 2023 13:45:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wuyonggang001@208suo.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: add missing spaces after ';'
Message-ID: <20230720134501.01f9f1de@gandalf.local.home>
In-Reply-To: <74685bd017411f96c8a846ebd5e3916a@208suo.com>
References: <20230719064321.19047-1-xujianghui@cdjrlc.com>
        <74685bd017411f96c8a846ebd5e3916a@208suo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 10:30:36 +0800
wuyonggang001@208suo.com wrote:

> Remove spaces to clear checkpatch errors.
> 
> ERROR: space required after that ';' (ctx:VxV)

PLEASE DO NOT RUN CHECKPATCH ON CURRENT CODE!!!!

As the name suggests, checkpatch is for patches and not for existing code.
It is used as a guideline tool to make clean patches. But checkpatch is
*NOT* the rule of the kernel. There's lots of issues that checkpatch
reports that can be ignored. That is decided when the patch is submitted,
and SHOULD NOT be revisited once it has been accepted. Not to mention this
particular error is silly.

NACK!!!

-- Steve

> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   include/trace/stages/stage4_event_fields.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/stages/stage4_event_fields.h 
> b/include/trace/stages/stage4_event_fields.h
> index b6f679ae21aa..9627e081a990 100644
> --- a/include/trace/stages/stage4_event_fields.h
> +++ b/include/trace/stages/stage4_event_fields.h
> @@ -2,7 +2,7 @@
> 
>   /* Stage 4 definitions for creating trace events */
> 
> -#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
> +#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b; })))
> 
>   #undef __field_ext
>   #define __field_ext(_type, _item, _filter_type) {            \

