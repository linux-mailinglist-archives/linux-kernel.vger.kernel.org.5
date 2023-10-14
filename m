Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232827C941A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjJNKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:18:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB44A2;
        Sat, 14 Oct 2023 03:18:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so2648912276.3;
        Sat, 14 Oct 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697278703; x=1697883503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD2RALeAHf4EyVH0V54MgAy7EPDrxXSYL/VcpZrTBWo=;
        b=N38LBgatJk6IuNEKMmbtU+ymfCXfkKDweIKbr13lb2FtLKLP4DMppnk5jMrtLhGkBB
         su3qWgoJ04n6AFsNsIChY+heoZPzLXND9dlHTB26IyBgD13SgJmZboacI+WzZk8kBVm0
         ufZCbiTJ9whCh6t7HBUg0G3rObrWv/Bht1QGVItAw+0eogvGnkDWRXemAjLSKmE2+7Ll
         01t8or8ErRpyD/aBrQ4JlbbaOP2LYtZq9eYJX7XElT0deDLfG8lxieiVHMw56aqP5Y0o
         I+4lQ30Ok1fSOwtypUkKJ4QTQl+OfeMTyvw75CynuYsBzOqZZ4Dxx9Mirtd/OTE9QZG8
         CXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697278703; x=1697883503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD2RALeAHf4EyVH0V54MgAy7EPDrxXSYL/VcpZrTBWo=;
        b=StkNzfj8isba8rwM2k8v//UBqU3JPPtApL5MJ4HRbWcqwoFdW8Cut+yVckgZUqJDXf
         zqwCn2eM/HP5DHauWmEW3gfClLmr3YmDvSM59/mwhZT2Ir6QoqDkZuvdlGrvpE4EtDQM
         M1AvqMpI/wNzJ3k5ADvq2z6EWiGhVKjzg8r3ORnnxKZF8ryEOZF6VTJoVypvsn99oiIn
         cXaKEX9Q1Mhf4Y1qRyLsozeZAYBco3SN8F5Vj7iwA6TuCvEVFXH6SaBzrU6o2XmssOXc
         TPKWgzJ1qDr23+ofhTFLUePPef/2Kl8pkmPxa8VAcRXuhx3lgJePQzyWHd8CJJtMi6nO
         TgyQ==
X-Gm-Message-State: AOJu0Yzy+C345uTdnzsDhzLmNAIsRc2XsHV+gEjgU2AtsxxNm1d1eCi6
        /fdesKOIv0Zfbh76T0O+Pkicpf8sOvAetlJ+UWU=
X-Google-Smtp-Source: AGHT+IEXHyobEY+S7AX/2O0DWm7a8adqtxEDJWjstkMbNv4IAw59txhFSrNML+CIpMWiPteLNE07XEW31DrQzci7Trk=
X-Received: by 2002:a25:db10:0:b0:d9a:b9fb:e6f9 with SMTP id
 g16-20020a25db10000000b00d9ab9fbe6f9mr6339988ybf.10.1697278703561; Sat, 14
 Oct 2023 03:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
 <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com> <652978deafdf8_f8792944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <1c2117f1-2d22-4d08-bd9f-8c821d4a1757@intel.com> <6529b493cc785_5c0d2947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6529b493cc785_5c0d2947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Oct 2023 13:17:47 +0300
Message-ID: <CAHp75Vc1D3ut8x8_bVRSaEGy8EdUgfubxEsAbLEzJvNDx49f_g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        rafael@kernel.org, vishal.l.verma@intel.com, lenb@kernel.org,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 12:20=E2=80=AFAM Dan Williams <dan.j.williams@intel=
.com> wrote:
> Wilczynski, Michal wrote:

...

> "The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
> the usage of devm semantics in acpi_nfit_init_interleave_set(). That
> routine appears to only be using devm to avoid goto statements. The new
> __free() annotation at variable declaration time can achieve the same
> effect more efficiently.
>
> There is no end user visible side effects of this patch, I was motivated
> to send this cleanup to practice using the new helpers."

The end-user side effect (educational and not run-time) is that: "One
should really be careful about the scope of the devm_*() APIs and use
of them just for the sake of the RAII replacement is not the best
idea, while code is still working. Hence it gives a better example for
whoever tries to use this code for educational purposes."

--=20
With Best Regards,
Andy Shevchenko
