Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCC7BBDD5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjJFRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:32:55 -0400
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CABC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:32:53 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696613571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUMRqrzp9W95pILwy96rYNmF5hIvu0nKh4XVqWJvVSc=;
        b=NFVqlDcwNUWDo8jT9q7F9j+KLX1hUbmwWpDbz6g6QmFFw2uCJ9T/1s8Y+LDo5tNftPqdkB
        9WHn1P6XslM4qUBwY6IQgTK86eE6M0I0l9MXwmZT8y3VhoIwz9jzP6StUedJU02/QxdsrN
        xlctjU3lE2jpUGnG7b09S4MGHW4uTwk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Brian Foster <bfoster@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] bcachefs: Use struct_size()
Message-ID: <20231006173247.zn4l6mwhup4bjkrf@moria.home.lan>
References: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:13:54AM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks! Applied.
