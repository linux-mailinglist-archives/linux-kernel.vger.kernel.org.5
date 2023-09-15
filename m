Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29F57A267E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjIOSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjIOSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:45:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22FE199
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:44:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf1935f6c2so18213225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694803482; x=1695408282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=UcohAoQAIsWWDIgI7BS4TdftP8BkbFCWvYnlnqDpaUUXHCH9eMK8yVInnUisQPL/nW
         A7oQQCsvjwu+RLSIEUvthKcMWY8iucOrVF5JVTBqvllmUOvFSIvU9CIqvhLQylqUJaqx
         Yp9nPC5lhePXZuKibzmoFKXut+dIY8LbYzvMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803482; x=1695408282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=Pj/z2abv4tOc5TJv8yg9pR5xAJ0EC3IT4Vd9o05GaIQhvn03e1xpZEOhb72xkXrobl
         RRfyIZE6XBFSuC979VRSKm/ezsdRjkFR9bfwenw91oGt0fX9ZZwezAjU/TChHs2IFxWq
         2j9cJmZ9oobec8+3PfYlgGSuY5BI5hUcumcxMwNA4D+9P3fSzdJDdcbWrEwq2i3VVBWk
         L/eVqyEqtDEin3Z2IMT2aQO0bNx3kfJE8dT/2bF0oTEvosIIxZK3qZvTXJOqxQOzWQVL
         GBwUSsxboqK+5BGl0sta+e1yFLsTSu9ZYgdLmxWac995W4lXP6gyvohfLmRJ0Vt9qVQh
         Se1g==
X-Gm-Message-State: AOJu0Yyng05bPZ2yK0ZEmONt89EIVXIuxG6p9+eCKi5ybwhTVfUxVCAD
        6wDiwk/KfFLcaPgaw/15VghpDQ==
X-Google-Smtp-Source: AGHT+IGM/U9TMc9dhOkJaD9Q2LSMeEhEmfp04Mj+FcHBxuLYmJmp+99UA23YpkT+qqmkIf+jiqtkCQ==
X-Received: by 2002:a17:902:c213:b0:1c3:b0c7:38bf with SMTP id 19-20020a170902c21300b001c3b0c738bfmr6342438pll.12.1694803481936;
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm3771453plr.220.2023.09.15.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:44:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <202309151144.E420B9F8@keescook>
References: <ZQSfze9HgfLDkFPV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSfze9HgfLDkFPV@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:17:49PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
> protection that struct_size() adds against potential integer overflows
> is defeated. Fix this by hardening call to struct_size() with size_add().
> 
> Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, yes, this will maintain SIZE_MAX saturation if it happens.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
