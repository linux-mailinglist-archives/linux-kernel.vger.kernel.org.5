Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804380127E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379207AbjLASTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379181AbjLASTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:19:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417012A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:19:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bd8efb765so1484704e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701454774; x=1702059574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRNx8XSp+rNad6wmKaHqg85aiDCSXnZuwfkrOtNdpoU=;
        b=BA5D7Scf9lzSuxlprNbBwCdU81krcAXNl6a4S7VfjX6bEkPE4RcivDTvF4kaBiPjIp
         YpXdupAzMHUGLpBbJfWPlW4jKFpLEYrHvW+MaWjXbXF5jHWcC/Uim+bkrCeY0qnAUnoi
         EQuVDwgD5PreubhiE6cBNT69OJJNv4Uhk55jfms1EyLlNwRZBHglcAG2L8QIiqlSJdy6
         vfTO7dgjvhNT1gp747DE7btfYS3q4VFWxqi33pWqELXET3wOny3tcevOhH0zgeEQ4WXX
         KUPYoH961I2P4N8Va6z6I5eem7xvTx/Z7Ewm7B47EbawWyIUidRJKkaEjYcNsSMIg4yO
         kBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454774; x=1702059574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRNx8XSp+rNad6wmKaHqg85aiDCSXnZuwfkrOtNdpoU=;
        b=FluTHDN/e02GE3XUj+6P+Fu1zJInJ1kvWzEb0IIBgV2eQqEfq0SYxBE+yI+GBlO8Sc
         X4bLGEkN6+MQuuo2HhtfAJuS7lOYLvFSXFR+5b7eC8qcvO1VU+9TUtjTfyLXDN7nAtWG
         T7ZvMwQTBIQbQqd0+GhLI/NKDdSACN7HAjJobJbyO3XKXORuRNcY3jsPACnUQlnQ5rta
         qCTbm6GDk1hDRTzgSgVUvs0b5ktugIP2EgxnbK5F/gZ96W24jHUEZNj84aYE31GfvCa9
         ravQx/rOP958OqTFIZxfgf4sYUA9FBC4Rdm0ZSEj9xJReM93v56lamfokdsmi9y+bM/i
         NTUg==
X-Gm-Message-State: AOJu0Yy8KBWfXeJo6jMRJ4kICkGpWWQm5aTWpWONfEVK6+wlPaw1YRCA
        I4ehIXbcWo0fQBXLGbiV2cekSXPtjlt1AHlb76O3zg==
X-Google-Smtp-Source: AGHT+IEOPydh3is0A9u1QqwKnUn0BBk8fQSGt66RzZiVp8poYynp8cdiZswRdYGUYlw+N0X8qb2brdkVzhIO9rAMA38=
X-Received: by 2002:a2e:b0f7:0:b0:2c9:d862:c652 with SMTP id
 h23-20020a2eb0f7000000b002c9d862c652mr1076937ljl.63.1701454774162; Fri, 01
 Dec 2023 10:19:34 -0800 (PST)
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian> <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
In-Reply-To: <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 1 Dec 2023 12:19:23 -0600
Message-ID: <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> >         bool is_drop_n_account =3D false;
>
> Why keeping is_drop_n_account  then ?

Good catch, thanks! Will send a v3 to fix up.
Meanwhile, I noticed it is compiled with the
-Wno-unused-but-set-variable flag, is there a reason why we disable
this warning?

Yan
