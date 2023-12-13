Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C501E810AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjLMG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjLMG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:57:28 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019199;
        Tue, 12 Dec 2023 22:57:35 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-589d4033e84so3815069eaf.1;
        Tue, 12 Dec 2023 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450654; x=1703055454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0VCk3MHUidn6Ccs8CBuDFAbju1kc7PhPe0+uu5yowo=;
        b=TVjIdV0k38zCl2sHMexMIn0ARARd4tvi80dPo57iwGiUDe6+2MyJqLj4t3RQxlgSoU
         VUuFj6g4auPzCeJoMaiwA5fAjyH7AoGXqNo8ghWgoFusjjm52p7qe3DmdUaSui2sLRvr
         GbDp3btwhmGrnjErZWBFHpAGj1fTE2+nKA8JAh5+CBmGg7Y2Tw+2UWPp6pPedtF/wniH
         6nNBMacRuhXILHuh3gq8H7DsHcPXxXfirJQD1C7Z4cXBzVpC8xa5ViCUbZvX2czTQvAC
         J4V4XiKnbVLZe2zlWKnCpe0PZblFjuQFsNn0oq8pKfOaxsaMC8zO9pMx7swrWbrhpoZB
         F3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450654; x=1703055454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0VCk3MHUidn6Ccs8CBuDFAbju1kc7PhPe0+uu5yowo=;
        b=Jsb/HrnIm6dnEDUq0lsPw9vxFpb3hBm5vhdhD6JJ5elMHbaPPSeDH/iSEyDT/Xaabk
         VXnSXSyR29wtgFm5is4N2xiwOy1LAwMIeXbPytBakCiJpD2bRDtBwNESFaLrYFCRRA48
         B7cnz5gN0sFoxvyuj6/E0fVrdcBEfFm38WYKPR3J9IAi9bVOkkqm6QTBw51UyIEI76vs
         gkDy9xanPBtv0V8rxNPEO5VBgTprCGNuHv3EpUrgA3esc6YOR43vmCsZgei3v478kWfD
         4n1sdLjYdyqG1dbKWHb5KN83OGagayoFJYAn5ocR+eqc9ElrNkmqC+0KoA2gGEFRO1a4
         /IZw==
X-Gm-Message-State: AOJu0YzNH16jPJc5rR37Pp1uhLIECQZ8PKrTlXxXyO7e1/87T0OvvHpQ
        2cZlejhX6bbmrS1Zk5GdGta+jdmxO/5yzQ==
X-Google-Smtp-Source: AGHT+IEZWt6eWD5GHQZmvTvf3FrZ37z7cXnierx0wfME73jgwdVdakRMkXbP6t6C5f+phC4naJpZ4g==
X-Received: by 2002:a05:6359:4282:b0:170:64cd:8aac with SMTP id kp2-20020a056359428200b0017064cd8aacmr8632806rwb.62.1702450654414;
        Tue, 12 Dec 2023 22:57:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006ce77ffcc75sm8280883pfj.165.2023.12.12.22.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:57:34 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:57:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeff@labundy.com
Subject: Re: [PATCH v2] Input: use sysfs_emit() to instead of scnprintf()
Message-ID: <ZXlV29B4x3q1Fe88@google.com>
References: <202212021133398847947@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212021133398847947@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:33:39AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
