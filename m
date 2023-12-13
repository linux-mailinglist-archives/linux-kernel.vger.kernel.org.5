Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADD811B92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjLMRx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:53:26 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0483;
        Wed, 13 Dec 2023 09:53:33 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58d08497aa1so4612175eaf.0;
        Wed, 13 Dec 2023 09:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490012; x=1703094812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqqY6lSB+RFit+gJ+Ct64NvIN16qb9HYYOP9L5yB65g=;
        b=bpGICFO5RnXWGs1N8uWDMMcbMMlvHYTEZg55gm/Pc7TJ8iGEGeBSnYvP0ViXcpOHL8
         alCGkjMs38wVLCY6zUcapYaW9xWPGyFni7ZDeRg8gqYfIrlKZfPbGAeO7VCOA9ldZN+X
         eEWhmueGphFwTYigUei+k6BQNdFSi8bT4XbwoesnOEDraxmImFNlqruXMIEWKhwNWR1w
         x7oF63T7XhEYXwU/8nWiCgg0Z+g2uIMGaXv6W8EY7gNpUlqtwF4+jOWD28tU32/G2VQT
         Z1FeJcFK4EharZ18bY0LsY2c2/zdYfrYR5PaEY1rzYmjemAGXhtgXtBJg/TtJHDmlcfy
         N6Tg==
X-Gm-Message-State: AOJu0Yw5cPr6SWPvcKlG22Wid9IqVrvGTvxOKXaUFJOAWdJ7S9OzHY4+
        ILHG8pnnMyHFXMd/d28Q0hR+gyJL0g==
X-Google-Smtp-Source: AGHT+IGGnK4qpiuPojyap8RSF0CD8y3a4ePwM9/4ReTh5wQmPg8Bwi+PLX+Jg8DxKI3K2cYH/jaXZA==
X-Received: by 2002:a05:6820:1ac9:b0:590:7b3d:dbcc with SMTP id bu9-20020a0568201ac900b005907b3ddbccmr7238000oob.6.1702490012455;
        Wed, 13 Dec 2023 09:53:32 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f203-20020a4a58d4000000b0059057416278sm3149398oob.6.2023.12.13.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:53:31 -0800 (PST)
Received: (nullmailer pid 1588079 invoked by uid 1000);
        Wed, 13 Dec 2023 17:53:30 -0000
Date:   Wed, 13 Dec 2023 11:53:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/4] Add displays support for bsh-smm-s2/pro boards
Message-ID: <20231213175330.GA1582432-robh@kernel.org>
References: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:03:41PM +0100, Dario Binacchi wrote:
> The series adds drivers for the displays used by bsh-smm-s2/pro boards.
> This required applying some patches to the samsung-dsim driver.
> 
> Changes in v6:
> - Drop patches:
>   - [06/10] drm/panel: Add Synaptics R63353 panel driver

The binding should have gone with this. I'll apply it then.

Rob
