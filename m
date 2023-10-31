Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934047DC815
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJaIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjJaIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:21:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397EC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:21:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso3762108a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740486; x=1699345286; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59ItUKeKAfQl6Pm0GuI2gI2GpUNLzTXJ8v/99uj7RTc=;
        b=Z3NDA/r7NDIHV+MezU6AhoU5TXjxc3exO/FTjhq2FrRgOdSOD1NeNZcYQfeLWeNVpm
         pbCsnO3R14ZKpbNTBRyQSz83dPaN7VAHrcsR2e3nK6/c7gW31NlKmEPNc89NmLYHRGWi
         PZ9xyMRihlNWWPxh6VZuPJGhECs2708db0jvl0qzB4gYblWA5EyzhMQF6lpcoBwVOxWT
         bQgth9GydDMWBFPhGIaqTZ7irLFdwB/tRv5nzhIQDNMjHInLQJTaRCRL2e7tMRBSlqyq
         Wz5lfkdvypx8EQkKKTJHoLHAsoB7171a6NbnONAf9b6uA1/XhLCj2zjioYvqlRhaMR8M
         ne0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740486; x=1699345286;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=59ItUKeKAfQl6Pm0GuI2gI2GpUNLzTXJ8v/99uj7RTc=;
        b=tPcQ9MDsdRWntUIaKAwy0L6FjeWgQCTt4s51S+xarLHMC8m+Z4CcUCF+58ud5Uxjcz
         46VdzZtZnaU6TNmj1/v+GyxVlhGoNmzbxsaacP4AxzjuwHwCDX120W6o2CBpLG0inzb+
         tWi/Gq4NPthYu+r0izMMfkfyzpnpkJPT0GPHU3LH2/uR1/qWWMJzhZSgh7FHHvIkNhZw
         iZZgVdjjX19mRCvhrxufvqSiSn30a3A6PehasPDeHIFRHCiXfZ5S7EZbHURgRxGlG9ul
         HXQLGOMthbLgRbyGzymxHpLuKYT3RmpG8kwuZS46Pe57ngkEeAiAdzYhz4OVDdxgjH3A
         SWgw==
X-Gm-Message-State: AOJu0YwpX4AtgI7KVzeWzO5iCg73Z4A5tpTZn+ynygdi35t4+fv6bUnt
        rSIO5fb5PfWFlRCL1wGTXpHF70IB+B0=
X-Google-Smtp-Source: AGHT+IHHBHVRJNDBt0RAGcu/t+Q6uNYCEvGjtPkxGzeePph6Ndp8DOdzVsRjMIOiIjmUcvhZ8C81LQ==
X-Received: by 2002:a05:6a21:7747:b0:180:f227:57f3 with SMTP id bc7-20020a056a21774700b00180f22757f3mr1149592pzc.60.1698740485779;
        Tue, 31 Oct 2023 01:21:25 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fi18-20020a056a00399200b0068fb8080939sm733810pfb.65.2023.10.31.01.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:21:25 -0700 (PDT)
Message-ID: <0e784280-02bb-4e0e-a5ae-4e0a40ea4c51@gmail.com>
Date:   Tue, 31 Oct 2023 15:21:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to fail
 to wake from suspend (bisected)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> 
> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> 
> ```
> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 7 14:32:43 2023 -0600
> 
>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
>     
>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
>     native"), the PCI core does this for all devices during enumeration, so the
>     driver doesn't need to do it itself.
>     
>     Remove the redundant pci_enable_pcie_error_reporting() call from the
>     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
>     from the driver .remove() path.
>     
>     Note that this only controls ERR_* Messages from the device.  An ERR_*
>     Message may cause the Root Port to generate an interrupt, depending on the
>     AER Root Error Command register managed by the AER service driver.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>  drivers/nvme/host/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> ```
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.4.y&id=1ad11eafc63ac16e667853bee4273879226d2d1b
> 
> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regression introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
#regression title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090

-- 
An old man doll... just what I always wanted! - Clara
