Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91697A46E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjIRKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbjIRKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:25:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA831D9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:25:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c43166b7e5so26259055ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695032721; x=1695637521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2R1uFPZQh5rHaFChaIdksfqptVdy9O1APe6DAZC5D0I=;
        b=gHnyFUgGgcQkE5CuJjm5EQ4vN6BEuMahmI64hqssUMHjMJb34/uTV8TxWtmUKDxTzI
         cYrnatzJ36aG4YF7WkN0/nsFYeuCCFtJK5//kQM7yduJsiNi4Bk+aCHT0yQEfJ/g8qM7
         K/YadinEiuJHfpNxVsiqHM5WISGlUbvO4yUeAYjIwLQjExLkzgIcfteXz4vRuZzw/iU4
         mWeqA0yjqa9YBlMRxJBXqlpNPPDXmDQZGpicad6BMPCJ/NwxeRTKwhdpGKXuecbuBWB4
         V6aGP+p3YyfteW9QmJPT1FzG7oNshx2MnggA5+jWqgkffL37u2hGCGokKp+h70tPzUOO
         foMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695032721; x=1695637521;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R1uFPZQh5rHaFChaIdksfqptVdy9O1APe6DAZC5D0I=;
        b=pJfuK5Op+gmpFcKVgNX17JTAb9p/rGyXiF5/Og5iNx2Yvkhp0A8Z9AEC9NvVbhKZFu
         vl8StReORGYZvVX5KlmkXyFHFVr/t4CgrHXwVHLuRKovIEdPLT0N5aKTOG1pW39fx4O5
         aSpZysMjUdMQwfUzjRpyaNPLBbBFcCMnlNsvZtGfX2AaVRxhcMth/mE0cFM4iLV6CPlG
         2xlWj3E6CPa/QhI299Xu6cEKPkL6nTsB96M8CEeZRhNH15Y7tg0elflDqI2ZiVPxPKx/
         8LotlpHJ4LOrQsowc2OkQ1EeMWzLMy7WPORsqwuG1HCFtCNMUYMcYJbjfCT7dHzsXE22
         Is4Q==
X-Gm-Message-State: AOJu0Ywr3gV0+2dHIeJXPYTodUtZ5xmYy2EVMlnMyAmn+0bup0pPnz/l
        JCW7IjVFwdFt3HtMSM1+ulfwtbyLahcbNxOHt3g=
X-Google-Smtp-Source: AGHT+IF+u2kWo8jwH97CBxsh0Pl65Wiztx0Y7Z+VM2CcJTy3FdfSVviraEX4BckReV+C05bmFGJa4Q==
X-Received: by 2002:a17:902:efc6:b0:1bb:7b6c:983a with SMTP id ja6-20020a170902efc600b001bb7b6c983amr7623614plb.59.1695032721344;
        Mon, 18 Sep 2023 03:25:21 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id j17-20020a170902da9100b001bf095dfb79sm7953757plx.235.2023.09.18.03.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 03:25:20 -0700 (PDT)
Message-ID: <0608654a043206078d3a27d23cd5e3c2851ee415.camel@areca.com.tw>
Subject: [PATCH 0/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Sep 2023 18:25:21 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are made over mkp's 6.7/scsi-staging

This series add supporting new Raid and new PCI device ID controllers
- support new Raid controller ARC-1688
- support new PCI device ID 1883 and 1886
- updated driver's version to v1.51.00.14-20230915
---


