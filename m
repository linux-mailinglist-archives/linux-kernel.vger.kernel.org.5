Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C70755748
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGPVGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjGPVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:06:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39D1A7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:06:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5833b517b32so5438847b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689541600; x=1692133600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdfCwih+5dEsklJPwU/YkEF4cHq6v8XcSCOAFgMBsQg=;
        b=x3DeF3yeIoB4iyzvNdtaDUi3o/duhMLvHXaCCUlrp7rfvqxpWc5AW9fVhVjzk5X6oe
         KlZ57RwU8n4v4ckvFDz55IuXCWzw2vDYvtPF9aEYpyO5BIUpqYYHebA9kpmJwggRv8uk
         0uoq4HJlR52IEYx8f/eFZF7hhsNfd5QMMzHjxRAYfDtwR7RKX+dFoDbAA1qkiDPK7avC
         O7euvbdUvCPC5jurm3QcShLN3jQe4l9wUSCknTIj/4AfeXyvgVijtPb8jRVt0/8NffER
         BtoI0DNY/MGZY0paejKtHSwfr2gVf/IweT/NiOmUbJvQkXC6Jo7sxf4JJ/AIo6adLUn1
         IjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541600; x=1692133600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdfCwih+5dEsklJPwU/YkEF4cHq6v8XcSCOAFgMBsQg=;
        b=KvVvEhSxR9v37MbcccDUT1DuykFt37RD3m+3Gtyjmb/wWQ893pTpbJWp0I4LqIGgO5
         tzWw3sX/asDo9yRt7U69neIizTShWUYfjERFhYNvfJJhTj0odA/huHH7kR/5F+QsTsgT
         DKc9QrK5BVtn7RcQMXcymbIfkWw8k2ixxoFSSF3Fp1FpftB38tnQ66uuvzlMIFv17UH/
         kLESQQUOWt73Z/XQl0bVUhdWdqf3T3xtbad1OT7KRRtatDoxNJhAQeITOqwyl1/YeGpy
         TWbpJsE+lHAq+wnn1oqf69xoF2PDtVzXcGAF/ZEXx2OPWsUhzyWo/o2odtJ3HUrAhCw+
         0nNA==
X-Gm-Message-State: ABy/qLaQ7S+9aWbSE/FLBP4yNKHK4mdCpEoP9gwDSAxD0c3YxvywW5yd
        0xQwAtBCcmV3sze0HAfe27dyBE20u+aznBx0+m1gLg==
X-Google-Smtp-Source: APBJJlGYH5otWM7ZH+BmR5IMZZxK6D2cr9NtseCkEkmHNTjTEyYhzBuFRf/ivmKV2OxPDC3n/BN3V9HuKHQ6fNxHy+s=
X-Received: by 2002:a0d:d847:0:b0:570:4646:15a4 with SMTP id
 a68-20020a0dd847000000b00570464615a4mr12170396ywe.8.1689541600343; Sun, 16
 Jul 2023 14:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:06:29 +0200
Message-ID: <CACRpkda3SeW=E=cdEd7bvdd_DTTXLoyXAPBx0n6wYOk_GnQoVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add pinctrl support for SDX75 PMICs
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit!

On Fri, Jul 7, 2023 at 7:20=E2=80=AFAM Rohit Agarwal <quic_rohiagar@quicinc=
.com> wrote:

> Changes in v3:
>  - Corrected the versioing in this version of patch series.
>  - Keeping the Reviewed tag as there is no change in the patch.
>  - Updated the patch series subject.

Patches applied!

Yours,
Linus Walleij
