Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508A7718F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHGENT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGENP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:13:15 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B2FA;
        Sun,  6 Aug 2023 21:13:14 -0700 (PDT)
Date:   Mon, 07 Aug 2023 04:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1691381589; x=1691640789;
        bh=7uqzfhuRxSmBbn5ctX5ihwDULfyOnq19+Nj7KIe2Xmo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=h0S7t26u7xcb2g4C8yLrd4uq3MNXlS8pD/6KLwjw1XKZF0QwLkAKTWUyfR8eqPbT1
         SEkgLppMLCaEjrlJNt/H9x7mMdOtUdoSP8DpALvT3gferx3Z4PMiDjRyRrQmz4eS6T
         jEgAdz0pNxr1zcRgwSVoEvW+jMhyxYQx+tLQqxfbzWe3kI9aTFgiMproOx411jjvCy
         d7/bdYRwB6Arz//rRZ52Gqs+j3TCij9iXgFk3GSCLZZxRU8q3vdM6MbeVUv+JPF/0y
         KRSIp0uYScwe5HHA/FYYCMfhk/kpc+xtPYvwElHhfhd2auYS7fBok4qAQvEg7rULmt
         689aCSUodfmkQ==
To:     Masahiro Yamada <masahiroy@kernel.org>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: merge_config: Add flag to prevent unsetting config option
Message-ID: <875y5rsd6c.fsf@protonmail.com>
In-Reply-To: <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com>
References: <20230729214138.79902-1-sergeantsagara@protonmail.com> <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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


On Sun, 06 Aug, 2023 23:19:55 +0900 "Masahiro Yamada" <masahiroy@kernel.org=
> wrote:
> On Sun, Jul 30, 2023 at 6:42=E2=80=AFAM Rahul Rameshbabu
> <sergeantsagara@protonmail.com> wrote:
>>
>> Overriding a previously defined entry for a config option with 'is not s=
et'
>> may be undesirable in some fragment configuration setups.
>
> Then, you should remove the 'is not set' entry from the fragment.

I had a feeling that was the expectation. Just for reference, my flow
for generating fragments looks like the following.

  1. make allnoconfig
  2. make menuconfig   # select the options that I desire for the fragment

We can drop this patch if this is the expected developer flow. I
realized that overriding with 'is not set' entries in a fragment is
likely desirable, so I made this behavior change as part of a flag that
can be set by the user.

--
Thanks,

Rahul Rameshbabu

