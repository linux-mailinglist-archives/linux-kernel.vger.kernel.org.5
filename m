Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B882C7B5A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjJBSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjJBSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:31:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B85AB;
        Mon,  2 Oct 2023 11:31:42 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bd4e4ada6so24847eaf.3;
        Mon, 02 Oct 2023 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696271502; x=1696876302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKjHs7tNvXYJ3E6TMRogj11ZeQDv6+I8lDqqMDt8DKk=;
        b=V4HgAePMk29n5s3QpIo4yF56FHshUkapGi75RYW/sHtm6JG//CwWW0FSknGcySN2XP
         2JnUHdzXFQsD2dcp0Ow+bkU5T/vAQEAQo+ikH1wedExLTcDSsQZOoEoVobzG4Z8fBbaj
         cSO3mWeXn++6EfXRcHMYNiA5T/z8FevBMjhFJ2XaQbsNVsIcmzR+eMXnH1wni6xyxS1r
         EztR3eLjUXfble9Pf4zspK2Hp1tl6KqmdIIJda1EOQ7kFcmqT3YePOCUZBN8yjRznHtl
         8Eh8S7P9EJsR0wHZCfQuN8LLU4ytXbRsvBcQqqnug4L0awlroUJLcpA57zzgQg6ze6ED
         OE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271502; x=1696876302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKjHs7tNvXYJ3E6TMRogj11ZeQDv6+I8lDqqMDt8DKk=;
        b=RBtdDBjYf/LxlgK4qI28ohrX5vu6MfYs3GtNL3IwVZgi0t7nQXCL90CSEGqeLoBGZg
         +9zj5Y6Wysq7rPzrk/f/pYcZJ5XsSkPvVazybjWivwJhAl+WLvl41hKD/WFPh+DVQK7H
         0rNpPsVRolJeL8k4JwYLf1IaQqdaSI0H5VBxzmsbTB2zZAabldWo4gapjQaayVrC9n/3
         qnoRutOplfdZc1jAi3ld1Oc2sDS5EmQhtbcyF4jk4M2sL1S0URQz1wrK/9QxyQdO+lbT
         /FuYWOgkMx/bnAnx3UYsPvalaLjTAslw60O65uOBpnngTs9Fi5vjXhGSxF3YdHYFG476
         Gf7g==
X-Gm-Message-State: AOJu0YzWUSACmG2S104PN0heXiHj4+BRe3gxbw6rZDA/tVDOKj7qDu59
        psIVtHOOD+9z3Po0/zdh0N/JoJe1rg9/axzy/Wc=
X-Google-Smtp-Source: AGHT+IFqSa/RifbLkRi+5SY1jP5NREDCl6ac0ljNJ8cNo5HNK2jj/w6Q2763mLH7m8OXtFSKFFJYqmZgMSSvJyfU/0s=
X-Received: by 2002:a05:6820:295:b0:57b:e345:43ad with SMTP id
 q21-20020a056820029500b0057be34543admr11373706ood.4.1696271502251; Mon, 02
 Oct 2023 11:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231002175052.112406-1-tmaimon77@gmail.com> <20231002175052.112406-3-tmaimon77@gmail.com>
 <CAHp75Vd701sE-pkTWYi=PsOpVoBa-fbOm91P3bGLruCn5U1KXA@mail.gmail.com> <CAP6Zq1jM3=D5PBp1z7=K6LRNJaZe3rEPutXm_xxo7p2Z60sWmQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1jM3=D5PBp1z7=K6LRNJaZe3rEPutXm_xxo7p2Z60sWmQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Oct 2023 21:31:06 +0300
Message-ID: <CAHp75VczCMaA0Kd7Lhr6PXG_kJJ5iFqe3WdX+v7xJMjdi0KdgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 2, 2023 at 9:29=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> w=
rote:
> On Mon, 2 Oct 2023 at 21:22, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
> > On Mon, Oct 2, 2023 at 8:51=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.co=
m> wrote:

...

> > + mod_devicetable.h
> why?

of_device_id is defined there.

--=20
With Best Regards,
Andy Shevchenko
