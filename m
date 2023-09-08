Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D218798048
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjIHBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjIHBib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:38:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311C19A7;
        Thu,  7 Sep 2023 18:38:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bdcbde9676so1161930a34.3;
        Thu, 07 Sep 2023 18:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694137107; x=1694741907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoqYLLTWFIzyoZFuY1x7lHwA6k4s+5qXgOEmq2+YoYU=;
        b=EsBpaSe0lH006cNozgkyqkb/qVj35GpPvPD0+TihJj8AVV2NkjuS1uT2EdWrL1k8uc
         FxAocCceBsKLZObsnDxzvGWhBbf5JCRVzOR6dlvll2DM9H5CByC7mENXBbvwAOt1nr3V
         /vP14AYGSzMjYUQwVUrwyYscpC6H477gKaem3Fhk1SJM2HlwJ1m1Qh6vlPYdY7CdhqLr
         ETOAHP6uasyBsAwABcmZLmA9Fd+BpcVnsGwetQCxDV7MxFQM4hjXyFszTEZq8lxsJ8Wr
         iptYlDeXlnBoLHl9mdNfwpyBNtITx+4iJ7smHUS9ihsA2PpRbRzqfpv9V3T2M0mHzpOU
         QM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694137107; x=1694741907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoqYLLTWFIzyoZFuY1x7lHwA6k4s+5qXgOEmq2+YoYU=;
        b=AGyFzUEo/CVNgjwO+Y4tTrban76h+SXhIB4ef4RCVFtF0Ux/n6XD5lIdZB7ra51UAR
         OQQ2RhHwFpd+GLpD8XbktSX8mLGMvCRgL2yczDDn0lE5fU18/TCdKNp1kumKedI+hXTJ
         GFUrqomhD7uGg2LVc+ZtXYTPqIrSDw/tM9MIV4R6PvJjLaQs4Yf1KrqT39A/5YG4ADLd
         vcsCuyHXIIZxoTxSPnSmwYuH/WDi3/mYq6TiR7XMviXF1oD+/9OTSAqZuuwy8pwqQmEo
         zBJegD27RjobCL06Uv2hfyBcL8C33/Qa26b06hCWLSzCCTWEy/ndNKhDGpAq3aTkQRcA
         edKw==
X-Gm-Message-State: AOJu0YwV+WdtmkuykXoWbH3ALbgGdiRl7Lvy1wEQ9MK0LVJyThM4YFW8
        rTqX9R5Wb6chF0CImDWDeTY=
X-Google-Smtp-Source: AGHT+IEX3ezoCJxl3ylzzZ+PxyXa4OnAcfwLdtTuYgj04ghqbAq39XjRtCcti+FtWFJm+Zk3a/JwUA==
X-Received: by 2002:a9d:665a:0:b0:6bc:f20a:3b65 with SMTP id q26-20020a9d665a000000b006bcf20a3b65mr1067072otm.23.1694137107026;
        Thu, 07 Sep 2023 18:38:27 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id i3-20020a63b303000000b00570574feda0sm171870pgf.19.2023.09.07.18.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 18:38:26 -0700 (PDT)
Message-ID: <470bd522-3e12-0e6c-de4e-2da8164d694b@gmail.com>
Date:   Fri, 8 Sep 2023 08:38:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Slow boot and shutdown/reboot problems with 6.5.0+
Content-Language: en-US
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Integrity <linux-integrity@vger.kernel.org>
References: <5011708f-b0ae-2853-0f87-a3b59845a2cc@gmail.com>
 <CA+FbhJO8b5V_So2mMPu1ApKXTxk0ieWvNMa=HBTYTWDXLEA-ew@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CA+FbhJO8b5V_So2mMPu1ApKXTxk0ieWvNMa=HBTYTWDXLEA-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 20:56, Marcus Seyfarth wrote:
> Thanks for picking this up! Just to keep track, you can remove my earlier report (https://bugzilla.kernel.org/show_bug.cgi?id=217864 <https://bugzilla.kernel.org/show_bug.cgi?id=217864>) from regzbot. I've split out the boot/shutdown/reboot part from there into this new one as that was still reproducible on default distro Kernels.
> 
> As to bisecting: Unfortunately I cannot afford the time right now to bisect this further as the system is used in production and already did invest a lot of time without success into it. Hopefully someone else can find the root cause of the problem. My systemd version is: 254.1, and I also use dbus 1.14.10 and dbus-broker 33.r35.g2220a84 which was configured with -D linux-4-17=true.
> 

Do you have test environment with similar configurations so that
you can bisect there?

> Some other observations: It was very odd to notice that with 6.5.* local h264 video playback with mpv did not work any longer - mpv did not even open the files (it works fine with the older Kernel); the monitor refresh rate was set to 165 Hz (instead of the manually set 120 Hz) and opening of the task bar, Dolphin or attaching files to an E-mail took a lot longer to bring up the dialog than with the older Kernel. Hitting the power button still could successfully turn off the PC though, but clicking on the usual shutdown/reboot Plasma Desktop icons did not seem to work, at least not reliably in every case.
> 

In that case, can you attach mpv output?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

