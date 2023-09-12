Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2379D4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjILPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbjILPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B010DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE607C433C7;
        Tue, 12 Sep 2023 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532089;
        bh=MODnFuqOmN7qBnUWBEYPJdtRHcnRb8MFbXBkDapR5wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it/ChpLvf1ohjiGo2F7VpKjXT3UYU9WN3lYgHuq5FpwOGf2n6MA+hRw9fze1fKlRF
         8dNK7kIMYv8bvNqR49lmcelCNqOtVU8mkPjo1hCpNWNuIZuhx9b97kKv+U6mx8jtwS
         sseYhfQThkWqH3Yz2Dfh9KXFM/J+lcImVEN0OYdqN8jpJorRKeCAr+akDcA3q2Ew3i
         BMawoE9mxxHCP6v33AsWog4uQWzQ4LGIlQU3su3KxqrASwI83VHOzJBgZvVI8WW9Ij
         l5Iz7INZnMw7fwVmWezxQ6gsiuMVwwgU82VxTK5ng4ABNuIZyNIVX7Rg8uuZFonJl0
         cZBCm8Kw/Aulg==
Date:   Tue, 12 Sep 2023 17:21:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH net-next v1 1/2] net: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <20230912152125.GJ401982@kernel.org>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 06:45:33PM +0300, Andy Shevchenko wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

