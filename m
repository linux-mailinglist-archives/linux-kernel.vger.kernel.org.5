Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB276F7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjHDCUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjHDCUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:22 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BD449D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-768054797f7so132352585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115620; x=1691720420;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LNKOwxHOWE7F5nlJr77NyuO/IQs7geHTBuf/n+r57NU=;
        b=O5r7Ja0UXIglCSK253x/L4+KBTQ6RjCR/Idfm6Lbd5MhCNdjDz4TxzN2ECQ8nA62xG
         vdT0J91bUbaf967iC5zuzvcsUAJT9CqK7fRWhe/CtRVWgrYWvPP0lYjuddDa2Axtlxs0
         /gRStbuknqnrB08xejghT5pSlTtvuEw7Uf1jL0zobKE3mFPtlD9UV49Beq7VzTb23JTh
         MhaWKX918uE8BMoOpP9/jpz/VtTMweKjmqUJIfd9ZIKOTPRR7uhwaPpG9cRYiFlS2mHb
         inhyIZrJio4MHW2PS87qLucEQP3LRx562/3vLY4loOCY/pRg1owY5lxtRZUBnVg1L0/W
         kOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115620; x=1691720420;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNKOwxHOWE7F5nlJr77NyuO/IQs7geHTBuf/n+r57NU=;
        b=lyXh+3ak+f6vGdZoQceb2ekazEfWZ1wiQf1TemfX2c2kDIrf71ISYowxSyDEKVJFSN
         p591Dj2tlnqHcp3BXyH3nnnTrGJKWY2YdTrXwMR4A6zMoqY9OwLtYSt4dRsXGQSC1y+l
         mH5UbrXl186z6NVqcgYJJTFmRZUifGCQcObyvHLcz4FbX8mOAWKfspcfZeRBrZSATIO+
         Q3lTZfsbOZ+r3CaRBBS33M9mEst0Xx6TnnST9yDRwjfmNnaw5QKWk28h2LBTT30FJJ2s
         op4rv3cV+7qEWeHr5rH1Z/0t3HfXhjin9cPibYCVwGancOHryNPafX+5non81unbNLsy
         a7hw==
X-Gm-Message-State: AOJu0YwNuOdXra+iXG9zTePk1PfJ9n3RIt3Wc+cuvfT6QttYcrDB5aAW
        rSWhzmUlNxaSl9tkr9eTnhEr
X-Google-Smtp-Source: AGHT+IFVkjumHTvwJDTFPEiji4el72MdE25hpNy/Vg94yts8Q9m/rrET88tTdhk2YiDBTVBYbDNXCQ==
X-Received: by 2002:a05:620a:1711:b0:765:d53e:3352 with SMTP id az17-20020a05620a171100b00765d53e3352mr693534qkb.30.1691115620163;
        Thu, 03 Aug 2023 19:20:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a10b000b00767da9b6ae9sm340279qkk.11.2023.08.03.19.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:19 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:19 -0400
Message-ID: <05f7a2e580dc616b292c848e75f8a03d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selinux: avoid implicit conversions in mls code
References: <20230728155501.39632-3-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-3-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 for ebitmap bits.
> 
> Use char for the default range of a class.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/mls.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
