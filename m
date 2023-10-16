Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E57CB139
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjJPRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjJPRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:20:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B53A1;
        Mon, 16 Oct 2023 10:20:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so32782701fa.0;
        Mon, 16 Oct 2023 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697476821; x=1698081621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWfEcOW2L2k+xynXBCBlj/nQZn7LeFqtR6Gjd7zepfs=;
        b=VpGn/ARFON8bf7cvF72LX81UPmIOQUSVDZp8NPb4R4CbjqYfEmaiyY4930XaqR0d4R
         ee9ZIHQ/0mqenoeM5gqOvvfl0rVogJ9/8vDE70EbEF2s5sjxzpPy9g3y3fT91Qm93fIp
         ThfQnFpKABxKw+sJtT59wj/hdFkk2y5w9/NJRWZsCfX85SeAUSlVwRDgIDlhchn1zX+0
         6J9cnLmY8LCuiTxUyCB3sB4fTy3sCj8xT9oApPZLwie5KFvdpaLXjHu/CK/HTJGVoFXp
         xKk0vGa8zeaCkDQQ43+wYHZkzNGiPrjcG6E8EpJ2e6B516JtMoJznxn1L/C2sobKzDH8
         VFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476821; x=1698081621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWfEcOW2L2k+xynXBCBlj/nQZn7LeFqtR6Gjd7zepfs=;
        b=D+36TOm+ljgXuIJnNCnkE8SAJSL8Aw+LqEhqsoBLZFdbMOFeNy+fHWvHi2HEaBKD6E
         e/CDAAT0Sts/01RD/SyEcSC2Q9TCVQwswQ4excQhbqdZmDIgSGM33Zyx/wtmfB4KqLZs
         97Or+jyrGlt56UZmURdk5mGcM6h0TY/XgyfG1DtkPehYvY+QY+Sqny8+EoKOwhmypiDH
         8ru0otVETpBOlqAIiw8S1SiMw1dbgNMHk322MXOTHG6/P/dWevBMC3FCEw/V4rO1UpYO
         rad9ExNCxV9Xd0J1CFyT5h6ooB/ZAcqYE7B7gLgkdN5dfPelu11ts0g2ZTnFjOxvwQMZ
         eMqA==
X-Gm-Message-State: AOJu0YzzBXH6lfahwf1ZZNRTOVYoL3rm28LmoRpdwQogSblqHdp0aklL
        fhPZ1pMq5qV3rmdD/PpIO9w8FpXH2yDy+hQBYuqWtmFZdKzIP6SvriM=
X-Google-Smtp-Source: AGHT+IF2KK3u6oHn5v2ieTIixFskEeBndJgyefW265kYtHWhHf+XSTJUCHXRnfFojA+kwjzqISEjSDw2QnvSo3UlVdw=
X-Received: by 2002:a2e:b8c5:0:b0:2c5:1122:9712 with SMTP id
 s5-20020a2eb8c5000000b002c511229712mr6532429ljp.46.1697476820513; Mon, 16 Oct
 2023 10:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231006024707.413349-1-max.chou@realtek.com> <169664042379.23949.8315443049400174883.git-patchwork-notify@kernel.org>
 <0ee79296-a404-4d0d-b8ed-42578a77692c@leemhuis.info>
In-Reply-To: <0ee79296-a404-4d0d-b8ed-42578a77692c@leemhuis.info>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Oct 2023 10:20:07 -0700
Message-ID: <CABBYNZ+DcF=q3tH9ZYTEhsrPgygU+hsYwYNEZf-3VwuiyzHXog@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Ignore error return for hci_devcd_register()
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Max Chou <max.chou@realtek.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn,
        hildawu@realtek.com, kirill@shutemov.name, bagasdotme@gmail.com
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

Hi,

On Mon, Oct 16, 2023 at 1:07=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 07.10.23 03:00, patchwork-bot+bluetooth@kernel.org wrote:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> Hi Luiz. Many thx for picking this up. From the branch name is sounds
> like you plan to submit this change in the next merge window (If I
> misread the signs feel free to ignore this mail!). Wouldn't it be better
> to merge this in this cycle, as the commit afaics fixes a regression
> that was only introduced this cycle?

It is part of the for-net pull-request:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tag=
/?h=3Dfor-net-2023-10-13


--=20
Luiz Augusto von Dentz
