Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B837C8F90
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMVvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:51:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F4C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:51:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7741c2e76a3so161783485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697233897; x=1697838697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=nSarddLCrg0YSLVPTAw7yRrdix4NtOqcjctrxVmYoqxnK7/KtPob7mNwQmvweISc78
         4sHH91meLJXkm8+gieMYA6UIkzb6YOdbhrrPLLgyniDu+U173fI+9+BNuF5UV0tZTEJ9
         KEKo4xeTD+hNNlU5avp8zb/a/0EmXPO1XkoIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233897; x=1697838697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=TnG5XXE2LBlXShuxYImuV+JEWcdFKqLWG4Byv7c+a34UC6wOseyfwrKkbPwvtHjTZ8
         Iut3c6jbg+cOLlLu1p0W2zy8DuAj2LsIjQTGtVoVe7zGw153ZyfwnIwAMJfovy9wNJ7t
         VhPnyaV1cvTmpIdmmdUAArsZHpWl3VppUB0bRuqqHb6IvbkTCmAu8vtl/smtabhb7Z17
         hlgHlW0i9hO29M8SWtUaf2RUPaW436n3lb8FqTIasyQYuJEF38zfQyFHQowM0uX1yJzu
         7XqQbEzLKKq4A+btBIOl1rwSyEw2zKj11yCztku8TQEokG1oIbZ4pm956T163MIG38PI
         s7bA==
X-Gm-Message-State: AOJu0Yw9HxENb384KMVVpIH1kcH4N6mGcYH6r6MbTxlbmKKeQtu4Yy/d
        pFJfNyPmGKJ1aEyjrYzopXdwFS4HLUijz2bbZPs=
X-Google-Smtp-Source: AGHT+IExrAgSPJAIXNqZwjC2NWMj2k+skGkJTMwjLVBF3PP+MidtUE5NItfNjsFiwO4wkbCWlFKneA==
X-Received: by 2002:a05:620a:454c:b0:772:6400:f111 with SMTP id u12-20020a05620a454c00b007726400f111mr37021667qkp.47.1697233897640;
        Fri, 13 Oct 2023 14:51:37 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id m15-20020ae9e70f000000b007742218dc42sm964805qka.119.2023.10.13.14.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-41b19dda4c6so37471cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
X-Received: by 2002:a05:622a:760d:b0:40d:eb06:d3cc with SMTP id
 kg13-20020a05622a760d00b0040deb06d3ccmr9844qtb.7.1697233896288; Fri, 13 Oct
 2023 14:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
In-Reply-To: <20231008113602.GB24726@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Fri, 13 Oct 2023 14:51:22 -0700
X-Gmail-Original-Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
overflow of the final result either, as far as I can tell. So while on
x86 we get a DE, on non-x86 we just get the wrong result.

(Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
calculating wait time"), setting a very-high bps_limit would probably
also cause this crash, no?)

Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
where if the result doesn't fit in u64, we indicate (and let the
caller choose what to do? Here we should just return U64_MAX)?

Absent that, maybe we can take inspiration from the generic
mul_u64_u64_div_u64? (Forgive the paste)

 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+       /* Final result probably won't fit in u64 */
+       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+               return U64_MAX;
        return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
