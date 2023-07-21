Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332775CC63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGUPsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGUPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:48:30 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62819A1;
        Fri, 21 Jul 2023 08:48:28 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98273ae42d0so63574466b.0;
        Fri, 21 Jul 2023 08:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954506; x=1690559306;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0kxHfC9oKai+yaQgmiybG2L0t2QG/Q/2VX2yD3Bj2c=;
        b=M3nicqWd9mY2rcptlmyjOT59s7u//6tLRlfYwOpvhAlgS0xyQk4WH17T3rk3WDG+Y8
         3If3ftGiEt30cZXqGsPbKijUFjrnQwREbuLikVxg9XHNA7kpMR8HbFKnotgn1mZAafsS
         dMtoQoIzE1QlLZYmOCrvhoaaXFKub+gNaC6O7VHtpbT9KmmySQ5AdVKjlsbpfa5ErQUX
         WIbVSuqYPO/tMqkSYoFdNsPxrhgZdjXcqAHaQVVr1jphF3tLJlp02GkluAY8acRraRQJ
         J43k7Qa/czMLE8WZd57Mf7wnuA+Bx5iAArGzEFBn7tLuLzmss5EqAv+zo6UR7Iz9I7EY
         ycXw==
X-Gm-Message-State: ABy/qLZoQNKDzmSa24BMfDvOwmJ1PRK/hblTL6AKPOIYtlmG8IrF4ii6
        vP3HnAEeaQTJlp0gTguacIhdefFJaxpraz7wtw2pSxNN/60=
X-Google-Smtp-Source: APBJJlFEi5JCOWtXl4MOcpLtgKbiy92+6u39Q88SB6CWTn7wJr3V1QnqWNk9SOA0jvJ4X7PY76k8C3MXexSLM+JmoTw=
X-Received: by 2002:a17:906:106:b0:99b:22dd:f83f with SMTP id
 6-20020a170906010600b0099b22ddf83fmr1978112eje.2.1689954506352; Fri, 21 Jul
 2023 08:48:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jul 2023 17:48:15 +0200
Message-ID: <CAJZ5v0jX-UshVsdTMQVDxmdTKXTeiCNVqocWTCWnyS_nV3pEWQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.5-rc3

with top-most commit 5534f44627418897cd901d725303ce3dedd7bc1e

 Revert "intel_idle: Add support for using intel_idle in a VM guest
using just hlt"

on top of commit fdf0eaf11452d72945af31804e2a1048ee1b574c

 Linux 6.5-rc2

to receive power management fixes for 6.5-rc3

These revert three recent intel_idle commits that introduced
a functional issue, included a coding mistake and have been
questioned at the design level.

Thanks!


---------------

Rafael J. Wysocki (3):
      Revert "intel_idle: Add __init annotation to
matchup_vm_state_with_baremetal()"
      Revert "intel_idle: Add a "Long HLT" C1 state for the VM guest mode"
      Revert "intel_idle: Add support for using intel_idle in a VM
guest using just hlt"

---------------

 drivers/idle/intel_idle.c | 172 +---------------------------------------------
 1 file changed, 1 insertion(+), 171 deletions(-)
