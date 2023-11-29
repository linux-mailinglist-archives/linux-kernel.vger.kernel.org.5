Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADE7FD16F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjK2Ixf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjK2Ixc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:53:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0DAF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:53:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce3084c2d1so53761995ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701248019; x=1701852819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZFL/pJqMhpdz+PJVA0CR6dasqvtUf0OfCGJuaJanG0=;
        b=TsFFEBYgYUs4tt11UJUpgyUTCHSlissBU/jllOjSKxxO62XeMgbHhKAUXidf1fviMN
         iiiF2SOqaigkchH+5vFIzW9xAzOSlzwObVVzdf2nPSRoFHY6CJ+O1n6HcOK2p0fC0Cao
         L3dzTOIW6V1YZ5NAgdeU9rlUGAeubWL+hXECmA7yK8U5UT9aScliMl+KTQV/bUQ/slUa
         mQUcVEg+cjYRpbbQP+kwV7vER/hI4zOClAR22iAucE0yxe5mPq3LQT45vgxArrYVnLN4
         Z5Vbsb/A3qSUFSFPvL2hbuLkyRKqZIUGbZDtydaXTJaTBc1O5bNWNybzE+jwg2j38swH
         4N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248019; x=1701852819;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZFL/pJqMhpdz+PJVA0CR6dasqvtUf0OfCGJuaJanG0=;
        b=CwCzGyPI6+R9g+GxJVgzYGmh8H4AKVTclySfxjTt8ko1G6H4h0ECMOA/jORfSP5i5E
         +fpFu8cFwsNOzT8ZxHEBEET5N/EEN4rdqVhl+GhP1kD56jRdgrECcL0y1SBWg8tYrFl2
         jlMLc2YAp0/nkwhgaJJccneUsNjtTtP1vs34bnxKsp5UHXlfmD0Cf64CtxgGc+ir1rTu
         W/MLAJ9BJJ+a9IQbDtl9neZYj75qgOPUNykCEC9Pp3QNY9uI2uIl+w5sG6gdD9YR9c8T
         LTufMdoEIKtRmVGr3xboMqc62B8LAv4h+5UZmS2BwslD+hAK9y/LpVa5/41JxNnQeltw
         kL8A==
X-Gm-Message-State: AOJu0YyfmNmcqA1LhIUlL+7ZnoiHs4ILL6lc87k97eYFU3oLrTazRHdP
        TJrF5AC8X4O4iV4H9M8QpI0qxgZiQQC3vVLhS+w=
X-Google-Smtp-Source: AGHT+IEj27MggbDEWMD6Qgaj0TytaMyDbWHfZSPfwi5SJnN4F45OBItU1oS8iLXGN3/gvMOm6Gox+Q==
X-Received: by 2002:a17:903:183:b0:1cf:6590:70 with SMTP id z3-20020a170903018300b001cf65900070mr23121910plg.23.1701248018961;
        Wed, 29 Nov 2023 00:53:38 -0800 (PST)
Received: from [10.23.169.155] (014136099212.ctinets.com. [14.136.99.212])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001cfaba4bfbdsm9174434plk.83.2023.11.29.00.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:53:38 -0800 (PST)
Message-ID: <76d535f6-f92c-4564-aafa-290042cf76a9@gmail.com>
Date:   Wed, 29 Nov 2023 16:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Benjamin Tang <tangsong8264@gmail.com>
Subject: [RFC] Core Scheduling unnecessary force idle?
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tang <tangsong8264@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm reading the code related to "core scheduling", I have a question.

Say the RQs in a particular core look like this:
Let CFS1 and CFS4 be 2 untagged CFS tasks.
Let CFS2 and CFS3 be 2 untagged CFS tasks.

          rq0                      rq1
     CFS1(no tag)     CFS3(tagged)
     CFS2(tagged)    CFS4(no tag)

Say schedule() runs on rq0. In the core-wide pick logic, if I'm not 
mistaken,
the end result of the selection will be (say prio(CFS1) > prio(CFS3)):

          rq0                 rq1
     CFS1(no tag)    IDLE

Why not consider trying to find untagged tasks for rq1 here?
Is it because it seems less fair, or are there other considerations?

I would be very grateful if someone could give me some suggestions.
Thanks!

Best Wishes

