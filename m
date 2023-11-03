Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4B7E0A67
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjKCUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjKCUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:37:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811A194
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:37:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28094a3b760so2986931a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699043852; x=1699648652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzjEyUYLHZleIDTS6RTLkKtGAiXZ2AH99d7iJ1I6V2Q=;
        b=ZvhIKpARGrfHAXTfzkI8P40CoAiPbcW0Xpd/meJNvihvqTA3ewVPTpFo2VyFUtEkUm
         n0/K+VeVjzitBNkerEbOkExwK6bxK7ubX4q4H/mKbcEsUtSfdOMFw8Bb1T2p6RLvdrhl
         y6+SYT2lC/JfGEvHS0ljb008qXgLcYEBLjrsbbJkiXBGC9o0BGndqKk2bgKU5s1+cEg5
         TMagd6Uc5ubjyEtnGdXCdwbKoXRcsrjMBQ5Ms1AretHr4+jvGaVMzSD65BcV9yK+fo5o
         mQHTTpA7L5Hk6xLiuNUQvRoboYS4QdGQS9k4CxghvDcp9+DN2R3Rp+eJ2Le3Dv094oVu
         Ez1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043852; x=1699648652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzjEyUYLHZleIDTS6RTLkKtGAiXZ2AH99d7iJ1I6V2Q=;
        b=S3fmvSDb5SYqYH8yDRhsPZQdrVfs0c3+WTbHLiL3lnYLkIHnqyKKtJkS5Q1ZArifdo
         7DVZUm2zCmb8a0gIZHZnaPy8OxId7jg46aeC3gaq2DJZLN13Zg3747YiESyuwsr0Kd+v
         zclFfwJ1t5bUX0GIA2BodEyY0k2XVCIblRCUSfOnKiHzJuJWDN1JCcNcXBSKGRCD9R0j
         xPtb8Wz2QYnUB/QV9LSzQ8dXWjhNQGicj095FnGnelDsKT7KATp3+DXpmxZQ84dM+M/O
         xDzYmI/J4YVHvqCm4ijZ/FIPI6jiymOtJCF4eNp1CFKn86eIeIlS+sUiGbrolb1WFUQW
         2QPA==
X-Gm-Message-State: AOJu0Yw+X7eLzFbXlrvTHcslEuqYuAmr68xLWTiZxWm+U31qQFfkckk1
        r+dRgxTZXXI3CtfErU+5X5MrwQkEo6cl0VdUs5QCA6ue
X-Google-Smtp-Source: AGHT+IEs5QhcuQbkoAwjMfBCbTnmbxMlbbAj1Gr3XcCS+FheDFI7AE54wp49HNmQR595JmugANy2ZDoQGPUo7U6SH9g=
X-Received: by 2002:a17:90b:f92:b0:280:bb7:9fa0 with SMTP id
 ft18-20020a17090b0f9200b002800bb79fa0mr18749245pjb.43.1699043851766; Fri, 03
 Nov 2023 13:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <e237a31ef7ca6213c46f87e4609bd7d3eb48fedf.1698351974.git.andreyknvl@google.com>
 <CANpmjNOrKpkV3aEPsTZSuL6Nb7R5NyiBh84xkbxM-802nzDtBg@mail.gmail.com>
In-Reply-To: <CANpmjNOrKpkV3aEPsTZSuL6Nb7R5NyiBh84xkbxM-802nzDtBg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 3 Nov 2023 21:37:20 +0100
Message-ID: <CA+fCnZeBzs+PQP8SQGorSsOe2e_NzDnqP_KksjfLwkUu+aVTZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib/stackdepot: print disabled message only if truly disabled
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 2:54=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> stack_bucket_number_order seems like a redundant variable, that should
> at least be __ro_after_init. All code that does "if
> (stack_bucket_number_order) ..." could just do "if (kasan_enabled())
> ..." and use STACK_BUCKET_NUMBER_ORDER_MAX constant directly instead.
>
> The code here could be simplified if it was removed. No idea why it
> was introduced in the first place. I think f9987921cb541 introduced it
> and there it said "complemented with a boot-time kernel parameter",
> but that never happened.
>
> So I'd be in favor of removing that variable, which will also simplify
> this code.

On the first thought, this seems reasonable with the current code.

On the second though, I think I will soon add a command-line parameter
to allow controlling how much memory is used for the stack depot hash
table.

I propose we keep the code as is for now, but I've taken a note to
either drop this variable or mark it as __ro_after_init when
implementing memory bounding controls for stack depot.

Thanks!
