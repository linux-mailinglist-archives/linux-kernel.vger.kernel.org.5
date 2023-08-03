Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA076F0F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjHCR4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHCR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:56:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9951718
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:56:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so29311cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691085408; x=1691690208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtiZwsSABgt+mK1yvfb8u9R5xpab/El+WHboQ+axzsQ=;
        b=u57XpfzCiX3ohGkxPhXVfjvBEIcIBKDB16BfSrMrVtZAk1KpeniZS+lq44SmE/cHMO
         7XWvFZ/cpnlEpg3gageco3dCvWMs7P8j4kuGhqFK0As+mmk8EkUksLMYini0NGWm7qR6
         Q6lyf5zauEmeGJ1QPFbIW5hvQQUPMmEXhKNIPju6yW9LAS8qkv25vaV8PbTMafiZNMGV
         JbauaTHFsD8Q5AV59n7mYZNIqBfd5GUlUjuB8ZkevxHpZZaC0ZuyfUbyDkiVVEuXQWrA
         Im8vOSf1oJBsUEiy9/8FK4Z4rkEyOIhUhUpWo5o3YpquUAit5v/C9UuVACCoVE6Srr6a
         AfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085408; x=1691690208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtiZwsSABgt+mK1yvfb8u9R5xpab/El+WHboQ+axzsQ=;
        b=lltVFxl0OXVnMg5YYmLljRiWcCmhIiLZ2n6HgUBMBOtXYL0zBGesE3HfHA4NpIuQCr
         +KmFZsKheq6VJU3h0ZO2u3tCTqzKt71n/DbRwZ5XjtTVkUAOJqnXBN9bqdJJRKHmbAeL
         vYfe7jpkfJy5XKYNNNuL0Lq8daw2Sg3c/YO1rVN6XOM86/9HuYqVa5tyJrTfoH5pneVf
         G0D3tZ1XZvfrXnDxowb5NYoXf0YybE5mn0fWcdq1prx1Zamqe0APmUB3nDu3Qmbc5YJB
         JKnkdFIxRx36Le7WvL049ImYZqOio08SAhYJJDPriU4LGCNxMV2noAgNI29EB/jYIGLS
         xoiA==
X-Gm-Message-State: ABy/qLZahX7QrYP6u4TYx4jVvgmVaou0YU0IMasEU8Ip8xaEXbqzrlpT
        xkJhLJ4ygJbAcfJU9nirl644Ns/4aP+h3T7f+Z/DwQ==
X-Google-Smtp-Source: APBJJlGl35bf2QzbQpBWgDvUdXpFzqk1G3zZk+vXJ2EaPJD5u7BX/byeBmEHUnRs79tVKj42r2plDYVADJIZPS5VRL0=
X-Received: by 2002:a05:622a:13ce:b0:405:47aa:7ffd with SMTP id
 p14-20020a05622a13ce00b0040547aa7ffdmr1629841qtk.19.1691085408201; Thu, 03
 Aug 2023 10:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
In-Reply-To: <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 4 Aug 2023 01:56:12 +0800
Message-ID: <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a subtle bug.

Previously, the arm-smmu-v3 driver could get away with skipping the
clearing of the CD entry on detach, since the table belonged to the
domain and wouldn't be re-written on re-attach. When we switch to the
master-owned table model, that CDTE in the master's table can get
written to with different CD domains. When the CD domain get's
switched to a new one without first being cleared, arm_smmu_write_ctx
will mis-interpret its call as an ASID update instead of an entirely
new Cd.

This bug was handled by clearing the CD entry on detach in the
"iommu/arm-smmu-v3: Refactor write_ctx_desc" commit before it was
split from the set_dev_pasid
series(https://lore.kernel.org/all/20230621063825.268890-5-mshavit@google.com/).
The change was lost when the commit moved to this series however. It's
splitting hairs a little, but that fix probably belongs in this patch
instead.
