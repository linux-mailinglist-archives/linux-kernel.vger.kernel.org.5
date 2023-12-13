Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39F88078D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442805AbjLFTrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLFTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:47:40 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB3D46;
        Wed,  6 Dec 2023 11:47:45 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4b313cda01cso54708e0c.0;
        Wed, 06 Dec 2023 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701892065; x=1702496865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3Uq7Eb3LQAhmgOwGxl2uUmTACv20Da6IjMtrl5hh2k=;
        b=Tg4mUD4Uduc4OenqQ/cF1Fwxb2AawTvkTDuOkJ9NOr30g8gFTWSgHFEzrvn9OTEJso
         k6uKZLU6Ny0oxt14j+VYVNLJo6crcBPgrEWAzYHV76yDLrTlz2b3kRK5bUIbIsaWFIfg
         mugfPS970KNHKcabe8uGcEA1w772jUnpmLIGYhecZmdDrsep8v3j6nK2LLkW1f4X2vUw
         Kxwqvf4i2Iluy0CByuwFurAE2Gm6IzcDc4Ax4+vKeiJXR3J6iLgF873xJuhO9xkEOzsa
         Dw59SXI5nYYnXuaMhxCbhHfEhWNWnwgzNbHEfzbVrrS+p+knRwqJYXz58JIAAy/a/EoN
         r5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892065; x=1702496865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3Uq7Eb3LQAhmgOwGxl2uUmTACv20Da6IjMtrl5hh2k=;
        b=HYpK6pPeSNXcS/JZX+O4L9gxbO1InWuO9Aylht+IDp/WbPZxr/CBqJcZgxRjgJPs1E
         EWsjRZVvIavhyjIfFQeIt+ClXE2UliOv0XcuBMSMJpXIFushmMSSZaUdsPRKkv3ZDQmF
         qOds686zDDr/FSH2U1wI6l6AGH1kcktv6b3bSG8brx5DkJ6hP4NAp8KcnwtPvS6CvUNO
         E30z9ebe5HTD3zw4WYwZg2k0Mv2ldYqNkL0Hm7XCt2obn8brotJiu41rdK7H5cmbctfU
         e+zMxaEn10vG/eAiXHfVHkHmvCHrMTbGGtaZkZ22RTlSM0bEgTA5FTzf5PV1ruOk1164
         C+Pg==
X-Gm-Message-State: AOJu0Yzogesvm+M3NXTLbRfpkl1Mbci8ggVK5ZG93kMZ2FeC7fl9vmoJ
        iafRGEL/TtbR3/FSGHH0yYiDs0Q+c/X8tMeYsw0tNbokSIE=
X-Google-Smtp-Source: AGHT+IHYl1yzcNVSMG13aCy+iy0WYAPTgpbzn6h590/aczcT1C5kVNrn6NnMKuR9NVMHNIVY9l96rBQikhUQLjE3ruQ=
X-Received: by 2002:a05:6102:5106:b0:464:8ba6:2a62 with SMTP id
 bm6-20020a056102510600b004648ba62a62mr1631158vsb.28.1701892064936; Wed, 06
 Dec 2023 11:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev> <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com>
In-Reply-To: <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 6 Dec 2023 11:47:33 -0800
Message-ID: <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Chengming Zhou <chengming.zhou@linux.dev>,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>
> Hmm so how should we proceed from here? How about this:
>
> a) I can send a fixlet to move the enablement check above the stats
> flushing + use mem_cgroup_flush_stats
> b) Then maybe, you can send a fixlet to update this new callsite?
>
> Does that sound reasonable?

I just sent out the fixlet. Yosry and Chengming, let me know if that
looks good. Thank you both for detecting this issue and proposing the
fix!
