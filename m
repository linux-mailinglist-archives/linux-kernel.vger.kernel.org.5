Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC57E8382
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjKJULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjKJUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:10:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3414C6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:10:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso7110320a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699647053; x=1700251853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UaWQSRQzi/7DA8Jzdisd3TlJK2VMiM2u767TaBKKybM=;
        b=cXksBSP2fm8aWPZNdifFg65Yke0PQniAYndu8lxzfGIaN7fVcyvKrHaHyMMVeCgv7D
         lzwD+xRHiFYnZHmdehJ1OADKJ1M7xh0AExCCk2rrX1LyxPo8dlM97saa7LlL6/HBX89g
         m4wK8ygB+4qCBdR+8airCW4H5vz53Fjmc4YWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647053; x=1700251853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaWQSRQzi/7DA8Jzdisd3TlJK2VMiM2u767TaBKKybM=;
        b=nuNdYkzRog7ufORqEEHkh2Du/7Wyj2lpdkOH+khEWSTCczetaAGFKM5s9/YHaV2ueh
         oYvU27qj2pKItMP916VkUBM0jgfi91e9OOcDi5hnXyeOycE+gYqHfR45Wo/DFpLBa6uL
         GeEp4YAX7x7aJ2u7G6EyfZUMTQA3jSaNxNYfuh/ZX3JdQb9ux9aHuIwHFM+xqu6vyzuE
         jg2za2m2Ceom1Ksu4UPaNoE0GrMz3slrx9437WwopynROwincTSDfFXiTgpSL3oX0Qmi
         WUEgU2mHvyheGs4//BKVJoNbnLfjbF2sJlQUKlEopR2yWM4nwuA9mUZUURLkNtZ23gXj
         dTIA==
X-Gm-Message-State: AOJu0Yx1tx5CDbU7dx0dkG7HDbPCtOdvoOsBTfdL/jXmvusfWq0GVLBh
        2qEItf0SznH6NANwcVcrrOxLD/dSpef+tGLgVDxSYIO1
X-Google-Smtp-Source: AGHT+IFYbcShskZH1wfFoFNKrDDPZ1xWAiP6MdFSEgeXyudyJTGC1IRW0afGbQ7fXgEY0EiEZriiWg==
X-Received: by 2002:a17:906:b84f:b0:9dd:ebab:2bc5 with SMTP id ga15-20020a170906b84f00b009ddebab2bc5mr133775ejb.7.1699647053030;
        Fri, 10 Nov 2023 12:10:53 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id j14-20020a170906278e00b009b9977867fbsm28854ejc.109.2023.11.10.12.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:10:52 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so7137030a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:10:52 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:545:52ff:edef with SMTP id
 b20-20020a056402351400b0054552ffedefmr2843522edd.20.1699647051822; Fri, 10
 Nov 2023 12:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20231110095013.655597-1-thierry.reding@gmail.com>
In-Reply-To: <20231110095013.655597-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 12:10:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
Message-ID: <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Fixes for v6.7-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 at 01:50, Thierry Reding <thierry.reding@gmail.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1-fixes

I have no idea why pr-tracker-bot isn't reacting to this one, but
here's the manual version of "it's pulled".

              Linus
