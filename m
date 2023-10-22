Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4907D24EC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjJVR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJVR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:27:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE856C5;
        Sun, 22 Oct 2023 10:27:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so377300766b.0;
        Sun, 22 Oct 2023 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995626; x=1698600426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpTr8j/cPhp7gOnGe37U1tLWRCKpL1TT2fZA0Di57mQ=;
        b=WBN+ebNf9HQt71GQLCVaTcmYO7OiU2AixAgwNU0OfPgX0cuNHuhywtmCMZEzYf6zqD
         ZRV1RJ46mbdEODlVU1ufhGVvvoZTRyB1p/Sbh7z/x40VJOLCyZps9C2ifQWdNGtUX5LQ
         5K4x5F0ZFBNdSJUzcoBnubBoN+itP8PvTBBon1i6sqSGvA37s/lZCNzAMM1MPWJF2CHb
         8kBwsZhYMm7K4rivsK/Uattcro0OyqAVcg5rzpRpx/xPqhUJ6katb8jXNECA3KgvyIbv
         EzNuvTdGgS9UDMBydP4qUsoRfulv+49JqWmSc9MFSee0nUCOttn7neymogXgmsMAFC7V
         rJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995626; x=1698600426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpTr8j/cPhp7gOnGe37U1tLWRCKpL1TT2fZA0Di57mQ=;
        b=TrsJtMiSwxpO/ESLIUl35viW8O+sXIHlRZwC6rOHSfJQ7RhEjY919H9q1tY6fllxkK
         I1wQFVrCmQTmWxLCJm8BOluZP8jgEmVEOoC38PzQUkFuHhvzwGqFpWeprt1+ge4NCUjC
         6nEYIsmuObJdiYp4lJtPVHEe4g0pPuMoe7mTm9xy+kc/br07p/aoEVpcvd6ZfqnddZEe
         E40hZ47AEjocXUw18wuehMWX4H6x4tkBnlE9I4j1Wi6TJMfyOPUxkvtZMDjD+x+iwuyL
         F79mi4B9XyNtcvgookHZObIq0B03BkFWMjMkLwrMkhD/xqeb+sRHV/wJ3eA4EFjr6Yt0
         IBPQ==
X-Gm-Message-State: AOJu0YyWz6hD7WP8CTZ0yvROZKOHrVAfsAVREL2HvfVDyBgr9Mk/kAeK
        k3iSoN3oAeBbzKQ4DCFKJAuXMsujPrRGN/VOG7c=
X-Google-Smtp-Source: AGHT+IE5z+j1t0D67TTY5nruM0zAtbUUw4/HoQZHVww6xljiYHoejJmNLYD3eGCNNyXU/8EjSH4oGlQ5OXC3+LXobRk=
X-Received: by 2002:a17:906:7951:b0:99b:ed44:1a79 with SMTP id
 l17-20020a170906795100b0099bed441a79mr6277611ejo.3.1697995625775; Sun, 22 Oct
 2023 10:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231021203403.215023-1-lukapanio@gmail.com> <23fa10f5-1220-4e38-942d-4033deac2de0@linaro.org>
In-Reply-To: <23fa10f5-1220-4e38-942d-4033deac2de0@linaro.org>
From:   Luka Panio <lukapanio@gmail.com>
Date:   Sun, 22 Oct 2023 19:26:54 +0200
Message-ID: <CACi=Ov6wjptBidbBxHDpRGdnV8W6yHxO=e92B3pVP1eXRvU8DQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] From: Luka Panio <lukapanio@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)

> Your subject is not correct.

Sorry, but what should be there?

>Please include full changelog. This is v5 so what happened between v1
>and v5?

That is a full changelog, no other changes to dt-bindings were done.
 Thanks,
Luka Panio
