Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24C77CA12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjHOJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbjHOJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:10:22 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390A1984
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:10:19 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56cb1e602e7so3724409eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692090618; x=1692695418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTEF3mMEwF6YiiLngewsEfRU77YIxTEoS69H+Rwqbd0=;
        b=VwWw7KpCrtSFxxsif4kM2FXRaUcWrnLoLuvxjuE1nnBjkoypFOscPY9JCuwbvSlGgn
         vwhbP/Skv8j3YwESeAWmdtqakZGqvtlSDKkwVT7LHw5QwZqHiFoL8RLwdYdTxq89h86h
         vwaDDJxFYoc2W9+3iBkXgLm9djhr1mownIn3JfHNIG/JY5Vxjx/dL0SEcr3RG2mEnkST
         hUEJf596xX5FsfeZkwbbh6uPKY3XMRGrcCzlY5W9s7bWa/yrVyxS5co+w9GDiP/8ax6/
         g5juva9uIG5s+i92ALBTFYyos7WX2At2iw31uNxPzDojAHSi4uraZqkxezPWFn1gNiHG
         btwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090618; x=1692695418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTEF3mMEwF6YiiLngewsEfRU77YIxTEoS69H+Rwqbd0=;
        b=eFFOpnchXQUYAa+XsufbRqEOpPkuPVCl329qs/Qieu1HSVD2QPed21AlDe+TsiYS9y
         BWmLPEz5tyx0DrQHuSLKnBPiTkUbxJyxKFaEhetqm0jMt2VtOVxW99vHplkGLBUXHJXI
         3uqh70mEZUoXTK+VkvWTrzV2J0VcDoiS9H1z6MFJfbWBwNgMKdA92jLJeSOR5Grxx7WG
         0QJILBUDX+wHVZn978D0J0uX7jtPlxI7kp0WMDO+eifhVMREwxauCOUyQ9O1tmg/m872
         QqbfvwiSw1Az58g9vKJl3LvQSnV8a+ZKiLuDug7ci8EHKkYigJbkUHviigrB++RmOrTC
         SuQA==
X-Gm-Message-State: AOJu0YzyDj8NC2wcUkTPWBaFFO9U6l2YBdtiOjQkRRY3A6HupTqlHAxu
        q2j7zyCD3waXgOzxJCnPxAbSoqKG+w98jBwIKEeI3JyzIqbAI7Ms
X-Google-Smtp-Source: AGHT+IELEzEzRHt7+/91xk3FRpX9OXjbJ3v23mrOMtATDKEZGj8lJsjlFm1Ydv4GSP2Njf9WpzC6Tp2I3wO1jQVdj4A=
X-Received: by 2002:a05:6358:2610:b0:139:d14c:d6ea with SMTP id
 l16-20020a056358261000b00139d14cd6eamr10111849rwc.9.1692090618249; Tue, 15
 Aug 2023 02:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230814114518.26243-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814114518.26243-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 11:10:07 +0200
Message-ID: <CACRpkdZvr7fvXyh7V2nMJTwDxtK=sUz=DBRtqhR=6YzZpb7DxQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: qcom: new drivers for v6.6
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 1:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> That's what I got in my queue for v6.6.

Thanks a lot for backing me up with this, pulled in!

Yours,
Linus Walleij
