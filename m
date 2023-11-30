Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4077FED7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbjK3LGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3LGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:06:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FBB10CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:06:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2839b418f7fso832402a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20230601.gappssmtp.com; s=20230601; t=1701342419; x=1701947219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VK0p3Vrg4Gg8051ZETfeUKQ1X0pr423KlXMEXlRIo0=;
        b=Yy5Caf9yYmWIl0m8QuLvT9qJchaIADVeNjZCHGcdU7ctBUJyPL5IZZWy8ko9QHSsDl
         EqTCvEdCJdXV7JVsoIXslpFBugY7ObhtVqaZIiI5+ZzPDAcPGsXiIaKmNepQNRfZc9qX
         STFuDQPRXGIbcT4XR7zUoSE1fEmAvItjpuWbErKCPxwLQXC3aEO3kH5NYA3KKf5Gav2D
         pH3i5C6yfxMULIyAob54BWCAAu3OFRTLr1NH1Umxx2W50vOuvWd2T519eN3W+LC0nGkG
         GkH9c7+5xI9HdFgwuc8IWtjb/bRvvc1BbysI/o32uK0XGkA7xBPpMs5qaTm3YIMMPUXt
         XJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701342419; x=1701947219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VK0p3Vrg4Gg8051ZETfeUKQ1X0pr423KlXMEXlRIo0=;
        b=r2LzWitxniqN4xNcwo1fIaypnyYOEsdbELk+jXH3ASrogjHTN7DtopJISgEomC92/a
         PzPaffJqDPDYCptwaOYUMwG60TseeYqzW+ndhK4qLPZfO38HeMlzkj8TqjfogCBxmFA9
         gakA0EOA8oBTE0xabHEJOwxQ0aXfDj6NC+i/GkvkHmjBZHCXwaaNvUH7SLf1To2Qb1+Z
         7vzgLZtTsQrW4uMsCyx108JC2PkwQhbDekxqc33zkIkSrXfGsOgTSuZ5AtlT/Px1nNQ6
         VAySR96LMdqBnJlXhImOn/3KDtjxZpR5vFASvmcJlK9kK/cwK6Yc6+18VHvXEQuH6gtX
         pWbQ==
X-Gm-Message-State: AOJu0YztQ7T8WCNNwaaAAOadeIIs/8zVQ/TXyONLm2z6s3fub43Pfr10
        /EezGDScVlHvYHj5w2aoLJ9Ro58WnN2CJ1u69UjV6A==
X-Google-Smtp-Source: AGHT+IGRG2Kj3feKGEFU/XQUFejAMZBBDZm96Wb9G5ijegmK6KOjleBmGWbmZIs+ys/Nrx4T+FyGQgH52OMPGySu6Jg=
X-Received: by 2002:a17:90b:38c7:b0:286:49bf:b215 with SMTP id
 nn7-20020a17090b38c700b0028649bfb215mr172414pjb.25.1701342418824; Thu, 30 Nov
 2023 03:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20231130034018.2144963-1-yujie.liu@intel.com>
In-Reply-To: <20231130034018.2144963-1-yujie.liu@intel.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 30 Nov 2023 12:06:47 +0100
Message-ID: <CAM1=_QQJxwt7sYVWOpE93xv9R79WUJ3aocLKP3ZE+MZzHS7tpQ@mail.gmail.com>
Subject: Re: [PATCH] bpf/tests: Remove duplicate JSGT tests
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 4:44=E2=80=AFAM Yujie Liu <yujie.liu@intel.com> wro=
te:
>
> It seems unnecessary that JSGT is tested twice (one before JSGE and one
> after JSGE) since others are tested only once. Remove the duplicate JSGT
> tests.

Looks like a copy-paste typo on my side. Thanks!

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

>
> Fixes: 0bbaa02b4816 ("bpf/tests: Add tests to check source register zero-=
extension")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  lib/test_bpf.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 7916503e6a6a..87a4ebcc65be 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -12215,7 +12215,6 @@ static struct bpf_test tests[] =3D {
>         BPF_JMP32_IMM_ZEXT(JLE),
>         BPF_JMP32_IMM_ZEXT(JSGT),
>         BPF_JMP32_IMM_ZEXT(JSGE),
> -       BPF_JMP32_IMM_ZEXT(JSGT),
>         BPF_JMP32_IMM_ZEXT(JSLT),
>         BPF_JMP32_IMM_ZEXT(JSLE),
>  #undef BPF_JMP2_IMM_ZEXT
> @@ -12251,7 +12250,6 @@ static struct bpf_test tests[] =3D {
>         BPF_JMP32_REG_ZEXT(JLE),
>         BPF_JMP32_REG_ZEXT(JSGT),
>         BPF_JMP32_REG_ZEXT(JSGE),
> -       BPF_JMP32_REG_ZEXT(JSGT),
>         BPF_JMP32_REG_ZEXT(JSLT),
>         BPF_JMP32_REG_ZEXT(JSLE),
>  #undef BPF_JMP2_REG_ZEXT
> --
> 2.34.1
>
