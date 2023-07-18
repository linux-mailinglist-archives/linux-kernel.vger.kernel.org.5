Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26952758814
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjGRWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjGRWCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:02:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC532100
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:31 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6378cec43ddso32756976d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717690; x=1692309690;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4Z5WjiQYpjKKIHMmiUkMvLecKSdsud95ripsYJYW2c=;
        b=QBsSyIZKaJE90Dtf17zQLs/VEtM8h6oEKDB9Lvpz8F68B87gaBMsnAxtqdmOiUpgSX
         XnAvKCwxtxQgTdBDWlHf6SkmpaS3wc06CUFz2SbN1DmmDUDHh16L/21NreuiMdmlNLiO
         M+mNXiI7wk/4yCqK59a/88lOmmQF+QCCAIl3g4N+nsjQxg4LW5p4kJ2QgMyW+TGcIF9j
         WxxagWvidCFM0xSAM/5alVabK3VH/PAfXv9iiZYCvlHvFbsm9Z39Fgj3NwnAL6oKVzyA
         NKTTWcVZ9GM8ywDhMcsBHQL6+otdp5oVOjaJLr0mlMx/sK83qlSw23cZJnGI3DSbCrbg
         fZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717690; x=1692309690;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Z5WjiQYpjKKIHMmiUkMvLecKSdsud95ripsYJYW2c=;
        b=j3eX5hBwVOMGxY7J7T7LCFfVcf9z8FZFYphAeqanCoqGJL1aE9n409Sc1EkJ7FFhil
         cIH/MOoCDcbqeMfXvsKx2zZj3Bi7P6hXQcw1xPV1PW+P09P97Kpu9NanUuPGVh0CeuSq
         5fkpEA4nSJM6AjvGAdV97z2t0hWxXG6eZTXf5V8/roNQ5ksafejN8df7qWG7T6Erkd2t
         JGrAsS/EyXcWrn1nT+P/mjKMXLw1P1KMFsAPdU6pc2ZEIYY0+gWbKU//Rj6lRhB4a7Bd
         jr7sGH6zUXtAVBDYcgszONti8NzffOo5b2YadO7G+v01C5G0G6nIgEoPdV3TGtn1cFEi
         tU2Q==
X-Gm-Message-State: ABy/qLbAvDcjfLDU9L0dYtafQFelhJHdf0fBPTxotap57bkHNMaf2R36
        FFbKANVQZogUMv6OS5a6/eAl
X-Google-Smtp-Source: APBJJlER8N9WfHQ6ncGSyNkwD8mvrvpnlHeOqVt86lvZVSCe8wYjB7PdwEBMyjUEvGsdm8uKxWw9rg==
X-Received: by 2002:a0c:f54e:0:b0:636:277f:4165 with SMTP id p14-20020a0cf54e000000b00636277f4165mr349296qvm.21.1689717690268;
        Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s12-20020a0ce30c000000b0062ffcda34c6sm1005353qvl.137.2023.07.18.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:29 -0400
Message-ID: <ee7408412dd3e1725ae9ef0eeb26e4a4.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 19/20] selinux: status: avoid implicit conversions  regarding enforcing status
References: <20230706132337.15924-19-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-19-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the type bool as parameter type in
> selinux_status_update_setenforce().  The related function
> enforcing_enabled() returns the type bool, while the struct
> selinux_kernel_status member enforcing uses an u32.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/selinuxfs.c        | 7 ++++---
>  security/selinux/status.c           | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
