Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA8016D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441843AbjLAWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjLAWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:46:23 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A7E0;
        Fri,  1 Dec 2023 14:46:30 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d7fa93afe9so679916a34.2;
        Fri, 01 Dec 2023 14:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470789; x=1702075589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsJlub1jKb7AVxZRT2Qd6Hjew3onl3DN9hVzEMU4t/E=;
        b=VzzVT4BwStBpnzx+cD7mUO/LYgLYFwGtzzyh8JuqBpuxjQshUw5aoAYSjaTVtP04TA
         hSVMd8MOZb9haI1nT2dKSK38ntwHd/XdSlUB647Q4PdTovrtjFmOzjdu5thQt6elQFLT
         4CM1OVrtPlab1tIWsTjLLvLEf6g/EKj7DRjdStNVddln6oR9tMiw5m+z/uobFmNbxW6k
         qUeNLlXwDcKPSXdJ6SttypXEgs9l3ioxfqiSQax3NcA0++ZrlQ4QoN139bRUT8WMl0e3
         R0pp2TNpW9xXHIIvLqVgOJzLhscnGMMJ+AJGMUI+G3/sLs5tL74txCvKdO0o2A8pzPv3
         aoxA==
X-Gm-Message-State: AOJu0YzOEhxPFYszhncx6QrXsf+D4fSxYK1ZRLEVNZzdfMuOSbiazwHE
        NANxQNPmQpwN1FOfZAqdEjuz9qeXIA==
X-Google-Smtp-Source: AGHT+IFEzpdrZvP08UQ5AKzXn3nOe74340Cbmknp6Vg3gEN0o8klYjfJl0ZLYKiXwsntkXmY3sMMmw==
X-Received: by 2002:a05:6830:448c:b0:6d8:74e2:6f2f with SMTP id r12-20020a056830448c00b006d874e26f2fmr249091otv.43.1701470789556;
        Fri, 01 Dec 2023 14:46:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q3-20020a9d6643000000b006d7f6adcbb6sm638104otm.78.2023.12.01.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:46:28 -0800 (PST)
Received: (nullmailer pid 2632594 invoked by uid 1000);
        Fri, 01 Dec 2023 22:46:28 -0000
Date:   Fri, 1 Dec 2023 16:46:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix
 regulator binding
Message-ID: <20231201224628.GA2631861-robh@kernel.org>
References: <20231201164546.12606-1-johan+linaro@kernel.org>
 <20231201164546.12606-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201164546.12606-3-johan+linaro@kernel.org>
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

On Fri, Dec 01, 2023 at 05:45:44PM +0100, Johan Hovold wrote:
> The regulator child nodes do not have unit addresses so drop the
> incorrect '#address-cells' and '#size-cells' properties from the parent
> 'regulators' node.
> 
> Fixes: 352335a6aced ("staging: hikey9xx: hisilicon, hi6421-spmi-pmic.yaml: simplify props")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml       | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
