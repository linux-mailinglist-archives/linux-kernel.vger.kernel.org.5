Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310B7C94B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjJNNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjJNNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 09:15:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77942B7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 06:15:57 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so3358636276.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697289356; x=1697894156; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHjV7htyXHmH4dOKJAmigSmZuMvsjUXk9KbXwaXEfrc=;
        b=XsczNKRc5gwSzaDcbb9ckilNnMC9Lne1iQg33rc02sn5waS2Gv7xH4xVrba4WjS+/b
         3J+bkxho3KSGBNwe5p4AYVuu5EtGj0q8ShBnhVen3KVAUgjp2qUt6dEw0ndz24m5B0XM
         2vAtYrVu57zl4sDY/YeOqS/n6YDNg6u9Kug5NAdxRVfWISRu9eMzl8hn6RpQapR+Ks1u
         LaRkAEK6+VlfMtw9peQBwUPkQ7zFEbmT5NkcHBLkLgEOu71fbkwrENNAHDt4J1SlInQU
         xDy0lVQSd+KTXtmW3IoPYV2j0dpPACFvW2pcv37jQSBjpjR+HEqTM9MolOu0ArH1ba5g
         dQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697289356; x=1697894156;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHjV7htyXHmH4dOKJAmigSmZuMvsjUXk9KbXwaXEfrc=;
        b=IFRhaqakoZiCBJuZTPBR8/Z1bJOf29EYQxnxJKyfa6YzUah1/KZbGkj3N6LLRcLKCg
         cbXK9DV+8Ex09f8cUbg5eLMAlocrCbLUoEO2viqaKiTHFx5sXuEm3f4e20XuGqQAw7Xs
         jd5B4idcS+22e4BvJ6gJqQFflcqFV9cKBbnBrdrrDU8Ylo1UnMrqHgBlzqghvZUST8Gs
         ZRgndGnyWbxgQp97/+wTVSsTWDMtGWgTZBOscU7ciK0OLOuPc/jSyQQ0iUqfoGsiSM6v
         X6MiNHI+vCksdsIsbaATg1lI9beT+TNQzcG675eVLr+X1OkSyzstjwohshImbOAWaIEP
         QIdg==
X-Gm-Message-State: AOJu0YwoAhnWrly+PnicCsz/cMQ8UXSL5dibSaln7OMsUvuCG9sjsuhw
        Pw36KYGpY64vO55qPQI5qCSdHJh9iYdEbVxtTbU=
X-Google-Smtp-Source: AGHT+IGCzEooaSjcn+bzwd0WSG3J8jTGw7Hm7PzmRBVdEw+XimRsJxlYEEWg7TieyMiO576RKRmvsUUwIPc0AGeWuJc=
X-Received: by 2002:a25:254e:0:b0:d9a:d91f:3888 with SMTP id
 l75-20020a25254e000000b00d9ad91f3888mr6318027ybl.13.1697289356714; Sat, 14
 Oct 2023 06:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7001:e18:b0:512:fc21:e85 with HTTP; Sat, 14 Oct 2023
 06:15:56 -0700 (PDT)
Reply-To: tchalimbenson@gmail.com
From:   Benson Tchalim <elkettanimohamed85@gmail.com>
Date:   Sat, 14 Oct 2023 13:15:56 +0000
Message-ID: <CAEnN6K4pjdq2=RNETQs7FB60HpDBsEPK4BQv1WA8sm2ZLxW_7A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Are you still using the same phone number, I have been trying to call
but is not connecting?
