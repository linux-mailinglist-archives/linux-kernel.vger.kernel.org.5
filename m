Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F27D9EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbjJ0R2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0R16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:27:58 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8060AB;
        Fri, 27 Oct 2023 10:27:56 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2df2fb611so1518254b6e.0;
        Fri, 27 Oct 2023 10:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698427676; x=1699032476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT09sGgTrEuTUf24HSAV5+mSvhXBl77PVqX+x8VkCqU=;
        b=nnQy3h0GkEN2++N0hg/xm0slgWt+/AhNMX0Oe//JI6QRJW+q5104+d1nt/UTw4U+Zt
         wt3eMPFMj2TbKwdXcnxpVX8jQ+6/G8K6ewAkszLYWdRLuVHU+TyzO8yNdLn4Ne+rZi7X
         mMWocA5xUMElUtB3X8gq7rPhNJXv80ViWfGxZpNv4x3Ne4RrIcqm7kx1ZXiyQdT3+Qaf
         ZI1tjB2J8UqF0bt6zEiyxKbOGe3QCoYJ2H3coTjb6GBFhq2ktMI6z3Sepf79NxwG6lEF
         iBz5DS/D1Rupmi6NvYlYZuux0dibefZkVxg9FtBToKg58pQaoyhruH6SKho4JNlnuPsy
         HizQ==
X-Gm-Message-State: AOJu0YzIX4/aJPChp/H2D8kjV0WtlP5HCbnp9q3nz0nfvHw3h+9uhs4M
        enGK/rCLQCc2e/M0e0XhUw==
X-Google-Smtp-Source: AGHT+IHrGTnQFkC61PIza6vsczaA9W1Gzyuq3CCjBuzoKftsPrt/l9cqVYYDl7cqKInXkPJDSawjww==
X-Received: by 2002:a54:4690:0:b0:3a8:432a:ea13 with SMTP id k16-20020a544690000000b003a8432aea13mr3693298oic.46.1698427676117;
        Fri, 27 Oct 2023 10:27:56 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a056808021200b003ae165739bbsm361155oie.7.2023.10.27.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 10:27:54 -0700 (PDT)
Received: (nullmailer pid 2844872 invoked by uid 1000);
        Fri, 27 Oct 2023 17:27:53 -0000
Date:   Fri, 27 Oct 2023 12:27:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: ssd132x: Remove '-' before
 compatible enum
Message-ID: <20231027172753.GA2834192-robh@kernel.org>
References: <20231020223029.1667190-1-javierm@redhat.com>
 <169801218855.747717.5658253186246322717.robh@kernel.org>
 <87y1foo1in.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1foo1in.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:30:56AM +0200, Javier Martinez Canillas wrote:
> Rob Herring <robh@kernel.org> writes:
> 
> > On Sat, 21 Oct 2023 00:30:17 +0200, Javier Martinez Canillas wrote:
> >> This is a leftover from when the binding schema had the compatible string
> >> property enum as a 'oneOf' child and the '-' was not removed when 'oneOf'
> >> got dropped during the binding review process.
> >> 
> >> Reported-by: Rob Herring <robh@kernel.org>
> >> Closes: https://lore.kernel.org/dri-devel/CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com/
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >> 
> >>  .../devicetree/bindings/display/solomon,ssd132x.yaml      | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> 
> Pushed to drm-misc (drm-misc-next). Thanks!

Given what introduced this is before the drm-misc-next-2023-10-19 tag, 
isn't it going into 6.7 and needs to be in the fixes branch? Though that 
doesn't exist yet for 6.7 fixes. I don't understand why that's not done 
as part of the last tag for a cycle. But drm-misc is special.

Rob
