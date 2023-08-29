Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5778CDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbjH2UtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjH2UtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:49:11 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8331BCC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:49:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44d56d26c32so2056209137.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693342144; x=1693946944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRj6oIeLsLoWDRIPaLOolZYdlfU92WGUkzkgfX02aeY=;
        b=y8ZPt5g4KQqBfd5AcCR3DwvzhwAatBh8oL/cRfn1qFK4ilQgR3+982bxgRSUxXO9rO
         TK3bYFZWLZ4RhQC7UP3HEBEpj+qmsXd/ojIUBNgUicG2BK4aD6gDPlpMPgKsLgCZFi9q
         B45kkk1M0HYstItmRVCN0ibkIBkarUyUtPAQriJNVlBKZxv6KwrI6yKMeTIIVEGqAuiL
         cW7Au+r2X7bWkFxSjMDvlRKR2oKYQzXPs5Wkrw36+FUqhUbv2NQAscuf+1J7ZmBOYh4q
         n51sYI2T//SCMihdR2+HqmTFvqJHvzzwkV+Tm1QYTH/hmrnbvvllGLKF7Q7WZidVAVf2
         qDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342144; x=1693946944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRj6oIeLsLoWDRIPaLOolZYdlfU92WGUkzkgfX02aeY=;
        b=LVQgzEiF7+qcfuFax/RIi0eY5knU7VjOfmDOKGgVRgSoSrQbvAjxc3OiljUmb9NJyj
         9OScXrJSi3LLY5835RJ3Iqv4yoBBRUXz3BTrFtl0VmUxXqDjBQW927yydzCkk4wakeAR
         BY6J5556ujC1GLlSKz5avskPrrBtFWtkynrJRFlaL5+rLVOrBCY1B/QfGejTzjV6CJU0
         XoNILve41wBolMme+DEC8oBtffpFvO0tkebqlJJ3LYg8pbB3a1RzAO5/vSFhWB6subLR
         j6maLlZ0ywOd1z3dIxR9eBnqtw5LHbidQ2qhNBiqgt3ziMNZ3T0RL4NZfLnkkO6DzANR
         FpcQ==
X-Gm-Message-State: AOJu0Yzg0W2tNjzTkEmRvexzCwLAZ2E+a9lLYOFzdK7I+8hi5XdoGTGy
        CkS8Z9kBSsDhqwryWenhZe2y6QPInS4cmR8tbvio/g==
X-Google-Smtp-Source: AGHT+IF7YRXkXJ355j1Ewd8JqLtawN5J8W6r3mYIaP1HoCS+5U7hrxkJJRqnSmslMlaAQn+nSwjUY90hjogjc08gTRY=
X-Received: by 2002:a05:6102:52e:b0:44e:9614:39be with SMTP id
 m14-20020a056102052e00b0044e961439bemr378634vsa.11.1693342144637; Tue, 29 Aug
 2023 13:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <CAA8EJpp_Uu62TDknZ-X0DQYinnwxxoriPpetfppCySxg_25YQg@mail.gmail.com> <CACMJSet-1tbTnMOab2GvMEc-b6Y3Xq5AZEE4mrfiUOZ=65z3MQ@mail.gmail.com>
In-Reply-To: <CACMJSet-1tbTnMOab2GvMEc-b6Y3Xq5AZEE4mrfiUOZ=65z3MQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 23:48:53 +0300
Message-ID: <CAA8EJpoFusQbZqUoqA-UZRfretUWOgox_LKfup6viVxXDQiS5g@mail.gmail.com>
Subject: Re: [PATCH 00/11] arm64: qcom: add and enable SHM Bridge support
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 22:03, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Mon, 28 Aug 2023 at 23:24, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 28 Aug 2023 at 22:29, Bartosz Golaszewski
> > <bartosz.golaszewski@linaro.org> wrote:
> > >
> > > SHM Bridge is a mechanism allowing to map limited areas of kernel's
> > > virtual memory to physical addresses and share those with the
> > > trustzone in order to not expose the entire RAM for SMC calls.
> > >
> > > This series adds support for Qualcomm SHM Bridge in form of a platform
> > > driver and library functions available to users. It enables SHM Bridge
> > > support for three platforms and contains a bunch of cleanups for
> > > qcom-scm.
> >
> > Which users do you expect for this API?
> >
>
> This series adds a single user: the SCM driver. We have another user
> almost ready for upstream in the form of the scminvoke driver and I
> learned today, I can already convert another user upstream right now
> that I will try to get ready for v2.
>
> > Also, could you please describe your design a bit more? Why have you
> > implemented the shm-bridge as a separate driver rather than a part of
> > the SCM driver?
> >
>
> It's self-contained enough to be put into a separate module and not
> all platforms support it so in order to avoid unnecessary ifdeffery in
> the scm driver, I made it separate.

Judging from other reviews, I'm not the only one who questioned this
design. I still suppose that it might be better to move it into the
SCM driver. You can put ifdef's to the header file defining the
interface between SCM and SHM bridge part.

-- 
With best wishes
Dmitry
