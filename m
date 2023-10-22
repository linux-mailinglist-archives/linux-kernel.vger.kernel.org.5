Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3B7D2314
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJVMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:13:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2EDC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:13:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c8a1541232so19892075ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976828; x=1698581628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BZxhGQ28bcDNiJWnqZ3AsEPoFN6rBfxD//AMxuy/10=;
        b=UPeRVwN/9GTyv7oeghmm+riQ/iqdFd4RYdPwogKCeNrD/+sMf27GPv/VU2YLZD/UDe
         vh5QymugsYwWbMg/Jt20rROCVUA94Ils4jQ1CLjI83NuX3f6epFG8fbqeKjbL4LkzWTY
         LGD1Hil6eNtb677TeL2w1VAb0KQ1vd3cyxMYV9cKE6Bt6CbMoUV1GCXAjfrdDOTnuztt
         1Pc1xlWYJTV9Po+DHPxzcfHL4AYRUvcRYBsDcVvW8G3e7rsYiM4KIjTlHrlME8uWwlH9
         jYwdpQdRzbLoIAwMDU1n7jHf/kBxBdCqsDwLfKPLsB2k4Zz5Opp32WeKJLoLEB/xaQ46
         reBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976828; x=1698581628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BZxhGQ28bcDNiJWnqZ3AsEPoFN6rBfxD//AMxuy/10=;
        b=QfF/N/lzU5H/MITd/aOMqtcc9AS9IRnU+0ChV0f0pkj+LN/9oNmq5TJY4y7oeH107z
         TzPRfI/GPNnQxV+4SO8CdWmgfcOiI6XneSL+6Ux0oN9ARyCjDzlGlesllkpu2V7/Xu6s
         UCD10ZfYfzGcrf4M8/qVKykn2EgGvfsWQmJTE3INTt9PH9dIf2GyruVW46E0iPqo8fnO
         BQ39Jd84qamynXPxdZgHEdahSa2kpgWgTPFKnPNoo81v7jPupJIRfOQP1dHo3OhZxEWg
         hhJ/WGbOx2a/1VoG2f1r1fSQpc1p5jCGuAI1MUo5XOxjQNlgfh8Zsr6nKyvFiZaIrI6x
         3H3Q==
X-Gm-Message-State: AOJu0YwAu892vjKRtV9P9oadaeasfkGTFjgtQaU/rIOCvE1ZZNOe8VTU
        hRdFXi/0ZfxkO+iXVZZTr40=
X-Google-Smtp-Source: AGHT+IGYz4FShfhO8IFsqj3LVS3VLm7MdITeOG1iGHqL7abwGfQ3F70w+8t5XMwp0sIOpsBbfJg1eA==
X-Received: by 2002:a17:903:1252:b0:1c9:e774:58d9 with SMTP id u18-20020a170903125200b001c9e77458d9mr7960726plh.34.1697976828445;
        Sun, 22 Oct 2023 05:13:48 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001c771740da4sm4378625plb.195.2023.10.22.05.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:13:48 -0700 (PDT)
Date:   Sun, 22 Oct 2023 05:13:32 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH v2 0/3] staging: greybus: Coding style cleanup patches
Message-ID: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset performs code cleanup in greybus driver as per
linux coding style and may be applied in any sequence.

v2: Ammended wording in subject line for all the patches
    Suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nandha Kumar Singaram (3):
  staging: greybus: camera: Alignment should match open parenthesis
  staging: greybus: camera: Modify lines end with a '('
  staging: greybus: bootrom: fixed prefer using ftrace warning

 drivers/staging/greybus/bootrom.c |  2 --
 drivers/staging/greybus/camera.c  | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.25.1

