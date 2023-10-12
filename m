Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAD7C6873
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbjJLIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjJLIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71881A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697097759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ZJmk/yvxywysiwqAeSgrduB50WCm2128HhTQfYvMZg=;
        b=VPG7Z/m1k/gCYpKmw65dO40n404Xqq9acW34eEWEHUHsxscKI89q8FfBAXkzeYGta0NLjH
        5ZCG+4n5Ag47pGN8+KI5pySoCb/EhwVuOhLxZZ8FhOj7aspnhLdSM2FTMWMH/IsVtrgbvX
        eTqHdam+HaH0PR06DSVUUqR1V8U1hcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-FlziKThuMUG84E-vxgwHtQ-1; Thu, 12 Oct 2023 04:02:38 -0400
X-MC-Unique: FlziKThuMUG84E-vxgwHtQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4066e59840eso4700735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097757; x=1697702557;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZJmk/yvxywysiwqAeSgrduB50WCm2128HhTQfYvMZg=;
        b=uhw59dngE9cLAIaCgAHqltYxDrnyJdg+McB3ZNHav81Mm95hUlVM1ztRDxe33tqRai
         +Xh2CBGjj0kz0rQ3LYiBW1aAG0dKYG3tZyB9Q0ysm4wpqkBnyqqBunB5VlDKLjF90oUQ
         UQnTOItpZCr9T8uvmBNG9tlxWDWl57tvxxqBGVtdRpU4HAG1GPn0e8nE335ZR/bdSe2a
         EfQfuCUs0xMjANx7anEodxa742+So0johTl+1o8VJ7gHecMljGMUX88ZiO/idTrde/TJ
         dJSs01NVs57cNFjy3nJpZg1eanJWxIxh+eWMZCLSSXNXbrnBqDFkZIfoG+DRP0wEP/9P
         pjgw==
X-Gm-Message-State: AOJu0YyuIRpQHhw8xvxfP2XMDiXxh7/kj7rY1FepkUbe7DBcpfCIHtYI
        2AoUBhYaHursopLzmhNWTlvc06aJ5fZh47vFyCdoxqjdHlw9E1MTmv3Tjp9/oWmugUR7FSwyY3S
        mg4eyiOVjV/PhR51mJG9VtqH2
X-Received: by 2002:a7b:c3d2:0:b0:405:514d:eb13 with SMTP id t18-20020a7bc3d2000000b00405514deb13mr20614225wmj.24.1697097757067;
        Thu, 12 Oct 2023 01:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv0KCNuksA2uv+yIsdoxozzE1E60kM7Qujdqf8Krj5f35WHmA6AkUHXRhBkdQLnBpDMh81EA==
X-Received: by 2002:a7b:c3d2:0:b0:405:514d:eb13 with SMTP id t18-20020a7bc3d2000000b00405514deb13mr20614210wmj.24.1697097756750;
        Thu, 12 Oct 2023 01:02:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d574f000000b00323384e04e8sm17558032wrw.111.2023.10.12.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:02:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 2/6] drm/ssd130x: Add a per controller family
 functions table
In-Reply-To: <e6593ea5-daa1-466a-9d42-0c1872f41a13@suse.de>
References: <20231012065822.1007930-1-javierm@redhat.com>
 <20231012065822.1007930-3-javierm@redhat.com>
 <e6593ea5-daa1-466a-9d42-0c1872f41a13@suse.de>
Date:   Thu, 12 Oct 2023 10:02:35 +0200
Message-ID: <87a5so46as.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks a lot for your feedback.

> Hi Javier
>
> Am 12.10.23 um 08:58 schrieb Javier Martinez Canillas:
> [...]
>>   
>> +struct ssd130x_funcs {
>> +	int (*init)(struct ssd130x_device *ssd130x);
>> +	int (*set_buffer_sizes)(struct ssd130x_device *ssd130x);
>> +	void (*align_rect)(struct ssd130x_device *ssd130x, struct drm_rect *rect);
>> +	int (*update_rect)(struct ssd130x_device *ssd130x, struct drm_rect *rect,
>> +			   u8 *buf, u8 *data_array);
>> +	void (*clear_screen)(struct ssd130x_device *ssd130x,
>> +			     u8 *data_array);
>> +	void (*fmt_convert)(struct iosys_map *dst, const unsigned int *dst_pitch,
>> +			    const struct iosys_map *src, const struct drm_framebuffer *fb,
>> +			    const struct drm_rect *clip);
>> +};
>> +
>
> You are reinventing DRM's atomic helpers. I strongly advised against 
> doing that, as it often turns out bad. Maybe see my rant at [1] wrt to 
> another driver.
>
> It's much better to create a separate mode-setting pipeline for the 
> ssd132x series and share the common code among pipelines. Your driver 
> will have a clean and readable implementation for each supported 
> chipset. Compare an old version of mgag200 [2] with the current driver 
> to see the difference.
>

I see what you mean. The reason why I didn't go that route was to minimize
code duplication, but you are correct that each level of indirection makes
the driver harder to read, to reason about and fragile (modifying a common
callback could have undesired effects on other chip families as you said).

I'll give it a try to what you propose in v3, have separate modesetting
pipeline for SSD130x and SSD132x, even if this could lead to a little more
duplicated code.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

