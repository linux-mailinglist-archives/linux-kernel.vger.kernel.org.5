Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56977B9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHNNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjHNNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0B10C6;
        Mon, 14 Aug 2023 06:23:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bb140cd5a5so3455720a34.3;
        Mon, 14 Aug 2023 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692019433; x=1692624233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrPNQERrOv3TUTMR4WcWsfPPW9clyc64cY5xGbhYQfU=;
        b=qRMXV3ux3UEznrhbp/FNBxNre5mDfXcdXEgxRffHEVNISfrJvmgkVGvEIdcBgpiz7B
         eYw19fAMKPMUvrlKUsdlfcUaRjDwz+CSvsJOW7Uz2vv88Jos+K2c/WDk6MZsf1BizKLo
         5pf55lrnaW8WDphjg90V9c2JZAVeH0qfpXrekjo+a1xH59KK1ajTPuGTBz2yix9btarh
         ETtGjq/Jy5R6rzZUqMqGFjJoJSLPud4Ak2T70Brb/VJooBuNARe+A6M0zHBixc8a2Z8X
         DJuD/CHJvMPttngCAMDfi83GTBCEH1SBWl11ba89qjBJpo8hreXjvTCxR1u4c4qCIC+9
         CHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019433; x=1692624233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrPNQERrOv3TUTMR4WcWsfPPW9clyc64cY5xGbhYQfU=;
        b=RrXUYhamYAG4c14hhMajPV7LtcvtebHzdZourjf3c3g8tIPESETLW4+n4w4+pgB3+y
         vd6UTOkGOk6JPUUzfQuyl744DAyB+WDH5t9kYm9QrPqEyk8iejf8H1v2cV6W/oTC22em
         h0p2ZBHSJCRZlLp/MOf4yfYWrVti6qGayouXHFsO9FWE16HULd9u6PGG78n0oeugIM88
         /0y0JrWkINPJqppZ5iUANd7DLi4sY39L0jnw08dFq/n+w6fBoKF3NpZhUQWADW41fm0a
         XMBCP+wtM0m1E4L49MAOYKjmR9ZWRu3evn0ww172ZBa59c2KPrz+fBjaa5kXaV2g2mQg
         AdVA==
X-Gm-Message-State: AOJu0Yxl+F938WKnlzXRsbJ3+I4To8OcYAbW0kaDHEU6pX1YmBEC6wHZ
        KuYEoe3hhdrL2MX22w82V2HkLws9An3Bu42Mt2M=
X-Google-Smtp-Source: AGHT+IFnyrKGUBSBRzYP9MZWbLPYVlvyCpffBIQq5VQjXF3tzYzUHmgGqPhYE+0g0sf0xcHWlAf7JP3fXn3i6xo0t1Y=
X-Received: by 2002:a05:6870:440e:b0:1bb:b172:4bd5 with SMTP id
 u14-20020a056870440e00b001bbb1724bd5mr11409614oah.18.1692019433185; Mon, 14
 Aug 2023 06:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230813160936.1082758-1-sashal@kernel.org> <20230813160936.1082758-22-sashal@kernel.org>
In-Reply-To: <20230813160936.1082758-22-sashal@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 14 Aug 2023 15:23:41 +0200
Message-ID: <CAOi1vP-+xfmQBNWL4iKC+bB-T+yjPh=zF0nBqGMeXCdvpf7+zg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 22/25] rbd: make get_lock_owner_info() return
 a single locker or NULL
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>, axboe@kernel.dk,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 6:11=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Ilya Dryomov <idryomov@gmail.com>
>
> [ Upstream commit f38cb9d9c2045dad16eead4a2e1aedfddd94603b ]
>
> Make the "num_lockers can be only 0 or 1" assumption explicit and
> simplify the API by getting rid of output parameters in preparation
> for calling get_lock_owner_info() twice before blocklisting.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

This is a prerequisite patch, it doesn't make sense to backport it
without also backporting "rbd: harden get_lock_owner_info() a bit" and
"rbd: retrieve and check lock owner twice before blocklisting".

Please drop it.

Thanks,

                Ilya
