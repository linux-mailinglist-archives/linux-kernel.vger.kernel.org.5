Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098D7B26E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjI1U4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1U4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:56:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2198D180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:56:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b275afb6abso2047835266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695934559; x=1696539359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzrMT21Lus3/G6BZGlxmK1SYMsq60jCjSw2jYNMrSgk=;
        b=KZ0SlWAHQOn5p0ZCCacFbaETgsOIvsBqpA/FwbiRxp64f+ozocT7sBSn13VJJFUc0B
         As+fmnNspNmH1ClmKv0/idP1cuqrRtqmcArE3j31/k9e23wUXcy3V3hosvqfJsrA3MVf
         k4BFuUlb+X/sA5pVaSmQPiqy6MIsivyK5GS5KhO1MPKcAbWMFbbRvA7gdRD/0X1H+9fi
         gn8t5l1/IkDxQehh05fQ15jtbeDlAFfLy1ByvFiyYTBGBvmuQMjtcAf1uqkWigjrEDR8
         9DggogP/aCQhu7aB8yv/E5LStdVy/kJvNK9loQ1vCSNxkYq+K6ul/KkkcOEZix5sYfw+
         RhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934559; x=1696539359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzrMT21Lus3/G6BZGlxmK1SYMsq60jCjSw2jYNMrSgk=;
        b=D9FHQNVczR0T6vkOdavT9n9cgxgloZ//KxSp75HyXqYKNJOppiKmybPy2azQGGlyDz
         WVB0+UhWTgGlCszQDKUr3cKMbA5TTF9ikCQNGXZu6AnBIPehFQ6oYbwXQ8qCM2K7nMHI
         B29V1wRlFM/pipA+l/2gtiD3onRMS0L2f8Kghjajc0fxPMA+3G/7vpuNdZyj96dCUzJG
         YqvfdfxAOYynWMkJ+w0xnhNrcIkz0va2ITG7pFbzx2slCjJCs2AsdFJLoyl69cD9F9a2
         7fDoroBgx5ClMq0sLYl9ICnQvkWewdjBG8xCepmTUojzDAX/B0cW87jugVC5EdM+jhPq
         4FTA==
X-Gm-Message-State: AOJu0YxmrpKK31m4cP67dLr0qW7E+Zg0BtNwh2c4YwD2E+qG8/TQFrRV
        ehQFqMB8xBcQYla0VkkOtQk=
X-Google-Smtp-Source: AGHT+IEr4Df+wMio8A44Vuxyl++s1bL5qFIQ/Sc/hyRv6tvIhKBOvhXB5yh8jy7cr/bFbng5qrYhYA==
X-Received: by 2002:a17:907:7b8f:b0:9ae:5a56:be32 with SMTP id ne15-20020a1709077b8f00b009ae5a56be32mr2427241ejc.38.1695934559266;
        Thu, 28 Sep 2023 13:55:59 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm11324311ejb.103.2023.09.28.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:55:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 22:55:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 2/2] x86/cpu/intel: Clean-up TME code
Message-ID: <ZRXoXLV69TQ7Wvkr@gmail.com>
References: <87h6nhu7k6.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6nhu7k6.fsf@jcompost-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Compostella, Jeremy <jeremy.compostella@intel.com> wrote:

> -/* Values for mktme_status (SW only construct) */
> -#define MKTME_ENABLED			0
> -#define MKTME_DISABLED			1
> -#define MKTME_UNINITIALIZED		2
> -static int mktme_status = MKTME_UNINITIALIZED;
> -
>  static void detect_tme(struct cpuinfo_x86 *c)
>  {
>  	u64 tme_activate, tme_policy, tme_crypto_algs;
>  	int keyid_bits = 0, nr_keyids = 0;
>  	static u64 tme_activate_cpu0 = 0;
> +	static enum {
> +		MKTME_ENABLED,
> +		MKTME_DISABLED,
> +		MKTME_UNINITIALIZED
> +	} mktme_status = MKTME_UNINITIALIZED;

Please don't move the new enum inside the function, even if
that's the only place it's used.

We almost always keep constant definitions outside function scope.

We also try to avoid static variables inside functions.

Thanks,

	Ingo
