Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F767904F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjIBETz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbjIBETw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:19:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614B1713;
        Fri,  1 Sep 2023 21:19:45 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bc886d1504so2147924a34.0;
        Fri, 01 Sep 2023 21:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628385; x=1694233185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7S0xH93J57bQbZ8gK0TSumtLZ9W10T+zU+7G1px/6U=;
        b=WaAIgDUNwMNBaXsgVtumCwb0B28OEYodu15S/VSBuP5t959ANBKf+Q0MLrBXcuzszN
         qtfPiGBNyGaMdvND6+jb41/Bx09Scn7M2VeOcxr/qEvozLja94iQ4yOUQHEpbz710v4a
         ScCEw5qd5CoGicGp+tgiCwjDtTVcnJ31OWdc9s/75OKCoi0S4vYb4B3d08H69JN/dhMG
         A42bvY31ZLwL73a5VdJLiSqLXFGZ1kr4Y6/FhMRIoWgTaRnw+LE+t625FExMkjwUhKlF
         IOrvFFogCvaYWb6eevOo2Bf5dUbscOOih4VSgBrYJEQvc2zxe+LybA0VZWSrffPvJjKE
         nqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628385; x=1694233185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7S0xH93J57bQbZ8gK0TSumtLZ9W10T+zU+7G1px/6U=;
        b=R8Xjwy0Gs9g8Ydml844rdK7sACQyyG7Mq4uQ9JkARJYzVSocQTu2TyUN9CjgvgRHYT
         bCtq3RGuMxgGygUzMxPSOX8EnEFPAL7AAW6ikO3eQNCRgFmMsMRmsQy9Fe6IJbIw0b7t
         ksOMxWWAwm1MTVN0zjLMCm18dT99IlhB8RlYnLSnqP/Yhv9y/Pg6kjKIvYShzjWJqRrN
         TObV4FZL09/IBlXIGJDY7c4+Mn9jgVG0r+OavWhfB7xVq6fk6iRjtby9clQoKhpzHmdl
         ovsJ4hI4E0SUknRdCMrAY3ni1YwAb4KpGcobw2JDyg3ZyeFV3KqdWNYgqQ6vwekjE/V4
         pC6A==
X-Gm-Message-State: AOJu0YzL3Ik8zQsFD/JIOnJNUILaNnljzhA3JvYx7+rcr12agYFcYuA4
        5ZFRjWdVJH2xckowJ2vKn60=
X-Google-Smtp-Source: AGHT+IE6GEQeoD25ayJeJNpJ2QZRre+vb/LDAWRd93Fydu+XeEcy0TpMJhgb1K8nCKQnBJ6qN0vefQ==
X-Received: by 2002:a05:6870:2185:b0:1bb:8d8f:9c6e with SMTP id l5-20020a056870218500b001bb8d8f9c6emr5169632oae.10.1693628385188;
        Fri, 01 Sep 2023 21:19:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a02cf89000000b0042b3bf0baacsm1517014jar.138.2023.09.01.21.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:19:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:19:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Message-ID: <dfd8aa56-dce0-4634-ab3c-93aefc4efd3e@roeck-us.net>
References: <20230831111127.667900990@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:11:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
