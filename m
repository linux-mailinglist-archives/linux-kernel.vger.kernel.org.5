Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D217E1A80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjKFGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:52:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09CF2;
        Sun,  5 Nov 2023 22:52:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2802c41b716so3351974a91.1;
        Sun, 05 Nov 2023 22:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699253547; x=1699858347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bviLxA9QNdIstU/q8Z042feuvD4EaOTMHTUZ5s5WBZ4=;
        b=YeI3yy20zOTq2eiHR1TDItV616F3z7EUlis54FrTnsmdhmB//BTZ3yZUPiJiTZp7x2
         eDKSqeKOY8FHOwzGe6lylUQyyaK1JY/ouC5mlyTDSnTnzHPePqR/jxr8vvz4amfaAqen
         wd6Ba/HOHbxZxM0G3XshKziGpDTUyNDSylMJgmng1rblx403sKln6EYb1lM3SrxnSTBC
         r6r1KMxHGWo8MMf628KSTu1bhdO7guQv3igO3zgnE3hwOQ67zESaj+IbKq2/POaVCakR
         M1TMt9i1eHpJbEmBh0xFcvC7iTcxfsfk13ewmZxhmHrP0j2h1UOqAbuXwomYAFPmtNtt
         ZthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699253547; x=1699858347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bviLxA9QNdIstU/q8Z042feuvD4EaOTMHTUZ5s5WBZ4=;
        b=hmIYcWcMP8rhQSpB16ztcxh13X6p5Xa8oTpc2Iw7pnE7Ed6nj9pmMl4Imqw0xux5tL
         NQ5cuPzLAsmwa6uxhnnbYwYvinVtLuoy70oKgJ+wUYzRCTVQ/umArRlHKByy1hUaiBMO
         5GG0COJxs5HnqntVHe7KOHqUQJNqhrdECW1FG8xGLpKVt1Y4a6t5skIvKTHTT7HUFU2n
         dAGUGH39YdGhG+OW2CFeU64fcO5rxJO09jTNijeBvh/uVcb8BERibDSxABrtkOuThHZu
         OcHnXyqtD1N27jPYcRHzprDoR03TTL/61a0iNz+jwbowD2SwlSLlUHIs7MBJ4lC3lmWp
         WhsA==
X-Gm-Message-State: AOJu0Yy+BQDnBT2ei6hAp5Pvsqy3F7QH5camqLdSjKV5cqOTPX3dr8Qh
        EH2VJEcVjfcb+sk+rziUw6kg55lAGsMi0XIsUpI=
X-Google-Smtp-Source: AGHT+IH0UsoRI9qSbDMkZLg8GKhuey+R/ZxL8cN0JuTvG/kGi6E7pvI+gBl7zzbU0OCpWZ0FZGDubJtg1T3QAZtnMRA=
X-Received: by 2002:a17:90a:1a0b:b0:280:c576:31b6 with SMTP id
 11-20020a17090a1a0b00b00280c57631b6mr10365842pjk.39.1699253546534; Sun, 05
 Nov 2023 22:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20231106043957.815407-1-zyytlz.wz@163.com> <CAJedcCxoDVS-7jVwLvsWOWiv0aObyYBiG-GmqX4bq+Qp+i3iTw@mail.gmail.com>
 <e783dbcedc9b444ca2651d2eac036d6e@realtek.com>
In-Reply-To: <e783dbcedc9b444ca2651d2eac036d6e@realtek.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 6 Nov 2023 14:52:15 +0800
Message-ID: <CAJedcCzWkozTPHd6Lm7uzxZHyxzZw1zQwb=LBzuGRbCw7ThmRQ@mail.gmail.com>
Subject: Re: [PATCH v3] brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jisoo.jang@yonsei.ac.kr" <jisoo.jang@yonsei.ac.kr>,
        "linuxlovemin@yonsei.ac.kr" <linuxlovemin@yonsei.ac.kr>,
        "wataru.gohda@cypress.com" <wataru.gohda@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80 14:43=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Zheng Hacker <hackerzheng666@gmail.com>
> > Sent: Monday, November 6, 2023 1:16 PM
> > To: Zheng Wang <zyytlz.wz@163.com>
> > Cc: aspriel@gmail.com; franky.lin@broadcom.com; hante.meuleman@broadcom=
.com; kvalo@kernel.org;
> > johannes.berg@intel.com; marcan@marcan.st; linus.walleij@linaro.org; ji=
soo.jang@yonsei.ac.kr;
> > linuxlovemin@yonsei.ac.kr; wataru.gohda@cypress.com; linux-wireless@vge=
r.kernel.org;
> > brcm80211-dev-list.pdl@broadcom.com; SHA-cyfmac-dev-list@infineon.com; =
linux-kernel@vger.kernel.org;
> > security@kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v3] brcmfmac: Fix use-after-free bug in brcmf_cfg80=
211_detach
>
> subject prefix "wif: brcmfmac: ..."
> Try "git log --oneline drivers/net/wireless/broadcom/brcm80211/brcmfmac" =
to know that.
>

Get it! Thanks for your kind reminder.

> >
> > This is the candidate patch of CVE-2023-47233 :
> > https://nvd.nist.gov/vuln/detail/CVE-2023-47233
>
> I think you can add this link to commit message as well.
>
>

Will apply your suggestion in the next version.

Best regrads,
Zheng
