Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422BF75B981
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGTV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B726AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449FE61C67
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE5AC433C8;
        Thu, 20 Jul 2023 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888397;
        bh=QXJ5DENNJsGYLk/GgQ5ri8+fy+kqaicG8P7w0hubSiA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ft30HvzqWR5WHXm7TaNvcVag948O3BCdkDks7hXb9ryz+DWqTQOpzAhsQwMfCa6cl
         qenZi3I9pQvFRfUzI5Q3PSojIiAc3I5b4JZraDqplW1QEbFjYEG/x4iayE7gTMKERT
         22qjefFWZdTq8aYIJh8Ii3hIwHjBUu6w7nVpOSI/2Lpt/YG07E/FgV3FtW8fUR0m03
         BWlFsG8g8f5CW+s8rTZ5rXoTem2q/L4TvcjogEkZQ9WuV7JDI7/IwD/K5AxbTE93+b
         bRirKtx72SbwI1zoBZRXYD1P5U0SFmUQDo+hLTN+tdwq5fvnlfet+6PwO0J4/TnpxI
         oOmYfEj2X0Ipw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Simon Horman <simon.horman@corigine.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
References: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
Subject: Re: [PATCH v2 0/5] Fix scan-build warnings
Message-Id: <168988839634.88307.10673257683695224856.b4-ty@kernel.org>
Date:   Thu, 20 Jul 2023 21:26:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 03 May 2023 16:49:24 +0900, Dominique Martinet wrote:
> I ran scan-build very crudly on our source files, and there was at least
> one real bug so we might as well run it once in a while, in which case
> we probably ought to also fix the less important things hence this
> series.
> In here the first patch is a real fix and the rest is low priority, the
> last one is arguably not an improvement and can be discussed (happy to
> just move the 0-initializations around to variable declaration which
> would also silence scan-build afaict)
> 
> [...]

Applied, thanks!

[1/5] 9p: fix ignored return value in v9fs_dir_release
      commit: eee4a119e96c2f58cfd1b6d4de42095abc5f8877
[2/5] 9p: virtio: fix unlikely null pointer deref in handle_rerror
      commit: 13ade4ac5c28e8a014fa85278f5a4270b215f906
[3/5] 9p: virtio: make sure 'offs' is initialized in zc_request
      commit: 4a73edab69d3a6623f03817fe950a2d9585f80e4
[4/5] 9p: virtio: skip incrementing unused variable
      commit: f41b402d2572e93bee85669ed05eb5e1f3725704
[5/5] 9p: remove dead stores (variable set again without being read)
      commit: cf7c33d332ab67603f159123b691c61270b14c33

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

