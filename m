Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B47DCB01
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjJaKg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjJaKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:36:27 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651E83
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:36:25 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b9bd9f8bfaso2203976241.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698748584; x=1699353384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0j5MzCJS6Nm8YyNAXIMgXvYrXveRdJRWMZSbaeNy6Y=;
        b=rvN946id6K8qhVISfto7xDbiKer7th1bL8ifOUX3aHtsG8FD4a7ii2ML5ultfB+FmO
         n2URzK0ftgO6vrpxYudvxmuZLEuid+hzUbbYqYd2sXqGqL5E/BPAm+Wzu8kTeyTWSDtJ
         MC6MF5YOGcpxz363qk9ofxw8wOSBmImGqD/s7XJ88kLmqqGUdA0YfpyUXzfs6C0q5no3
         3D2ZL+9wnQRdlXaaKlG4/uomzg/vdLrFz9kbq0CgygK8XkPzzFnGltu2t3EneiOuHVgX
         1w0Kj1dBNOgfDlkH7CgiRzC2wkIkexZWxKx5HuTIF2AujDHQvdhLbx1PjYr5ZCKLsEHz
         6fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748584; x=1699353384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0j5MzCJS6Nm8YyNAXIMgXvYrXveRdJRWMZSbaeNy6Y=;
        b=BFjOIsHekN9rF5U/43LvvvvZWqw9nuaknLO89l3T2FSJy5sh7k+sacgdWWGvm1nGZR
         RGOkRh7+T8qOwiGRECVPJNd9NvZeRHAnR704LtKsa9yZTuCKdIG44aIyxEqUQ54fYTIf
         n3+jHE/LwKVzSuXUUSnvMpW49Nu+Ij/3+mqIlyJqOh/c7bBB91Oaz+FrcoJRg9ey+B56
         0pD3ZziJ239sq5e6GAM7ONWQMrZglC1uqQ6mc/dJwlrsGB1m46uamvrPiPi+OFXMqRje
         LIuOGkOPmCvjRJCujx57JQ7wczKtzolavZwWXp6zN4mewJlLgiU/jZ+oP/vzBQf0SHO0
         y4eA==
X-Gm-Message-State: AOJu0YwqlVela+uahQocsU2it46m5a0EbjgoDkvDtSOroiwfJPwBr4mB
        nhXRPXxy008ae6zJtNNNVd3/KCcPGXm72NRXI/zvOw==
X-Google-Smtp-Source: AGHT+IFfihGghZxaOx77OzFwyUrNBsA7BsHF9OMXxQ7gHC+wgag1CBz+lqHxb3KAAncOcs9MZLh4dPqNFCqaz/EyQf8=
X-Received: by 2002:a67:c392:0:b0:457:cd5d:6ab5 with SMTP id
 s18-20020a67c392000000b00457cd5d6ab5mr12205839vsj.23.1698748584165; Tue, 31
 Oct 2023 03:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231031100742.98859-1-sumit.garg@linaro.org> <0de17ec7-b692-4d1e-b059-c5f3f619e94a@oracle.com>
In-Reply-To: <0de17ec7-b692-4d1e-b059-c5f3f619e94a@oracle.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 31 Oct 2023 16:06:13 +0530
Message-ID: <CAFA6WYPC83ZOocdUo0V=RfG5RQZosqK0jHdELPP3M2bFNGYJYQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Destage TEE subsystem documentation
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     corbet@lwn.net, jens.wiklander@linaro.org,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

Thanks for your feedback.

On Tue, 31 Oct 2023 at 15:46, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
>
> On 31/10/2023 11:07, Sumit Garg wrote:
> > Add a separate documentation directory for TEE subsystem since it is a
> > standalone subsystem which already offers devices consumed by multiple
> > different subsystem drivers.
> >
> > Split overall TEE subsystem documentation modularly where the first
> > module covers the overview of TEE subsystem itself along with generic
> > features. Then the further modules are dedicated to different TEE
> > implementations like:
> > - OP-TEE
> > - AMD-TEE
> > - and so on for future TEE implementation support.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   Documentation/staging/index.rst  |   1 -
> >   Documentation/staging/tee.rst    | 364 -------------------------------
> >   Documentation/subsystem-apis.rst |   1 +
> >   Documentation/tee/amd-tee.rst    |  90 ++++++++
> >   Documentation/tee/index.rst      |  19 ++
> >   Documentation/tee/op-tee.rst     | 166 ++++++++++++++
> >   Documentation/tee/tee.rst        | 122 +++++++++++
> >   MAINTAINERS                      |   2 +-
> >   8 files changed, 399 insertions(+), 366 deletions(-)
> >   delete mode 100644 Documentation/staging/tee.rst
> >   create mode 100644 Documentation/tee/amd-tee.rst
> >   create mode 100644 Documentation/tee/index.rst
> >   create mode 100644 Documentation/tee/op-tee.rst
> >   create mode 100644 Documentation/tee/tee.rst
>
> A comment from the peanut gallery:
>
> The old tee.rst starts out describing the userspace API (include/uapi/,
> /dev/tee, etc.). Maybe this part should go into
> Documentation/userspace-api/.
>
> The rest of the document describes the internal kernel API (how to write
> a TEE driver). And maybe this part should go into Documentation/driver-api/.
>
> At least I think that kind of split is what the documentation is going
> for in the long term, so if you're moving these files around anyway it
> might make sense to do it right away.
>

It makes perfect sense. I will do that for v2 but let me wait for any
further feedback on v1.

-Sumit

>
> Vegard
