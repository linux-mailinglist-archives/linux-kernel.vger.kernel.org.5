Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01607F4896
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjKVOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjKVOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:14:02 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E496110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:13:58 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f060e059a3so4009438fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662438; x=1701267238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcmZVxrbcRc23EBBsMzMg3az+uJ3xujBmlpT02W14Kg=;
        b=CKfpvg1f0XtF253qwkkCCKQPgQ3MEAQfWz+70iXjbDyc/dtb4VoIi7pG6XuAHjvezi
         bN0+Mc1vx2eEOSrjErbZmMxvtZzll3nNOVxERF4hmJBNd7z1FCy+qx+9MnZ6NPDVg94a
         RG7ZSdNqKkxoXSrLVz1wToGvMwsLCv5U4rnEb1E5tufcfp6ftiSad2uPQtNbXQXue9GO
         jsa6bXeNTEzO+EhzgJIoeSo9cu+Z/UipB0+XVK2VmLNSwaMoSD0fwJAKes0jfvJmzld9
         erk2/QO+maDNy1qxY6gcyPyVC3sRksxuY257FJ0rU6udpv+IZauYSv1RVlswlkTg48cG
         XVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662438; x=1701267238;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcmZVxrbcRc23EBBsMzMg3az+uJ3xujBmlpT02W14Kg=;
        b=EDmdov8XNhZFeJS2uNBXJPHAjL3DyzGeFYAJL5Jxu6KJAGHK20FuvjJUIIf4RJxAtT
         pIQnKAnBzT8R5FJ0MtTyU8rjzp/cg5t69venfkSMdju2Vn2+o+qYJ+fDg9lpXNS1UTVV
         sW2zWuaphU7fYMInAO3PWb9cVcgnGN0spnHna9OorZf8zCnGj2mgkdkwjmy663pG1JsT
         G//YQItOylZJQGyV9GbMbd3CJcU4mTcRDJV6KMOdT40Qlr5NSyKyOmgcY6hMjbzGkEYw
         TD3Im9APgP+R4dWW1/JoVxKxgRzK2cjkkf1NieqH1gm4P9nRHDfinAts2P5liUy/6kgD
         Nsxw==
X-Gm-Message-State: AOJu0YxrZePW6fft2cIA6JdxP9xPfAKDlalR21zA54kPF7UrmeZk2nAO
        QPVd5WVeiSRR8RmX/vqJu8KnTO8N/H+1lwPE3pGhgA0qbPYYvMuX
X-Google-Smtp-Source: AGHT+IExCgbzsvdEhxeHyQlWxbsCi4VitxN/f7zqcWbuVIBSGrWCrRrtv+FbOiiY0V3pxrBxX/WLwjd7HdwYr4qr9Ok=
X-Received: by 2002:a05:6870:3c87:b0:1f5:ccc2:b21e with SMTP id
 gl7-20020a0568703c8700b001f5ccc2b21emr3552962oab.41.1700662437775; Wed, 22
 Nov 2023 06:13:57 -0800 (PST)
MIME-Version: 1.0
From:   Bret Joseph <bretjoseph@gmail.com>
Date:   Wed, 22 Nov 2023 16:13:46 +0200
Message-ID: <CAKpemQ+OFgSjyAERZqKWv3oMYVEvmURdBkmNZtESxQOsnYarKg@mail.gmail.com>
Subject: mt6370 i2c error -ETIMEDOUT: Failed to check vendor info
To:     huang@richtek.com
Cc:     linux-kernel@vger.kernel.org, zhiyong.tao@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get the device registered. I have the device in an I2c
node just like in the documentation

DTS code

&i2c2 {
        compatible = "mediatek,mt8186-i2c";
        &pmic@34 {
                compatible = "mediatek,mt6370";
        }
};

It seems to time out during probe.
          regmap_read(rmap, MT6370_REG_DEV_INFO, &devinfo);
returns -110
