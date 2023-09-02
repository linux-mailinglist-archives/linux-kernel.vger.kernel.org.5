Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32214790894
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjIBPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIBPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:46:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C72E56
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:46:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso124851fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693669563; x=1694274363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTVrfuoyyUEeTTw7w2mP5y9qGCPLtPAJX6CEnNqN/W4=;
        b=FB26Ycyu1cIsGTT9LUlS0ZkxWIET1Sa9jO8UKaxF26Ic0C9E/xBPy77hRRguAAg0CI
         Nat2q/FVG9Pw+4rBvU4Zn/qnCuNkzVXd1pnnpE9q5+tZNuZB+6WCSQEVx4E6WkAse+Dq
         2ZzA5qgv2e0eIZgyijtApB5G58rh0LlmL/p24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669563; x=1694274363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTVrfuoyyUEeTTw7w2mP5y9qGCPLtPAJX6CEnNqN/W4=;
        b=DKKqEs+p5DnEShOdzHEhXPIxy94DpICAp1FXNcEA6DsH9VZ0mJHBu041U8OYOtJyOb
         SAXYiXambAt60J9qh9wiY8GW2m54QYi41kFajkkJmeQJOV6RaFyjl4eB4uuNiJJihCrA
         Ti5KnrgoGENZ9IfhWvMrLEnqruyK+FvIP40VAG+hR7bFk5q16BpvgmJgh5+jCJ7A7DFY
         HOUIF7B9KLFreA7fBZq081V1n2nBO2dAiYX+X5B8wfKZmn0HKfJwOq2OqdpkTQjM1Wry
         3nm5xOCxvNW2J1pR9cGcWa8ysE0YHH/9pSjrfpH7pe5t/c1UDv4vx1MNt7VA1QypUJUk
         Oyvw==
X-Gm-Message-State: AOJu0YxS31sEPuFOg9jFBlSMrfbGNFVa/B31ScC3XL0Tx700Q58ZuMIB
        Cah7weQP96WYquJd1WA3JciWj2r8SdrBgyl581bzwg==
X-Google-Smtp-Source: AGHT+IHapu61k/+dzeXeoG1G1LGF4dkAXauoneHI172ue2d9w4N9hPNCW2IQPORS3D5ezqvX6UqN5w==
X-Received: by 2002:a2e:b0ef:0:b0:2bd:169e:3817 with SMTP id h15-20020a2eb0ef000000b002bd169e3817mr3926949ljl.41.1693669563367;
        Sat, 02 Sep 2023 08:46:03 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z12-20020a05651c022c00b002b6dc35da95sm1229755ljn.139.2023.09.02.08.46.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:46:02 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5007f3d3235so144376e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:46:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3b2c:b0:500:9026:a290 with SMTP id
 f44-20020a0565123b2c00b005009026a290mr4608993lfv.9.1693669561847; Sat, 02 Sep
 2023 08:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZPMdTJ7zwrCkdMTu@debian> <ZPNX-jZAZbebizXA@slm.duckdns.org>
In-Reply-To: <ZPNX-jZAZbebizXA@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 08:45:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha+VT3yC3BKS1046GpuH2JRPER+_MXVu_Z1V2K1Ja6Dw@mail.gmail.com>
Message-ID: <CAHk-=wha+VT3yC3BKS1046GpuH2JRPER+_MXVu_Z1V2K1Ja6Dw@mail.gmail.com>
Subject: Re: [PATCH cgroup/for-6.6-fixes] cgroup: Put cgroup_local_stat_show()
 inside CONFIG_CGROUP_SCHED
To:     Tejun Heo <tj@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sept 2023 at 08:42, Tejun Heo <tj@kernel.org> wrote:
>
> Sorry about that. This should fix it. Guess nobody is building linux-next w/
> !CONFIG_CGROUP_SCHED. I'll send the pull request to Linus soon.

I solved it slightly differently by moving the whole function around
rather than adding yet another #ifdef.

See 76be05d4fd6c ("cgroup: fix build when CGROUP_SCHED is not enabled")

                Linus
