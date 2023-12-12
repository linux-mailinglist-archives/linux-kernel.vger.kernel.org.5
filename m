Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71F80F3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjLLRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjLLRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:01:17 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AAE3;
        Tue, 12 Dec 2023 09:01:24 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb04b2251bso4286940fac.0;
        Tue, 12 Dec 2023 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400484; x=1703005284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FhVzYWda/1YKc/fSv1uyXT3s6nzoViCVsvqyIDm9fA=;
        b=J8OubeDcEctdi5EJywGw9TKq/YzNa0+myW2yxzMayTzbSccD4ijh7DQiGPuKODQ00P
         9VyuFkUZ1iUE/x+B2zARxL9qt7F8P+MdRI+8AqjUYCtP8slxETWbebHUQDDAr/auIbi2
         hMwBPbGDD0e9w74G2HkdB0IOAQtgCsESwiFFUp5srPMV7HCrSHVx53RJ16MoXsAANfuX
         qy/t1UePvcjl3ykE3Rv9evDH35daOVTKB0nm3AWD40I2Q6AYLFkkr0VtZ3U5lyxrnLBl
         LKxr8i0W7s6ERPT6L2FleDfIUTzKPjPwjZ4JXiP7xMIZd3HNeY7ItBpaxpc9mE6HL3G5
         cREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400484; x=1703005284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FhVzYWda/1YKc/fSv1uyXT3s6nzoViCVsvqyIDm9fA=;
        b=lYZ7RQehi6K/qwrn6QLIv6qHVsxI8DZM42Eu0ZIpW5HdWHKSPH8bcktyBct4EPAHGv
         NdurcoKEVSB5RXEzcnavy7HzdxnlWEXyPDCLm64edmijMgeoVtPHHD4CEv6AhJOkGaQT
         r1EpYV5h+M6PV7vArEbRCRXtV+4grE3eLDeBxvdYf6YncgwWL1ZSQZ/uAirJKQ24Lmfo
         jP+XT87YSXeXfhMPUZNHBEpYFyBikWrcKxkAJRHhHgGF/9xWO5CE0vkhJSmqmkmC24kK
         xL9SQWhgTbQPKHX0WakMDJbE0sL9dqr02Z1W48OnNWUbJLTpL5sBCDeF0Xg4bD0skSOP
         XWew==
X-Gm-Message-State: AOJu0YwCf7eS9tFwrpnKwO5ZS3RejGCJ+fxXwAnEn+FhE1Dlghrl/8HV
        O21AN7FQT138+XQi9S6zI7c=
X-Google-Smtp-Source: AGHT+IFGQtN+ItUbfxXhZIMFm4LB9DC+KDHLOiUSUrfESB+fKdBZbBDRdNSBSqdGz8U2dG6mdmvS1g==
X-Received: by 2002:a05:6870:700a:b0:1fb:75a:de58 with SMTP id u10-20020a056870700a00b001fb075ade58mr7982583oae.70.1702400483727;
        Tue, 12 Dec 2023 09:01:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k29-20020a05687022dd00b001fb0edac63csm3267075oaf.6.2023.12.12.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:01:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 09:01:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
Message-ID: <687d692f-389d-4990-b678-7486c6b7ff4a@roeck-us.net>
References: <20231211182019.802717483@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:21:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
