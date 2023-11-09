Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2D7E6AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjKIMuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjKIMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:50:17 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637822D70
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:50:15 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5b31c5143a0so9741437b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699534214; x=1700139014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9QkNEZK+idQ7+J77TT5hbKke59G7z1CkfstDJ5u5Ow=;
        b=w9AnDqTsv5FtyKNGv0IcsRhz0Vf18JSgYz8Oe1wFWCn8lyzx1cHb9z1vWtJqR+O6jw
         oHHWXYMsleKbg3ws+vBJZUc7BsmDzBdkuWvkF0v9lvvnRBiHN5RjTkJJVwKgJTFgYj/O
         9w/tRgrNe1Z5Ckm6wwBJ1PmPWQHC+scCoSyvD95DHqNOFRbL8FLE+UdMFWRAKiD6LskQ
         HNkxziP6vf3IrdZRAratOGPjYI1LoO4lBqBGAHW7GeA6cTJfntcKUuOndJxXWS6EdlZ3
         Rpao/nOnk8RykeyVemNr8wh8wJADNfJbdlZRzQfg7KGT7aD0MFb7AhpdF36SOn0P6kQ8
         gPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699534214; x=1700139014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9QkNEZK+idQ7+J77TT5hbKke59G7z1CkfstDJ5u5Ow=;
        b=LpkLJgFI1uhwnkxhYtbBN8js4qG3BWMY9BnfI4HJqIBoxJFhCmj4fJ05WFDYaiKPkn
         XCYVN4CKHg2zFndYl3QiPR7/+RL032YPBLBG7BYkiFlx2IaeEfg7g7JwhuTe3qAT80Xn
         C88Ni+He9CUKtB37O5SmgDXo49ZKGCnn6JYBq7SLxqjC7T1beY8WiGDF1jeMNKYXn+zW
         c2GgDgDU3e+01cYsPc27HWpxuKluWvMFl7tKG8mYH4YROZO1AJnntCbTeMfSvB/4A6Tg
         OnyC6PF6Nr0SgQzLzvba8xSQuXLaxhrWtycoaXincvjUtRMF5DnfvCkm3G2Sn8KnyiKc
         o24g==
X-Gm-Message-State: AOJu0YwOj6mB2MH90U3OpRWCDnUXD/UhfuNOjPpuBCRYXzF1Zop0LFcE
        H/bTkr9QmliojBmJDAuJUC/F8jUaoH2iQXJZIcji9bF23u1TYEhW
X-Google-Smtp-Source: AGHT+IHp+SM2yGUTokG4IzIbO8fHH9Otm9D7ZLbf1ZTxB+cIiqKlz50s1PbdFXn6HFqQ5ZgJs+2kLuirk/PMOgI3A34=
X-Received: by 2002:a0d:f3c2:0:b0:59b:54b5:7d66 with SMTP id
 c185-20020a0df3c2000000b0059b54b57d66mr4948891ywf.34.1699534214575; Thu, 09
 Nov 2023 04:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20231109085419.84948-1-heminhong@kylinos.cn> <ZUzSM37FWz6sgH9n@rigel>
In-Reply-To: <ZUzSM37FWz6sgH9n@rigel>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Nov 2023 13:50:02 +0100
Message-ID: <CACRpkdZfTbrPLFGH5akY=od8Rma=2c6F=nPz2nmAz2my_f7OeQ@mail.gmail.com>
Subject: Re: [PATCH] tools/gpio: prevent resource leak
To:     Kent Gibson <warthog618@gmail.com>
Cc:     heminhong <heminhong@kylinos.cn>, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 1:36=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
> On Thu, Nov 09, 2023 at 04:54:19PM +0800, heminhong wrote:

> > In the main() function, the open() function is used to open the file.
> > When the file is successfully opened, fd is used to interact with the f=
ile,
> > but the fd is not closed, it will cause resource leak.
>
> All open files are automatically closed when a process exits.
> That includes both those returned by open() and by the GPIO ioctls.
> So explicitly closing them here before exiting is redundant.

Yup. And this is one of the reasons why we have the character device
in the first place.

The character device gets released and all GPIOs are released
if the program crashes.

You can imagine what happens with the sysfs ABI if a bash
script crashes halfway through some complex allocating and
banging GPIOs left and right. Not good at all.

Yours,
Linus Walleij
