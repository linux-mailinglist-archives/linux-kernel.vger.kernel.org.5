Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8419076813D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjG2TLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG2TK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C223A9C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690657805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOCFbmaqJDliMmq4qRXmQzpcNBbZ0rghMQxEBFeZeig=;
        b=JEXB2HrUkMgCyeFCzoeQ5LcomrPt1WYJyQMBmhgpUnN6b5jBHpvYXNi2dCZjFTl1wLJlXX
        nd4/8gIYNqPwHNu6+XoQ3wIqO6DN/dv0coPGs6eWkPdwAjWR7hK9o9kjuLtKPYZ6jhtatU
        xuJhTDZB+AFuXBgTeCtUFQEQwJlWhmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-MwghXI0WNUSvM4xjQdX1YA-1; Sat, 29 Jul 2023 15:10:03 -0400
X-MC-Unique: MwghXI0WNUSvM4xjQdX1YA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd2778f5e4so17100015e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657802; x=1691262602;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOCFbmaqJDliMmq4qRXmQzpcNBbZ0rghMQxEBFeZeig=;
        b=J16QYNIPF/8OhFj8tmFO+IlqcLp9rZUBGKr1AUWOwG/rT/4Z5tgPoWV6M2bvmi7Q7K
         u2YWmQ6El9KFJe8FiLxntl648TIhbaRLskt+XNGCNNXnlPj+TUNSI9v17w7R6oXbNAFA
         JsUcyxgBRgnSUXM2KzF4jAf44WnhjIL9bGeEW+FWI8XOblhBpUKLF9Gk3ZHacjVfJs8s
         fWBjbBxb0lwMH7KO4iP+yyVKupdODG8/xCenAQtPOlKZMVuC5BfY3rGBgGKooF85be6Z
         I4d/p8Qh9HVYL2eQ/v6bCSrtjbcE8UYOY3e1j8CakQa885bmke4J97kHGheYTp3+V2Dt
         0Kag==
X-Gm-Message-State: ABy/qLadkzU6k3YSnAwboUMpn5TTqkFeJ8pFtUaUiLPr5euytvw05bdX
        1Drs4C+nZFcPNNg5U8NeYw0fgx7LuSjz45+pvB4iPLuiu5vxteNWa0+YXL9ZNlFWAIZajeaHUbO
        ZZ3hh1hJBzLCtAXR4dSa43Egg
X-Received: by 2002:a05:600c:22c6:b0:3fc:1a6:79a9 with SMTP id 6-20020a05600c22c600b003fc01a679a9mr4764485wmg.16.1690657802669;
        Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLhWwdb9e5stl9mtFYazDKO5IGT18IwiQdgIdt9oSkXWPDup+CMG32gUcSUxlzRYbRdSzBsA==
X-Received: by 2002:a05:600c:22c6:b0:3fc:1a6:79a9 with SMTP id 6-20020a05600c22c600b003fc01a679a9mr4764469wmg.16.1690657802420;
        Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x20-20020a1c7c14000000b003fc01f7b415sm9897722wmc.39.2023.07.29.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Spelling s/sempahore/semaphore/
In-Reply-To: <8b0542c12a2427f34a792c41ac2d2a2922874bfa.1689600102.git.geert+renesas@glider.be>
References: <8b0542c12a2427f34a792c41ac2d2a2922874bfa.1689600102.git.geert+renesas@glider.be>
Date:   Sat, 29 Jul 2023 21:10:01 +0200
Message-ID: <877cqiy1o6.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Fix misspellings of "semaphore".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2:
>   - Add Reviewed-by.
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

