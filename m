Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5077006A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHDMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHDMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:45:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46DEA;
        Fri,  4 Aug 2023 05:45:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b879f605so1487852b3a.1;
        Fri, 04 Aug 2023 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691153139; x=1691757939;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSm0LHggTF3l2aeyLG/2fKikbnrwzc2eP2dgLLzrPv4=;
        b=H8+Mt1RJKgOVSJpv5ue/Vmj/iDAjFwcuqBenikvT/u9NokDxWaHtce+LSzYcnVmT0j
         vTPImvio1m7gI3jXv9dvw0LohUtjRxWER2RGbTSxWzglllA6/dptE22VkOzc4o9sxERT
         pIjEmQmCiUWLblpxC/fOoc4l0u2CTCD29XBOHfDiNoUcT12pXwyUNL6UeT5ALLQxI1Hu
         c55BUX2FQ1rJ6PEYRv8eB+cuc9x+819YauGAoe0zAUM8+Ite10DiQoUhR1pih2/Kn8fC
         6ZhIOa0I0gOU0UBx8dTBzH0jmp0zcj8Ho7kcsT0h0bw3xhFVIcJl8r9RcLThv+lFpHMJ
         2ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153139; x=1691757939;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSm0LHggTF3l2aeyLG/2fKikbnrwzc2eP2dgLLzrPv4=;
        b=VVS2DPfuj5zEYHCvEgq65PesrAGpJte/ADh4HjkrWyJxV6CwR7Mt4XTC3CQRkkxEZL
         fAbLba9l5O/yRUSVCivdnkWEPyPHoieT0LiwrZmaqfmZ1Ou5hSKtkVdIBDAO5Td6R9+B
         cheIg+WtYTniY2yLGiLi6u6Uh4wIqmfPUIzLGEcrPf5FIIWHSriGKbD0sQGgPxBpaRIi
         YANRJQzuMtPNVIIwlO5Ps1M76TmGok8Hsw3u8Vdx0n/EqasNLBoLhL0BvL73a2j+SSlV
         Vl4TSrQOS/LW0EQ6dirQUbxl1j5gXOpUVR5QdUAgBYhAOUcqda8qr739AimxGJmjldwk
         GBSw==
X-Gm-Message-State: AOJu0YwHJ47H4+/rhR8ao5tQAtzbPssBJUdEo3xg0I6KRYzKd6pjsOx9
        TvCkmEoooDElonpE+LCRG1uhYElEj8M=
X-Google-Smtp-Source: AGHT+IHGLB8g1U8UsN2DTHPgNdRGdwPal/H/mLrBwBvjqcOrzv3I8ACc19Md38AOGdGvO2z0b6dFGw==
X-Received: by 2002:a05:6a00:1828:b0:687:8417:ab51 with SMTP id y40-20020a056a00182800b006878417ab51mr1688267pfa.8.1691153138915;
        Fri, 04 Aug 2023 05:45:38 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n5-20020aa79045000000b00686ec858fb0sm1536456pfo.190.2023.08.04.05.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 05:45:38 -0700 (PDT)
Message-ID: <0ea231a1-e510-903d-22a0-998234426462@gmail.com>
Date:   Fri, 4 Aug 2023 19:45:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Regression: ALS/ACS stops working on amd-sfh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a very concise regression report on Bugzilla [1]. That is,
quoting from it:

> Since commit a33e5e393171ae8384d3381db5cd159ba877cfcb ("HID: amd_sfh: Fix illuminance value"), the in_illuminance_raw is 0 all the time.
> 
> Before that commit, the ACS/ALS has normal value.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: a33e5e393171ae https://bugzilla.kernel.org/show_bug.cgi?id=217762
#regzbot title: Fixing in_illuminance_raw value hard-codes ACS/ALS to 0

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217762

-- 
An old man doll... just what I always wanted! - Clara
