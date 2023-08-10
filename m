Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E8777D05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjHJQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHJQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BBE7F;
        Thu, 10 Aug 2023 09:00:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc6624623cso9486305ad.3;
        Thu, 10 Aug 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683205; x=1692288005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G928jvuclRXDZupTtetoPT/Moc7+e1us2BioE+DjLBM=;
        b=n+PK9qOVs9lBcvUQ/dhgzFNt+7GnmnESe96MAz6jHORQwEyfSlkLHxcjFd9sRwKdo4
         tGyA1r6hMO2/ARKXIBDr+9ovXNKlDWrM0uJqeDN/3W4o8oIa78ZWuTE2n8Z/M+gi9G4C
         WAyXpfYyjUzoBbQKjn+la1eFqCLV9e3vdlQmwyK+c94Pgz5hjS/zc4CdfqYS/N0y+6gi
         ziIQh4CqvSRBxk8aflTpau6E9vCAnCDIVweWeM1gVxrOwR4IVWzymkIwtlPd60DxCYlQ
         b7Hw9b0DfVayvhz8MpzanZALeXk778zyqGcUUfWRpvDF70RFv6n/2sRURnibHwVS1059
         Hapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683205; x=1692288005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G928jvuclRXDZupTtetoPT/Moc7+e1us2BioE+DjLBM=;
        b=NTnOjlADe154ju9Kel7xxtnxTNeeW6ZuS3L0aF8TkS/1lp6plHcJjm5HPmSU9qHSiJ
         QmaUQNGlZ85X9HvQtkMW4QFoExj3zwCQrpcGLeDy802X4OwjK+3zLyO8dDPfa+pSda7k
         CRuwtb7PPRfFWzYD/P6AtegoEXheSTF5uvJ/n/Xrtq1VXtWWOuukmCYHTVi7B87hO52Z
         tP+va/euMXW9LfYNqWPqFVopXEFnK0aYe0F0faBlLGDviSRdudFwaDCJvgmKELvFAbJI
         bS7px33zZeIiyh1p4HIi1J09vnP4lI7FKgj0lM4dZWhEl0aFpdhDXl/0I1vfxXYVuYz6
         02Fg==
X-Gm-Message-State: AOJu0Yw6zie4ZyykWanUNZP9HVtzrEnGWHeplFVAypNdZe4ccQvt73Vc
        7zM1elNUm78ZPK9lFAfvFGs=
X-Google-Smtp-Source: AGHT+IHYLFAONf/6oh/AOcIBb1IOqaLkls5eebXFRPEuQD2bQqIE8QhL0AAhEz9rc3Azmzi8XjskrQ==
X-Received: by 2002:a17:902:ea02:b0:1bc:671d:6d28 with SMTP id s2-20020a170902ea0200b001bc671d6d28mr3884437plg.10.1691683205313;
        Thu, 10 Aug 2023 09:00:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001b891259eddsm1942500plh.197.2023.08.10.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:00:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:00:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 000/204] 4.14.322-rc1 review
Message-ID: <a4b27b78-5f96-4b51-82ff-77b5c648e74b@roeck-us.net>
References: <20230809103642.552405807@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
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

On Wed, Aug 09, 2023 at 12:38:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.322 release.  There
> are 204 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.  Anything
> received after that time might be too late.
> 

Build results:
	total: 159 pass: 157 fail: 2
Failed builds:
	sparc64:allnoconfig
	sparc64:tinyconfig
Qemu test results:
	total: 431 pass: 429 fail: 2
Failed tests:
	sparc64:sun4u:nodebug:nosmp:ata:net,e1000:hd
	sparc64:sun4v:nodebug:nosmp:ata:net,pcnet:hd

All errors as already reported, introduced with 4.14.321 which
wasn't tested. The errors are seen in nosmp builds.

Guenter
