Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765F7F9EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjK0LrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjK0Lq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:46:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213DB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:47:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b34563987so22965095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701085623; x=1701690423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tA3boN6EG4yS9sARU9W7D9LN4ahR4KmDV0zSEVrFb0=;
        b=nEg+V7LBIaLbiPtIHMYgKvHXwNi2+b7HjwYtp7LGjgmofHn4ps0bc/zPZ52Y3QP0J9
         48ODicnGQzPeJ6xxCxxOoS3pnUOpxpZ26+h85QamkTcmylL4kBlbK4zmTO+SA4lNkm/I
         ldD+0iKWoGLLCiaqbllKuKtBz5BwbnfigdQ+OjLc2tff0ehjZAeERZULXuzZXowcIgEZ
         88LWwHs0aQIdiaGpnL3kF7QKjY/bwqJ6kU/vDonUj6MDD3rHlci5/dKC15FaT5+wVisl
         xAr2ykvWJbdpFrEVNH+B735//7T1pTO9LFMAD1+ayQ+lm7KzGmaq6Dy554aANxr4N0r4
         ZBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701085623; x=1701690423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tA3boN6EG4yS9sARU9W7D9LN4ahR4KmDV0zSEVrFb0=;
        b=kRTx+xtegivFfBG1DlcskFn12tymgOaOysAJyjHqMlCwuVLD+4QLlb3DRg6OUKXxk/
         vJQrgXof0KzSTA5v6ZJlAbe5lKtVZdXkhMQtEN2Ky0elNnA11BvHoAwAFIxXtnW8FE40
         CKzgohhHuHyPhAR0BJWV8B6kuJXEzzYAiCmVpvR6kANovzuI33BNuZwKl43+mftV1lZi
         7KtHQVB/5OMrGLJH1U/q9/ahwpqTF5jUUTElZIg5ny8hBB5dXEQH8JxzJG4FJTaI36OQ
         8dRD/e7ZY9krVkzrq8YF0jLvg5dBtopIFMNQsi5Ozc/Rq/Qox48hw44k6aC6xegJtF5B
         duGQ==
X-Gm-Message-State: AOJu0YxRAFnef1B0Nl6ho22EkQ3n4qXrVy1aelp+PQQOjIpkiwGKEkQ+
        mkCPQPw6D3oNV1OM/IomOPcwo+Z4fMRfNosANY0=
X-Google-Smtp-Source: AGHT+IHFHh5s3DrJkF+ahST3zPitBaks2yNwrnyWDMDsu2R3tzZh+/mmIzmyi63lGqBAWzE/QyPjfw==
X-Received: by 2002:a05:600c:6d3:b0:408:37aa:774a with SMTP id b19-20020a05600c06d300b0040837aa774amr12532754wmn.17.1701085623387;
        Mon, 27 Nov 2023 03:47:03 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id s8-20020a7bc388000000b0040b4562ee20sm1681859wmj.0.2023.11.27.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:47:03 -0800 (PST)
Date:   Mon, 27 Nov 2023 12:47:01 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: Aw: Re:  [PATCH 6/6] crypto: rockchip: add rk3588 driver
Message-ID: <ZWSBtZAwn_58UtcD@Red>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
 <trinity-a0ee3146-f23d-4f6c-b29c-5fe446c4d4ad-1699797868421@3c-app-gmx-bs50>
 <ZVtVkACNHTcCjqGp@Red>
 <trinity-a9a71294-1396-43e4-9ed5-9ee2914ef093-1700838301802@3c-app-gmx-bs48>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-a9a71294-1396-43e4-9ed5-9ee2914ef093-1700838301802@3c-app-gmx-bs48>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Nov 24, 2023 at 04:05:01PM +0100, Frank Wunderlich a écrit :
> Hi
> 
> > Gesendet: Montag, 20. November 2023 um 13:48 Uhr
> > Von: "Corentin LABBE" <clabbe@baylibre.com>
> 
> > You are using kcapi-rng but the driver do not support RNG yet. (and probably never if I continue to fail having good results with it).
> > So it is normal values does not change.
> 
> which functions does the driver support atm? or how can i test correctly
> (and which kernel options i need for this)?
> 
> regards Frank

Hello

The driver handle AES(ECB CBC XTS) and hashes (MD5 SHAxxx and SM3)
For testing you need:
CONFIG_CRYPTO_MANAGER_DISABLES_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y

Note that I have already got several report of random hashes tests failling, but I am near to have a reproducer.

Regards
