Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B308078B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379344AbjLFTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLFTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:36:12 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0990;
        Wed,  6 Dec 2023 11:36:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so172675b3a.3;
        Wed, 06 Dec 2023 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701891377; x=1702496177; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=thhmb3P+KlGpZTFSXhxWQdhGMFU5F6uevLRA8AfPi7o=;
        b=Qs1p8E5hVaI6FYkIMmTGTi2AtEx6AdBQo6EnulWgd0wd/5i/0DXIXC1ynM8Efo3xU3
         qHAB0OgD79QQvdur5s1A3jNU9+vDkmCEz36xd/MOGOW41BbxFgC+gBk7QQ0IZIFBmYBq
         mlfySJ9LVaf8gBfqgVKjIBlJDwh6uuJUn6MJUZWTXVHlWYViDu3BnWBUB8yde1FVy+ux
         LtWEzN8lCw1l/N6gLdROq8UL9LNuQn4weipk6wLef/edxmoPozAJx9y24XKUfQHXMWod
         dEQyRWVA50nCf4W4iZ6HO3G5gUmCwiikdx8ayZDm5IFVYHUUH3zYmNtLstSlEf5QbuRB
         6dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891377; x=1702496177;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thhmb3P+KlGpZTFSXhxWQdhGMFU5F6uevLRA8AfPi7o=;
        b=tTJG68tPH70U+04hR+sWQNCi8EBiTkKyHQGiOwmoe+J0d5KzXbypDdjx5zWr5qRzqg
         xSd3FSRkZ2TCjCRF114GWUs6LqVy8NTnlznX5LWvntOhw6dKvo7ZJr2QF6N7HEFXACam
         5ou0oAC5HKC2WWDlUY6R4UD6CVYBRWVxEoI86jVzi3UyU6h3cdJmpuPVN/Pr5kLCMzt0
         qv+I+jNB+RUSfvERnNPI/LJmcs5BfX7lQ6FQto3vXvbm0IkZJur0P07uKb1npZt42WPG
         T/ces744DdFeVcM/+lH65uZzXhZ7DEO0GPnna/98yO9OZL843/hmCDgnrxFFSpLa94zb
         4Ciw==
X-Gm-Message-State: AOJu0YwUk0/EQdXzczc9IG5gRT4Pao0ahJ6YmzwfkIEQH63KWIDlNv8I
        D7FrrxutdRmIgUsHak6QI4/0GmgMD4M=
X-Google-Smtp-Source: AGHT+IFdqUMI5KdpwdwNOZoWwEtsEMxEnq+B94NQjLqjP5ShSd/UYXAzTqFU2rMK6W7sFh2JD61MUA==
X-Received: by 2002:a05:6a00:1256:b0:6ce:64c5:956e with SMTP id u22-20020a056a00125600b006ce64c5956emr1690371pfi.39.1701891377419;
        Wed, 06 Dec 2023 11:36:17 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00158b00b0068c10187dc3sm329353pfk.168.2023.12.06.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:36:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Dec 2023 09:36:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v6.7-rc4
Message-ID: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 037266a5f7239ead1530266f7d7af153d2a867fa:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2023-11-18 15:20:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7-rc4-fixes

for you to fetch changes up to cff5f49d433fcd0063c8be7dd08fa5bf190c6c37:

  cgroup_freezer: cgroup_freezing: Check if not frozen (2023-11-28 08:04:03 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.7-rc4

Just one patch.

f5d39b020809 ("freezer,sched: Rewrite core freezer logic") changed how
freezing state is recorded which cgroup_freezing() disagree with the actual
state of the task while thawing triggering a warning. Fix it by updating
cgroup_freezing().

----------------------------------------------------------------
Tim Van Patten (1):
      cgroup_freezer: cgroup_freezing: Check if not frozen

 kernel/cgroup/legacy_freezer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

