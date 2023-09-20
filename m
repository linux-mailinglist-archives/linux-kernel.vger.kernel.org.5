Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0C7A7A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjITLKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjITLKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:10:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E523C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:09:57 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59bd2e19c95so70847377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695208196; x=1695812996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOJ/BJ2l2WZd3GigDvvKxccID8awaxn2aoWl6IQWUfU=;
        b=u+khXbP+lDfk7IFsUe8xUzx7l+UTa2cVYhph1pwZzdQTKbDLdG1BgkNsUWf/y6GLO2
         HgArdlGPFp/cZ+kJTwjkTQ8IOGB4AVHRHw8foqsBOyw6hRCYFaK3hagrlrL8aebmr2zy
         BIoh2kHw96sErPqRW1Mq1RCG78Q23RP601GqAims4GrpE0+m0QQe07EkKL45uanO5FPW
         o7CfJSA9NnFP7xVgiGxAnCAHktGZTwa0nZcVxT4i/ZSQpgIxuc2vI71kuErSolFM090f
         0D6GvAbGb6DUfUXSH80dyU4P7IEj87ubaFRdDGBryL/axWbPlmtItSLmjOLfKnj+22ry
         UwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208196; x=1695812996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOJ/BJ2l2WZd3GigDvvKxccID8awaxn2aoWl6IQWUfU=;
        b=q90u2F3V3B3HgfI3aq20vBDrVSbbGvhfZ0FuBpeUezo5QAbML7SjHbCGOsm96WlJH+
         sooiTtKa0BYbbzh70K7LIiMIAfNUSJ0wnUMnk9SM5k7G+cz1pbLMTNCzGMAZ+8I4gxDm
         Rmmk/CBbfZhrTatmwl5M9qvPD2v8vm5R/gD7rLUWfba1I5DGUcwPAO8KEgJCkS/7e2Fm
         qAALvfNP1p2z6xY8gsIrwKlbNBlR7KAOnTSqhbuMP9tae5DA6EFGgFcsTFBUyqaxMyeL
         fzivdga00IydpGLbNJ+nuKqs/8lmDKPz8uYZh/Gg6ThDdkc2nP1IWrDe4pZ0v2XOZ8ny
         Dt9A==
X-Gm-Message-State: AOJu0Yyk4X6uxadYyxZP+pmf0zVuMioP5HoPOPTR0c7U4Gk2WzN8QiGh
        x4pK71VR0QCq6Xu5fhT8rlQ9exybmQ6VGh6QfDG7ww==
X-Google-Smtp-Source: AGHT+IFhD3MUXYEzKxwtcQYWepb7sIaD75bCX88GQFGfrl1Lyt5ccFyOLbZ04EVfWGqQdYmL/4KLXdgi4IDi3ZH1xMs=
X-Received: by 2002:a81:6542:0:b0:58c:4ec6:f21e with SMTP id
 z63-20020a816542000000b0058c4ec6f21emr2259029ywb.23.1695208196594; Wed, 20
 Sep 2023 04:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230919101117.4097-1-tychang@realtek.com> <CACRpkdYtGhhNuBnP0MvMKiqP=wPsv=5K_ZBaWcgW3sssLrm2aQ@mail.gmail.com>
In-Reply-To: <CACRpkdYtGhhNuBnP0MvMKiqP=wPsv=5K_ZBaWcgW3sssLrm2aQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Sep 2023 13:09:45 +0200
Message-ID: <CACRpkda_EVEOP=LCjiBcSgPY7-mU9ENiOcw5taskL7TcwkMkCw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Add pinctrl driver support for Realtek DHC SoCs
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 1:08=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> All patches look good, bindings are reviewed by Rob, my comments
> addressed: patches applied for kernel v6.6!

Sorry, kernel v6.7 at this point obviously. I can't keep numbers
in my head properly :/

Yours,
Linus Walleij
