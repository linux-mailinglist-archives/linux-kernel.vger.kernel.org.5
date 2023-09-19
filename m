Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8A7A6B10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjISTCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjISTCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE561E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e79a36097so2560557b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150134; x=1695754934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7DMdUamBzEa23P7zE5AZLI90338+bQ4zFLdMCSp3KI=;
        b=UEof/Mk/O/C49Pj8KbGq21BVQykE6ts2VwIQ60l6cTX6bumvoMRMXddeHNudsBSPRT
         uTVUrWBXt2t0eeABdQ/8sgjmcxfE9KT/ktyTjDOYJBj6NyxSnYoU/C0NxA0eJRey8xIa
         O0HAnbvMobjunQaIY4gjGXScAhwxQtWnLItdO32fpHrhnUtO76iAnl83Enjg18abWx1q
         mcM0DARDzPwJ/IQ8/647uTGuKGAYaMpe8p9qIB7CTwRVgBA6uKHLuVYu9Yf70mKLFNJ4
         ez8he3MUHcCIAXuKTqzr+8x6QvslnMQxcxOQK6L2LOoRvhuDu2bJ1dB2wbY8U83v6o6I
         9LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150134; x=1695754934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7DMdUamBzEa23P7zE5AZLI90338+bQ4zFLdMCSp3KI=;
        b=hyFnnUnWPcRQSRlyiOm138aZ885s//sNOBO0ok22qUoTh8r2D04YG2pI9+Qkc7LEok
         le2VgpyetWxBOQ6hSAolEwpkr+gbcAPZXhcivCGJFypcSs/maajm5JPTBhFGPMqhui47
         AkJvVq9Jqb/IcbmI7nvTz1XrP1BA+jezTaX68cfBoroF4QzD8a2MPPqmqVYPssFXutB6
         pRsL66ncCpTWI/QWp1J0Xp5IdOniLItSxCkJHuwXRcvMQdfW4fp8QHXkLHhugByH5Tkg
         40ZfJhPsZV+hHdu1xNuJXxrXg1ebMDoU7pwuCfvOmhDGfez6RqMFnIRYSco75bVWKUxS
         B08Q==
X-Gm-Message-State: AOJu0YzYytrWn2K0Z9V1Lz3TuM1ZZC9SVJJD7LpAkZX5cuSE5oRmeLjY
        F3SUcbo/VrE32lbdZHJAha6FRWkhrQKXfRJzSdYa
X-Google-Smtp-Source: AGHT+IEO4CioWGeMO0mLBTwXzCTR4DQsMAJTo7jrWLS1l6E5YqJYAIusC287GlrMsgTnCH5DnoLfuDVce0/mKLRwpTZk
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:c83:0:b0:d81:5c03:df99 with SMTP
 id i3-20020a5b0c83000000b00d815c03df99mr12778ybq.3.1695150133966; Tue, 19 Sep
 2023 12:02:13 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:01:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-1-axelrasmussen@google.com>
Subject: [PATCH 00/10] userfaultfd man page updates
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various updates for userfaultfd man pages. To summarize the changes:

- Correctly / fully describe the two-step feature support handshake process.
- Describe new UFFDIO_POISON ioctl.
- Other small improvements (missing ioctls, error codes, etc).

Axel Rasmussen (10):
  userfaultfd.2: briefly mention two-step feature handshake process
  userfaultfd.2: reword to account for new fault resolution ioctls
  userfaultfd.2: comment on feature detection in the example program
  ioctl_userfaultfd.2: fix a few trivial mistakes
  ioctl_userfaultfd.2: describe two-step feature handshake
  ioctl_userfaultfd.2: describe missing UFFDIO_API feature flags
  ioctl_userfaultfd.2: correct and update UFFDIO_API ioctl error codes
  ioctl_userfaultfd.2: clarify the state of the uffdio_api structure on
    error
  ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER error code list
  ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl

 man2/ioctl_userfaultfd.2 | 254 ++++++++++++++++++++++++++++++++-------
 man2/userfaultfd.2       |  15 ++-
 2 files changed, 220 insertions(+), 49 deletions(-)

--
2.42.0.459.ge4e396fd5e-goog

