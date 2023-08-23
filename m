Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8816D78527B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjHWIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjHWIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:05:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550E171C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:04:34 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d749f57cb22so3267003276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692777873; x=1693382673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x18HgxcXuVIfqokI9MrmvgHbYOVzb20sqxbnbY2CMg=;
        b=BHPJJYWgI3y8TP+PbXbXHe9EoUB31NFYFuLKGqC5SqPy+mO00AhzDYg37HhppnIFo/
         SgZQ76lABeqqefWejNA8ZYtuNbl4+Jti7DDluHO3AdrC089eSQ7E0sQ8fO3c01iULqQe
         +HPiFlsQiTi72puH++Rr3EHGb/gykt/ga28g3Ed48yIX9X3yf3APdqmO+ZpB6au+26e9
         4Jq1uAwaTcoua7wJzglFidCTg03+QAN3H/A0wXe1BdIdY1dCpP+HY9KUJCDhjVGPeW+h
         ElbRVjE3M6iDP/2zT3WjFNr3GZc/lBkpl72tSCK61cxQqfJqTeIXP1H7FurNxCVco1KL
         vg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692777873; x=1693382673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x18HgxcXuVIfqokI9MrmvgHbYOVzb20sqxbnbY2CMg=;
        b=UFgAn9vDltYg92gFZplhoZbplE4OvmlGFdkF8NbOZh4Vu9a5O0AXHK3vMDNGoAiZFX
         eoqoF0vqR6OVCaJkBSdD0fhrvkqrZChBUyCpTdZ7iP4G8xwqwfy5pK5XAAFiKRbXviXK
         rJKHigm0+RUZKrWaZcWgmQ5IzOYZf138NHegHGwuJS7VGPGdFmQ1vHRRAXhykSMcMKwI
         JFUd4ka3hqXS6giK6+m042tJh1EReOq5pSobC6mXgjleoLIVyvJPlijOMdj4w7eTABbW
         3vBGzZl6idNQ1YBvp9udJWFu4gxqwmBn+M73NXnsjt12ICUvmdG5N+ExI0tdExlIafkN
         anCg==
X-Gm-Message-State: AOJu0YyXjBUFniWk+tAS8knvJI315XkQRGuG8CPRQEb9K4FZFWEPBCF9
        XyM/uHvGd5CRXeV0GVbAHqBHTULQWkbCSy94SpbQ/A==
X-Google-Smtp-Source: AGHT+IGrOMMEwVtHryHwU0XzgH5J6pb+GFBjuvEmvNHq8LAg555gZ6ClRom7dtM4aWc9Doh+9kYdPlPZ/Q8JzX59BZQ=
X-Received: by 2002:a25:aa26:0:b0:d56:7556:93f1 with SMTP id
 s35-20020a25aa26000000b00d56755693f1mr12580669ybi.29.1692777873522; Wed, 23
 Aug 2023 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com>
 <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
 <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
 <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com> <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com>
In-Reply-To: <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 10:04:20 +0200
Message-ID: <CACRpkdb=AnJXG2J_DRsN-RUEh=7_eAs8+_CxPYuueVM0c=DP3Q@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Shyam Saini <shyamsaini@linux.microsoft.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 9:07=E2=80=AFPM Shyam Saini
<shyamsaini@linux.microsoft.com> wrote:

> do we plan to disable access to RPMB devices, once we have this RPMB
> driver in place. User space tools like mmc-utils/nvme/ufs utils
> can still access RPMB and programme the key and should
> RPMB driver deny access to RPMB ?

We don't break userspace. Just not. This is not an option.

The RPMB subsystem simply has to provide the rpmb character
device the same way the MMC subsystem did, or provide an
in-kernel backend to the MMC subsystem so that it can provide
the same device. Whatever solution is best.

No deprecation and deletion and breaking userspace. Ever.

Yours,
Linus Walleij
