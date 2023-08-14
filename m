Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5877BA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHNNqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjHNNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:46:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64B106;
        Mon, 14 Aug 2023 06:46:17 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34aa2883f1cso2893845ab.3;
        Mon, 14 Aug 2023 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020777; x=1692625577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yKMPxUGe84xvNf8pYF68HzMRRk71stM/ItQSRJOA3k=;
        b=sX+Sbzaeg5OOm/s+UizNkCgX2zeHA5HPploXfuUVhikqDqFfRm23IwYoX3/jPH8lsS
         KD0YbGTDaAS/zDnKlvAqYwmzMBszYiFlLNKpCabd6x0rjhPNw4PwheGvhYRYtcNqR5q7
         PcbWBhEdfvYdLLNQmHWRjHuCDPpuZGwynTbwi1w/zVaBC3XAtpEQNu6/3+3ZbNUweWfx
         VDFara0unQ+olJ4ptNYY66tT4/l0mlo/nvsNdlFLcFXoXMgFWW33BN2inJ7ILVOrYZdS
         zC/+frcGxM9VH0+IuvZIA5ghcHmavTHWzACH5nDugUtUUWzOPGqruuMjeSzYmPc15EVN
         Q3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020777; x=1692625577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yKMPxUGe84xvNf8pYF68HzMRRk71stM/ItQSRJOA3k=;
        b=Bv/6/BdSPZ6TdagmbZnkisRFGfo+v6tGU92O6UaJvpffR5CmXegIFE6O/9C6WNIIBj
         IqtmcIeVUC/unT3dpZ+UbVQrEDEEVuwWzCHKPWn6Bm/2VR69Z5QtCwV4PuSxySLoamfe
         K3Z1lKRC/AEYxI6a0cyE5u7CSG4sb5CtxifqIhovnkvJ9gfiXq1vwhfEj554hNVz0evg
         KHZ1Bpk7iA5jpx6DiY/daMxKmso4f6KjvS2UWzTMrviWyVkEbXtLeh8nZVwQFKMu5GHM
         6CKkIE2Wo9yLm+tC3kcXwwhbayISdcvyU//nW7EDI0d9zUxh/tknXWt93Ir7Rd3okUw4
         piHw==
X-Gm-Message-State: AOJu0Yz+PjUJVprDYJpOXSKOC/kBB2vAHqAThTbAutL4LosEaCAEDXjn
        GkOaoip4wIP/t5UeI0xVs3I=
X-Google-Smtp-Source: AGHT+IF1ZkjHYTAqORYWQkSZckevSGpcdYvx95BZ20yXmvWcSuKnv1NxDwAsmCC/O3CxhjfPqm0Stw==
X-Received: by 2002:a05:6e02:20e7:b0:348:8576:15b5 with SMTP id q7-20020a056e0220e700b00348857615b5mr13574235ilv.3.1692020776945;
        Mon, 14 Aug 2023 06:46:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020a92d186000000b0034a921bc93asm1538168ilz.1.2023.08.14.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:46:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 06:46:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gerd Haeussler <haeussler.gerd@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for Siemens IPC modules
Message-ID: <5f072764-b4c5-49cb-b880-a735f6d152b6@roeck-us.net>
References: <20230814073114.2885-1-haeussler.gerd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814073114.2885-1-haeussler.gerd@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:31:14AM +0200, Gerd Haeussler wrote:
> From: Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> 
> There are different IPC driver modules in the kernel that are actively
> maintained by Siemens but not yet listed in the MAINTAINERS file.
> Add the missing entries.
> 
> Signed-off-by: Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> ---
>  MAINTAINERS | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f966f05fb0d..6ca5564a4f8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
[ ... ]
> +
> +SIEMENS IPC WATCHDOG DRIVERS
> +M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> +M:	Xing Tong Wu <xingtong.wu@siemens.com>
> +M:	Tobias Schaffner <tobias.schaffner@siemens.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/simatic-ipc-wdt.c
> +

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>
