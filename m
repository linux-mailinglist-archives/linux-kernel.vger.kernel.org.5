Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE577F7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351579AbjHQNnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351586AbjHQNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:43:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07373106;
        Thu, 17 Aug 2023 06:43:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc6535027aso65044385ad.2;
        Thu, 17 Aug 2023 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692279802; x=1692884602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ekX8+Nd4VswfjxOCjX+b1kzoOwGdMKAd1QgVJxzyBU=;
        b=Kb9cGdIUJ0pBbOrseOO9IQ5aUYDBPMKlfAlIfS3ERPMbNVKWjoRLyYdPYxlYfnmC7l
         E1a5RY+EERyITC8flXmGnLkL3D3IrFnF4s1bTvIYk1PMwgxiilOvCRvtS9krMRtR9q8x
         V8VKQaRMEhaxBGxIgEQLVsjcHK2FMj+FvnqZAG8fD+1mpc/+QFwwJPC0TTmPQZZriNsW
         wkNIRb6bMaAheQVBq6QoVaMv/wpIQSq0jObm1ZdQkOTqekemuT6lHF3aDhGqRmUzqQQg
         5XzAsmUXL9kThS7cV+OLu1JPZEHSVYVSSQD/DVkSyuLX7ApNV93YlJ0vajgwmd849qaR
         Kn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279802; x=1692884602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ekX8+Nd4VswfjxOCjX+b1kzoOwGdMKAd1QgVJxzyBU=;
        b=CYvPYF1i6inIpD51NR7rtdWazU3+H8+GtLfz3YxQSJdgZjPZKO+cSsdr+vDPVrB089
         esdUAuFwanxWrSTG5RRFTvajY9tF0U29x9oqAXw8oB+v17qprj7nHxGrYF/avuJM6clS
         BMuwnCx9f/CJG5PbLY6Y9A1iIPmkhI1Y1z8sjadxKogAcUOeaZwBn9j6Z9YPBdX5DrUP
         lIUwkwoA0MqlxsshYnhTr9j2u3HSUPkRANadfBK2YgpApbanbd2KWdZ4sD1eVBV6RAE0
         1h7NA2qn0/1sX/HZfaz4SFqmWLL2Pa/5M+3M2QyftktBdZTiUUeBl2u0t+lnk/LGHLo3
         cfQg==
X-Gm-Message-State: AOJu0YzC87ekHyZavuoNF0rYtf4clvtijJwPYp/aB2umuS9NRtPO4/C6
        nkd7tjxp9Ck3WE6jjQ9r6gQ=
X-Google-Smtp-Source: AGHT+IEWOn7C6DJ0dCJItiCXw8kIj+QzmbnlW0Rs/bE46okrUgBCh1xMLw4dXb20goVTRd+phIi9dQ==
X-Received: by 2002:a17:902:ec86:b0:1b8:400a:48f2 with SMTP id x6-20020a170902ec8600b001b8400a48f2mr5532154plg.62.1692279802386;
        Thu, 17 Aug 2023 06:43:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001bb6c5ff4edsm15234511plc.173.2023.08.17.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:43:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Aug 2023 06:43:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 7/7] rtc: rzn1: Report maximum alarm limit to rtc core
Message-ID: <ab8d6d2b-f5db-4d77-82b9-f9c4f773b974@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816133936.2150294-8-linux@roeck-us.net>
 <20230817100341.15867e4d@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817100341.15867e4d@xps-13>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:03:41AM +0200, Miquel Raynal wrote:
> Hi Guenter,
> 
> linux@roeck-us.net wrote on Wed, 16 Aug 2023 06:39:36 -0700:
> 
> > RZN1 only supports alarms up to one week in the future.
> > Report the limit to the RTC core.
> > 
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/rtc/rtc-rzn1.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index dca736caba85..c2cc3774ebb8 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> > @@ -351,6 +351,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
> >  
> >  	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
> >  	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
> > +	rtc->rtcdev->range_max_offset = 7 * 86400;
> 
> When we set the alarm, we use:
> 
> 	farest = rtc_tm_to_time64(&tm_now) + (7 * 86400);
> 
> What about using range_max_offset (whatever its final name) in this
> calculation as it will be now set in probe? It would further clarify
> its purpose.

Excellent idea. I'll make that change.

Thanks,
Guenter

> 
> >  	rtc->rtcdev->ops = &rzn1_rtc_ops;
> >  	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> 
> With the above change,
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl
