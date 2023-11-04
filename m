Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B87E0EAB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjKDJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:46:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30CE5;
        Sat,  4 Nov 2023 02:46:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so368130166b.1;
        Sat, 04 Nov 2023 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699091167; x=1699695967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3et3wokcaM4JMqKEyF7KHOhIdEs2zSUOjJjE3wuxjU=;
        b=BTgzUNGj5ZmITLjFULyI4U30zPfzBqTtVG3CaSpWk7b8Zv4awacGnr0K/c+bYZjdSe
         F3WImZ9KQV4SGGtmMDUEXRgQ+mvel2do8sgh5bFV5ya4EhSrN7YJBdyTRilFuKJ8i9ZB
         o3phymhEnMKk1Tbyfbwlin7XzJ7LVAIvKETMkX41KS0jbaSRzgI/OAya7y2bpINbXV9N
         hDkh+q3Jxzf8zSkFu1oDx8D6CbWwqDm9DhE27BoPQv8SHrIdggqqNyuJFsk2WDpKuqrE
         DCebct6htoMBp2ZIJ6WHbMr6xouSb83a6oiO4h+bT1iN/KT8ivACu/K+8uFnEiC/oDrs
         NaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699091167; x=1699695967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3et3wokcaM4JMqKEyF7KHOhIdEs2zSUOjJjE3wuxjU=;
        b=mhv2C3KBuWvH4silnsASlbxQqmFLUQuzVigV7rFk+Fl621r6H6hubbpGoOS5lr18F0
         vPx04WjbfIxP/y8Jza1FGRHgXJxO6mQOLjAnx1vHoBNQon4REKEcmRsUEK24TMs3BuYG
         UUyZA+HSs1MwnycDA43cIH+VIrK06RQVtM0rkKDV3zOoDW4J01CYCa1k0/X5QIp0y9n/
         g74YAyeC7WpNVxQDunnooFIrsxhGM7ZC8erOUsQtuwbObQhL4bBU7ImLoVjGjce4hMHY
         uJEj1bePXSvtcDgABVzQ/ZT08ITDpkclXBeEN9PowiuOVQfAh6Nxnzhptttkk2ClMcHI
         hKdg==
X-Gm-Message-State: AOJu0YywrPnCeSNjCk6x8hIsNwaiNCD6ex8YKIvCkBunLuIO3ZpewzJr
        qttrzRoD7Pj5qQVXgz8J40I8nZNsSy6nQqkn1uqhUK26uUyXyA==
X-Google-Smtp-Source: AGHT+IH2ZQ9sKxxj6jsFs2ZCXqEkRxXgn7scMcRKXvEJGilUR4807EaDhSgWMdAZaFSrkdI4oyrHhmxvl0BCHYLCyWU=
X-Received: by 2002:a17:907:2d91:b0:9ae:5765:c134 with SMTP id
 gt17-20020a1709072d9100b009ae5765c134mr11169301ejc.15.1699091167433; Sat, 04
 Nov 2023 02:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
In-Reply-To: <AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 4 Nov 2023 09:45:31 +0000
Message-ID: <CADVatmNcq94zF=SfSudmgzfoT92ytyOFYZEYqnYObDfja5uVxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 RESEND] parport: parport_serial: Add Brainboxes BAR details
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sudip.mukherjee@codethink.co.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cameron Williams <cang1@live.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 21:08, Cameron Williams <cang1@live.co.uk> wrote:
>
> Add BAR/enum entries for Brainboxes serial/parallel cards.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please take this series after the merge window is over.


-- 
Regards
Sudip
