Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6377761DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHIN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjHIN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338951BFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE2C36250A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EAAC43397;
        Wed,  9 Aug 2023 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691589481;
        bh=Hs20ll4Rq+TbfoHU+d44Grw6y9bXu0zimVI84g6KWxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCMhnsmNn1lpJ8lSYMjnxDuS5l4bC3+l4ek475rXJQwPN8hVAC+oOOSD6v/TUasz8
         hhBvwWUbwpiSMV2BBic+4b0WK1zCq/Lh+sqNwLG8c9xKETiTDdpZoyuDeQNsMc5j5Y
         4FXCCDL/x9Q2wsUmbVWN5HyEfCpXkk/XMe49Xvie3PSXk7d+0qYwhI1QjtjU6DCG4u
         dKZOpGolgLLMAf0nPc8eFjkka6qkIFXTotAaNXIvgS3+SCcRagLNaXDGCGvd2YI2iv
         TBI8peWplTB3/BNNOwA8Ut7gVITeA3IHs4ITC0p14UrzNHiX5/k7MyE2x4CJtkeoJy
         /8pF/pfFAXdNg==
Date:   Wed, 9 Aug 2023 09:57:57 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 09/17] x86: Remove CONFIG_CPU_SRSO
Message-ID: <20230809135757.wqhlvlgzbr7ehevm@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.058602783@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072201.058602783@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:27AM +0200, Peter Zijlstra wrote:
> -#endif
>  
>  /* Needs a definition for the __x86_return_thunk alternative below. */
>  SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
> -#ifdef CONFIG_CPU_SRSO

The comment is no longer needed.

-- 
Josh
