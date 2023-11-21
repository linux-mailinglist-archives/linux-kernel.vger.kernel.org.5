Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D907F31E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjKUPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjKUPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:05:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F651100;
        Tue, 21 Nov 2023 07:04:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf74ad87e0so2195855ad.3;
        Tue, 21 Nov 2023 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700579097; x=1701183897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MamKMnl7Z6RhslBmaPtWYRegLQ83xlkelf65TWw0tPY=;
        b=KC7MhirZeeyNKeMbUeebN8m8NLHo6zepgWNNtd7G4ZHne/m9M92dHCWGmD9KiksfZA
         hNQq6a8N8+wMSOiIC7+kD0YhmlBJKgytGIW8r8KGp30v/3/iHuuAcYgD3VMU4irpVp0K
         JBdSK57vqKFoGq7ObXV7sgVOb5GjROXOvn9GL97qksha8FSct3WKOkrtIc9d6Bw6+JeU
         n+RMsLo04Y26wk6Ht5a3cfz2fBUaFmBEokhH8azgC5uTidoXsdYdU0XG7pW4yoL6URjv
         a6hmKaCXk3krE+x0MrcInRoNBQK0e/Wx4oZEf36gvN6kLSFOi77aE2NbX/mL0mGnPJwj
         u4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579097; x=1701183897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MamKMnl7Z6RhslBmaPtWYRegLQ83xlkelf65TWw0tPY=;
        b=VymDVQYVuq/4gfhuntEJDhyDFZ+poKiYmYenZ9bU33uFYlL799uUsR8hMDD8HsGCLk
         iM0pZeDOm9oZtvPEnyJ/aXkCnwLF/CohVn0zn+pvy+OUz5tInyO8eOCvP/47G2C1IBbv
         x6E77r/tL+S96Ith1A5YMYtj7/gT7V8ckQRjOJiroQZFG9ZryTbEdmXjGJ1Mlrh6rq/C
         Y/HeTaKqU2QLYSQ1006O9gK8NWKiwE9sOnth2X4GwF1ertHTQMrifivdtBPaT8RwpCKl
         Uic0hrXgigIaqbLsFysdR3Yk4sj8n2o7pMxMFKeywNdy475eJTT+3N3oaMZZkU9JKY1J
         prtw==
X-Gm-Message-State: AOJu0YzubVnNxMaubS2KHau1xZAPZ9o0kRBpKwEazjYzJrw9b8kEW9K7
        iCh3Z80rHmJJctMOBRbx0sk6BpZciB58vLAfAGA=
X-Google-Smtp-Source: AGHT+IFkLAr3UKyBfJx63XKcpts3fBxCuou9eVwNpuLmQdvia19EFwfrxo8iP2EARsuS6wwTlwwRa2NnMwT1CO5pOiI=
X-Received: by 2002:a17:90a:a395:b0:283:2932:e90c with SMTP id
 x21-20020a17090aa39500b002832932e90cmr11720736pjp.12.1700579096540; Tue, 21
 Nov 2023 07:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20231120175657.4070921-1-stefan.maetje@esd.eu>
In-Reply-To: <20231120175657.4070921-1-stefan.maetje@esd.eu>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 22 Nov 2023 00:04:45 +0900
Message-ID: <CAMZ6RqJiCk_yc_V_1=TkJ41KjTQpDU--Z-kEwdUugoxMbz3G0A@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] can: esd: add support for esd GmbH PCIe/402 CAN interface
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 21 Nov. 2023 at 02:57, Stefan M=C3=A4tje <stefan.maetje@esd.eu> wro=
te:
> The purpose of this patch is to introduce a new CAN driver to support
> the esd GmbH 402 family of CAN interface boards. The hardware design
> is based on a CAN controller implemented in a FPGA attached to a
> PCIe link.
>
> More information on these boards can be found following the links
> included in the commit message.
>
> This patch supports all boards but will operate the CAN-FD capable
> boards only in Classic-CAN mode. The CAN-FD support will be added
> when the initial patch has stabilized.
>
> The patch is reuses the previous work of my former colleague:
> Link: https://lore.kernel.org/linux-can/1426592308-23817-1-git-send-email=
-thomas.koerper@esd.eu/
>
>
> The patch is based on the linux-can-next main branch.

I left one nitpick in patch 1 and two nitpicks in patch 2. Regardless,
for the full series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
