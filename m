Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1587BCFF2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbjJHUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:01:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF8AC;
        Sun,  8 Oct 2023 13:01:37 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a200028437so48265217b3.1;
        Sun, 08 Oct 2023 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795296; x=1697400096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN2ZBxUx7Vih05MrleQq1aYrTxYKCR/M22bSzjoctzQ=;
        b=BydTdDQzcip/UKtHHK08oKfYqca9zVSOhPbjQ4P9TLuttZzuuXBeqNFsttSHUXFoZi
         7PHbszcRCUWCIsOhyTsrYTCSxBBqVZvGD2un07L3gxj/fB6fuEp9PtogXHfXYxGeWZbh
         9MNI5vgg87InzG2addRRqIATft+KGnNpv7JoOQb5jC+TyBJZsAH0HRyykP4gtR8gw3g3
         ayAJVihDXK2Fvw/T4HQ6w4R9UqvThJMEjQRQulTQXHq0YQc5wvmbR759O0Dord83HKJT
         CHlknt2v5MhG0BDO9Qg7rQqTyOptGC9hEjjUbEYaYJO+jfdPfbmUkimvP9zLUIWOCHBj
         MZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795296; x=1697400096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN2ZBxUx7Vih05MrleQq1aYrTxYKCR/M22bSzjoctzQ=;
        b=VQ9fUIrmHglqXz8LoD/s3OwAw7jP+YZJzoTjX/Y5ZRlSgmYV85Ln8cQCj42J3G/tOf
         6SxZGRbJ4JkucjN4yATNImayRuEsj5r2DR9tl61Q/VQWADaWD7oHNeXMM+zgs5Htc1Uf
         +C8XCBuhDyTewZXiit5k1/Ih5L55/mSthZrW6omjb9oseK7cSR7+w9cmNPzbAjgdj1T+
         6+ONaj7jMtAlA4bUYpGD686Cs4i6OazEZXNudA+et+O7zEifUaT4lidbIpbeQWTwAPs1
         xZ4iACnnc1hZT+1DehJIG4PmOF0+nHBDpyL0yln8eD09DBlYAWQ/Ua/g6WtzilVRWXlo
         VDIA==
X-Gm-Message-State: AOJu0YwQG2FvG/Tv0KyquE6TVIiu2ggNm6UayF8KI9YBR/SP4XYdk2MT
        iGjsNzLQVF2JMcwC1+bS+JAqU4w+Rewh1dtvhJ2LUd33jS6xshEW
X-Google-Smtp-Source: AGHT+IE3jCsd9cd/xkG1ckZHf+MojPTjTuBpg5rUJ4F6U/kCaPo7Tph0wH+4fZp7K+tjrEamthac/E8E6se7MYRrRqY=
X-Received: by 2002:a81:8141:0:b0:59b:1763:bff9 with SMTP id
 r62-20020a818141000000b0059b1763bff9mr15987232ywf.49.1696795296564; Sun, 08
 Oct 2023 13:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230906204857.85619-1-manmshuk@gmail.com>
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Oct 2023 22:01:25 +0200
Message-ID: <CANiq72=anYqsFqW+XL+b43rHcRvSqA+mrFU-R06oBWg8ZaQ09Q@mail.gmail.com>
Subject: Re: [PATCH] rust: error: Markdown style nit
To:     Manmohan Shukla <manmshuk@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 6, 2023 at 10:51=E2=80=AFPM Manmohan Shukla <manmshuk@gmail.com=
> wrote:
>
> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
>
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>

Applied to `rust-fixes`, thanks everyone!

Cheers,
Miguel
