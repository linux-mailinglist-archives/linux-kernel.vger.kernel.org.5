Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893978DF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjH3TJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbjH3NYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA091A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc87ded50so34575465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693401887; x=1694006687; darn=vger.kernel.org;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cS6Q9Nda6J5ktOOJj5rlj7vp4gloDffAAQTkHig3BuQ=;
        b=XhhiBOM9f+rNExsYyYAfsZrwVAlOv3MBGaRzZ17i9/Zj/BBh7SpgWdcAEST6V5mhWy
         EIOQlwPhQIO2R8a4rETNN0YI5cQngO+nw7zw9lR/mNM8MyRT4VzLO7UNI+VsMSp5bCTK
         qOwKkmyn/6RB1eFvrQPVt9LBxcCwSVNTNEMUFSWpwoArqP5V20u+AKlr0fSgq528cXw3
         y2gmfOKaBerYdzhej1srj6IckQ+tPyGnzLhq48tNwoBFi/R52s9uS9yeea3/LZ9i3f3m
         CyL78dknVWr4ERzpAA7jbPY6c0BOGg5+mp43/nR+/vhYYXeEd5ZmjNXhPcbBZsf8kp9L
         WXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401887; x=1694006687;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS6Q9Nda6J5ktOOJj5rlj7vp4gloDffAAQTkHig3BuQ=;
        b=eYE0MjSN2Wy23vz8Ky44Srp3Hg/rjxVe+HHDmSRegc+OmxuA3VyRJ2ixrQVEZsFVW1
         aUwYCvlZa5uOiMG34lVji0yYa45ayeY+SBIGxmm2akDKjePl3m1ZFnjjrWVPT29gsliW
         ZW9G8/7fRRDS+6Aafa3U1Ec1Cut6qBjvr4qm5I9lbXlwq2v0DMO2ksFHfQ5SQt/p9OwR
         KbrJqg+ej7FPcJ7w3Y9AF3m09rE7ogVeX6bYXkE9VXm2SuZneZThW1RBtTsDRT3zMuEU
         /txx49coA7Uzly5GBoazNIGvM7wa9OKoVL1b8M5O8EK3ilvZ7/sbLnjptUD2xvjofVk9
         m45A==
X-Gm-Message-State: AOJu0Yw1rO15B4jUSd81GtCoFGyn6NCkrKPI+NmKOeTOYo8Ph2GKprx/
        0bPZ00NiZm/HHhwf2vXaPwZGxg==
X-Google-Smtp-Source: AGHT+IGW5G1y37EAqJFJzOnhtad780Rl1Is3xQMmrx5OuV3OLnESR1H70dQS/JXhixw9HWX9IZgKug==
X-Received: by 2002:a17:903:22ce:b0:1bd:b8c8:98f8 with SMTP id y14-20020a17090322ce00b001bdb8c898f8mr2328919plg.4.1693401886986;
        Wed, 30 Aug 2023 06:24:46 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001bdb0483e65sm10980620plb.265.2023.08.30.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:24:46 -0700 (PDT)
In-Reply-To: <20230725053835.138910-1-namcaov@gmail.com>
References: <20230725053835.138910-1-namcaov@gmail.com>
Subject: Re: [PATCH] riscv: remove redundant mv instructions
Message-Id: <169340187984.2480.1255424893144645227.b4-ty@rivosinc.com>
Date:   Wed, 30 Aug 2023 06:24:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 07:38:35 +0200, Nam Cao wrote:
> Some mv instructions were useful when first introduced to preserve a0 and
> a1 before function calls. However the code has changed and they are now
> redundant. Remove them.
> 
> 

Applied, thanks!

[1/1] riscv: remove redundant mv instructions
      https://git.kernel.org/palmer/c/10f763532d58

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

