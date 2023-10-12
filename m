Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E17C7A45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443075AbjJLXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:16:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933BA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:16:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1140653b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697152564; x=1697757364; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pH+QiaOpiodhML+ziwBZXDsGTkmJ8Um8VRUGUcj7OpE=;
        b=AzlaMWoR1ee9Nm39y76CDwz6AH+QD8Xt2nuDg5CSu8mAAYAS+fYnJdhKg27SvPP0Lg
         pda63qU/jOiOSj0RIbluNZBmojRdeY7S/Z5GYupLfGzrQkIKpxujfjV6y923W+J4toKD
         LADaQSipY0KbusK8xM+FteRh9Srt6ysKRkLMjgb/g+cblz/Hobo/TzLiEfEy9ezstQBk
         qAtw/nhnTp/Z+x91cFV2dz8RV1xnpP+tOnLGjfkEvGdZVTNIUihx1i91keH3k1e76ETV
         pCzaPX12WcgxgrH7P0ncgd3lFONRftbrbbj7VeJtYIxloiDUj8Z7gjO6Fv8mxsmMVIJw
         N37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152564; x=1697757364;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH+QiaOpiodhML+ziwBZXDsGTkmJ8Um8VRUGUcj7OpE=;
        b=XzHWkAeUccJzTkBbYhPfVUHoZJCZgTs661quxV9p/hNPECldIy3OTmSs2I/njUnYSB
         VUzODynkGf/0xIQ07Oi5TNDYYNTb52k5d/ZlB2wQTrIKMX7xff9tVNQpZUcXmDU6PNdO
         s7vh8czHXufYcaEd2D8SUd14EGX5opWR0nTOYN9YtE9q2l0riSgiYRwZ1n9HTAn1q3Da
         A1elVZi4txQkYQ1Wml585pq/taWWsy62YnH7/dPaGFlTAPTVR6P42kSTJOtNZU1jb6Hf
         CeXsBmQg3lHZpvwFoJ+/r5YYLxhUfDziUG8pC9MVulCedOVAmsCV2xZbrqr++eplM8t4
         MB8A==
X-Gm-Message-State: AOJu0Yx1QNa4w/B1MqoLJpluPu7koGTNR6Fls1H3C1dXq801HS3Fanoe
        IGAUd30LaqG+byhAylrjqgg=
X-Google-Smtp-Source: AGHT+IGWNM9HxyjKjEjKXLUp5t+0TS2LwspKsRp0pAtYtEaj1A0Nh8DQxXN2IsD0JhotBS2YQgTViA==
X-Received: by 2002:a05:6a00:2d98:b0:68e:3616:604a with SMTP id fb24-20020a056a002d9800b0068e3616604amr34034272pfb.8.1697152564146;
        Thu, 12 Oct 2023 16:16:04 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0068620bee456sm12292131pfm.209.2023.10.12.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:16:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 13:16:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Workqueue fixes for v6.6-rc5
Message-ID: <ZSh-Mjmquc6wAw9B@slm.duckdns.org>
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

The following changes since commit dd64c873ed11cdae340be06dcd2364870fd3e4fc:

  workqueue: Fix missed pwq_release_worker creation in wq_cpu_intensive_thresh_init() (2023-09-18 08:50:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6-rc5-fixes

for you to fetch changes up to 5d9c7a1e3e8e18db8e10c546de648cda2a57be52:

  workqueue: fix -Wformat-truncation in create_worker (2023-10-12 09:53:40 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.6-rc5

* Fix access-after-free in pwq allocation error path.

* Implicitly ordered unbound workqueues should lose the implicit ordering if
  an attribute change which isn't compatible with ordered operation is
  requested. However, attribute changes requested through the sysfs
  interface weren't doing that leaving no way to override the implicit
  ordering through the sysfs interface. Fix it.

* Other doc and misc updates.

----------------------------------------------------------------
Lucy Mielke (1):
      workqueue: fix -Wformat-truncation in create_worker

Waiman Long (1):
      workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

WangJinchao (1):
      workqueue: doc: Fix function and sysfs path errors

Zqiang (2):
      workqueue: Fix UAF report by KASAN in pwq_release_workfn()
      workqueue: Use the kmem_cache_free() instead of kfree() to release pwq

 Documentation/core-api/workqueue.rst               |  4 ++--
 .../translations/zh_CN/core-api/workqueue.rst      |  2 +-
 kernel/workqueue.c                                 | 24 +++++++++++++++++-----
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
tejun
