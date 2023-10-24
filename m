Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E97D46ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjJXFeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjJXFeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:34:03 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25476E9;
        Mon, 23 Oct 2023 22:34:01 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e19cb7829bso3030247fac.1;
        Mon, 23 Oct 2023 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698125640; x=1698730440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9l4yWO5IYnmruSJerE1/J9bNO/v7+P+ZDUoIpWw7cM=;
        b=DvsDOKD/DS8dB8k8p5OqdUmcWGPFuLYZZJyoKF/wblH+5/+PdHtOGj4q6/dqpJhAtb
         /ShUiC0BmmrkCF0cYI5tD/GKseOUj9xpWCGkDGKsUQApsTi/O9yR1ZIP+FfL85NW/Fpr
         GuTvEaAau2YcaNAd22GyB43QpgLLUsWsiSckySIVn9ynx+GWPZ25TGpFaC7W2J/oEbxg
         8fc+roeCe9Iz0v2L9sogJD/GbDti5XsJjgvLLKFJ58LSWVwA25uvD8m7Iy9sC0zAWN+O
         QlqpkR0QxDjCBqr1N1z66d36hjZ0+ueW4W1GtyCr0N2posVWRJcvmp6Q2VSVXhInbgmE
         hSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698125640; x=1698730440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9l4yWO5IYnmruSJerE1/J9bNO/v7+P+ZDUoIpWw7cM=;
        b=ZB0rczSx2F7ewblpOwB5mDw1kO2K9FobsomPYeFD8SB4HHwnErx2k6ycUg1MmioEPZ
         FZwnpJsAZhlfatLsnmQwZQHIv89a9y0Ag2VSRltMeqKX6qJpf0e2uK+wa50LwR2+CUUA
         3Mj8RnhlEpS7LCeoApul9hTWD6V09SCMCZyn2XsNK4agoExoHhrMbDPxacykntLfbWB1
         G8mzCT97rbKA6cpMZIMiz7Md6jxX2M+uMjzulYwiFTYAQAn71FhpslCcwTh1gRZw035h
         iRCaQoQ50ThAPHejjboDC0t3ccIv8OLU3wAzxC0SOk5XC2Q+RG9RNx7ZxBEQBMOgw3ri
         PYIw==
X-Gm-Message-State: AOJu0YwHFAsxJB+3fW11kUPQ/JIq/IMnE37elweIXvi5wU2Plma7Lwps
        wNLDW80N/p4GoOhOhmzP2Fduns0vDkwFeoB8Hn/zKWpL
X-Google-Smtp-Source: AGHT+IEcYN1h3j2Era38wqdWbWdgcyvQM/WIdxTXDby68IOTN5tX/P8ClV3LtRidM0yMP9cC2VJb5T3KlWZSsgoGhwA=
X-Received: by 2002:a05:6871:a302:b0:1d5:21cd:7069 with SMTP id
 vx2-20020a056871a30200b001d521cd7069mr12991818oab.8.1698125640332; Mon, 23
 Oct 2023 22:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
 <1d6804f3-a5e2-4840-a4ae-7cd2632b3b64@phrozen.org> <CAMhs-H8Stk8_xWLFu2sozjXPgy2GjJMOCP2bwAH0FXxmYRr-=w@mail.gmail.com>
In-Reply-To: <CAMhs-H8Stk8_xWLFu2sozjXPgy2GjJMOCP2bwAH0FXxmYRr-=w@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 24 Oct 2023 07:33:50 +0200
Message-ID: <CAMhs-H8a-a1gnsS5-avVt6j3CYK5zmvw3u7a++wwxLQeNHPZ9Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
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

On Mon, Oct 23, 2023 at 6:50=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Sun, Oct 22, 2023 at 4:33=E2=80=AFPM John Crispin <john@phrozen.org> w=
rote:
> >
> >
> > On 22.10.23 11:06, Sergio Paracuellos wrote:
> > > Its been a while since I am making contributions to this architecture=
.
> > > Hence add myself as maintainer.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Acked-by: John Crispin <john@phrozen.org>
>
> Thanks, John!

Hi Thomas,

Is this patch supposed to go through the mips git tree? If not, which
tree is used in these cases?

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos
