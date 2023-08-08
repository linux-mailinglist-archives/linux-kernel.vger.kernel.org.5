Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8A7736E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjHHCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHHCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:43:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C489E5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:43:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686be3cbea0so4105523b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691462618; x=1692067418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INNxwX5OXvLNLDOBW649YAXFL5xD3rewmot3fGeUu+U=;
        b=A2/H7xZD3CqmMHtFxsVqnriGlaXy35N8gBbwRol4vGFZvKVXNjRJ4I2Ej91W89NYJM
         wSNrqUuSu0NHolUuyrAQOlT9CF2bWUVb0RRUmRd1vsjGH8JXqQUMDtKUCngxFdnfJqFN
         O4M6br26j+O/QUpWu/rrKJIXEuTHwWBeF8GT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462618; x=1692067418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INNxwX5OXvLNLDOBW649YAXFL5xD3rewmot3fGeUu+U=;
        b=GN/IkDjwAbArQA3CZ+16dU/X/0jLMPCpNH5SY7xa8c8KQg/zVaJsnCds/OuDKKnpQ+
         R8FFx1B90Ry+NsGKbMCXvKUfd6Kk5HItTuTQPeOo0VmCRQOkTatSThQNM6eFSCDAzV7t
         Gu15r5QDPUv8bZR6jh5KzZvn868jiZiE1xijtl2mztrz9YwOGHJDrjLcofgy/ZL7P/1m
         Pzarf8sGF+ifCU8GDgQA3/QxtpnfVTQmx0deEIK8y2BPBZ/6t/5zRJ/9XUDUQtD+Epvi
         voyWOBG5j+Iu+rI4oXyydnnnQ9wLgUJObgWgJLuIe+vtf3B1cEbkJCgbRssvb5LD1Sfw
         FKKQ==
X-Gm-Message-State: AOJu0YxqdQS8xP+2N78TPzk93wXFGtkoKDbH9EscAxnKF6kBW5B/T2p+
        ya2mzojvGkOJySmgX/E/bD4QWQ==
X-Google-Smtp-Source: AGHT+IEEHi3T6ZsjgaGRPluPDjQtcIdZ3It0oJBuq7pr5+R6rIUvnxra471DvdmsO6KuBdWwjldy+w==
X-Received: by 2002:a05:6a20:440a:b0:133:38cb:2b93 with SMTP id ce10-20020a056a20440a00b0013338cb2b93mr11291967pzb.9.1691462618594;
        Mon, 07 Aug 2023 19:43:38 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b00662610cf7a8sm7063479pfn.172.2023.08.07.19.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:43:38 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     jshargo@chromium.org
Cc:     airlied@gmail.com, corbet@lwn.net, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
        melissa.srw@gmail.com, mripard@kernel.org,
        rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de
Subject: 
Date:   Tue,  8 Aug 2023 02:42:33 +0000
Message-ID: <20230808024313.2220391-2-brpol@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230623222353.97283-1-jshargo@chromium.org>
References: <20230623222353.97283-1-jshargo@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any progress on this?  Is it ok if yixie@chromium.org and I do the
followups on this patch so that we can also submit the Hotplug patch I
wrote (that's now archived?).


