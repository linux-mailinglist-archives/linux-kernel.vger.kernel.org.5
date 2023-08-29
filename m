Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317878C0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjH2IqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjH2Ip6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E70CDC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693298695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7vrRIgvkMc8vEJcRG5fVY17VaUCcvlpWh8mJG998ig=;
        b=e2p6+sXyTBOl7tCEX9ynbhxqhpXtYBSWNVcqbaYdiEssdBn/KOQsVku978VGLGe90ZS3LW
        QApj3/LfPaB4zqjF8JABnGwHY8dfij69+Bf3eZw1TAdhB5uVkCzBpkytdcLBFw44sfARmB
        fq7RlsHiG5jg1HBJFFWEtwqJPLgF/D0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-vsxuWZ68MEGJKWoVr0Y0Mg-1; Tue, 29 Aug 2023 04:44:53 -0400
X-MC-Unique: vsxuWZ68MEGJKWoVr0Y0Mg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3172a94b274so2892362f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298692; x=1693903492;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7vrRIgvkMc8vEJcRG5fVY17VaUCcvlpWh8mJG998ig=;
        b=f/GRaYY3Wh5axJKZ/SGFMAAenlnizacdgg+0nc5BVyq+CtXUY82tjUGu+Z66nYfmN+
         Xa7JJ6D+isapnr7k+InOSVeKUA6gm21rGSWN8kmuA4DWivwWqtCJzkJTBqznjJXIbyJ6
         YFj2tulsLe1oHYASA1bIWWuhi+MJM1xuF0Cialzbu/n2FxxeE2i9VzIOGU70+D+55mGk
         q7hlld6EdHNsPF5cv9FLncJgM8I4p9MXrZ0oE3uv8pGByc/CAix0BFa4ebQZfKEaqYsr
         Dx6bLNW9oFBp/0TTA8maFzPBaOfyS9gae9/Oh8RBOd5ImHkERr2wzfOrJ32FBEVCD8eg
         qmnA==
X-Gm-Message-State: AOJu0YzeJYmqa8fMBTxB3aZBcSgStErerGUi2wcZ2ycrAD3CWyImon4z
        xkse0zYgzCsNJ/r3Nm2ffEAcYVX6H548ioQToKA3NLYiRhvg2tKcD2e8duGfKSjfS2CN4e0RtbE
        zChGFvNUmXmY6YvSYdrL+uwkd
X-Received: by 2002:adf:f64c:0:b0:319:77dd:61f9 with SMTP id x12-20020adff64c000000b0031977dd61f9mr20720991wrp.35.1693298692524;
        Tue, 29 Aug 2023 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkyz0H/59QiwmMaoPHBd8l/zOcbWepANl0xbLpo+CSCqgbruJh8dSYCGWoP+ygCUhdbU+SlA==
X-Received: by 2002:adf:f64c:0:b0:319:77dd:61f9 with SMTP id x12-20020adff64c000000b0031977dd61f9mr20720976wrp.35.1693298692219;
        Tue, 29 Aug 2023 01:44:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d538f000000b0031ae8d86af4sm12995610wrv.103.2023.08.29.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:44:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/8] drm/ssd130x: Use bool for ssd130x_deviceinfo flags
In-Reply-To: <285005ff361969eff001386c5f97990f0e703838.1692888745.git.geert@linux-m68k.org>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <285005ff361969eff001386c5f97990f0e703838.1692888745.git.geert@linux-m68k.org>
Date:   Tue, 29 Aug 2023 10:44:51 +0200
Message-ID: <87wmxeteyk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> The .need_pwm and .need_chargepump fields in struct ssd130x_deviceinfo
> are flags that can have only two possible values: 0 and 1.
> Reduce kernel size by changing their types from int to bool.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

