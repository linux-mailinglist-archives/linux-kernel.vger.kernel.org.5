Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3475880D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGRWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGRWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9741FE1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403a0d7afafso33178351cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717687; x=1692309687;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zatc7oqvLk5obRhVfXqqPnIpkVhIdJiNW+25Wuf33w=;
        b=E6dTjBs/NNUMFYeff9FDj653zrrm7BuKv8mwVAK1i+jHmRQH3dmNaOfep5OisY+mIE
         43FdAvt2CYKFHdOhnxbl+8B+hO70u/DcQoprw+GkZJxJGJefOk/dHthXwuxh83y259BR
         XtngKQQ3NNSzfLn3oRSOOUr+s/ulxHqSWRcH3pdD8Yo9c3XMwBWyQ7STCO6o+kJDs4SL
         vFCDOxLowTVbmXixt/cFpwLDKfYqO5xwopPXM8QEh0xEQUge82nAlQbzEG8J5eucrn3K
         ZDbtww8HkyBBk/4ee3utMroEBJXa2ly5lVbPlwFgVwJWvC3kXDX9JXz5lY+hXak+MEhq
         mpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717687; x=1692309687;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zatc7oqvLk5obRhVfXqqPnIpkVhIdJiNW+25Wuf33w=;
        b=AVuk5iMAcPOd2dw2ShaG4z7X1bDSJcDh5E/uIFbFeofA5dShdKG+RwxEJHh4QBJ8/6
         NX+Buuoi9umA5j3UT2UfDA7xylLYx4iWqbnOcaZubFJ2+nlm+s/KaPyIgO1kbmwOpsrI
         17OQpO5f/1Y8hfBjdSxlHmi/q62mn0NTIfQtaw/Ro3VjeQgCs5tLDwr2z2U2r1UnIKkl
         3yUy2afFMPY6enG/zjLoKv8t06fqPJ/XNcEKz6qTRzq//sFubRmuA15/o1XI6qg5f1CO
         kcUji8ssY0c30KKNrJuxIkC/u5Z492q6yXBMG+zg8FsWcUyBAj1GBxG6ipAwTRJyX7U6
         ctsQ==
X-Gm-Message-State: ABy/qLYK1X7NG59nlO3T/IjIzzR+c2r4TWx5sxjsfhO58iOilstKHTc3
        ukvAgvDGueN9rvRaZb5jA5od
X-Google-Smtp-Source: APBJJlGARi+hdc8R26OMEnPJuHGzshKNJHvcEG2B6RuRDbL7kksjNzSJ3TXN/aDv8WVnLmtSjHALdg==
X-Received: by 2002:a05:622a:115:b0:403:e8df:2381 with SMTP id u21-20020a05622a011500b00403e8df2381mr1070440qtw.23.1689717687410;
        Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84d59000000b004036bcfb1b5sm908632qtv.65.2023.07.18.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:26 -0400
Message-ID: <16efe82100e3de75391ebdd3b0ad59ca.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 16/20] selinux: symtab: implicit conversion
References: <20230706132337.15924-16-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-16-cgzones@googlemail.com>
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
> hashtab_init() takes an u32 as size parameter type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/symtab.c | 2 +-
>  security/selinux/ss/symtab.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
