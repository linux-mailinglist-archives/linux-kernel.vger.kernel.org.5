Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14467DE233
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjKANsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKANsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:48:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77B10C;
        Wed,  1 Nov 2023 06:48:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so100047061fa.1;
        Wed, 01 Nov 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698846509; x=1699451309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypnAFcKaxcGrebt4YkydHFPrDnm46ZqpTii7CDbQCEY=;
        b=kFGq2QtxR8vGQpZ9m3j9cHga6Mf94kizVjjaToSnsY+15ZeDjs2Nt1iEy7D/dMswRF
         2Sc8E2J2TK+TP0HtqI51cKxzKUzpwcdQ87gqgZVOcH0CdhbKKNEiPynMwtDl+4eYxES4
         qgH6PVFbRdon84urNE4kt9VmzQtTeVCimB90Ksljn/tNqKbfTXH/5CbP08j+FqaoKbvo
         bSugvL7UsnmGeYeDqpxaDz7ozt+/JSlFBQWRrdxipgKxEww9z88PrtvxhG5DX4Ku4hwz
         YyjU4XwCkFJDmFQoSfggr61GShfUs1IQpfpgLSGjQh0PPFjFq2O020NBIE/2E75t5HGU
         KhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698846509; x=1699451309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypnAFcKaxcGrebt4YkydHFPrDnm46ZqpTii7CDbQCEY=;
        b=id45htP7QvSOY6L3buFzm1ulDxMKzC4h3mxAVwEIxA7bwo6nT9VnqO0ZTsalpopcyn
         uHxMIrooEA+5pauO9c2pn75Q35CrzN3JlpmwaXD+ubkN8HM/CyOyb7Z/JchIsdi8xkda
         V5o5AT0LBPE4OWUczLEucYwC1UzRO94XCvieMPH9ve5n/AhrPKKHLYesk9QcSjMiHT/G
         wa1/+ZKFe8emzLJadQLMUriXLJC1PMlKs5CoJTcwDtEcZeAXd4v8hjRCOGE6fanriyo5
         oUDQVftpNM3X2FHBtjVGakXVLap1gB0Qw16OgBoRUHh7QE9C5spdYB5Rm2rKlEJ973HH
         O1VQ==
X-Gm-Message-State: AOJu0YwFSzWjXXr2NXD/ge+PQ/jPkHHhQcTN1O2PCPEEsNjon6BkDlVl
        VD5wqk3njZ2zxQMmHKQrlXk=
X-Google-Smtp-Source: AGHT+IH0olDc5ndrSrDBXxxXXQwDGLg9PtRgHABkRp98qEUSj5BFubA+3kWVV8WIeZSqBzewLXeKIg==
X-Received: by 2002:a05:6512:1388:b0:508:26b6:bc21 with SMTP id fc8-20020a056512138800b0050826b6bc21mr13510216lfb.40.1698846508452;
        Wed, 01 Nov 2023 06:48:28 -0700 (PDT)
