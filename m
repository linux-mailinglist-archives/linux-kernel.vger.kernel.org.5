Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384E7999A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjIIQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjIIQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:19:28 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3210C19C;
        Sat,  9 Sep 2023 09:19:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6F5593200906;
        Sat,  9 Sep 2023 12:19:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 12:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1694276358; x=1694362758; bh=M6wmMumG4G
        BxFWlO6TZUur1MLDcccw0IA9bEJxeSNGM=; b=ZQovllt6MTMezPd0k27xXp7Zlt
        eD1Iv0eIRAoAv8bY5pZt1yPp2u0Oxn3SWbD6NVyU37HL8xyI3rZSc1ctFAtIzOop
        iB1XhXzuroyAkhcQfceaYBkNMrITKDt9kcR8PaPLU7nas2SZ1UtI6uudsYWjU01P
        odsqvNgkSVX53gjwQN9WmbI+OLwmOSHjYVXAMIPBgjLi+242+KkBb0zgvWPhn5k9
        WYF2aTe+DFMkaDY6wAvTPQ25pIoQQauOTvBXjX1GeQnLEIdplqh7WlsWjwPpBqen
        E1UWjetRfv38HvP2mv373pSEFQXY9fg9WcdYKatkqVHavVE+JfUrWB1F4aHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694276358; x=1694362758; bh=M6wmMumG4GBxF
        WlO6TZUur1MLDcccw0IA9bEJxeSNGM=; b=qs1+qeSdE4kiwwsozL1htaz808QAu
        xpEA9BRVT7YL9j20aBJpnDpOYOi9Pbor3bmBHAMUiybyBbSOSNTGS5vS64To7cVT
        K2Q0QfixfA2pozZUxSmjNEyLYDBckXiYZrTqcz821A3MiX4tw2ll5CkFm3J5h9xn
        5tkoVYJsJ1XAVbFDOUOhVFtt148gaviT1J2dQrUMLoS8kx/N0ncxnE67+p3UsDR5
        SURthJg4+a9dOOuUK4WBc4yP7Q3Tsbk3HG60I54NtYi4//JYZTVd1sp91/4lc2u0
        fZxEbvu4uoKIGm+xdnjibCI0zqmISaCFyvwiXrPwuSzIJ2QBzA8PRekOQ==
X-ME-Sender: <xms:Bpv8ZOQHmuRjYDUquUOmY8Nt7juhf9PRZvU-l5vJxr17k2dScXr2cQ>
    <xme:Bpv8ZDxQ0v5eqcJH_Vs7MbJPPVU2iV3F9DJQGYyLETTbsT3NMBHdfRxX_cPahKOVN
    ySXCezxcj0hh8y-GC4>
X-ME-Received: <xmr:Bpv8ZL1pUmpUIK_BvWLn50VTCP3NIbdnpkO_7xtjHJ_SL_ZpPfJD764N26td6THx-49lNe31sJ_ahgcK9VQUy_gYKN0X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhkucfh
    rghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeduge
    dvlefhtdelvefghfdugfetieeikeekjeeugeduhfdthffgfeefhfffhfdvveenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhurghpihdqghhrohhuphdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggt
X-ME-Proxy: <xmx:Bpv8ZKA_NvXZiIuNH8lfCnpGwrNVsRH3z09FX83hHZCK03YAdBQa5Q>
    <xmx:Bpv8ZHibBsluqj3N9tbAXe36m881wXAtZhWD3JENLkWLO6aO0CG3LA>
    <xmx:Bpv8ZGqeBGvdiwdPFzn-Br4gPAyCFgV7_j9EwRK5kh2RIJ_-g07OYg>
    <xmx:Bpv8ZAa7_TpCPyCx-lQW8Ge9baHpzDK9bIKjYMn31Qq6N4QljrQcsw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 12:19:16 -0400 (EDT)
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, bluca@debian.org,
        systemd-devel@lists.freedesktop.org, kernel@jfarr.cc
Subject: [PATCH 0/1] x86/kexec: UKI support
Date:   Sat,  9 Sep 2023 18:18:50 +0200
Message-Id: <20230909161851.223627-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch implements UKI support for kexec_file_load. It will require support
in the kexec-tools userspace utility. For testing purposes the following can be used:
https://github.com/Cydox/kexec-test/

There has been discussion on this topic in an issue on GitHub that is linked below
for reference.


Some links:
- Related discussion: https://github.com/systemd/systemd/issues/28538
- Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/

Jan Hendrik Farr (1):
  x86/kexec: UKI support

 arch/x86/include/asm/kexec-uki.h       |   7 ++
 arch/x86/include/asm/parse_pefile.h    |  32 +++++++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c     |   2 +
 arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
 crypto/asymmetric_keys/mscode_parser.c |   2 +-
 crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
 crypto/asymmetric_keys/verify_pefile.h |  16 ----
 9 files changed, 278 insertions(+), 116 deletions(-)
 create mode 100644 arch/x86/include/asm/kexec-uki.h
 create mode 100644 arch/x86/include/asm/parse_pefile.h
 create mode 100644 arch/x86/kernel/kexec-uki.c
 create mode 100644 arch/x86/kernel/parse_pefile.c

-- 
2.40.1

