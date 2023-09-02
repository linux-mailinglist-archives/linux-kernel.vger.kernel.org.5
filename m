Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A927905E8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjIBHo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351799AbjIBHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4701717;
        Sat,  2 Sep 2023 00:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4259B61795;
        Sat,  2 Sep 2023 07:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C4C433C8;
        Sat,  2 Sep 2023 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640693;
        bh=DVkvAMvl+2Zdfwigk8cYS2Hcg9oVjNCoVYv2flPntS0=;
        h=From:To:Cc:Subject:Date:From;
        b=120qI1iaWfNB1TjOT0s8uTrFj7/O+eINmYVkKDtpIYIgQKd8BW3cmQQBOD164C1Eh
         J0T0/zOr63aQIGw0kvRsEtyT4zadvx593bLRkO9Lgk8DE9Av6zUSfZ6Ww70lbFRaPh
         oF62tYEsvc5OAZRpRfOONBMGIrLMaj5xAgoLRlHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.256
Date:   Sat,  2 Sep 2023 09:44:49 +0200
Message-ID: <2023090249-crimp-rash-0a5f@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.256 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/mips/alchemy/common/dbdma.c      |   27 ++++++++++++---------------
 arch/powerpc/platforms/powermac/smp.c |    8 ++++----
 3 files changed, 17 insertions(+), 20 deletions(-)

Greg Kroah-Hartman (2):
      Revert "MIPS: Alchemy: fix dbdma2"
      Linux 5.4.256

Ilie Halip (1):
      powerpc/pmac/smp: Avoid unused-variable warnings

YueHaibing (1):
      powerpc/pmac/smp: Drop unnecessary volatile qualifier

