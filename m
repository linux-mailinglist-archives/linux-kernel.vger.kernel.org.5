Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF77A274D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjIOTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjIOTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:42:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD119BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so2328099b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806935; x=1695411735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=h38ZcxOqWwCMHk2cL65uE60F0C0YUQdFXGSjn5YM4z/sbkkqRAKpN7N8C0XpegO6cw
         c2UagfzmMXtWz3MuMZ9O3TEYaEWJfvjaI6qniL9tuqrfhXZampXd7WTX72bjb4h1LLPI
         1u4LWhkpW4LmoBf7pprnlw6+1Zq1wWhGXTfeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806935; x=1695411735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=iEYNATv5dgUdIZBaS1qxeTawrcHANKpqA171s67vsCqp75CVJkN9Yj/fAcpwtyfk6M
         HFxe71DkfhiHc81TKYc1eRNL4uJX6+y/0iGPMD2Ot+TKg/dXDq87tYZbKNBxry0LoekT
         /ShJIDLBHmFG/rJPW+kzSui53MqSgTVW73FvhyHf0PRHT/+GFBb4AhIEgJy7KR7qsuSU
         Q2eKwFHE2IUbaebuifpNs2kDwsQ9ZnOq+nmjpBVSwCpRQsu0NbYIUV3Pbop4+8dgj8No
         38+Iwq1tqtbz2SJ4FUHkAjdEKvaAskxMyg18NZ/S/xbN5lgd1saBtVcPK0+MdwGApd8/
         zK4Q==
X-Gm-Message-State: AOJu0Yxs8AmmusuY3borLg8TShbcvEvk/4FXPpHOlKEhou/4NZXEuyDr
        zUqwVbyTKERCVubdtCtZj0x6Qg==
X-Google-Smtp-Source: AGHT+IGpdxeoMFg927wqPjDXncgi6Ri3SO4sv6EPXygbD0EnqTl0JEaVe8KWeIG5/O1y9sFbXRwVKA==
X-Received: by 2002:a05:6a21:7189:b0:153:39d9:56fe with SMTP id wq9-20020a056a21718900b0015339d956femr2593392pzb.47.1694806934963;
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b0068fba0f5f32sm3417615pfa.90.2023.09.15.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:42:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <202309151242.E732735FA@keescook>
References: <ZQSqA80YyLQsnd1L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSqA80YyLQsnd1L@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:01:23PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.
> 
> Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
