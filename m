Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046A7DC240
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjJ3WCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ3WCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:02:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573711D;
        Mon, 30 Oct 2023 15:02:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7206257e87.0;
        Mon, 30 Oct 2023 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698703359; x=1699308159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6LtUKWtO+7Vzk/wEC7O9RVhs3g3csgXQpvHojkT5a9A=;
        b=njoD/klkzym4T16shWSRU6cBb7Kdn+q3KGBSgMiSFhD4IXIgq/6NSnmomX4QxgKdQS
         3P6LzRmli9Sd1y1Xe4x92gdeXXXO9VYfk/peOFSL9IUmucvW/wrYbo6TQ61dF1QkFC/+
         X9jhHvFAL806JeJE3Qx7BlRHbpaFX2Nb0An8dWM46MFYmBU1ekFm/kkfWyOqcRxVb/V2
         tGu7w2pqbN6UwA+g37f50KdTQgpONep88kxwpaq5MlzmwoysybDcc7OTuClRCofRkl1L
         2BfE5tGgbSCmDbjAmDMsxjK4DheE15mPOIniAbWoZtlyWdG5kM/cnK98Iz2jjCGa+16m
         UutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703359; x=1699308159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LtUKWtO+7Vzk/wEC7O9RVhs3g3csgXQpvHojkT5a9A=;
        b=KKAKi/VW5gmLyPM4pyFdspLZDEz9Yy2mknXXc6TsEJgCfJYnZCRp7y9eJcbOn6LReS
         af+V590Ocy2eDLPe3oGRb7F2idLguLlsAH+6l2gULDE5M2aeRtIB2zGTnNuG8EZrnk8M
         DY5HJ3afYk4LosfYk9EprDJqNyN+QwOJ1IQNRkt1M6fuYAPvbCJdMNq4EXiPcmF0e0TA
         zE7A3gUws8riVH70CJNRenu42hPr0BF1iP/tXY6kCol/nAd8AzGduJhxKdSEZ2/Fe9Lp
         wuKd1yjVrwK1pszcqohFbFLMni7/enJS1UFoBOylWVPVWUo3WqiCpJCMErDQBnxZXNz7
         La0A==
X-Gm-Message-State: AOJu0YyJ9XmL5J4D6h66jae2ZGIj08y5QvOTYtcIoL2OYR31B7GI1Svt
        MjZiMPb/36/xhMFv7pnUXsg=
X-Google-Smtp-Source: AGHT+IF2mpKxmpquRSqB8jJA/lyugpMPhOSqogIlt4M/FrMCtWZkryvSM7NxYaijp6uGzqmipvzVWQ==
X-Received: by 2002:ac2:5442:0:b0:504:3c1f:cbd9 with SMTP id d2-20020ac25442000000b005043c1fcbd9mr7950412lfn.16.1698703358295;
        Mon, 30 Oct 2023 15:02:38 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:c490:292e:2164:5dcb? (dynamic-2a01-0c23-bc31-8900-c490-292e-2164-5dcb.c23.pool.telefonica.de. [2a01:c23:bc31:8900:c490:292e:2164:5dcb])
        by smtp.googlemail.com with ESMTPSA id c26-20020a50d65a000000b0053e469f6505sm56396edj.26.2023.10.30.15.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 15:02:37 -0700 (PDT)
Message-ID: <a6471019-3588-482f-8dc3-6503f3f3e4f2@gmail.com>
Date:   Mon, 30 Oct 2023 23:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and
 RTL8107E
To:     Patrick Thompson <ptf@google.com>, netdev@vger.kernel.org
Cc:     Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231030205031.177855-1-ptf@google.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231030205031.177855-1-ptf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2023 21:50, Patrick Thompson wrote:
> RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
> eapol packets unless allmulti is enabled. These devices correspond to
> RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
> in the same way that VER_35 has an exception.
> 
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
> 
> Changes in v3:
> - disable mc filter for VER_48
> - update description
> 
> Changes in v2:
> - add Fixes tag
> - add net annotation
> - update description
> 

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

