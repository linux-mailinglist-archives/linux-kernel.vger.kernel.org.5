Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B387BD7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjJIKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbjJIKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:01:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6869D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:01:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-664bd97692dso29235636d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696845666; x=1697450466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HotZPzuJzl1SmzAQEp1ojEnv3yLnH0/BdTX3c1wN21g=;
        b=lxSejDTwnS9U14TqP/P0PsCb13FtrhLQqqQPGFTh1GxI1sYp7Y8CVWRt3khCdLGHsJ
         D3mnrLXzB/vhufE8pWt2isM4mE0kNRxD1cfV3EuOPGdc3qm9uKy6iNwNnlwlniOjOhrs
         hbvIuNWpuCexmxuast3tYLUvYBDlbl90BIV8N1yVbV0qjV1szZP83+Ux+2b6BZh/dLJX
         0nGshLRZAqfT7HqKEDdSRdtMIqEv4uSQO4vQvj+AK6bMTsdEPagRxY4HF1wPImBE1W7d
         8VRKhljrO6MMc4Pnz6XA4ccIbUN576Copahpn2T4KFUYYxVx/Kf1x+Iy3AzbSGcBn2M+
         FR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845666; x=1697450466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HotZPzuJzl1SmzAQEp1ojEnv3yLnH0/BdTX3c1wN21g=;
        b=leJNlYJAfJwZJadt/WKBoDKHmBbKNK2Q/tVL2RHj988KvsLB6xKt2qwiISjizHt7Gs
         taALjItM7lucUmSbV/fqQqQXu7gkpPn4nYIT0YxAtRpqsjhCnzDVbVemY6Am2uMhaHmW
         7lXjKOBsanhtpfMJBJ5lril9zOf+ylfaFMSlHUTPHllNWWkhVzdvywB1HQcYdLliapd2
         pPARV0hP5L+Od33mOJqJVcZxROAkGLcfrBjGFUDmkksIznj0CAuc+vvFix/L93djsjVy
         bADnEWRAZ04trfvZ7kZXxCgC6yj8t7ts+JUNxeMWnPfssbL3JVgQsz5lwlxlGk1vPqxC
         IRTQ==
X-Gm-Message-State: AOJu0YxVfB/eYRG5CYsmozRkpI/+IMUmfIg9uH2RnQNQfLI39GEuldFj
        K9z/4o5N8812PG35CXc4d5ycrMh0GuxqrPXiFhCFcg==
X-Google-Smtp-Source: AGHT+IH2NnJHpNLpm3BdWsCu8f9GXosUxTvU2Ng+RR4+SrkUap1Uj54ImLX73UydH8+798peMhtwWeygP9cePyDNLoI=
X-Received: by 2002:a0c:9cc6:0:b0:65d:b9b:f327 with SMTP id
 j6-20020a0c9cc6000000b0065d0b9bf327mr12581237qvf.63.1696845666421; Mon, 09
 Oct 2023 03:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <7f6b58fda637238ffc0c240e7fd3b3a6673d9d91.1694625260.git.andreyknvl@google.com>
In-Reply-To: <7f6b58fda637238ffc0c240e7fd3b3a6673d9d91.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 12:00:26 +0200
Message-ID: <CAG_fn=UGeH_eWcGNjX2uZBaWtVcS5pkikOx0+4UYcCqRLjHceg@mail.gmail.com>
Subject: Re: [PATCH v2 13/19] kmsan: use stack_depot_save instead of __stack_depot_save
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

On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Make KMSAN use stack_depot_save instead of __stack_depot_save,
> as it always passes true to __stack_depot_save as the last argument.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
