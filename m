Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB380BD3A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjLJUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjLJUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:40:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F6BFE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 12:40:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2d50c0adso6612095e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702240852; x=1702845652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ab7lMzsLfWXGl0JbgQIy0bj4UtBSLghAU6yN7UWGtc=;
        b=bIRGTsdzWYvBF0CJ8M1CrXZh/nf+H2mC4H99bSU8Bfwn+/6DsqGHlTTuP92D3ZcQO5
         quqXGYVAkwXZcHxkViB4fdsUNBloaHQI4AKLKzrxyyVYDFj75+Y2mQGtkAB8uXZbzQVU
         9fldnt1zCstuOzNZ5fDOAAUjwMZtGH0c/FhQjyLkMyOE9Wxe5V25RxzU/Ue0VHN0v0fv
         0s4db8E7AXXc3MVezsZaAUnqHRWAZEsDhoCrrecFmqxcZc6p8f+VMWDYTWgup8jB4pPw
         7gKyOk5mdEMp4AL/OsG2+8pY7pRZ6X92dyZXguzcTWyD0LsFMyeZm2P4RjaoEXBnYzBj
         CfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702240852; x=1702845652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ab7lMzsLfWXGl0JbgQIy0bj4UtBSLghAU6yN7UWGtc=;
        b=Ej7MwD9OunqZOotbNOoBZB4HkBNVtPJuA0uRdNnm4QPZJrnlDnvUOXoTczja/nC5yg
         SpCxh2MWSVqxtHt3XCX/Df3+YqMy/J1Gd7AveTO39bRqmd0GQnVfWKSpyVRVR9P43izG
         UebRcZ2XgalltTkuO3q0Dciu86SqxBpB11EiedUa3RRYnKRLitf8Lf7o5m8+r++DARZ2
         xg02pKosPxmgyTVWftk2myymX0v0EResQlMyw3FDehuhrVXsuwjUEx6DM3wCaVPvCbI+
         jz9B/COvqJkpuXjOQ+3YPDkEFUKboSWZ696Qlk/82me0DeamYtsNLjJTPoEbER3KN1TE
         dAgA==
X-Gm-Message-State: AOJu0YwQ0DMH0X8vblS92lk7e7g5MVO5qx7aUYx7e+PI/97H62tDFbVr
        VV934tMoR6IrXi8LQuQIcNr3Mxs5NfY=
X-Google-Smtp-Source: AGHT+IEq7ypqKwoorgwhbbOrqX2eZbNSUEABBido4fvYyzJ4sCIzFZC8cdjPAs210wnQHCqfjccieg==
X-Received: by 2002:a5d:6483:0:b0:333:460f:759c with SMTP id o3-20020a5d6483000000b00333460f759cmr4065123wri.1.1702240851947;
        Sun, 10 Dec 2023 12:40:51 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id q18-20020adff952000000b0033609b71825sm6534260wrr.35.2023.12.10.12.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 12:40:51 -0800 (PST)
Message-ID: <cc4513b5-2ed0-4475-8bed-fe75e837aebf@gmail.com>
Date:   Sun, 10 Dec 2023 21:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Staging: rtl8192e: Remove unused variables in struct
 cb_desc
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231210193705.2131807-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 20:37, Tree Davies wrote:
> This series removes a few unused variables from struct cb_desc in
> rtllib.h
> 
> Thank you in advance to reviewers.
> ~Tree
> 
> Tree Davies (4):
>    Staging: rtl8192e: Remove variable bFirstSeg
>    Staging: rtl8192e: Remove variable bLastSeg
>    Staging: rtl8192e: Remove variable bEncrypt
>    Staging: rtl8192e: Remove variable macId
> 
>   drivers/staging/rtl8192e/rtllib.h | 4 ----
>   1 file changed, 4 deletions(-)
> 

Hi,

works.

Thanks for your support.

Bye Philipp
