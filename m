Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF747CD026
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQXBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJQXBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:01:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9EF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so97569567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697583676; x=1698188476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4SDhb6UAPkxAoM2wRCL8OdhbgRXprRWmehTmuNxYxAM=;
        b=eJLG246aJvZie2G0eDm8IHpEpxjgSDeu+rmjIzUWx3CMqtQORVPqE435BRk7G8Dnlf
         ljoGx28OyVwALb1mFU4IrOLCgT3H15LI6rX+t6dCfzNB0ko/gIgpl5h5bS6xYixj9uY9
         d+8tIHzoZVLv6rvVCXHcS2G2m2TIBDZ08t+/vLVc1D7ChS06jryHoJD/XIXtX/rHqxKR
         Xc0SoUNaY/0sxklb3IAibBa2+hDXqKXWWtV28C3vJWsq4mUhM20+i6jz1DiZagRmpRMY
         1Xg1lD1wS60fINBb4l2Pi1MwdrLq0ITy5b8RmQLP9rcd0RtRg/O3r1OZix5epVzKSpL+
         gEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583676; x=1698188476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SDhb6UAPkxAoM2wRCL8OdhbgRXprRWmehTmuNxYxAM=;
        b=Elf0NNY9bANNOKw/XVy09Zsfod7ei9KXpW2kSi8ex/WUvOtRz2/1ozWPI3v9buELm4
         vEbhxJ5+c8Z4zapKgjfO47zXP2SjMxXAGOhNOTat6UfbLh+p7nf4gf931yvkEo26/+Ue
         Xj7Iz7nO301kK2qWra8ddkXC03uDuK4PCB9Z+4UDMLDw8tr/aluGuIzuVBRH4txjUm4t
         8M3cJQ27Zwj7JzLvcoaazZYzZcyNXr9R4PYst2GJEUoasEJEBsWw4HmvwUMvQXEFH7ny
         bVuQhdzWkI1JYEmrT8y+hveY6Pbv+o3m5M8PeIY3rtrw3M2Ra+gPkRvbf8/XUcnYsu4L
         V6Fw==
X-Gm-Message-State: AOJu0Yw4SltT+Xj3DN4FAKL9honWboAGak75kBCYjbrvweZBH5mRfwi1
        PnMESClSbT6lw4BPY6OZFD3H1npLUIMtqLHXF4pN
X-Google-Smtp-Source: AGHT+IElOQnXJ8mAPfK/Uft/QZDFbxpj4waEhQQCD8PjRlSuHnU6ChFz05siV7yB+6AvAe9n/NYUaIe3MGJeZK0G635R
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:cd04:35d6:a586:5c86])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:ea43:0:b0:5a8:3f07:ddd6 with
 SMTP id t64-20020a0dea43000000b005a83f07ddd6mr81182ywe.6.1697583676211; Tue,
 17 Oct 2023 16:01:16 -0700 (PDT)
Date:   Tue, 17 Oct 2023 16:01:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230110.3170850-1-axelrasmussen@google.com>
Subject: [PATCH v3 0/3] userfaultfd man page updates
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes only the remaining patches not applied from v1/v2,
with review comments addressed. This series is based on the "contrib"
branch [1].

Changelog:

v2->v3:
 - Rebased onto updated contrib branch.
 - In patch 2 (patch 4 in v2), reordered error codes in alphabetical order,
   and fixed extra spacing in the EINVAL error description.
 - In patch 3, fix mistakenly copy-pasted "struct uffdio_continue" (should
   have been "struct uffdio_poison"), and alphabetically order
   UFFDIO_CONTINUE error codes.

v1->v2:
 - In patch 1 (patch 5 in v1), change "after" to "since" for consistency
   and to be clear that we mean 4.11+ (inclusive).
 - In patch 2 (patch 7 in v1), reorder error codes alphabetically (EINVAL
   then EPERM).
 - In patch 3 (patch 8 in v1), resolve conflicts with earlier review
   comments.

Original cover letter:

Various updates for userfaultfd man pages. To summarize the changes:

- Correctly / fully describe the two-step feature support handshake
  process.
- Describe new UFFDIO_POISON ioctl.
- Other small improvements (missing ioctls, error codes, etc).

[1]: https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/log/?h=contrib

Axel Rasmussen (3):
  ioctl_userfaultfd.2: clarify the state of the uffdio_api structure on
    error
  ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER error code list
  ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl

 man2/ioctl_userfaultfd.2 | 173 ++++++++++++++++++++++++++++++++-------
 1 file changed, 145 insertions(+), 28 deletions(-)

--
2.42.0.655.g421f12c284-goog

