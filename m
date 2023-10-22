Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67B7D2355
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjJVOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:09:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF91E7;
        Sun, 22 Oct 2023 07:09:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso1780809b3a.2;
        Sun, 22 Oct 2023 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697983751; x=1698588551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vq51sfoWK29Xyr9uHLogcGN0q8f07Bk7akLzovDnqr0=;
        b=hk0RG4vkN99MJ5bOVbadLSZatEF4tiPSqS/OxvsAk0AST4CiI0V8o4+ZSZ3Q+5TXhK
         X465AFh2gJWi0kJ6mtQzRXu/nKqJ3RxkYrZcQaUTjKNOp+nkJCAhLK09DUGEzcPmRTv1
         eE3Fq8UMT0cfL1JBqlP1SHyKIJzjIIbIN/IQQZR0ATJ9fdn8MCZPftVDxH6ilE082fvh
         uxF8Go41eo6IX9pcmyoY++PPVIG4MfCGrYVqO36s0yDsBy37y01cVYaaShkXniEpzDOZ
         eRR2rF7FAJ3QLoU2Zgfh3/Q2t24mZP8YFM+fBG6wjHkTTB2DCAyj3SUyceGNzJkkuWN6
         nZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697983751; x=1698588551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq51sfoWK29Xyr9uHLogcGN0q8f07Bk7akLzovDnqr0=;
        b=WWD8zvxAobEqlPGRbKxfHR0DbKwNiCqV+Xaks1SmtNcGEqc55BzRZUSs10Us4TRaHG
         Qsvh+/NSsVwVI6JE/FFWL34zNhRLHno275eEtJAlWO1hRm8IjEHWp6n2jHsiNvHlKwx3
         SeFHagLBR56pDQQVqZey6aGDHDNh9cZLwJbsJju1FEXvliCSpexXhOSAD47x7TumHP8Y
         iLluF90wBx34hFNA7naCA7L37ChpZGyktHCBkyTxiJRkRylxjmJSqKHhup40xa/Y/4Q/
         adyQOLqNJiwmQAtvyXfIiz3h2+g8MyJaClTladYN0Laj2vQE2yKfLMwIwb7aLb3+uIFG
         4kGQ==
X-Gm-Message-State: AOJu0Yyz9BRBhB+mv+fmDSKIX4kCU2//A1Chqmmc1u5huEGWGorOJOZS
        l0dR/cUjPppdiVQZfHZYNPE=
X-Google-Smtp-Source: AGHT+IEs9+VThr5TWBxb+QG4LemnkStvrHuALxohT7h3f5xRoY2ex5KJAmrMCqrCHB6CIF/qQPK4uA==
X-Received: by 2002:a05:6a00:b84:b0:6be:5a1a:3b93 with SMTP id g4-20020a056a000b8400b006be5a1a3b93mr5631352pfj.4.1697983751086;
        Sun, 22 Oct 2023 07:09:11 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm4691749pfr.92.2023.10.22.07.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:09:10 -0700 (PDT)
Message-ID: <872e8be6-c0d0-4e5f-94d8-e5c021d24585@gmail.com>
Date:   Sun, 22 Oct 2023 21:09:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Old WiFi modules -- for testing?
To:     Rostislav Lisovy <lisovy@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>
References: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
 <ZTUIJHf1vdSxkXeX@debian.me>
 <d85050999a2944a921a38352d1c371fdb3b8c29e.camel@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <d85050999a2944a921a38352d1c371fdb3b8c29e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2023 19:31, Rostislav Lisovy wrote:
> Unfortunately I do not have any further info than what is on the
> pictures.
> 

I'm confused then...

Anyway, you can try submitting patches as contributor (see
Documentation/process/submitting-patches.rst for details).

Bye!

-- 
An old man doll... just what I always wanted! - Clara

