Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647B7DBA21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjJ3Msn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJ3Msl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:48:41 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4BB4;
        Mon, 30 Oct 2023 05:48:39 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b2e22f1937so2443173b6e.1;
        Mon, 30 Oct 2023 05:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670118; x=1699274918;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0sHj+qaTmXTMscpJuCwN/A4yXlW+dYGaHAy5RxzFWNk=;
        b=S6zUx5tBa183Pzvcbik0ynF5pdGm8lFKCtPosLjQOTAvIlu0lpDZWqB0vdVYshyROS
         inlxX9BVIfsJuyHwY+3LStxiD1RDeI/MWg4MW6L+Rbet37vs3a50zob2jvYahNR7qyR5
         SC+knWMrlsBRGUT8ZO453cFLyczdGvB7Y9m6xiVjBuB+iSS5WfnSN6DtxuY6yL61TeQB
         Yj1jHkubr7kzzymUogJFFPLRAcLFw8WYki9EmoFgoFvfcsGYjDVdky+YsaRAC/k4Ne29
         rxPfgKbgqxP115Etm8qHZgDurOXRxx6d++vcvlYFTKnGJ3xtJ7iMz45eMXw7ue+MbmQx
         aCZA==
X-Gm-Message-State: AOJu0YxbK1fDps2JJp32GqUYNtYJuu6hJ53CLgvxdEoU4NUjmpr7T387
        nzhX4u0ac3S6ra7XvOx/Pg==
X-Google-Smtp-Source: AGHT+IHqTv6Ycn2tHjE8qvZ0dxeqUqbmStnWFnI/LUkn/IFbPOnhHl0u37HVdadgB61tglTvW5xSMw==
X-Received: by 2002:aca:1917:0:b0:3b2:ddc0:ac9c with SMTP id l23-20020aca1917000000b003b2ddc0ac9cmr8957083oii.39.1698670118214;
        Mon, 30 Oct 2023 05:48:38 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 13-20020aca0d0d000000b003ae540759a0sm1347064oin.40.2023.10.30.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:48:37 -0700 (PDT)
Received: (nullmailer pid 688312 invoked by uid 1000);
        Mon, 30 Oct 2023 12:48:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     chris.packham@alliedtelesis.co.nz, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, pali@kernel.org,
        cyuval@marvell.com, gregory.clement@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, andrew@lunn.ch,
        conor+dt@kernel.org, mrkiko.rs@gmail.com, robh+dt@kernel.org
In-Reply-To: <20231029174814.559583-3-enachman@marvell.com>
References: <20231029174814.559583-1-enachman@marvell.com>
 <20231029174814.559583-3-enachman@marvell.com>
Message-Id: <169863125398.3865774.11413601961068945959.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: arm64: dts: add dt-bindings for
 Marvell COM Express boards
Date:   Mon, 30 Oct 2023 07:48:34 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Oct 2023 19:48:13 +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add dt bindings for:
> CN9130 COM Express CPU module
> CN9131 COM Express CPU module
> AC5X RD COM Express Type 7 carrier board.
> AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../bindings/arm/marvell/armada-7k-8k.yaml        | 15 +++++++++++++++
>  .../bindings/arm/marvell/marvell,ac5.yaml         | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml:37:12: [warning] wrong indentation: expected 10 but found 11 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231029174814.559583-3-enachman@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

