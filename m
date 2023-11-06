Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBA7E189C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKFC2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:28:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97838FF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 18:28:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca85ff26afso7747515ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 18:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699237688; x=1699842488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ICXDgrUHS6vF/SNPSijdTNrJfbN2u8WpcsExfAzl5Y=;
        b=e1o5xTU2yVE18YW1DnaNuNCjKDFO5m3ZS5/vS9lcdpUjkj8FMblQEF6s+J9/7kq9q0
         SBd08vzClQdFYQjWsOxTmwiNWMXZCOMSJr+YvTmvgoPGbb//J/h5+QnQj/4qki2UDX+x
         j/FQM8AERkjkTlYmFA1JG96ixAC/YEQN9/RT3j7VRgb+k9+xKYQm/E1WfJ05BYzAyAhr
         2d6saErNaSxfx0lPKfE4LrRn6tIIkckuMvysYpfNhQskUBRDSwYnllT1DSz4KoynpZCo
         U88xr1xzzZLjRDBGGtRHnakcMrd+INeyJuG1PQi+dXS8yfeIyjcHU11jJ+39hDc+LA1Y
         Hauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699237688; x=1699842488;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ICXDgrUHS6vF/SNPSijdTNrJfbN2u8WpcsExfAzl5Y=;
        b=ZJsohXhWYTppzmr7rD/t4/aMo3+qzKphdq1PTVgfXYk0oHlPOy88y6Gl+Jy4FqwShp
         qtI5DYs2dmPu8Cmook2g69/mzs0bF6OOi9IHK/o+Dtv3fqXa0JNmZ6loAUhloCrNC2Ft
         TSg78KOJeykRU9wjNgI3njs7CnoWd5EgXn+/y+936gJNhe1XbooS2z48zZmnX07TJEYd
         hqjv/wto1yRZ/H0dgJJhgl7FVQ18NBdG45peAcPCCUtn1XeiE22q4PI7aWGTkgNHfRCf
         A8sd+jeBiImgidw2S/Wb2gWtkpA2ynS6Ikn9AJcNREzBLe2BbPXY7gaa6iyQIiwArnwU
         waxw==
X-Gm-Message-State: AOJu0YxBZEwJae7ZPTR0Ov54VJ4J7bKCDaL3dYWpx3+U+HUXlD7criCi
        SY0//aRWQNMvfoZtsBZ/TAQ1Sw==
X-Google-Smtp-Source: AGHT+IGKeESJ321fkysf/ehuZaNxdclt+G5XHCOjmYZoDKjWobUxbFP67O0IeMp/d/iW1j9dzcL4Nw==
X-Received: by 2002:a17:902:c649:b0:1cc:3202:dcca with SMTP id s9-20020a170902c64900b001cc3202dccamr23138767pls.2.1699237687807;
        Sun, 05 Nov 2023 18:28:07 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:44eb:593c:2134:f5ea])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001cc0d1af177sm4735588plb.229.2023.11.05.18.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 18:28:07 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:28:03 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 3/5] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZUhPMxpho1WR5b+8@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <7300b8804396075d2ae565f46de51a980ce846e6.1698353854.git.oleksii_moisieiev@epam.com>
 <ZUNYkRtXUPeM4ppS@pluto>
 <ZUhOw0+HVcJYmvp6@octopus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUhOw0+HVcJYmvp6@octopus>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:26:11AM +0900, AKASHI Takahiro wrote:
> On Thu, Nov 02, 2023 at 08:06:41AM +0000, Cristian Marussi wrote:
> > On Fri, Oct 27, 2023 at 06:28:10AM +0000, Oleksii Moisieiev wrote:
> > > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> > > 
> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > ---
> > 
> > Hi Oleksii,
> > 
> > the new get/set v3.2 implementation seems finer to me at first sight.
> > I'll try to test this next days and give you more feedback.
> 
> I don't think that this version addresses my comment yet:
> 
> https://lkml.iu.edu//hypermail/linux/kernel/2308.2/07483.html
> 
> I hope that it will be fixed in your *final* v5.

Oops, this comment should better go against patch#4/5.


> -Takahiro Akashi
> 
> > Thanks,
> > Cristian
