Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E900880D00A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjLKPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjLKPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:48:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C16A1;
        Mon, 11 Dec 2023 07:49:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so42747655e9.3;
        Mon, 11 Dec 2023 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702309744; x=1702914544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aks+T2RWp+y47yPnFcNxGDqSMNoe71C5oOgiPokDMdQ=;
        b=YjrW7ehpDJFdNpPGizOZ4OGLkNl2Fc/dPQs0k1wop/TC9ntuHag3EPX6s0UWeB79Vh
         SFDtnoBycjR9hpEASBqW+Y9Q37RX6l/XkPMGQXSxUbmSV/68eb1J8gfBpTy2giqv/ami
         vmgrCWA4hLohTamwsIKUZlh6ZxFaKlKuyyfH3nGNHL2ctdwRuaUtX0GRjafGtqNwlm+W
         IeQpuVFHjSyLpplwPVsymdInM1Y7kSiyrghX+gON67FUF06cR65ZffNPtHwnIC9ZY/yf
         TS9hqcXKdgXiTagbxI4zwLO+VAXaNxKv0tQWGjIMpZXFR2Uq5MxblPCuHf1j3O5ro/Xa
         Tvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309744; x=1702914544;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aks+T2RWp+y47yPnFcNxGDqSMNoe71C5oOgiPokDMdQ=;
        b=hqk5WB3aEzGEzql8+pHim77WZtxWzohY/ybyxhdCHuw23yGOCzaaDBuzyGWO3WK3VH
         sPtyyvBChJZJ7YzYBnjAcsXVMQAxV/VK+xrQbSArf438U3yGNDOJIAKcYswMlhi5rTkt
         yRw65xV3f/MUL2o1SYttU4GstxpNYe2eHt2tTRTWiTOF++xmPp31A06nXoYoT3IbCFli
         qSvSogi2lPSypPLQEcgc+evKkQQ+hTO1hNpDAQlLg3jkGMFMeLGapIAXGPkXTIFrzYJQ
         4+Ef/wl8Qhpp+igJoZo6zanK9RLhW473UbYMczEpxaWNmlmOIvwwGVLNUZJVLERqvNG5
         hfdw==
X-Gm-Message-State: AOJu0YwgVKx12zVKREu0kDZSQp6tg/AMNbwuCfBK9H/1ZBw0l2rfvYHH
        JrNHRRZQdJhB8lns+8IoPq8=
X-Google-Smtp-Source: AGHT+IFDUkEZ2kjIUnbrZbnNL2NpdVGrdjYTtXF9+NMVopavJIKSOLRrF6f0TEY+PC9zv7nRJyumgA==
X-Received: by 2002:a05:600c:4448:b0:40c:3ec0:d705 with SMTP id v8-20020a05600c444800b0040c3ec0d705mr939053wmn.272.1702309743881;
        Mon, 11 Dec 2023 07:49:03 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm1699344wmo.12.2023.12.11.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:49:03 -0800 (PST)
Message-ID: <65772f6f.050a0220.8a2bb.80c7@mx.google.com>
X-Google-Original-Message-ID: <ZXcvbHLS8fEFKbal@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 16:49:00 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:44:06PM +0100, Andrew Lunn wrote:
> > +properties:
> > +  qca,led-active-high:
> > +    description: Set all the LEDs to active high to be turned on.
> > +    type: boolean
> 
> I would of expected active high is the default. An active low property
> would make more sense. It should also be a generic property, not a
> vendor property. As such, we either want the phylib core to parse it,
> or the LED core.
>

Also sorry for the double email... Any help for the problem of the
missing link_2500 define in net-next? (merged in Lee tree?)

-- 
	Ansuel
