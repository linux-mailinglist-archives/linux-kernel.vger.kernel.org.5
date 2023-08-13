Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65F77AA4E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjHMRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjHMRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AA10D0;
        Sun, 13 Aug 2023 10:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A60D60FBE;
        Sun, 13 Aug 2023 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD7C433C7;
        Sun, 13 Aug 2023 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691947316;
        bh=HRw1zHhveSGkgHF3bY3fnQnq7o9pcZwlmNxSaVaKEZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lrZoVa3etfrl7/8UMbghLJDsF1VX9k6zxzizlix54dRnZwQ00CHnk05M9HDGw03nQ
         ojZTaVDuqJ/Ee2c9dD1hdCc1zGTNJ403760Z5SxwiaKjh7Da9FbacQUdlfqa648Y+2
         0bsg6Govb+PsHjIx17xKPawDwC4kQNgYZr8f5LseydVPWZoOtpcC2ITa6sGQcGqK/m
         OKWmUJm7qDsC54n3Xz4hRZtc51VdQWdLm1HTZIqv91xMwZ5Qgu4nzOl6e7n25Djjwm
         El2jqcp3oE6Hza62YKjKWa8cls5+iho8jl0zCz4LVM8ClT91qH/gE7mv1E2OBUOkV2
         2+SKpp47+Mkyw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso5565346e87.1;
        Sun, 13 Aug 2023 10:21:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGsoNDnZQTI36GYgMIDfqD7Mdl1AX2ve+poUHaYzNc598uffhV
        nlxXghVtusH6w2+SgZOEDpAoWVK/K3UKd6ZQ/1E=
X-Google-Smtp-Source: AGHT+IFmzCAccwRwvRv3YHhEs1pQjc18KGaerDfD8Q6+ZV4oFi6yPiUqxSzdGFPJexpuiMD9HQUXK9V5GRNHXEKbhE4=
X-Received: by 2002:a05:6512:304c:b0:4fb:9f93:365f with SMTP id
 b12-20020a056512304c00b004fb9f93365fmr5926430lfb.38.1691947314937; Sun, 13
 Aug 2023 10:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230731104911.411964-1-kernel@xen0n.name> <20230731104911.411964-5-kernel@xen0n.name>
In-Reply-To: <20230731104911.411964-5-kernel@xen0n.name>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 21:21:42 +0400
X-Gmail-Original-Message-ID: <CAPhsuW4msFL6WO1TFj-amJW2pkztLCruc8UGUVUXz4rftD8dng@mail.gmail.com>
Message-ID: <CAPhsuW4msFL6WO1TFj-amJW2pkztLCruc8UGUVUXz4rftD8dng@mail.gmail.com>
Subject: Re: [PATCH 4/5] raid6: test: make sure all intermediate and artifact
 files are .gitignored
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 2:49=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Currently when the raid6test utility is built, the resulting binary and
> an int.uc file are not being ignored, which can get inadvertently
> committed as a result when one works on the raid6 code. Ignore them to
> make `git status` clean at all times.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  lib/raid6/test/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 lib/raid6/test/.gitignore
>
> diff --git a/lib/raid6/test/.gitignore b/lib/raid6/test/.gitignore
> new file mode 100644
> index 0000000000000..bb92e11396c6e
> --- /dev/null
> +++ b/lib/raid6/test/.gitignore
> @@ -0,0 +1,2 @@
> +/int.uc

We also need neon.uc, right?

Song

> +/raid6test
> --
> 2.40.0
>
