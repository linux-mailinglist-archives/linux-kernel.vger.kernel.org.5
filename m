Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF67EEB93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjKQEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQEKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:10:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223F1A5;
        Thu, 16 Nov 2023 20:10:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc131e52f1so20591955ad.0;
        Thu, 16 Nov 2023 20:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700194249; x=1700799049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioK9Z+g0T7j8X5f/Qosoe0HfJXCOJDxZK8IrkzbXDwI=;
        b=ePstFDTyLbHsWvTtrtJv8vDP1K/K2SfX1m5gXc36venCRLQEE9RpOWXxvZZViisV/a
         qHGNCZJyhSsGpAf1xHH1ihW4Ez9IERZOEnqegX5mqAmlFlYU2L7Q+5EtOJBA32Vv+sWP
         BE9tppluZaZ3VaJQY/k93v41luAj/6HnRNyxrGU/wnLur9WxXU0ftA+zHkBd+fn/svbc
         uAkIncxqKnHtfKv8c1KU9iR3iv0ojxpxyWKbos/zcYyj4G9U02wpCpm4yLikyw/RDo4S
         g/WzUfwd39J6Qmid0BTqDTKVJ7TFUVeW2grJmN/QYkOB/ukOtZLt35xHDLhaHWfUvDHz
         R+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700194249; x=1700799049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioK9Z+g0T7j8X5f/Qosoe0HfJXCOJDxZK8IrkzbXDwI=;
        b=UDHsOJAvXpeLcp4hNfsMIWVWNTEkAmn8NIn5P8fhDufl7mgVeJLrHE9dZmhVLCzDt1
         0miLIRPCnagM/nZrrKEUj05DMHup8NJCWRgqr7NMBmn1PwXx6r9fboSSj2jdiRHaPcgs
         O9VHRGpQw7v8D68/I8MqaZ4cHPOgQVExYMCb5jdzaJ3i3Thcwhnak1/UmpjvvoJ60VwJ
         vqGpF1j1ChqtxxMjZInNikxEn/z6qm4hXHVue5/569zg/biXjBx2lpgUuClcqNuQmiTS
         2KgUVn8XtVjCmoGoF2NfLzNgIfdJqVfJf9/HG16Ho9o1O5Bgbu3xsmmLfuCf5mCx8qqB
         Knng==
X-Gm-Message-State: AOJu0YzO/QH1HAOP9os3yMzCh6ulbG61IWYFfLYIJhKzd/j/dBXexG7J
        KYg4y9gn5prjsn+fkuRFHyw=
X-Google-Smtp-Source: AGHT+IFPMxQxpgxcza1SIflNw8Mz3NRxAN9tnlKTEBJkKgQ938ZosXPDKQNiJgFDTX/rNDgVbK5bCg==
X-Received: by 2002:a17:902:ea0b:b0:1ce:5d00:6a05 with SMTP id s11-20020a170902ea0b00b001ce5d006a05mr1049387plg.13.1700194249029;
        Thu, 16 Nov 2023 20:10:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001bf6ea340b3sm445229plb.116.2023.11.16.20.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 20:10:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 20:10:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/45] 4.14.330-rc1 review
Message-ID: <16b96c58-30dc-46d0-89a8-b86be647078c@roeck-us.net>
References: <20231115191419.641552204@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
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

On Wed, Nov 15, 2023 at 02:32:37PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.330 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
