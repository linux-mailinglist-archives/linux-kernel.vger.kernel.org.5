Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E97F6142
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjKWOSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjKWOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:18:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC51B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:18:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8821C433C8;
        Thu, 23 Nov 2023 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700749089;
        bh=JbjbiZXLJuBZFzaBnOTLB5z9aONmiLxEbV7xY8VRxic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TfMhNavTWbml41++WkP6J1qn+BmmAT7C/MXCETSIfUhPi9U+Cz3K7VqAwPbGQmVjl
         T+er3T9uohI1BXCkW6Diu1E4XVshJFJF2WhTjbqsk9yrQRLSWASmNWDNV7cojZWTwu
         SgpCa1dvj2uyzZr1CKEm3PlRAlpFnBJv1YvyTlD9C0Fzd66j0Igi1aUUOgrZs+PZgT
         uE1akfScty6czxcbMbNAIeHmcjDQcARuXqL531zMavLJEQ/lNKLxqYkP8KZaOY/XVV
         7a6UOb69F89aB4P7xDmZVPglBtbKaQFJPiCgle0HE4DnaLFCcWNDA75QymPSShmfwe
         /0oDYnsLN6Q7Q==
Date:   Thu, 23 Nov 2023 23:18:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded
 config
Message-Id: <20231123231805.b4cb1b96426c956bd35bf53d@kernel.org>
In-Reply-To: <ZV8jkGVup4KvKiYb@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-3-oss@malat.biz>
        <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
        <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
        <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
        <ZV8jkGVup4KvKiYb@ntb.petris.klfree.czf>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 11:04:00 +0100
Petr Malat <oss@malat.biz> wrote:

> Hi!
> 
> On Thu, Nov 23, 2023 at 11:22:07AM +0900, Masami Hiramatsu wrote:
> > BTW, we also need to make a block-list for some early params. some of those
> > MUST be passed from the bootloader. E.g. initrd address and size will be
> > passed from the bootloader via commandline. Thus such params in the embedded
> > bootconfig should be filtered at the build time.
> 
> It's ok to configure these in the embedded bootconfig - in a case they are
> provided by the bootloader, the bootconfig value is overridden, if not, the
> value from bootconfig is used, so it works as expected.

I meant some params only bootloader knows, like where the initrd is loaded.
Anyway, if user sets such value, it will break the kernel boot as expected :P.

Thank you,

>   Petr


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
