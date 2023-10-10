Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7327C034B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjJJSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjJJSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:20:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E553594;
        Tue, 10 Oct 2023 11:20:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565334377d0so4773537a12.2;
        Tue, 10 Oct 2023 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962008; x=1697566808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smsRCyRCvXDTTbB7Xek8Z5l9YJAauh0DpQh3KeeOdV8=;
        b=CiO90/yJuK8tkFaalVy90eVqo44Uiu4ovkbB9YhJbilYg5rZFk14A0fY5xC3pOyA6d
         JNducYD7JKL5Oh8pOEZoPUrgM2QHFVljYakCMnnkxXHuHCzZR556//H9XE8gJEtyhBB5
         39GcYQJi+Mnez04Cy/1OW+I2JVIpT5V0mHNzJMNJfMZ9tSBAfE2rSBG9QkTAOxBN7ZSj
         CwC7j+UuQm81EUdMETyfbXz7+5KdUg4+aOy875kqt7rIvcgrUgeU9yB8qozE+TdC9RzC
         YHBs0hoqWJgDGEq3lFMsgNE17zOWDxFLjZrh3Lal1+CzvwcV1b9KuWhyDtyM4g8zS4IJ
         zEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962008; x=1697566808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smsRCyRCvXDTTbB7Xek8Z5l9YJAauh0DpQh3KeeOdV8=;
        b=BRPQaSEAc/6jMYLfLdXc/5qGUAp6SXYdb7JaYGUAsVhMpwaQ1SUvYZtUhrlHlOFJDC
         RdoH/XU5hhzspJC2XVQASUiGq/27PK1Yy+FNYzaAkZXDSxmZdkvUgAlhbeMOJ7fszcsy
         2KWiWTdm64BRNfae3Tr2GpwSisNeDu/5kZjTJ622DQy7w3tEo8E7lfo2m47uA5NwUE4M
         FitK5cNWsiVF4Tt4oyEPfPEw44VqqlWo5m5i6s7nCiWf5+uWnj6/PHFmqHoAxgvlRTHe
         9OIXHgqT4necLcrpK9qrtNzC87w+h1M0vWpLxtHEc2UbdRKUDuqgMgozdEqOKbWY0t7G
         8T9g==
X-Gm-Message-State: AOJu0Yxhzqr06kAw5dkKHvNhgHOQCuJno2S3BoZniW1LsZKKzT0G2r+f
        wvk7VP3HVupKbtEySYyQaSg=
X-Google-Smtp-Source: AGHT+IGh1x2CPH7S/waClFkhgK9zDhkdiRYbjaGzdtO3+gGPXg36ynxjHksPjf2t9KZb+ppalXibMA==
X-Received: by 2002:a17:90a:1196:b0:262:f449:4497 with SMTP id e22-20020a17090a119600b00262f4494497mr17124879pja.2.1696962008223;
        Tue, 10 Oct 2023 11:20:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001c444f185b4sm12123162plg.237.2023.10.10.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:20:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:20:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
Message-ID: <f72be808-de46-44f5-aad2-866104a56f5d@roeck-us.net>
References: <20231009130124.021290599@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:59:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
