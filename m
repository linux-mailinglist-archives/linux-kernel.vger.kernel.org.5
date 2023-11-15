Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD67ED721
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKOWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKOWYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:24:21 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807219D;
        Wed, 15 Nov 2023 14:24:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b587bd1a63so644497b6e.1;
        Wed, 15 Nov 2023 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700087057; x=1700691857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pK7x80v/TUk+HNYdR00Nsp/GdzaTg3DmSY6zCPIMGg=;
        b=A98c5IgwxRX3p2FGO34UArDsfhs+2wQG9M7rmPcUg6aaNCMNQKS4R51pkOIS/o9dHg
         DpBZm6BwTr0nRR01WTo+bx3KGyJm8u2xg6Dy8LMoM+1D9x5jMXNVRytuxWLCJGE7Ni3U
         pA3JeUDD3oNu9psEWeoNik04FjbB+L7RWlJAn8wCSvqW+Bt29S6iYkZlIRS4At0IkOAW
         yqLXp0LKDlmew3bUbMtnaUeHenwoMehMOvPer/l00kIFwcjCTd48pg2QEiduyo4I7DW1
         3bw55ksuV15ZHwfTbnCCPvOdCWckPwjXGC2U5R6sfpQlOr/dDlkv9hb2Bpj0OjWB4ify
         x0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700087057; x=1700691857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pK7x80v/TUk+HNYdR00Nsp/GdzaTg3DmSY6zCPIMGg=;
        b=T8zPtsUWyJiAZ9yJdGu1U1D13jr8X6sHWXKFV0wuoU07ZONTWBz+yoIapHxLNvXqEp
         cDMGLrNRUFiWgmJ3partRN98g0817BBvAxB2qQwpLZ6WSe6SjotiQrpOaA6BWhne1xkJ
         cr600nLTaih6PLs37D/C6brbVQq2kIKJzC3c19nBHP00usWTVMEb9VifhgJhNOO5of09
         /Rj96QYUZtLC8xjv1fojDf0rTJ2NLiIAQmWgLO6P9uSRtUfkANutQSNs0b9o98PNAGc4
         1L/7RLvMIusN9xHzjCD+/1aNlY1UJNOjtXmeO8rRHPj32fvmX8+Indj72oocV+j2Do+g
         K2aQ==
X-Gm-Message-State: AOJu0Yxfwv+QXoyVJKGwINUoudVCn8D7hU6Zm+8u4bI1QkloNxP0AI1Q
        YrAlqMgdiRhTNk7050bHSa4stWX3bbw=
X-Google-Smtp-Source: AGHT+IHdq1afOr17zIpOmnrFXKOSA54kmUEhDEWVRk4T9O0ItiEcdIypqDNf0UUNOIKrqBjSoC7Vyw==
X-Received: by 2002:a05:6808:1918:b0:3a7:3791:706a with SMTP id bf24-20020a056808191800b003a73791706amr4029129oib.5.1700087057509;
        Wed, 15 Nov 2023 14:24:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1-20020a056808014100b003ae0e57874fsm1620531oie.21.2023.11.15.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:24:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 14:24:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: lm25066: Use i2c_get_match_data()
Message-ID: <69c0290f-ab61-4f6a-95f5-3ef0486c4bce@roeck-us.net>
References: <20231115205703.3730448-1-robh@kernel.org>
 <20231115205703.3730448-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115205703.3730448-3-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:57:02PM -0600, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c_match_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Adjust the 'chips' enum to not use 0, so that no match data can be
> distinguished from a valid enum value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.

Guenter
