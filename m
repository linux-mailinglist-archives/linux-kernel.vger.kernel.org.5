Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4A808EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443463AbjLGRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLGRhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:37:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D01711
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:37:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1c6dad2dd0so33274866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701970647; x=1702575447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaPW6iG2qBLLizRIc7bjpL05yaqfcnLXrnwA/boxXcA=;
        b=VNpnvC+XyMnTh4GeAPgxupzPYbrsYpPNELXEL3GfGFt1SM0TtiNsIiuq28QwbYefmL
         nFkbECZw7bIBLRDEnUwVxQvw94wausZ51dFzx1j6a2UU7iCH5+4L45koBb6Oxf1PpAgU
         JbjoUMIuznEaM19nNcN1QFRgA02HdjX2RXV6hydBlh3DqqJS9aBFxt+JW+2ltGCtjVln
         EpREtw0vMlcIrQV8H5CRkUMaIe09Ue6rQnHUizf6HV3qmb6OFJ+acf4P0v8wXfjM9+1L
         68/0Pffr1o9grigU55817NXJhex0+eTi1+BHeXe4/B5kzAd9WlnGvkJSfsPg4z77XOf/
         KHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970647; x=1702575447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaPW6iG2qBLLizRIc7bjpL05yaqfcnLXrnwA/boxXcA=;
        b=n2tWgQ92TXKF5GA0pMYUZeSHRmCRMQ890vBaKuuvfEY/nPRBvYkmEdii3ZY+MAJSM1
         H+WNWMkBL7tfnPZX0hTe41LqovFnM9JO8c94UwxubPCjS6/l4EynjtpF0AFY5Y+LpB6r
         eA+ED5wP2u8ogyo6edc0onrO1KCxxb3r4MV3rorytrGzBWNcqPSasOv/Bp5kUyeFqvj+
         hwhmuHIT4bcRjjDYd2DQWW4qNUQYMPV95S8pEHQlbB3T58IsV6E+ifjfxjGIPpkHteop
         N61PqSzSylh2ljIWN6fTYOx7gI5j6VNIecZLnM/qQ5POdj3NVhQRD2aKrwIzsf2xLHRP
         DVpQ==
X-Gm-Message-State: AOJu0YzSjGKPUiGuJ1JmSK+rVp6ygZdJOAatTsB3/oUa1m+DSzFmFbDk
        iIrt/R1J/cWK7V/n8whpsVFNkcZFmrY=
X-Google-Smtp-Source: AGHT+IFFG7xc8N6UrPAk1y6yp7QjjpA3oxUsdABpDY6ZiwM4RCQjP1vO0co33O5D2wXojC2ef1kJeg==
X-Received: by 2002:a17:906:2295:b0:a1e:1afc:4594 with SMTP id p21-20020a170906229500b00a1e1afc4594mr2795696eja.0.1701970646835;
        Thu, 07 Dec 2023 09:37:26 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b00a1dc4307ed5sm6035ejc.195.2023.12.07.09.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:37:26 -0800 (PST)
Message-ID: <0541b225-cc2a-491f-9631-212455c0098f@gmail.com>
Date:   Thu, 7 Dec 2023 18:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: this patch series renames (5)
 different variables
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231206230404.1721-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231206230404.1721-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 00:03, Gary Rookard wrote:
> Hi,
> 
> This patch series renames 5 different variables with the checkpatch coding
> style issue, Avoid CamelCase.
> 
> Patch 1/5) renamed variable bAMSDU_Support
> Patch 2/5) renamed variable bAMPD?U_Enable
> Patch 3/5) renamed variable AMPDU_factor
> Patch 4/5) renamed variable MPDU_Density
> Patch 5/5) renamed variable bTxEnableFwCalcDur
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> Gary Rookard (5):
>    staging: rtl8192e: renamed variable bAMSDU_Support
>    staging: rtl8192e: renamed variable bAMPDUEnable
>    staging: rtl8192e: renamed variable AMPDU_Factor
>    staging: rtl8192e: renamed variable MPDU_Density
>    staging: rtl8192e: renamed variable bTxEnableFwCalcDur
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 ++--
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 +-
>   drivers/staging/rtl8192e/rtl819x_HT.h         |  8 +++----
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     | 24 +++++++++----------
>   drivers/staging/rtl8192e/rtllib.h             |  6 ++---
>   drivers/staging/rtl8192e/rtllib_tx.c          | 10 ++++----
>   6 files changed, 27 insertions(+), 27 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
