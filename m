Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5667978909E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjHYVnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHYVnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:43:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375D1BF1;
        Fri, 25 Aug 2023 14:43:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d749f57cb22so1402977276.3;
        Fri, 25 Aug 2023 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692999781; x=1693604581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOjiLmb+UW44aXh7b+IYQZhe4+kyawAGhkPK5fqLGxg=;
        b=H11sQ00dlGNJFSl8ruX/T2dyoG451qCGPihbBVPIjhB9kRjrG6UvkG79PQL+C8ghRy
         KgM8ByRo+oXbl0Kf/NPlzNJZV/04Auc4hc/ZWuYeALpaIup7XRmKj2AaKZMBVK+fRXjh
         NCf3uJV4t7108inEwCn4w4KcKJYU6avlB468EBskN/Mkvs/1gtYdFjy5PYTgiur26K86
         Q4ZhnneXWOB3+bZeEAtcJnQTtDQ6914lweJVQSpED24U3YcZlSG6IXHdXYIBTHVrzarB
         R0jWXSunF2gjcyB9PcVeAF4k9sRyD59cv30HRw4wTZ5iA7xmhQmoZgJFm9bPZCWSP9oz
         MLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692999781; x=1693604581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOjiLmb+UW44aXh7b+IYQZhe4+kyawAGhkPK5fqLGxg=;
        b=G2aEOyoN/mMDxDkd74T04qtOJhb1vWAqEllB2Q1PB0ffTxNvz/Uk2BbdiintXSSLJq
         uMnfGsgxwzHnlxL61ZCuJk20/uw/eNDuAhA1QpFRDX3UBTsP08HbLw/3eSJ/6FrQPA37
         tFLzv4Zas68/vGfZMqlCOrDijPxPvEosc2tFqMp9ssgxebUjLhPJIEDqiq81Pd++repS
         ntxrDAItERez7m1miXWqixwq/se/HC5cRPZw0iT3RAEdaqVBKiLpoWdc/C51CGu85CEk
         msWbSfK+cA0EDGXDqPL5N+HOGIMftZ6WvGE4wpBhfxQVyqQB677FtBHwddMbiiK4Gvj+
         xFCw==
X-Gm-Message-State: AOJu0Yzy9V+N6Uu4E4ArpOZlokikyFRhwTt2eN8t+ABg1oM/5EnJTYdX
        d8Wc/T+UUqAcJA9VKe0nrIzELoNo+dxXwjFpX+s=
X-Google-Smtp-Source: AGHT+IFYdKE+7m1VfV5IIDq2NFaDjbY6Ne7jqDO5pWrZgojiP0TNftc/e+0hEaEGndIzReC9AOY6vigqJDN5d81GFG4=
X-Received: by 2002:a25:bb85:0:b0:d15:454e:8ecd with SMTP id
 y5-20020a25bb85000000b00d15454e8ecdmr18647689ybg.13.1692999781101; Fri, 25
 Aug 2023 14:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230816164641.3371878-1-robimarko@gmail.com> <20230816164641.3371878-2-robimarko@gmail.com>
 <ff9ec6f5-9c7c-546b-5814-159d7e2843a8@quicinc.com> <CAOX2RU7wbZopGErQ71frXFMz4+Y9QU6SjfrYbZPT_3yd0gU73A@mail.gmail.com>
In-Reply-To: <CAOX2RU7wbZopGErQ71frXFMz4+Y9QU6SjfrYbZPT_3yd0gU73A@mail.gmail.com>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Fri, 25 Aug 2023 14:42:49 -0700
Message-ID: <CAN8TOE8h9mAWTAx71NUEirSW4+5XTZgDiu5KjYmu6yecyowrUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
To:     Robert Marko <robimarko@gmail.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 25, 2023 at 2:41=E2=80=AFAM Robert Marko <robimarko@gmail.com> =
wrote:
> On Tue, 22 Aug 2023 at 17:38, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > On 8/16/2023 10:15 PM, Robert Marko wrote:
> > > +     ret =3D qcom_scm_call(__scm->dev, &desc, &res);
> >
> > Would you not be wanting this call to be atomic ?
>
> This is implemented based off the downstream 5.4 kernel as I dont have
> the SCM docs
> so I dont know if its even supported in the atomic version.

More than that, it's known *not* to be properly supported on one such
applicable device:

Subject: [RFC] qcom_scm: IPQ4019 firmware does not support atomic API?
https://lore.kernel.org/linux-arm-kernel/20200913201608.GA3162100@bDebian/

I still haven't gotten a solution to *that* problem upstream, but it'd
be nice not to make it worse.

Brian
