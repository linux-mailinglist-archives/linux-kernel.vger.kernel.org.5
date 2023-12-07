Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76520808639
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjLGKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:31:35 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663CB13D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:31:42 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9a1a2fb22so475906a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701945101; x=1702549901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi/pEIhfWjcb0S+f3fC8l/5THGcsm7y8cPmxyrZp11k=;
        b=dWQ5GTmxG3XIFkTDbbQCkVZFczzl0anqDY4umZ6rqprEm5DHkHtusG9MfD14QisxOY
         mJnQEgML2viFiebDYx16m4NP0muleORYSf+Slx89yzrDeLpk+XYY6SVI88tw4/m19P+S
         4aOc88F+NZ/MxlcQpc3T0MdspbXyjwLiaDUMJOG/viT7Ir16tYAVRTlb6jpLyrS8yErk
         DAclQL8JoBN0ZDrGvkAqtrd9Eos1Tmepsv1TRhRh2xCNhZhI/Rt/tZWdHJ7AWCMNj3Vf
         C3dQjjKOc/m7++6a/LSkY1xNYx4KP0OPb3q2AZwmoxmhhV2ndqYthvIPNvqM6TWDnuyC
         jwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701945101; x=1702549901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi/pEIhfWjcb0S+f3fC8l/5THGcsm7y8cPmxyrZp11k=;
        b=UYcuxJq596nPxpdYk0TjNGI7Sv4BTI8Xo1l0x3uVvajTKC5bFn9GeNR0UbUYFDeaTO
         V9qhgajq85BV+esEs3oMPBWwRLvalRisdswtudKrFcLrZK9OH4jO0qVgrj9OYdLwrc1p
         ZtkznijU1sLQ27w5oGsfBmkZpeNbRttyueVnBVGCAmlXWb+lv/QmmbiKMfkhwD4g8uCT
         /ZzK5oTymNT0FPd3S7J+3CoPp2LEC1RxeuCwGryYkS3W+pTZ634jGwnRI5xNOs0noZyk
         9xH+L8tbpOhFOEBJu33U39Kc/P9rAyPTHMZL6if524EYpL6PZkipj5ggfnIXJ4wYPuBO
         lZuw==
X-Gm-Message-State: AOJu0YxCPlsih1NhdsAii0aTz5oSKz7dWymqyCTJXFlYc2VpWp1is/qd
        pv7sT8a/ZwSpox3pNEbdT76lGSDuorCdP7g0dTU=
X-Google-Smtp-Source: AGHT+IGe6QyAHvJ3dNlq85arW1OxLP1khgdRBaBIUe2kM2NNTkaloF8AsNI1eB+7fHFjWCxnpxhGOi913yIf0ehjm/Y=
X-Received: by 2002:a05:6870:4209:b0:1fa:c334:1e46 with SMTP id
 u9-20020a056870420900b001fac3341e46mr2153417oac.43.1701945101574; Thu, 07 Dec
 2023 02:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20231207074308.393008-1-christian.gmeiner@gmail.com> <092107b1490b4c1b4ba5f2b60993e452c932f4a3.camel@pengutronix.de>
In-Reply-To: <092107b1490b4c1b4ba5f2b60993e452c932f4a3.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 7 Dec 2023 11:31:30 +0100
Message-ID: <CAH9NwWd+wdpmY3-N+iDO2L5neeEJqJnarMZG4SQb6-PNrMefug@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add sensitive state for PE_RT_ADDR_4_PIPE(3,
 0|1) address
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Gmeiner <cgmeiner@igalia.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

>
> Am Donnerstag, dem 07.12.2023 um 08:43 +0100 schrieb Christian Gmeiner:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > 0x1540 is the address of 4th render target address pair (two pixel pipes).
> >
> Are there any corresponding TS states for this region?

I will add some more ranges .. Do you want one patch per "region" or
one patch with everything?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
