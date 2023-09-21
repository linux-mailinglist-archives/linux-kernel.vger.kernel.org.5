Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD17A96FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjIURK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIURJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8A6EAD;
        Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3aca0934e74so692367b6e.0;
        Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315911; x=1695920711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjTezTynTvqJlvf69zSKAa6dTWaidBbob/xaqQEVHUE=;
        b=CxnIEGkGbioJkg1ejx4aUfosi1wB2MFlShyPu+xG2Ls0tNw0Mh3UIt338ds/yOwxp3
         RRrj0AkKpEYOpI0MN4Y7utxohy706Yl72yRGDO3dIWPoCINuWxktJfwoSwSYS0Wmbfk1
         lxu491W4ZSpumBfbawjCOeo/1o7UXzMsRKKGnlf5/bnxKVxoLS2Hsbf37UNywzdTFuXn
         kB2dRRG56z9tPrNZrMe5D6IbMqUbvZK1ODZXYk1n90LnUkcmcLtaQ4pd2Z51rZuEwiBB
         xiTac8ruGQ6cde8rRuCt35mkN70lIocnR05DAt3CvB5Fnv96UX7OXvW3+9Drge5pn7WT
         uNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315911; x=1695920711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjTezTynTvqJlvf69zSKAa6dTWaidBbob/xaqQEVHUE=;
        b=RrCV/G1ZbBujMPlqBWqkC0Nk3Oya2V4xp39+Bs6EGWc3bV2O8vin4bOI1PbKaj4HF3
         a20Qtrd1rMOE/u9/QX2iw83B1XPMziiW5UqKW81Jyzv4qHuZxn3HHSh8iIMCz++vjS81
         ipeadZ/uUvfQH/XPLMdRXgEffEgQf08Tdu1tTDv6+u49pKiP0h1R+SWXZK8DWEDeOH9U
         wuxVfWSVXNS56J5rhaPQxBFRqOXF5yUC3PPKvUEMBzwaQ64v1HJLsKehm/oRydMdB1S0
         D5IepQtuKzSRjjhq+Hkn4vxToGAtlLPSzvhh7Z0ktR77JyiKiQjTYjaJlhgBNBG9Ax6l
         QfNw==
X-Gm-Message-State: AOJu0YyYNaWb/IsJgX4b2ziqjyiiATd9+42Kzohvd0GvzABuxbnTTnCz
        meFepydH5JCbxH7vaBZdADN8tikccnw=
X-Google-Smtp-Source: AGHT+IEpYwsuhBNIwJEQqvsb//9rTopvYqrIvT5z0atK2g87iYx/Y8K7JfQni2Qb84qM7j9BUqJf6g==
X-Received: by 2002:a05:6e02:16c8:b0:34f:525d:198 with SMTP id 8-20020a056e0216c800b0034f525d0198mr7618097ilx.13.1695311631254;
        Thu, 21 Sep 2023 08:53:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9-20020a02a609000000b0042b279bb086sm450069jam.66.2023.09.21.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:53:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 08:53:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
Message-ID: <c090d70e-ed2a-46e4-ac92-217fddbe07fc@roeck-us.net>
References: <20230920112846.440597133@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:27:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 147 fail: 2
Failed builds:
	arm:allmodconfig
	arm:imx_v6_v7_defconfig
Qemu test results:
	total: 441 pass: 434 fail: 7
Failed tests:
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net=nic:net=nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:mem256:net=nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=nic:imx7d-sdb:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:sd:mem256:net=nic:imx7d-sdb:ext2

drivers/pci/controller/dwc/pci-imx6.c:645:10: error: 'const struct dw_pcie_host_ops' has no member named 'host_deinit'
drivers/pci/controller/dwc/pci-imx6.c:645:24: error: 'imx6_pcie_host_exit' undeclared here

Guenter
