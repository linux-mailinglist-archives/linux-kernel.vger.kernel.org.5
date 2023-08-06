Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE14771594
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHFOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0328E49;
        Sun,  6 Aug 2023 07:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E0B60AC3;
        Sun,  6 Aug 2023 14:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CB7C433C7;
        Sun,  6 Aug 2023 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691331632;
        bh=B0FK+oQvOD3NtQzSbjnb2FmtF6XR6WtO36dN0ZCh4k0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rAlDjaHGYMJE7Itjk3GW9WUjboVkFjxVW/SWAa1DQL4eIkle3b9qFZ3X3qcXrFxhx
         QsLsD0ZbJyC+11sUo7DIq77pCOvFLJXnCRNuv/DBav0Q1Jtmp6Oe/JgOpBLzGPyvLk
         s4UiMfa0jHl9h3qTnyl1qvnv0FqwgYFieJQdnzyeL1eFFghOA1G9CRxxCiMlJJh+nq
         nkj+KjXLIOSXOvLvCiYLLxB3DuwXnHMlE5MXrPHzzlB8mpvbvjovdNmNAH1NymUMAU
         mgcqtJIHd6xIUnatyhbdF9ifYvlJfR3do6VUOUyheFT/5Y49q+OBkSHkQ+9gN8ur4r
         BV41cBk42oLNg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56c96982829so2606462eaf.0;
        Sun, 06 Aug 2023 07:20:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyiuXlGRvKfNXfE54/qaLIzgVhdd5p/onuZ76dIyZoenshJTdp5
        DU9bcZzCrUrVs87Pg16Rt5OH9k08M6e4QvSOAKQ=
X-Google-Smtp-Source: AGHT+IHFbQjzWBWvGY43yozN242H1+mT3jaZoo2g4jLOqYeI9JWsz5vOGIEtLltEEpfjLYNa221LklVLZ8m8po5t7/8=
X-Received: by 2002:a4a:6801:0:b0:565:cf26:5a10 with SMTP id
 p1-20020a4a6801000000b00565cf265a10mr6807000ooc.0.1691331631880; Sun, 06 Aug
 2023 07:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230729214138.79902-1-sergeantsagara@protonmail.com>
In-Reply-To: <20230729214138.79902-1-sergeantsagara@protonmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Aug 2023 23:19:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com>
Message-ID: <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: merge_config: Add flag to prevent unsetting
 config option
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Jul 30, 2023 at 6:42=E2=80=AFAM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> Overriding a previously defined entry for a config option with 'is not se=
t'
> may be undesirable in some fragment configuration setups.

Then, you should remove the 'is not set' entry from the fragment.






--=20
Best Regards
Masahiro Yamada
