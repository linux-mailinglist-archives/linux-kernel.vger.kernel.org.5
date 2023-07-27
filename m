Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C87653BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjG0MY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjG0MYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:24:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB8422B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:23:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso1625889e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690460629; x=1691065429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8HOZbTaPMKpZieZhlIo9g3XBT9r6g5noy68AfRKqEI=;
        b=InLfukPs2jlpv1/JStTGwJXQCtEeHLVYyrdK12EoeGVH73HCL1uRXC4d1eaVSz1CEE
         HbIlnlv5NZkHlPRNAydMgExGL0zdTkhCEkG0Gz3TG/F54i3FECeAR0OaW2lAkGPvw6wT
         s0D5f/iXGYb43X3A3buHcBdGRwsqlmJ2fGE4waUxB4aqfBZ27j1YuV0sO+FRKMMg3Kz4
         xdninMrSa48T///+U3BuOMDYxtnaS16ftscSQbJ+cQ+OxnO6EpckkCPiGHhyYZXjyles
         LLUzRJnkl9vixVyaWba3+e+5uRNEcfrVSCDTfHb5ATZpI7WLJufVfLq5U5JMdivEj+I/
         ECZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460629; x=1691065429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8HOZbTaPMKpZieZhlIo9g3XBT9r6g5noy68AfRKqEI=;
        b=O/0UD6ia54LaUT2vbEwa4PqqlMXfu2qWP1m6UNx2izDOvfsH9bfI+IP8DWrUEz9Frw
         YU7k49EuDIQz6gpbF1oJ+4K5lrgDYoShlFrGvI5X/z9kmIB/I2wm1yJRg4g18N0WSt6G
         VWpAgRpF4RAGYMDzARJ0hp4wDPH589UIgaBgh3N5ZL7TTzmDJnRHE+d7yLqrcMVMO2g3
         6BZ+qJJ3i7UPRtPDT5URNsCKe8ngg5h9UY7s/YMTJ/qT4OHXOw0QSxQrkuNEPLBmPhRs
         ykDuGaQQgJ1Wo7jjOcVo3Kg9GDbtxXAw4Gzqz9RqegYOvp3Tp05kAmqILb4kUFPIplCL
         pIOg==
X-Gm-Message-State: ABy/qLbcDVhH4H3wf/jSlFcuDtRSEkLjnsnq9y7r6R2u2Dux3nBE1Ziv
        hfZNY31aekxZPZtJJGomF/4=
X-Google-Smtp-Source: APBJJlHAKorEDhHqQX7aIu3NJxRAQMbLyDhHVxP3lggawjf354RQ+w3/8mfvEKEHjSESC5vZBQAaJg==
X-Received: by 2002:ac2:5f53:0:b0:4fd:fecf:5d57 with SMTP id 19-20020ac25f53000000b004fdfecf5d57mr1359432lfz.39.1690460629296;
        Thu, 27 Jul 2023 05:23:49 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id z21-20020a19f715000000b004fe08e7dfbdsm294861lfe.44.2023.07.27.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:23:48 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:23:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jeff Garzik <jeff@garzik.org>,
        Alan Cox <alan@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_ns87415: mark ns87560_tf_read static
Message-ID: <3izp4odx63522c53o35kifw23mjalho2hpnhnqziuczf322mzv@6gutwcdba3ly>
References: <20230726151119.2303954-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726151119.2303954-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:10:23PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The global function triggers a warning because of the missing prototype
> 
> drivers/parport/parport_gsc.c: At top level:
> drivers/parport/parport_gsc.c:415:5: warning: no previous prototype for 'parport_gsc_init' [-Wmissing-prototypes]
> 
> There are no other references to this, so just make it static.
> 
> Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looking good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/ata/pata_ns87415.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
> index d60e1f69d7b02..c697219a61a2d 100644
> --- a/drivers/ata/pata_ns87415.c
> +++ b/drivers/ata/pata_ns87415.c
> @@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
>   *	LOCKING:
>   *	Inherited from caller.
>   */
> -void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -- 
> 2.39.2
> 
