Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224DE78E33A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjH3X1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjH3X1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:27:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5BBC;
        Wed, 30 Aug 2023 16:27:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564cd28d48dso263937a12.0;
        Wed, 30 Aug 2023 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693438050; x=1694042850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWSiG1Av0SGOVCmNfwg8ak2uSd5V4L3YZMCs5wa1VjU=;
        b=B0Hf9HTyskdB7pUziynHnGeceCKocZMjPnlZm2eRurbsv2gK+BOJl2bLGvAIdHAaXY
         +nFRhZNcA6cW2dT508NR+LuheN70DvveKkUC7MqCDb5nqLnj/k2RHouk6Np79jjBOUJf
         QMUVLTiJlO/rGeh2mPeUwgRiSynOKIFVOXcphSDixpAVtQ7nG98BclKlS6UIZxfYRovx
         yQR8JuHXDH2CCwHAHjq9G0z2HBBkIuz5uQc0hzFLSgAvkUtSTQy/ctvadMZYZiWO4min
         RwBYUzpbAQgjYDc88xjXs/CFlg6nQsRGt1OOvege7k+j+RZyk7gYo8bqFBr/gy2iO9TO
         UU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693438050; x=1694042850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWSiG1Av0SGOVCmNfwg8ak2uSd5V4L3YZMCs5wa1VjU=;
        b=jsgnWgNkUmWmAauiDZCURGbieH1+CuX9onotez6udqWrew5e/l4lP1YYkTO/ACyoQj
         YQ+no8iVzNvE5jqJ+5lHikAMX9YaeSKnffF0Ptw87V8nf/TFmEYBxJGpXIFnwcfvSj8B
         715CSJLPjuqEpsjaO/cGGF3I05iqbrGbuIy5VJ932J7oXImtCSYiiS05QopUtu0YvqIT
         csfHI7stAABjlfDjkyLMvMQT15+irMutCo3Gfno/barf2ZEMcMPpygt2DLrnNCh8iQDz
         J4sDs9fEa2lVOeOgy1tdg+K9aRdjQGxTAbNVO4UzoFLxZZrI0VPiMAz44Sdd5RZrrGoq
         p3NQ==
X-Gm-Message-State: AOJu0Yzk/swS+x6m+lEtuSqF2LADBa5JiwGxo0tfReYQH5VIjHG0ZT3M
        MhQoXnjrumkBpVnTkbKrOKE=
X-Google-Smtp-Source: AGHT+IGS+jUQo9PxO2wxI6Fxu/H0FRAiL6/WHrxNIfww1PdXRhYWCf5+SHH4FmTdQj67QkjSoqDfLQ==
X-Received: by 2002:a05:6a21:3292:b0:132:cd2d:16fd with SMTP id yt18-20020a056a21329200b00132cd2d16fdmr4842907pzb.38.1693438050434;
        Wed, 30 Aug 2023 16:27:30 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-82-184.dynamic-ip.hinet.net. [36.228.82.184])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b001b672af624esm41059plb.164.2023.08.30.16.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:27:29 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        minhuadotchen@gmail.com, rdunlap@infradead.org, src.res@email.cn
Subject: Re: [PATCH v2 0/3] convert TW translation sparse.txt to RST
Date:   Thu, 31 Aug 2023 07:27:25 +0800
Message-Id: <20230830232725.5655-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87y1hvyp8x.fsf@meer.lwn.net>
References: <87y1hvyp8x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
>>  .../{sparse.txt => dev-tools/sparse.rst}      |  2 +-
>>  Documentation/translations/zh_TW/index.rst    |  2 +-
>>  3 files changed, 42 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
>>  rename Documentation/translations/zh_TW/{sparse.txt => dev-tools/sparse.rst} (99%)
>
>This series doesn't apply to docs-next (the final patch, in particular,
>is problematic).  Can you respin and resend, please?

No problem. I will respin and resend the patches.

Cheers,
Min-Hua
>
>Thanks,
>
>jon
