Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE59E7DA63A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjJ1Jvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1Jvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 05:51:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA6D3;
        Sat, 28 Oct 2023 02:51:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A87C433C9;
        Sat, 28 Oct 2023 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698486693;
        bh=GNDf8LvusR6ZgGhwmyHmDzU/pVpBClhIYC2hQq+9buA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B7fdqsqk031Kn0CZi/Vy5J5mBKlp4xRzDmAKB7gPzntJ2++IYKSeiLLFxlNFIcg+m
         VOqGmTr63NsMjWGFRXRdiFwHPUekGU4iOb3uzrwIwNPMmZtQHPcfr06BfX0hc5fTe5
         ckmXJqek0ziJuXEk7W47B5ESf5EPiPbPSB7kdF/Vd1WzT/YTHcDVg8qAjgh8JX0WiA
         O6Fzuli4/6Nh/tH6yvAgcI4waL+v9Rkc4+3ovsW6R9Uwa7pPhVH66ncUUWCxIQBbEo
         Md/Jj07sq1a+uLerZF4IvIDwGS+q+GqgdeZ8+Uxljz3/LCpo0SOz2AskcvlXo7yKa3
         b9eI+YbKA3A5w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1e9ac336589so1896526fac.1;
        Sat, 28 Oct 2023 02:51:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEOJhnYAGB2J3le82nzu6+JlhDkWyw1xBMha147biDL7+qejbV
        Ewky2oM3ICyR8JPdFVQyqjcdlZ/d4c6pL5kz/5U=
X-Google-Smtp-Source: AGHT+IFv8vMfCPjd/oJREySU+skr371cgt0AF/R8GRXXTgjWyAhUUoLUAoqzKpwogiRLOFUYnFiyMD40qtsmfZstnHM=
X-Received: by 2002:a05:6870:b48f:b0:1e9:b0fa:de48 with SMTP id
 y15-20020a056870b48f00b001e9b0fade48mr6157186oap.47.1698486693015; Sat, 28
 Oct 2023 02:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org> <20231026072628.4115527-2-sjg@chromium.org>
In-Reply-To: <20231026072628.4115527-2-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Oct 2023 18:50:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReQB4KF_Ka=SUWSJ2psvqCrEm=BOkKXCYDK7Ux9uYutg@mail.gmail.com>
Message-ID: <CAK7LNAReQB4KF_Ka=SUWSJ2psvqCrEm=BOkKXCYDK7Ux9uYutg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Correct missing architecture-specific hyphens
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 4:27=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These should add a hyphen to indicate that it makes a adjective. Fix
> them.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---


This is trivial.
Applied to linux-kbuild. Thanks.


git grep -i 'arch specific'

 or

git grep -i 'architecture specific'

finds similar patterns, but presumably we are not
keen on fixing them tree-wide.





--=20
Best Regards
Masahiro Yamada
