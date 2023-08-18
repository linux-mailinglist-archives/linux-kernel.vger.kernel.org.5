Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80AC7803D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357256AbjHRCdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHRCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:32:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA4D114
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68859ba3a93so390689b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692325972; x=1692930772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFph4ySbXN61+e7h1mFNXgd12ZG3z/7VSWDwoBYZoOA=;
        b=U7tz5yRaMnDX036ltTYyjQCbCNKEFwJ3tPrsxtspHowWVckoqdDfAsbj6WsVs8xkVN
         9GnhI9PdjGWy0HIZ5aRdEbmpP0sCE8jWQpmkLndwJpVoaoIVRAsyevoFM45/pf/YdCTx
         HRxGzy7+LlaR3rLr2Ouzu/yTFuYmiQMa09QUtKa2US2HVJ3+0zu60+PHm9i7Uuuh3Xjx
         4dcS6UurBHKiW7ZUA0OqV3rx9PEX4yjSQpm0x6xHhpuTn/gkk+x6jSl0qsjCdE1PeEB5
         YDdaeNZdTgboJy/IDqSrVZfSlGzhSvCRLv+bH/uqzE2AvyOssKvVMoUsX+NmP6UwzDh/
         scGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692325972; x=1692930772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFph4ySbXN61+e7h1mFNXgd12ZG3z/7VSWDwoBYZoOA=;
        b=LCoOOfui1WrC069oA5i7tXRRNujPDUZWaewtrSC3LkVwDXvYyCUCZKAxNdra+I+0g5
         3eQ0f62wREVBFNBw4ZOjSQzE/KFcpMqdOLeFvmaBQ5aDm3QsKqxp/pPyZoZTaIhdwaus
         Fmu8W/DjgyafXgbaEBhzjWST7XgE/FbtxTbcw2l1y5MieMnS5DgLAAmHME9KBCUKT/E6
         +N1daztwhTR24S6BrMAibN4SbbjsCrAr4ZKC8QJ7NN6WkhjpfE1Hy2/QjljPXVHa05XK
         qK75v5Szf4MbmYh3i9H6p0YrOPgEsh803UK8m7SptR5QtdzRaCspffJsTALL9sxYIAtf
         PXbQ==
X-Gm-Message-State: AOJu0YzpEYDappqWJkceKmTDrfUMeVeEIjT/7kVNNr76DclOykN4ogHc
        WL8NoB61WWk6fwX9Y3ZzOH1VdV4XYCk=
X-Google-Smtp-Source: AGHT+IHODvAieJuO26vD0JvupjsdEzzjtIEfZRq4RTLiBMYWXuobV4pJSOuIJl6iqIFoTgNTys+AkA==
X-Received: by 2002:a05:6a00:1912:b0:687:3bc2:58de with SMTP id y18-20020a056a00191200b006873bc258demr1515735pfi.6.1692325972269;
        Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b0068713008f98sm424134pfb.129.2023.08.17.19.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:42:35 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 3/8] erofs: move preparation logic into
 z_erofs_pcluster_begin()
Message-ID: <20230818104235.00005603.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:28:08 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some preparation logic should be part of z_erofs_pcluster_begin()
> instead of z_erofs_do_read_page().  Let's move now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
