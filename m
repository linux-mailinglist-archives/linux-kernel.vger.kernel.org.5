Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2287C9419
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjJNKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjJNKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:15:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650BB3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:15:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6492b415so24845107b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697278516; x=1697883316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAnTTZd/oNJv2+sQ0/p4aYX3rI9i+194grUqUEuTdNY=;
        b=Rw0W/28Tn8uk6oG1QozP6ZL9zcHVfnOP338lusjsMHdOTm3REEzPPy7piqVDx2QZjW
         KdlXl6QxEiVFPG92+W6rVv9bSZsCYaqW4qLv6qbWLWHtfEPz57qzH9khb4gamUc4CH2z
         mA7f1TyoRSzdgg54GGUfhUw4c96ESQxx56cG45LSpJeMudxrc99aB0+MZurY2kwkBcgN
         uFZhJeYLfv27lOL2P+AcZsUVFKoltU3Jna5zOEh/1NKi5pw5mmNlKWVbr6yMqW621c8o
         geUtX0DqrIpgFtMoSrdR5JPrxrHqRuBm0Un8dJnHjK5wOQeEgyR/6aOvE1t8qMqzpkB4
         MyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697278516; x=1697883316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAnTTZd/oNJv2+sQ0/p4aYX3rI9i+194grUqUEuTdNY=;
        b=qPamiM9T72Y8BFiQQu8v9pgfo2fLvPx0x6S7XLE6nO4BrX68xOjZxAMs92dbK4SosM
         3Wo25UkQaxqZKUmEANIsttGY/vIy/f1EejL/a6QQoGQjIFrzQ0xi8uGdZ0BN17W4Uq/D
         kiC4ur7Y+9wlQ4dE71/Xh7/oABdBh5Z78bD78SjPMFTic0TRWit+OsLETdmCscCXbRHi
         wIDa+E7Tft2/0KyNh952fw/Ub5wKCBgpng3YeHrLEqEjQ7Qujg7QljqCwXx1TOsgOhi0
         aSEBwj7hKttSpm7gBliueRBcQ4Ljnaf5ThxB92H2M8DEbdKHT12nwUIyzSahBgEM+FWN
         +IHA==
X-Gm-Message-State: AOJu0Yxn1B1PqzcKkRZicv533TVMeGNOaEp7lEVLdiL7o3lnJLMY87B8
        2wCAvpd2awnXap7cqolW4TDwwWk+7mHPBRufJzEFnaCI3oiyRw==
X-Google-Smtp-Source: AGHT+IEYeET9k9Qt04HFyvWvucYiOlGM7u/sgzP/p2kXn0h+m7E9plH1UqVRSps2fp0YUBVkvr16FJTS21IPszSGiXs=
X-Received: by 2002:a0d:e841:0:b0:5a7:b545:dcaa with SMTP id
 r62-20020a0de841000000b005a7b545dcaamr1372679ywe.23.1697278516577; Sat, 14
 Oct 2023 03:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
In-Reply-To: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Oct 2023 12:15:05 +0200
Message-ID: <CANiq72npYE=W6B5Ln42Tr-Z8kPQihQit3k=C_wdO1kcx_Dvpxw@mail.gmail.com>
Subject: Re: [PATCH] scripts/show_delta: add __main__ judgement before main code
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, ndesaulniers@google.com,
        n.schier@avm.de, ojeda@kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 13, 2023 at 3:29=E2=80=AFPM Hu Haowen <2023002089@link.tyut.edu=
.cn> wrote:
>
> When doing Python programming it is a nice convention to insert the if
> statement `if __name__ =3D=3D "__main__":` before any main code that does
> actual functionalities to ensure the code will be executed only as a
> script rather than as an imported module. Hence attach the missing
> judgement to show_delta.
>
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>

I am not sure why I was Cc'd, but the patch looks fine :)

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
