Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C67ADF19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjIYSho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjIYSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:37:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D848E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:37:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60a514f3aso30739565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695667057; x=1696271857; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=StCxuS9iQZ+v0HcicZ1FUp7Q8gfqg4PF8H3Zs9sp0jU=;
        b=GWbh1dTMArkYq/W9R+SDFDCFxEzsP29FDxx4e6AOIDbCLbX/WvMp+cZr2+BkiEBAaQ
         K1HLRD6PZj6d2BuOrOGu8QlU+Ee6h1+wXb9LQjmIygWBezpMX1/NqX/zbzVN7ob8LijK
         X10UfnTfTlbL4hx99CwqVzxEmwnllaUcqLAPnAA48IopIZPYmrm0J4Vpmi+Kulq5HtHP
         Cni/mLqnhY4/h7KTj6VkPdfEJkdpJZv6Zue3M0EnZLcO0gkaKSlsZpRXqYfKEqEOM9ag
         /A9ABvpxrPkeguvJnQPYLlkdOPR09Pr4zXJgaf25FRMexC2ZKaRpKUcBRDJLAjEzW2gO
         UlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667057; x=1696271857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StCxuS9iQZ+v0HcicZ1FUp7Q8gfqg4PF8H3Zs9sp0jU=;
        b=aqxAZgHjuQkv0LGKxATpDIaLQSY34MCQL4auYZtUSRjQtLkDkGqoT7++j1oLu2yVzg
         q/bvItU2jJmewOD+wkC5Sj3x+DldhdD7G8Tq/zWDQm/U4NdtHhBh6Xo6Obb/zR54MS//
         TDCkFI6yZrBW1dsJtgnLUXL+Ey8Rj0fytXyKF3mUVRGEO3gNVk4+KSje/a554Srj0Ipa
         scK236YHcslGXnZGv/sRwyhjelSAVBz2ez/Gj+4EJ50dF8xX0SEI6EO0MIMGiWyuLa/F
         kKdFfW3cJ4Wm+dQK2vQX3GsbcjG9tHsZVJpPNpcFyk+Hvnrz1ad7S0fU0+qQowl0rmCt
         dunw==
X-Gm-Message-State: AOJu0Yxk+p1F4DJtKCy1hvz6IWk//mKM5TempPoxh5wqKJxIvgNGJOSV
        yBPRxTn5TpAy6uVIivjFWB8=
X-Google-Smtp-Source: AGHT+IH5sjKWWjATskXQFSnBLb5NjFLFAQfqwcnZ46mdTzrsq2lDcAKrnzot2tSa2Ek0uZaASQCstQ==
X-Received: by 2002:a17:902:a9cb:b0:1c5:c36b:e954 with SMTP id b11-20020a170902a9cb00b001c5c36be954mr7033620plr.2.1695667057412;
        Mon, 25 Sep 2023 11:37:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b001c5fc291ef9sm5319606plj.209.2023.09.25.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:37:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Sep 2023 08:37:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Workqueue fixes for v6.6-rc3
Message-ID: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
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

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ wq-for-6.6-rc3-fixes

for you to fetch changes up to dd64c873ed11cdae340be06dcd2364870fd3e4fc:

  workqueue: Fix missed pwq_release_worker creation in wq_cpu_intensive_thresh_init() (2023-09-18 08:50:31 -1000)

----------------------------------------------------------------
Workqueue fixes for v6.6-rc3

* Remove double allocation of wq_update_pod_attrs_buf.

* Fix missing allocation of pwq_release_worker when
  wq_cpu_intensive_thresh_us is set to a custom value.

----------------------------------------------------------------
Steven Rostedt (Google) (1):
      workqueue: Removed double allocation of wq_update_pod_attrs_buf

Zqiang (1):
      workqueue: Fix missed pwq_release_worker creation in wq_cpu_intensive_thresh_init()

 kernel/workqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
tejun
