Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E2760094
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGXUha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGXUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:37:29 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AFAD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:37:28 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bb31d6276cso1675788a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690231048; x=1690835848;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ7trwGgOy74ZMmx1WSYkhxwukYNWfMR8FKYB/XHJWk=;
        b=EcC4j7O67nSfp/pImT3LWLEtRyZjPvk6ecuY8zSS9qrNKZZE5P/tebJ9aBwO/jmPkq
         7KJz0mqaZV2qrZ+JBkHslV2Bl7bmck5ZpeVzdn/jhhvQLD9SGDBnTOwk3/Vea9E0nK2L
         oY9lPNgWdjpuwaurVKs+GVWuB9yjLzPUTemj8uaYyoR0QbR+5ubZQUxy/7EO+jwuZmpk
         7iCxAE9qqxEKZ/wrUqL4n1LfV9Ve3d7hJoSX4YwvC8/gaeNmP7kgucw/gS+gu7zSl0hA
         iYOgNaPF6SgbS6lwvAMZrr2HCx1YG4YTD/sDBhayaVZBCfOTqCrB/BjHaKDZeu3Ll1K5
         KQzw==
X-Gm-Message-State: ABy/qLZx3Dri2Wrg1/G+z+AGqsjukpnOYZWTPngImG998BMpikhDxP2u
        vKUoV67zHphnqdikgzFA8tRS9m1pVcc0yupf7+SjPIXvVWBd
X-Google-Smtp-Source: APBJJlFWQnGftlrdER0j6SIMnKqOAkXNGK//D4qIZMkaaSZT9cyUVxOEEr75aCJTNAtgB0vgDsd0BSkGhTjvPdwIAwtEiZ9CyWSu
MIME-Version: 1.0
X-Received: by 2002:a9d:68cc:0:b0:6b4:5ee1:a988 with SMTP id
 i12-20020a9d68cc000000b006b45ee1a988mr11110645oto.5.1690231048090; Mon, 24
 Jul 2023 13:37:28 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:37:28 -0700
In-Reply-To: <ZL7fhuAHmlcEHj73@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035b866060141957e@google.com>
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
From:   syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/bridge/samsung-dsim.c:730: undefined reference to `phy_mipi_dphy_get_default_config_for_hsclk'


Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
