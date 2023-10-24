Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1797D5A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjJXSM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbjJXSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:12:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC410DC;
        Tue, 24 Oct 2023 11:12:23 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c7262d5eso49217577b3.1;
        Tue, 24 Oct 2023 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698171142; x=1698775942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3EYlEUXN/TtJ8i/q/rreox/HAhcUMuzowMifNS8GMc=;
        b=PZeMIXTGCQAsiMdUocr01G9sueyIrXDHTeANjs9cFU6bxTz/gKTBlyfLdL6XvwrpxE
         PYBlmgMoUwxUQMzLviveiBPWXvxfLAhnwBzrjbRLcHOMC6toJYYAij9+Y+4XDP09xLg/
         gcUfqJG/zEOlnMZH32u/jpyXvx8t5IKt05dfL5+padiIhleqHAZPDbB55SNRhC+gAxXf
         meIYJ/pYdulW+t5JVCl6wjq65xR0saiG8StbnlqbKGxhSuRuP0IzORUijmlXGPyOaLbn
         urEbpcz15vWbR6KB+b7lywGmK1BVv8EkZQIiXzfoK2frvQZnCO232W3XjOl8Co7RForE
         9L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171142; x=1698775942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3EYlEUXN/TtJ8i/q/rreox/HAhcUMuzowMifNS8GMc=;
        b=WHNwb5jEgzynM2bJ4MJwCkA7pQOUVOco+cy0OScaBvf1xzb/iYC30uVtRlDYciZLij
         Gtw7yjZrSTcXFAAdn8z+v9rb9ozRXateYDlkEhfCWPxrs1F3dLQQV7rpBvk9ZuMra0SA
         Z36hzQWnH+VKHt7cBuIkCv8gXaSW6nfI1YK6L1gNbLioegg/BCtllcWxWPsgddEJpL/m
         wIeKBpjRwYPrkkZkPFFjdzkVQuRGW855yn8FoXqOlsFrPwCSxnXqyIRhf8aVgSAwBtN/
         vb0D/bww+8oIurMgI2E2sGtkvwySG9l80EmgC6EVJh8jmCY7xZ6yYdIJXjdnOLs39qTh
         V1Fw==
X-Gm-Message-State: AOJu0YzrhWVNhKKsu2kAg6bOko2b8JiN8szZZwHv7Zli/6WoQLNWETUz
        VAPevyIHIq323Upj1quignU=
X-Google-Smtp-Source: AGHT+IGOfSgpOJ9UZkmStpd+Lyqgg4laPuyKw/q+P0QvkoKNB+/BPcz58iI8PlfdndlRRhfF14/lZA==
X-Received: by 2002:a81:8415:0:b0:5a7:dad7:61dd with SMTP id u21-20020a818415000000b005a7dad761ddmr14071882ywf.20.1698171142163;
        Tue, 24 Oct 2023 11:12:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o188-20020a8173c5000000b005a7dd6b7eefsm4245315ywc.66.2023.10.24.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:12:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Oct 2023 11:12:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Message-ID: <458d7cf1-3e6d-467a-be84-5053f730533c@roeck-us.net>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:53:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
