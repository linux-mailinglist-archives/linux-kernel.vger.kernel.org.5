Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2B7B3A38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjI2Src (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjI2Sra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:47:30 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9211A4;
        Fri, 29 Sep 2023 11:47:28 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a21ea6baccso29842747b3.1;
        Fri, 29 Sep 2023 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696013247; x=1696618047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcd+XSW5Wbey5vsIAZJL9mSCtFx4gk9xTBQH8ncGL5c=;
        b=ZxbvLvCGa+3LbmZWDIzGiUfM6Y8O8ktkhyjJV0OONnKu6ruwRPldOkoA+XNVTVDMI/
         7lzb3i9px/67/ScWYOBgkQJa6uFk9QvCogCJSXIkHHcldyn1tuyaalvJl4p91myINgKa
         7ga74Ofr7gprov3aK9fx84TjbZQQ2mayBfivqLc+Cd+3d95rtkVK4UIt6NhQpbgw9s/l
         DwYw4/q4cUMBeP7wB3TNMbItKNdDFW9lzP3s3Dj93mkhNMEMwGitY1xHU58II1fSfU2l
         6RyXYrBXVzvx8ufRQeN8HhC5DpFiDq/4BZ/omn4JNwHUg8p4Iwq9zg8UhgBbVx10NeV+
         busA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013247; x=1696618047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcd+XSW5Wbey5vsIAZJL9mSCtFx4gk9xTBQH8ncGL5c=;
        b=EFqUOe8TUMlh3cqJ6K9IEB6DyqhDmDrgI31znTgW1WZtUxeHRY1bf90k0+FTr0d8Zj
         cjeorAACRosBwNaLGS8le/ZcaJ2PuC/JqfshP9xS7D3yhOd2Q8MQbIH9W3ZnCSOGAIeS
         SFOt4aUdYjyrukBZCF6sKbVmaFpS8yT5t+Q87XLoeDpfz3llwt9oxO3DUOh6Ou8uqQrS
         lDqPdvWbljfESF5DOW3jKBFInPkxBJX2QLAX7ieRKD5hzIymb4/q1LtGGq9UcCLxTlEx
         GfS3RYE4/7zKbYm2/UKfwdJfTa0PxA3+RDOvCSP3waRvv+4tPooQPNPQ4/C9ponwElQt
         kptw==
X-Gm-Message-State: AOJu0Yxj3V9DUs2Bm41SC0XgXSHQVjjjAYJS5w9aPcMx/WqNIGfMJrUG
        4BJ0P4ybm+fp+I68ie43peRHb+6VC3uDlxrWUnw=
X-Google-Smtp-Source: AGHT+IGd9/GxIKuVqQ1RpKyY96X0iIdC9CzLvnixNuwek+jiCmsukcFRkPICaAUT35lOXvSrpoE88Rj7o8gjRDG2jWs=
X-Received: by 2002:a81:6c17:0:b0:59b:eb5b:fbbb with SMTP id
 h23-20020a816c17000000b0059beb5bfbbbmr5330541ywc.12.1696013247246; Fri, 29
 Sep 2023 11:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
 <169601293865.3008733.731908758021441164.b4-ty@chromium.org>
In-Reply-To: <169601293865.3008733.731908758021441164.b4-ty@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 29 Sep 2023 20:47:16 +0200
Message-ID: <CANiq72micfYv6uLTH8fWDbs_j_Xr0p7dEs=3hjJAqFDuB2pDTg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: panel: refactor deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 8:42=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Applied to for-next/hardening, thanks!

Thanks for picking it up!

Cheers,
Miguel
