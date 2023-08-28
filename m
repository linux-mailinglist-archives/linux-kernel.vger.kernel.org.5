Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8278B23D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjH1Nsl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjH1Ns1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:48:27 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF554BA;
        Mon, 28 Aug 2023 06:48:24 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5921a962adfso38305927b3.1;
        Mon, 28 Aug 2023 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230503; x=1693835303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blhUfqzVF8tP8mpgksXjcwth+y21tfThEGRNVYSwGqo=;
        b=devQHdnNSEAvsloV66rJ3RMFyKr4XeX6oj3I1+sEodMBq+pZo0ahB7DzB4a7sMer7u
         odKe9KPnSQoBt+8SXY0cY4XRYgP27MhPFauSdE3lKFEK14Rp2LZ8oBpxaSbSVBmPNwZP
         dQH8nRNhu0kzIh5T60arNTEptOeIVMwE4w+dSoleeV+m3l/E3SY3ma5evohfXtNnnbRG
         sj8sXUJHk52hJq6XrUTw7C0jz1i5aQK03jcwJtYwxRB/h6KRD6cL8EkMFyUKmZNVxz65
         OMLXWSbd6Qyc5W8jL99/S+KoS23H0TwOwUXBtXsGlVyd3KaobhlZOnvSQUog+8JGxTNb
         yZHA==
X-Gm-Message-State: AOJu0YyB+LJfr3ZcqyjIBINyLZWWy6XzNDR9Gay9zGeUmZJnLPKFzQta
        Kh8jJZWZzz4mmTFzSijs+yR5caa/GCh0QQ==
X-Google-Smtp-Source: AGHT+IE/aG47xr4aFKQSQnWeTHix/moy4Q5+BWRyKz5ITnwbpKg8BY6e7aupaCttRi06B/NtdZweBw==
X-Received: by 2002:a0d:c4c4:0:b0:57a:f72:ebf8 with SMTP id g187-20020a0dc4c4000000b0057a0f72ebf8mr27083807ywd.28.1693230503695;
        Mon, 28 Aug 2023 06:48:23 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id c66-20020a0dda45000000b0058427045833sm2151213ywe.133.2023.08.28.06.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 06:48:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d746ea563f9so3081739276.1;
        Mon, 28 Aug 2023 06:48:22 -0700 (PDT)
X-Received: by 2002:a5b:b06:0:b0:d47:8db3:8bc8 with SMTP id
 z6-20020a5b0b06000000b00d478db38bc8mr26525998ybp.21.1693230502647; Mon, 28
 Aug 2023 06:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693037031.git.quic_gurus@quicinc.com> <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com> <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Aug 2023 15:48:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
Message-ID: <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Aug 28, 2023 at 3:37 PM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
> On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
> > On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> > > This script runs get_maintainer.py on a given patch file (or multiple
> > > patch files) and adds its output to the patch file in place with the
> > > appropriate email headers "To: " or "Cc: " as the case may be. These new
> > > headers are added after the "From: " line in the patch.
> >
> > FWIW, I personally prefer tooling to operate on git branches and commits
> > than patches. For me, the patches are just an intermediate step in
> > getting the commits from my git branch to the mailing list. That's not
> > where I add the Cc's, but rather in the commits in my local branch,
> > where they're preserved. YMMV.
> >
>
> May I ask how you add/carry the recipients in a commit?

I guess below a "---" line in the commit description?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
