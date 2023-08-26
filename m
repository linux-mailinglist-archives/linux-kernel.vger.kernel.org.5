Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F96789648
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjHZLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjHZLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:25:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC572123;
        Sat, 26 Aug 2023 04:25:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so25487691fa.2;
        Sat, 26 Aug 2023 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693049132; x=1693653932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7q9dBWc81QA1pa/uzOif31Eyr0SsHNs9yCw/zf7Ygo=;
        b=naL2RizsHkPl81Tn7M8FOmAl9U7H/P2uC5hoXX9gkpE1RzukK9ZQX7oW3Gca7QtL0r
         bqDXOFgFHW6FKtGc+I7gOYLD6H1JxC+bV0Jl3pmn5JIxVc8v12qTKPTH791hgNJURaLW
         Ri3/wI2XbvrJS2D8HaF50tofAySosTVqaPJmG4Fn6+yQkBGJO6JH34loz2xeK/IM1YbZ
         lhdfDdr81cpMXwWgE+uZ+RpUZ8zx+Es/BGso2yqfiFPZDqxC/Ua8tcydMqVXpngYLzQg
         KwknZlQTcfYjUZDRRR9bD7OQKk3ht+HHXOn1Ekg7gPPiN6FVEvhm0ptuVpzxZ9pn6qly
         SEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693049132; x=1693653932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7q9dBWc81QA1pa/uzOif31Eyr0SsHNs9yCw/zf7Ygo=;
        b=jSto9URzdBj2BztMc10buYCqATe1DOj7WJgxtTEItMM5KOh2scNirZmvO61EgLqQsL
         MGQ8qJILaPmQC6rG0kGTCc4umCVvHVIgbF+iN8es+wCUt2ejR0CB7/6f9rPGdxw5dPfU
         1EGPPX24DZv8DCeMRVPHgPXKLu5XebJMpr+fveMU+ykaQ/D1dXir0/YBzP3wOWntgkBm
         9zGtkBLwCoOG+TmviYY9G5NW14s8tD4ZTXmKLJhPGN8gyO2fjCZWcsdYnC5rRoMEceNc
         rvUGZQGra/eX0Wk3MtnLJkgHFZqu2nZB8HTi9n0ZmdG0Ggzvv3fiKOB9vSKS4wPqohOz
         /vIA==
X-Gm-Message-State: AOJu0Yx6txYvIu3Bw5eD/2mfSgSDKSdKDlj8Bh0PPEMjRuuCf+kiPDl2
        2Euz/8YU/2YPiZ2YGd2oB2wVGKDebavymQ==
X-Google-Smtp-Source: AGHT+IHa1RBHeNuoBKWE4UageeHtiPeJkDemALQvIrHv67GOVFom87yOULnI/u0HmGGkixDme02t+g==
X-Received: by 2002:a2e:7810:0:b0:2bc:e46d:f4d0 with SMTP id t16-20020a2e7810000000b002bce46df4d0mr5668480ljc.2.1693049132260;
        Sat, 26 Aug 2023 04:25:32 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a2e9b09000000b002b9b27cf729sm758451lji.52.2023.08.26.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 04:25:31 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     badolevishal1116@gmail.com, chinmoyghosh2001@gmail.com,
        linux-kernel@vger.kernel.org, mintupatel89@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, vimal.kumar32@gmail.com
Subject: Re: [PATCH v5] Common clock: To list active consumers of clocks
Date:   Sat, 26 Aug 2023 14:25:24 +0300
Message-Id: <20230826112524.4134627-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
References: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for disturbing. Just a gentle ping :) 
This patch looks abandoned.
Is there any chance that it will be reviewed?

Cheers,
Maksim
