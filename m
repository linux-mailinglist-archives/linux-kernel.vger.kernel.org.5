Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A219078DBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjH3Sk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbjH3IaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:30:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB0A1A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:30:17 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7924a3eb5afso178537239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693384217; x=1693989017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMR1GV6sFpYJsS0folCTsjLW+vWGeZBsW541aS1m7cU=;
        b=UX3rUb54ILRd2f7RVcYIFdUMZToDsG/pKgdfxBQ6mCpSK4mFvsBpDyVrgXdnu677Uo
         DamL3MWGfrHzX563yXdkaXqz53Xnxp5Bx/hBB3AuoZeorCwhHFL+f1zjiE9UpA15yqt5
         kr/hJmkwhAIyl7tHnbNTqKM+M3WyOcnHrBMVQD/7H35pIGddA/KOyn/WAgQwP1Mf34Gz
         +cHbvbqfKz8tlg+Hk/wV7U5x4XqrdAmFZvSoumR3giqR7IpHEx4FfBv4EkTzVv3TJNzf
         ucPc2AUp8prOHcTSofEaMJj3TSiZgUwiv0uvSvbPxhm4f6eX1OcIVRnXBo+XcL4c4Z6b
         cUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384217; x=1693989017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMR1GV6sFpYJsS0folCTsjLW+vWGeZBsW541aS1m7cU=;
        b=OIVe/MmXp2Xj/KZIyncqSunmxweiThqZfV9YpFoRecHVdkEfYap9lqS7KbjkbEUBuk
         z0RU1JjCWpFz914t/PUAUNjsiabnLq0kbdpQCY+pCaPAVe2vziDWLBZNDHzn/r6Y90OD
         dDsE7ahBTUmfpNbhqzkJ+nD4Z+Jozv1onkzwF8DRPequkkggNbM8A3ujppejs7OkONpY
         PRVD2OwBdvZ8oLr3lZw7QBVtwXh9b04F4dLi/88cEMqg3QLdAyszUMY0O07C2YjtUJkV
         Fn+2WR9t/o3Hu4wwLGRhs0do34fVZM1AYrl8Z53uucZ1WnUg0HaVXPPE+2ucTqs7HgXO
         tgxw==
X-Gm-Message-State: AOJu0Yyq3ZeaO4jiUwlMefPVeXFgyOevoOkbeX28MjfEeM+0IcCmq1Y0
        rw+/3zWbwXD8MSc3Bgu+5haMahwDFJxsUOFlRl9TRA==
X-Google-Smtp-Source: AGHT+IEHVbgqHgEbK4q+Xw6DM0TVBpkfQNlW/ZScXIow8wnlJ18bcek/FPAGd/6gmjh4fhX7yxBNnVHbqc6vWn9s3o4=
X-Received: by 2002:a5e:cb02:0:b0:790:f397:4321 with SMTP id
 p2-20020a5ecb02000000b00790f3974321mr1771037iom.1.1693384216737; Wed, 30 Aug
 2023 01:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <f5dad29285c8aa7b4a1a3f809e554e7d28a87b6c.1693328501.git.andreyknvl@google.com>
In-Reply-To: <f5dad29285c8aa7b4a1a3f809e554e7d28a87b6c.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 10:29:40 +0200
Message-ID: <CAG_fn=UYA3bwO+_K60UydVa+9NRayQpH6qHwXukG9Dfc2YaCDA@mail.gmail.com>
Subject: Re: [PATCH 08/15] stackdepot: rename next_pool_required to new_pool_required
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

On Tue, Aug 29, 2023 at 7:12=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Rename next_pool_required to new_pool_required.
>
> This a purely code readability change: the following patch will change
> stack depot to store the pointer to the new pool in a separate variable,
> and "new" seems like a more logical name.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
