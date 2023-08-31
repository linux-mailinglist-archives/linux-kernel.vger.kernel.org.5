Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0778F08B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbjHaPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbjHaPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CAB1B0;
        Thu, 31 Aug 2023 08:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCC67B8233A;
        Thu, 31 Aug 2023 15:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C7BC433C9;
        Thu, 31 Aug 2023 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693496738;
        bh=J1cZYDRnTeF8cAXMCJ0XFEKzFUSLXJ/iqg35dWO1Xlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m9sJMKHABnRVgyrpaiqO/6dri9ODMIQ2UYtcPw0s1RRnkYP9nAEi02nSlDcnZBfVu
         dF8V9bQfD784m7vV8UNt3V0eIV1U7+y+3czS4NW3LOly5T1LiDbnS/3JL0HB/7QH+G
         ND/7Xk0LhEEVbMllR2fDp+zaRReZaOmDIEpvign+dD4FG4hPedRR2Z5Hm7NrTH0lrE
         bxnvUQxnYZZ7cB0ZeA9rzXEQV7Cls3FompIOVbhBiWmGlfwBS0wEhCgvgfaEeGSpGC
         nKHUtgrRMu9rYOMCOMknC102ncMv0mcCI1WaN2y3pSQFFC3KCBOMjELtAYfODpFSiJ
         Xx4MtQi7jaZZw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso558059fac.0;
        Thu, 31 Aug 2023 08:45:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyx3B63qh4FYrEgsBeNmgN0+kc07+oMf/x/avSQ6bMgNSzXiWEP
        qfqAFJIUSBpbnstASOsLagSCcKIGCzlnVnXl0aI=
X-Google-Smtp-Source: AGHT+IEUJMNylrks/fy5NvmaNAFMnHbg4XiCcdriY8ZpK4zEHo9Dox7bvKVqZcq4Wd6iiC2FHgRGNtjlem0M8nYGzko=
X-Received: by 2002:a05:6870:392a:b0:1be:fe7c:d0a6 with SMTP id
 b42-20020a056870392a00b001befe7cd0a6mr6668317oap.2.1693496737720; Thu, 31 Aug
 2023 08:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230825194329.gonna.911-kees@kernel.org> <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
 <87ttsjlmho.fsf@mail.lhotse> <ZO2NVLipjlzIh0YS@bergen.fjasle.eu>
 <CAK7LNARjsB+LTBGRfWX68Ld7oehhuBv9SY8scoC=Xk8EJc-OHw@mail.gmail.com> <202308301702.4EB6F55@keescook>
In-Reply-To: <202308301702.4EB6F55@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Sep 2023 00:45:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtiS5ePpq9vsQvhQs5AC_FGbsGycM1Bn9jtKvH1rRwpA@mail.gmail.com>
Message-ID: <CAK7LNARtiS5ePpq9vsQvhQs5AC_FGbsGycM1Bn9jtKvH1rRwpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Thu, Aug 31, 2023 at 9:03=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Aug 29, 2023 at 11:57:19PM +0900, Masahiro Yamada wrote:
> > The attached patch will work too.
> >
> > I dropped the "in the first line" restriction
> > because SPDX might be placed in the first line
> > of config fragments.
>
> Good call. Yes, this looks excellent; thank you! Do you want to send a
> formal patch? Please consider it:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook


You can send it with
Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>


You can add help messages to more *.config files if you like,
and add SPDX tags while you are here.


--
Best Regards
Masahiro Yamada
