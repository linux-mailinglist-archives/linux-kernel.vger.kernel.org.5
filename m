Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43F7CA01F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJPHLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:11:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0BDF3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso1049640b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697440301; x=1698045101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9BgW3N7fBm3L3q4onC3IgvyssbSs3COoJlmjYvy67c=;
        b=bT3qysYzQd5hmcVvZhTsiZwIB/iZooHSpkXl/sAJurRrCZWG81NR4I+NwA9uRUsnCD
         880bWXswVCZQSmV79CRs0OGxXBD1ZHc169Ni0HhnOW68D9V9JIS120QBUWvvvHmM09lJ
         D6E4HwsJyFA0xAHeYjPyJR8TLbgiu+DE9iGUmTieOF1zVCQJcdB38XpffSKCKcH5ZpKP
         JOy1MjgcrSL6wYf4eCp8+kQrJdvOQtO8AnjkPCTQKTGWI0ced8SLRmAboSsCiYa/AKfo
         /Ag9fkxQcATaU7vm7Gtt6mMXPpB8Z8FSZfAqOPXcdr/gUfjAtWaC6PVlBt6cpgco7BpJ
         Nthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440301; x=1698045101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9BgW3N7fBm3L3q4onC3IgvyssbSs3COoJlmjYvy67c=;
        b=LvpNmL9VwsVNxQDrXpdMSBTn80561THUt30dB3bRx5F1Cd/IME+XnrkDe7X/LmjCnD
         rjGnG6nbodp0ux3ys1q51m22gq7MUwmlVtrFUgCIqv4Ey3fDdqxGI1WidNEwG6P+k3mF
         z19vsRrUzB3ujrE9fhv1rfA0VrsTd9i9aiVqydBCH/DDumWofwUT8t1EwxCXh4GwfyIu
         VWuSOiOaye4AfqXnEUd//tS0ymi5R04Vpny0X44YbfLzpgNn5Bnmos1kDZZ+cSe4fYEk
         TmzaiInTOpOt5SgMhXrVC6N6wMwCp/Zh+rDnCMEowAAOV2TTk+tvrJyCwzYbdx6mePPo
         GENg==
X-Gm-Message-State: AOJu0YwePdrpCVn66YwG2HJ1+Fqw+NeMilGsz1F/bPj6lx8+2Uwrs9V8
        TYmrU+dsMXdzbvv34tp6oQ/NDQ==
X-Google-Smtp-Source: AGHT+IEIs6XIz4BcgrL6UjHqZ7eccrdQBeHu6/iJs/nkUOuVV60OXfEgZzK/h9q3JanneEdJ0Z+E/A==
X-Received: by 2002:a05:6a20:244f:b0:152:be08:b013 with SMTP id t15-20020a056a20244f00b00152be08b013mr34042875pzc.42.1697440301401;
        Mon, 16 Oct 2023 00:11:41 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id lb18-20020a17090b4a5200b002636dfcc6f5sm4069757pjb.3.2023.10.16.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:11:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH V4 0/4] xen: privcmd: Add ioeventfd and fix irqfd support
Date:   Mon, 16 Oct 2023 12:41:23 +0530
Message-Id: <cover.1697439990.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that irqfd support (backend to guest interrupt) is already merged, this
series solves the other part of the problem, i.e. ioeventfd (guest to
backend interrupt).

More details inside the commits.

Arnd reported few issues with the ioctl macro usage and argument's layout, fixed
them for irqfd too, which was added recently.

--
Viresh

V3->V4:
- Use __u64 for indirect pointers in an ioctl command's arguments.
- Use u64_to_user_ptr() in kernel driver to access the same.
- Use _IOW() macro instead of the internal one: _IOC().

V2->V3:
- Remove explicit barriers and depend on spin lock instead to take care of it.
- Move check for empty ioeventfds list to privcmd_ioeventfd_deassign(), which
  could earlier call ioreq_free() even when the list wasn't empty and so we
  returned without printing a warning in v1 earlier. V2 implemented it
  incorrectly.

V1->V2:
- Increment irq_info refcnt only for valid info.
- Use u64 type for addr.
- Add comments for use of barriers.
- Use spin lock instead of mutex as we need to use them in irq handler.
- Add a warning when kioreq is getting freed and ioeventfds list isn't empty.
- Use struct_size().
- Validate number of vcpus as well.

Viresh Kumar (4):
  xen: Make struct privcmd_irqfd's layout architecture independent
  xen: irqfd: Use _IOW instead of the internal _IOC() macro
  xen: evtchn: Allow shared registration of IRQ handers
  xen: privcmd: Add support for ioeventfd

 drivers/xen/Kconfig               |   8 +-
 drivers/xen/events/events_base.c  |   3 +-
 drivers/xen/evtchn.c              |   2 +-
 drivers/xen/privcmd.c             | 407 +++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h        |  22 +-
 include/xen/interface/hvm/ioreq.h |  51 ++++
 6 files changed, 482 insertions(+), 11 deletions(-)
 create mode 100644 include/xen/interface/hvm/ioreq.h

-- 
2.31.1.272.g89b43f80a514

