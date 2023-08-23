Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FFC784DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjHWAId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjHWAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:08:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B2184
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso939766fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692749310; x=1693354110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6voCTFbL0lNbz7y0IRbENmmss3++8RsYIaK/hukXzZI=;
        b=sJY6ArUvu8a+wfwuZZ9xumV/iTUHXJUytEikIUOyu8NcO9k72WRic/FXlS76gq6rqG
         fCIulukOrg6Cj+6lEDbwH9u5/8bUfv5lwq8JNzH1FkZ6wF8soVd+C9aFfND9J1u5Zkbr
         frTgrlmcMI1YGlsYtB1RqSdSOYBOZLkJE2PNDAQrDFnZCFnlb6MIyxP2LcfyMx1SMQOQ
         0WGmTs8jaLsOojY4OJznrTu3ccaEJ8H4H2A+hfa/WHlTF9yo7h3U7YMeczONp1bfS2NC
         5y+o/aivcbB8+r2Yfs88Z4akJyiSnl5j8c4xayW4CDcadqvoLIaZ2EUUGf+bKz5tYECj
         QTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749310; x=1693354110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6voCTFbL0lNbz7y0IRbENmmss3++8RsYIaK/hukXzZI=;
        b=Uyr6EBkh+kVFsnF3LPvMFuIQ50JegkS1hlL2x8yPdHbeaA3HD6P6X8ff567QxDUyoA
         yLRcKTABQ9mppSGEWU3SNrNYF3w6crp9AHja/Ns02AWQiccPAWJa52cHBuUtsIQ7s/cP
         YyJXtGVCgm7b50IdvdbFkYgqPSVCjeg6Hxzhro4BlmryUMFyzHLnbMTAt7NO5bJGI/Hm
         b1a/S2gqB2Y1v0DFGivtxn8LlPVJviLGFMBEXl0gTqHCYAvpKrUzbZR5M4D7vMLEdxb7
         Ub0fMH5eDgl2GKEPYJvrmSnnICfml+t1hr0iVDWT0tI+pPjmdq6QlzYingiRYxl+CYC9
         hOkQ==
X-Gm-Message-State: AOJu0Yw7DkqO3As54ExXc7IeTp4NhuNTsDh/8bU9kehaTNUI11OI1NfZ
        Adxl9EvdoSQTaXA8/MOpBPntwyGlURyJ3nZ7V64=
X-Google-Smtp-Source: AGHT+IEsT7YDa/7c6bzW0F46+sq8eU5YKhnMY8iy6qpz38n7aoD6dI8tILwNZhuh50G4IT3oEZTqgA==
X-Received: by 2002:a05:6870:330a:b0:1bf:9fa2:bfa3 with SMTP id x10-20020a056870330a00b001bf9fa2bfa3mr12503886oae.1.1692749310072;
        Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bg23-20020a17090b0d9700b002680b2d2ab6sm10149127pjb.19.2023.08.22.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:08:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yang.yang29@zte.com.cn
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
In-Reply-To: <202212031422587503771@zte.com.cn>
References: <202212031422587503771@zte.com.cn>
Subject: Re: [PATCH linux-next] block: use strscpy() to instead of
 strncpy()
Message-Id: <169274930900.113062.17637182584523326020.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 18:08:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 03 Dec 2022 14:22:58 +0800, yang.yang29@zte.com.cn wrote:
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> 

Applied, thanks!

[1/1] block: use strscpy() to instead of strncpy()
      commit: 146afeb235ccec10c17ad8ea26327c0c79dbd968

Best regards,
-- 
Jens Axboe



