Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA37A0F73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjINVFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjINVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:05:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4682700
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:05:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b703a0453fso23669941fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694725525; x=1695330325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi4VUf4gJCA6NveynZh2FFW5elFrdjQW2bjMwJLkbzQ=;
        b=Ww4EVITliI6FPHoICZUDpEBVA51hwaScNcK/0JlRGcYISzgU2vckV09H2GCZqh9WIw
         EYQja7Je/x0oApJ9yOB1fc9WLvFEJk7IdUi1KJWuGjfPI/vpQCep/BPuDIicv1c3wlUY
         DSeQiHQ8c6Z3yTxwqnJ/IMS+rFIlXa6HSZI2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725525; x=1695330325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mi4VUf4gJCA6NveynZh2FFW5elFrdjQW2bjMwJLkbzQ=;
        b=OzPGj92Ze+6uBXmm8Obv8hGeLNVx+U9e4vrigweKSkCxj9p0oiWlBhyClvzC87Rbym
         /AtDVoAg7K5F2tU3NMsSsbG2tuH+J1aA4/88kxxY2VjgSpfFziYPe7Kv7hZ/63rqQSGi
         36e/PNuIsUHeUDGOUt9CFqPAHN4syzj5lmB47o4lALKJGmhULSm6dLETJvylO9WgyI/U
         gCD27bil7j32d8AtSjZMKgfA+p4RK74aV6XP0GhBXf5bYapNeAXKQh8HgqHV+JWv79Kd
         Vy7npvB6V6K6uCEjDalHCgVZuP69i4cw5A/MO9L+p4jOXkMXJldq1PQoZqUzy1YWLdDY
         iFZw==
X-Gm-Message-State: AOJu0Yzbb+qI1F4weDGJ8sLwWBnYRMdSkHo4RxzEBOZrfj8zOWUaQ1dH
        7KNNNAO+oBvkKAXBANMX2ai0hsx39BbzKYUM+nAP/w==
X-Google-Smtp-Source: AGHT+IGpIoxvufotBG4tHYBQHVc3J5oCnnG46FrQfxYwsgRu7oFKFrZ8pufbyYpDTvOYejxPAaSGTQ==
X-Received: by 2002:a19:e013:0:b0:500:7806:4f96 with SMTP id x19-20020a19e013000000b0050078064f96mr4863881lfg.28.1694725524921;
        Thu, 14 Sep 2023 14:05:24 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x12-20020ac25dcc000000b004fba077e654sm402614lfq.194.2023.09.14.14.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 14:05:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso23815731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:05:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3703:b0:4fb:8f79:631 with SMTP id
 z3-20020a056512370300b004fb8f790631mr4518877lfr.46.1694725522393; Thu, 14 Sep
 2023 14:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org> <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero> <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
In-Reply-To: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Thu, 14 Sep 2023 16:05:10 -0500
X-Gmail-Original-Message-ID: <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
Message-ID: <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 4:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Ok, I'll make something more reasonable.
>
> Well, I took the pull already, just saying "tpm fix".
>
> I assume the only thing the typo actually causes is printk's with a
> typo in it. Maybe some sysfs name will be wrong?
>
> That's the kind of information I would have _liked_ to see in the
> merge message, but I didn't then delve into just where the class names
> might actually be used.

Sorry, I should have been more clear. The typo causes misnamed sysfs
files, which breaks some userspace tools.

Justin

>                Linus
>
