Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8597FC294
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjK1RcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbjK1RcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:32:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D8F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:32:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so53765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701192733; x=1701797533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJyIox/fp2fBmF5ORORc6mIFmRJKaIKe+cG1xBjp8o8=;
        b=H3cdw0o6i9B7BlkgtdPTK0qDLz/zAtYw5eLZFtspffj/XsjUWO7xTgIUtlJ+Sv1/oQ
         4gLt34pYRLiklnNX+/7tG1IdlSTydBmp3ZYWq9+lqu4etUCrF++vywgRcTwZfbL+Kpx0
         /a+/gve3P0LxrR4e+EXyjZMAFlWMUvT6f4tsqTjDNJzbW/jR6VbaWABcrGR5VnuREtb0
         xdfGbEp7MyJcuY1etq71SIZdKdUjaGGLKbazRS6COgxlzf+qgW+Juo80FXLbOoxLueMP
         nYvgrA/6HAF5jvlYxonXp3EDtRuBO4Bsm73c+Jy4jj99QfbTfYVnBuMDWAd4SFzwXapL
         HpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701192733; x=1701797533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJyIox/fp2fBmF5ORORc6mIFmRJKaIKe+cG1xBjp8o8=;
        b=sBKVda4u9pyDDJyfRoh0rZ/+aUXPROJvsTJaIPgigHT1YChRLg9+D/QTtfsg30+j+I
         nO2HrviAZtcYloFzrRZLK9uGCLjgpdVb3467Os9RDVcHFyG8Dp8z50l3eqW0eV1pgrsS
         EKO95SVREEVIES2c9kXaL34S6PkZsrKYxCxaA9Jvj1PvmyLGzBAwC1R4QTvwY5Oe716O
         lDAdKMBePskuOD213uh7v/xPtmDNiIA5ExcAQAo+OkZwzM0cOHY3WPLHENp9uVz4MeXF
         wyCk6xJbYyLYje6YEyeQ7MYRMOlXKcmvj8UYEj9ETVzV7tvTPmF5TZmPtaFSos3n4i44
         K9Hw==
X-Gm-Message-State: AOJu0Yxr3YpRVl1HhvuSgH7WsZee2ulYABoKiitcNvRU8+HALLgVA8aZ
        gIFE4jlXruJm+c6xBsONNnr0xH6drh8RwQT0HYgV6A==
X-Google-Smtp-Source: AGHT+IEc6Z4SpVUZAk2CF7793Z7n3QqquvlPQt5tnx5NSbillEpYOmwy7C1hitmTJzSl1aG/3dNSEggEj4OrHsC8Fjw=
X-Received: by 2002:a05:600c:1ca6:b0:40b:4228:ee9a with SMTP id
 k38-20020a05600c1ca600b0040b4228ee9amr384291wms.0.1701192733522; Tue, 28 Nov
 2023 09:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org> <ZVokO6_4o07FU0xP@slm.duckdns.org>
 <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com> <ZWYa5IlXpdus2q3R@slm.duckdns.org>
In-Reply-To: <ZWYa5IlXpdus2q3R@slm.duckdns.org>
From:   Mark Hasemeyer <markhas@google.com>
Date:   Tue, 28 Nov 2023 10:32:00 -0700
Message-ID: <CAP0ea-tJJAJ0V2Wk1j6cHxEscA=J9RByVWBBCRYMD3u3hNEB_w@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To:     Tejun Heo <tj@kernel.org>
Cc:     Tim Van Patten <timvp@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
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

> Yeah, I can do that. That'd be for v6.1+ and fix f5d39b020809
> ("freezer,sched: Rewrite core freezer logic"), right?
>
> Thanks.
>
> --
> tejun

Correct. Thank you!
