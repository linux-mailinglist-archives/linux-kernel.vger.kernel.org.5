Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEBB7E200F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:33:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B5AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:33:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so31228355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699270401; x=1699875201; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUKg4uVi4S/dFZ17di9VmvoE4aPOO4c2Mhi3gOlXYIY=;
        b=TR4/Zt1B5DEeMEiOjL4GlIcfKm6yyDjXtz82Ebik27eIubgyWn2hD8cERZBBpq53KE
         /0SmUH/b1/vbUtjWtlf1yfaDuo4mfq0QfwOKjvgecSDGWXMrCzFDx8QC5j6s2xVfOzGO
         iZYIjZlZ/OutJJQSbrg2NxON2QpyAp2fZ9C4ms+LY08uFiYfr0hAtAEatXhiDAbF/6E9
         Dg5oGhOjRZ1E6D1o/AAedc06CI191VAcMo8SdxaENBemJkXH1MFCIXbBjWJlyahcYB+h
         ROXhKicb2v/IIfN2Bfaw9KYJoAosTHiBFCbiaDpUjekZIAwL3tlNFAVp3Gw8fXhXP0Aa
         feRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699270401; x=1699875201;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUKg4uVi4S/dFZ17di9VmvoE4aPOO4c2Mhi3gOlXYIY=;
        b=wDfl99rQbctKxDOvWCiTwjAOfDrVpdBJk2iwzPq2t5KPDsBDbSNMZdsz+VIFe4WuMs
         yRMUHipMpLkOnV7oJKzdoj1UIAwb4vNkjUjbhYrFlkzoONaiBS7X5ymKHAE6VQ3u4kOT
         2NN3UkIttftYa/0Z1+d6GAfg5csq8RagH/3kNrkhR2nXODq0YeKz0JV9rB9EShrOV1KC
         CDsLJVNr3bAd2juFE/8zwscu8HFwRIz14gNJ0/ssU47vbICVjazvjT+B/vwgpcdOuM38
         LByGUwS8gjeBY51MZb3fuNYBj4+Q4ywMtMFjHKwvi73214exmPRI2QRq27B6a1QC309D
         7Cpg==
X-Gm-Message-State: AOJu0YwzeOONN6qDR5WoykYB3TvNfagVgI/VkrDyJPYurpw9wITuBl9p
        s6kn/6IyX8bAgDHU+ngsN+U=
X-Google-Smtp-Source: AGHT+IE2f8JmuTi8owPpBOZcT3du3yeq7e//eJgkT8TBc4/LbLa7lzX8PxyD4XIK6sHGvxBMtIDwwA==
X-Received: by 2002:a7b:c851:0:b0:3fe:d67d:5040 with SMTP id c17-20020a7bc851000000b003fed67d5040mr11252842wml.5.1699270400711;
        Mon, 06 Nov 2023 03:33:20 -0800 (PST)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b004068de50c64sm12045548wmb.46.2023.11.06.03.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 03:33:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
Date:   Mon, 6 Nov 2023 13:33:08 +0200
Cc:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard@nod.at>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9D03E2C9-0571-418E-9075-6DD39DBA724F@gmail.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
 <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
 <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2023, at 5:47 PM, David Laight <David.Laight@aculab.com> wrote:
> 
> gcc always assumes that inline asm changes "cc" - there is no need
> to add a 'clobber' for it.

Thanks. I was unaware of this behavior.
