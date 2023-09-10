Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C150F799ED6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjIJP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjIJP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:28:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED31CCA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:28:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1839FC433C7;
        Sun, 10 Sep 2023 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694359695;
        bh=+Wff+pK+Vbh4L0aEFSRYIsCk9XAL1qmKYXRwW4CMwXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zvo2Sc+23JNTgc9wOA7TcBm92+6QzHv6cc4nACCst+QXuXJQu/l/PAtY76bjAI3V3
         O8NieKDbltZRZ7myHslY5cqUkTzqbH8kPN3Ow09hUSQE0yjYkzXaYz/oL2jr3cMq27
         vOw6cKyA/sG0ycppAzIsU7Cjl3MQxOqv0cuSIih8ui3IvjV18WrHIJKjbqPnOcs0Lf
         Vmwjn72ssikqA0oOyUKNVGCPxaVVhHbvEryTR86xZQOnlK6q9STSJfLSi+CJ9GLHgE
         uRjYu6CyphRSj2c+s4dKkf/ZuU3i2aUXF/W9iieAQg607ZfD94Hel5cAmEDb3z7oS5
         BHimSj6B1knaw==
Date:   Sun, 10 Sep 2023 17:28:12 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <20230910152812.GJ775887@kernel.org>
References: <20230908235853.1319596-1-jeremy@jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908235853.1319596-1-jeremy@jcline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Hi Jeremy,

thanks for your patch.

I don't think you need to resubmit for this,
I think this patch warrants a fixes tag:

Fixes: d646960f7986 ("NFC: Initial LLCP support")

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

