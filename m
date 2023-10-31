Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6A7DC3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjJaApD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:45:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FC98
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:44:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bee11456baso4470776b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698713099; x=1699317899; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uoDWQd8kpjejy04nXqg/q/i5Wv7zICsBXPE4dDH1FfI=;
        b=KluaaNfu/dDFeqmGI8x7Hgc/sXuxhwOvRNpozRNv7ScgvvAx3iWeViEE+5++F7FRgn
         1VL11a6MD3uQFEPCA3evjICdlnfwLB++asAoNffkunOgby+Vqd2pOQLY69+ooAacjwXJ
         ZQ4/lkuDTVmwxu2IpCD+HPc476E4ZbJ6iJblL83liSeSRBj+5QyTuIcJbVy6psHcTO8u
         /B23oB4o/jMu5/VAnsmqMDUVMSxd1uCuJHeh0SHezC4FMn0kI9JOG37Oy03+jKkU8AD9
         DcOkCJiJUp01WuJr8VJmnPDg4IZxBxjzpC5kD3I6tl9/FcwvegfHtrY8X0nnmIZqUxhw
         Kerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698713099; x=1699317899;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoDWQd8kpjejy04nXqg/q/i5Wv7zICsBXPE4dDH1FfI=;
        b=XUXROoX2oPtZ+CnWp8hCbGiyad0LLmY3LHo5M7gcADK/mZw15YDHCrLrPSyrXr9BV5
         cDAWBnMnyLWSoX6wrvGkDbkEOVdfyIldnAJQqcZKz4Gg1obRnkZETc8FAnrKPJ76aj9R
         Ev4iXb3xO/3vvOHScPdrBrkKUAGnMgOuWkweXC9VY/l3uLb6tKTMSUchUVoBEl3VWaTC
         TENWftQCEExauQhZ/nNjNozO2nvF3AB538kIS5YS9F7CCXHf4uQuFmWVT7ThVI5yLrSN
         +7FRbobl6K3cBI0jWb4jTlPB6/5+ash1gUdRgWqJAafxARIItJxhA9cosT7+GIqyyTmU
         ogrQ==
X-Gm-Message-State: AOJu0YzpC52dyX5WZUjPHMTdKhkA7lG6hJPdr0ktSNpsheEVDtfv+kTc
        jQKIWvOqWFdDGmC/fE8ry/4=
X-Google-Smtp-Source: AGHT+IErW8dHiUQ9iuD/NuYRd6m3PiS+VHotHyAtLHwLf91mxUe3yeZzPskgFZoaGvzvOEpWNK9DMQ==
X-Received: by 2002:a05:6a20:1614:b0:17b:62ae:a8aa with SMTP id l20-20020a056a20161400b0017b62aea8aamr10620109pzj.6.1698713099122;
        Mon, 30 Oct 2023 17:44:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:10c7])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090311c900b001c625acfed0sm109272plh.44.2023.10.30.17.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:44:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Oct 2023 14:44:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com
Subject: [GIT PULL] workqueue changes for v6.7
Message-ID: <ZUBOCeLPnmgrE1qn@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06dc10eae55b5ceabfef287a7e5f16ceea204aa0:

  Merge tag 'fbdev-for-6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev (2023-10-17 17:14:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7

for you to fetch changes up to 265f3ed077036f053981f5eea0b5b43e7c5b39ff:

  workqueue: Provide one lock class key per work_on_cpu() callsite (2023-10-17 23:49:19 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.7

Just one commit to improve lockdep annotation for work_on_cpu() to avoid
spurious warnings. I'll send another pull request for workqueue rust
binding.

----------------------------------------------------------------
Frederic Weisbecker (1):
      workqueue: Provide one lock class key per work_on_cpu() callsite

 include/linux/workqueue.h | 46 +++++++++++++++++++++++++++++++++++++++-------
 kernel/workqueue.c        | 20 ++++++++++++--------
 2 files changed, 51 insertions(+), 15 deletions(-)

-- 
tejun
