Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D7771EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjHGKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjHGKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:49:16 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1519AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:48:55 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bb75afeee3so3188301fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691405334; x=1692010134;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOqvjYpL8TOY1VQyCJX/k1Wl0dCAzqBeX1FG+QU3ZR4=;
        b=gzo6NysgKKweswL7UjeFF09Y9Ji9Z/Uf35i4LQFrP2/dcJDHC3DI4879BexeA91mcm
         z57MKJY/ByZcaAqP+krUXrut6lJ64eQqk0AA3hgN1xtyRpnbXOM6Ln+Zb96JjxqS82pB
         fJUSk81uyUh5w8E+a0TWGnYrObQqTwoE5qbBSC0u2Lc8xRhqK/qh4WHRgzhDCCuCFBcY
         lgpKrODnkD6Qud5xAGpvV6011VAjCDlP1uWz1egqTmfmGSJ/OdeyJ3MLwv/jY5R7qrKL
         G782BxQ/6StluxlFjNdYHp+3k1l5bOaBIirjO4NHAsLhFG7yxjnxIGmleMJbf8zUHT/c
         6aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691405334; x=1692010134;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOqvjYpL8TOY1VQyCJX/k1Wl0dCAzqBeX1FG+QU3ZR4=;
        b=XNNj5IgWVbTCyd0+XdhpS7cKkYWTNS0KNIsZwEQa2DzJWwxUV8BLTt2P04tnjSwVqm
         AgTcjGzMa9x/2Wn4nMbq63G3W/5kSSiZ7hb2lvqprMToxoHG8NbPtGz/TIGUko3JDfwL
         W/hyo1KpFFUWCn5mevDJ58j+vY0ZsD0kSBmVPVnGcD9YaUFoSMciwX9DWQlHX5qOIFqG
         XybgAGHc2csKPDpxCAln/Dpkk4PgPFYdZEhCI5AeFBeB4a6uY79cTwlaKUiSSNUatTHo
         MAnisDIXq1GMOXgrD6ONXK0d2xwy6xUCu3m3ZXO3zGsR+XwrvguTahiFFcLrZKZ8N4ZI
         ay8A==
X-Gm-Message-State: AOJu0YxcNt06haMw137Tya6S8wK+s9SB9ydLxQ5vVbBjSeuXpUp7/Pvc
        +OIwhIucqEG6+zjDbklrFu+XpyM4rlSTu59emWDxArK/
X-Google-Smtp-Source: AGHT+IE+8t6WZmXSA2gENA1tNwHAJ+VRkzEbu+o+tPqzLzZjNhYYW9QWCVRwSEdItXD2Ro0U1Y9LHJOpP+xowR4bSgc=
X-Received: by 2002:a05:6870:d0c4:b0:1b8:5d9e:638b with SMTP id
 k4-20020a056870d0c400b001b85d9e638bmr10052976oaa.43.1691405333876; Mon, 07
 Aug 2023 03:48:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b87:0:b0:4f0:1250:dd51 with HTTP; Mon, 7 Aug 2023
 03:48:53 -0700 (PDT)
In-Reply-To: <ZNBfEjZRWnPrCIGu@casper.infradead.org>
References: <20230806231611.1395735-1-mjguzik@gmail.com> <ZNBfEjZRWnPrCIGu@casper.infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 7 Aug 2023 12:48:53 +0200
Message-ID: <CAGudoHHXa47bGqBh5QELBmpT1zS2znjT9U52Tb+bp=g3zq5Cww@mail.gmail.com>
Subject: Re: [PATCH] mm: move dummy_vm_ops out of a header
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Aug 07, 2023 at 01:16:11AM +0200, Mateusz Guzik wrote:
>> Otherwise the kernel ends up with multiple copies:
>> $ nm vmlinux | grep dummy_vm_ops
>> ffffffff81e4ea00 d dummy_vm_ops.2
>> ffffffff81e11760 d dummy_vm_ops.254
>> ffffffff81e406e0 d dummy_vm_ops.4
>> ffffffff81e3c780 d dummy_vm_ops.7
>>
>> While here prefix it with vma_.
>
> It really shouldn't be prefixed with vma.  Other than that, I love this
> patch.
>

I think an unprefixed global is iffy, but I'm not going to insist on
semi-cosmetics.

The one thing I expected people to complain about is the location of
the struct. The mm_init.c file was the least bad choice I found, but
maybe something else is preferred?
I'm just trying to avoid sending V3 for this patch after someone
claims dummy ops should land elsewhere. ;)

-- 
Mateusz Guzik <mjguzik gmail.com>
