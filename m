Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24166775E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHILvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHILvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:51:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6D268C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:51:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso64601035e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691581863; x=1692186663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YoLJg3uyNcm/pmOxJC3Fq4ZGphQKyXSORQ4ZI59PwTw=;
        b=Shh2Zd48mx3fxiY+RfLxt9LreMcopPayjdhzWCsQ0aOlpMt+DEgm7CHOogbnMTpiNF
         rGU7UN4wv5Z5VNhAfuSu9kHzWnySIEP3QJPByVXvQr2SpfzPSuEkGcan2U3ecsSyY/+F
         FxrPDUtGFcdf0BFe5a6+B6It4wpEtLNxmW9qLtlVgx2aaljsUAbhQ27IpXqiEpi6xA7H
         wZ87wojZDTPqd7DQK9dTg6PU/ox8Y8RTDmTquySxABH9B0ZFCT/GrbHFNcIuEXvDPnQz
         KNLVxuiC6KFf6mTP2hAFrvz2frKZXifRphR1NbQ5FfcKOt2Y7rt3phELOHpAkiABes82
         zmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581863; x=1692186663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoLJg3uyNcm/pmOxJC3Fq4ZGphQKyXSORQ4ZI59PwTw=;
        b=BX5OvdFkVhxu0n9B8DovX1lGPBHu7eQ759xyPnCtjnEA/krPqiPoDniEBgjLItuFG9
         kYjUpGyME1JGnudDYfC0oPfVn5hYrv9P4lSXlUlrCG0nEFA36cOx/FootEpLqz/WN4eJ
         ml/+jDYHslnHvWHlzXemNB8n5J2/+YhMTGsAsrkF3cGchSXNvAjhXgQ/fcjl66RkBjDY
         otxE3czSlDKH8C0Ng/Ptz5+j3qnass8LUDP/TkdCl03dr8gnuyYRtoJ7FehtIGU9/Oyq
         DCaMmK6KU1xiJbyY2x3qz/ASksZxo/iVIM9lCxRdXV+x5UDdPDM2taMm2cM7ICEfMRSZ
         cp+Q==
X-Gm-Message-State: AOJu0YxDyB1CFvObdWQ/YWsE/SekDFGbNepu3QUw8dqQRzJ6AddZ2R/S
        uudKl4RgcTUXpSqccMkkJwoVGA==
X-Google-Smtp-Source: AGHT+IGU6k4Sf3I3QTFLY+ZsNUrN7WVbqQSddAG5CXHZrLzSx0iHlwACOjWrAI/vNBghQwK9k8bQWA==
X-Received: by 2002:adf:dccf:0:b0:314:3740:7f69 with SMTP id x15-20020adfdccf000000b0031437407f69mr1671678wrm.37.1691581862922;
        Wed, 09 Aug 2023 04:51:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b00317909f9985sm16547116wrj.113.2023.08.09.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:51:02 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:51:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next v2 2/2] mmc: sunplus: Fix platform_get_irq() error
 checking
Message-ID: <9c7a69b1-9ee3-4676-8d3e-9f12e39b37af@kadam.mountain>
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
 <20230809071812.547229-2-harshit.m.mogalapalli@oracle.com>
 <CAPDyKFqHnHCpsi+GBAQ2vmESf17rDMGyUK+EtZbhJT5AngvmBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHnHCpsi+GBAQ2vmESf17rDMGyUK+EtZbhJT5AngvmBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:33:51PM +0200, Ulf Hansson wrote:
> On Wed, 9 Aug 2023 at 09:19, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > The platform_get_irq() function returns negative error codes on failure.
> >
> > Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Applied for fixes and by adding a stable tag, thanks!

It's not really a fix.  The platform_get_irq() function can't actually
return zero.

I asked Arnd about this and he said that there were some arches where
zero was a valid IRQ but they're not in the upstream kernel any more and
we're hopefully not going to do that again.

regards,
dan carpenter

