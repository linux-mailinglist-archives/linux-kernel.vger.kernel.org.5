Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4978FB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbjIAJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348991AbjIAJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A61BF0;
        Fri,  1 Sep 2023 02:42:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565f86ff4d1so1234989a12.2;
        Fri, 01 Sep 2023 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561350; x=1694166150; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxbsY73eqE9chY2EX3xsnlO4/jof06x9cIh9+N32rEY=;
        b=HNB/aH1c4x834q2vF0ng0vziVl/fcqks0YyymwNJOjlM++dKv4EI5Qv9cOtrPhNa/w
         5zF/mtbkInArjsOnDePAI9IZvAac8+OuQ1D6w8maW5/VV6FNY0bIDNavomO0gHKBe52M
         h/84MS4M34cCsTG3uu0GgGrLQJtab+eKLrBlLsepbw38fae3aWiKmYL7QZM5Fw65FLnt
         cgOchdiP7LGeKgXuAAHXhfxmyH4Fa41ougKH/koL+5Jkqjh4ACBpqS5jWkw1Sm6GFMnA
         vlSrGZRgjVLA+e3POX+XPCDLMjuP4FKDaWzCLiJiIc88n8fqFu++5sJZqzf0c2c0Kfcx
         NOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561350; x=1694166150;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SxbsY73eqE9chY2EX3xsnlO4/jof06x9cIh9+N32rEY=;
        b=drzRe5v3XAs6+X5P5spzwOM5ZAaMhnVz3A9Vc1kF7lh+zKPK0MKf5Wtqrvm7dRRxKP
         6W8OEa+gIEbr2HvTcjDQJvYTSobJGfbbZD0ncLBgM//gNvehnR+XHyRC2JV56IUcvNy1
         KeIRHb7RdJ4uJFXAi9XbccuftlEsHAdf3d4QeZeLxkvx9xOb+CfsLbqkapaBO7ihziP5
         0t0yY0KHGGE64oVQ+DJeHjqQz1YxeBDc1EwrHHZmtXiLT7KffquCzs7aQxkXJMKT7r+Y
         V2iGUMtD3fBrKFBoBCoJBXFQbnb7TuBU406p60gEx14y30B4WqjANmYAZz89KqYtpwMV
         awzQ==
X-Gm-Message-State: AOJu0YxayOetU3fuoHoNrSDxkRhnhaPj9t+uIcKWFEpALpGq0t9iYLtY
        Jwahe9kUZ4NdShuRgLeVAlg=
X-Google-Smtp-Source: AGHT+IEZzAhARyVFBvaiXDdpznBROrWDzsHD5p0QeHfBpniT6ccOViVKaS0K8DiuKFWyEJKOr2ZJpw==
X-Received: by 2002:a17:90a:bf8a:b0:268:b682:23da with SMTP id d10-20020a17090abf8a00b00268b68223damr1677995pjs.34.1693561350349;
        Fri, 01 Sep 2023 02:42:30 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a199e00b0026b4decfe59sm2856220pji.31.2023.09.01.02.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:42:30 -0700 (PDT)
Message-ID: <bede02c1-ef90-8e30-aa8b-e6fae49a8ccf@gmail.com>
Date:   Fri, 1 Sep 2023 16:42:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michele Della Guardia <micheledellaguardia@yahoo.it>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Abnormal battery drain with kernel 6.5 (Ryzen 5500u)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1] that have been already handled
there. Quoting from it:

> After switching from 6.4.x kernel to 6.5 I experienced an abnormal battery drain since my laptop is actually never idle.
> I accepted default CPUfreq to schedutil and AMD Processor P-State mode is 3 (active). 
> 
> I expected a different behaviour, but am I missing something?
> In my boot configuration I had "amd_pstate.shared_mem=1" and tried to remove this switch, but did not affect my power consuption.
> 
> Is there something changed from 6.4.x to 6.5 that requires a different configuration to get an optimal power consumption?
> 
> Thanks a lot for your attention

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217853

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
