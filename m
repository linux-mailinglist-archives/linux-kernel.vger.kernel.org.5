Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058F81385D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjLNRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjLNRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:20:47 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68675B2;
        Thu, 14 Dec 2023 09:20:54 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9e2d50e61so5879696b6e.2;
        Thu, 14 Dec 2023 09:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574453; x=1703179253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bRpMT8adyLjuk8v3m+Q7iMZxQW0r3mgWAJ3z5hKZNg=;
        b=mdeiyd4ZDe2FlWjP/JQ6cadgInN4sJEUifOxPSTf43IT2GElxyu/KO8nYwLxHvHACz
         PrusoF3mplullW7N32VHhw9+zlnRrcG955NRnGKhZCa9c7mLpseNDGGA9CeWuuUHPHdV
         pgWvMW5V/i+uAiuz99Ti0SimMuIo0md4QI71enyl9hhTFhKpobLOMzKqa5LkebNRmvVS
         fiDQbbQzZN7a7KluoTdIFslS+uvUAlqzUW4zh6lPcDeCy9FpcuqUbRB2xAp8AUBGz2Gu
         Oq6S6mLWKlVIJyT4vPDz3QCtBPSec0DrUtOh8ZKp2Psz51Z7dFIdmgBSAM5zUuHAclbN
         /QiA==
X-Gm-Message-State: AOJu0YymwRzFgNoSZsAc11dgnMxZYglnvLTUqAhLIZasteL5LWK50b5t
        JqW18Tl+lyGndJOMy/eTggU1Q+73+g==
X-Google-Smtp-Source: AGHT+IFG1H7d5qx/OPE9NFJC6FAAQwsK89rA2Zqb4ztseS1evSpGKvGvToAZ/lZKGdOpICFILPvMYg==
X-Received: by 2002:a05:6870:4209:b0:203:56f5:5a29 with SMTP id u9-20020a056870420900b0020356f55a29mr895478oac.16.1702574453615;
        Thu, 14 Dec 2023 09:20:53 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
        by smtp.gmail.com with ESMTPSA id so10-20020a056871818a00b001fb1f2c424fsm4597941oab.45.2023.12.14.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:20:53 -0800 (PST)
Received: (nullmailer pid 614807 invoked by uid 1000);
        Thu, 14 Dec 2023 17:20:51 -0000
Date:   Thu, 14 Dec 2023 11:20:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/16] dt-bindings: phy: qmp-ufs: Fix PHY clocks
Message-ID: <20231214172051.GA611674-robh@kernel.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
 <20231214091101.45713-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091101.45713-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 02:40:46PM +0530, Manivannan Sadhasivam wrote:
> All QMP UFS PHYs except MSM8996 require 3 clocks:
> 
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC or TCSR (since SM8550)
> 
> MSM8996 only requires 'ref' and 'qref' clocks. Hence, fix the binding to
> reflect the actual clock topology.

Breaking the ABI is okay because...? Please explain in the commit msg.

Rob

