Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D176C0E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHAXai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHAXag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:30:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46D2134;
        Tue,  1 Aug 2023 16:30:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6873a30d02eso2012460b3a.3;
        Tue, 01 Aug 2023 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932635; x=1691537435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zaHWiEW/Me3thxkNJ56r2Pyq80QApvWwI2tz1dQNoc=;
        b=cBjXpxxw0AtY1hTOCWyN1k+FZrG74Ps+bAvg2BJm6iNewS4PeKBRBrSE9tQ8zSKkUS
         EWaCe+2nOIZYrvJiC9cNmI9GLrELxOM8bEcS9mQP4M8dnWz8DuP7/KcxFhg2ElPDJhAL
         /nXID6ZjRKSP4UlqUnogyZT9afGlN4YnMTQO9iz2Y3rFjB+CZKLstPje7XLn3qCe2Jt5
         Xbq6SNZFaYXu8pGm7bbDyKzV8gQDDU/BWT/AisnJfg/M0KSmFcp3D9PzNtKpammQDDQT
         YvSCcv1GKEQ5ORnz/FFdE4HU2dKM/DUuXvfzOfxjpuRDnbrj4uMaoPZfOuWPqUBfBqwf
         p9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932635; x=1691537435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zaHWiEW/Me3thxkNJ56r2Pyq80QApvWwI2tz1dQNoc=;
        b=jKiNyGmG3DncJDfDacXsBOwiFzZPmI9LNLLdbv0M/c2wwVntA1n5n7a40X4/r9OR73
         wNq9E00zcR61VL1ysqy6GDr99Mvv4KHYKOD64Um1kpj2jPVe2ikvyXB4iSKoePoEQLJk
         V1kQjXWCH54i4w0teR4RCpsCcngj/wI4GUlkiTOECH7ZI6YLz6eJz00VJAiwhS2DbCIG
         nc/lGTxBEojMivD7fFBZb+f48RXXrWO85jhsRuBZfWfkXlEGin8a9jsBmhk1rPlvvrSU
         IXfLYJ7nFqV8z2mrtiKAMEV3lkkxjH5BjofwdtcMump6iPzJB35upSDyYQ8WYYy1ikLq
         TeIQ==
X-Gm-Message-State: ABy/qLYwcjyRUc1VWxQC9aQzW3SwlrHmZakh4jlBGvpt4fx21hBrn4k1
        4cpcaQmspQ8kjxGFBqvfRCw=
X-Google-Smtp-Source: APBJJlE3ZqHkOO61oFs8tDICIrSP5akS6ruW58KYc0SCnq9Pny0BzCcci9zeZj3GF4tS8mIdXNUuqQ==
X-Received: by 2002:a05:6a00:c95:b0:686:6fa8:2b0d with SMTP id a21-20020a056a000c9500b006866fa82b0dmr16652018pfv.4.1690932635454;
        Tue, 01 Aug 2023 16:30:35 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-13.dynamic-ip.hinet.net. [36.228.73.13])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0066a4e561beesm10127615pfm.173.2023.08.01.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:30:35 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     minhuadotchen@gmail.com
Cc:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: fbmem: mark registered_fb static
Date:   Wed,  2 Aug 2023 07:30:31 +0800
Message-Id: <20230801233031.72174-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162812.25518-1-minhuadotchen@gmail.com>
References: <20230731162812.25518-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi Helge,
>
>>num_registered_fb is still used in:
>>drivers/staging/olpc_dcon/olpc_dcon.c:  if (num_registered_fb < 1) {
>>
>>Helge
>
>Thanks, you're right, num_registered_fb is still being used.
>I'll check this patch and submit v2.

Update:

num_registered_fb and registered_fb are used by olpc_dcon.c, However,
olpc_dcon.c has been marked as broken [1].

I do not have the knowledge to remove the dependency of fbdev from olpc_dcon.c,
I'll leave num_registered_fb and registered_fb as-is.

[1] https://lore.kernel.org/all/20220609223424.907174-1-javierm@redhat.com/

>thanks,
>Min-Hua
>
