Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5A75BA98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGTW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGTW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:28:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE010A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262ee777d1cso178893a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689892093; x=1690496893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER64QQYHsUjwnG72el4kyuwJDiqUwTkcoHvph6BDruY=;
        b=xvnxeikI4preGoplg4GJa2wMcpwX156LfaLr8H24NbeffloJZcxZ79aZcYtr3mITgR
         J3SBSJ4LeXPYFbhe91Z0vaDGcAyXlTZf5tXCmRzOBCpy7n3NtPOf7HIr2lzT+ShELXLd
         C3Sbk0INLRfUrb5HCB9ayySAPcoatZ2wF5LstdPXuVWobEPNOV1iHKqyw6ZJcCmmxVbs
         E0ty3dIfkDANo1MPs9ZAKju5ZQy2F1bHqVxTca5GYUMJJzQNvfLot9kZ3k1Z20R4KOVy
         LQmKKwgSfWkJU/hVi2kEoJasJvfst55olSEhnUFyOHfj7wNkqiBT+sB+OHZU3Cxks0cd
         0egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892093; x=1690496893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER64QQYHsUjwnG72el4kyuwJDiqUwTkcoHvph6BDruY=;
        b=fsvaUA1dVcVnCkoFBbQNLBu2DUlnGJiK3vJe+Rkq/VrO+oQyxncot9lHrk5XNU2qVz
         /xXufwVTLRbW0AIcSi/W0LgiJiiHwvD8e513LIAe5vBN33oNJ66TYjpMlPYhcf2F3MOP
         d9xrg/i/ZQ9qtgfFexbyt2lfI+uGCl8njHtaecfnvmTGTOUGdnQkj/gPspnZFwwqFc97
         AqFiYjucJnEknIEucJjEpn2DiXFqB/h0pAkLc/SnHcZKqzRFsTbd54dOrxqBqWAQmEb9
         xcV0xj44raokofVAdLZ7H1vLRK2Y5IR7AfpI1vFZALZcf35NfDStRpadXsj/Ew4WawKY
         P67Q==
X-Gm-Message-State: ABy/qLYICb6EYQb46IQaJYhHk7f36Kj4O6t9p3r6+g90QuylOtROIEOp
        O+6ZhwLHFi7SMtadFhHJDKU6Fm9R+uADC56GBM4=
X-Google-Smtp-Source: APBJJlGb5KbDm3ra3A6zcXjXBrySFNfNSVxxeSzp8vPmQrISvsnUWmY7D8a8kPz7CxMAemHOYr+xMg==
X-Received: by 2002:a17:90a:304b:b0:262:c2a1:c01f with SMTP id q11-20020a17090a304b00b00262c2a1c01fmr30777pjl.3.1689892093322;
        Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gv20-20020a17090b11d400b0025bf1ea918asm1409443pjb.55.2023.07.20.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:28:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     martin.petersen@oracle.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719121608.32105-1-nj.shetty@samsung.com>
References: <CGME20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8@epcas5p3.samsung.com>
 <20230719121608.32105-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] block: refactor to use helper
Message-Id: <168989209223.138604.5420894293792909192.b4-ty@kernel.dk>
Date:   Thu, 20 Jul 2023 16:28:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 17:46:08 +0530, Nitesh Shetty wrote:
> Reduce some code by making use of bio_integrity_bytes().
> 
> 

Applied, thanks!

[1/1] block: refactor to use helper
      commit: 8f63fef5867fb5e8c29d9c14b6d739bfc1869d32

Best regards,
-- 
Jens Axboe



