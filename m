Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53D7A35A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjIQNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIQNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:20:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAD189
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:20:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-401da71b85eso39983505e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1694956836; x=1695561636; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KeYIqn2tdFkcVAufe9gBvH8l2EIbPxMaLKSc9nvnSeI=;
        b=fGP/lbeOLDw9ka7WpYIOuuqmh2b0qkPdH4OKothbxnK3awDnxiGkVXPoqDUU4I9Bbh
         gHibX/usDnz6WHH2BHTYY6hKXtmwJaoLJJwJO+eP1isLelK6Cv0rlx8qXE1PIHe3RdpE
         XcENRMZei5ZaA5Fvoxugqi3n5axgIOIQQUdZgJjIe55D6YnWB74vgmU96fCdQHdgoCok
         9yl9FQBmzI4Cb/Ma8gdsOlXtdfw/w5wBdHZckbjoPkE7y3vlsdmHnAzaOXU/WePYx+Ti
         PZ4/2YQYNzvM6VH5IR8i9KlD7lXZJoBbqf30HE2nsZFJv5cbe0038aHxi4mRLphfmfVl
         CTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694956836; x=1695561636;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeYIqn2tdFkcVAufe9gBvH8l2EIbPxMaLKSc9nvnSeI=;
        b=u0X9USICE6aYmYtcvVViAVVC12XBIsvpGQqv1lYrjmSd0kZVgeBF1EGiXMcqbpNkuN
         UE5AdsyuI4NeKO42WIq5oX2TMkUXX8u8P0lkxKTR0vpcqqfGdj+kuLsWzaXJfRfmabww
         wPHlygnIbJtklzy0D4MSvH6oDly71ncEiQe1MPDABT7IWGWAwaCuq1c7nCkEXfaK5DPy
         nSpK4jJ3A67pZg1C/fnop5l8mt73JTlm0lC/9o7KPpi4fuT8B5718Aq2JpojWaMusU5r
         DKu2Rqquac98ohXxXnPvKb/ze5Uu/ccuewghuBaWJSmmUjSYC7D4erWRiWPGyIysBkjJ
         tXTg==
X-Gm-Message-State: AOJu0YxmRUBOAXWiJR9sL1IgVvNqxKtpShzDomPUfFGzOTEKD7/N2s8i
        23zTZq8jK4ZlFSsfqRn89O+9vQ==
X-Google-Smtp-Source: AGHT+IH4ywV4aEv+TpxbpFW30ZsBFhptGh4bDnt8s/U1O/3wFXPg4T07xR32tTPSdkwu/HFEYDVc2A==
X-Received: by 2002:a05:600c:2901:b0:401:906b:7e9d with SMTP id i1-20020a05600c290100b00401906b7e9dmr6226687wmd.18.1694956835911;
        Sun, 17 Sep 2023 06:20:35 -0700 (PDT)
Received: from ?IPv6:2a02:8070:d84:9160:acd3:26fc:724e:a2dd? ([2a02:8070:d84:9160:acd3:26fc:724e:a2dd])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b00404732ad815sm8936077wmp.42.2023.09.17.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 06:20:35 -0700 (PDT)
Message-ID: <dd0f65048f7030184caad4d99b8277d589c6d352.camel@aceart.de>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial
 device tree
From:   lukas walter <lukas.walter@aceart.de>
To:     bryan.odonoghue@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas.walter@aceart.de,
        phone-devel@vger.kernel.org, raymondhackley@protonmail.com,
        robh+dt@kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sun, 17 Sep 2023 15:20:34 +0200
In-Reply-To: <3a66a198-5817-4c74-9047-c49e5bcc84c2@linaro.org>
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


>Are you sure this is 3620, have you tried wcn3660 and/or wcn3680 ?

I am sure. Downstream source [1] and downstream dmesg (wcnss: IRIS Reg:
51120004 which should equal [2]) indicate 3620 (3620A does not exist)

[1]:
https://github.com/CyanogenMod/android_kernel_huawei_kiwi/blob/cm-14.1/arch=
/arm/boot/dts/qcom/huawei_msm8939_kiw_al20_vb/huawei-bt.dtsi#L5
[2]:
https://github.com/msm8916-mainline/linux-downstream/blob/b20608408caff817e=
c874f325127b07609fbaeb8/drivers/net/wireless/wcnss/wcnss_vreg.c#L51
