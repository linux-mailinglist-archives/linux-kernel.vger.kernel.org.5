Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305AF7BA19B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjJEOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjJEOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:43:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728E16AF0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:21:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50336768615so1402680e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1696515667; x=1697120467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onRU8Y/jXDlaGXA+m6kH7bamAm9GIlcBQ1TGe+vGhSQ=;
        b=Xa2ycxitRJmkmyEPwvy1Ky5DIfNkkHFzikrjB2wJ7CqXvvmT/Z/MZnGcGgTZdCInRN
         oCGvz1UKgsRIj0lG7hAHF/IMkLubyfCiAh/yAQvfhWMKUuZLdGrJD/NaYtH60jysuVC7
         1KbxrebVK+c+x9p16HQqKvB9ZtH7P5n04xkqYT1yHm7zZy1n1Ud6NAedTuvwLRdCOgwh
         cy/32XlHQcX9/BvG/N9Ta7YSVBt6/Yr2x4/dftCaW9Ayzi7oqFO3rslV4f3seZj7h/6N
         TlXK/hNyM499cTblUyi1QaiCDX4fKJQ7zVfYDtAVEz/BgTj4ohw6aexdfPeRAjMMgxS2
         6bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696515667; x=1697120467;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onRU8Y/jXDlaGXA+m6kH7bamAm9GIlcBQ1TGe+vGhSQ=;
        b=DUO0VZ/3rD79MteKq76RacGrimyDN2OspAsJ8xk+4BQqs4pXPH5k6Wraa17+oCgt1l
         efVdsW6Mvc89+EEt/TZuWm+YOGsookq9Rut16P1wZ+qvROH9SK+JJRfiV015TvZJGUSi
         TjkDmx2qN/5TEC6aqRqIWQn3altGvp2j0ZCBHtO2dXdgihQj5xDhkI7QRB6VzO2BUf50
         ys1ExKrTfyAs6MI9YXbaTB6JSDzupdj9xdaIXW6SIQ+4BEjWSZSrIcl25eKyof7ZFuMs
         YBmH1oF7ArnzZrUUKfZZu37z8fWvH+aaZ+uUjE3X96vTJnzS17JbnE8PjCcevm+swnTb
         ZWzw==
X-Gm-Message-State: AOJu0YxyUE4X/ZQEHkTCdsCZAQrl0s1QB+nlHUC+DJi7ek/AMagvhNNo
        0L6l0evuxXuZ+vhCawKxfkoVLA==
X-Google-Smtp-Source: AGHT+IH4VhF219dRGP70eZMjQoWP5soQazPniTQw0zoui1ncQEviX4+FQu6riCbAWM7259/4rJ7fLg==
X-Received: by 2002:a05:6512:210c:b0:4fb:bef0:948e with SMTP id q12-20020a056512210c00b004fbbef0948emr4039144lfr.5.1696515667464;
        Thu, 05 Oct 2023 07:21:07 -0700 (PDT)
Received: from [192.168.2.171] ([94.186.212.25])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78056000000b00692b6fe1c7asm1457287pfm.179.2023.10.05.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:21:06 -0700 (PDT)
Message-ID: <284103cfa6bc312ccf12a552dd61d12108fabfbd.camel@aceart.de>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial
 device tree
From:   lukas walter <lukas.walter@aceart.de>
To:     konrad.dybcio@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.walter@aceart.de, phone-devel@vger.kernel.org,
        raymondhackley@protonmail.com, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Thu, 05 Oct 2023 16:20:57 +0200
In-Reply-To: <8e6a41b2-7ad9-4cc6-8f95-93b8c2e4151f@linaro.org>
Organization: aceArt GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is this fine?
>> Should I send a V2 with the signoff and reserved-memory changes?
>I don't quite get it, what signoff?

Krzysztof noticed that the Signed-off-by are in the wrong order.
But I was told this alone is not worth a V2.
