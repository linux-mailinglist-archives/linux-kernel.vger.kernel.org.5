Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A224777789F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHJMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjHJMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:37:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0D1B4;
        Thu, 10 Aug 2023 05:37:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9a2416b1cso838563a34.2;
        Thu, 10 Aug 2023 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691671064; x=1692275864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9vkH0qyALcGdJXi476zLeBAUKcf5jFE0hRhwzDsk6o=;
        b=EkMnV8P7+dTgYEUW9GmPoATMW5SwYOsAAUEw5gC2SKDsFigdoSRpce0Mmz35fjVHT9
         0heaokZlsIGqon12YgPz/GPrwSCo3eqssCJThGBs1lfy0GLWI5H+Kl2smfWsgUgB4D1e
         z7ZjL3hFafN6q3jTcF2uO6GzoVeHIog3P/qXrY5Un/87gJTOfsc2Tqa9ucqDzpMhqSyv
         61TVwWWa55N99Wf1jr/fjXcBV8SLaC1gJD+v3Y4TrzrtYVZHqHv3QLrexfr/50GNBJvo
         IU2rq0ndxPWoOVsh6ywtokSPGVwdpeSeW+wVpAwU3tM6pqdexxcjP41KB9m7/2J82pOH
         6VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691671064; x=1692275864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9vkH0qyALcGdJXi476zLeBAUKcf5jFE0hRhwzDsk6o=;
        b=lX5KNAPGdLyz9sxHXepJPnq8l+Oywvb8LaucsPJdiKecr1Cah2lsoQsJjWpQwR4UzE
         cBxZrJEY1XFKwTMB0VHTTHGs7pcoxATwvd7WekL8c949m4ROYsmnpjaLIqcmm8Qm42LJ
         aRX+P1PXH/qxQo4ch6Q6/WFPGT1oWd39rRRjUp7husBb45sDqISRHoTRarhRJ+vSurAD
         emYyjhETPLz/v4QyCmYbYRkSZQU3AK7PfHAhhJNcYxTflAJjZhMdqlkYVm1tUGsz/5H1
         27VxP3AH7WITHzpoPOZxrQRYQLaYS07gibku32GDT0wDdh/tzJSoa9zVzciPSvpPG4xP
         r3NA==
X-Gm-Message-State: AOJu0Yz9wWDMKi8bAD3dRxapmYyvQyT4u6c+67etC7xGxq6sZY/xmDWG
        0JvpfVqlgBnDjh6OYHUO1ru3GMfdzw57XIjy5aY=
X-Google-Smtp-Source: AGHT+IHayVyAACF3oRIWlkC9v4KwPLwDb29FR1roLZ8kL+KRpCCiDtziSCko5idF/mEFYYH+z9ay/juk/17NLedao98=
X-Received: by 2002:a9d:7517:0:b0:6bc:f276:717f with SMTP id
 r23-20020a9d7517000000b006bcf276717fmr2771951otk.13.1691671064642; Thu, 10
 Aug 2023 05:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230810091510.13006-1-jirislaby@kernel.org> <20230810091510.13006-2-jirislaby@kernel.org>
In-Reply-To: <20230810091510.13006-2-jirislaby@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 10 Aug 2023 05:37:33 -0700
Message-ID: <CAMo8BfJ5EBausUzk7u6LyNRm+Ybtbyg7LG0_hvYN30kZz8ECTg@mail.gmail.com>
Subject: Re: [PATCH 01/36] tty: xtensa/iss: drop unneeded tty_operations hooks
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:15=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> All ::flush_chars(), ::hangup(), and ::wait_until_sent() from struct
> tty_operations are optional. There is no need to provide them with
> empty bodies.
>
> tty_operations::put_char() needs not be provided if it is the same as
> tty_operations::write(tty, &ch, 1).
>
> So drop all of them.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/platforms/iss/console.c | 24 ------------------------
>  1 file changed, 24 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
