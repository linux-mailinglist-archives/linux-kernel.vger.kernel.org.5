Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06127A9996
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIUSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjIUSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36270A5D6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:59:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvl1R3Dz4xPd;
        Thu, 21 Sep 2023 19:33:23 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     christophe.leroy@csgroup.eu, Yuan Tan <tanyuan@tinylab.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net
In-Reply-To: <cover.1694685860.git.tanyuan@tinylab.org>
References: <cover.1694685860.git.tanyuan@tinylab.org>
Subject: Re: (subset) [PATCH v3 0/3] Kconfig: Add dependencies of POWER_RESET for pmac32
Message-Id: <169528860031.876432.1342566431743164769.b4-ty@ellerman.id.au>
Date:   Thu, 21 Sep 2023 19:30:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 18:09:55 +0800, Yuan Tan wrote:
> These patches are to add dependencies of POWER_RESET for pmac32.
> 
> As I have to use "savedefconfig" on the latest branch of different
> architectures, I am sending separate patches for each architecture in v3.
> 
> To simplify the enablement of the poweroff support, selecting the
> required options for CONFIG_POWER_RESET=y may make many people happy
> especially when they are using a customized config (maybe tinyconfig
> based) for a target qemu board. Without normal poweroff support from the
> kernel side, qemu will simply hang[1] there after a 'poweroff' command,
> which is a very bad experience for the automatical tests.
> 
> [...]

Patches 2 and 3 applied to powerpc/next.

[2/3] Kconfig: Add dependencies of POWER_RESET for pmac32
      https://git.kernel.org/powerpc/c/a3ef2fef198c25c1d9ac6ff89fd50230e9507207
[3/3] powerpc/config: Simplify pmac32_defconfig
      https://git.kernel.org/powerpc/c/f84b727d132c39c70208503e60149af6dd5a217f

cheers
