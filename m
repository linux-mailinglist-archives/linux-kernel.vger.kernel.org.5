Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB0800BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378966AbjLANSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378938AbjLANSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:18:36 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0F10E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:18:42 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d36fddbe3cso16584827b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436722; x=1702041522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09w7LW+cnqnlOMOkAO+xvtNckElk6wbrltpRZF7gZK8=;
        b=jDbTERifj0EHk24e+bi818C0wkQpVbzuqsDVyzmn9V5jii+a5mYb0kUBmzkNtJTcIQ
         5PBIQ0svSwnML2LGV5uiAD9Oj2Pgy9jzOM8k9YsEuFK7NfwK8iQggQg3lXkf7JYGRIfd
         aVYsZG0tbWukeHJp6bCWo8azR7y+C8JqIaay6cDE2LDBNdUJkMW4egClcRb6MRkGDf+w
         n7owctiCTjqOG0Zz8F3ChBQu5QwZ5ZmfPodF7Cem+VXB1JHZWSGy84U9/H1SEztF4h9h
         dedISDAxoxEmmg1ogvBCo5Z3vXbxw6PdeQoBPkU/zC/I6MIOwvf7UFBK7nKoVw97rVHy
         WLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436722; x=1702041522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09w7LW+cnqnlOMOkAO+xvtNckElk6wbrltpRZF7gZK8=;
        b=gfgKZDOyRP7x3JP5UsBlRXfLNBA3mhkFOce00BKdRUoTj9Okqnk1BuHoAYHvcLbxrT
         3eTxK6Gt2H7YKGbbyr+0udOzGZf9nsHrfYVDK54EaI9rBymxPGicejqNbmykwRYDqAgo
         a4EqSvpz9N2haDqxZwpks9hwsdgRHd9F5kgQGTTKcBiCA75tZ0QB6ZtoSFu8JDDzgZDc
         5gQjaGrCUwIOsI/B+L2PSF87EnfM8cjHmdygE/UNxFQ/XDnkBbrWhgR0kE2Skf33NzxT
         K0yph/JHIITFVIes+Df7ZOiGDGYd6BHcHhzRtA4tkZ6bw4+VQ16goqhbFK6OxdUBkKSk
         D4zA==
X-Gm-Message-State: AOJu0Yx3bEpU2Xn0zwf2e6VN4NKYfdyADFKNWHWB4jb0/q6jDEd6IyWm
        hH2Qz5rEeYneSZbiMgZCyJ82Oeczxv+FcFk8D1TDeQ==
X-Google-Smtp-Source: AGHT+IED9fUj04DIXgJcAJDTj+imzR+T7qCQhh61mUs0nVQkvTLJCffTbDrbVbGT9xP07igPg64irBBooCwy4hbwxiw=
X-Received: by 2002:a81:5743:0:b0:5d3:ba32:a10b with SMTP id
 l64-20020a815743000000b005d3ba32a10bmr3341733ywb.10.1701436721755; Fri, 01
 Dec 2023 05:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20231201091034.936441-1-jorge@foundries.io> <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
 <ZWmptatt60if9GBH@trax> <CAJ1nHOW9T3yvFj5FFdOZYrdgfy0f=opiDri+2srE=yBp5vtVZw@mail.gmail.com>
In-Reply-To: <CAJ1nHOW9T3yvFj5FFdOZYrdgfy0f=opiDri+2srE=yBp5vtVZw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Dec 2023 14:18:29 +0100
Message-ID: <CACRpkdZHB4OETge9T6g5zHqMdd=uO3_-jbMMmzf+vRn=fJQHiQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
To:     Jorge Ramirez <jorge@foundries.io>
Cc:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, jinpu.wang@ionos.com, hare@suse.de,
        beanhuo@micron.com, asuk4.q@gmail.com, yangyingliang@huawei.com,
        yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:47=E2=80=AFAM Jorge Ramirez <jorge@foundries.io> =
wrote:
> On Fri, Dec 1, 2023 at 10:39=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries <j=
orge@foundries.io> wrote:
>> On 01/12/23 10:28:52, Linus Walleij wrote:

>> > > +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>> > >         int ret =3D 0;
>> > >
>> > > -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
>> > > +       if (part_type & mask =3D=3D mask) {
>> >
>> > That looks complex, can't we just:
>> >
>> > if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?
>>
>>
>> I chose to mention the mask nature of the field for clarity - just in
>> case - but I'd much rather do your suggestion. So will do :)
>
>
> sorry no, I mispoke  (I like clean code so yours looked neat)
> we have to compare against EXT_CSD_PART_CONFIG_ACC_RPMB
> bitfield since part_type could be EXT_CSD_PART_CONFIG_ACC_BOOT0 (0x1)
> in which case we have to skip it.

Aha those defines are not flags but enumerators. I get it.

Yours,
Linus Walleij
