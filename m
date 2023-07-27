Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A987645F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjG0Fn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjG0Fm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:42:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD830F7;
        Wed, 26 Jul 2023 22:41:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317716a4622so565210f8f.1;
        Wed, 26 Jul 2023 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690436430; x=1691041230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xUdM1bpBbzKpESSPaaGt87IpVcVmVbZ5/1wy4z5/m68=;
        b=HSKJW0FgwfOoj8r1z8v+TlEikm2SpEOyq/rYhyqE2EK2VOHMzFp0q/nkSA7WTzsfcu
         qEMjzRmvbYcwB38psAGQBtaazMkUOuegRtdXnNpGG16NIgJcJ9MU2xyr6ZMdUHGKqX21
         auuBlNglStSZIJmVaF7Bu8EQwRSHod/OTvokuQzgsDrldYtonLVzL8NlDvMlFpKzDyUI
         mJ3kxowIMUTFffvFNQ+c0HHxj8lFVrTVL9aVKT5Q38Iw0o+HsApTAtDqgKKSyd0D97ZR
         2Av7BxOaAs5Mi0FX96KYoLgQsH4sI8s0As5yPCE6idmGdzmJbZyv5mn7qzbfdTR2KeXY
         l2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436430; x=1691041230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUdM1bpBbzKpESSPaaGt87IpVcVmVbZ5/1wy4z5/m68=;
        b=BeIHrEwnnXAYU1TQR0UGwu3Huw/n1A6ZxbPPIlViS+fY2UWeG1/xTqFXXcpj2UCd9P
         6p9ezeFlSkVpzvHyxpjopFFlzBp3xDHeCtgBdrEHtXaqzHYSqqaTGzDqAf0cZ1ZY6Q37
         y6sr9U57EYJGZ1ZqyOckNKy7NaMPWaykHVCJDWg9eBAyxgUjdkFKeuxFH3UZsb7HxFBq
         JNI3RjJJvCB554HwZypWUuZFdPMd2dNB4+fkxXMrv0mr+T1o/LmX/htD1JYSFVa6Hcty
         RQQrwy2t6U02hmbMiJBCb6NVELGfstBaucLn6q2UWa9VvK/TJYmjJQGObYc0JJGarSqz
         DKsw==
X-Gm-Message-State: ABy/qLahPwmCTPJlOK9Bg/f5uBuMVNJp9GOJhB4vmjzAa1D+OEuZhr7T
        gMX/svdac/HtnoGsIu+D9nVKzRpInCG+nGH2CuVQzMQk9sraxAQ7
X-Google-Smtp-Source: APBJJlFfvEnnSRPWQQUpIgtzFG/33m2l9VH/vDw3R39SRyKbG7JWCgIhVNv0uZl9iDuNmzLosZbjOErzLURnVTZ5Y0s=
X-Received: by 2002:a5d:4a42:0:b0:314:1b36:f440 with SMTP id
 v2-20020a5d4a42000000b003141b36f440mr751145wrs.70.1690436429984; Wed, 26 Jul
 2023 22:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726155342.51623-1-dg573847474@gmail.com> <CAAmqgVOZwYS_TintuQNrE0go_Mxwk3YFJZA41Yt2S2isD7JW_Q@mail.gmail.com>
In-Reply-To: <CAAmqgVOZwYS_TintuQNrE0go_Mxwk3YFJZA41Yt2S2isD7JW_Q@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 27 Jul 2023 13:40:18 +0800
Message-ID: <CAAo+4rWOgZvOtUk4_mGALcZOsKObPhvnkbNMG62sM5=qdHduLQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix potential deadlock on &phba->hbalock
To:     Justin Tee <justin.tee@broadcom.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Thanks much for the reply,  it is my negligence of not have noticed it,
and sorry for this.

I inspect the bug report of my tool again and just find that actually
lpfc_sli4_intr_handler() also acquires that lock.

lpfc_sli4_intr_handler()
    -> lpfc_sli4_hba_intr_handler()
    -> spin_lock_irqsave(&phba->hbalock, iflag);

It seems like this isr is called on an SLI4 type HBA. If consider this
one could it be a deadlock problem?

Thanks again,
Chengfeng
