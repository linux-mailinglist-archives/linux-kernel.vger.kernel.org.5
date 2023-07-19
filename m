Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2875980C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGSOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjGSOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:20:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFD8198A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-315adee6ac8so6654971f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689776433; x=1692368433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD7U3M3Hdj1KbEGA5MHZFpn4+iCH3CG6qIXB6oHiAg0=;
        b=NzXAFCftbw+S6D6Cx2051P1VTZgEE2FnmEciOOpuvKi7PAlkLMBjOTTeWXY9Ge+3HM
         XWEWVSlSzBW3WaNizpY5xJiOAZwJufXzL3No+91k3hysHSK2KTRJTsQoG5FggwSYziqx
         wcTjM9B20J58TPvtMwNeD/1gfOxVRBSkCVoo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776433; x=1692368433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7U3M3Hdj1KbEGA5MHZFpn4+iCH3CG6qIXB6oHiAg0=;
        b=f5jq2YN+yAjJ1WMVb6hXu5AQNepSFuC59OXZHnjIcXBnuk/V0x5upfLv714PhEQjTq
         UKZLVfIi2jZZ3xVbcBKN7tM7w5kr4t15kHnP2fzykJW1VkhsALHIfp7kdijf0nONZu8/
         2bsmhuTNvsbNaUMxnmPI5eWnMFYv/8MlGmTnX59rblDsWyKnlhhELiBwQjMt+BeBZEV1
         SjdFxsEuT2CV87T0s8JlhVUlezQ7sjXaC1IUtKtC6iqVeIrKfGC8iQe69iOUcFrfb+MB
         ORwGS+a+5YMUiff19pcpiEnwoSTbvY+fGbYCH2vXcNwh8xo8AqHMEyaUMBBhg+4EoiIV
         2N0Q==
X-Gm-Message-State: ABy/qLaoTssm1eu6WafqLXg9KgM75FB3hTlgWkC0pnzPMoDACJUx7wfQ
        sVJLk/vc5rwY4MXa+8ETRVRWRA==
X-Google-Smtp-Source: APBJJlGp14EglA8VcfXrVUxwsoE3rzyvXr9G3AO+2J4nzLaP1FL57cOTbsbxKXFWBD0Pk+HaLF7kVQ==
X-Received: by 2002:a5d:4989:0:b0:313:f6bb:ec2b with SMTP id r9-20020a5d4989000000b00313f6bbec2bmr8229wrq.47.1689776432761;
        Wed, 19 Jul 2023 07:20:32 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (91-82-183-178.pool.digikabel.hu. [91.82.183.178])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6411000000b00314145e6d61sm5499995wru.6.2023.07.19.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:20:32 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:20:20 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 6.5
Message-ID: <ZLfxJKGLH8IpG7Ja@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.5

Small but important fixes and a trivial cleanup.

Thanks,
Miklos

---
Bernd Schubert (1):
      fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT

Miklos Szeredi (3):
      fuse: add feature flag for expire-only
      fuse: revalidate: don't invalidate if interrupted
      fuse: ioctl: translate ENOSYS in outarg

zyfjeff (1):
      fuse: remove duplicate check for nodeid

---
 fs/fuse/dir.c             |  4 +---
 fs/fuse/inode.c           |  8 ++++++--
 fs/fuse/ioctl.c           | 21 +++++++++++++--------
 include/uapi/linux/fuse.h |  3 +++
 4 files changed, 23 insertions(+), 13 deletions(-)
