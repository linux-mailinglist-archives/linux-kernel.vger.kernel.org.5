Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F183805B83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjLEQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjLEQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:50:10 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F780197;
        Tue,  5 Dec 2023 08:50:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d8481094f9so3522839a34.3;
        Tue, 05 Dec 2023 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701795015; x=1702399815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duhFd6gUglDph6GOTzZ0Ncrj+fI8X84602btwhxZmyA=;
        b=KI91JGUIQrjI3hR3dq6fg1AZYUBYsVU9aOGREzKGMR1zmKfEnv+2lddusVqMbqSJh5
         9qC7KDC3Saz2ghEWC0xdq/wc8D9C+cSdaYUSWJi3N9D9BTt2SICz98WxtRvp6sIJVQYL
         fLtlupCZbeY3m/MybxdJ4lvlJfT3dkuwUDtdofTokSaJzd9ifUJRfM8aLqnovAQs1dSr
         lQKyr8fhJT5Qmdbmkh6doOK37HJ7+FQbLXfexE3xApBYG74YuMK5GEmXhFlljhWBDIWh
         CHSXPCtOQOBFjEMw86aKTfN6Z813fsF6RBhA8by27DKiwXiy3uevyBoYZsT9kQ5VY/5H
         elqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795015; x=1702399815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duhFd6gUglDph6GOTzZ0Ncrj+fI8X84602btwhxZmyA=;
        b=CjW6oioi+z1fdHAF7NGfLiFwSYvpvoSpUD3GvVvea8kzRSUU4EDAAwvc0wYKGwKDlF
         CQS0Z/QKcsUcK5Ev2yWJXfS7Jeb/Mm06hLf0bOt7epnDy6xWVri4MleEALtHNZOxojKQ
         IY6pKMm4TfzDRMtT6udQjKjkko8rYsjTaASkU9xOZ9Ry0d4O02Q7/cs8PubQwJAUXKzX
         ZMVSVRLRN6Xk1W6MqgmPJs2cvb1tlmFUoqBL1wTRaJxpWrKMDEgUOiBAg7JAN0G+21pY
         615/iLSUU33auPLACOCsJ0f850ACRx9qny4bdIrUsBRzFEz4ERUznGMejptcny0SFn9C
         JBRw==
X-Gm-Message-State: AOJu0YyXO95UKKlQTN5G1Oz5y/ENFgmEiDZQsuZadyryDpS6R+wkV+JD
        dLI8PafqiUTGdr4qxH2MIRM=
X-Google-Smtp-Source: AGHT+IHx117Oe/EFLi2x1dEEecTCdGQpyVoMB4qRs2AFafHoFU/s2HAL6C3tUrXXUAqyYHKxxditJg==
X-Received: by 2002:a05:6870:ac92:b0:1fb:75a:de5f with SMTP id ns18-20020a056870ac9200b001fb075ade5fmr8680210oab.77.1701795014934;
        Tue, 05 Dec 2023 08:50:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id on7-20020a0568715a0700b001fb42001fa7sm1206269oac.36.2023.12.05.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:50:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 08:50:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Message-ID: <9435ee4c-59a7-4956-9955-a434d467ced6@roeck-us.net>
References: <20231205031519.853779502@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
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

On Tue, Dec 05, 2023 at 12:16:45PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 152 fail: 2
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
Qemu test results:
	total: 517 pass: 495 fail: 22
Failed tests:
	ppc64:mac99:ppc64_book3s_defconfig:smp:net=ne2k_pci:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:net=pcnet:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net=e1000:sdhci-mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net=e1000e:nvme:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net=virtio-net:scsi[DC395]:rootfs
	ppc64:pseries:pseries_defconfig:big:smp2:net=pcnet:initrd
	ppc64:pseries:pseries_defconfig:big:tpm-spapr:net=rtl8139:scsi:rootfs
	ppc64:pseries:pseries_defconfig:big:net=e1000e:usb:rootfs
	ppc64:pseries:pseries_defconfig:big:net=i82559a:sdhci-mmc:rootfs
	ppc64:pseries:pseries_defconfig:big:net=virtio-net-old:nvme:rootfs
	ppc64:pseries:pseries_defconfig:big:net=tulip:sata-sii3112:rootfs
	ppc64:pseries:pseries_defconfig:big:net=e1000:virtio-pci:rootfs
	ppc64:pseries:pseries_defconfig:big:net=e1000:virtio-pci-old:rootfs
	ppc64:pseries:pseries_defconfig:little:net=rtl8139:initrd
	ppc64:pseries:pseries_defconfig:little:tpm-spapr:net=e1000:scsi:rootfs
	ppc64:pseries:pseries_defconfig:little:net=pcnet:usb:rootfs
	ppc64:pseries:pseries_defconfig:little:net=e1000e:sata-sii3112:rootfs
	ppc64:pseries:pseries_defconfig:little:net=virtio-net:scsi[MEGASAS]:rootfs
	ppc64:pseries:pseries_defconfig:little:net=virtio-net-old:scsi[MEGASAS]:rootfs
	ppc64:pseries:pseries_defconfig:little:net=i82562:scsi[FUSION]:rootfs
	ppc64:pseries:pseries_defconfig:little:net=ne2k_pci:sdhci-mmc:rootfs
	ppc64:pseries:pseries_defconfig:little:net=usb-ohci:nvme:rootfs

As reported by others:

arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
arch/powerpc/platforms/pseries/iommu.c:908:49: error: 'struct dma_win' has no member named 'direct'

Guenter
