Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19907E48CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbjKGSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjKGSxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:53:48 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719399;
        Tue,  7 Nov 2023 10:53:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc7077d34aso45849735ad.2;
        Tue, 07 Nov 2023 10:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383225; x=1699988025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syzcffRnbgK/9IE6uDHer/p4B7FlvUHvz9oRSKSYO6I=;
        b=XkNyH9RKHGzhhnIHn6uZ+C2zzz0qbTnHMKRIMFrmahMYUXqaFYz3c8ohqvu8WOD5wp
         Z7xY6jen1kYQDizRkeT6iGGik65PTROp4/Gffjzmz1byjpULeaOrjvvy2Eqo7UlPqeMJ
         zrxnxl4bIjVTdKUaMZLh5a93rL1Kmi+G4XHz0OBdcIA6ZxycHDWC1ZPyK0yCQl8swEBM
         L+0G2/zYeQ1StkVBtTe2YVMROGiC+2v5vRF9162fXb/kLT2Ptzx8FtO6dD7zlWDWKMNX
         cISDZXfO7+wDKGE3YRF2/zdCK4TizWJ6Yn4Uaxh/BA+CiQx0tH2N1ARZ6LE+peRxvVUV
         Azxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383225; x=1699988025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syzcffRnbgK/9IE6uDHer/p4B7FlvUHvz9oRSKSYO6I=;
        b=AhmzyfZ5eSmkYqJpExyWpstiU9Ihm5Itt4KnddQYEQ1SCqqNm9Gy/cXrALgw1ls98l
         E4x4+NALcfQT3lELPUehaiMM5QLafaS7Gm3D3PpzXqxoH8bssetsPe+fAn/Et6P5rvJg
         MNwbfOMPm92OisKcI7yxZ133WIFhC2HV/SN+Yz0z8aO8DGFhkknSgjzo4uIw98wc53M+
         O/BltyuW8SPkLh/W2YHA+hzMnGNjR1s1OohnkyNy6Z/itzwDhxWainxdA47nYF71zbJw
         bbJ01PIo9GeuCfaBJDT8V+tb1jE7rVfw3G94aGbP3e8q+IiucX5XkrLFEAdhU1DaLLyO
         c4LA==
X-Gm-Message-State: AOJu0YwSkqmFcXNoL0S4p7/8mMILXkwdkQKlLvMwl//XUrzHZ/dfzaUv
        zfBAPR3lxeiS9bDm1FCvmxM=
X-Google-Smtp-Source: AGHT+IEOnXcPNRpTT3ez+7bKefHJz5nbyPIthHWn20mErl/BTC1B5uhYpmY9UbR4zN26ksP8uJ3GQg==
X-Received: by 2002:a17:902:c94d:b0:1cc:4e78:d10f with SMTP id i13-20020a170902c94d00b001cc4e78d10fmr26331697pla.8.1699383225461;
        Tue, 07 Nov 2023 10:53:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001c625d6ffccsm151928plh.129.2023.11.07.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:53:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:53:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
Message-ID: <86bdc3e2-3d7b-457d-89dd-f5f931d08fd4@roeck-us.net>
References: <20231106130301.687882731@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:03:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
