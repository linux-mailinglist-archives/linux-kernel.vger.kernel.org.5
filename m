Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8E7E9E49
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKMONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjKMONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:13:10 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06127D63
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:13:07 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5b499b18b28so51606637b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699884787; x=1700489587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6+pycgnZG58S2WudqRgu7/urmppv02RyU1W64E8pNI=;
        b=SCpnL32GK+p3zrPuNfFVG2CUz5kOcnK38UNBcUPb7HX6i+1WeWRW5z7BNYzSJHc5Bl
         /vU+mWc3461SlG2OTWALe2mRMB0NH+wLoBdOOOkjAPnLn7Vuvtq9k8Lee9HJxoF1JDl7
         rwSLfL7qd08KS68QzX3WwVClNwibjMg4rp15r4Ad3y9MYHs6cWobhSAFSsHvg+RsT9FC
         Zd62KWjTEf3UPSz/r0TtnhQl7Zg5QWsBVwCXllwWjtEJCf2pgFPD9qz8L0aMJD5qdAcZ
         JDTj9O16lrt+8J0gBoIQ9FYaE3bdj8QLHLZplmXwSRAb5cxAD4LCI4MooKlqHwKn3nND
         fFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884787; x=1700489587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6+pycgnZG58S2WudqRgu7/urmppv02RyU1W64E8pNI=;
        b=uqVqSdAVBPnPJN0I0NR3rgqEv8xeH4HCAAD3PFIOJDMoUYcIgz5tEmEfedYe2C02FR
         gHjTlmcUT/NZhKUYY8H6w2kUUKfLsKgxqO+r+n/O7K0G++2D+K5ZzDEvsfao/xxmNejf
         00+2h5dF6E7rNyTmzwiqIrraOyTRJlteBdJ4m2YQDTJtfDSTW3M2g5Zk9FfKRMd/EwAu
         lxv4QIGFsRt+BsJDN9hmA+UjdoaVpJIrl3DwywNh83s4nf3Y2YJxJN5kwCFD+3m9r/KE
         9MUC9YA/HH8zc5we2LmRDljjJ7ncm9yXYUFJfkBknC0oG9//+d6hK8QFfU4S+Aza2/+s
         KZtw==
X-Gm-Message-State: AOJu0YyLEw+qac4bUr0HATv2WiZ/SJsHacrNa0gOrLIXvfXf0XO2vCzA
        aDS6okShek5PGAS+hkxEoUVFmrMDTTg7/suj0OiibA==
X-Google-Smtp-Source: AGHT+IGD26Kjd6X8qP+F+2+1/G7gpSLJN4W5nonKQd8XlGJZqGmUhTtV0CPqPtSKJ5F9k1AZ7XAeeH4NgiSFjX1VrYM=
X-Received: by 2002:a81:6c54:0:b0:5a8:1ff3:ef96 with SMTP id
 h81-20020a816c54000000b005a81ff3ef96mr7595283ywc.7.1699884787153; Mon, 13 Nov
 2023 06:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231031080807.3600656-1-nichen@iscas.ac.cn>
In-Reply-To: <20231031080807.3600656-1-nichen@iscas.ac.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 15:12:56 +0100
Message-ID: <CACRpkdZdmJQPx7-q0QY7=TpSDxr0W1md-sGwbKYc_kbCdEmY4w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: Add check for devm_kcalloc
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        robh@kernel.org, geert+renesas@glider.be, jernej.skrabec@gmail.com,
        valentin.caron@foss.st.com, bero@baylibre.com,
        dario.binacchi@amarulasolutions.com, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 9:09=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:

> Add check for the return value of devm_kcalloc() and return the error
> if it fails in order to avoid NULL pointer dereference.
>
> Fixes: 32c170ff15b0 ("pinctrl: stm32: set default gpio line names using p=
in names")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Patch applied.

Yours,
Linus Walleij
