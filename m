Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB5078A59F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjH1GSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjH1GRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:17:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9BC6;
        Sun, 27 Aug 2023 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693203432;
        bh=RLh/iKkhkkusFbJvY334+vB2M1uIDZ/5pE7VOu44/vs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JTyQZFDqNMeMVmO4EfPbcnBAZ1DuSvbuwFjAnB8hSINbPAT7GN+TCyGskVksx4HqU
         qlglGjm7W6QpmD7R7ZY055gnq3+8SzUN1VvjbGgrCt8xLS9ywu8I2IEGj4hyM/rFrs
         EKBPeTE+KGWADe4s4DSkURpDjiH+ruEWVi6fPTUSRb86CcALzqCZc2iaDeQZOJC0xR
         ai+fS4iHyIw2BWPMTGlKuLeyZyb6kxF0Csk351GZU+Rfl0awmhXkm90BAZ4gsOMSiU
         7QdNfRvx++uGuFtP9TmDplcr+JF1HigKcAAfv4Kangxy0rMI5AHg4zzZ1CgZ5knBpH
         m//LD/elqaqXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZ0hQ2vSYz4wxQ;
        Mon, 28 Aug 2023 16:17:10 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
In-Reply-To: <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
References: <20230825194329.gonna.911-kees@kernel.org>
 <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
Date:   Mon, 28 Aug 2023 16:17:07 +1000
Message-ID: <87ttsjlmho.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Sat, Aug 26, 2023 at 4:55=E2=80=AFAM Kees Cook <keescook@chromium.org>=
 wrote:
>>
>> Hi,
>>
>> This is my series to show *.config targets in the "help" target so these
>> various topics can be more easily discoverd.
>>
>> v2:
>>  - split .fragment from .config to hide "internal" fragments
>
> Please do not do this churn.

That was my idea :}

> Like Randy, I did not get "why" part quiet well,
> but if you are eager about this,
> you can show help message only when the following
> ("# Help:" prefix for example) is found in the first line.
>
> # Help: blah blah
> # other comment

I did think of that, but wasn't sure how to do it in make.

cheers