Received: from [192.168.0.108] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.googlemail.com with ESMTPSA id h31-20020a0565123c9f00b005048f11892dsm222024lfv.171.2023.11.01.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 06:48:26 -0700 (PDT)
Message-ID: <e88ce2bc-71eb-490c-8640-80c24a9ae18a@gmail.com>
Date:   Wed, 1 Nov 2023 15:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] media: qcom: camss: Introduce support for named
 power-domains
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231101-b4-camss-named-power-domains-v3-0-bbdf5f22462a@linaro.org>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <20231101-b4-camss-named-power-domains-v3-0-bbdf5f22462a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.11.2023 12.54, Bryan O'Donoghue wrote:
> V3:
> - Includes bugfix reported on IRC
>   genpd_link and genpd should be checked for NULL on the cleanup path.
>   Matti Lehtimäki 
> - Retains NULL check before dev_pm_domain_attach_by_name()
>   I experimented with the suggested drop but of_property_match_string()
>   chokes
>   Link: https://lore.kernel.org/lkml/883ce8a7-80e1-4065-a957-424d0b4a6535@linaro.org/T/#m10e5a43d0245f13eca177ef2f65b24259c641030
>   Konrad
> - Fixes spelling caught by codespell - Konrad
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/b4/b4-camss-named-power-domains-v3
> sm8250-testable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/b4/b4-camss-named-power-domains-v3+sm8250
> 
> V2:
> - Incorporates Konrad's suggestion re: removing 'id'
> - Adds RB - Konrad
> - Adds in a flag to indicate if a VFE has a power domain.
>   As I rebased this series I realised we had some magic indexing for VFE v
>   VFE Lite, which isn't the root cause of my bug bear in this series but is
>   the same sin - inferring functionality from indexing.
>   Once we transition fully to named pds we won't need a 'has_pd' to flag
>   which VFEs need power-domain attachment and which don't.
>   That transition will require populating all upstream dtsi with pd-names
>   and then deprecating the old way.
>   has_pd is a far better choice than inferring from indexes so, I've added.
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/aa45a2b58aa1e187a2698a65164d694251f08fa1
> 
> V1:
> At the moment the Qcom CAMSS driver relies on the declaration order of
> power-domains within the dtsi to determine which power-domain relates to a
> VFE and which power-domain relates to the top-level (top) CAMSS
> power-domain.
> 
> VFE power-domains must be declared prior to the top power-domain. The top
> power-domain must be declared last. Early SoCs have just one top
> power-domain with later SoCs introducing VFE specific power-domains.
> 
> Differentiating between the number of power-domains results in lots of code
> which is brittle and which we can mostly get rid of with named
> power-domains.
> 
> The reliance on declaration ordering is in-effect magic number indexing.
> 
> This series introduces named power-domains for CAMSS and refactors some of
> the code in CAMSS to support the new named power-domains. We continue to
> support the legacy indexing model with an intention to remove after a
> reasonable transition period.
> 
> New SoC additions should use named power-domains from now on.
> 
> Tested on x13s, rb5, db410c
> 
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-23-camss-named-power-domains
> 
> Bryan O'Donoghue (5):
>   media: qcom: camss: Flag which VFEs require a power-domain
>   media: qcom: camss: Convert to per-VFE pointer for power-domain
>     linkages
>   media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where
>     applicable
>   media: qcom: camss: Move VFE power-domain specifics into vfe.c
>   media: qcom: camss: Add support for named power-domains
> 
>  .../media/platform/qcom/camss/camss-vfe-170.c | 36 --------
>  .../media/platform/qcom/camss/camss-vfe-4-1.c |  8 +-
>  .../media/platform/qcom/camss/camss-vfe-4-7.c | 36 --------
>  .../media/platform/qcom/camss/camss-vfe-4-8.c | 31 -------
>  .../media/platform/qcom/camss/camss-vfe-480.c | 36 --------
>  drivers/media/platform/qcom/camss/camss-vfe.c | 77 ++++++++++++++++
>  drivers/media/platform/qcom/camss/camss-vfe.h | 16 ++++
>  drivers/media/platform/qcom/camss/camss.c     | 87 ++++++++++++-------
>  drivers/media/platform/qcom/camss/camss.h     |  7 +-
>  9 files changed, 156 insertions(+), 178 deletions(-)
> 
> --
> 2.42.0
> 
> ---
> Bryan O'Donoghue (5):
>       media: qcom: camss: Flag which VFEs require a power-domain
>       media: qcom: camss: Convert to per-VFE pointer for power-domain linkages
>       media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where applicable
>       media: qcom: camss: Move VFE power-domain specifics into vfe.c
>       media: qcom: camss: Add support for named power-domains
> 
>  drivers/media/platform/qcom/camss/camss-vfe-170.c | 36 ----------
>  drivers/media/platform/qcom/camss/camss-vfe-4-1.c |  8 +--
>  drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 36 ----------
>  drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 31 --------
>  drivers/media/platform/qcom/camss/camss-vfe-480.c | 36 ----------
>  drivers/media/platform/qcom/camss/camss-vfe.c     | 79 ++++++++++++++++++++
>  drivers/media/platform/qcom/camss/camss-vfe.h     | 16 +++++
>  drivers/media/platform/qcom/camss/camss.c         | 87 ++++++++++++++---------
>  drivers/media/platform/qcom/camss/camss.h         |  7 +-
>  9 files changed, 158 insertions(+), 178 deletions(-)
> ---
> base-commit: 48016737a9af47328dd321df4dd3479ed5e2041d
> change-id: 20231031-b4-camss-named-power-domains-cc2ac2722543
> 
> Best regards,

Tested the series using work in progress SC7280 CAMSS.
Power domain handling works correctly.

For the series:

Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>

