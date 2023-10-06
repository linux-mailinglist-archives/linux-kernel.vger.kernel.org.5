Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52B97BBD8D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjJFRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:17:37 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB6AD;
        Fri,  6 Oct 2023 10:17:36 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57bf04841ccso447438eaf.0;
        Fri, 06 Oct 2023 10:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612655; x=1697217455;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MT227Cp+OqLxf0QGLJ4irDMFkrKWEpKFwHymioLYXDk=;
        b=TBzU+d/7w8TBxOxzXxqWFwF2+mBoSO1PJyDzkqL/CVYAIpOghYVKgTHJJ4EvJmwIgM
         Vw0Gqx6CpBQETulUtc0A5OEo75gyuHSRk8o670mnaUzritk7RkDUWILFK2Xbzytt8B4r
         lyeBgGIHEdSFVkXaZgYMR1VRT2hdgFR2OY3UAlVZR9d0nQpZcasfO5MCXNcl8+4AnvGS
         y86o65fz8/RR7I7AhSXDKbnJlu2ZHCNvbaWww0rzGZc3Us/HsYGzUbKLlBD9ZMbGk5ba
         Fw3RojEl4i39n7jPL/g+HpsA20W3umxRCpZZIWlNE9aDKmnWSM6TK+9kRSv45C00uP/E
         S9qg==
X-Gm-Message-State: AOJu0YwrvnmHxZC9ef9kEo9Mz6piNet2dWQoaUrXNCptQ6Y3BisbYoww
        4uR/Rp1iSEqAd+/CyHnAwKOrmul6BJy34w11V+wMGK8DD6o=
X-Google-Smtp-Source: AGHT+IEth3nbSYhG2llY/goLxwU+6yZqDGPHd3kADWD0MYvT9tId8eHcJb//AXhNczgrs6FJx8cB6KgQ7F1VCaDFGVc=
X-Received: by 2002:a4a:ee90:0:b0:57b:94b7:c6ba with SMTP id
 dk16-20020a4aee90000000b0057b94b7c6bamr8638422oob.0.1696612655720; Fri, 06
 Oct 2023 10:17:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 19:17:24 +0200
Message-ID: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.6-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.6-rc5

with top-most commit b21f18ef964b2c71aa0b451df6d17b7bcad8280d

 PM: hibernate: Fix copying the zero bitmap to safe pages

on top of commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa

 Linux 6.6-rc4

to receive a power management fix for 6.6-rc5.

This fixes a recently introduced hibernation crash (Pavankumar Kondeti).

Thanks!


---------------

Pavankumar Kondeti (1):
      PM: hibernate: Fix copying the zero bitmap to safe pages

---------------

 kernel/power/snapshot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
