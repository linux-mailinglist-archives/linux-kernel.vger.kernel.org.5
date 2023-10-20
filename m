Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557E7D0C99
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjJTKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376946AbjJTKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:01:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88394D66;
        Fri, 20 Oct 2023 03:00:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so5430605e9.0;
        Fri, 20 Oct 2023 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697796056; x=1698400856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peRqXjQQQ45HJmDIxv6CwSEgU//1lNonAjtSzwx3PGU=;
        b=WAt6zkRrXTXbvp7uV9zadEt2O1sBo7iFog6EsgZnH/d3Pk1Dz2kI3NFcdhF5UN7hm4
         mXtMixQebrkU7+DXfCSEavCu7vXffxc1vdFZjcuP+eqZRMvncs0hX67kN2dYefUXEXcp
         W9Qo//N9Av9pmWUnX8CAUVN4Te2RwVLOlRQrFs/PnWegi56YuLU7tuxhLCqhpbEt6ZNY
         GswuoyV5wn8lq6i9RqyjLWurTb+L7rri57jXx5riMLTjuG4EX3d7MTE/+8Ju5CWcd1RW
         QipibBOLPnpLWdJvh5eHoCHNy/GDohXkMyqG1m/cFeTaMUJxMavubDluUcc5eRuFPa59
         wy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796056; x=1698400856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peRqXjQQQ45HJmDIxv6CwSEgU//1lNonAjtSzwx3PGU=;
        b=wzC2xsfrFnhPeh26GH24fQNurpsxq4ffcFHUnqUBgV08SwVvHFFg6V9vmPfDsCVMhU
         QtzGXA+SISdVVdEr9gb3tTUNS+9fIlTJbZMfumKTO17WbgW4mqdhB25lrBrTKOIl379G
         Suc6esTWrftN5qo2TnE65ENXkdTzmjFgSClA9wPXssGKigdHaOv4oeyUaAcNzVXukX22
         UIcaZruBlf+qQtK2jmvdNq43BCUoly4J5fY7bnx6DZUwuaydaop9bhfjj4fPlwJTYiOu
         ErjCf/0sYzJz7OI+sSVAeStgrbJtU6scnPm4njo4uG1D7ap+0NIta/esqmdhEo5NyPOC
         2FJA==
X-Gm-Message-State: AOJu0YzSNzzfWgoEMVWe2vP4Vo9cFeUH+/MLoq8KB4EvrFbPDp0wdJML
        /vYDFreDmezL2A+uFE4TBBE=
X-Google-Smtp-Source: AGHT+IHsoOcv7yGlkWUObueKECjKOC+XTO4SUe7WvsjAk0W10IRiMeQ2aLBhTMS9jRCqxjmQxecx/Q==
X-Received: by 2002:adf:f387:0:b0:319:68ce:2c53 with SMTP id m7-20020adff387000000b0031968ce2c53mr991596wro.25.1697796056321;
        Fri, 20 Oct 2023 03:00:56 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id d14-20020adffd8e000000b0031984b370f2sm1320027wrr.47.2023.10.20.03.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:00:55 -0700 (PDT)
Date:   Fri, 20 Oct 2023 13:00:53 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Message-ID: <20231020100053.wf3jivdkdfaunfgh@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
 <20231020084620.4603-1-ante.knezic@helmholz.de>
 <20231020092729.gpbr7s2cbmznmal7@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092729.gpbr7s2cbmznmal7@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:27:29PM +0300, Vladimir Oltean wrote:
> On Fri, Oct 20, 2023 at 10:46:20AM +0200, Ante Knezic wrote:
> > Ok, will do. I am guessing I should leave the existing 
> > ksz8795_cpu_interface_select() as it is?
> 
> I would encourage moving it to the simpler call path as well, but
> ultimately this is up to you.

Also, could you please put spaces in the commit prefix ("net: dsa: microchip: ")?
