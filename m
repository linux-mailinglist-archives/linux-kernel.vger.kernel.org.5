Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA1770BAE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjHDWD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHDWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D0180
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691186559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXzpEUWdN4SLt2rhGexfL6X3wS8/Bi9/wvDHMwbVeD0=;
        b=SgdG6kyOKaATyKZoFSLyP+WzutGRQ4PmtGiGg9rWN3/zEp2fPHZd83vMgq907AQVH1AEqZ
        VR5fmc7V3kLHDXfUrIB10FOBGumMzL/tsgDhrqpwVdvG5g3gwhTp89FLrIh0WcZXhz+KAV
        LtrNGPUsxuWZEz3pLVW8mfBg96SITHM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-dc88GoV_OYq8LYd7ae2oKA-1; Fri, 04 Aug 2023 18:02:38 -0400
X-MC-Unique: dc88GoV_OYq8LYd7ae2oKA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9d34de264so4357605a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186557; x=1691791357;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXzpEUWdN4SLt2rhGexfL6X3wS8/Bi9/wvDHMwbVeD0=;
        b=AgYHBNed1/wmbdiFdmKzcTLz+RwM7Qc0M32b3ZVxYyrCk+QkQjq4HFJx8tu3YfgFPW
         TErWbcp8vD+uyENCGmCbfPJBoOgmRtr6onKyZFWaGIkr1R5PucQc0E9YXbktDsbHqKIh
         BvzcpVQVxmWHIGY8lqGKf242I+nbv7/3dDnLIWlJqT45qPyUs0GppX7zpFjwTCi7f7b1
         rP16WV5E9HQO4osovUfKO0YLU6Ka9m9Jn0rrWfIAmZ2RJUk6EJgiHDsFNIk/PDDzOjq1
         nU39bEP0Xcxz4HqdEqRGE/gYpxf0fiKVpE/1GULorhZPBEMW4Y3aAuY4O9s1GRtiZSDw
         ez/w==
X-Gm-Message-State: AOJu0Yz59VZqAKWPfgRKkkqyzEZ0ESnMOWrVnnScrITO6gYueGoVrMhE
        jW89SelmrProLtDAcHajV5Dr4S52gDtlM1H7J6kdB3A05gpU8YfLNKUKtVv/QRPp2spTz2sXdf8
        0BcgjJaR1f0orQiSeaCar0Q26
X-Received: by 2002:a05:6870:9a1d:b0:1bf:4f5e:55e2 with SMTP id fo29-20020a0568709a1d00b001bf4f5e55e2mr3810518oab.53.1691186557633;
        Fri, 04 Aug 2023 15:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFibSEktTsTzniXcgNYUQlqWW7plBeiVw+TGTzHJSGuSRMOkvkMo+5wIPlRNMRenI850kABsQ==
X-Received: by 2002:a05:6870:9a1d:b0:1bf:4f5e:55e2 with SMTP id fo29-20020a0568709a1d00b001bf4f5e55e2mr3810498oab.53.1691186557318;
        Fri, 04 Aug 2023 15:02:37 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d67cc000000b006b9cbad68a8sm1677676otn.30.2023.08.04.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:02:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for
 DRM_FBDEV_EMULATION
In-Reply-To: <77cdbbed-e64d-0c55-bf0a-6dfcfbdb8b20@infradead.org>
References: <20230804125156.1387542-1-javierm@redhat.com>
 <77cdbbed-e64d-0c55-bf0a-6dfcfbdb8b20@infradead.org>
Date:   Sat, 05 Aug 2023 00:02:33 +0200
Message-ID: <87msz6foue.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

> On 8/4/23 05:51, Javier Martinez Canillas wrote:
>> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
>> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
>> to an effective 'select FB_CORE', so any config that previously had DRM=y
>> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
>> 
>> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>> as reported by Arthur Grillo, e.g:
>> 
>> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>>   Selected by [y]:
>>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>> 
>> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
>> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
>> be to enable DRM fbdev emulation but without a framebuffer console.
>> 
>> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
>> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
>> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>

I have already pushed this patch so I won't be able to add these tags but
thanks a lot for testing and confirming that the patch fixes your issue!

> Thanks.
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

