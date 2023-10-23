Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D57D2BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjJWHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:46:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8486A6;
        Mon, 23 Oct 2023 00:46:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso436998566b.1;
        Mon, 23 Oct 2023 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698047182; x=1698651982; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ihrHhV1qIWSGDUJPcmUG3Dq/nYNoW90MCo7DQQacUk=;
        b=Pn6pqNJND3u+os1+PBKwkyN9b8EAcvDeRhnqslE3ASRfqObpuVlUBBQcvvKQ6h7/oY
         i38y8xV2pC2CGzdvMLK/r+AX3/JcvRFmUOetEgV4bDukyesOKRhzmg4HpgM2vdGyWerV
         bSgtirENU/w9zS6gJKqw8LZ/i0rvdvERz6UT6aMrzWgZAUxjyHab8GxDmts38yhcKGht
         NG681Nq7qujRCFZ8wzPQmsHmdDjHNylyrDdgq+L/UGxNL4LRILcGu0w1oH0wlub1b7Q7
         INF90QuYwROB1tKNQCujfFLalnwW01zG/3LEAKHTv04VeCVUthunA9IL+LF5v7q776cn
         5naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047182; x=1698651982;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ihrHhV1qIWSGDUJPcmUG3Dq/nYNoW90MCo7DQQacUk=;
        b=lHWcuDAbolglD2qQrBMaIIREeenlxwhST3mwNOB1I4Ge0FtkBnUAEQghK3om07oA74
         ZML3lMWiZ1Fv2xlsStkDQ2YWzqEz1Wt34vMxrMZuYZenniPF/7uDAzn3mZDNckVshq/2
         pReVlVbZ5ruU9Wi3TPumOERdBqhdQWPbZyGrRcxYXnB3rL8mgFmA+x6I7G34eL46DDaS
         VkBQiqkVUnKJ1X3OUS8Bi/9Xd9eqHxh9GxSyfYx44FmT5usKwiZN2uOIp+MV2Q74Rmxy
         lTLFxo5lCbWzg9b4pDPDKVfWtq8Cx+HiLqsbLuX6BMCNjZU0/YIYcCVShjAGV5jPfF/7
         cpRg==
X-Gm-Message-State: AOJu0Yznzjk+WkV8JzeqqZ4YvmWe000FTiAeWWociPLpOHSdIycR4u6U
        u+A80EjGdofbrzU7B2nwm2ACqK1QttnxtOaLpu8=
X-Google-Smtp-Source: AGHT+IEmA9OHcn5Osk80Y4+FXM/A/b/CLQ/mIiAggZOS1PbCqvFL3RZBYcIk8Po6Iih5KX6fVHr1gC8OzZ2dm5V0toQ=
X-Received: by 2002:a17:906:4fc7:b0:9be:30c2:b8ff with SMTP id
 i7-20020a1709064fc700b009be30c2b8ffmr6512097ejw.61.1698047182034; Mon, 23 Oct
 2023 00:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231023074319.14456-1-lukapanio@gmail.com>
In-Reply-To: <20231023074319.14456-1-lukapanio@gmail.com>
From:   Luka Panio <lukapanio@gmail.com>
Date:   Mon, 23 Oct 2023 09:46:10 +0200
Message-ID: <CACi=Ov7Ev3UNfL8Mqd0DXcURBEfM1r_RhEmKMw5gRGTKHmgdvA@mail.gmail.com>
Subject: Re: [PATCH v7] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
To:     Andy Gross <agross@kernel.org>,
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

The v7 patch was sent outside of the patchset and to be ignored, sorry for that.
Thanks,
Luka Panio
