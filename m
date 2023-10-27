Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0137D97F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbjJ0M0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbjJ0M0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E06E129;
        Fri, 27 Oct 2023 05:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1836DC433D9;
        Fri, 27 Oct 2023 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698409566;
        bh=40awDpj8t/P0Fjgu0Xs9iB5f6HCN4KxGA43DVPjQQA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WnmWaPgqN0NlXCTW+Rp3IpUllrg7flEIbffPw96cMvOzMah44V1pqLti007hq2dRU
         TPVQUzOenFH1PeTMvk4H/BWucapfaGDp7YWVhtUV5hpVObVhn8Kr8F6GQ4rgSMEH6C
         DmCP2bgAMsemz/iAA5HV2LIM4CMoPiAUaYm8rHXNyIeehSdveDQINev1nJKPhfs5FJ
         ayZmvReDvmV/7EHtTivLdI94C19XuQvyOSE+8rp6w7LaFBxpKyAtn4Z0ZL5swLzAAq
         Edlhk4O0v3ALc+OKYCP/kXnT5mjcQ3cvunHbhuhPhp4J4R/DrNGEvJdff4G1ia1YGZ
         H7/1ULNAyT+Pg==
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-457cdfc293bso905477137.3;
        Fri, 27 Oct 2023 05:26:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwiZ3Oh6cICnJeSk2mMLNIe0KgZiQDc6MZ5x7fD8SUJ+a0uyvNX
        1w9na389ziD+9M/OAuhRlLDEOk9Pw4i5/QAnF/s=
X-Google-Smtp-Source: AGHT+IGbXsdqt+Z/U+WYrZeZRcYXTYor6c4j/BJOyxqSqwLy5mXvP0sJlUWZqUFvbWlURZMSFgl/AEhxOGUtZpGwY7M=
X-Received: by 2002:a67:a241:0:b0:457:dae3:4895 with SMTP id
 t1-20020a67a241000000b00457dae34895mr2656437vsh.34.1698409565144; Fri, 27 Oct
 2023 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu> <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
In-Reply-To: <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Fri, 27 Oct 2023 14:25:48 +0200
X-Gmail-Original-Message-ID: <CAPybu_2gya-XP2-JH8roYgyROUAeTbVBaY1ypMKyVp+ujb=t6A@mail.gmail.com>
Message-ID: <CAPybu_2gya-XP2-JH8roYgyROUAeTbVBaY1ypMKyVp+ujb=t6A@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: i2c: imx214: Move controls init to separate function
To:     git@apitzsch.eu
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
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

Hi Andre
On Mon, Oct 23, 2023 at 11:49=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitzsch.=
eu> wrote:
>
> Code refinement, no functional changes.
>
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>

With Jacopos comments (don't use de_err_probe())
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

> +       ret =3D imx214_ctrls_init(imx214);
> +       if (ret < 0)
>                 goto free_ctrl;

It seems like we can mutex_destroy a non inited mutex. Could you send
a follow-up patch to fix that?

Thanks!
