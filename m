Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A0782707
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjHUKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHUKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:24:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697F110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:24:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so4744794e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692613453; x=1693218253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWv+yavI21hdsA2de00od+06jOmtpq7dA1Gt2U3Tmd4=;
        b=Bl2ipkAGcmqDcfVSVsy7Pp3HD0/J072C2FIgVM/8QDsULWGsugbFxywMsoKFWvEsI9
         qoU24aH/aNwrOG7T/O3X3fHX7kdeilDXCErcXHkmcDmesJ37cWlx9fWd8KDtkCMpZMD9
         t+4vTlb51DzisD58O2eAXK0R7vm8N4ktVpIzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613453; x=1693218253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWv+yavI21hdsA2de00od+06jOmtpq7dA1Gt2U3Tmd4=;
        b=LunsrQroTQxTGpvWLCMLvqYukfx2tFQjn1GR9vXOcZ8UBSdIrKdnv2zPm+SGH0tJq+
         /cvRl3GxeFfZsmyG5xgJ95EO2paStoq/dFc1vbf3bxFRYDAvndXK+/12JXDAHbYValI7
         vAu07VIol+adLzl9vGfMC/NrFIxy+Z0HhxPgXAV5mr7LkXdeMSPBrC/9yeaMdQKOMn5Z
         /bZHBhk/R5sx/x5iCH7veS8Dgul5zvQ8UBEe4PaA7185/2gIAcBo1GDVEd4GxXnDxNiH
         3EDafpCcBS8FSLG+bTUDvjq2n0CWHnuMaFOGEZMoKzNwGxGFCsdtRN14OGa5jrihHXNg
         vnyg==
X-Gm-Message-State: AOJu0YwUS67Bpqedq27kFE/xbaauJpwtxT2I+EBhtU4vFXd4EsMG1mvJ
        s6o+TPb+/oFlvRFNBgKkAMKdj1LgakM9VXQc18Y0vU31tCfq+lpeqxLHKA==
X-Google-Smtp-Source: AGHT+IE+mwwGj+mBMcFDaSMSAuehg+IW9Lcs9ljpWmTtT7EBLkeGsjqhyBjmwFaP4ISNECXfDcDcoUo3XCYByc89cfU=
X-Received: by 2002:ac2:4c92:0:b0:4f4:dbcc:54da with SMTP id
 d18-20020ac24c92000000b004f4dbcc54damr3439503lfl.27.1692613452642; Mon, 21
 Aug 2023 03:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022453.99043-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230817022453.99043-1-jiapeng.chong@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Aug 2023 12:24:01 +0200
Message-ID: <CAJfpegsN0HNBALcHNatFq9-21vyiP6k91gbdLTd_e_HhKxQqqg@mail.gmail.com>
Subject: Re: [PATCH] fuse: make fuse_valid_size static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 04:25, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The fuse_valid_size are not used outside the file dir.c, so the
> modification is defined as static.

Thanks, folded.

Miklos
