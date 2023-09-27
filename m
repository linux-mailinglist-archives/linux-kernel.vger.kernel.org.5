Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5217AFD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjI0IGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjI0IGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:06:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC5D1AA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:06:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso1286586066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695801986; x=1696406786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryydy9ohdDMnk3LeSCYYGEmNVUaQ5qBDaUQrrGSDq5Y=;
        b=RPiooq35ermSJ99aYG07xTo/i4OeCSCEt3DStTbX1S4B9AutmQqddqfn6ShZuW0OGF
         F/+fKeoPeflbCs8NQ3uMrVNpqx2Q5zE54l91Ym3CETKHPgBm/JCUZKBiDfN1xYShI6t6
         q2CJ75pbE76irORD1zFHg7yse0zT/rNwjw1xQVskEt6t8NboEe+98Jej+DdcsPDycn4g
         49I4RCbiD4u/cTwP/u5FIpxnlHG3XrxA0ABJj3gU2kEuWtZlyWdl/RYkgr75+glSX6e3
         UOVUY5Y/v0Bu6JI6ggsQXbLycvAlqC4/YNbtZPlQW1nRr6GK2qnA+uYbv7TwYa77QCu6
         SJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801986; x=1696406786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryydy9ohdDMnk3LeSCYYGEmNVUaQ5qBDaUQrrGSDq5Y=;
        b=p25mjEwv/pD0AnWKgadaNaFTtO8eRuMvok+6iy0dB+z4nZ/4afOnG70UxyFpATjNRU
         wt4KI3AJO/TUKYHInhiqHg6IF1xrN/K+diLCsctJtxyE8PkMT4CGQzoXzoAIvRcmSaTH
         dCtqP/qKCK3NZofV6DRTOLnagF7bglGGdc7gJQ1LqV2zpSG4NHLxrjg3g86BX1UUy/Jy
         3OEiHHLglYbtMX0Bh3BhGsYVx14EggQ2+Nq6+IItQvYqHCVBKSzCehotKg0SvHQtxnOw
         sooYeZ5oOiFrBfT4aX3ro3HYWT+D2rYBc0HakDmV3EgZ78USEJFwb5SBn50UTlWQX4w+
         kRtg==
X-Gm-Message-State: AOJu0Yz/rwSCxfIoSYtv+mmkngyRSp2jpGniTPOvZqlrnzKTnhofJBN1
        4p1uaz/jvQsLvFSmDDhWPR0=
X-Google-Smtp-Source: AGHT+IGaiQTioYJMm8lqlrjKYYAOFXPwurpySherulz6mD8S5yL8sh1E66YUP1aQ3ifPsZql78lG/Q==
X-Received: by 2002:a17:906:1017:b0:9ae:65a5:b6f4 with SMTP id 23-20020a170906101700b009ae65a5b6f4mr991625ejm.20.1695801986210;
        Wed, 27 Sep 2023 01:06:26 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009ad8acac02asm8948524ejb.172.2023.09.27.01.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:06:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 27 Sep 2023 10:06:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     xin@zytor.com
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH 1/1] x86/entry: remove unused argument %rsi passed to
 exc_nmi()
Message-ID: <ZRPif+9R8pp1v+m1@gmail.com>
References: <20230926061319.1929127-1-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926061319.1929127-1-xin@zytor.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* xin@zytor.com <xin@zytor.com> wrote:

> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> exc_nmi() only takes one argument of type struct pt_regs *, but
> asm_exc_nmi() calls it with 2 arguments. The second one passed
> in %rsi seems a leftover, so simply remove it.
> 
> BTW, fix 2 slips in the comments.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/entry/entry_64.S | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

I've split this into two patches, because the comment fixes
are entirely unrelated to this patch.

[ I've propagated the SOBs and Acked-by's to the two patches,
  as I presume is fine by everyone involved? ]

Thanks,

	Ingo
