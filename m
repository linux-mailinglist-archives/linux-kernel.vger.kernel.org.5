Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9D77621A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjHIOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjHIOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:11:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BB1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:11:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb7b8390e8so44072345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691590278; x=1692195078;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mIY98ATs8Sp2k6Nt4Ma3culh4Cy5LNj7LG1rUaO2uQ=;
        b=mUSvPNf4SywhNdU0KLw2DVBUXXkzCbKtkpcbJo1jNcgImlXRw1cK/W9dvtgf8L5+R0
         E8fH3jdEK8qnFwyIx45geAkJtGWffjEvnahOytEy6wlANrFhl2bKx0euN0KGVvUlUreO
         2i2eDPVjJDxqGQRHyaPQGr3Tvgm1GswZKHCVdXlQGMTYh7L/6dOnXaQYBA7QJ9qkce1/
         iQ6HGNOmf2a2Dhq11yLTdXbAeTWaD+iVua5GcpyiZjrPpgb/tvEAz+KnGgqPSHJ97HhJ
         0dvEJ2kYpZxwDqeNw3fKn07AvxTWlTRtn1ReSoIhlZNf5RwLO4Jd1JWs4K7fglTZSJh8
         b97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590278; x=1692195078;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mIY98ATs8Sp2k6Nt4Ma3culh4Cy5LNj7LG1rUaO2uQ=;
        b=Ty+DBjKwfsKA8fgL9MXKVxQ8ngOTHgLS46toa5qNE052n7fmtmopjI8rmmi2ayh2Wn
         jSf9j3XuSFQU6b04ktXHOVA5uKtbkhhSn7YFyssFqUWW46olRh1HDWy4WAZsZ/6W93rY
         OZmQ56M9NmOOu10d1t1VeyBsnVh3MMb+csg7Q3bSuWszfwJtXgh6XsUyOwm16COEAqBr
         0RTjK+aYk5lGzByI+Zxt4MgctgebVo03gKzsowsZpF/LyIjIeuo86q97DuwRof5XywXr
         cVud0ly2TiVQq1RjLbdoQ9k1Hle2VS+CBF91mdqjBDtmM+KaQLg5ws5Z36oP3rCaFjMk
         RWjA==
X-Gm-Message-State: AOJu0YwqMETJnomVco4MswHHtUj+0gTTWr50TqfvZPwfAz55ReZxWg1S
        vqIuHVjCESIkNfQwRnf92YM0Pw==
X-Google-Smtp-Source: AGHT+IFwQu4yz7lexZBMwWkILLgIn4eDHexDHimT+VBPX58RpGr/KUCDxSL4aDpoZ3RB8Vp3KOUmuA==
X-Received: by 2002:a17:903:2450:b0:1bc:7420:ea1d with SMTP id l16-20020a170903245000b001bc7420ea1dmr3192596pls.67.1691590278176;
        Wed, 09 Aug 2023 07:11:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b8b2fb52d4sm11176934plh.203.2023.08.09.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:11:17 -0700 (PDT)
In-Reply-To: <20230723165155.4896-1-tanyuan@tinylab.org>
References: <20230723165155.4896-1-tanyuan@tinylab.org>
Subject: Re: [PATCH] riscv: alternatives: fix a typo in comment
Message-Id: <169159026877.18421.6107684619447151446.b4-ty@rivosinc.com>
Date:   Wed, 09 Aug 2023 07:11:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>, vincent.chen@sifive.com,
        Yuan Tan <tanyuan@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 00:51:55 +0800, Yuan Tan wrote:
> In the usage of ALTERNATIVE, "always" is misspelled as "alwyas".
> 
> 

Applied, thanks!

[1/1] riscv: alternatives: fix a typo in comment
      https://git.kernel.org/palmer/c/174e8ac0272d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

