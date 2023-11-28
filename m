Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C755D7FB2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjK1H0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjK1H0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:26:48 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB543182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:54 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4ac89e8e964so1352692e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701156414; x=1701761214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQHZhfJfvy6myNbejEz/bjCAKf8Fay2vrOw4NWLU8tk=;
        b=Zy+Hw/32OxxdrlhTE7vy+2FprJM1evLmduheqRFxA7cbuOGt1cMnJ0LuYC7trQhV6C
         tRkEdc2qWL3Z10jPmxXkjfT9tFk+kZp4JBmrwT8cPi9aYsgyZ5Im0I6GDA5wnqggOixG
         eY2xFhWswxK/Fr38tnQutbXS+FOe9ZqdWJH2jigRw50VxxzWBDHpq45nPnGlvUsjZgsC
         leqgnB0auyxDBtspIO9Jhd8EMBF2ZOdiqoULNnOYOsLsdMp1yUKr75msnqp15j1guHY0
         YIQ2kb3wwUFhVvHuD43ArH5xHRC99GhQOzzBUYU9SxkwUfXmII0mtcSWHRYJwlqZzfII
         xsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156414; x=1701761214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQHZhfJfvy6myNbejEz/bjCAKf8Fay2vrOw4NWLU8tk=;
        b=TcNGQ8+RMKGOZSmQT1dlav+7uBZtP3YR0BPOOJ+OCAc0KGpLVfRNAkDamWEKy2JFo1
         hreX+2gs8SlkygBvFTGiT60fT2h1TshNFdek9Z1aYAGtzYG+UB/dvxtzjRsO/Bx7LEMb
         qdS0qVvrSF8WaUBuF+F6oY1g60vRhNRr9JEpepedVkSj50rswcHDcua5jE3Bx1qqXFOy
         Zis1n8KXIEWRUfDXkFZ61xqqJH2cGeYd8bVZCtEAA88ob8RIFc3lJyIyQc8ycX7IB9CU
         vCjYxGjZ61BrFPQihVBdVSVmW1AqxLIpX/rXhOL6YBqDj0e72p7eAT+/ya03t28XVW9C
         gPzQ==
X-Gm-Message-State: AOJu0YwTJ0+8ONFojG5+q8dX3wEeFkBpun/fov/IzTM9cM48YzXA87Nm
        GENkXTcDjZqDY/Y9agGZwSnsYE7HRN+4UvxFz9vEBQ==
X-Google-Smtp-Source: AGHT+IFVftVfIjL481V8MUaMw/MvqE5UMxbcrVnbA83NJUcqSW+tuQjWaY+YSV1SVn7KWbLN310PsdKPUSkXzlxwW+0=
X-Received: by 2002:a1f:4ac2:0:b0:495:cace:d59c with SMTP id
 x185-20020a1f4ac2000000b00495caced59cmr11457812vka.0.1701156413959; Mon, 27
 Nov 2023 23:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20231103061715.196294-1-sumit.garg@linaro.org> <87h6l7yth7.fsf@meer.lwn.net>
In-Reply-To: <87h6l7yth7.fsf@meer.lwn.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 28 Nov 2023 12:56:42 +0530
Message-ID: <CAFA6WYPs2LCepSM=MQ_dXtTeDPMg6ZQg2LjDR1ZgKNhu3+cqbA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jens.wiklander@linaro.org, vegard.nossum@oracle.com,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 at 23:22, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Sumit Garg <sumit.garg@linaro.org> writes:
>
> > Add a separate documentation directory for TEE subsystem since it is a
> > standalone subsystem which already offers devices consumed by multiple
> > different subsystem drivers.
> >
> > Split overall TEE subsystem documentation modularly where:
> > - The userspace API has been moved to Documentation/userspace-api/tee.rst.
> > - The driver API has been moved to Documentation/driver-api/tee.rst.
> > - The first module covers the overview of TEE subsystem.
> > - The further modules are dedicated to different TEE implementations like:
> >   - OP-TEE
> >   - AMD-TEE
> >   - and so on for future TEE implementation support.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v2:
> > - Move userspace API to Documentation/userspace-api/tee.rst.
> > - Move driver API to Documentation/driver-api/tee.rst.
> >
> >  Documentation/driver-api/index.rst    |   1 +
> >  Documentation/driver-api/tee.rst      |  66 +++++
> >  Documentation/staging/index.rst       |   1 -
> >  Documentation/staging/tee.rst         | 364 --------------------------
> >  Documentation/subsystem-apis.rst      |   1 +
> >  Documentation/tee/amd-tee.rst         |  90 +++++++
> >  Documentation/tee/index.rst           |  19 ++
> >  Documentation/tee/op-tee.rst          | 166 ++++++++++++
> >  Documentation/tee/tee.rst             |  22 ++
> >  Documentation/userspace-api/index.rst |   1 +
> >  Documentation/userspace-api/tee.rst   |  39 +++
> >  MAINTAINERS                           |   4 +-
> >  12 files changed, 408 insertions(+), 366 deletions(-)
> >  create mode 100644 Documentation/driver-api/tee.rst
> >  delete mode 100644 Documentation/staging/tee.rst
> >  create mode 100644 Documentation/tee/amd-tee.rst
> >  create mode 100644 Documentation/tee/index.rst
> >  create mode 100644 Documentation/tee/op-tee.rst
> >  create mode 100644 Documentation/tee/tee.rst
> >  create mode 100644 Documentation/userspace-api/tee.rst
>
> So I finally got around to applying this...after dealing with the fact
> that it doesn't apply to docs-next, I found that it adds a couple of
> warnings:
>
> > Warning: Documentation/security/keys/trusted-encrypted.rst references a file that doesn't exist: Documentation/staging/tee.rst
> > Warning: drivers/tee/optee/Kconfig references a file that doesn't exist: Documentation/staging/tee.rst
>
> Can I get a version that doesn't leave dangling references like that
> around?

Sure, sent v3 to incorporate rebasing to docs-next as well as removing
any dangling references.

-Sumit

>
> Thanks,
>
> jon
