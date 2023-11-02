Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51B67DEB37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjKBDPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjKBDPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:15:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC6113;
        Wed,  1 Nov 2023 20:15:06 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581fb6f53fcso234033eaf.2;
        Wed, 01 Nov 2023 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698894905; x=1699499705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07ijN2s/Gqg53qTilmJ5hXeaHQyI0IV15I526+m3XjE=;
        b=WE6g+77SXdz276kzRRHF/lxpewzjdnOcN3lb7lKDu59cMsZfvDzqvIn7Je3+Gh1nss
         8Lc1wdVy5eiqjtzrG8IHZW/Js21Y14aL99Z3XNaPQRiQ/FSRFYBzLFow5sPi/drBRWXE
         jIVXX18snrR1uscJYfxTarEWGrVcc/mxxco/LP2AYxb3Lc/FatKpgee+N6MoR4Q/b9Tq
         OudmqOr72ylZsJaeh8gDItp1UmkPZUApFH7izSEkvtUg72rlXp3J/Ok6QHueWJdAzq4Q
         QYGtpHhHwiLNZ7E0C4yqit7n7E33AQcGPhknBkduwxbStPuoUvyOk8Tf9Hg7MkqGO3cs
         1qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698894905; x=1699499705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07ijN2s/Gqg53qTilmJ5hXeaHQyI0IV15I526+m3XjE=;
        b=i5aK8wYxo0kqzmQAY5ezPMtAXSvG3e1xbbsKuJRJi85KMnQepQmgiSHjfy39Z64jTW
         xbuoQRQKaufuoux2rMagZJkN+TS/5wdwsIwh8j58CmQzJOOYS/zAb276w6xJ9rdPuzj1
         ejgk6ldYP/WzJf9YunF0k1M56ehonIcDE6v54GhXCJ7lhaKFmJ5qbFAVXQB7TV0Kjavb
         C486n+9Tp1P8UPIxU4hAGinZWqrdsE/iD2fNtEHSvQIL+ti2rCHokRZNw5FsjFAeErvb
         WD0kXYU2By/kBS5Wx7qH7F0nqmkKWej72MfA6Q7iHccQGMQUUKUd4mZzfA2W9MCEWhd8
         y2MQ==
X-Gm-Message-State: AOJu0Yz5/LVzGWBiFqnJr8TfsxftIl9VfFlzSNn5LIpinTjgB7uo4hjt
        EULeYBuDJuMZGNiw/fll29JL2+p69k0=
X-Google-Smtp-Source: AGHT+IHGqTqbXnZ6ELTOrKAIgev5NX8AiKdOnszEHivskG21FKHmW9/HkeZkbdz5pDjRmqzfciHZfA==
X-Received: by 2002:a4a:dc94:0:b0:57b:7ac4:7a94 with SMTP id g20-20020a4adc94000000b0057b7ac47a94mr16486453oou.2.1698894905388;
        Wed, 01 Nov 2023 20:15:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p125-20020a4a4883000000b0057bcbc23738sm857754ooa.17.2023.11.01.20.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 20:15:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Nov 2023 20:15:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: ltc2991: remove device reference from state
Message-ID: <f0a0e61a-a853-47d8-8978-f6bfbdac5a44@roeck-us.net>
References: <20231031095647.48376-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031095647.48376-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:56:46AM +0200, Antoniu Miclaus wrote:
> Remove device reference from struct ltc2991_state since it is used only
> inside the init function.
> 
> Pass the struct device as parameter to the init function instead.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Applied to hwmon-next. It will be available after the commit
window closes.

Guenter
