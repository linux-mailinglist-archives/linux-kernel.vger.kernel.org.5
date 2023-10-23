Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47E57D2BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjJWHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjJWHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F2D75
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:49:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA428C433C9;
        Mon, 23 Oct 2023 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698047363;
        bh=Vi7PbFlCzKdEOfiRwN4AmNq9g5sBCASEmCpy+kAcYoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGJNaUL2HtYILuUJB5b0GGEE5lTA+/plh4fOacyOlp922N8zhp1SUnBLVWRKHwj+g
         fIebWhJ3ErwZQrpoZvC9zZLCO4yLutm9kY14Z3gAwrWuPf+SPxHwsz8lreWVENXZbK
         Sb7dAr1mT9sJYD8XypQAGQV3IXsaF5cQZH2RUVRPIgxiXiVe+j5Q7buGJ+Wvfouutw
         RENl513AAtGh+x5ARh4Y1cJ5kdxFBdiUBB7jtW9IG7bFL0HcdBqXoJh4JXVQKikX/U
         XMCeK/bKH4bY9ttWYjeFeYqeunzbxrTvm4pzAUU8gKU8NaJDtvRWvtTzbGPiuylPaJ
         mqa+/D60Y9WPg==
Date:   Mon, 23 Oct 2023 08:49:18 +0100
From:   Simon Horman <horms@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] sock: Code cleanup on
 __sk_mem_raise_allocated()
Message-ID: <20231023074918.GT2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:00:24PM +0800, Abel Wu wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

