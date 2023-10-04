Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908F7B7E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjJDLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjJDLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:25:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A85A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:25:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so20358325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696418710; x=1697023510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeZJyHK/x9TA/rlOy4OI80hx9G/PexI8heXL6spHMG8=;
        b=Tqv5jEp7GudEUEq+CdrtXSJEZA5mA82DSJpSsR14td4aKaOuKanQ236zYWvfZc+lmx
         qsVbneN2i2UbcyvlC1UC+hPvP/eRlaBfDbBFf+IwUeqYM59HvVvOYF/6lcZkTA2IJ3lr
         K7CkYwbjBAGTPmmW83uw58Vk31u17N9niC1AHAQxgzFp2cjtlaASUPGRR/bJaOfnOcNb
         AhfHUeUzG/lEEpyPyx4dufP7BPFD6xgxgRY4eS4J8ulxKLvDcmnJnt2/l91Swro8ZsVl
         mThzUfw5Q1vRBd1q6ImS1pnX4g29fCumfJVVWrFm9pAlyiOpke/SgxSOQizpOVX1XU0K
         JN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418710; x=1697023510;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeZJyHK/x9TA/rlOy4OI80hx9G/PexI8heXL6spHMG8=;
        b=vBJbI9IN7bUmlrFAaYKK1Wjuy30qc5jTSekPPy5DI9oAUpdKrDgMOCNQgozp2bz9tj
         yUOD7JRtDC+gcJKZwbWxyEXknkzRV0id4uSxXbIvFlg9qb0ffD7hMVEMa/SE09W2SnP7
         Nx1Gh52iXS/9eyVV7V1Jm8+E5IFxmIobMWqTxM6fPCQ5cegOFENxq6gGqMbsny5qLFFT
         8QeJuChcGNeYqN4Lic2bnPc09wmDnxxBK18opXdG5avguB3WdRRwcdhOWmoEIBdA27as
         XBoKlYZxXoo9CmFLdlJrTcNai2WYHUGFkNngqB+upqxzrOwVKsXWuvdMuIIAnCI0CiWB
         hgdw==
X-Gm-Message-State: AOJu0Ywz7cA6WPIn2reLqQcJ87KfKlhMpZ0eGKS+iI7XIH0963r6TUwO
        qBBaNQLkbrWNddia716Zzwm11K0NwA6nBw==
X-Google-Smtp-Source: AGHT+IEfmrfK2ak5YRu9Vchf9a5qMFpMRt5bz2h+4dfVo3vdyhZqZjvCgBq8XKQgKTHESDhtHopo2A==
X-Received: by 2002:adf:cf01:0:b0:323:264d:9cef with SMTP id o1-20020adfcf01000000b00323264d9cefmr1703777wrj.12.1696418710376;
        Wed, 04 Oct 2023 04:25:10 -0700 (PDT)
Received: from [105.4.6.164] ([105.4.6.164])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d50c5000000b003200c918c81sm3757198wrt.112.2023.10.04.04.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:25:09 -0700 (PDT)
Date:   Wed, 04 Oct 2023 04:25:09 -0700 (PDT)
X-Google-Original-Date: 4 Oct 2023 13:25:08 +0200
From:   Leona Dickmann <lastinlugking00987@gmail.com>
X-Google-Original-From: Leona Dickmann <leomanndic@gmail.com>
Reply-To: Leona Dickmann <leomanndic@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Please Be Honest
Message-ID: <20231004131301.B7B14909B36333FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day

I am 75 years old and was diagnosed with cancer approximately=20
four years ago, immediately after the death of my husband.

I have been touched to donate from what I have inherited from my=20
late husband for the good work rather than allowing his relatives=20
to lavish my husband's hard earned fund.

As I lay on my sick bed, I want you to help me in carrying out my=20
last wishes on earth which will also be very profitable to you. I=20
want to WILL a total of 5.5M US to you which I want you to=20
distribute part of it to any charity home for me and the rest for=20
yourself and your family. I will inform you on how to share it=20
all.

Please for further information contact me ASAP.

Regards,
Leona Dickmann
