Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420D770F62
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHEK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHEK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:56:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4B10CF;
        Sat,  5 Aug 2023 03:56:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc411e9d17so18023515ad.0;
        Sat, 05 Aug 2023 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691233000; x=1691837800;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFJpgeqguFqka9/XNIH0k8DX9+9PRkRkOApZBqWdHSw=;
        b=Pi7EoI8f6yxpZ+nqdR9tGlh7642zR+q66btl2XVSm1IVM9bGh0u3PCEXVnp9+pzo5M
         poxsh3MEpOKkRgJmrTG0BGU313s4jROY0DJukvrzl+1cEB7mrkMExZC3nGM5qIq26YJt
         llv7q4l9Vf4kQf0es79t+ttWEavUJ/cU4jpACoWJ+OsUVVOfTJZFwEDS0M+ZdKVaX7Sb
         zjzr4B1lkwrPSVA/dqwNWAh5Qs5oojKENp39LwlAk72jRL6yGViytadCgia9CJVw72kR
         EAXL7AlOrxvA4O374MCK3uQfEhb8TL62M76y+ILffGs0/x2n4hFmt+1LPZLFxv1qHQcW
         NDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691233000; x=1691837800;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VFJpgeqguFqka9/XNIH0k8DX9+9PRkRkOApZBqWdHSw=;
        b=RfJXup5P25xL427DPci+gO5kMlrwmAk72TE4PkJrykGG+f8pohG+0vnE1Ni/js3fai
         oNb12nW8tS7TyXBu4EGFa5mbbC9L7FqqeEWUqxZsvAx8AvNCoSyrIGbOR/hBhamjXMIy
         zCb5IQqPA2HA0c6I3vKaeOf0OSNOD325+kxd+4aDmpvFNbgPQKDSqsonbyz/EYe9xm09
         6uRpMTeKXcOrZRM+daJ+EzmUl9OHd5vECsYg/fGu9Q2YqvjwwQI2QB1fhkOcNJLQq/3X
         ORABwgcQPBeVDKRno12HLoV9mBUZIIXuOkCN2Yzg6GQgpEWRV9oZkv//wazGNgsPM694
         A99Q==
X-Gm-Message-State: AOJu0Yw6xD/fPAASg3lQz1WVQcLimiz6d6RiVkgRaEPghr8kBTQicvTu
        Zj32TQdu2JJxZvKtFC6p3/4=
X-Google-Smtp-Source: AGHT+IEUUk9pvqK6JFBe+/bMlNaS9W+khY1xitY4wrZUGvzgl63VtGY9dhA2nx1hpoccnnlvy24txQ==
X-Received: by 2002:a17:903:2350:b0:1bc:3504:de35 with SMTP id c16-20020a170903235000b001bc3504de35mr5240302plh.62.1691233000072;
        Sat, 05 Aug 2023 03:56:40 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm3251908plb.93.2023.08.05.03.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 03:56:39 -0700 (PDT)
Message-ID: <b3a2cae2-a514-a171-2671-7b811ce4d833@gmail.com>
Date:   Sat, 5 Aug 2023 17:56:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        gnap <garbage_accnt@outlook.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        ACPI Asus <acpi4asus-user@lists.sourceforge.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: keyboard not working Asus Expertbook B2502CVA
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

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hi everynoe,
> 
> Component: Asus Expertbook B2502CVA
> OS: Ubuntu 22.04.2 LTS
> 
> I am having a keyboard issue after installing Ubuntu 22.04 LTS on my Asus ExpertBook B2502CVA, I discovered that the built-in keyboard is not functioning. The keyboard works perfectly under Windows 11, which leads me to reasonably suspect a hardware compatibility issue with Linux. 
> 
> I found that BUG 216158, Bug 216864, Bug 217323 has similarities to my situation, attachment is my dmesg.

See Bugzilla for the full thread and attached logs (dmesg, dmidecode,
lsmod, and xinput outputs).

AFAIK, this looks like hardware support for Asus B2502CVA is missing
(maybe the quirk?). The reporter also confirms that this bug is
also present on current mainline kernel.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217760

-- 
An old man doll... just what I always wanted! - Clara
