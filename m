Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F27A95EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjIUQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIUQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252A19A2;
        Thu, 21 Sep 2023 09:58:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41214998fc2so6984271cf.0;
        Thu, 21 Sep 2023 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315492; x=1695920292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSYSW2qFhPqn5+qIPFrNbOjRh2C16Pv4b0nfPD6viEE=;
        b=dtdTy/CTiaYM7pWAd4OlQ2KsxC+Csu4Crt3jcHU908miiJJ031K/p8frMB76DhxwDH
         evi4BQD7r5za+BD243qhD/Ky2NDt9ePOZS9iSti3242L8ry+0f+eOP/eUMfflOXcinGG
         Re3JGhWV0ui1daYXQ2xDcLNKhAHanID9BhRZsOd174Kf2hkcHQSf9z4A2/SH5AI4cTO0
         DfCaTPyYS8tsRlK8fWb0SOprMXFFJB0qjZdMFzZgRwBq1J5ICaKC0LxI/X4N2q9pe4ZR
         4yIO6S4cYv+BUa91+O/4GvhY1Aq9N9DhYYKmmfPsrLvyLSl4MIG5DZSPulDJVicguAyJ
         JWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315492; x=1695920292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSYSW2qFhPqn5+qIPFrNbOjRh2C16Pv4b0nfPD6viEE=;
        b=lJXBZnveA4t5U/I7VfAtzvjPVgyNwWiobZfbvU4nQ7Se0bXdomiC+T5bbZideMNgJp
         WpKzdbLFUWUvoVlf/FUE/ygkZqqSS6fmppxMgOzwuPVom3tZTi47qGzPAXXABIaoeYvb
         J/EP1RDFlEkxp4EsTAGdd9gIifOidpSXByqFUP3bLkGyEdAcZtk1TcY6ibKbHZxPGPQP
         3piE9qfCdz9XQNBlviNPxkC/3tkGU/w5gyTvdx5Gjg02R8Rh3ylW8RMdm95XugGKHPsp
         nIdYccv+DF0RAvtGrL6a8scZ1t1UbMcwEJFqvcCSDdt505fRym2OTeF3MhVC6Uhvlcxr
         /oWA==
X-Gm-Message-State: AOJu0YxNXMPf1auZtxQhgpn/Ms58Gedv7VLqcAdhP4nyYJN2DO9PyzYr
        j1ROFz9+je42ZQHTp9Pnnw3f1dSKxIQ=
X-Google-Smtp-Source: AGHT+IGUC/NwymIeM7tgGfAVay0XJcI/uXhc6rnS05JwOhzLY7q8Ynum+iAmHSi90rAnZspB8ioraw==
X-Received: by 2002:a6b:ec0b:0:b0:792:9333:2cbf with SMTP id c11-20020a6bec0b000000b0079293332cbfmr6309253ioh.6.1695311968868;
        Thu, 21 Sep 2023 08:59:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l17-20020a02cd91000000b0042b2f0b77aasm440766jap.95.2023.09.21.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:59:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 08:59:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
Message-ID: <2ab51081-698f-4556-b673-cc0b62b0ace5@roeck-us.net>
References: <20230920112826.634178162@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
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

On Wed, Sep 20, 2023 at 01:30:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 157 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 495 pass: 495 fail: 0

gcc-10: fatal error: no input files
compilation terminated.

The error is due to commit 653fc524e350 ("perf build: Update build rule
for generated files") which uses PMU_EVENTS_C without introducing it.

Guenter
