Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6A78DBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjH3Sbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbjH3HlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:41:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D6CD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:41:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-792409bc1cdso15249239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693381264; x=1693986064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL07VE0OwJGqoGj8jsKtJTE4qZZ24p0Xdc0kh4JlWO4=;
        b=QuPk173Ww8IkURpJM2JfzFyc8484eiuBzmihR3a0sdAGp2EdC34Atp0kiwSrWIQeLH
         7E2xLsFYrOIBzCv9byaAYV/I2aUkIH/38weNAwXyxtuYco+KcQETL/LYAjbhpmXHy+Se
         e2wVsCs5uUCDWUrSfs9OniForqS1RQcqT2EXf8m/mo7KXUTXIbB4bE0romIvH/vF0+Wm
         2vRJi4zSJLnBd40ET3CL9hng74o1YEtC8sjeb/Iye4u9kjLCi6VcR9KNwgPk5h8jhpeb
         r7+zOx14Xz0pXUapBir8Ua4B0qi+k9ccg/W3dFKSPNpEYrVgij72VmddthBFCJs7EYG+
         wHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381264; x=1693986064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL07VE0OwJGqoGj8jsKtJTE4qZZ24p0Xdc0kh4JlWO4=;
        b=Kl/NIj+fikUYIRspNHEM5jdN+RAsgPFgeZiZAebgV3ol5N20kxDtF+dRRFnHsJl95m
         5AI0revBe0rgikXlYCC5JrUKeVfHoyLBU5bvkLf0ersZfGlbCXTT4wWjXnGmB4YZdAP0
         kQY8ZIqAAz+BhrIaYH4Sm3ITrkzg8sV84OzUfoPsD9Q3e+zKY05aD8O6GtmuM2H7uNN8
         C8jJvzinKr0PYCve5TWksPHJz04AmAmCjRN17eDM1eR5pz14rOIsR2rrSR5BR8thRC7W
         wCsLkPw1ErWiDeFcfyZubl5MuJ07k1s817vQyl+4sGX4ENL25tv8RMeKt1zkyZkTYhCe
         YNuA==
X-Gm-Message-State: AOJu0YyHaODvW/uED59OmM1gqQu8afoCGiOBXSBKpcqHGpkWqQgpivX0
        liWRDUv81z1IOjll2vh0BX+ENumfaQi5zKsbw+K/Vw==
X-Google-Smtp-Source: AGHT+IFbOALw8ruGTw3MU/WR6pkmWmfaKxQYdbfD6Rcwr6aeY4XOBpR3f9UQs7r6AG9q9Z8AgHXr7E1WDmuMxnuBYlA=
X-Received: by 2002:a6b:e811:0:b0:792:93b9:2065 with SMTP id
 f17-20020a6be811000000b0079293b92065mr1294332ioh.7.1693381264582; Wed, 30 Aug
 2023 00:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <43b26d397d4f0d76246f95a74a8a38cfd7297bbc.1693328501.git.andreyknvl@google.com>
In-Reply-To: <43b26d397d4f0d76246f95a74a8a38cfd7297bbc.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 09:40:28 +0200
Message-ID: <CAG_fn=U1GN5TH7Mm80uvrOEhmNUD-65Tyh0qgm-v=w6Bfape8A@mail.gmail.com>
Subject: Re: [PATCH 01/15] stackdepot: check disabled flag when fetching
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
> Do not try fetching a stack trace from the stack depot if the
> stack_depot_disabled flag is enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
