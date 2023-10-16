Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783A7CA21F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJPIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJPIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:46:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A310E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:46:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso7541525a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697445964; x=1698050764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Ex1fsxDQzYBUpjDdsHCxpyekcqZSNA9OBJDzzDxq80=;
        b=m2bpcJ8F6O34BTe57K/7c3MqI8VVp8IVE3Lyr4s2WzYc6mZfWqQcVqcA1GNcv4HCzr
         l8YHJUi1ih1cgqIpmfsYLGhafxVwBCMU45oxYOhliudKSW3hMuQE7ExXXwP3Cwk04wwa
         cgntDOywOcTBn5HwHW/OsKvGNA2CdmWKufgQVPYJiieJcbn4N+9cc5gpF7Vr+2C9qrMa
         RbCXEGfCe+hwrtk4zYVthUy0XyNUeGHhO8MTbxzDfo4zt8tuM09YqaK7L0hZ6ickNcGL
         2LOjyjG1Eag/Rx81XWnRh9DJdklLB0EI7QcO/rkoeSvPNZNQ0DvNd+HPGrg+Jh8psdKS
         +Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445964; x=1698050764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ex1fsxDQzYBUpjDdsHCxpyekcqZSNA9OBJDzzDxq80=;
        b=s9Wl1rvDGjIpbED9ExDMnwNTliHmIobb7QfdisccTbJCrQVbS0IaXLBgWUGw6F7cW1
         o+iINxB4QtFMnEaSIrtLiQJq0jKckteXc1I2w3yCnd4nBLiD/2mGiI2yynG1ivEkeMfv
         FWwQNJc+GLghf5IB2QX1GhV/EIw+k+2yZKC3lhydkjE6obig00FKVGEFICVYu1ZycJ6p
         QTwXqsMPW3G4iKtwLixSzxauxpwuoMgPqNHwNy5evrk8lyyzZbPYBU+AUY/IDRngdpMl
         5lDiUSHMo1W1V5VDY2RppgZdwtXG051f8J8mndBY12lnavQmQwc7WaiSIST0VdKek3hT
         ybYg==
X-Gm-Message-State: AOJu0YwcsbCkQMOPYZcXbFyhfIUcGYRQMeBWZPBW9+jjagMTrAvqqBiM
        Ecj0bKmD6PM37ETutiL7e2lfyw==
X-Google-Smtp-Source: AGHT+IGX9Cu51HiWChDnsIGPbtwsgdrFPajLMbIzizQWD0U+FlFwPNqTC2xGshxfYcKNHIbEG1fenA==
X-Received: by 2002:a17:906:ef04:b0:9be:b12:1423 with SMTP id f4-20020a170906ef0400b009be0b121423mr6726851ejs.44.1697445964321;
        Mon, 16 Oct 2023 01:46:04 -0700 (PDT)
Received: from localhost ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906235800b009c503bf61c9sm422114eja.165.2023.10.16.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:46:03 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:46:03 +0200
From:   Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] drm: bridge: adv7511: get edid in hpd_work to update CEC
 phys address
Message-ID: <7dyh2eggk6ezag4ksmtac7b5gh3vzty3tf5547iyzlugbmwqap@rtssnbq57xuu>
References: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
 <20231016081749.GE23177@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016081749.GE23177@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Oct 16, 2023 at 11:17:49AM +0300, Laurent Pinchart wrote:
> Hi Alvin,
> 
> Thank you for the patch.
> 
> CC'ing Hans Verkuil, to review the CEC side.
> 
> On Sat, Oct 14, 2023 at 09:43:01PM +0200, Alvin Šipraga wrote:
> > From: Alvin Šipraga <alsi@bang-olufsen.dk>
> > 
> > The adv7511 driver is solely responsible for setting the physical
> > address of its CEC adapter. To do this, it must read the EDID. However,
> > EDID is only read when either the drm_bridge_funcs :: get_edid or
> > drm_connector_helper_funcs :: get_modes ops are called. Without loss of
> > generality, it cannot be assumed that these ops are called when a sink
> > gets attached. Therefore there exist scenarios in which the CEC physical
> > address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.
> > 
> > Address this problem by always fetching the EDID in the HPD work when we
> > detect a connection. The CEC physical address is set in the process.
> > 
> > Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> > ---
> > Pardon the insertion of the ugly adv7511_get_edid() prototype, but I did
> > not want to clobber git history by rearranging a bunch of functions. If
> > this is the preferred approach I will happily re-spin the patch.
> 
> There's nothing wrong in rearranging functions, it is actually preferred
> to adding forward declarations. You can submit a set of two patches, one
> to reorder the functions, and then a second one to fix the problem. This
> makes review easier by isolating the refactoring with no functional
> change from the functional changes.

Alright, good to know. I will wait a while for Hans to take a look before
sending a v2 series with two patches. Thanks!

Kind regards,
Alvin
