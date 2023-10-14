Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B97C93AB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjJNJJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:09:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC5BF;
        Sat, 14 Oct 2023 02:09:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB373C433C8;
        Sat, 14 Oct 2023 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697274556;
        bh=QMKGeVOd3CQqoQwVajdhLaEh2KmBVSf8R3WFPYadptc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZWvF6fhPJyRBXJV6sf2vMWNoPu/ZNCKgiUmo0OQXjc/z03PSmpR6MbeNUKEdo1w4
         m8QBx2FruJm9mxg+hHrr6iGRH1hB/t61ooXfrX8ZKg2vICkEBGpyBHJSXPP7pNVf8P
         /Nv1p7C0+uXxUjchzbq98DaDOoQcTu9SkfzuaTJwIf6JwPx3/dmQugsWZqfDx77sVv
         L2B3sqkAwG12YedKz3eeTDZcqR+B+eIVo06uwynAjrqQFqsVwza8dzmdhq3n5hpCxH
         O2BHBQAx05gFteBHw94KFS986YvVFSjOlg2SRCQXiWF4MkjoSCwGINQSDuMzAldz+3
         VCq8BYKf+YD3Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e9baf16a86so1426864fac.1;
        Sat, 14 Oct 2023 02:09:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyaUxcAhjCog6pLv8U1QVblb2HpPSBZ1p9Dbv6CZEtgLczxHWik
        yuugxxmAP3mw2M0BXXkN3RIoQB7uPiuPPduhr4M=
X-Google-Smtp-Source: AGHT+IHedrA3UMSJSZgJvBvP0ejVRXx5lRC+UJuOuF1WIWquOiHBeVkX9c2aoRHTFlsXmzRC+2SAleIJLiufg2NmOCc=
X-Received: by 2002:a05:6870:a99a:b0:1d5:c417:503e with SMTP id
 ep26-20020a056870a99a00b001d5c417503emr32560193oab.57.1697274556176; Sat, 14
 Oct 2023 02:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org> <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
In-Reply-To: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Oct 2023 18:08:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPupf+iMNxs7gNAAm15Y1Eg8eXuZTWwVai23heZE8FjA@mail.gmail.com>
Message-ID: <CAK7LNAQPupf+iMNxs7gNAAm15Y1Eg8eXuZTWwVai23heZE8FjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] csky: remove unused cmd_vdso_install
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
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

On Tue, Oct 10, 2023 at 12:16=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 9, 2023 at 8:42=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > You cannot run this code because arch/csky/Makefile does not define the
> > vdso_install target.
> >
> > It appears that this code was blindly copied from another architecture.
> Yes, I do that. Thx for pointing it out.
>
> Acked-by: Guo Ren <guoren@kernel.org>


Applied to linux-kbuild.




--=20
Best Regards
Masahiro Yamada
