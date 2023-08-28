Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073B78A997
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH1KEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjH1KEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:04:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20010C;
        Mon, 28 Aug 2023 03:04:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99df431d4bfso394001366b.1;
        Mon, 28 Aug 2023 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217082; x=1693821882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YF+tBcFB8oUAJLRFh8palpJJ8k8VFrTFaU4dRCnVkd0=;
        b=fnSgMhcsY93sz5w5SAqlosS1e5CtS8cTgo1oaCubuRsmnFbL2ULRJsVZFShm1Bc1id
         ZzLOLxnYu3IymoJAM080tklkdA92FqPjdzuWsU4mNKxuPAXiTwSDVMBxr+IUCC+ZxTna
         J+1V44Ngj395eXqXZVIQSHnore95m/ZeMo//rzmT39gNPJjz2hc0y03q0i+6Jwnkt5Eq
         QA2sT6oSUOqoFF3h9EzBmBp3h4OCb5hxFBB4ixNon8tMZCm532o5OrsDeXDwSg7HF1G6
         JByfqm36Iv8WINtKvV1xRW/0Fy0ufK4EjWyjTqcGYres9Tf1BmPjbQwYa0A2FaFp/zXK
         K+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217082; x=1693821882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF+tBcFB8oUAJLRFh8palpJJ8k8VFrTFaU4dRCnVkd0=;
        b=I14IKduwiSJrPH2U+dmOFS00EB4ph+H1KeR2c5MBGVmim/0VUiLGsiP+WJRihAjNwA
         aLZd+WGq3d0abUkKi+zLU7JHoDhl28gkLoojs/XouZBpWl5yj26j40aTOWOIrLXsv9K9
         0jRSTj+Vz9lmL1IIiPep3Og9I3/txRiE4ekpjqjGSDW7bbCzvhYftAIca60v9cPJR+Sf
         375h0i+AUceM8S5KExQn2bCkFE4oJAa/DCBVw71wbyc2NGnYpsL5s1v77pk4kmJvCjJf
         5DjjiAjbJGarVeKuWA87Izy+ZCVaX7yLtaei/Q9DRpg0wB9vz++UO48O4gsc0/oB3Mgw
         EIQA==
X-Gm-Message-State: AOJu0YwKywI+YEzMAhPBRxoPDwvMiosd6x7eFNVDp6vkPllOcdH1Y17E
        dZfMVpGZEUPGw8jCrdz0acPi9OJlj5T/bC5rr8L4yl4Qyuw=
X-Google-Smtp-Source: AGHT+IEv81ay/Ms7SUmOAPSoLX1ePrJ048tBBg1eModdvSwOMPYQRIS9QPxDdrcRZCdVbH6+/pImd7xxDum7wTcXELY=
X-Received: by 2002:a17:906:8a51:b0:9a1:fab3:ee34 with SMTP id
 gx17-20020a1709068a5100b009a1fab3ee34mr9418974ejc.0.1693217082095; Mon, 28
 Aug 2023 03:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-10-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-10-arnd@kernel.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 28 Aug 2023 11:04:05 +0100
Message-ID: <CADVatmNRd11Xmm1ReY+1Ce-SgnHcMizAa4DpvsCsG7Z7NLdObg@mail.gmail.com>
Subject: Re: [PATCH 09/17] parport: gsc: mark init function static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 15:22, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is only used locally, so mark it static to avoid a warning:
>
> drivers/parport/parport_gsc.c:395:5: error: no previous prototype for 'parport_gsc_init' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
