Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574387EA50E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjKMUvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKMUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:51:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FA3D5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:51:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40838915cecso39767015e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699908670; x=1700513470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvrGvFOPBp1VS132BZ8MbaZ9ElcVPLuXsdcm4yp0Wog=;
        b=Ad/aWVQ5eZ2LN0QD3hHMs4TONOjUDTEZJ4rxiYEu+pL1g9DxcJb2Y14Cm/ST3KJG69
         Khvd4wUvjyPStyiN3q3/dqb1wrrwIjSz3dBzL/fqNFG9/SUL0iMqf+rjg6lxnESZE+k4
         3H9UpizuLsRnrj7rldT1Blsru2xPxlj2AAiz6qvLgka+qouNDqv2DpDChRYUjkNqGm4I
         AkjazzxUSPQojqYAo5TApHOY2Y3ylLi5VQuKT6omquGpPVgPhqHnXe/958WEgEVD3gvc
         yQwvKVmuxGxjLFOLPwURlYyb1Y9HIZCR7u/OsAfl/24eHepXnndy2B0DRvUVV7E3UMVw
         i4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908670; x=1700513470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvrGvFOPBp1VS132BZ8MbaZ9ElcVPLuXsdcm4yp0Wog=;
        b=OveUit0rYi1V1z+BzqlJPYyctEsFLP+uNyTCBk/B5Dehkcs+UmmclUEY9CLVLePi4+
         m1XWDGmqXEeZBat6uZ6d95BKtDmREl7RhIGxcO4F7Pvv2iEkoFsY6KZAPWjvgYjmP3yj
         8ELGzPfj7D63Dbc1ZwgnFu/nXVcE2+/nH1RurE6SDm3mwtgqFZoa+35Z12m0YyI3EpjX
         se0TNNNO1LJs9MUBto7yjBbvv/+FQnUtKd8Lg96atLmd1o5Bwc5zMAWGhcQaSYcSBnZe
         iMjU/4yxZ3VZ3ZLpEn5SpVllmi2B7koRBWAsCEZeya0oexs2OALXuyYLrbjKgKi2fqN1
         RSiQ==
X-Gm-Message-State: AOJu0YyNh0uJ4fjRxEmbZ1v02iq+YzqrB0uVNMwOv2MD2crJao5CF2fb
        yoBxVwoz+kPeVxb00aeI1GGuMQ==
X-Google-Smtp-Source: AGHT+IG59UF5+7vlQRedNR9pMLJkOZkBzIexuJ9FkwfCBxG9z1gYTAE6SxeEuFjALwO4Bh/rrDDz+g==
X-Received: by 2002:a05:600c:4f4f:b0:405:39b4:3145 with SMTP id m15-20020a05600c4f4f00b0040539b43145mr6335121wmq.2.1699908669876;
        Mon, 13 Nov 2023 12:51:09 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b003feea62440bsm9237703wmb.43.2023.11.13.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:51:09 -0800 (PST)
Date:   Mon, 13 Nov 2023 21:51:08 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20231113205108.d3r3igce43cpmotk@blmsp>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
 <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
 <33102cbb65e24c5c17eda06ce9ac912a91f8d03c.camel@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33102cbb65e24c5c17eda06ce9ac912a91f8d03c.camel@geanix.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 02:31:20PM +0100, Martin Hundebøll wrote:
> On Mon, 2023-11-13 at 14:30 +0100, Marc Kleine-Budde wrote:
> > On 13.11.2023 14:25:37, Martin Hundebøll wrote:
> > > On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> > > > Hi Marc, Simon, Martin and everyone,
> > > > 
> > > > v6 is a rebase on v6.6. As there was a conflicting change merged
> > > > for
> > > > v6.6 which introduced irq polling, I had to modify the patches
> > > > that
> > > > touch the hrtimer.
> > > > 
> > > > @Simon: I removed a couple of your reviewed-by tags because of
> > > > the
> > > > changes.
> > > > 
> > > > @Martin: as the functionality changed, I did not apply your
> > > > Tested-by
> > > > tag as I may have introduced new bugs with the changes.
> > > > 
> > > > The series implements many small and bigger throughput
> > > > improvements
> > > > and
> > > > adds rx/tx coalescing at the end.
> > > > 
> > > > Based on v6.6-rc2. Also available at
> > > > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.6?ref_type=heads
> > > 
> > > For the whole series:
> > > Tested-by: Martin Hundebøll <martin@geanix.com>
> > 
> > On which hardware? On an mmio mapped m_can or the tcan4x5x?
> 
> tcan4x5x on a custom iMX6UL.
> 
> Sorry for mentioning it.

Thanks for testing!

Also I was able to get my hands on an am62 board and could test the
series on a mmio mapped m_can (in loopback mode). I didn't notice any
issues.

Best,
Markus
