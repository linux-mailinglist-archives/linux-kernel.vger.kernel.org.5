Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B946C78DF82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbjH3UGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbjH3UFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:05:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4F10F3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:49:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso5670763276.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693424889; x=1694029689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJMdw/C4AyMPoyB2tq4Z62TY5NrdXD5YnDuPj2zmJiM=;
        b=njJIUNv8KWQ/BrI6KiPJhRxe9apUJc6X8Mh0GZIx1JfrYqOYRX/GtSrSdu/198UTcS
         cr8whSpwBEk/mWljKOr0AUlJqp2vDU3jrb4GF1uqOIZA4Q97tr5G27Y1iKFKArSBdwqo
         M9W0QfP6jzimf8rV8IIZfYxyAjh4Gd0BLjjBHVVoH+iNmoU7BgA9yFqyObwUbJ5lVMh8
         huMj9bLaluf9/ou9F5GEBnDyZPwC4oyzzhrU0qV3ut4KnliGE+CEm83C7x4fmZKONOrK
         zAhk5qc/19rVXPL6vSYeqlrG5QO21ZxykJJ9c/DTtK0c5pVZu1kTfcyXskU3NRap0yH5
         2bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424889; x=1694029689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJMdw/C4AyMPoyB2tq4Z62TY5NrdXD5YnDuPj2zmJiM=;
        b=d29CeJcqb6TxgaGXXAYc6yr4RNP5hajDHyYVOxtQqWWHxBSHOiXhZhtokdrJW0aLIH
         jABax12A9Ni1VyP7i90SwU8FY46JAp09ARfX2BNgipUT24sgZVK/NZyxquuqTpicwt8E
         jtRjLcFzWOtf0Y18J8FGW93xgcsV3hM+I9XvT+oIgMBy0lhEA/KAS2LC1irOnjKWlBXj
         YiNaRA7jWrqaHG9/oVTfJptcI4lbI2SwIUJLJDqZQoZJKeyW7fEAxMoY6QHxYXMXjfLX
         dt3rdLbbAUOfDib60XuLRcs0pD2cNSw7FTe++B7Ljn9nIkRDWmOrga5upbSaGeHOQKCE
         fFZQ==
X-Gm-Message-State: AOJu0Yzmm0TQ5GanLi8PSXuYc/RvkqVJ4d7KbXwsTJzIlQHx1XRUI6cf
        qfLoHbYfbrtrNPRnjzb5HxK3OJ2avXQqPFzm8nxdBA==
X-Google-Smtp-Source: AGHT+IGkX+b8/id5mnhsdSwU9pp41YFk3WYZkYEZqYPlBixDk1KbdsztU74V3Q6iBQqWEbgI4/9irEaASDq7WrvYvAE=
X-Received: by 2002:a5b:889:0:b0:d47:3d16:4b0d with SMTP id
 e9-20020a5b0889000000b00d473d164b0dmr2944641ybq.25.1693424889246; Wed, 30 Aug
 2023 12:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-2-quic_gokulsri@quicinc.com> <3722a8f6-8f63-fe7c-6983-ac96caa18c87@linaro.org>
 <d2080d0b-f0d2-b5f2-4fd5-c929735e406c@quicinc.com>
In-Reply-To: <d2080d0b-f0d2-b5f2-4fd5-c929735e406c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 22:47:58 +0300
Message-ID: <CAA8EJpo=e0JNWRhERUFFtLZ6o+hMhdBspC8yPi3j8U0AAo_FQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
To:     Gokul Sriram P <quic_gokulsri@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 21:31, Gokul Sriram P <quic_gokulsri@quicinc.com> wrote:
>
>
> On 8/29/2023 3:39 PM, Krzysztof Kozlowski wrote:
> > On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
> >> Add IPQ5018 compatible to A53 PLL bindings.
> >>
> >> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Knowing that this patch could not come from downstream (it's some old
> > kernel without this file), I really wonder why two people were involved
> > in developing trivial one line change.
> Sure, I had kept this co-developed-by for this whole series of patches.
> will remove co-developed-by for this patch.

Each patch is individual, even if they form a series. Different
patches might be developed by different parties or a combination of
them.


-- 
With best wishes
Dmitry
