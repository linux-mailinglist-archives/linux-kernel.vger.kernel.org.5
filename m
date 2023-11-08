Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9D7E5F59
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjKHUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:45:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE02132
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:45:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso30156266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699476335; x=1700081135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awG7Olb7pC1wEJXiajE9JdlOzQimXXsb3BWKke0OpeM=;
        b=M5B7/zsvisxi1npfCU6G64Ns1OC/VLzSr0ISweBPqeg38eVbc7B69HnSefuQe5q9qv
         tC+vWHPO91GS94FDoxGg7Kdr2M2KrGa9kOv/9n03/V2YksfGhOT5EgClVGc9tocjl6qA
         k5l4BD0xIx1YJIH606FnVa+9bV+bYreEEnI74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699476335; x=1700081135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awG7Olb7pC1wEJXiajE9JdlOzQimXXsb3BWKke0OpeM=;
        b=IR4iIDbgbnaxb1ymGad4l9Ac5t3rQY5yaD1MbVFtxS5hSIuvZG4wYTdJLJkVmyw5v8
         UDl7DNu0ehK/6Pocf8C5G5SDkv6/uf9/lB11RSQUgiNw9B34vZRJ4D94ZF3SrFmMCzLD
         fpvr58TsyYKZSbKVSYWlbvl33NYHoDGFEAPT/iQTks99Pze5f77dJ7lVPs4Wk2wVZ5xv
         wC/seI2+3KbXYiQH+a9lommYrKZBwub3mkr49R65QE0qavP9YpUF/QLRxQ6vYb7qsr77
         NyPWIsvSUdfzIFM7jnxpnvMVGiDm3G2pnOL1yR8I3pOfrleq72j4WVn+SgYF8fsj3uha
         /2LA==
X-Gm-Message-State: AOJu0YzD3OLj/hltfQxk+5qQFXrzANElz4jhROKo4bXV0dbSPia9SsQO
        +x0ou6+qybX8NBTlRMgbLHVEX+J6Oic8NxkfdJ6Ilg==
X-Google-Smtp-Source: AGHT+IGtlcy2I8Kq8EkXb+CliLviFLzomguepqwOU3n8Qo6IjUJ2ffTyMLeTIAPaQfbvVa6CxlNJ+g==
X-Received: by 2002:a17:906:4fd5:b0:9c6:19ea:cdd6 with SMTP id i21-20020a1709064fd500b009c619eacdd6mr2829533ejw.50.1699476335024;
        Wed, 08 Nov 2023 12:45:35 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906134d00b009ca522853ecsm1575231ejb.58.2023.11.08.12.45.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 12:45:34 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9d224dca585so28000866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:45:34 -0800 (PST)
X-Received: by 2002:a17:907:7247:b0:9b2:b152:b0f2 with SMTP id
 ds7-20020a170907724700b009b2b152b0f2mr2305890ejc.10.1699476334255; Wed, 08
 Nov 2023 12:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20231107-lists-lf-org-move-v1-1-b19b499a93fb@linuxfoundation.org>
In-Reply-To: <20231107-lists-lf-org-move-v1-1-b19b499a93fb@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Nov 2023 12:45:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7TrK=kb9ZTEh4Cd+AOkY+ZBvvARsPy-xHyugU5eKMiQ@mail.gmail.com>
Message-ID: <CAHk-=wg7TrK=kb9ZTEh4Cd+AOkY+ZBvvARsPy-xHyugU5eKMiQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update lists.linuxfoundation.org migrated lists
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     virtualization@lists.linux.dev, acpica-devel@lists.linux.dev,
        bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 12:00, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Normally, these would go through individual subsystems, but it's one of
> those one-off changes that don't really bubble up in a natural way. If
> you would like to pull this in through someone else's tree, please let
> me know to whom I should send this instead.

Oh, I still take patches, and this is fine and makes sense. Applied,

                  Linus
