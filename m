Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1877E0C2F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjKCXYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjKCXYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:24:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8129A2;
        Fri,  3 Nov 2023 16:24:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2800db61af7so670789a91.0;
        Fri, 03 Nov 2023 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053891; x=1699658691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u5m6dlQXf6Wo/EeO3f8wkZCknJ2zjID8Vb7+EIy4Nc=;
        b=lT3Dhm7AwolRs7E1GIYht3QaAuGAP1YPXz6DQpqc48ss8oQCh5vwOUV+XaNmep3aYG
         1k4V2AnAmV3XNx4AVafZoGkazCPacouc87ePcekULi/MKgDFYxRZUyRbL9j4p7e2lxuj
         YOKRZAk0Z5AZsjkffhmQD+ALKNSAyFPRQo4Vc8/oRtoDC8YzazL/tO45SIvEKMFY0Wrv
         dfmzB7BmGY113TKGu/Jedv/QOVXzvTYxeDjGyAz0Ou/9jiPNqHtv0qvYmkJMN7+rWwel
         Sde7IRaanS/zYe0IV5eb10M+qfiSdnO75hX34numZWkHdBWjyPiGmNg2FAxTRvp7WEZ8
         ajMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053891; x=1699658691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u5m6dlQXf6Wo/EeO3f8wkZCknJ2zjID8Vb7+EIy4Nc=;
        b=uJmBVwZC743FYx9sDq/iRRU1YBy+JmpX54c09O+mzddbozZFz6yDqviKN3V3taq0nu
         xkTDujGW4XNaPWiNGvXauAJLz2DYw/4306lJIyfru36kNzArB3lSS+3otcaoWee2IwRY
         fhIV5lWrMZISX+lPYBOVujSTYaEvmjLmiMqd8T1QikkaEeIcYb4B4PIweGVSPvoAm3nS
         LIVOPQ4QPepC6sS/jkUUIDyn4EKalG+5oag5sRYIyfL/j/1KtG9+IG50YpQU93NzuOHS
         5gOr5QPWHpaR/vW2C1ZfdO9urV1FDh4tBXhydKM74vbObWCNc1xy3JRofgP0f+3qNJ1C
         F8+Q==
X-Gm-Message-State: AOJu0Yxs3XL3mgOI6AvWUusgugik500D8BjS8RKpf59HGB1xgNylQ56j
        Uy6L6/BmfdpMvMr9Pc6/tco=
X-Google-Smtp-Source: AGHT+IEEZtMYlk0JPMSDzLWF9UGamGEv/PI/eyLfuAHH+bMh2n6k9oJ+4aKZ8t1rRgg+OWOQJoI3vQ==
X-Received: by 2002:a05:6a21:a59d:b0:163:d382:ba84 with SMTP id gd29-20020a056a21a59d00b00163d382ba84mr28833842pzc.5.1699053891063;
        Fri, 03 Nov 2023 16:24:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00159600b00687fcb1e609sm1890574pfk.116.2023.11.03.16.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:24:50 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:24:48 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWBQE7vfBXAVADq@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
 <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:18:44PM -0700, Richard Cochran wrote:
> On Fri, Nov 03, 2023 at 09:15:03PM +0800, Edward Adam Davis wrote:
> > There is no lock protection when writing ptp->tsevqs in ptp_open(),
> > ptp_release(), which can cause data corruption, use mutex lock to avoid this
> > issue.
> 
> The problem is the bogus call to ptp_release() in ptp_read().
> 
> Just delete that.

Like this...

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
