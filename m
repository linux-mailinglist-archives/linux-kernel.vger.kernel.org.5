Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105BE7C98C3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJOLHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:07:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D5C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:06:58 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7ab31fb8bso41905617b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697368018; x=1697972818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFbOF3573uN2XsjzuWMYl1qqk639YGQ/7wnYm7Gey2M=;
        b=NAjWLu7r88l0GqwnvNQfFYTguNnvuwn+IYmiST5OcqKcrpQgZ3GQ6t/rV4WX/PrYJ/
         alT+6S0bt2TZJGnz8NZZ8QD1MPBsTytR7+q64y+m+kS0PhhNajy0vrpbfY1BjmLke4yZ
         ukUDNCIXffDPQsLOAVl195PaITZ1h8P2PUURxpzbWrs55mkooqQxGohn8MxdSuMiQFt+
         p8heyUqSyPdvgWCSNasz2PRAYCL0yBJ6IcLVnet+LpYyfUgIxNtzduGnG03VHU+/VpuH
         cTnVDOgIkm0vfjBOY9xFAnjXvknW/5BK6Tnt06IFibLv2I87yBzzIW32cu/IAge1nldY
         3nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697368018; x=1697972818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFbOF3573uN2XsjzuWMYl1qqk639YGQ/7wnYm7Gey2M=;
        b=PXB84eBlHBPgYmT6A6tkFmkuUHGnhZSE2BAaw6yd0Wf/cqhrq8/N3qrLVmaYIZve4p
         XNROk81OZ1mHp5TdnkOT7lt5IbRMkgqB+brk0PdmwScLvghgQGtxkejEtea5FDVBMg9E
         NzVWAwg/GagXcB48xkfM8M3x7KEzXF6IC79eEkX48I4ZT4oXFPpZasMZ/185H6qCazUP
         1vtgCO2Z7rbxAV3QkRwGRsff15ttuPOr/4BV5rG+P9ToHZSjJImlMEYUbP0WOdmtagTV
         XeirMSKJf+f/kNqdFM2JWVXGOO0pSwwH/K9jOh8WoLBsWWztAAqhWpQlWOJDVrTWIwW8
         svrw==
X-Gm-Message-State: AOJu0YyD/DwKkwrFHVhdSbYoD4ilq5us1Lu1vfm3wDosawjz6vg6peK6
        jVkkzPJUWukBYoCBdJEyIYY=
X-Google-Smtp-Source: AGHT+IG9SqycCh+aJkrrd1ftgs68PBXqV6Nv82psbGlYW5dVk1EiLuLltW9MXQsnpg+fQQnl6EAwFg==
X-Received: by 2002:a0d:f8c4:0:b0:59c:b61:898b with SMTP id i187-20020a0df8c4000000b0059c0b61898bmr31684125ywf.52.1697368018073;
        Sun, 15 Oct 2023 04:06:58 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id d187-20020a814fc4000000b005a4d922cf77sm1303676ywb.119.2023.10.15.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:06:56 -0700 (PDT)
Date:   Sun, 15 Oct 2023 12:06:46 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8192u: Mute checkpatch error
Message-ID: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Gilbert Adikankwu (6):
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments
  staging: rtl8192u: Align descendant arguments

 drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
 drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
 drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
 drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
 drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
 drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
 6 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.34.1

