Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FA080C485
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjLKJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLKJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:26:33 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842CF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:26:39 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67abd020f40so42439836d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286798; x=1702891598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wulg4+tUdGy/R3+bfLHBvkWxaEg78fQV6NpVDVKy7Js=;
        b=e6DmILjp8Wp6InWdpBsdXVVkfqpRDbrIrdv+Fufqe1AwPNEgyyqXjCo/I420dj1ppa
         OYkpN3YFnEElxxChMtqOopfYkctypi3AJQXuzFCmivv2XnAGa4TLKgGTyOMEr98acWK6
         GJZDLxTLrESt9Zogn/FumyKHyy4O6YJJvoRwCw7awTh6hefODhyqa3d9z9lcCEvTR7F/
         nvx3gV2Vqx1BvTV3TFLtZLwAWqfGt3UNXRkVhvfJaA7RPbHOT91c8A9qRSrtman1YsJU
         eMcwSHjzZFzb1e3CzlunUcwHkW8ruGdKQSep0WyKv9w+blCzvEWz3GH+iZiII9NZdODa
         rCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286798; x=1702891598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wulg4+tUdGy/R3+bfLHBvkWxaEg78fQV6NpVDVKy7Js=;
        b=txrpUhjj1fsICWcArXfVTpVDNBMK5E4aWeM3k6YCvbhHilM/t2/qIdw6f4df0LkIGs
         Qjh2IA6EnZ/sb0y5TE5aC7pzVN9rp73IU43JEJu55kmWWW+MqJXPiYC1g0BuiuQAEwKA
         GlVZnPFp/e2X13WFnreti5rjnW6WuOrxv5CuLv9ZH6YcBd4aKNDF+U3hSHB0sNWiEA9T
         qIm1X6rnFKau05I/uF9seiLLrWW0nYhA2d3hVGKR3BhSoEZ4MWE/sX7Eb309P8X9y+QR
         0hYBhggmiqQhHJm6Oj745b3EeIDAvJM8n8ZNRmc1GCYyeddNJrBgb9/tzOvLtNZtczE3
         RfXQ==
X-Gm-Message-State: AOJu0Yy+JmOEIW7zRbfRWvEYhzwV+MUyk3VzxCUl0AziOuVpHjIci+Vq
        epyCqEGQwcibVQQJMp3rOqEadgxtZSsNEVgm7yKYCg==
X-Google-Smtp-Source: AGHT+IGJK7yWB6DUL7NT03/GV2yF3fAJkHszJ9rd8msS+2kclQSARKaIQgxwDs8Gje2OH1aBF3x/Kvt5YEEv9irmFbM=
X-Received: by 2002:a0c:e2c2:0:b0:67a:3a51:8773 with SMTP id
 t2-20020a0ce2c2000000b0067a3a518773mr5019332qvl.5.1702286798466; Mon, 11 Dec
 2023 01:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-11-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-11-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:26:01 +0000
Message-ID: <CA+EHjTyscwpSeRytJu_OX+pS4+BMXorhoOSvTuNsUM2kR=VkCQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm64/sysreg: Update HCRX_EL2 definition for
 DDI0601 2023-09
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sat, Dec 9, 2023 at 1:03=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> DDI0601 2023-09 defines new fields in HCRX_EL2 controlling access to new
> system registers, update our definition of HCRX_EL2 to reflect this.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

This is not an issue with this patch per se, but all FGT registers
prefix bits that trap on 0 with an n, e.g., HFGxTR_EL2:
nAMAIR2_EL1...nACCDATA_EL1, but not HCRX_EL2. I think that most
HCRX_EL2 bits trap on 0, except for TALLINT. It shouldn't be done in
this patch, but I'm wondering if it's worth the hassle to rename the
bits, or if there's too much existing code and in-flight patches that
it's more trouble than it's worth.

That said,
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/arm64/tools/sysreg | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 4137179e7570..1acec8f5c37d 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -2458,7 +2458,9 @@ Fields    ZCR_ELx
>  EndSysreg
>
>  Sysreg HCRX_EL2        3       4       1       2       2
> -Res0   63:23
> +Res0   63:25
> +Field  24      PACMEn
> +Field  23      EnFPM
>  Field  22      GCSEn
>  Field  21      EnIDCP128
>  Field  20      EnSDERR
>
> --
> 2.39.2
>
