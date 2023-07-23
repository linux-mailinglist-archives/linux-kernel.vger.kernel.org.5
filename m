Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917B175E082
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGWI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 04:28:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D88E7B;
        Sun, 23 Jul 2023 01:28:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb2468257fso17656705ad.0;
        Sun, 23 Jul 2023 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690100923; x=1690705723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2RBK6a1rrlPMn5TOATq9/7yx1S/Tl+2zZSZzJBZNsM=;
        b=aZpe29ckQMqcjD0CsG2rRtigKYI0ycSzcfnysKME5uEV0dbXxqtgQbq/bhqYWPtf+W
         CSobQNGJyv5uNyH8uuFRqc+5O513SpfChXjITqC+MhD19F9pcuh321hq90epTf2hntZI
         xNJWWUot6UblUHOmHbXg/+aohGhJxd/y12WJLiLVw7Vx4xrYQ+RkRLK3FWeQQFqVSwmi
         9I9HtohJOBSMAaRi0gRLwLmBeMkiYmP6he6Yyl1LTMroJeD73kHNriFDxANu2tsSg2Wy
         F/HCRsLhC2jDUyU/dZPzCQK7fbSeZV8UPDqP3L85G8sLY7tJZ8mUKPFj1Z5xZ9XOIHty
         eGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690100923; x=1690705723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2RBK6a1rrlPMn5TOATq9/7yx1S/Tl+2zZSZzJBZNsM=;
        b=CggpZvVvuacZ8XkEOCP9CV3eh0DdAnq8xAUNrXTxvHYaFjREWxjQI26eoho2KRvrjM
         TOX3dzf5EhKhgaOIGHB4A8WMXzpV/XZiq0kS+wdeyWfFWFLDrpf95iOEDLX80ml6yHmF
         epP8wejuwYQp/bG4Y3weovbMuitw8poTiQT01Tu3FAODuSPhauLJ39H/ktDxfU3sdvNf
         /JPzKy56yNK1Egd8lJ3eqGKRua0g0H4MfjEM+/rN//gluw/EiQVE9sqbBDzMRWvaPLvZ
         zG7JsvJCI9QdMP5oiDVjrY/nHGL57E4Uvc6VJiaZYFfPjiyx43kzvC0sZSiZNsYb2KiM
         QzQg==
X-Gm-Message-State: ABy/qLbQOsiH57UE5tAWXFD4zUfj6ylrK6mzRc0NGV3vwVidK4KZ5MrE
        9z6/Dnf965rEfVnmm0Judsk=
X-Google-Smtp-Source: APBJJlEyAivqgS1z/Q7bcfIa339ze+9MNCa6mD2worMXLAUFaSPxd3TpcGx2eH8f/O2vbFPJ05rqIg==
X-Received: by 2002:a17:902:d509:b0:1b9:de67:2870 with SMTP id b9-20020a170902d50900b001b9de672870mr6536878plg.40.1690100922731;
        Sun, 23 Jul 2023 01:28:42 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b53d3d8f3dsm6428406plg.299.2023.07.23.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 01:28:42 -0700 (PDT)
Date:   Sun, 23 Jul 2023 13:58:36 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4
 boards
Message-ID: <ZLzktMnJHTg13Pp/@zephyrusG14>
References: <ZLbATQRjOl09aLAp@zephyrusG14>
 <2023071850-festival-illusion-6399@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071850-festival-illusion-6399@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:37:21PM +0200, Greg KH wrote:
> On Tue, Jul 18, 2023 at 10:09:41PM +0530, Yogesh Hegde wrote:
> > This patch fixes an issue affecting the Wifi/Bluetooth connectivity on
> > ROCK Pi 4 boards. Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
> > on ROCK Pi 4 boards") introduced a problem with the clock configuration.
> > Specifically, the clock-names property of the sdio-pwrseq node was not
> > updated to 'lpo', causing the driver to wait indefinitely for the wrong clock
> > signal 'ext_clock' instead of the expected one 'lpo'. This prevented the proper
> > initialization of Wifi/Bluetooth chip on ROCK Pi 4 boards.
> > 
> > To address this, this patch updates the clock-names property of the
> > sdio-pwrseq node to "lpo" to align with the changes made to the bluetooth node.
> > 
> > This patch has been tested on ROCK Pi 4B.
> > 
> > Fixes: f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth on ROCK Pi 4 boards")
> > Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> 
> Why are you saying this fixes a specific old commit and not also
> properly cc: the stable@vger.kernel.org alias?
It is a mistake on my part. I apologize for the mistake. 
> 
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
Thanks for the link, I will read through it and resend a v3 of the patch 
with fixes. 

Thanks and Regards 
-- Yogesh 
