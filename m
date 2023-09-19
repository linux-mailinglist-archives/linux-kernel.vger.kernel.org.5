Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025E7A68AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjISQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjISQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:14:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6379B6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:14:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7927952ca67so202761139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695140071; x=1695744871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCIcJHAWFPOLBSbECabbg7duQStJvSvwou+mFA2mS48=;
        b=SDUix1ALmdNyYCWtpAVtZXaXiIgqkTSBP5c9sSVembi9iDrnc9N6TpvFq/vcDvF4Kw
         94Jzb8VZuuyvATGwZ9TK9eNw0vHZe2AMzmSf+pPAC6hFMxOBuqA9+yZfcT/wysrba5t/
         7hS0TPYHJ3EExsP1Hu7gT23uFXqw7nsX0benaRU5u00ULeEigvRQN7pBwzF6mJRZ8Rtq
         17vZsVtOaNAFeYUYvSCcue+6Pnn09U5Oqb4j+lDdLqrMPhqcrWjPWv4Jf0HMHxK56Yug
         S8ryEnefZzOOFKXm5hvltYIqYZxFgx+uNjA6cxfcBH45UhuF3jA3yRQne1nb/zEle9fS
         xNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140071; x=1695744871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCIcJHAWFPOLBSbECabbg7duQStJvSvwou+mFA2mS48=;
        b=Qx+aKl5tqBZCYZPtAMugNfo823KuAcTZgMq/rhsU8oXw5N/mr1Fx9SOcySl0UUxP18
         889RqDTjO8kfFO8sUXktfhwPRqdVrN1oJmuXRnObGTLHpqPAYpNLsCzF3wvBPxlweWje
         j9T5lPnIAjeTxqU2H9Lm7W7lMVolWfYUT/mCudfQNvs5xlc9hL/rBfjO1/ZObb89yGN0
         XDkv0kjC3FQATvtB/dz+ZCeTvbzOMpuMQSk5XrmsOY+oPdCdQQQ1Jqq1VA6zxIfztCvC
         S7lqd9PK2QWdATGRrc0n4l5Q+j7qUruo7Db5GM4oMPguPnY2WO3kSdLj2y4oBRdoK8A4
         LPjA==
X-Gm-Message-State: AOJu0YxrsThTkwlUZfUguGmNxOo2LF5sAWGSZN3cZNHmQX4FcMYrn9z1
        cFpfAkCX9GyEBFSlyZnN9Em5+euMd/2PrsMHu2ccwg==
X-Google-Smtp-Source: AGHT+IEzONpw2FaQZlL1wFbHl70DzyH8HlyBf+hDgw7+37EwZ4nnPMOsFqoEIUIPb1qQYUGfgkcn+sRpTBlQRy3ib10=
X-Received: by 2002:a6b:7111:0:b0:790:f866:d717 with SMTP id
 q17-20020a6b7111000000b00790f866d717mr323374iog.10.1695140071037; Tue, 19 Sep
 2023 09:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <3a7056408e391ff0c66b5f50c460a7b9f796228f.1694625260.git.andreyknvl@google.com>
In-Reply-To: <3a7056408e391ff0c66b5f50c460a7b9f796228f.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 19 Sep 2023 18:13:51 +0200
Message-ID: <CAG_fn=UchfGsWMYnYdatDrzr_k+E_55HKvHhMO0VeKvSKONJWw@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] lib/stackdepot: store next pool pointer in new_pool
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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

On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Instead of using the last pointer in stack_pools for storing the pointer
> to a new pool (which does not yet store any stack records), use a new
> new_pool variable.
>
> This a purely code readability change: it seems more logical to store
> the pointer to a pool with a special meaning in a dedicated variable.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
