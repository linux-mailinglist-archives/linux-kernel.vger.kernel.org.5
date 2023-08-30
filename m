Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0D78DE77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjH3TDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbjH3Hnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:43:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EECD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:43:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-792975085b2so117645039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693381418; x=1693986218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGGarPsIuAKKUhNUS4INN8GZ8o0SRnTpA7kSJCMs1/s=;
        b=DHrBXITUV9wBA4JNdTUB1FY901uegtIQWydZojf3QsaYsY2E3DO1Limi/QjXsIo81x
         dmYthrDy5c1G30mQrbekDJlqgIFMKoo2sj2c+1Nbg8TD2hL1qcaXfgHsFD7RJZpMYPq+
         AP1uGOV+XBS4cvtX7LDrnkj/bYwdiOinZUmB97Y3DPjQDwgBFG5ATbL052MvF3yB/B3I
         s+MdhkvezQLTTPnsbfCBX76Wyz2PZJ/zPBTlqmJ2OMVa4p/jkHsSmlffzwr/sC9aBT7U
         hFh9UZ6HfK3bW3mvD4G4Kv1yrTOUjanVQ08r6Vxb9aBz8PBRgpRsyZKi/xArOHd3iyQb
         Mibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381418; x=1693986218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGGarPsIuAKKUhNUS4INN8GZ8o0SRnTpA7kSJCMs1/s=;
        b=lxVYCKwPszHmtH6G+nUZhfVarg1eCmL+LtNWQvA8JTxoP05cos2OyCAyMtWF/tEkPH
         KT2YYyMfsXNnzYxeLfOuc7v19mCzEFi2lZc8sqWwTETPIE2Cw47iFaeAhITQrTKNEi4W
         4ZT2g/3TKbCpwW8VRuy+whqzQprKH8WUhbT/EaHBobX/k33gV2XbDUq+OXMCz3niYlhE
         mdWAgbt1AVu1+MwYIWPvk42JdrH4xoWDDuDfCONVcY8DfKweVHn3A5g9NCSPmc5HSwJV
         GLq1F8yaMqbp/Vyx5Y+XA2+K+KXFyFckf1d9lxPYg7nTN8jttx+uwWzcszkd+4ygBAnS
         Wmmg==
X-Gm-Message-State: AOJu0Yx6m+NXV8noyz8FTNmvL61FDi7lifMp9pF2T0GIrWngPW5tGQua
        4heftqfsrDXFZn9pRJwWOVnlrgI4EISLGlKK+YghXQ==
X-Google-Smtp-Source: AGHT+IE41ncp3MrOk02KPS7SxVmXh2C3T3tw0YH5ouLwJwMza3P4sWp1465YmAYRpaVNWxDBMkmD7F1z5ISa+YfWcZk=
X-Received: by 2002:a6b:6112:0:b0:790:f733:2f9e with SMTP id
 v18-20020a6b6112000000b00790f7332f9emr1585375iob.13.1693381418668; Wed, 30
 Aug 2023 00:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <eade4ff3e44769fc172e782a829853127c644737.1693328501.git.andreyknvl@google.com>
In-Reply-To: <eade4ff3e44769fc172e782a829853127c644737.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 09:43:02 +0200
Message-ID: <CAG_fn=XjBhiYadLE8=tqHJpcqSsdh+e-=+wHK8=8WddHZxORtw@mail.gmail.com>
Subject: Re: [PATCH 03/15] stackdepot: drop valid bit from handles
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 7:11=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Stack depot doesn't use the valid bit in handles in any way, so drop it.

Good catch!

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
