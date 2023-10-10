Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436A7BFF13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjJJOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjJJOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:22:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052FAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:22:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso5066962a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696947766; x=1697552566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjgCMQrMRxO7UT+Dgjs8+PUls1MVudu/KuMSQSGIC0Q=;
        b=xMdSesD8RwHDcdBBRgiP4rZ5zl3aMhbclxsWfFdbBIMyHj8uzMtJaGTminPNtAZo8a
         ATzQHfrXrEl48YAW7BUHsKCh8/5MNeCKFb5V96/vo2VokVMijecIXEW4Xjf7apl0pWbG
         kbBvdgeDs8WtirQvzrFaN1oabkecqDmBJscAWkRklYnKt4pvGihV7EfhWDIvwDwLieoF
         zzicHCHypFH+szq8X1rqdaPHzxhaG8VY8Mqu/qYsb9yk9bDgc5Ehs+0KMdR5pqBAWI28
         7VzEzoAM1Smh3bXz0+/0UKw5FmoUMLfoJxiEd9VvTO2XOpRj7TpgCQKsFG8mTUquEUxC
         Eqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947766; x=1697552566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjgCMQrMRxO7UT+Dgjs8+PUls1MVudu/KuMSQSGIC0Q=;
        b=G8GfzifLp768uNgLWzdNjgHqnDJa8CT4OEM6KVyXYc43UeDZsCiyEEEaX+B1PmWXjq
         1RqvEDUdl/ewen+EYWAF4xQGS8AuSaZpDShqcFtW99s8krUBPcQBXjJMRm677Uphzwvf
         taxgUEG1qdTotTKQb3232K2jt7AfoM43x90dc2J1qhXZh1QOCvhvccsHrBX7Uz9bRwIy
         fIgb9ztFlKcXNWqVEuOEkRX/7hUhZsJNOl5epws6CCO2hIS7y0hpf6aCFWvo7LjgyO33
         J1qRYP3XIJBj7dccuPR2spKWG9J/6/9djJRTYgnnx2rZcgkB9cE9SnSKjuDBed37KjgB
         UsZQ==
X-Gm-Message-State: AOJu0YzGTCbsBZtLqMNbIwZXwY1kf8fV6QAvjWXvy2lQEG5DyAJDkfXY
        XqFmWMTW2+HMvSHLzOfjQ15OJJgJqYWlh/9oPmGFsw==
X-Google-Smtp-Source: AGHT+IGEzqDJ7Iy6V8fGm6hyIdbMLIhMRY6DQ2ciMjUlAXpHOvBPGkT6Hr6/thaPTJdBzt6mz7WRCQImQ+TQaICLcuc=
X-Received: by 2002:aa7:d5d0:0:b0:522:6e3f:b65 with SMTP id
 d16-20020aa7d5d0000000b005226e3f0b65mr15498021eds.33.1696947765800; Tue, 10
 Oct 2023 07:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696850733.git.viresh.kumar@linaro.org> <957de2a53dde99a653b47af9c95bc17692870294.1696850733.git.viresh.kumar@linaro.org>
 <920a671c-1927-4086-950f-db8e3293a989@linaro.org>
In-Reply-To: <920a671c-1927-4086-950f-db8e3293a989@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 10 Oct 2023 19:52:32 +0530
Message-ID: <CAKohpon4aYmr9TxhS8H7fVTU_xyhvErr12qViuYAUEf8RX5DGg@mail.gmail.com>
Subject: Re: [Stratos-dev] [PATCH V3 2/2] xen: privcmd: Add support for ioeventfd
To:     Bill Mills <bill.mills@linaro.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

On Tue, 10 Oct 2023 at 18:52, Bill Mills <bill.mills@linaro.org> wrote:
> On 10/9/23 7:29 AM, Viresh Kumar via Stratos-dev wrote:

> > -config XEN_PRIVCMD_IRQFD
> > -     bool "Xen irqfd support"
> > +config XEN_PRIVCMD_EVENTFD
> > +     bool "Xen Ioeventfd and irqfd support"
>
> You certainly know about kernel policies better than I but why the
> CONGIG_ name change?
>
> With this change all downstream distros need to find this and re-enable
> it if they want to keep a working Xen system.
>
> I presume the kernel can still work in the old way and not use your new
> mode correct?
>
> I would certainly change the description but I wonder about keeping the
> CONFIG_ name the same.
>
> No issue if I am obviously wrong and this is done all the time.

You are absolutely right Bill, but this is a special case. The CONFIG option
here (XEN_PRIVCMD_IRQFD) is recently added (by me) and is currently
present in linux-next only. Hopefully this and the other commit will make it
to Linus's master together.

No one using this currently downstream and so life won't be that complicated
for anyone and so I wanted to put this under the same config option, since they
are related too.

Hope it makes sense.

--
Viresh
