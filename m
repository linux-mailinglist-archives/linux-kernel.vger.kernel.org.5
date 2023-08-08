Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC464774CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjHHVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjHHVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:18:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E64C05
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:16:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68783004143so4473377b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691529415; x=1692134215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWCyLfh7ufeA+e41sIszR5gJVTHk0O1EKFC8fwFeJfg=;
        b=bIgZfFWff7vCFhFRBNYMP44PLjllIzgk88/Bvu+Jn5ZnqWt0PMjlF2x5GRzb2r4G/e
         NGSRABryQUoSf22qDJDVau9dnF2TMhDfeBmSir/IB/9HDiGQsMsQf1th+t58wJ4Cm7+c
         OldubBMLwwcmRNC2GT2RAxf8BmDKEkRL+o3Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529415; x=1692134215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWCyLfh7ufeA+e41sIszR5gJVTHk0O1EKFC8fwFeJfg=;
        b=mG08E7aJCQ4trnbVdnkqn61x8vA4p9Q5Ar86Y5MCRwgqb8zmBqCRf7TAgbKS+uOBmt
         qTjnRGzqbORiTDTyehHk4FqE/yRSryPN+QTHBk5yu7o75sMqbUb2O/2tyyR0ycscyC2P
         J3lZtZDVMI8roUNGb2lUHz50GPG09z5buy9dGfORf6Mj84sWTyfVL/IiDZo83Lo5Yunl
         3VfF0vzIXZlA4etQdpkKLLwdJYaoPIKGvXh8BHhOLHwCbNgo/ePhtPJaS6/CvLx+izTB
         O4eYz+0ucDKnOWUJmibL0tn3XBaxNSVE7v84duz8wFD5Fi8ZTqCAu/ooXbErnRrLpvjA
         1FQA==
X-Gm-Message-State: AOJu0YwSHtrSFm9I6DwlAyYV6R1LZhrftKTziLXe75fgGHcV9XtmVDHP
        Ln5v0u2W0FM44OlwqJLeoRuiAQ==
X-Google-Smtp-Source: AGHT+IFMS3iiiGT09SOSdi5OeHfTDBBqx0THtxMP4GnBnfJYaxxIcgGr0pmGCRSNeCyQAJFPohjtNg==
X-Received: by 2002:a05:6a21:3e09:b0:13f:1622:29de with SMTP id bk9-20020a056a213e0900b0013f162229demr740661pzc.7.1691529414881;
        Tue, 08 Aug 2023 14:16:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78549000000b00666e649ca46sm8523574pfn.101.2023.08.08.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:16:54 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:16:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [GIT PULL] hardening fixes for v6.5-rc6
Message-ID: <202308081415.A5E80C1B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these couple of hardening fixes for v6.5-rc6.

Thanks!

-Kees

The following changes since commit ec7633de404e7ce704d8f79081b97bca5b616c23:

  sparc: mark __arch_xchg() as __always_inline (2023-07-13 09:54:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc6

for you to fetch changes up to cdddb626dc053a2bbe8be4150e9b67395130a683:

  media: venus: Use struct_size_t() helper in pkt_session_unset_buffers() (2023-07-27 10:11:11 -0700)

----------------------------------------------------------------
hardening fixes for v6.5-rc6

- Replace remaining open-coded struct_size_t() instance (Gustavo A. R. Silva)

- Adjust vboxsf's trailing arrays to be proper flexible arrays

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      media: venus: Use struct_size_t() helper in pkt_session_unset_buffers()

Kees Cook (1):
      vboxsf: Use flexible arrays for trailing string member

 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 fs/vboxsf/shfl_hostintf.h                    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
Kees Cook
