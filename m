Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62F7DAD0F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJ2P6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2P6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:58:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F28B6;
        Sun, 29 Oct 2023 08:58:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507bd64814fso5102615e87.1;
        Sun, 29 Oct 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698595125; x=1699199925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e6k9aLofPBwqtOZrl9eOkhzMIksyEAGsMT8mwHRyZM=;
        b=Mvb/wDkrLCx3xmNgUd5TSo1Q0+GSK1vvjwW03vlzxaD8vGghFIHbOI+iYEEuLDBNsC
         KYxjBpsB0NT9dYWCxhp4/4PxtnwnwUkVQSHiTT3PTFVpk5E1tN/HajqGZ9odjE4Gf/bW
         +UO/ksjjzxXJ4p0yN3CEXbXypfdZFU0lkJwGgkrMwgTUN4k7CKvbQ04XZUXgUBTgqiGO
         p2d8Xcs3nrZrmnLEfYB6HeFiEAW92uerdFenbYBfknATti5DMkcpodeS2stCt+CtGK1a
         auXGtpYaPYWEK4P43+2XYpT7cStOpZSwi61OoxRZQ6dHBX07gQtvxqoLhwDaoBRcTybJ
         jpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698595125; x=1699199925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e6k9aLofPBwqtOZrl9eOkhzMIksyEAGsMT8mwHRyZM=;
        b=FZ1MzQDbK3a55dkGqCOcsGa8EetZk9+5ou9BLZmE/yKVPNj2+eY2v3A0aRTsiJ4WOg
         SZ8t/ebQtA1bPRXCaka/c1ujdaYH5k+IqU1fQIsUc69wW0qxzfyFmgeOZiNt1rM2ksyT
         VdBa+x78st/dsGPJAbSXL3h3sdicIYu6y/iAjC+6/HewTK5CBSvyDJ41OMpn11WJ/+Uo
         eUk5y0a+1ZduTC1UVN9jm3ZxvRUKAOt6ReJwOkb/hgxkeznz3V4YjRVCjLEdDkOUEKOD
         37Dc/pCKqMrlDfH5BJpWVzZalli7/12v/L6W4ph78Nv3lpERaFL16nVi1vBkgMxdq5y6
         KoIg==
X-Gm-Message-State: AOJu0YzSwgNUNI418rfYl0y2v+AMkN+38xVinuB01BL9Gj6Vnwr3bDyd
        //PnQKCmJCcAysom2u3v8yPyw3f0IhjpCA==
X-Google-Smtp-Source: AGHT+IGdwy7SYuF6/s1PQPTMV/8CnnApzRpnqRmzo6LOWmpIsBoiqW0De7bNFLzKpreJ56RvnOLJoQ==
X-Received: by 2002:a05:6512:1150:b0:503:26b0:e126 with SMTP id m16-20020a056512115000b0050326b0e126mr7221754lfg.59.1698595124842;
        Sun, 29 Oct 2023 08:58:44 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b0032d8eecf901sm6231180wrd.3.2023.10.29.08.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 08:58:44 -0700 (PDT)
Message-ID: <576a2923-1705-48e8-81b9-f53a43c2b6f7@gmail.com>
Date:   Sun, 29 Oct 2023 16:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        leonard.anderweit@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow USB and MPS Flow
To:     Guenter Roeck <linux@roeck-us.net>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
 <20231016083559.139341-3-savicaleksa83@gmail.com>
 <c08d04b4-8e6d-4221-93f1-cf5fff8c54c4@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <c08d04b4-8e6d-4221-93f1-cf5fff8c54c4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-28 18:24:38 GMT+02:00, Guenter Roeck wrote:
> 
> Applied.
> 
> Thanks,
> Guenter
> 

Thanks. Maybe I'm missing something, why is the first patch
from the series not applied as well?

Aleksa
