Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41B810ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbjLMG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378654AbjLMG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:58:08 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8CAC;
        Tue, 12 Dec 2023 22:58:14 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fab887fab8so4939142fac.0;
        Tue, 12 Dec 2023 22:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450694; x=1703055494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DAn5xLi9rQnaABRWF75LVLMVJOq3CUle8klA98StY8=;
        b=l5grFS/cCA+bTXfPvDq9MUiOZwfLFvtOPLzmUG4BT8tpEz3dduWugXLiEbTIweYp5K
         rzZFXZ4gmLcPw3oNxY5ji3ofqyuPhx0t7cVOkDvF53hJXD4jxfH6GLht/Z/NP4QEK/t0
         A5hKjyIqnG2nE274u70M9+AA6wvCHtBRDCHLwyiQvr6qpH5HdifKvFkEl4SCHDIuL319
         BOHz9f25lsx4XmMlVK7DrMCeV+IvKQKSi7N2P2gp6unbVsaHBuFIN5bgleMYEKCfwnJb
         tKuSqIyVmfTPmz80EOaSCJECQtSR8pFh8lfAxRK3xtac6KXZ8gxpIA5jbyiPyOmUrxbB
         ZNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450694; x=1703055494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DAn5xLi9rQnaABRWF75LVLMVJOq3CUle8klA98StY8=;
        b=vQKj5+gAy31b8yquRyCY0VV2uLYGi/kHkFU97qKXTE6IGfXrx3hEMiodX9/qsL09+j
         jWgzrpZkW7HhoqtAfAvfxRemI8LVaInIAVc1wqR82Dcem6qw3kFj5rftxLLc/0QL4OXc
         /KldfxrCN1FfQPchYuPj3SxtLGoWCvHi6qOUwb+sW61LA2sm+h0IPLL4orTCXoOYulD1
         QtygA1nOdf7jYt/p3Uu7j6A7VGXkitYzCu4G2C/Dfdahreqz2/OUeDXNVXK3ofgSVh8U
         nRtYjgw+UZsPdutPdYufN/EcpHUTmySrdB0ppEaNZOEMiy/kJ7KLTBoGiNo2V1V25Hop
         qADg==
X-Gm-Message-State: AOJu0YzgSa/XoF5+8/Gi4nqnkjJUBRiD2+oOfNkgVLDq9Gx6wspNdTCW
        cKBkbXrvIk0d5sYiGxpCNpU=
X-Google-Smtp-Source: AGHT+IG3c8aFQUtCtrW1AZlRJzMEWQYIny2RwUFDnEd1Q7XPoItpD5A7t0a4K7dj7raZf46hIApPcg==
X-Received: by 2002:a05:6358:3393:b0:172:8991:8120 with SMTP id i19-20020a056358339300b0017289918120mr600911rwd.60.1702450693543;
        Tue, 12 Dec 2023 22:58:13 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id mt17-20020a17090b231100b0028ae58d4435sm590399pjb.28.2023.12.12.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:58:13 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:58:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     oliver.graute@kococonnector.com, u.kleine-koenig@pengutronix.de,
        jeff@labundy.com, nick@shmanahar.org,
        giulio.benetti@benettiengineering.com,
        michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
        wsa+renesas@sang-engineering.com, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: =?iso-8859-1?Q?touch?=
 =?iso-8859-1?Q?screen=3A_use_sysfs=5Femit=28=29_to_instead_of=A0scnprintf?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <ZXlWAlufTzIAk-QM@google.com>
References: <202212061148163560976@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202212061148163560976@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 11:48:16AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Oliver Graute <oliver.graute@kococonnector.com>

Applied, thank you.

-- 
Dmitry
