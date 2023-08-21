Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71867782EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjHUQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjHUQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:50:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14294116
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so475056466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636630; x=1693241430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PagTLK6xqDPvO4gTtJwCGV2PiYmZKmMJsJXCmnUX+pk=;
        b=lsFKqcQDZSptRnM9i2aDXX7M5L92wgcxL41ZOhJjHGB54gW8POkvalwEg6ul44sNDF
         zwPBKP4K/evRvQyfWS5Mrdw94+1meXrl7VsJnWWwSNniKlx07wQHGEFzym/+V+xo/tX8
         JxQjzWZLoFY1Rw4xnBqZcI5KVd2kjHPNqeuRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636630; x=1693241430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PagTLK6xqDPvO4gTtJwCGV2PiYmZKmMJsJXCmnUX+pk=;
        b=KN3vyHF4pXbwYPFT0BBKKvw6okvm4HbYT/xyqYqbI1IEjepxQZRbot399JaFEa4WcX
         aawbqQl28G2oUp2AmwihxBANKyUTeIFxB0iwmMpkKIkj9WGYi8wI5hNrSpvj03yVd92N
         oWapBLQLPjWr4+iENgC/eoPlRZiYK8NMpKNXwE2IAqKJpyIHS7lYaOxUAlcPALJASAzB
         1K8a3eCiWP+Rc0fbJxQRrMlsx/uL/LlHa00A/rFG8vHX2M5cLDUmNGK1F9lJwCk7nQN5
         eIIk9IRa2xa3mLfvsb/2YH3dMxOiCyIebwLo5OEw+zq9Hcb60PJ1PtjOHtDYxTh/ft6T
         G1dw==
X-Gm-Message-State: AOJu0Yxas0/84q6Vq1nFiWK25Q9IsTSxcXxeSfhaA59DN8ka5htjn6Bn
        9dQ/1705oKzvUSfiFG9yjDGat5bf+DUYcoT2tmS9sbSk
X-Google-Smtp-Source: AGHT+IGyEQeKu5BdiHqdCUpg0xJrk+Rwz0y7hBxhLFlaBILEBX1KkHyN9UyGyDR+VUAyYr26JILVrw==
X-Received: by 2002:a17:906:3d22:b0:9a1:6bc1:b540 with SMTP id l2-20020a1709063d2200b009a16bc1b540mr5035908ejf.26.1692636630139;
        Mon, 21 Aug 2023 09:50:30 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id jp19-20020a170906f75300b0099cd1c0cb21sm6752011ejb.129.2023.08.21.09.50.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:50:28 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fee2ba9d09so1215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1c90:b0:3fe:e9ea:9653 with SMTP id
 k16-20020a05600c1c9000b003fee9ea9653mr1983wms.4.1692636627577; Mon, 21 Aug
 2023 09:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <89a905854995cf662a122792d8d0c781e39ea7da.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <89a905854995cf662a122792d8d0c781e39ea7da.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:50:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu1GqYHAU99ZkQvYtupireTgtjwUGMXPOCivG-m+xVoA@mail.gmail.com>
Message-ID: <CAD=FV=Vu1GqYHAU99ZkQvYtupireTgtjwUGMXPOCivG-m+xVoA@mail.gmail.com>
Subject: Re: [PATCH 2/6] regulator: core: skip nesting lock for -EDEADLK
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> When ww_mutex_lock() returns -EDEADLK the nesting mutex-protected
> section becomes a no-op. Return early and avoid the extra lock.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
