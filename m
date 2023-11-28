Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94BC7FB091
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjK1CgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjK1CgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:36:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F382818E;
        Mon, 27 Nov 2023 18:36:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00cbb83c82so704843566b.2;
        Mon, 27 Nov 2023 18:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701138981; x=1701743781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMfQiZRGZNh8CgJ4/FyHU6ngG5/rgJQq7TyrI1Hz6Vg=;
        b=Fz504EKO2XZ7GxVTveKqqsBXkd6SgVf7FBb+Zh5eIzP1iMHGCt/DBSQKuhumdi4fbZ
         gt1AJCc9ZRRxo6YRSx29rKlidfLz5Qg8EBN6ZY/I4GidUT8w2bdZ8HgHvCbCwgyjg9TZ
         DoJczt883JhRezI3rrbPCCqjHfgR/5cxsXWd6/PaNbqLkWuQJamA8rlBSjolvIrlMXgZ
         aB6pvOE/HUfdv16s4LUM1OZfZs8SIK3mL5SnM++zekBbgxd0Wp5vWib/krSHaqyoCdBc
         0WhnqZwl3o9zADF7foeZpce45BRKEqVlRt3XMj9nATQ60RLox4y51PfypaLAJ935AkHD
         NZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701138981; x=1701743781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMfQiZRGZNh8CgJ4/FyHU6ngG5/rgJQq7TyrI1Hz6Vg=;
        b=QEVkbjFlmYRFZRUSuwKTJ1aRxdsC5HPmwn/S2GsuQF5ftHhFpbbvAASNJZhMdkA9uD
         pG6pihncfz7PynnY+KZXaRlF4oeG2nO3kf3AeMhj67yYpNeJlGyHq2Dpx37IFaqtR1r7
         ds0iRK4BrdZlEOMvKbU1IR6X0KwG9d1ToMzV013s38rKo8siRput3tdZoyLtljwpbNnT
         GlWuKbSszL+IU9Yd63P0J8Zj9EH/x3waCavdzf1GY4IOX/2KePfXkvatxFxer/mLimmK
         IKOocD4qRvE3HAx7/PayA6/Adi6bZx7Q8OBkH1ebd5uhxx7ZqIK8ZkZC7WjFICH/Cd7r
         JzwQ==
X-Gm-Message-State: AOJu0YxDf+vk0NFbFxKPFcc3i5i8b/Qom7p/H6UyYwzQvRiH+Dzy5C9u
        ka5UMNWv9wYBq/HmktIS+cMBk3a6YnVOPJsGgyk=
X-Google-Smtp-Source: AGHT+IFZHVqhstMsbHwZz+ZcsuCceHtOMAoSoOM72h7xOQf9lWwOG6N72/rf85Cz3A8SPR9FBUbCMqR+dBxO8sLLP/4=
X-Received: by 2002:a17:906:7497:b0:a15:ce29:6dcd with SMTP id
 e23-20020a170906749700b00a15ce296dcdmr113047ejl.7.1701138981283; Mon, 27 Nov
 2023 18:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20231126001544.747151-1-akoskovich@pm.me> <87bkbeei6g.fsf@protonmail.com>
 <7gnt80t5c023J-Vo_c1TvJFYJ3OOpw3iaxcEtXDhFQQLmnE4eKK4VZH_sjd6hzrTtG5GwLwvgC0lD6UAeEAxJwA7N9qGsxmgONPCyDD03IM=@pm.me>
In-Reply-To: <7gnt80t5c023J-Vo_c1TvJFYJ3OOpw3iaxcEtXDhFQQLmnE4eKK4VZH_sjd6hzrTtG5GwLwvgC0lD6UAeEAxJwA7N9qGsxmgONPCyDD03IM=@pm.me>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Mon, 27 Nov 2023 18:36:09 -0800
Message-ID: <CAEc3jaA4qJVSTKZmU+PN5zHhPw0NZmf_8XAuX9PkFBwcFdEfkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hid-playstation: Fix button maps for the DualSense
 Edge controller
To:     Alexander Koskovich <AKoskovich@pm.me>
Cc:     Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        roderick.colenbrander@sony.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supertuxkart uses SDL2, which doesn't have the proper evdev (or for
Windows dinput) mappings when not using the native hidapi/hidraw
backends.

Thanks,
Roderick

On Mon, Nov 27, 2023 at 6:19=E2=80=AFPM Alexander Koskovich <AKoskovich@pm.=
me> wrote:
>
> To clarify, I did test this patch locally on Fedora Rawhide and confirm i=
t works with games. It does resolve the issue, and is a workaround.
> It's not just Steam/Proton I'm seeing this issue in, I'm seeing it in nat=
ive Linux games like SuperTuxKart.
>
>
>
> On Monday, November 27th, 2023 at 9:16 PM, Rahul Rameshbabu <sergeantsaga=
ra@protonmail.com> wrote:
>
>
> >
> >
> > On Sun, 26 Nov, 2023 00:15:49 +0000 "Alexander Koskovich" AKoskovich@pm=
.me wrote:
> >
> > > This brings functionality of the DualSense Edge controller inline
> > > with the stock PS5 controller.
> > >
> > > Signed-off-by: Alexander Koskovich akoskovich@pm.me
> > > ---
> >
> >
> > Will provide a follow-up to the relevant discussion.
> >
> > https://lore.kernel.org/linux-input/P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZC=
Quqoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=3D=
@protonmail.com/T/#t
> >
> > Since I assume this patch was not actually tested to resolve the issue
> > based on the evtest results, I think we should drop this patch. Will
> > mention some details I might have with regards to the behavior you are
> > seeing with Steam/Proton specifically.
> >
> > --
> > Thanks,
> >
> > Rahul Rameshbabu
>
