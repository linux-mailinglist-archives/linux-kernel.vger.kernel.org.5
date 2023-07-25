Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D787609C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGYFv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGYFvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:51:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46AFB6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:51:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso51160355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690264313; x=1690869113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDa0fqzt30Ptcdn+Rp2moDt3uwTqaLbOBTSNBvQHsow=;
        b=Fm732xFUENH32uKlXGBO66pTUcan0hi8UvbXIOsmsajrmKgF65+VKuAsgwl0h2rEvm
         8bVGJCXxJ7Lo3CDTY397Y4mxix0VJtW/pkEXHkkLKO800NxhaPqfFFKex6vpdJLCOa4w
         CmI8aGs1OSFpz1ZKdyfS0I94dx6bSwxKd8BBKpUZIt+arN+GsWHCduZZv9YOaAYpEwDJ
         Kpqga4FAeLkxMrOnhuZRX4J7HcS3KeKVchXAMmblYLn9CvHnXCAxAdBbWFocNGUcqeMO
         Tu3SmXJtzR2hdcpIZzcJs/EIeI/+pl0EtvFzM5PA5rL69dp57n8daVKEcMuVDnfOpImi
         zo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264313; x=1690869113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDa0fqzt30Ptcdn+Rp2moDt3uwTqaLbOBTSNBvQHsow=;
        b=gUCfTyITQMQ60xE1mOU8cSFY8l7ci7Xe/XGaiBOaW1j+9GpIWLttwonYwVkNrlyH7X
         wQj+ZqIIuugcMvV/hKknThMKFvxU2OIULhOKcjOpP09w4Pr7gi7VsNszMYLEo50XB0mr
         loR4Q+WWd7sK6RuxkfL7ph7OMs2U56PnFVcreicPooAUd5NsBLCSDJ8xlVvO6eMwfzIZ
         S7dZmQZGMASBoz4JI5HyfcVhWdpFzDK7x4/Jasj5nOU9NK3de16P3pVD5CLC2EXlB727
         I1OIycLo9e1nvfOt98KCicQT7QUo6li0nRbcNitc5K4shE0+cuoYB90vcDOza7TKbK46
         PG8Q==
X-Gm-Message-State: ABy/qLatLqiow/SHY2NUc1MyXbP1Z9w78Qr0pVkGnshrUqIqvKOQl1/N
        HCaclKvD63U4UZ64sGJswbbyvw==
X-Google-Smtp-Source: APBJJlFxsS3y+cMdX48jiFbTMmksWQoLUG07CWaL93WGXpO5sZmPQJoOQhas8KWkVrn1RtL/72a08g==
X-Received: by 2002:a05:600c:152:b0:3fb:e200:b2b3 with SMTP id w18-20020a05600c015200b003fbe200b2b3mr9548144wmm.37.1690264313064;
        Mon, 24 Jul 2023 22:51:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b0031423a8f4f7sm15243623wrk.56.2023.07.24.22.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:51:52 -0700 (PDT)
Date:   Tue, 25 Jul 2023 08:51:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com,
        intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/tv: avoid possible division by
 zero
Message-ID: <5d096bcf-c394-4dad-b307-3d7e33ab6e6f@kadam.mountain>
References: <ZL62X3/CnsJcWWU4@ashyti-mobl2.lan>
 <352f7c10-3592-4a18-abdc-ab554a992d10@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352f7c10-3592-4a18-abdc-ab554a992d10@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason why the first five attempts had bugs is because we are
trying to write it in the most complicated way possible, shifting by
logical not what?

regards,
dan carpenter

diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 36b479b46b60..6997b6cb1df2 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -988,7 +988,13 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
 		      const struct tv_mode *tv_mode,
 		      int clock)
 {
-	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
+	int div = tv_mode->oversample;
+
+	if (!tv_mode->progressive)
+		div >>= 1;
+	if (div == 0)
+		div = 1;
+	mode->clock = clock / div;
 
 	/*
 	 * tv_mode horizontal timings:
@@ -1135,6 +1141,8 @@ intel_tv_get_config(struct intel_encoder *encoder,
 		break;
 	default:
 		tv_mode.oversample = 1;
+		WARN_ON_ONCE(!tv_mode.progressive);
+		tv_mode.progressive = true;
 		break;
 	}
 

