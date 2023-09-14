Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4D7A0DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbjINTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbjINTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:00:44 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B6770CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7e68f4214so770588b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694716974; x=1695321774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=aV2KMBDNvU9cOBjNOdThSdUR+SVqEaYaJ0clxmkIM7M3VUj9sIMj4IOw3QU3YhncmL
         56yStPR7MO0vmEQNnp52TcxgruWCD+2WJYGtitOsY6HIUdzz9dqqC/SZFpQNvfMltBfE
         VmIwHxmNxX8JvrovDafsRCOMZNKRelZwi2cj2l56nljvlSpqJ7uZsCnyvPH/DMET2dXa
         VFfehfwJJ+yr8qtcLVRmnJF1+lA+i5JVirwRGeRA5GPKuNqI6CFVubTrc3jZiBZDc4SW
         g2y4DvJjmFTjcDBThbEUGoBs9FD5fpWaRn6nt41ubZgqjDR+mIYtMsKGAV6h7Q8g73Uy
         7zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716974; x=1695321774;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=TvZgNtYq+iOcfp0k0LwKwUlI6QBeXhh7DDnQMb51GovVBtfMmTav5b1dAaJdE3EQ+X
         gt+FfRS3LbxLoPxmm9poEioH6MU0g0+op17BFJnh1nEhptWfV80JO/MYFuUXbwIiOTJ1
         GzW4+AP6K8vDI8z7EcY5qSdIZmLNIK7r/Wm6QTYJpdzXZjj8587J9ZCJZryi2I7HHTJY
         QYXMR69JZMB56gLgZMzOlzrWk2K6efYsgzZ5dllJXDUOMoIBHkKc1RUWJiF18+wiu0rS
         pj0sD2TP9Og+EknbaRDSP0g2En4sIkgwBD4aTjZ80JpjQ8F88/eS9xYqlfQFT/YdKEWB
         LPHA==
X-Gm-Message-State: AOJu0YxoAhnRLPsE3F6FFSeOksq8CV4341wRTCsRNXQ4sTmr1+zDyJ49
        g2n9qFRS14VRTcDPczEl/MdDoy4J9Z7U24j+PGLM
X-Google-Smtp-Source: AGHT+IGPNy8EbKLj4XJ8pXuM3HonrcFslH5yiD8vr8y0o+cR6/0HT4xmd/jBQVZX5t3JRdCy/vsL1H3t0hcRku9emNs=
X-Received: by 2002:a05:6870:6393:b0:1c8:bae6:527d with SMTP id
 t19-20020a056870639300b001c8bae6527dmr7958709oap.55.1694716974516; Thu, 14
 Sep 2023 11:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 14:42:43 -0400
Message-ID: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.6 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A relatively small SELinux patch to fix an issue with a
vfs/LSM/SELinux patch that went upstream during the recent merge
window.  The short version is that the original patch changed how we
initialized mount options to resolve a NFS issue and we inadvertently
broke a use case due to the changed behavior; the fix in this pull
request restores this behavior for the cases that require it while
keeping the original NFS fix in place.  Please merge.

Thanks,
-Paul
--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

 Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230914

for you to fetch changes up to ccf1dab96be4caed7c5235b1cfdb606ac161b996:

 selinux: fix handling of empty opts in selinux_fs_context_submount()
   (2023-09-12 17:31:08 -0400)

----------------------------------------------------------------
selinux/stable-6.6 PR 20230914

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix handling of empty opts in selinux_fs_context_submount()

security/selinux/hooks.c | 10 ++++++++--
1 file changed, 8 insertions(+), 2 deletions(-)

-- 
paul-moore.com
