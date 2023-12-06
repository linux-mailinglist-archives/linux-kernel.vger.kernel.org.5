Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC48065CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376594AbjLFDky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLFDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:40:49 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6613122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:40:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso1966125a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 19:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701834055; x=1702438855; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=Obdzpy86OjHjt/UqsOPU4cwrUuFxBSYyHnI0wpurhpu0BxobR/QdvmNrOMlfJMi50H
         hAkxPjlqjnk3OhcuPci5z+GZdiUnCmiaIQgSWK2EZxK+abSREqsQUGxEKUiTa7BrdjIc
         6aNy8HYVgP5gGYD5dpDNFnlLFHwS3bkvqpOHIsiIjR3Y7/DFdoDnT+W402PmozES1WVe
         bmmg1jUxeGCr5D3b9BLFrd6b03yOYbu3/nx1ngnQTCIAxUV2bHdBAQ49zpBAtecEErzK
         wBtaKHOI9NWtt8GBrp061Yn0G3RiACO5M3UfjHuU5uG1l2koOoVCa8517OMKJdtIch1q
         htew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701834055; x=1702438855;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=W0qDA7lp5GX/wEJeDjjsvy51k+PClK3ohE4hCguLsPjMTTvS7U7FF0ufTiDypQAQgw
         HKpLaNXGt5proK8Ez/cKP2anFVSc6feefx56phAz/zfIrZM+R2W9Q7MlDgYdnh8y92Sj
         xgnArTvEMc8vfp2SrXrceCak8HQx7lrhbvDAkNZ/CkMc4LOaGPjbUTaD+/TxrfiFo2cD
         YjxVKpHu4HcHH6P70tf1uQ9yJWGyNreY5py3kftazs2Ps7IrAxeVABqBygHta4n43caB
         NQtV0fK9LxOgkPlhwtQSYgfskAvH1PNzeXapFn1Vs7VQF2AX48vaPMxwlCPrL6AVA8wS
         IOSw==
X-Gm-Message-State: AOJu0YxpOfZA83cih0Mhhqla+sR/QbMxuDaQW5U27KcluRSHwm2C+PcP
        hOU0Plj/dhFNivXgBdqNJIw8uo0G2FNxaaYd
X-Google-Smtp-Source: AGHT+IERll6Ph6fDDrFYS3tl/2WQaoSEhmV7l9/z84IP0U5I6t861tQYWPNGin1N9Cc2TWUaOpRtbw==
X-Received: by 2002:a17:902:ea0c:b0:1d1:c917:2e5c with SMTP id s12-20020a170902ea0c00b001d1c9172e5cmr134717plg.95.1701834054978;
        Tue, 05 Dec 2023 19:40:54 -0800 (PST)
Received: from smtpclient.apple ([203.205.141.85])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001cfc1b931a9sm6856987plb.249.2023.12.05.19.40.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 19:40:54 -0800 (PST)
From:   1 z <hodgezhong@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: 
Message-Id: <1FFC5A93-056A-4F73-BCF9-C16F30C1217B@gmail.com>
Date:   Wed, 6 Dec 2023 11:40:41 +0800
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subscribe linux-kernel
