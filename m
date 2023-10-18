Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5407CDD81
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbjJRNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344723AbjJRNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:39:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EA10F;
        Wed, 18 Oct 2023 06:39:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be3b66f254so731386266b.3;
        Wed, 18 Oct 2023 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697636339; x=1698241139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pm6XMnF0LkLiGv//V6H7WXNTlx5q7g2HU2tHJ2BwW4=;
        b=l2/7NsbSg174PJNclPIcVsTDKCPtl2gAdC6DV3NWDsd3alf1Y1S2Te6AtBFRbpo2Hu
         cFa+9V9m6XumETo+wGp0c32Mff3crXQxvZFMShP9VkNSppIKX0yPZ/SOWp3F32wASpyF
         SbTN5SeIpIVQIvXZf3wJC9jR2oNHPktiIX2RI/DTgdp2LcTjPeYfO3FnOcjoCnirc9nP
         oiwOqVZWJ042DQxz8OfaoBReJ4FbGdq2w7YAZBdMowBxRVJD2gGUFRvHqlhvBRpKpX4r
         DuZR/4GPkhCPVeB8mEclp0neFZwwC9ZToIDgOdKcJb22VLPD5P3c6lZrjlPX8FhTfwm1
         YEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697636339; x=1698241139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pm6XMnF0LkLiGv//V6H7WXNTlx5q7g2HU2tHJ2BwW4=;
        b=Omw9EGpDmJ7SrEyUQznRJjEE/qKEQrQiZpBaJOKLtmarY3C099zM88Jt2kBOqhvDEV
         AeJkFFsTUzycsnIuZQkxM46AHaEMmfPD9xpj6PLJYq+J0xgumUnN4zvf+ySksYRRTdTN
         KzqgCBZ+BFRRxNK95lspANrXVlEUiEwUZcsq58/yT0cMechWp5eG1qm6uWxX+J9d81Js
         AvpMAEWmTkhtjz6v4VUQFR/EplZ42t0uiQXpEewc8M64k9e2tAAMf6KdjEgaaFCXy8HA
         +TLrhs2K//YD8KmJnb87oYRep+W5lC8QyNvD3gH4Mwwo3bJLBQkROvSEH6xSrKXgE0p5
         s+uA==
X-Gm-Message-State: AOJu0YxI6QdOb3uHUPR+ASnG5DUYRe9MW3MVtZL+DyB0RWEJCNSmjX45
        9VyrK45YQNa7tv71XA/a+2ylVgvQQhs=
X-Google-Smtp-Source: AGHT+IFDqfZgAY2jM1OJYiTRT4h2u9L2KclhpnC2f5LMyn2k1W2N08R04lVtmG4J3ddx3rkdU8uY7g==
X-Received: by 2002:a17:907:1ca0:b0:9c1:9b3a:4cd1 with SMTP id nb32-20020a1709071ca000b009c19b3a4cd1mr3925459ejc.3.1697636339234;
        Wed, 18 Oct 2023 06:38:59 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id bn4-20020a170906c0c400b0099cb0a7098dsm1749327ejb.19.2023.10.18.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:38:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 15:38:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <ZS/f8DeEIWhBtBeb@gmail.com>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index bb0ab8466b91..e4b2dfbf3de5 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2849,3 +2849,8 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
>  	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
>  }
>  #endif
> +
> +void check_thunks(void)
> +{
> +	WARN(1, "Unconverted return thunk\n");

If then WARN_ONCE().

Thanks,

	Ingo
