Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4357EE764
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbjKPTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKPTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:21:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8DD63
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3bb4c307so10978075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162490; x=1700767290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzF2ALYUXgtOOWHICjx/9sp3ZlXGizxmY7whZwnkVqs=;
        b=k+gERTjO6F93q1lS3m32rhR1J28d3mpm2fohBNlGcICYiGp+WYLpMxD8T7g/NwYvkq
         TnISjy6v2HHl9uLVBPS8As3+3N6VKqEA9rJCcxc1hfXLgupG0st4Nw0XKCMTajq+7gAC
         fZ1sQBFKSupkE3fCKaYxdMbwZ3O33arR2wFwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162490; x=1700767290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzF2ALYUXgtOOWHICjx/9sp3ZlXGizxmY7whZwnkVqs=;
        b=fcW7TzRHsYp2NRss9MfBFavzyDyDtK/lZIam+3Pc5/K5IyulGK6ww8kbmInnL/uny6
         Wt9V+9QEidLSsPuJIl1pwgiYbfwIHU0uwEIK5lEn/dyLc1AhVZwRmYX4Uh/6K7DoAEvi
         39ZCkgyqHStJOZINVScNRm9+5CEG9Ti3KXUaaWe8LOpO5yGeBmgxmer64FStU2fWQ6rX
         GuPABpLcH8NGbqKUwdk0rdAp2HhM+ehYaixSiYqo0eqTj6nXLUFUB7l94QDzQxbQ0rcz
         c52fBs6YwWwP7NzdlhpLhCwICFhfE6tI4bcq0YflGZiUqDZ4qTUiJzA1Ebdd7FMFXgv5
         CJZQ==
X-Gm-Message-State: AOJu0Ywnn2PvihIqex4Qke41WiYYmV+u1pp8hnBqQKaiWSBrdy6kxgFM
        s5v3Ic6ma1tItCUWbZURTjRvjw==
X-Google-Smtp-Source: AGHT+IFOsmNi6M20q2mMZfgvvs7Ny35X8FWHOzyId2w5LMV8GyUNADT9qbMocFM5IvDg5rKoPH1waA==
X-Received: by 2002:a17:902:f54f:b0:1cc:4eb1:edaa with SMTP id h15-20020a170902f54f00b001cc4eb1edaamr11388254plf.51.1700162489866;
        Thu, 16 Nov 2023 11:21:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709028c9800b001c9bfd20d0csm17388plo.124.2023.11.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Date:   Thu, 16 Nov 2023 11:21:22 -0800
Message-Id: <20231116191718.work.246-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=keescook@chromium.org;
 h=from:subject:message-id; bh=w0GAtTzgRNL9znjaphz3FN4VQ24pFDHc0eBL30sFkpg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmu11zVyAR1N094pTJIYi2lpml53vIr/7Zkfb
 zgMf4lRuPCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZrtQAKCRCJcvTf3G3A
 JqcUEACow96whY2PXsoj9tPefpjj3UIwlfJ3ut/35CSfyT8UK7/zYhv7KEZrBeHK/qxMRJ9+xBe
 Pc7j5tIqc68ExBPJVWjYfDJ37dsg28n4AbifgDfF4Tfr+XD/B/7zBYlbqa+YfKIoqNsie3TuEmb
 Jo5TNLzmJ+iHwLZQBg52HuTJ8IypsNdhdPUDt+GSVayHbFP8sOaZMzSgNzkWGE0EZPJVbhJkBhG
 dgaf1he3KcoFhM6lOXcJzNfLL4wP3gW0wQvCa7n53dwozdUYLAN8vAo99ju0ONbxHC5gaRy2hV1
 m8LYlDrVzBTldqKUPCwLlfworllGmywSzRyIvViY2SKCuLTEJMhrfrRT7eIc9F/TyhwKXjfWGox
 Q4MGthWvVnHSVXW26aJPBCdBexdQe0UNHIe1e9GtdPVv6/DSkPteLizTSuVXO/m6gY1q3uCYF9G
 RsrfA76ykmz8PiMZ1HwiSOUivMyMCZYd9dgBIcnKAxJdRmYQm6zmTcEY6iUR4P/ay56A0T7/tW+
 SIqHoC9vLAMJk2kagkrDUu4Q7FIjW4MKeI+Ul2jrc9WW0ggDCMFFYhz9oXzEcrakU5x04mo7l07
 mIs0IZlQmu6Y6/xTB1XcYB+9kCsQ0kxxgVUzqWsljvkctWg0ATuQ6HYRvZxRPR3AoAIvMha9INk
 Mb18F4pb gdKumXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers.

-Kees

Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c             | 53 ++++++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c   |  2 +-
 kernel/cgroup/cgroup.c      |  4 +--
 kernel/cgroup/cpuset.c      |  2 +-
 kernel/trace/trace_uprobe.c |  2 +-
 5 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.34.1

