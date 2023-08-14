Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79177BFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjHNS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHNS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:28:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE59B0;
        Mon, 14 Aug 2023 11:28:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-349a94f3d69so5011885ab.1;
        Mon, 14 Aug 2023 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037680; x=1692642480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3DxKgyMPcstTEDb6kptBJFKn5Z00KFtFcxXmcD+73I=;
        b=nMdPmZYrbtvtPE3iOGZWMEg7p0sk0N7JpBqByKZ9qgjpxjtoTnbyxA3TILCYEpQoJG
         i2Ds+cc0nqOuHoIMu/FCenV6GQlQAwtffHNl3GxFmE7MBTbgalWFzD98G877l9SdYOxX
         L4sxfl4HhdMxrfMrjncD8ILidQDVJWqOoIDkROsiKRgW0IYkRJz8zTm4jZkNvg48fCt+
         yJgyXteWEYJUuLHl8gAoj7yxgWjzZhwOXFf3n9QHVmxYvd5Qfu+P7EaOi2dptEHdFgET
         l8XUtXht6sW8tMxEHJ1H9T303gcxKimZs4kEfchZe3JTayOryXM8HT/C+nd30NR9EHyE
         rWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037680; x=1692642480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3DxKgyMPcstTEDb6kptBJFKn5Z00KFtFcxXmcD+73I=;
        b=b3jONZJefty/Vw7ji1OJsxIakEbK9VG+DoTV5Cq/CXI3xO1jsgk0Rs0GE+DLvUGrXz
         6sl3b0FdTLd30JX3uyiOwoBLWlJa+jeGhr5eH7g+NhOGVGc3dAQDlqxr+b10WLDGqXXY
         mHTQ5XV7hR69kKzjY4paYR9skj5AEsfEvwCAureFi0BS0LH6XM/cESp94XGyJaiU4M9w
         FEKm0hvsoFvcjofClqvbQJiSc9hCAWSxbeoGF3+bmWGM2csc2yK55p29uH6wb79n5nhs
         3WYydMMEc4kUNNiWqvJ8XyAT4zuv4PAuyqfEspPsaRSybqgs3Kt4UIeFrJqh1IlLetIh
         UzcA==
X-Gm-Message-State: AOJu0YyAHK4xT/bRaRQbH3c7ksnBJlnolTFfYe2kAEzj6Wt5FK8dgYZz
        ldNgZZq/n3A4iafzWCsAIJc=
X-Google-Smtp-Source: AGHT+IGNryW0eIkWw87ANhGb6gc9oozzk2/nwTcxGMbXlErQcDcdizkelmlipMA/QM/0vM6oWPzaxw==
X-Received: by 2002:a05:6e02:1c8e:b0:345:873d:1102 with SMTP id w14-20020a056e021c8e00b00345873d1102mr14981905ill.15.1692037680710;
        Mon, 14 Aug 2023 11:28:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6-20020a02b686000000b0041627abe120sm3174115jam.160.2023.08.14.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:28:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:27:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
Message-ID: <8d11ca33-1924-4017-b2a2-40c872f067f4@roeck-us.net>
References: <20230813211724.969019629@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:16:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
