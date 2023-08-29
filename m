Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A178E78C4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjH2NQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH2NQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3090;
        Tue, 29 Aug 2023 06:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 024E2617B5;
        Tue, 29 Aug 2023 13:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6485BC433CA;
        Tue, 29 Aug 2023 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693314973;
        bh=VaesNxr2VPcxUZ4EXzjPHYXwuD1wLdg/EjsIb+7HAQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XI2rGPxjBaQnqqlpq7ZmwYFF8rODATFDrVaY78OSs4LCet7LlkcBkcfSBaQ1p4Uqa
         uS0foll4kq/WooPxMyGuMpBckz/X0PVil8u6136OKuL31AVao71uEMrPtM5516YDhn
         xl6+39Ie5sA1vO+v8nx6CkHXmljPOKSRjY9gy/+pAyO5VExeFYPpLIQWyPmYgiQq1w
         snv7K3TiJGfFHXAiTnJ8SL30Ji2LeuaYeuvPGDcqBQvRM1gSa4fZw2hRnBAYm4VTnm
         fW6XpbhfOuLRhw2gCnzqAO5ewVDJq/dwRtrTnkSyrtidnEFEZ9lA3GMU8y3Gdv+jjb
         DD6GApjTIBIBQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso3015664fac.3;
        Tue, 29 Aug 2023 06:16:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEaW6gqm3OoyFGh2ch9EMryE8/gbUL2afYwpzj0vJzPK7Ut83a
        7ys7FJH7L3Xz1Y5DjlsPcwqsZ/Om/7gYfE9/cis=
X-Google-Smtp-Source: AGHT+IGEq9p9i6rL0aOlX9yWEF6QoQ3zXqoU5jhS7nvbgHefzK8TeylQD3QBbXb3cWgQ2HvJz/H8R8KJz5hKC2aooBA=
X-Received: by 2002:a05:6870:910d:b0:1c7:ebf5:b6d6 with SMTP id
 o13-20020a056870910d00b001c7ebf5b6d6mr15892523oae.37.1693314972703; Tue, 29
 Aug 2023 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230820224800.3905291-1-masahiroy@kernel.org>
In-Reply-To: <20230820224800.3905291-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Aug 2023 22:15:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATypTEe8mqNuQ7FBGYm_-T_ra_DkJiXn2-cgzh1nmvjWg@mail.gmail.com>
Message-ID: <CAK7LNATypTEe8mqNuQ7FBGYm_-T_ra_DkJiXn2-cgzh1nmvjWg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: merge list.h in modpost and kconfig
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Mon, Aug 21, 2023 at 12:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Move scripts/mod/list.h to scripts/include/list.h and remove
> scripts/kconfig/list.h. This removes the code duplication between
> scripts/mod/list.h and scripts/kconfig/list.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


I will drop this patch for now.

It will break 'make xconfig'.


scripts/kconfig/list.h is not safe for C++.





--=20
Best Regards
Masahiro Yamada
