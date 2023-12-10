Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8080B839
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 01:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjLJA31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 19:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 19:29:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B4126
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 16:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702168166;
        bh=JSsA0xeMBTfbUG5iyWB2yjJpJSqD6ERcemGdGQRU9xs=;
        h=From:To:Cc:Subject:Date:From;
        b=SI5E4XnriUeSgKGPopMp2U47vFshZT1/PlPsCoBQ5IhZZTiVugPenPVu98w7+vAZb
         EuSw2cRjA0mLTBDIr7hRoDl1+ltIDsWC52iN3e/8b7qjvtXKrVJd9KZfnu7Hm8T4NK
         pazCl9i10yG18eLat1tgUvwWF4kWxcLdoYpmoTUwSa5EWaZCj4x0Jbzm7SBA0P8AX3
         Is++hmbtc4polTkbS0Iq1X0awtk2ZNcet4y1PkjoVeiyKy1u3GHPIyFhhwzl02xz3K
         IyrCIXbqvGX/Gch+shgQOv7HZzrkr8LEUf41ANfDrVJCklZuI92x84iONsLEG4ZMso
         xADK7W/KzDnZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Snm3B1YQxz4xCg;
        Sun, 10 Dec 2023 11:29:26 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-4 tag
Date:   Sun, 10 Dec 2023 11:29:22 +1100
Message-ID: <87sf4aew7x.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.7:

The following changes since commit dc158d23b33df9033bcc8e7117e8591dd2f9d125:

  KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers (2023-11-29 22:24:21 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-4

for you to fetch changes up to 4b3338aaa74d7d4ec5b6734dc298f0db94ec83d2:

  powerpc/ftrace: Fix stack teardown in ftrace_no_trace (2023-12-05 14:14:12 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.7 #4

 - Fix stack teardown in ftrace_no_trace, seen as crashes doing CPU hotplug
   while ftrace is active.

Thanks to: Naveen N Rao

- ------------------------------------------------------------------
Naveen N Rao (1):
      powerpc/ftrace: Fix stack teardown in ftrace_no_trace


 arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmV1BNYACgkQUevqPMjh
pYAI2RAAhz0DW42CARKjsiQ/iyDVphkYwuXMMlX6DCSFPBPFZMPkI+wPzwbQDASg
ZW9p3NfxGa68szbKKSqK7RSYjHUAVlff8S4QyqNlnJzEwmErz6dhKa27vgGmE+k/
bgMTJO5qKFIt2WQ/xdvHlFUCzVxa7exxhLvR1fGkYnpENSgZrroq7pI0SuM92pnK
UDpoUeadXNKtwrP4yowdYTrGd0ciMdV2lQDXjG25Z9neW3eX4cT/D6FZLckS61wt
8eVmOlhoElmgLNnz7tsUCrfM02z3/nsU/dRx/jGYMIzlSIc7CNDSC6vVlIjGqoHu
4a/jhTL7OHQcamGo38GsmWenetqvJe+IJj6y5wcykA8z9Y231sUAdbAKbzw73t2k
Gb6wys82twpf8YbakGdzR0rM3aT5oE52ZRsMcoXDWFK7Q12H/euh/h32TmLISknK
tbsIROx/fLB8j8b+6R7Y1+7Kh5bvhckyoJqqjkGzUZMSI8QufEGOwfAnHJhD058x
HYSFJmqioCtwOk5gTe0HRQzTsHU8xQfN+HiLlOO4e7NhJAP3LBGVcx9e4Gbr9j/1
emq4hjB7cO1kBJdjpM0sQt2M2dgAuNzcUimkLqewy/swcR9KQV2NyjnU+teAJK0+
FEqMVVnGd24PdMTjr9fAzC6p0995vxFgWYzXJlwDVPY22AyAjfE=
=VOa0
-----END PGP SIGNATURE-----
