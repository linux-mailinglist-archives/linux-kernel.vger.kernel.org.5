Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB67A050E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbjINNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjINNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:10:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD501A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1694697016;
        bh=vjRNE9GBDDIh+LZqescnluax+52f9LuMl91e+i5f6EA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e3+ds+98KlCctd6iNeD0ROwpZP+z0JMQk5S1YLYywHP8AJsyk03KdfoWuojDE/cji
         6FwGLQvarAWrppIIGdQRhzLpYcqZjtOV8+PEfVVs6x7iTQvY3/Vo9KwFEVbJRUAr0j
         CXZWoByrw/Lr+t7vDaZiJ7rH2ycPnGqlvRcNkkDZTWcWoN05tNUBYPcB/Z5Sf7Nayc
         C2apWYsdWtL9C/y23VjJaDcqOPxCKvLcK6fen8+GBDZ5Zt+gZPD9FphvSlhWCJMtfL
         qUZPoKxnWZvgrfBbE9aEj7jgASlspmNHHwyFm4YZR1STWvAATHf6lii57i5crRApzC
         l7gtcy/D9Y36g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmd374S2Wz4x3H;
        Thu, 14 Sep 2023 23:10:11 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yuan Tan <tanyuan@tinylab.org>, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net,
        tanyuan@tinylab.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 1/3] powerpc/config: Cleanup pmac32_defconfig
In-Reply-To: <23b30e8e9e31e7a6af4aa7d317699e1538ad89c2.1694685860.git.tanyuan@tinylab.org>
References: <cover.1694685860.git.tanyuan@tinylab.org>
 <23b30e8e9e31e7a6af4aa7d317699e1538ad89c2.1694685860.git.tanyuan@tinylab.org>
Date:   Thu, 14 Sep 2023 23:10:08 +1000
Message-ID: <87y1h87vf3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuan Tan <tanyuan@tinylab.org> writes:
> Use 'make savedefconfig' to cleanup pmac32_defconfig, based on Linux
> 7.6-rc1

Thanks but I don't like doing these updates in a single commit like
this, it's easy to accidentally lose a symbol.

I prefer an explanation for what's changing for each symbol. See
1ce7fda142af ("powerpc/configs/64s: Drop IPV6 which is default y") and
the commits leading up to it, to see what I mean.

But I suspect you probably don't want to go to all that effort, which is
fine :)

So I won't take patch 1, but patch 2 and 3 look fine. No need to resend,
I'll deal with any merge fixup needed.

cheers
