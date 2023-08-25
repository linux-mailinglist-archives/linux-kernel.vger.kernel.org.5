Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A7789278
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHYXj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHYXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:39:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668E2726
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so178740666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=QVGmFqsF4/K5NVoJoJF+dUyFvy7vxGVJw/2VXZ+2uZidyZ4CawnajEyf4nSeJ43ACl
         zsm3vqdDdSaMDQDB8amtxmHw3u+uXWhKayeIGMmRXZoMlA7C18saeGyS87eVkzoPloL3
         R7KuHQ7vtbPQRhiN+GormH5u385wcE4qcpoNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=jn1xMUnGvRWG+uSFbZuRCtR/CiQJ+cag/ME+MQ6xlwM0dba17t6yXz74992tOdxnqY
         hgF3992ej7QD534WL3brTt7dD/QUc6GmSl0O0g0uB4jIjPo8mfcJQgNIUTSZgpbOZRpX
         vjRl2Vhshy0TVOOkQ74PKRw1bpeZ6hRHqjRx5nEFElqotsdBtCmKSeZDGyzYt9BGxVan
         rFvtuZc0zMMG9GgtcFr1e/LsXn9Zlq+6iHIW0zp6SWs34FhuDLuKr3ODSukjbF44gRhG
         +DoINGF7+MtsYxrWFp9HouvBD2UtqHOY8NGGp4BTRlqQ8y8YKKGhIB8nuSBKSZJqsA11
         MSSQ==
X-Gm-Message-State: AOJu0YwOPvCHuVW0vNGsPH6vmSUpvH82EDUn600PWCjFZDbUuaf9dKIC
        GVQOCK8kID0VhBZ89fik58DTGCSjQFdhPZNORuA=
X-Google-Smtp-Source: AGHT+IFU9fJC0WTcnsAJ7ynokUF+/fBEkOQErgXKMCdhlxgzqeZa+e4mY72gkboJJunf/IIbyiNZmg==
X-Received: by 2002:a17:906:1dd:b0:9a1:b967:aca9 with SMTP id 29-20020a17090601dd00b009a1b967aca9mr8799524ejj.63.1693006749498;
        Fri, 25 Aug 2023 16:39:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906590b00b00992e14af9b9sm1444798ejq.134.2023.08.25.16.39.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so1995488a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
X-Received: by 2002:a17:906:59:b0:9a4:88af:b82 with SMTP id
 25-20020a170906005900b009a488af0b82mr2214834ejg.77.1693006747785; Fri, 25 Aug
 2023 16:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692931954.git.gustavoars@kernel.org> <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
 <202308251410.8DAA6AC5E@keescook>
In-Reply-To: <202308251410.8DAA6AC5E@keescook>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 25 Aug 2023 16:38:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 2:10=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> > +                     mwifiex_dbg(priv->adapter, WARN,
> > +                                 "TLV size (%zu) overflows event_buf b=
uf_left=3D%d\n",
> > +                                 size_add(sizeof(tlv_rxba->header), tl=
v_len),
> > +                                 tlv_buf_left);
>
> With the suggested change to make this a warning and not dbg:

mwifiex_dbg(..., WARN, ...) *is* a warning, not a debug message. Or at
least, that's how it's used throughout this driver, even though it
actually yields a dev_info()-level message, regardless of the 'mask'
arg:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/wireless/marvell/mwifiex/main.c?id=3Dv6.4#n1811
