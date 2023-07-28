Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2D7665B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjG1HqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjG1HqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:46:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F72B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:46:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso34433861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1690530374; x=1691135174;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uClO5JWTJKO2N7x/hBsNNQoelfp9s2hdwcR9D2N0pis=;
        b=VUa5J1JZkluxTMAOPfpnAfSjSutl0qDhfJvqZQvZR9ugDty+ej/Y9lxsuw9ae6yQoh
         0bEX36BF9IRk13H3D4ete1E3pkUiMD0DuT8HSMQCOZ8vnxOrTQYg7VjzFnf2plnfFzm3
         j3SoTmX4unVupBtoFJXbNlMxAbfn6C9Y58a/iFvjWsPHf9Dx1aqMJACrhuyFq0/HxLfQ
         57PLeH8P4sLX6PvzzkLDk0hI/KJgbAt/6mTqu3m8d0v+4Am/gCFjBaXnhnKeJHro+tcL
         VvhDg2ghhBABgPIhASrYIt/5vu2/qR/yNE0ibZJsnRS72OnCBFaxiDWui7JC9SEf0ujE
         g//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530374; x=1691135174;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uClO5JWTJKO2N7x/hBsNNQoelfp9s2hdwcR9D2N0pis=;
        b=K2QLNjXptY4aNT539vXrXKJz1Uvgc5qpDIewTZtPdgh36kM01WM016QilrgNoCs8jo
         DS8aul8AoXuILyP/jkevrF3GDe/thmmIjWEq1RKBrFfU+lX4ZFWM3QkoZBETFRxweozP
         zOsp0YiXGtS10HMys6yvZjUbpqWIfUz7cG5LWIiSVgi7U2Jaqe5S0Kzm1YVDgfqi5iZ4
         8grO+mQZTgRQX8iwaG49ypLwjduQxg/S4gWHppW3Y6hFCkVKDa1ewbSP4yFFe82WpBUF
         a4XUXoFntf5Bqo3f/L9rdRvy0QfKo82muNNbdjHZmhTVpfasbsJLGWKuigRisT8tHsqP
         x2qA==
X-Gm-Message-State: ABy/qLYBnQQez07wYbimCRF/06iPMNbFd907fUdD6GOCB+N0zYFQNF1c
        btoiWdMMISsBDYc7IFNTd1iTPWHa31Z3W/FzL1lYN8UzntNR8VPQ
X-Google-Smtp-Source: APBJJlFtBzRTbmmBx+JMzqlmXO1DrW7C+yRC6z0vScX9LCCYdnvUu5ola2ZuLWGNejxruag4G022+N3lQs7I3keE8qY=
X-Received: by 2002:a2e:880f:0:b0:2b6:d03a:5d8d with SMTP id
 x15-20020a2e880f000000b002b6d03a5d8dmr676774ljh.6.1690530374290; Fri, 28 Jul
 2023 00:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151146.1459250-1-martin.fuzzey@flowbird.group> <168747606054.325012.10021476177510722363.b4-ty@kernel.org>
In-Reply-To: <168747606054.325012.10021476177510722363.b4-ty@kernel.org>
Reply-To: martin.fuzzey@flowbird.group
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Fri, 28 Jul 2023 09:46:03 +0200
Message-ID: <CANh8QzwYAEeLhgBfaVY4P_2_-YYfpvAgbdK2EpqAqb8LMNBvCg@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: da9063: fix null pointer deref with partial
 DT config
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

there seems to have been a mix up here.

On Fri, 23 Jun 2023 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, 22 Jun 2023 17:11:02 +0200, Martin Fuzzey wrote:
> > When some of the da9063 regulators do not have corresponding DT nodes
> > a null pointer dereference occurs on boot:
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
>
> Thanks!
>
> [1/1] regulator: da9063: fix null pointer deref with partial DT config
>       commit: b9e6bee2bcb144d0eac0ac3d8826ae73c54a50df
>

I originally sent V1 of this patch
[https://lore.kernel.org/all/20230616143736.2946173-1-martin.fuzzey@flowbird.group/]
You gave a review comment that it may still not work with some
compiler so I sent V2
[https://lore.kernel.org/all/20230622151146.1459250-1-martin.fuzzey@flowbird.group/]

There are replies to *both* of these saying they were applied.

But the code now in mainline 98e2dd5f7a8be5cb2501a897e96910393a49f0ff
corresponds to the V1
This has also propagated to stable now.

So I'm not quite sure what happened here.

It's probably not really that important, the V1 works on my compiler
(gcc 9.4) at least, not sure if other versions will really have
problems.

Regards,

Martin
