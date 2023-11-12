Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB67E9232
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjKLTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjKLTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:14:53 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B72582
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:14:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso51430547b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699816489; x=1700421289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u8Zu/4Nclk+G3sJJf3mP2PcsPtSmnzmZX9K/gDNJ8Y=;
        b=WuCktuL7LVuu+aQ50oe6iRyta+2KfHdOaIZpTPqep8Z2H7I9CLlbfm15HQ0zjVvSwr
         D7cOnyFOgAmydcJEEwROZrMheLqfqa9paF/PzZbPpKwuShi9aMBc7laNhudj9QtjvnF7
         E7qUWNv9yJPNE2M82KnzCEl3tGQU0iNGg2/vak0+itwXww546BEVLTiyBGxpy2LK0FGW
         SIroUQkkP1SD5w677hqzbWtPgCMXNMJiYcZPgfeJTtEbixIT6TkZBXkbA7B3R+aQdBpo
         1BC+19GGH1/oKbqJ/s+KV4EKMqn72BmapKivfAVWhayymehasMVjqGkKbKJsCJUw8QF0
         gdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699816489; x=1700421289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8u8Zu/4Nclk+G3sJJf3mP2PcsPtSmnzmZX9K/gDNJ8Y=;
        b=MWWEpykPG/tsV7sYr4S3erX+Zq7AaEb4wr2JEnvPTiopFhI/A/B+BdxB8uXCDhc4Ds
         dZKgz6JmS8Bi7GDlEN3rkrrsu6pcykZ2jiGNAz6u5NSx898OlmlBIhRfkmcnzLpAKwCe
         GYe1RNsca9KCnXlaCPZYcluzgxxE6KWe5gU9oMD25WRw3r1wOI5bdMJMjlMqucT1/MK8
         VTtmmlkbz+uJBeDMA3lWGpZ+BjUcEeI01C6XN0kGL879VTaC2lUpC4I9J0Vec2RGxWVy
         XBOxfUEc6ePqp7DRdo8MFFp0+5HcZXVEeLz++V52Dq3B6pEl2JCyzRdLAQpWu6UbhiVE
         QavQ==
X-Gm-Message-State: AOJu0YyIqZqXwM9vXa3jhr9nIEJU7ZM8CLJcEJpvXCn2ZRZcPitVLz7O
        TF7/CveaAN90kSn2WzfQ6sHlGpU=
X-Google-Smtp-Source: AGHT+IEsdrSkurmFg7TNhtoBzQzZs8huZFDWlP65Cvd430M+9iQXF6DmgEgkEv6nV0lbQoiDoQEWfIE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:7644:0:b0:da3:a4ae:1525 with SMTP id
 r65-20020a257644000000b00da3a4ae1525mr122969ybc.5.1699816489316; Sun, 12 Nov
 2023 11:14:49 -0800 (PST)
Date:   Sun, 12 Nov 2023 11:14:47 -0800
In-Reply-To: <20231110175150.87803-1-puranjay12@gmail.com>
Mime-Version: 1.0
References: <20231110175150.87803-1-puranjay12@gmail.com>
Message-ID: <ZVEkJ9waaH9X11GR@google.com>
Subject: Re: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
From:   Stanislav Fomichev <sdf@google.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, Puranjay Mohan wrote:
> MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
> bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
> operand into a 32 bit operand which is equivalent to a normal BPF_MOV.
> 
> Remove this test as it tries to run an invalid instruction.
> 
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com

Acked-by: Stanislav Fomichev <sdf@google.com>

(based on the fact that emit_movsx_reg doesn't handle 32 bit case under !is64)
