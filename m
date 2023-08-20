Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2609781F76
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHTTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjHTTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:22:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529A1BC2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:17:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3159d5e409dso2336569f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692559020; x=1693163820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8tmHG4iKjop6oaRZJCRny7Ii8bbirFNeHQwN4qiWd0=;
        b=LRJNqb63H45H5c6VdWdiNavvlbuXHFoNkkYYndXMMIeOzq8cU8HoXOyiXbCC7fAjSD
         CJdob94BYUHO3+3UohhOepgf/kGyWxicpH3BgxgWoaDJSMaRaKrQoDoXbrgps3b8bSL+
         SrcVMDvRrsK7dIjY9qn6n3aD+I10DdSm+Vad3CsF88wETXQFCrfTT3nsFu1cFmwirw/e
         IpDijPIORXriNaw8HoRuvwiSmGRJLeTEovxNz0pmC7yRCOmgj+kYObbYvP6qD4ZvpkHz
         Uqm0s40DqeBi4Ba3LrxCQNVfZaUCbqnBsU/u2KD9mOiUzc+TfOhfh4mlDrIZXn3KvEfT
         jgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559020; x=1693163820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8tmHG4iKjop6oaRZJCRny7Ii8bbirFNeHQwN4qiWd0=;
        b=hpMFqR5FpcVlDeVz5O7xl0OTciVM5NeV4F3trq/TJk3/d+opbkrf7PqzykZ1tQDAJI
         41yJKRYHj2QOdYVCRp9gt9rboD53CHjLlf+tJGFrxmUuv+nwT20l5a2W9iJBxPMnnBji
         ggbGIN99iP3gvRAqvhs+aZHLc4HKKhcB2LZscrRbYeFWoR1RO8+QeG4w1XMQD8TGvNPE
         72rGcDJJXTNEkuFpfmmRckl/+2+fW+fiCNF+7+TjMF2BGddzm217MyS8xkNUrKFn2eM0
         DVWPmQEp/9TEVYwsQ+Qs7zhhIfSZIKuC/TxuXSXBspA8ZgUthNP7hbzb3dlemvN+aOT1
         yZyA==
X-Gm-Message-State: AOJu0YxeTa63N/wZiViRAua8P+ezVUdrFiHFsg5w5Z7Ki2TCtkiL94yo
        w2hf8LrCqyDXMICsCUt22h8G9w==
X-Google-Smtp-Source: AGHT+IFGC/mjVRpF0tS2ezanULq7qQN5KU1nu3cC6II4FY/Q8NBzmL0Tc1d0uWFWxLjgVZomEoQGHA==
X-Received: by 2002:adf:f9c4:0:b0:319:7abb:4112 with SMTP id w4-20020adff9c4000000b003197abb4112mr3930024wrr.21.1692559020165;
        Sun, 20 Aug 2023 12:17:00 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b00317f3fd21b7sm10125665wrv.80.2023.08.20.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:16:59 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/2] Backport unlink misfit patches into 6.1.y
Date:   Sun, 20 Aug 2023 20:16:48 +0100
Message-Id: <20230820191650.532978-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoupling misfit from overutilized better helps handling misfit due to
uclamp_min only being misfit without triggering overutilized state, which is
bad from energy point of view as it prematurely disables energy aware
scheduling.

The series also makes the search for a better CPU under bad thermal condition
more comprehensive, which is useful improvement when the system is under bad
thermal condition.

Backports to 5.10.y and 5.15.y is hard as find_energy_efficient_cpu() is
different. But it applies cleanly on 6.1.y

Compile tested against various randconfigs for different archs.

Boot tested on android14-6.1 GKI kernel.

Based on v6.1.46

Original series

	https://lore.kernel.org/lkml/20230201143628.270912-1-vincent.guittot@linaro.org/

Thanks!

--
Qais Yousef

Vincent Guittot (2):
  sched/fair: unlink misfit task from cpu overutilized
  sched/fair: Remove capacity inversion detection

 kernel/sched/fair.c  | 189 ++++++++++++++++++++-----------------------
 kernel/sched/sched.h |  19 -----
 2 files changed, 87 insertions(+), 121 deletions(-)

-- 
2.34.1

