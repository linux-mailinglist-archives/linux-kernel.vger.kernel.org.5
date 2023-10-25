Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8C7D6F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJYOJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjJYOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7418D;
        Wed, 25 Oct 2023 07:09:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso4894907b3a.1;
        Wed, 25 Oct 2023 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242984; x=1698847784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZyZ4g/1PidbZAEIU8dmzbg7m3vGYmT3TgIEM6NuO+g=;
        b=KYIV4+OnckTGJPKutn8F3cf2WuBYWTQStkuJmQGnUoo5F4lC2Pbmm7iKuswXuC1Qvb
         DzqfNCQfLWtClEquQRliRVlPPoUHXd2QXofpZ+i2hTzp0tIWAaQ9t/VLcaPopgvqApzh
         Wg/f6DBzvhd2yUj2BY4/BosMCaLwO1ol1FhVLiPui2pQNdbh9Sq3cFA1pxu6ezV4duBK
         AqSpH044VG3uSLSkgWT597U3Pjr0bKrC1jZJ+0OQvI5BDnsyHO67FdMs0bJ6QDu4JtBh
         9Tmu4eagNK0soPwhlKg4rskUm7ZnAW74CCH8m7Ugy+l6RJYpslUZvgniSjbZ7Rhc7R4j
         4QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242984; x=1698847784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZyZ4g/1PidbZAEIU8dmzbg7m3vGYmT3TgIEM6NuO+g=;
        b=vR9n3SLohwM23FmGpXat+5yO0hDmjUgN0aRQ3/4xoFz41dUFBKbor08KAGUMjSMulx
         AjZfBGO0fWD5OnhnSSAwyKodbu3jY+ywTq2JXRQTa0wPfO434Ti0u2j+5fwj9PtVOxa7
         WSkPC1xgsVGsQTiMoCCg6mR9LuZxjvqCq0xJOnr0lAebbnx5bg2/iSuMXuCO9gMW1ROf
         juA270MrtHWrIuyMbJ+00PitYcCBARTdScw7nzMvYCNPUXlSviCGIQccRXHXqpHdrHh2
         n3E2obDtrvBQDSi2uLHuaEW/6Zdveps8EJawOjLrZ9f9rxhY/yOkEWnmGjdwQNsEnGsU
         m+Ag==
X-Gm-Message-State: AOJu0Yyvxph8fxlmi1N5M4AMl517nqt/RXhHeG3RRf0g/uIcZ6/8UIvt
        1/+UikwFDnfQ4lIEJEOk3gEyv6NrMqI=
X-Google-Smtp-Source: AGHT+IEpOW2en+mqWlt1dAVxt2QPuBr79SMNK2Jco9lDoJRmo9LD28OU1Umyzqtm3MLQraWraTo3zg==
X-Received: by 2002:a05:6a20:914a:b0:14d:e075:fc5d with SMTP id x10-20020a056a20914a00b0014de075fc5dmr6207564pzc.40.1698242983825;
        Wed, 25 Oct 2023 07:09:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8685264pgp.11.2023.10.25.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:09:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 07:09:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/120] 5.4.259-rc2 review
Message-ID: <3d29d9c9-fa72-46d8-be8a-280e621815de@roeck-us.net>
References: <20231024083306.700855687@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083306.700855687@linuxfoundation.org>
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

On Tue, Oct 24, 2023 at 10:36:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:40 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
