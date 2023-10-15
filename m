Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B897C989C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJOKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjJOKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:06:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34D102;
        Sun, 15 Oct 2023 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364383;
        bh=lQ471ge3JT3D/IyXiBK6OqZg4gy00/Wz1cpF1NMX1CI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jgv8/cUxgQM27y6U//UT8VctmRJrqlUlqIr1QQTvvhugWnDzvcBYSj+SLZifK2jTQ
         owmdqqRmmp8iY6chJq2Mlnpjbq6RAj8jt0kTavOSSUm2KQgIWHKXgDY5hnkI1rXRb9
         NIdVXDDuIe1rtwQ5evX8B8s9Peo+r//MyCvLnEJu3WQv7amCnhXoAL+d5jvpc0YjYY
         35406tFs9oyMdUOOMphj3mCWt3yUm5zVp0ckK6CxgcejWbG+0vkHDPW3MGFNsWQ5DX
         tEUDQT8EKLC+kMhx0X8thKh1EhRV8sMxpXYvKiRh1qX2qbrIMTQ4XvICpOiJdoeKvz
         ZQx5NpTCbYS3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVc4t2xz4wnw;
        Sun, 15 Oct 2023 21:06:16 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     reiserfs-devel@vger.kernel.org, Peter Lafreniere <peter@n8pjl.ca>
Cc:     jack@suse.cz, linux-kernel@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, linux-alpha@vger.kernel.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Subject: Re: (subset) [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-Id: <169736429854.960528.1442206910501555108.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 17:56:09 +0000, Peter Lafreniere wrote:
> ReiserFS has been considered deprecated for 19 months since commit
> eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> several architectures that still build it into their defconfig kernels.
> 
> As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> from defconfig files before the filesystem's removal.
> 
> [...]

Applied to powerpc/next.

[2/7] arch: powerpc: remove ReiserFS from defconfig
      https://git.kernel.org/powerpc/c/c945e6f453a361b0e9daddd2be9c099d1b80d6f8

cheers
