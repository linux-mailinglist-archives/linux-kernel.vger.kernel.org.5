Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367177ED42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346972AbjHPWhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346968AbjHPWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:37:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A31B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:37:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5241a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692225452; x=1692830252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQDeyROFYUTUFsCL+OkgLZhf1Wy3F/deELM+UEjRB0o=;
        b=O0xtAmCGhGv8ZmSg3w+xHZ9NleCGPtfeERUEp/8ouSqwpB4QjKiNj/tW1+OLXNlIcK
         XbpxwZLLZOp+xHHzuUuy2ur8+0qN9bOeXiWEUUtw8qeTnGNg3f/B2C7G7Jz+HfUm1Thz
         L1o7xnUiPvvqWfjxKw/G9zZodTEfYkIvKtVoEJ8PbOGnlVlxNl2glM3RXM/QKznj5ozp
         Fan1q66qgD/kBUAv31Ay4Qx1Ahd8HsXnIwd8ZbubRA7uduy7qaxfANbtELYVB+80HkFs
         uuiaIfiB2KfTFMTc4G0OCgJxgraijd73Ef2seU3e0GNm5aC3VGug5UjvUp2VXQ5GzF2E
         E7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692225452; x=1692830252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQDeyROFYUTUFsCL+OkgLZhf1Wy3F/deELM+UEjRB0o=;
        b=ej8lYKjA99PrQo44V7BFz9MdWe0FuNEsV6ZWEnokn9owzDvGsWNhetk2a2HtI1TllA
         sMaJiOvYhK1xqm8bM8heTgO2aqtFLOXhJNf+mYIZP6QRD6ML2f4ww/LIyh/hqiugOKAO
         Z+yHt7mLg7gHj+m7+K85sU53KyyhZc8vjlGkAIN7BKIp53G1GOO3J685xax2y7PrEKN/
         WTyJB1ZWRYVUu5yrWPvf5TPdmbESWk32GljKsn2cU2jsxqxcKCzCCgDujZW35meCspTj
         t4ll1vxVjOxS8sMKlQMioEjdkd+ehYaZcRRV9C6dwpV98VOFdaRUb62AJkf3PVDeUKug
         YB5Q==
X-Gm-Message-State: AOJu0YxxbMufEo9IYFHYJtdw5SmkvDqmZXWnlECxR9kr55HtxphtMnAB
        HjohmrDSx5qWqoZLA05NOSQktL4w4cWLPuHz/MCEiQ==
X-Google-Smtp-Source: AGHT+IHj8aaiYS3UZpEEFq8ei4o5VyZK0cDjn8s7zTlAHBhXGm9DDbbRP1Htj8kZe7iwvXQiYj1o/4J4fBGq3L1184A=
X-Received: by 2002:a50:bac5:0:b0:522:41c9:9b9 with SMTP id
 x63-20020a50bac5000000b0052241c909b9mr15050ede.5.1692225452644; Wed, 16 Aug
 2023 15:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com> <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
 <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local> <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
 <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local>
In-Reply-To: <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 16 Aug 2023 15:37:20 -0700
Message-ID: <CALMp9eSbdLuUr9ZvHOA5=vvvA58S5j+cePNKxbx1RxEprRMLZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
To:     Borislav Petkov <bp@alien8.de>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
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

On Wed, Aug 16, 2023 at 2:59=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Aug 16, 2023 at 02:36:57PM -0700, Jim Mattson wrote:
> > Doesn't this render that attestation misleading, since the microcode
> > patch may not have been loaded on all logical processors?
>
> For that it doesn't matter because the microcode engine is shared
> between the two threads. The updated microcode revision is shown on any
> of the two threads so you can load on one only. And we did this for
> years.
>
> Only recently we started loading on both and we will be doing that from
> now on.

SEV-SNP is supposed to protect the guest from a malicious host. A
malicious host may not load the microcode update on both threads. As a
result, it gives me some concern when I see something like this
(https://lore.kernel.org/lkml/20230808190239.131508-1-john.allen@amd.com/):

+NOTE: For Genoa (Family=3D0x19 Model=3D0x11) and Bergamo (Family=3D0x19 Mo=
del=3D0xa0),
+either AGESA version >=3D 1.0.0.8 OR a kernel with the following commit is
+required:
+a32b0f0db3f3 ("x86/microcode/AMD: Load late on both threads too")

It seems problematic if the guest can't tell from the attestation
whether or not the identified microcode revision has been correctly
applied.

> What could be problematic is if it simply fails loading on some cores
> - regardless of SMT - but that would be problematic not only to SEV-SNP
> attestation but to the general system health. tglx has some patches
> which verify what has been successfully loaded where so hopefully we'll
> be verifying more in that area.

I had assumed that the SEV-SNP microcode revision attestation was for
all logical processors on the host. Are you saying that it is not?
