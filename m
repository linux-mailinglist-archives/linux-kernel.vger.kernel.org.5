Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC46776CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHIXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjHIXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A21E72
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63d0d38ff97so1598786d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622464; x=1692227264;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y2G1FEoODyuW8LZInJy/D8VWDoauS6KvhR2/aXXIASQ=;
        b=KRPD+tFlvIJIh/SfRJKPke3EkchYdx+kQLzWrBM9QT66JJaT98ADso2nUAtEt5l66S
         0PNcIMOhG+IgIuwi3bfr8OhPs3EAsox0ta5oBVOcFilb3ixjhgOF2OmgNDCzarRtnLQ+
         uro+J9gSpZpPrIWH2WdQKtoROsrHlH1t4yoPO3GfmgULgIkxYrnp/BatI61z6+dUPXAq
         R0kSNer1X52WabWq11ban6NnDgW+rXhCR0UkbjSejNBAtXR9JaKYhFlbWN/ylBdOpM0+
         IuU0UGnv6VGJVvOujPK/3Dcphk4lFKyUsOoVG/bIURMrZtHLJM4b75RCbnEQXgtohf4n
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622464; x=1692227264;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2G1FEoODyuW8LZInJy/D8VWDoauS6KvhR2/aXXIASQ=;
        b=TAxeFv+LWHfyzRiFm2aBbSZZCy793wYJzp+p5tLqxeQShghItW/uAULfDGFd/edExV
         bVTMWbIWkwFjYb5kmpDs5eYxmCMSRBRDaUXeA4AECLLHqOGheXGHQB6zAlfeMChYBS2T
         AsB5cOuDs9Y1kXTJhzznEJ/v5tIqKzCu4QTX3qpQPaosIXq2Y1daMB9i1Z77QMQ6fcH3
         7N11rJC93X0TDwzdfPQtxYMewGcsAf6hk9tQ/4DXW8qVZLemEh+06az+tmFKt1VpxSSa
         jIGgCxjpcpYQGWm9JheNN2InOfdii6AaOQnp13h5XCloIjAe8ubdtq0iNfWq8KUlSiCY
         YFJA==
X-Gm-Message-State: AOJu0YzPCkKqxImMC4Eoitzhf68x5C8kDoC8y4cLL+kJ/FvEw0RjxuFh
        QpAggbxlcWkuusYxt3WrKdRx
X-Google-Smtp-Source: AGHT+IFSpMTflGFdiT1OvIdpQy/aE8TDHCxXjYsislp4DlCUAwm6eQUiY+WC8I+4nMwtsnGw/cIXLg==
X-Received: by 2002:a05:6214:1304:b0:63d:580:9c68 with SMTP id pn4-20020a056214130400b0063d05809c68mr414507qvb.32.1691622464288;
        Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g17-20020a0caad1000000b006166d870243sm26517qvb.43.2023.08.09.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:43 -0400
Message-ID: <3531a5295c973c359344ee36c2daaad7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] selinux: make left shifts well defined
References: <20230807171143.208481-3-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-3-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The loops upper bound represent the number of permissions used (for the
> current class or in general).  The limit for this is 32, thus we might
> left shift of one less, 31.  Shifting a base of 1 results in undefined
> behavior; use (u32)1 as base.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3: split from parent commit and apply cast to correct shift operand
> ---
>  security/selinux/ss/services.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
