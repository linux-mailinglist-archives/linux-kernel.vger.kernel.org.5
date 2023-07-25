Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E17623AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGYUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGYUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913C2737;
        Tue, 25 Jul 2023 13:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 052DA6190F;
        Tue, 25 Jul 2023 20:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61161C433CB;
        Tue, 25 Jul 2023 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690317547;
        bh=QET1kSGbHT9obYvAR6+ezWstZZZY5nedbQpW/EoZHLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lGL8szh3f16nlAxMhqAeRBXGdPfmiWvmSvk70wiVPaJtjwG0Y4ZIglKeNOy7C4Qjd
         YCH0f4tWS+/GjuRq+q6u33Uy0my1J4GxOtbzM0NSk4sZ3VU1piY5TP0k9lxO13kaEy
         bJMtaAOi//iogTvWQaDJycD+wDasywhZ1vAg5CeSA4HfnUshndUS5zj/209TigJP7v
         lLWNwEZTQrt9f8WPZ7ZhLJj8VBIuBZRx/W6Fpm4t0J7zdD4n43AIXABRU3oqBjIP41
         tyzry1NfgciTmoM7Zxcmg0z1EGiOwUwMCrm834TulDU8A5uOMcprd3raRGyU8uVBkV
         F62S76q7HfGRw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98e011f45ffso871850966b.3;
        Tue, 25 Jul 2023 13:39:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLY7VAlYH7zkkoAPbQeupoqWjKnxjR2r8F3SxsIc88SeaOgyRvFM
        phxvLr68kkPL0kPfuevuvanNIJAdCNZrOloGMQw=
X-Google-Smtp-Source: APBJJlGwzLnxT4QG6DFKXKhAjWsyUsUauvgtUT9uqofHL7y5i0b4PYKutiowXKNr7qL4o9c8igFF4ENciofqpzURL7k=
X-Received: by 2002:a17:906:3f1e:b0:992:4d30:dc4a with SMTP id
 c30-20020a1709063f1e00b009924d30dc4amr12853186ejj.74.1690317545596; Tue, 25
 Jul 2023 13:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230724063341.28198-1-rdunlap@infradead.org>
In-Reply-To: <20230724063341.28198-1-rdunlap@infradead.org>
From:   Timur Tabi <timur@kernel.org>
Date:   Tue, 25 Jul 2023 15:38:28 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVuvVNzbyTLSiqRoSNdU0aprHoxozZzBahFUghqLvL2kw@mail.gmail.com>
Message-ID: <CAOZdJXVuvVNzbyTLSiqRoSNdU0aprHoxozZzBahFUghqLvL2kw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart
 minor numers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 1:33=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Reconcile devices.txt with serial/ucc_uart.c regarding device number
> assignments. ucc_uart.c supports 4 ports and uses minor devnums
> 46-49, so update devices.txt with that info.
> Then update ucc_uart.c's reference to the location of the devices.txt
> list in the kernel source tree.
>
> Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCE=
ngine UART")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Acked-by: Timur Tabi <timur@kernel.org>

One thing does concern me.  The UCC UART driver piggy-backs on the CPM
driver's layout (see cpm_uart.h), but apparently CPM UART supports 6
devices, not four:

#define UART_NR        fs_uart_nr

where fs_uart_nr is defined in enum fs_uart_id.

Unfortunately, it's been so long since I've touched this code, I'm not
sure whether this means anything.
