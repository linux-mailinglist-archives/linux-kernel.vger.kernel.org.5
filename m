Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14E7DDCD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjKAGpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjKAGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:44:59 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDD119
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:44:53 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5af5b532d8fso60171067b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1698821093; x=1699425893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lniAoX+cOYo/zOXbRAfWyrdbW6/g25qDgJ3kFODDZfU=;
        b=lvfmM4pyF/UG+xTu5Tn04uq0cHgH+Bh5vwiS1cxL5AtH1YerEIIOoLvQTQeU5HdGbv
         zo+z0hzhVkekY5GPN5OExUZ1QRByLZE1rQj/WGyio+ap8jz0Wqj79WxTzIXKjqb0A02E
         S4s/nPbh0/d7YNt0+oPWIfYeCBFEhmbtVLGtRSbabCPygA/kApMByWgBBSMQLnRMBLVC
         mMinfczPxAy4A8nil5Q3inq2ifyiCEGmWUBSkTk1JKWbx6/A1I1CJYHtgOXIJ8TOsPr+
         3IIP30iY3AbZySzHXH6A1mCksSZfiCd3Dfut9WwbUFCZzU8t2B6Wp9/r8ItDfprM1oP0
         DdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698821093; x=1699425893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lniAoX+cOYo/zOXbRAfWyrdbW6/g25qDgJ3kFODDZfU=;
        b=jmzUQ69j5Ud36p4NCW1L7ZinNdxmoWmUxUB6Hu5gH3sXtYPy5TtlhOtpaAx55iwYC/
         I3yEK4DjDaw3Jj8+vmb0elWbQV8pY1bADQoxpuqt+3aSrHlNcfR+fgsD5ISyqIPcM15a
         tyqWdIRhPH3pSmqVXDT7EuiGWTHgQHUOlLKzX5L9g5QUQXkpMukZsLBUBoDB5qRVpKOg
         cCqKAXuXapHX3iXjDXP2UNkCUZmeeZk0rsWS0XQ0oaHj+UXv7IixahRXLpbAi6PbSGrN
         b5pOG12+1qfG8+7LKfQ2fwgDE2ZvmeDjPtbtmgZokzAkJoqZjFgoYIU3gu0tmVSEuLki
         tuPA==
X-Gm-Message-State: AOJu0YzILBGszQo9fwW6kWveLEhhWHZhi2JfD56ecO2caM6Sinhrrslr
        flCtUT6D/4CsgBU/L2xOEJj2F1wMW9xKq1n88O5elg==
X-Google-Smtp-Source: AGHT+IGvZFErZZzdg+Ec3VicmUnJ2FC+EaS9pZvC7b+Mg+mG0u+QuH07GrTtuvLVhwuDRFsLaudNDw==
X-Received: by 2002:a81:bc4c:0:b0:5af:a73f:53d3 with SMTP id b12-20020a81bc4c000000b005afa73f53d3mr13585700ywl.13.1698821093007;
        Tue, 31 Oct 2023 23:44:53 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05690c314a00b005b34d8b33ffsm1602410ywb.119.2023.10.31.23.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 23:44:50 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5af5b532d8fso60170827b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:44:50 -0700 (PDT)
X-Received: by 2002:a81:e50c:0:b0:5ad:a3f9:1b10 with SMTP id
 s12-20020a81e50c000000b005ada3f91b10mr12841619ywl.10.1698821090148; Tue, 31
 Oct 2023 23:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231031014009.22765-2-bagasdotme@gmail.com>
In-Reply-To: <20231031014009.22765-2-bagasdotme@gmail.com>
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date:   Wed, 1 Nov 2023 07:44:39 +0100
X-Gmail-Original-Message-ID: <CAAObsKDTdYM4PqLNgsE_UAG8yQW0wQ0tg_6eJp2vGoeTwDx=mg@mail.gmail.com>
Message-ID: <CAAObsKDTdYM4PqLNgsE_UAG8yQW0wQ0tg_6eJp2vGoeTwDx=mg@mail.gmail.com>
Subject: Re: [PATCH] .mailmap: Add address mapping for Tomeu Vizoso
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dorine Tipo <dorine.a.tipo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 2:40=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> He's no longer working in Collabora (and his email address there
> bounces). Map it to his personal address.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  I was triggered to do this mapping after I review Dorine's (checkpatch?)
>  patch against DRM subsystem's CI [1]. I Cc'ed Tomeu (using Collabora
>  address, as the file author) and relevant maintainers list from
>  get_maintainer.pl. My review to him bounced (address not found).
>
>  Tomeu, would you like to give an ACK?

Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Thanks!

Tomeu

>  [1]: https://lore.kernel.org/outreachy/ZT5n-5hSfD0MqsnT@debian.me/
>
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index b325732e31eb9f..27beb64673b8d2 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -567,6 +567,7 @@ Takashi YOSHII <takashi.yoshii.zj@renesas.com>
>  Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
>  Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
>  Tejun Heo <htejun@gmail.com>
> +Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
>  Thomas Graf <tgraf@suug.ch>
>  Thomas K=C3=B6rper <socketcan@esd.eu> <thomas.koerper@esd.eu>
>  Thomas Pedersen <twp@codeaurora.org>
>
> base-commit: 407744af8384dc12b5813d8946855dc4789d78a3
> --
> An old man doll... just what I always wanted! - Clara
>
