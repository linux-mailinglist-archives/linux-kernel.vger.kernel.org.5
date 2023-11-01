Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636567DDDA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjKAIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKAIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:14:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084AFA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:14:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc3216b2a1so26117265ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698826483; x=1699431283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yteGal8bfi28CjXQ5f/6gEYfH3Je8xJWZgC19fKPZpw=;
        b=CnhxnTCh2C289uG9beiIMCoqs75QD4PnGYBuTnftCFXnkKUZSY+PlqlUcq95r/59MV
         sqeTOnRXl3Mw+8BUINDxqN5rgDD7m9XxjLw/A4VhrDuKrOD6dBEBfWxFXTGPkSXM0b8B
         4NEiLIkD07yEDtxKNprunQ0y9ZlN5fj6UDS4eYBjKPshAQC0V+k7NEBiRBeiAyp/TR1B
         sdNK/c08t97pgcjM9z98RiUYzfliZohk8eOfUdR/rT1MkFrW57a/V36hho3fujd8SFQK
         MJJl3waUnJgQpkZnqxtVat30K17ks6nnOgagiI407o3m8sJXHGlPxKWvYZarXyu0xlRG
         zaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698826483; x=1699431283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yteGal8bfi28CjXQ5f/6gEYfH3Je8xJWZgC19fKPZpw=;
        b=kX1auuxBBd6uEPLu9TsBlTveCOgKBKqjKLA/eh60/Tt74P7SEEAnAcpuvxE3yevRNL
         RvtyS5A9VQhbbZ7r+kZaFSfJO3EAV4YQ9dZV6W0p8QSpAnyao/DxNvjvd8J7wAxYsfw6
         BbKIN4J7P1j4t45JcfzMg/UzFr6qh9jOt87btQP6ENQ8d1ArYU3yymLNQN6eM18mBaea
         RZA94BDw3ooZY0pYhLwSIm+v4PjTEunhGSyNKA3jEaSbkzkp+JnLkL7iyYb7j0Q7K2ga
         dg0QITlvlFSN7dH/MFsSaSVzOzAC9vgIiZk+rBEyHfQQiAvNX5ztXkThvHklSNyJEuU1
         u4JQ==
X-Gm-Message-State: AOJu0YwPpqdWSQfsoHVO9p7zmT1ESr6peaIgsB7MJ00Cl5n9zm+aD4EO
        /BilR1m+/saRgT3i+zu7Mfebef8yL3U=
X-Google-Smtp-Source: AGHT+IEvDkDlJewlEieY2zSy9jhj4YYYdNBvwZXNulDhgLueNtBCUcYWG/kgUcekigFT/lm+sJXHPw==
X-Received: by 2002:a17:903:905:b0:1c8:90bf:4239 with SMTP id ll5-20020a170903090500b001c890bf4239mr10564511plb.42.1698826483425;
        Wed, 01 Nov 2023 01:14:43 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b001c0a414695bsm821596pls.43.2023.11.01.01.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 01:14:43 -0700 (PDT)
Message-ID: <ae8cc9af-b73c-435e-b2fe-8930c49e88bd@gmail.com>
Date:   Wed, 1 Nov 2023 15:14:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vme: enhance the help paragraphs for clarity
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dorine Tipo <dorine.a.tipo@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Charles Han <hanchunchao@inspur.com>
References: <20231029180346.8570-1-dorine.a.tipo@gmail.com>
 <ZUIAyQGSfIKqK7AE@debian.me> <2023110152-snack-circle-3bf9@gregkh>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2023110152-snack-circle-3bf9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 15:09, Greg KH wrote:
> On Wed, Nov 01, 2023 at 02:39:53PM +0700, Bagas Sanjaya wrote:
>> [Cc'ing driver contributors found via get_maintainer.pl. Also Cc: Charles from
>> linux-doc mailing list as wording patches like this one most likely suit him.]
> 
> Please do not, that's the responsibility of the outreachy applicant to
> do, as it is documented very well what needs to happen here.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

