Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240907A9955
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjIUSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjIUSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3C46E93;
        Thu, 21 Sep 2023 10:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CA9C4167D;
        Thu, 21 Sep 2023 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695282772;
        bh=7sbg7ty3X00SeIzirmC43Imk8uNIqkBNFRxgqrACu3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Il9GsuRY8gE+EGjhdsilzVhgmN8IQmH6MJlwQ9JrrWV6o2z/ax1auJXOnCTwB4k2k
         LdfK3cPFjNPwiwAqbB093decXl+gV/JEN2Lj08NzxMfc6HCCDFwFioEoKLvnrEH1Tu
         6x4UvymlsHy9XeDEx4DThd4kkdaYI0unEvzOMQ+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.196
Date:   Thu, 21 Sep 2023 09:52:46 +0200
Message-ID: <2023092153-fragile-bleak-cca1@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.196 kernel.

This release is only needed by any 5.10.y user that uses configfs, it
resolves a regression in 5.10.195 in that subsystem.  Note that many
kernel subsystems use configfs for configuration so to be safe, you
probably want to upgrade if you are not sure.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile          |    2 +-
 fs/configfs/dir.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

Greg Kroah-Hartman (2):
      Revert "configfs: fix a race in configfs_lookup()"
      Linux 5.10.196

