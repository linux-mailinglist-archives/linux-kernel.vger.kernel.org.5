Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18338810C63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjLMI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:26:24 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9591
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:26:30 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9fdbcec6eso3240487a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702455990; x=1703060790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE/wsQc0NvMrBcD3wye0l3DSrzAEfoQPWgdUdXeJ29U=;
        b=ktBc2sce9zbDV03ymdmV2PGRfL7naDqxpxR5RCfhnMSrmn8ukQE6SYxFpBHvcBnK16
         a4SpyShlXtw77CEhj8DvnrQzsXUihcTfSSPA5cDr1B3IIVYHPqge+rMi0hPRJMb0lkVT
         Mi7laVvaOYBUt8RqIenc5++y51EN1V1ibwGaiIF5rHHTTn0645I0M5zrhVePHPS1mGK8
         b75fkuVx+efeVFIDKhCJhSO3EbbwxW+f5RdS+jr0v5fi2yAQRCi3tlQmLYABQIFMBlkZ
         xsJAFC6n5X/4pthKvGGv/Ms3+jfB5DN/fcXu9wqbFn4YbKpLEr5EEy70wM3jqoJ5rC1v
         nrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455990; x=1703060790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE/wsQc0NvMrBcD3wye0l3DSrzAEfoQPWgdUdXeJ29U=;
        b=xSue3Zd9NPZ+TE5dLVwXMEu/82ckRcnY4rrrlRPObumCKBKjUuKrLvwBPbzCwZLEt2
         nrHdiMnjs0Z2VRKhty1UzKi72468UbG54LkFBYEPi3H6mu2RdK/T+hIfL2UIjQqR6JtD
         1Cu8j7GvUi3qf28Zj4ffIrPOGQCsLZnABa4Pzh+v9exbbdH5UEgKovnCemV87UwFhj3Z
         RT90i85jJaJ5+mXiweWICU9s/RdYNrn486cmQB7g0Kk0Qc2+zoZFmX2NhcJtGSEHlDF/
         2RnM/ftUZo/fD/qgDRE6MhPYv8s57Ayshl7Jz185gYG6xTMeD9PdQtY9rzygy4USa6nx
         5v5g==
X-Gm-Message-State: AOJu0YyidzP1+c5wTqVgAJhCT/4dumLcjlS/E0eKqepkwo3/vYHs6o59
        ElF5UX/ERWlAcscXzTh+AyoQf3RHgDznVCkYH9vDdQ==
X-Google-Smtp-Source: AGHT+IFZWoXjUhtr1OciLgqlVu9KIOuINiG7MqFVLwWer25dN3z7ejaxCgjlpkpB7Qpe3+bRFA5cZ1WCgINPpc/nTeY=
X-Received: by 2002:a05:6808:2f15:b0:3b9:f684:f4ea with SMTP id
 gu21-20020a0568082f1500b003b9f684f4eamr9169286oib.106.1702455989885; Wed, 13
 Dec 2023 00:26:29 -0800 (PST)
MIME-Version: 1.0
References: <202312121120348064534@zte.com.cn>
In-Reply-To: <202312121120348064534@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Dec 2023 09:26:19 +0100
Message-ID: <CACRpkdap4LUbMcKv_zi=25A-SZf0DJhXiyR1zn0PfuR+b=3NfA@mail.gmail.com>
Subject: Re: [PATCH linux-next] ARM/dma-mapping: replace kzalloc() and
 vzalloc() with kvzalloc()
To:     yang.guang5@zte.com.cn
Cc:     linux@armlinux.org.uk, jiang.xuexin@zte.com.cn,
        chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
        rmk+kernel@armlinux.org.uk, willy@infradead.org, rppt@kernel.org,
        jroedel@suse.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 4:20=E2=80=AFAM <yang.guang5@zte.com.cn> wrote:

> From: Yang Guang <yang.guang5@zte.com.cn>
> using kvzalloc() simplifies the code by avoiding the
> use of different memory allocation functions for different
> situations, making the code more uniform and readable.
>
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this patch into Russell's patch tracker.

Yours,
Linus Walleij
