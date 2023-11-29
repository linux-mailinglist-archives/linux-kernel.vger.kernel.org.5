Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09897FDA71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjK2Ox5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2Ox4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:53:56 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D89BE;
        Wed, 29 Nov 2023 06:54:02 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1fa235f8026so2672357fac.3;
        Wed, 29 Nov 2023 06:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269642; x=1701874442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea/iuRLQ3MiOQbUR87zXKlf7PgJMpl4mFKJ4sK0omKs=;
        b=C8wVbHlrXxXXHvph7+FT89BofYCysccbYbOGoVYL5ta1qcc3U1Qccbe9h+6zbXKsoL
         8xAZokW3gTC/SaOihZPft1+bNLMtQg8f/dHJz+egTv2TdytzSgXPcFG9R5gCg4AIYPtL
         9Gx2jRZ0KWdRovnvN+iWa31m1+JQE07s62KbapySVJrbogV99pBb0eKjAbUG+9d/JQxk
         4Y2ayddeMSIrtuhlZSC1xlAryK2TVkEELhTEV25N9RQ6S7TxPy+DDD3ZTM2f3ixzt0DJ
         AHnrejCBWxuPihCqYdRsHj4JdbtkvbCMXWHVoLzxWObRL07KAfXE1+xyZstltzhhcYba
         CXFw==
X-Gm-Message-State: AOJu0YxFvkaskRJ8qPhHZ0tuyE8/bks9Ry0PMYFXTdek9LSokr7Lvjyw
        1aiiNZrzUua2GQm8ls5mQg==
X-Google-Smtp-Source: AGHT+IEKQZCzwe94OXoL3+AZ7eYT2112nCdj6/VnLFu1cjYWi2d5/xc1SEv31Wkuo3A4ZWK/3DhFNQ==
X-Received: by 2002:a05:6871:5811:b0:1f9:4244:4c52 with SMTP id oj17-20020a056871581100b001f942444c52mr22776977oac.41.1701269641968;
        Wed, 29 Nov 2023 06:54:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mn13-20020a0568700c8d00b001fa3ab0a3bdsm1982754oab.31.2023.11.29.06.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:54:01 -0800 (PST)
Received: (nullmailer pid 2458296 invoked by uid 1000);
        Wed, 29 Nov 2023 14:54:00 -0000
Date:   Wed, 29 Nov 2023 08:54:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, daniel.baluta@gmail.com,
        alsa-devel@alsa-project.org, iuliana.prodan@nxp.com,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH v4 2/2] ASoC: dt-bindings: audio-graph-port: Document new
 DAI link flags playback-only/capture-only
Message-ID: <20231129145400.GA2447249-robh@kernel.org>
References: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
 <20231128081119.106360-3-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081119.106360-3-daniel.baluta@oss.nxp.com>
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

On Tue, Nov 28, 2023 at 10:11:19AM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Document new playback-only and capture-only flags which can be used
> when dai link can only support just one direction: playback or capture
> but not both.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/sound/audio-graph-port.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> index 60b5e3fd1115..b13c08de505e 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> @@ -19,6 +19,12 @@ definitions:
>      properties:
>        mclk-fs:
>          $ref: simple-card.yaml#/definitions/mclk-fs
> +      playback-only:
> +        description: port connection used only for playback
> +        $ref: /schemas/types.yaml#/definitions/flag
> +      capture-only:
> +        description: port connection used only for capture
> +        $ref: /schemas/types.yaml#/definitions/flag

It seems like we have a random mix of port and endpoint properties here 
and I can't tell what's the logic for deciding the right place. 
Everything in port is also in endpoint, so maybe using port is 
deprecated. In most cases for graph bindings, we put properties in 
endpoint nodes.

Rob
