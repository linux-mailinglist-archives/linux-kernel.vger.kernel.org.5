Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D760A7AE2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjIZA0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:26:00 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0877109;
        Mon, 25 Sep 2023 17:25:53 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57bb6b1f764so2275534eaf.2;
        Mon, 25 Sep 2023 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695687953; x=1696292753; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EndygcAAjSZYYYSGW2g5PCBC6k5ixtfB9rULOZ8VgLY=;
        b=iEvXSDRGXf3nzPmcwqRutHG9byKOSM/1D9oygz+Xspdd90Nj+Uip0cDSUZ5t+w/Edd
         dMBjGT1QoC0mxv/rxGrnupmfnPtog7r3NHJsUk1hQ8BBrMY88CmlIXISBMI1gn4VqmVj
         gdsjzZSzm0KPCqd+qvgMGvQr9ixMC7XsJfsuPZ8aCiXeFNbjVw4SKqNH6ZkuS4mlGxK8
         N6NaDs53fdO8wItRpK33tNaKYmzDAXVznYtZ2JX1Rrjr6eT22rsIlQQMtvjH00G6DiDe
         97K3hnVHE1DCoGWfKQmDikktvWbz1tD+Nsw8AxW3dC4pXF0eCO3NQ80osyKe6X73N/9p
         84Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695687953; x=1696292753;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EndygcAAjSZYYYSGW2g5PCBC6k5ixtfB9rULOZ8VgLY=;
        b=Lqvr7c5Wlb+RZnL+oSByeVkmJN7pZO8ciyqEyo16ImrypOglnWMrlHMatCbGuKoxdf
         7dxZ+FV1YrLPuWmtb57ZevWnWbElqYm5Jyhk+Z+S6HZ2HZrWF1nSMG1p1FiLPBvYDAv6
         PQrJ7nkDhLXU9tx3CFfoXD3qxxggsRxWM3zUSvMacKYBuIWt7VXUKobIASINJmuc+fOs
         u6Ms0Rr8bUiHQhuy0YfWfvT087LzZbcJU/9gU9OaVML9Ns0sQuApoUn/0R/aW4IExIwQ
         etpZg4+ffD+DAcxkWfVR6exPOiHdgRC6GsUvxuKDUdIDrAQ462e8R/Jt4IQ4w7nRXz4b
         Lw8g==
X-Gm-Message-State: AOJu0YylQ7Hscv8wOLIEiELeYYnkTUweBPtVrp/eIEGOKZsA4YSOEah/
        gB6bwDoRcLU2sLdEne9HTm894uuebFmgyA==
X-Google-Smtp-Source: AGHT+IFUYS4ZMeYL56nT74mymxtirDqVejiQuiN557RGluOT00M4N6c1CrcZFlgn1AFRaKhTJPIqdg==
X-Received: by 2002:a05:6358:7206:b0:13e:b54f:5c18 with SMTP id h6-20020a056358720600b0013eb54f5c18mr10380687rwa.17.1695687952857;
        Mon, 25 Sep 2023 17:25:52 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id r9-20020a63a009000000b0057e13ed796esm5633870pge.60.2023.09.25.17.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:25:52 -0700 (PDT)
Message-ID: <585dcc9e-7e72-473a-98ec-4f06018d542f@gmail.com>
Date:   Tue, 26 Sep 2023 07:25:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Arnas <arnasz616@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: [Regression] S3 Sleep Mode failures since Linux 6.x on Dell
 Inspiron 15 5593
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

I notice a regression report on Bugzilla [1]. Quoting from it:

> I'm having some weird issues with sleep mode on any 6.x Linux kernel version - it's a toss-up when I close the lid as to whether it will sleep properly or not - when it fails, the screen will lock, but it will not actually enter S3 sleep - it just blanks the screen, but the laptop stays on (and fan does too).
> 
> Opening the lid after a failed sleep attempt turns on the screen instantaneously, and it doesn't even need to reconnect to WiFi - this doesn't happen when actually resuming from sleep, it takes a couple seconds for the screen to come on, and it then needs to reconnect the network.
> 
> Following the failed attempt to enter sleep mode (closing the lid), the following entries appear in the system log -
> 
> arkiron kernel: ACPI Error: Thread 3233415168 cannot release Mutex [ECMX] acquired by thread 3268191936 (20221020/exmutex-378)
> arkiron kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 due to previous error (AE_AML_NOT_OWNER) (20221020/psparse-529)
> arkiron kernel: Non-boot CPUs are not disabled
> 
> Now, the "Non-boot CPUs are not disabled" line stands out the most to me here, because successful sleep attempts won't have this line in the log.
> 
> After the failed attempt above to sleep, I now close the lid again, and it seemingly goes to sleep successfully. After checking the log following this, I find two new error lines in the log -
> 
> arkiron kernel: ACPI Error: Thread 3233415168 cannot release Mutex [ECMX] acquired by thread 3268191936 (20221020/exmutex-378)
> arkiron kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 due to previous error (AE_AML_NOT_OWNER) (20221020/psparse-529)
> 
> Note that this time the CPU line is missing, as expected for a successful sleep attempt.
> 
> This happens on both latest stable Linux kernel 6.5 as well as the latest Linux LTS 6.1 kernel. The last kernel that this didn't happen on was Linux LTS 5.15 (any version), which is what I was running up until the Linux LTS 6.1 upgrade. At that point I tried switching back to mainline (6.5) to see if it would fix sleep issues, but it didn't help. Downgrading to Linux LTS 5.15 did fix the sleep issues and the laptop seems to sleep reliably now. Running LTS 5.15.131-1 without issue as I am making this report.
> 
> I'm on a Dell Inspiron 15 5593 using BIOS ver 1.27.0 (latest as of now), running Arch Linux x86_64

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v5.15..v6.1 https://bugzilla.kernel.org/show_bug.cgi?id=217950

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217950

-- 
An old man doll... just what I always wanted! - Clara
