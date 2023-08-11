Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306687792C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjHKPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjHKPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3530EA;
        Fri, 11 Aug 2023 08:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B84674B2;
        Fri, 11 Aug 2023 15:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B5C433C7;
        Fri, 11 Aug 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767103;
        bh=TY023/yqTmPJ04tQxu/4ubKH1wWymHQGuKxG/uToQkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJOfsHyAJr/vg4deRa14jmLc+PcZBNb1WPmSC8Rcz75l45LzyY4ERdjOfyvJcrC+s
         q4pH6NSneiGpaTgSUAR4/jmEd10JnxAMDE32UXAskG94fAxldWSgh5zzF9H1uBUfZz
         Wejo9uXemyfSMjXb1idNsB7BV3lvnviYHVAXB6Ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.126
Date:   Fri, 11 Aug 2023 17:18:11 +0200
Message-ID: <2023081111-endowment-ambush-7368@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081111-unlocking-synopsis-d7d5@gregkh>
References: <2023081111-unlocking-synopsis-d7d5@gregkh>
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

c275eaaaa34260e6c907bc5e7ee07c096bc45064
diff --git a/Makefile b/Makefile
index 6fb94face8d7..a90f955e14ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 124
+SUBLEVEL = 125
 EXTRAVERSION =
 NAME = Trick or Treat
 
