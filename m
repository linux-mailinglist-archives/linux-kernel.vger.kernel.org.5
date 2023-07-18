Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E392975880A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGRWCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGRWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:43 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC71FC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765ae938b1bso567673785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717685; x=1692309685;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0u9TRtvPN85YoE0zcDntr23xKKV4yPsatOmaM1fBF0=;
        b=FIrh1bs/b0Emc5CZM+IsjnREXK3Fg70nVv2Gh4m+pBbzqd/jijcHCBWPyyQXaErtnt
         H4F8Vnkhslu1VLVGnCLumMKVqh4oqyW/hqhgwDYZl4I/BShREi7CQyE7CSKSmt5xOpep
         wqY2kfYFFqh5PdyxhvmyOu5t27rEU83CZk68CIhttiwVpTpjivkZzmskfCyKPm/UHd6+
         iEgdL22uRhjm61H3dP7Sts9WzoP4sdeyBtMbX7qKim+gIXTr8oHk2emmqv4GnmW3kfQb
         k5vBiI83+8Kc7D5rFd/1yEbJmB61nOkslaC9yNp2nVwfzRMRBUVaOVI3wtJSu2Ysqq1j
         nKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717685; x=1692309685;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0u9TRtvPN85YoE0zcDntr23xKKV4yPsatOmaM1fBF0=;
        b=GWnfmAublm/N9aRGHRgx0LBqiY8wyw7kwLJW6oErrK59B26fBEn3oBtaMwVuYMy+5A
         ZvT4CP3gPrAcdDbg6EWWEgPg02iaeCm40MpBQQTDYZu/28lrYocb7/VtlY8zsOESGvE4
         UDqKLJvxvnC7/7m1Cz/5wuGD7Nlo3OFJLk/m2dj2dhslqQPAh9J3/oeRgkUEiMFRLXu6
         Nbu3ZH6/cMPf5WTiGtvA5pIlHb44LFUOba9Xqoy9iCvAOiexzMzfpu3HHc+tQu9y+OkZ
         i3IeuBm2rcKpawUEtNtF/wYlMfwbbbdyBJ5blxSDJ9NEAnj5P/MtHOL9WS9RiT/UmMgD
         Ev2A==
X-Gm-Message-State: ABy/qLaQNExiP/hmfXsarZ6dEcdnTPrdOiW0U8/mQ9YWSeKhxPVCTfAo
        KmtP0IIyi0tbgcesuY/4p5O4
X-Google-Smtp-Source: APBJJlHWFmyXEDcJCVd1mNcgtzgar96TyAApokpQEb7PfORZM66oLsMoq5KVIU4/HiWcN2rAybhZQQ==
X-Received: by 2002:ac8:5814:0:b0:401:dfb5:9056 with SMTP id g20-20020ac85814000000b00401dfb59056mr20136563qtg.0.1689717685267;
        Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b004033c3948f9sm925394qtp.42.2023.07.18.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:24 -0400
Message-ID: <d3ca51aa2e03213b075ae00f9e5ca65b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 14/20] selinux: use consistent type for AV rule  specifier
References: <20230706132337.15924-14-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-14-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The specifier for avtab keys is always supplied with a type of u16,
> either as a macro to security_compute_sid() or the member specified of
> the struct avtab_key.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c    | 2 +-
>  security/selinux/ss/avtab.h    | 2 +-
>  security/selinux/ss/services.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
