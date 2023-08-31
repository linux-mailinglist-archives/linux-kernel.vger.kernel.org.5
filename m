Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55578E75C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbjHaHs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjHaHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:48:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB63CEB;
        Thu, 31 Aug 2023 00:48:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso53444066b.0;
        Thu, 31 Aug 2023 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693468101; x=1694072901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/h0H2YPVBqYjaGBwW4IhOCDM0z5E5pLi9XA+OkpL5s=;
        b=DaF2UgeMyBj+hpEjz4+GqrVVDSUZi6MLT3gAffv+0Hbvs8P0Nd9evCrAVXidaLcxdL
         8+vt3QcvEShRWY81nqhsIxHR1SbwaxEEQ6oFUz+G60VCVC5Eu0PmezH/ApEFTzoNMnyr
         7x/ojQjd5xsdjv01mfHRZL5TtGtj3+VhbvazRp7H2+iAOQPALQAl3u7V/bjd3BMjUV6b
         ksXm4mPB+w8nIPz0HQfgzeJPgSmZ3D8LzCDeoy3o7ihkBCvmorFyBRpvh6xsfFMnURf/
         Nvzh4kn4wyTScGEmUIsaolXDPPtZfEmV1gfNFMiogup798q5q6h1mFqE2HgUqDfhR0s6
         fnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468101; x=1694072901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/h0H2YPVBqYjaGBwW4IhOCDM0z5E5pLi9XA+OkpL5s=;
        b=BmdJosiOAOPma5pzfidw3Mm0aMhlNq6dqXw25kjRX9/mZtOvpk8KChkVrGC9wb+yG4
         pmOwgET2UaWFSPt3PCRbPMrR+B8DuANkHVz8Eq42gBWS/xTsCZUB/hybG16Z3edR3R3M
         3mgXaj+1LVDLfH+qTUDuCECpBM313Dz8ji1jUaSVAKDmROAhE6u9uyBBu10iUPqeVdpc
         nhc1aLkTjUq9Z7UTjNhWmcIsd5BoM+Neysbt2LsSmSgTYniHce7ESImrxP17zCpiCN2M
         YJM0Z9fPCB1IDPknn27Zl4UoHDGED3KkSVZQVhMydA920rrsvRaqF9zUrfBJO24x77mz
         lCwg==
X-Gm-Message-State: AOJu0YzdMuwnD1T53B8VJz8N/Qlj4s9Q37lB47C8h3V+9Lxfg1qvPgty
        NtMI8IggL4PXoNWpO2wREVg=
X-Google-Smtp-Source: AGHT+IFfYkO2CAmJrVcq+fgCI0FkUGLFzUGOMlvN9bEPnvcgaCvoohYnbwFfAsyv9bczO3YMQk6/PA==
X-Received: by 2002:a17:906:5397:b0:9a1:e941:6f48 with SMTP id g23-20020a170906539700b009a1e9416f48mr3543360ejo.13.1693468100420;
        Thu, 31 Aug 2023 00:48:20 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906495600b0098e2eaec395sm450311ejt.130.2023.08.31.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:48:19 -0700 (PDT)
Message-ID: <0527327b556aac4ce9b7e4db85aa831ca439e600.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74413r: fix function prefix typo
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Aug 2023 09:48:19 +0200
In-Reply-To: <20230830094314.26353-1-antoniu.miclaus@analog.com>
References: <20230830094314.26353-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 12:43 +0300, Antoniu Miclaus wrote:
> Use complete device name prefix in the input current offset getter
> function.
>=20
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

This a typo fix. So, I'm not so sure if a Fixes tag, backporting is really =
needed...
Anyways,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
