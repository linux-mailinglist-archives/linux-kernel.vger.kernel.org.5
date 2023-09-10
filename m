Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F94799CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjIJHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjIJHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:40:31 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD219E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:40:27 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57358a689d2so2307455eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694331626; x=1694936426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o7PZOATBTTYuMJlCCQhRQy08FMNMBBk+dHuox+/SXI=;
        b=XHQS9+Fzy+PCsQfCevEEGnTCp2xsGH9IUMyIDGot1pA55+Wud73KIPkRmLOq7IPk2o
         DfogRf8D8BErdIynB4ZCviohcVSthZmAl6VqtvVSxYWXfd83uPyzx6xNHbvMtQB+/S2t
         R/zT9jWKvq38+kvtVNTrj5TuRa/9+p1Kj31/GHP87+xb1hnTra7/wN8gl6wcDczZVu0P
         tXZ38gNx63nHTRmzQqWyz4ru1BT2EaoLwGsoDqijoIAoAbLkD3sTNhj/A/WJWb5JzZ3j
         qRcLbVwk0GLx3w6SuePSjku6W7ILGrjZrFbjqJMB6GVCYyzdX96rhpSKiCM5O+i26loH
         wg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694331626; x=1694936426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o7PZOATBTTYuMJlCCQhRQy08FMNMBBk+dHuox+/SXI=;
        b=X1gBurXQEfGmS6jBOblk4o7lpjDy7iTquwepO8rU8rruXIGTwRTX2xq4GP8UK8fzN/
         TvcBQrSOEYXWQCGYxiUVhqAxO3EN0+wh9WLqLMvtdxenh82deUhhx31tm0K4WAxjWoJO
         Lv+K/hLt5C1TacJLdAtUfz8fObH4l0u05u8gxjZhxGw2Y1SDiHZeXP0/aG4H694D1dHw
         qHhpr8m2yX2ECB/c4ZetVzUsc9SVNFYwnQ2ASSSl06cHJlL+JAs9YWZJTa/9mD6Cx3+Q
         d5U2thvQFklg7TyXbHis+2yXizr93+LK7n06orcCnHgIheVw1hCOqEVbUIC7g7F34oF6
         kfWA==
X-Gm-Message-State: AOJu0YwZugKEoE3AJPLYfaLKaOFnC/5moopc2tvbIG57+2Th5b87P1Me
        oEXhcNcki1vVVkQ97muTP/F+k7XstpxtrecZw7SxiVjHGSo4Pw==
X-Google-Smtp-Source: AGHT+IGSox7Pn9mrGWK7033AhCw6BmCMFELDvmxyqMzP45czb9yGsyiwnua+StahE8sLEmjN9uC41CkxQWkofgPkX7M=
X-Received: by 2002:a4a:a2c9:0:b0:576:8b2b:1ea with SMTP id
 r9-20020a4aa2c9000000b005768b2b01eamr2621679ool.2.1694331626502; Sun, 10 Sep
 2023 00:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135840.2362708-1-masahiroy@kernel.org>
In-Reply-To: <20230908135840.2362708-1-masahiroy@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:39:50 +0300
Message-ID: <CAHp75VeBgnf77z4z=h2Earud1=ssP3--29v9gkWfjig1AV+AeA@mail.gmail.com>
Subject: Re: [PATCH v2] devres: rename the first parameter of devm_add_action(_or_reset)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
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

On Fri, Sep 8, 2023 at 4:58=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> The first parameter of devm_add_action(_or_reset) is a device.
> The name 'release' is confusing because it is often used for
> dr_release_t in the devres context.
>
> Rename it to 'dev'. No functional change intended.

No objections from me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
