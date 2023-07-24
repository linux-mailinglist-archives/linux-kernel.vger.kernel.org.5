Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8413C75FD90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGXRZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGXRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13110FE;
        Mon, 24 Jul 2023 10:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03019611F8;
        Mon, 24 Jul 2023 17:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F4CC433C8;
        Mon, 24 Jul 2023 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219515;
        bh=Yyhpp58mS3l/tk4NHB2+v/T2fIrL/opM4y6CRYD8KGU=;
        h=From:To:Cc:Subject:Date:From;
        b=PAEgeutPc0z30KGmLZhokRw8gwFhoEc8i7YuJ1CXiyfJn7NtM+QhoCDm9128s8a58
         ZuE9+cweMoCLDqN6u/zuAv/HC16W+qQzRu2qcIz8oNITd4Ylpv9NGKH7Dvtj2NHdMc
         wsPjxs4sw22Ma2TaZ2cLhywtHSfam3Q6COi2rQ/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.41
Date:   Mon, 24 Jul 2023 19:25:05 +0200
Message-ID: <2023072431-resubmit-baffling-d793@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.41 kernel.

All AMD processor users of the 6.1 kernel series who have not updated
their microcode to the latest version, must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 
 arch/x86/include/asm/microcode.h     |    1 
 arch/x86/include/asm/microcode_amd.h |    2 
 arch/x86/include/asm/msr-index.h     |    1 
 arch/x86/kernel/cpu/amd.c            |  199 ++++++++++++++++++++++-------------
 arch/x86/kernel/cpu/common.c         |    2 
 6 files changed, 134 insertions(+), 73 deletions(-)

Borislav Petkov (AMD) (2):
      x86/cpu/amd: Move the errata checking functionality up
      x86/cpu/amd: Add a Zenbleed fix

Greg Kroah-Hartman (1):
      Linux 6.1.41

