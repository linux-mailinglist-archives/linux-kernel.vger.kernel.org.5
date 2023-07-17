Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167F755F58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGQJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3824130
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689586392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GSk6WKN5IHnbhndU+RbN845PKQyEPVxzi9rw1bYqlc=;
        b=Z5uCTup8EObBz1QRWZrQsr1+9yi1WDb7anMjwdxV224/hlS5rx2kL7jWTnfQYxrS0YLj2o
        IOkkOFW3MaIFQ/ONcfCCTxTAgnpLnaXrsteKRQ4I+lYrTWC/ZLzltvosnivBSk3rNaP+8L
        sRkHIWSqZRGmVzK5/ofefKSBEhNr2SA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-0eglSViUPVC6qwu7O76DDA-1; Mon, 17 Jul 2023 05:33:09 -0400
X-MC-Unique: 0eglSViUPVC6qwu7O76DDA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6f51e170fso35682371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586388; x=1692178388;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GSk6WKN5IHnbhndU+RbN845PKQyEPVxzi9rw1bYqlc=;
        b=LccWf61t3lUbsKP4WZyMxeZr+KtVo1aSKSriUzCRWV5XW65LiHuL3okHjZg8s8uBgD
         hcph5UG/jKzGuouDE7naMrgULpU42NZWwUSOpXUxuayj4mfM3uFGqo1bS9y9TGSP+T1q
         eiFt2EeeZYhUElVcvMPdhPZgzVYat9SRqJ7hVkgnDbqybQ2PBfPyQYccvtkMe0lSD2nB
         xubWmsPnKytZbLXUTD3xw015nICThj7gT35DdMgh970w4Ebpva60t0vPbwxmuXXCS5j7
         p20BVwxHyhDhtOtnwt4iFxHgahXp31LJglnW8T26BqRppey1xaZOoyijEhoZAFQQXSqV
         Va4A==
X-Gm-Message-State: ABy/qLZZ7Bc7ar97r/GRFqrtBpdZsbdCOJ8eUqIx6wLXkgMAf5vUPNek
        T6hoV7De76byfNBxCj1Ar6xSqk8w32e5JvY0GvUhoKS5xXtwk5Twkj/JvmZFGFse4flM/jBD99g
        VUIP7jBxOB+1avXuzZ+/PiiWT
X-Received: by 2002:a2e:86d4:0:b0:2b6:e958:5700 with SMTP id n20-20020a2e86d4000000b002b6e9585700mr7669259ljj.4.1689586388036;
        Mon, 17 Jul 2023 02:33:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0OLByQN5N+LQ57Inm6jnh+Bx3SZZ6vASzWXxO8whZtwkQRvwOLwzKHyX9P3IFIbL18i2Aqg==
X-Received: by 2002:a2e:86d4:0:b0:2b6:e958:5700 with SMTP id n20-20020a2e86d4000000b002b6e9585700mr7669243ljj.4.1689586387736;
        Mon, 17 Jul 2023 02:33:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b003fbd0c50ba2sm7627771wmc.32.2023.07.17.02.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:33:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] drm: fb-helper/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
 <87o7kakijn.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
Date:   Mon, 17 Jul 2023 11:33:06 +0200
Message-ID: <87jzuykhm5.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,

[...]

>> >> penguin in test004 is not displayed correctly. I was expecting that to be
>> >> working correctly since you mentioned to be using the Linux logo on boot.
>> >
>> > Linux has logos for displays using 2, 16, and 256 colors. Note that the
>> > default logos are 80x80, which is larger than your display, so no logo
>> > is drawn.
>> > Fbtest has only the full color logo, so it will look bad on a monochrome
>> > display.
>>
>> I see. Should the test check for minimum num_colors and skip that test then?
>
> The test still works (you did see an ugly black-and-white penguin), doesn't it?
>

Fair enough. But when it defaulted to XRGB8888, it looked better. So I
thought that it was a regression. No strong opinion though if the test
should be skipped or not.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

