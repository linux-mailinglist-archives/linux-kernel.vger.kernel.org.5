Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37F180C62B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjLKKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjLKKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:13:57 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0603D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:14:03 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d8a772157fso35301727b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702289643; x=1702894443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z6zY4c0Tb5+ieU4d3Nz6Jn4MLK8nHKOQpLlbBpEjKg=;
        b=NCSFYlSxaMBXjGEeo9r58onG6AqzMDuUvTpfYB7xy1IT+ia+GZbt7Y3b7ivuFErQis
         qGzAtEYfMDOI0O+bMzCTklMFkQI8m36CqZHD9qClzyaVvPFR0XU6tXeYei0SfuIohZA3
         g5YRmTWwUZx8vZdTGOcw5Aknqj2f6oh1Nsbyo5OKXYMcUoc0nDYv91KoSDBJyZ3rnZlm
         Ntiku1i/R5DHBday/ia+Nj31jiwNxr6l3QT3rpYE2y2TbVRrO6dKcB9cbtSLUehEUlLV
         oGEkH7ngxQqx14u/IaWe1SuX9yJ73+lXUab+jhwxMg+yDau9RZUnmzqfRBTmJbGubwyb
         XETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289643; x=1702894443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z6zY4c0Tb5+ieU4d3Nz6Jn4MLK8nHKOQpLlbBpEjKg=;
        b=c98jOIes3ZjdZN19yDlObwQpNpl7A4SCWv2fu3YRI6Wm6Lwm1DVVyC0n6tzXLghFYd
         4G4QBefwaAwbsKaTfXbRHtuqC8pTG/NvIRd4sNPHxeKXZz9gCqCamkraeEwl6OSrLHty
         RbMFz2T8zmgkitDWt3GnxKoomKnBKewEFoPzsQG7mVmwFOC5FyJyvtY8JLjUuhtAUPqJ
         D22XTI/+qHOWVcviHA2ZR4OYDgdqyzN3PggyRrupbpYNGqwTpX6Xv0pZYPZmxHRibxoc
         K5Mzq5cTGUlUm6TsVbHORG4a9mpUJH+OEN3E1E1f0cKSu618wljKVu3vwMpUpntqBAel
         bsaA==
X-Gm-Message-State: AOJu0YzdKD+5ss9Ou7XDFQ2hl8BcuL9zW9E33owdK/5jIA/4fxLR6tJ3
        v0DD2kLFW07St52L7wKntk2LuHQb5x857nittXOMyg==
X-Google-Smtp-Source: AGHT+IEk5OVTZiB661DV5dZOhAvgOHAleqdnumLHRqN/Lk2fp+rcFjIzeAHjQGdOci45RI7ZRYsN0u4klnWKa7xixF4=
X-Received: by 2002:a05:690c:3249:b0:5df:4992:9f90 with SMTP id
 fg9-20020a05690c324900b005df49929f90mr2222920ywb.34.1702289642775; Mon, 11
 Dec 2023 02:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-28-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-28-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:13:26 +0100
Message-ID: <CAG_fn=VE7M590AqPceT1qjtf7qS1QGBfvnprz9s=0U2WgRmK6w@mail.gmail.com>
Subject: Re: [PATCH v2 27/33] s390/mm: Define KMSAN metadata for vmalloc and modules
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The pages for the KMSAN metadata associated with most kernel mappings
> are taken from memblock by the common code. However, vmalloc and module
> metadata needs to be defined by the architectures.
>
> Be a little bit more careful than x86: allocate exactly MODULES_LEN
> for the module shadow and origins, and then take 2/3 of vmalloc for
> the vmalloc shadow and origins. This ensures that users passing small
> vmalloc=3D values on the command line do not cause module metadata
> collisions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(hope some s390 maintainer acks this as well)
