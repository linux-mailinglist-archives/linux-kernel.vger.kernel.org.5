Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FB76D0CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjHBPAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjHBPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:00:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252B210A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:00:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso6401701f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690988433; x=1691593233;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPj5oQb/gSwDVKB5Tdu3got89oVLm0S9QauyfF4BC3U=;
        b=b5zvHi6U2ftxA/daZ7INtzzCNjyerUNKLetDSNHdGRZMQM1iOUCknfguL5BWmGNDoY
         k3S7k3CR9cjL1XEvhUCBHw0leJiOioqsL83yRyRoKwjZnvo5r0nexJ8TF2QGvd/acTA3
         NwLMIg67O2+zHQZIOatQvBMeu/7wBuhHiE6SUSpaLTq7eVIKFLitGGwg/daxNqE7bwQg
         gTUuFDfGixDy+ajPZFBqtRKKQU/z04Z+OY2AgExra6vJd4Rem564FnSlgOxl+Jg3A4mj
         qOKrylji9wKTHxGQBK6Tvi0FDkZ/q9a6LR/QfLl66wKG5Lx4pWMizihHiGeRtTGXx+ik
         a7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988433; x=1691593233;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPj5oQb/gSwDVKB5Tdu3got89oVLm0S9QauyfF4BC3U=;
        b=F+7zy3H94f9yxaKEsZnh7lNebA2M75ma781emtZxsHYPecu0zDzmjlVGWT5kVsfrBr
         PZDxFfipABRYbwMKdy1LdvVEgwMh1aQu5NjH6Or7EvOGfxVptncMh33WxoEDm54CIt9m
         FA4h+p1sAE6tg5sMTDUlG5ElbyK6mRsiX9zMJIzkHpqJtQF6FvgGTxorXGVAbx7ThdSt
         uDvPa9fm4OymvZcEgchNac+38ralSSeM3orYxBGVZnbkwjj2EVo97YeOhOvxMXkoKL+L
         B7Uiq9SPdhP7xA+bT58XXY10FPWUDFzKoBM00GXJbUuPoGcfmRlpLTmeCOafx1ZdS0Su
         fnPQ==
X-Gm-Message-State: ABy/qLYdZSs0RDw2/rFpeyz2L+Hlr4XrV4/CR9iA9FrC9bXtuRoDB2Aa
        x2RJmHuKQ1sjikHiT6iQpxlxQQ==
X-Google-Smtp-Source: APBJJlFPLB9LoRRGImnN9+NIw0ge7AsUxBWoGqVXruAg6ZTGUgY9KCieZjFbfnhRAq9VbFPrJ7pi9A==
X-Received: by 2002:adf:efd1:0:b0:313:ebf3:f817 with SMTP id i17-20020adfefd1000000b00313ebf3f817mr4761979wrp.22.1690988432883;
        Wed, 02 Aug 2023 08:00:32 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w10-20020a1cf60a000000b003fe1afb99a9sm1918418wmc.11.2023.08.02.08.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:00:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
In-Reply-To: <1690984411-4448-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1690984411-4448-1-git-send-email-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v4] misc: fastrpc: Pass proper scm arguments for static
 process init
Message-Id: <169098843172.77085.14958655683805861888.b4-ty@linaro.org>
Date:   Wed, 02 Aug 2023 16:00:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Aug 2023 19:23:31 +0530, Ekansh Gupta wrote:
> Memory is allocated for dynamic loading when audio daemon is trying
> to attach to audioPD on DSP side. This memory is allocated from
> reserved CMA memory region and needs ownership assignment to
> new VMID in order to use it from audioPD.
> 
> In the current implementation, arguments are not correctly passed
> to the scm call which might result in failure of dynamic loading
> on audioPD. Added changes to pass correct arguments during daemon
> attach request.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Pass proper scm arguments for static process init
      commit: 64227235abd9a3ebfb5927dff2202771ffc92b8b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

