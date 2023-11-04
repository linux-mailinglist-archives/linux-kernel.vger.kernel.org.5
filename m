Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0B37E1015
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjKDPVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:21:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09301BF;
        Sat,  4 Nov 2023 08:21:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so971782b3a.1;
        Sat, 04 Nov 2023 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699111260; x=1699716060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwi0jNDl4gJYKceItd95VpjLlRi3/UlXBw/STpxKSqI=;
        b=ZmKLNfv62KeeFAJCBQ+0efTqH/OFlPRSXJtV6BqWbxuK6dEgyiHpkwbqOxlflXg2zb
         yJ6Gcd5aOUN5zIWTF6FkPNKNQ/u34EB1+icVXuhIYrWhajGD3swPiOfjc6SQBuJHVEdf
         Hm17aeGaFTWQuoMNyFR5jGmdL8zG8R9KdxJYLzKgjKX3dWaWKmDraRlxoE5O9vbIYCuw
         jUwuzQDne8uO5hGRvyRc/HXMWTRqJx8olP7vdCPSq5y55EzzXhWh/t8U4Oskz+tQaVS6
         hIPFXsxqTx8cOg58HyS8cJh8EdYy50ryQ+RLiwl2m6COtV/KTacnvBL9m5CHzKYNgOUl
         V2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699111260; x=1699716060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwi0jNDl4gJYKceItd95VpjLlRi3/UlXBw/STpxKSqI=;
        b=Q74VACt39JLXVCewp16oBeZalkwoxd3mL4sN6Srw2W0jfAcNBv6RwSm9wwIr4XmBKt
         VdcBas05KBWWdMCFv3nTFnASxocdGUhqHB4g0KAnT+1u//5TJqWTH1BYVInMYEa+4dt2
         q7G8tWKa1X9qNH1baJkNAhq6s1teQHpHmdRxkRoenOZWRe3AhoINzqYxM4DIHbEqjYDy
         meAyXZcfW9j6j0Ccm+mcFFtfbkkHN/P5ecrAJgJe2HEJqjzcEuFX530sO0L/EQnYInLD
         08L9IbIbicATNu1iHP3Q9QvzJz/yHJ3QT4WfQIkH5cQwto+Dzm8nKd1NSHmrHZE2i1pa
         Egiw==
X-Gm-Message-State: AOJu0YzGLUIuIPZ6vdWnLrHcqljp8gLtr5tit1RkuR7AXZwmrU3EyJY6
        iTPWPoD7V6sj3TNguywYojk=
X-Google-Smtp-Source: AGHT+IFpt6tG5NJq4zDf1pGfUNWR/TX8GvKfAHykKlGtWqH2jdJSqBeug0xy9K3jny5gbjkvQ7QPxw==
X-Received: by 2002:a05:6a20:440e:b0:15a:2c0b:6c81 with SMTP id ce14-20020a056a20440e00b0015a2c0b6c81mr34281891pzb.3.1699111259969;
        Sat, 04 Nov 2023 08:20:59 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001c9b2e66795sm3109565plc.85.2023.11.04.08.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 08:20:59 -0700 (PDT)
Date:   Sat, 4 Nov 2023 08:20:57 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V5] ptp: fix corrupted list in ptp_open
Message-ID: <ZUZhWepwPWLtmbDF@hoboy.vegasvil.org>
References: <tencent_33056C0C97FCEA56EF7ECD4C7B266DCC2D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_33056C0C97FCEA56EF7ECD4C7B266DCC2D0A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 03:07:24PM +0800, Edward Adam Davis wrote:

> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 52f87e394aa6..7d82960fd946 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -44,6 +44,7 @@ struct ptp_clock {
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
>  	struct list_head tsevqs; /* timestamp fifo list */
> +	struct mutex tsevq_mux; /* one process at a time writing the timestamp fifo list */

As I said before, it cannot be a mutex.  It must be a spin lock.

Thanks,
Richard
