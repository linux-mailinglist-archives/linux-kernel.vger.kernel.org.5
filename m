Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B37DF229
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbjKBMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347334AbjKBMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:17:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BBD182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:17:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc394f4cdfso6645235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698927456; x=1699532256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oL4FlP2htnexmvbpvmgMjjZcLLmrpWIdcBwksKPmpw=;
        b=Z5+K5ssa+yHKYAl5eQaS5d0EWJL+OBNlc8YUSmht6JNtxy17UubTSZB/r8mpaxOlBY
         11wEFE3LZpK9nC+lurRGuWKwcKHHpnlMt/EYLVItSYvjngXVCOZ1jvG7H/nQtlw7wqgG
         IGK+iIWyqP0OSpqFDe96mKEk81tz8i1vTl7Fb5bXgIg527s3NUr101qrZdi7O7L+370D
         +6RdNdDvRjvz/Ts+HlDgu11V2MlPlUSed897uoRltL49gWzlA6B4wru54OO0VK/rrOz9
         kmE0PZUW0Yyhmi+6yNI883MLQ5qcQbyWLOawfoa7evwV/ypjXXi4+lBp80lhyKjZzvFE
         IYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927456; x=1699532256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oL4FlP2htnexmvbpvmgMjjZcLLmrpWIdcBwksKPmpw=;
        b=DxeJSQHDbwivAETA4igb9CUme4iwq4Riubu4qKgTZhFEHfLbNugBhMifVdHboE8jpR
         bYcBkKNT5S5RmCYSojYlHf7rM3BShvJ5quZDkp+Uv5VxP8Qi/2DJyLWOCmfD/xv0VVi8
         8Nz9vgJswWwPPiICkMVhqocnXaprdGeRXl6dbmBEPkIyjAs7R+w9342eR4J/82pTMRbT
         +uTAxHSguaeWbYC60VQp1sqjO23Uk+G7Me/UyNIWQM6dpNSicrklGFPEVBRXrygy2K+N
         NBrxxvxvsEE3LMzGs9QK7o898jc/DevNi+4KEPW6Ifvxis91TzyfZtk6t7Q3grHcqLKR
         nwWw==
X-Gm-Message-State: AOJu0Yyzcp0yBk2FavJDg6qOotJZ5SHkokPf6f7N1vAWHanCWg/r/GeX
        MvF++H/thtsrn3FEAyVGtRgKS5u6CIk=
X-Google-Smtp-Source: AGHT+IH7RPiQ5pHor1NWOb5GbtnuHttpILM2oIDKqNJcXfgLKftPiHOy9t2Z/uRhfJ3PFDNw+rHUAw==
X-Received: by 2002:a17:903:210d:b0:1ca:28f3:568e with SMTP id o13-20020a170903210d00b001ca28f3568emr13887600ple.51.1698927456573;
        Thu, 02 Nov 2023 05:17:36 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001c3f7fd1ef7sm3004029plb.12.2023.11.02.05.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 05:17:36 -0700 (PDT)
Message-ID: <1ecdbe5b-157f-4d29-8c4b-5fd49f7b75b2@gmail.com>
Date:   Thu, 2 Nov 2023 19:17:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Documentation: Web fonts for kernel documentation
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231102120053.30630-1-bagasdotme@gmail.com>
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

On 02/11/2023 19:00, Bagas Sanjaya wrote:
> Intro
> =====
> 

Oops, linux-doc mailing list address was mistyped. Will resend
(as v2) shortly.

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara

