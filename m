Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094477587F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGRWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjGRWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADB19B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7679ea01e16so565241085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717678; x=1692309678;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhqKt40L8OqcLw8LjCrBqzYCuugFm8zkJphxDeUn8N4=;
        b=A74w8Ia/08u2KKgpEdKm/cB4wUc5lgnl5inl+w0GbhySy3LhwF2EATnxn98ZomdjxB
         y2yNP67zyDrxPfJbQCYtTp+36LSm2pvCZrTjyV/wY+z4hWumu/Ezy1AjpKk10cz/hwnr
         GHgTCEgzCf4NtjeHWFtoDhLM27ptVAWfvQa58bBTZcdkBIQcxd0YQBFkV60ya6fZ8mda
         nFGWuKE+lG2hRQ+WXuL9liQI34NpzlIvMLpiHcZ4PMf00y5DG66d8cYdFuI+srohbxyv
         VxAFONU2x71W3v1dlIaQMQNyffv9x2+nScWklSjvaMbw4RbOfMjoAE+Bs95dgyFmsgmw
         LqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717678; x=1692309678;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhqKt40L8OqcLw8LjCrBqzYCuugFm8zkJphxDeUn8N4=;
        b=ZbKrRTjqKTJ3f7WoHcHiP5pYvndKkn4V0pGesXauru5lqLbBk7a22lqXBnuKLdX7up
         T7/hEHOELGFGVwM3WCYhxoKurZf1vBeDnJYoCN8AHavVPjBFgTBkGX9qn2xRfDT7wPzl
         GnMYj57zRoFkYCRwBrPmWpjMWH0qtTu+djT8T64o1wdiGDchF6vTRBkdWQcAoOgCTO8+
         FyZq0+uqV6mmBYa7fVjWbR39cTReg9Wu1fmnsyzAxK2Cf1cKBdnYIe5hdf85nmRqABSZ
         6p7oGKcwDqq57NK9G2c1wDbHq2lGcldIofZ1nUEwRY5GUWAY1VftkBym++Ct3K3B79jF
         Sb4g==
X-Gm-Message-State: ABy/qLYu5TM7eFBNSyuTX6yr479l6Tywp20/O0SdZ+ZBw2v9HBIx7bTk
        cfEBur/7MXRYskI/U0E1TMGX
X-Google-Smtp-Source: APBJJlFM2D/vWvk/N3b7jmz6SpkkmDM8jnnTUOWslc/8qaPiP91FO1WU3tPpR8EmnPZ02vnOKZTaAg==
X-Received: by 2002:a0c:be8b:0:b0:636:a9a3:9035 with SMTP id n11-20020a0cbe8b000000b00636a9a39035mr12896162qvi.42.1689717677899;
        Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l18-20020a0c9792000000b006379c3f7895sm1036919qvd.52.2023.07.18.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:16 -0400
Message-ID: <aedacdf95535c7147e6add61419c2cab.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/20] selinux: mls: avoid implicit conversions
References: <20230706132337.15924-6-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-6-cgzones@googlemail.com>
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
> Use u32 for ebitmap bits.
> 
> Use char for the default range of a class.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/mls.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Two words: "loop iterators"

--
paul-moore.com
