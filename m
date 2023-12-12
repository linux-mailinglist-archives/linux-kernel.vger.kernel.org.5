Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962C80E90D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjLLKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjLLKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:25:18 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F7100
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:25:23 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67abd1879c0so36193246d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702376722; x=1702981522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0bin0YrkFC9aYpdJb7YrobqLtsNnCFlx+bPuCIstk08=;
        b=1YEZPh6PWDgKqy9xan14p1PyG1suuhAGF1UnPu1r8GTUmsfShmCozKAA5Ts0BuMBV4
         amo7e6NCAYMS8JNwF9lI4vCoZFrayzECuZcLJimEJ8Fdv4oSIAMtf3XGNYJhaI5afC1v
         MAubyNNw8hCrpKs6Pis2BzJL1YUZleN9rIGoUQEoc1dOosKCbh3AR/ZNQyqzOqpuolys
         bonjcn/yabyy3mJRvYy5RpElEvKtxC5A4u8FE/FLgEzgtzRGo0aSiYQ1Qdzj4a7jNbLE
         U56qGTJkJWfFRN4xz7RMgVeCJMWHtmPZj2ni03tPQdYMc4ivO4sWP7/Sztn2qyjPNm4H
         3rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376722; x=1702981522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bin0YrkFC9aYpdJb7YrobqLtsNnCFlx+bPuCIstk08=;
        b=DG0aTF3E+5GNQU8EtCkhOrhXa/5X7Gdco6QP+nJPFyfDwFcs625jN6vjtD1Xgi9yr0
         As1T8hznaBFJRVe9ZMcm9grM9L0Qqw39jM9nOSyZAvqYm9LKL41fU17gDReUvIMN7D/5
         YthbwoX1HA9N0TTsb2JQnee7IrgcT1lap7Yz13G8y1cd3j3a4uymax8iekL/zr/M3TOe
         wNMhmeMdqpLSMa+8uJrvYqdYEAU2R4Khb1pDKzQMhcccfG51xpmrqqzZ26TEVPmu8qbg
         Q9t3DhaGZtXqUC4BeXjMSoCI8nTh28EZRwldmIRm6yUgAd7Wd/WzelG9p2HFvVzpXP7Z
         cugw==
X-Gm-Message-State: AOJu0Yz6Oy4IWpR+t5OoUJn3OquvQTow2IATWOiGHc/zTW/0r4iz/vMM
        +TmjrDhhRA1GSY/qT/f6bti7dOpzMA+1MVONEhXHye4Zz0a7OjDjs2CNFA==
X-Google-Smtp-Source: AGHT+IEa5Tq95UBbdXr06Mju2aXrNJnxFPwla/XvRmZFAfJFXKZup/f4qL+bB7opz0u80b4bMkib5FV9bbp0qQ073Iw=
X-Received: by 2002:a05:6214:1191:b0:67e:ee32:3320 with SMTP id
 t17-20020a056214119100b0067eee323320mr230383qvv.32.1702376722584; Tue, 12 Dec
 2023 02:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
 <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
 <CA+EHjTzdKS+ardXUofO+U1vnsOC3QjiJUBuKCHWw6z6zKdVGSA@mail.gmail.com> <20231212091047.GA28147@willie-the-truck>
In-Reply-To: <20231212091047.GA28147@willie-the-truck>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 12 Dec 2023 10:24:46 +0000
Message-ID: <CA+EHjTzswc6Qji6yaTcYu7uc57MFY-79KxY45wFT8tQ+9PEhPw@mail.gmail.com>
Subject: Re: [PATCH 06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for
 DDI0601 2023-09
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Thank you Will.

...

> I renamed it to PAuth_LR following your comment, but it looks like
> ID_AA64ISAR1_EL1 is still missing this field entirely for the API and
> APA fields.

I noticed that, but thought it's more appropriate to have a separate
patch for that. I have one ready as part of my respin, unless we
accumulate a bunch of sysreg update patches first.

Cheers,
/fuad

> Will
