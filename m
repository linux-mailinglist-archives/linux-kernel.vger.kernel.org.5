Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BE79FC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjINGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjINGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:35:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE7CCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:35:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d20548adso537856f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694673350; x=1695278150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zNOGE+5MM6BEZnPWt6ReEcr8sE6fFN9dseyZd6cTxY=;
        b=o1Vq8GKyv46JJtdljTxwCCCkX3G4kgXa6gjv+7tavRJ6wwwQcic98mkT6kE1UjISrG
         X5J9Pk0F6fMFqbV0m9LsDqgSd8Ibwpt0WzRHlr6b5Zn3cffZxlKtDs5qItA1vCudD6w6
         eHUypxxsgtFMWds9ACA4kYcXLDrlBD7bsgBFlQ/SkZlPA26RpkuJMPnQouAkkzh6sciL
         BxjzWmahhgVVoCcJ16IgHnlYOcHabTWTMkknKx5jnurRixAI9iug/lC5AepcnYkk02JP
         QV2NcxnQxAIIL2wXtnorDMlf4g5xqLZsJqPDe57AyDb6zEI6PwCdG6ZKgruQG7xAO4BW
         3utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673350; x=1695278150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zNOGE+5MM6BEZnPWt6ReEcr8sE6fFN9dseyZd6cTxY=;
        b=MNc72n+fkp32pZgHCVs57qANcHuNDZHwdfgN4CEc6yx6sNBo5EMatOWLoa44KRRX6c
         zIv4oCKlausvyWCDhobfQjh4Bq7gMfOuF6YAurFrJoaRoSa03bjqaAE+6tQco/SWajnW
         EbO1q5xbftXMfzcDImXljgwJyGNISr5XayiB32kiitA0E5yfIkOwR4ONJoR76IEbAJNO
         ppsnqdQ3yXF4Ev+0BcB890+lTDnN3GEbFz9YhCwsfeOnWa9nsIBmc8f+yH3UlEJPs01a
         rxxLZ/GxEmSSZjzlysHjdieSuEj6F51nmyImvdv/7OhJ0EIkEnMXcFiEKyyhDiTWBaIw
         61Lw==
X-Gm-Message-State: AOJu0YwKHkT647gEozRF1953N9PBBpWtnKOvoGsjrGWUrqzEEfAol/f7
        3wuqlL3ktHC8lyPm1bjvWFzAcA==
X-Google-Smtp-Source: AGHT+IFchjJOs01D7OSO6EJ43M0F+u18JLWXIlesmUdumSOf5TZW42BgtvIm+F/+kcsudif63vxKTw==
X-Received: by 2002:adf:f981:0:b0:319:7c07:87bf with SMTP id f1-20020adff981000000b003197c0787bfmr3724604wrr.53.1694673350534;
        Wed, 13 Sep 2023 23:35:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b0031773a8e5c4sm829543wrv.37.2023.09.13.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:35:49 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:35:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [RFC PATCH v2 0/4] staging: vc04: Drop custom logging
Message-ID: <1d54715d-25f9-4937-bdff-de0136c95fe8@kadam.mountain>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913185528.770634-1-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:25:24AM +0530, Umang Jain wrote:
> Hello,
> 
> This series attempts to restart the discussion on custom logging used
> in VC04. In the last feedback gathered in [1] it seems that the logging
> would rather be moved to use dynamic debug. The series tries to move
> in that direction.
> 
> The elephant in the room is the ability of turning on/off log levels,
> which this series just drops. Compensated by a crude strings
> ("error", "warning", "info"... etc) for easier grepping.
> 
> The log category are also just strings (which probably can be transformed
> to dynamic debug class names moving forwards?).
> 
> To move forwards, I would like feedback on the broader direction.
> There are couple of TODOs in each of the patch (summarised in commit
> messages) which require case-by-case discussion.
> 
> Additional high-level questions to move forwards:
> 1. Is loss of log levels by moving to dynamic debug, is actually a
>    concern? Is dynamic debug a valid replacement?

Dynamic debug is honestly going to be an improvement.  I guess, Greg and
I said this back in Jan.

> 2. Whether debugfs should be dropped as well, found vestigial in [2]

Yes. The "vchiq/log" should be removed.  Ideally as part of this
patchset so it's easier to understand.

> 3. whether vchiq_log_trace() should actually be tracing support for VC04

That can be done later if people want.  No need to discuss it now.

regards,
dan carpenter

