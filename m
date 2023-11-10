Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D899C7E84CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbjKJUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKJUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:53:30 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E09F;
        Fri, 10 Nov 2023 12:53:27 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58a0154b4baso710394eaf.1;
        Fri, 10 Nov 2023 12:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699649607; x=1700254407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEvV6up6i1bmVXQGPQ7nI6E0uipZ7czAkBoWnloW338=;
        b=qTSstPZ+TR8r/07BPOZ7XWKQhPtmSyLcO11n77mZ7kYQ/NTNccOBJVMpIGajykot/+
         I2viS0ebZ/7qI2eqmINUdEbNNKNqni1i4dPYoEyGIi9suxuKN631ciK1XqnuYCo37pao
         lLEuNl8eHQmUgyXHoa1vUXa4rhe7ChsgfTxOrQTnwtwN7qNRWKzZ1X6G7BxzFc9yzUt+
         F+aqTQUivqxksyFwWwvqiEsSe+6VybF7F8GG14p1Bo4KdY2LcuRCu0/T3Pdg0leObDaI
         JeYiWztPJGcgt8OPby1ubWtpeY+QC41MaWCXCjoPV1tn6ApKE7z9PNC/oSpQ5VAp1dfc
         ElSw==
X-Gm-Message-State: AOJu0YyUD0AAUjysQk65l1/Ld4SlfspZalsKgJQVz3J9OrWoGtuPmOYi
        oKs264ZStNuvInKq183yRQ==
X-Google-Smtp-Source: AGHT+IG/EZf6Lcw+9SaA3RqAxpvyogtQj45WDc3IQH3lwKA4HPVfubz5Fy6kv0RFIf82fFD5MurXxg==
X-Received: by 2002:a05:6870:514f:b0:1dd:2a3f:cef3 with SMTP id z15-20020a056870514f00b001dd2a3fcef3mr1980692oak.26.1699649607267;
        Fri, 10 Nov 2023 12:53:27 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830338e00b006bee5535b44sm50533ott.75.2023.11.10.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:53:26 -0800 (PST)
Received: (nullmailer pid 412851 invoked by uid 1000);
        Fri, 10 Nov 2023 20:53:25 -0000
Date:   Fri, 10 Nov 2023 14:53:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, devicetree@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nas Chung <nas.chung@chipsnmedia.com>
Subject: Re: [PATCH v14 6/8] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <169964960493.412801.18307395523292801214.robh@kernel.org>
References: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
 <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
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


On Wed, 08 Nov 2023 20:29:25 +0100, Sebastian Fricke wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Add bindings for the wave5 chips&media codec driver
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  .../devicetree/bindings/media/cnm,wave521c.yaml    | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

