Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1CF7FD33A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjK2JvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjK2Juh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:50:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF901FC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:50:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbe716b511so4993740b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251443; x=1701856243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf5ZNG8VUFCp2pyyN/j4IhpXWszvEpfZvRBzDBYODno=;
        b=SXK3WvrigbTrtIbsCDam3+COL2f6YP2q5HgecgOnKtdzLkMsrD/FJ6tH6AtbHyZcwP
         KiosJ3mg4IehufXkmrWDJGE1XCvOFPhXs5nybH52eDUznwmbmGzQp17WPFMmrlwXQUQS
         Oc71WJtuGwdJgkRAJsHfkEB1q0/Xl7FAbKAs6cHYG2636BFV+8X+zMxatmEYmxhjHUpM
         BEo7wIyFD2naPX1tPjWsLGOrZoV0G9iWBqkpeut8QatEKX9AJViHfoNitOwt8PY1j/hG
         TlBZ/2NrHk3rWcVjkrkD9jiY3AYazFO8QnxPqJ4DKMdqr7JkDJ8OGp5sMKCNcEAJt3N8
         VWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251443; x=1701856243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf5ZNG8VUFCp2pyyN/j4IhpXWszvEpfZvRBzDBYODno=;
        b=MKRPNczsg110b7LTWjV0ObsYPN0ncSLcl+cMs56VjT2EJhHAuCWb6uigygBQarExyA
         882clJxtj5/kjvLHdiw7+bn4qqGI7scyw9eBIRBYeOymf318vCfVj9/kp24FLj/ZBRKk
         1bozk1yt9oO+WZQiRkjma3AJ82LDPMJEYVP5UjRCgKV+Ozha3nV4d3j3OE/XVsGlhAIK
         FMwXl8YsufFB6MKVk3tX6eEQx/DyarDNfBx27RXgXOeDMuGyMlwbAVbqkMW+9xwD0GML
         yqwGUrj1a0mjP0BvP1oKCGeK8JFB/9MkSTg9ISlC4XOP+FjQYmo0R3bOLAWgSLsB4VAE
         kMWA==
X-Gm-Message-State: AOJu0Yyqzb61edzAUeDzp7UqYIjqEkI57LkvTO/Z0I7pniZP9UCGXMju
        kw3w1dJy/9fwq4xHcieqD8uzpA70+2PfbR1yx+EXUnjX
X-Google-Smtp-Source: AGHT+IFa38cDRt/67rdkdTczADETZq2XVFPWoq7Fxsv18HaOXXn5sCx0O6qN8vJASiVVyFQnCd4DbX3cVlvGi3ZJYIs=
X-Received: by 2002:a05:6a21:1a2:b0:187:1015:bf9c with SMTP id
 le34-20020a056a2101a200b001871015bf9cmr21781963pzb.10.1701251443117; Wed, 29
 Nov 2023 01:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20231129091337.2084747-1-yujie.liu@intel.com>
In-Reply-To: <20231129091337.2084747-1-yujie.liu@intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 29 Nov 2023 01:50:31 -0800
Message-ID: <CAMo8BfLDPFycHYBm8MiDU=o9Ak=BeRMpzddXpjgSoL+9v2CU1A@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix variants path
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:20=E2=80=AFAM Yujie Liu <yujie.liu@intel.com> wro=
te:
>
> The directory in the path should be "variants" instead of "variant".
>
> Fixes: 420ae9518404 ("xtensa: simplify addition of new core variants")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  arch/xtensa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks. Applied to my xtensa tree.

--=20
Thanks.
-- Max
