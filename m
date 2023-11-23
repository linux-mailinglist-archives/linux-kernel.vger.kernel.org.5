Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FE7F5552
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjKWA0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjKWA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:26:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F937100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700699192;
        bh=x4ZQqedJYLGPYSK+d7G5PNiQr9d+Gw8ba+LcRhYj45A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YPC8I2Y51EwzLJV2d79l8abHDqwqoEm3vGEo2qWzyoLyBcQ5JdMhbBqj4iXNalv+R
         7oUNbrvjHmDzljIQGxEKhzff4EXfvuO8dUquzjPYSqhzwxjuMSf11xmT6OxyvNZwya
         61tfvYtMPH4+L53N59qS8/NxVg5VqFGRhWO99nmTG2k5sHQnWwKubKrzS0whjuzfKO
         arebV4JFb2GWg8Zo3dymdohx/UqOAc82d7JPz1cpzXSNo1RZemk28J04xolONPAC2C
         CSq8nYUWK+Wv/zKrQ18bo6T5l0xisx96lkzML/VjoMp1Xi1PCKmI6x1PzuClkJhU80
         nqxpcRcm9zwtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbJnh0btLz4x5n;
        Thu, 23 Nov 2023 11:26:31 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] powerpc: Use ARRAY_SIZE for array length
In-Reply-To: <20231122090312.114679-1-jiapeng.chong@linux.alibaba.com>
References: <20231122090312.114679-1-jiapeng.chong@linux.alibaba.com>
Date:   Thu, 23 Nov 2023 11:26:31 +1100
Message-ID: <874jhds4aw.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>
> ./arch/powerpc/xmon/ppc-opc.c:957:67-68: WARNING: Use ARRAY_SIZE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7612
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This code is copied from binutils, we don't take cleanup patches to it.

See also the at least three times this has already been submitted :)

https://lore.kernel.org/all/4ed43222-17b0-8355-f836-adabb453e432@csgroup.eu/
https://lore.kernel.org/linuxppc-dev/20181004171036.GA1907@embeddedor.com/
https://lore.kernel.org/linuxppc-dev/874lfxjnzl.fsf@concordia.ellerman.id.au/

cheers
