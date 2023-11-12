Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932B7E9169
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjKLPVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:21:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856A2592
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:21:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce1603f5cdso4267455ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699802508; x=1700407308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwAN54Xoik+Feb3mCch+2bZAbzYnD5M1v5iLrQuVXB8=;
        b=hO5a24gj7AiXIMgm/q29s60RnZiDZ2mK6suQWGyV5N3NiCMZbRnK7uI5Qa8MHRhbYc
         ORA/5XDkCQTbIuLB1HaYGYWeC0LgYnpaVaxX03ZvoK6d0qtQ+jM/AD6Kkmb6kxWLGT2n
         t/ly0tLZqtAUFnbHs0uh74PJhCHK7UheGo7GDN2abvyBdoLIjf7l3OaUDTp0Hh3W8TdP
         wnELZOoDSCMImyZNO1H7AkV7SdSIA5HM2LoI5Kih+TNoCWyb79kHjVeRAeReSbuNwMr6
         3UIqP5TdlwNr5vJy5rgWtXg+wg064DJJCdWmoxuPX8yMnWNXr1ZtZNk/CW0iP+H2E6eL
         Oyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699802508; x=1700407308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwAN54Xoik+Feb3mCch+2bZAbzYnD5M1v5iLrQuVXB8=;
        b=h5owavLDifmdZx30eR0OPwureXsMqTCQ58XwSjIFrghB1SoJN0Opmt+Ritj72W6943
         LrhKngson6Qh7wK4fHJZoL/I94PabmJHWqAk2JTeFvSeaLy+p199VIYghAlHQR8S6yNG
         /P1s0U9zoG3XjWEiCWIaiAMTOoZctauhE/fmFL+KqXOiBpQJfeBR7rS6d5vwVRR+stj0
         oKiiquVOFXfP215B+LPxZPjMTfQDyZG6B5psTVAsCa0xwEVFJMpz+CnYDdBdDfjZg/LB
         t3Q3ygP/KArNJVNbOcBg8r9u4M8Tc8ZiczLuhxy9BrPjiC9Crgp0iW3prR5FeavDbdB8
         BPhw==
X-Gm-Message-State: AOJu0YyCZHUdRewI2GGPNqtVCG9mWU8OihbCv80vBKpP1TWyzPyyXSTD
        VR/crYGqUlWOoDpVGk9x7kLGSRINBSMApaKb
X-Google-Smtp-Source: AGHT+IHA+T3o8pU2uFblZMWxTHMyQamRP/be5ZMI7/TJEpAqpmn1OLHzFSrlq6DgcaM0YWSyWFT0/g==
X-Received: by 2002:a17:90a:8a15:b0:280:1d6c:a6a8 with SMTP id w21-20020a17090a8a1500b002801d6ca6a8mr2680866pjn.23.1699802507597;
        Sun, 12 Nov 2023 07:21:47 -0800 (PST)
Received: from [220.72.86.232] ([220.72.86.232])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a030f00b0027d0c3507fcsm4970504pje.9.2023.11.12.07.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 07:21:47 -0800 (PST)
Message-ID: <13dfd533-daf4-3b35-3d68-5c72a294db3c@gmail.com>
Date:   Mon, 13 Nov 2023 00:21:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqdesc: Fail check on early_irq_init allocation.
Content-Language: ko
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com
References: <20231111170035.10386-1-p4ranlee@gmail.com>
 <87fs1bxe9h.wl-maz@kernel.org>
 <1f6e21c1-7340-ed40-f2a7-66c063b453cb@gmail.com>
 <87edgvxb56.wl-maz@kernel.org>
From:   Paran Lee <p4ranlee@gmail.com>
In-Reply-To: <87edgvxb56.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-13 오전 12:08, Marc Zyngier wrote:

Thanks for the great feedback Marc!

The review has taught me a lot of things I didn't realized
I'll try to do better in the direction you suggested. To be useful.

> A much better idea would be to *get rid* of early allocation failures
> altogether, by moving all architectures to SPARSE_IRQ and making sure
> that NR_LEGAY_IRQ is always zero, meaning there is nothing to
> allocate. That would be something useful.
> 
> But adding random BUG_ON() based on the dogma that all allocations
> must be checked doesn't bring value to the kernel as a whole.
> 
> 	M.

Thanks so much!

BR
Paran Lee
