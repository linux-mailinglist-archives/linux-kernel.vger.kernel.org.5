Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF37D87E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjJZR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:58:47 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D3194;
        Thu, 26 Oct 2023 10:58:45 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5820299b99cso1159757eaf.1;
        Thu, 26 Oct 2023 10:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698343124; x=1698947924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z1yGiJBBI9AoK8qoFUV3Ia7kjAwo9PR+/1kimU+UtM=;
        b=C01vKXbtdd0pPfC6htRJLm1kFZb8iLmGqvNOBgL7Widekr9iLjRCdMijknux4kI6X2
         WNUfQ6WXRr9qPhx1EyrVE972MeeyLgt5p3Kdw2hh/EwryFXvbUcbFvuF2uacZUOCYMxk
         g7WsVpbv+mZLTpiJRMOufuQMDTBMk7SzF7sdUS0SrgPBXNnd+BAERHTTMgrw1t35UrOb
         KYTxsfuXYkW3KHcyn6RwM2g5arYSegFuhShUaQTPN6rRiRvpob+cojPqe7YQOQTRMLxH
         +kMdtFf4b/oR47eQCkVAlf1T8KWMmjjongvXkMv2o2ErZmLMdOWZInX3nlBzl7/mBTER
         VDag==
X-Gm-Message-State: AOJu0YwuopFpRts1LbjxwYoYe7Bo/MMs6Udy5A6mKWfHerDsmqFurSsn
        SN23qnw5TJvH2jJjJ94ggOYWG/ZaoQ==
X-Google-Smtp-Source: AGHT+IHr9EOYODQ6j0BtriylyMdcCEFd57N1ORR/U0SxrpWPOj4Kh9FB988mGZIYTgeXUar4RzptMg==
X-Received: by 2002:a05:6870:10d4:b0:1e9:eb35:c548 with SMTP id 20-20020a05687010d400b001e9eb35c548mr313657oar.6.1698343124249;
        Thu, 26 Oct 2023 10:58:44 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v24-20020a056830141800b006ce3241a7fasm2740604otp.72.2023.10.26.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:58:43 -0700 (PDT)
Received: (nullmailer pid 4107072 invoked by uid 1000);
        Thu, 26 Oct 2023 17:58:42 -0000
Date:   Thu, 26 Oct 2023 12:58:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: sound-card-common: List sound
 widgets ignoring system suspend
Message-ID: <20231026175842.GA4101469-robh@kernel.org>
References: <20231023020718.1276000-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023020718.1276000-1-chancel.liu@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:07:17AM +0800, Chancel Liu wrote:
> Add a property to list audio sound widgets which are marked ignoring
> system suspend. Paths between these endpoints are still active over
> suspend of the main application processor that the current operating
> system is running.

Perhaps it would be better to define components used for low power 
audio rather than the OS mode that gets used. Isn't LPA just audio 
handling that doesn't require the OS CPU to be involved? So the state of 
the CPU is kind of orthogonal.

Rob
