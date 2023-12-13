Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993678118DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjLMQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjLMQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:13:45 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5810C;
        Wed, 13 Dec 2023 08:13:50 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d84ddd642fso5401517a34.0;
        Wed, 13 Dec 2023 08:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484030; x=1703088830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKFwCtE90EPD9y2XJTF44lWNSwXrZ/Ik0w5o/94t9wo=;
        b=rLZ6s6hq/+A38IhIqZVpVkgN+VX8AoxjGU3N+/LbhM25VpWREgQRJtSHby3lCgobnx
         nX/9Lj1F0oYr88SSYoDDRPsBp616pYKM/KV+lh6Qc1NKyTpXosVV3mMJhIMbUTObiGIb
         qXN3TQt4yqMdltmAs6WfvORcYJgM1i1doHR9cnHs1VzAJ+bVb8ClN1U/CevilJ+LLZod
         wa47GVOU5+NddKS8Obp5UFTsUtrmVbyBWr/iyxyXd4dK8AaqRcc2xCXPrCz9tK2coygw
         NLuWi3zkS4UPXjpGp1mBKaGMh+eJ0Jwpg2Yn9aEM9IdP3vM7sIW7no9oJkBKBnVp6WyD
         fvqw==
X-Gm-Message-State: AOJu0Yx/oYmJxqOTsLOMMRqP96FcxL8ovJlR6rWNiAg2LOVb65qdc/0B
        x9xP/8njEvAX9s+MrifTLw==
X-Google-Smtp-Source: AGHT+IHvwtas0Wz/5QoHKT/kRL+DgeC/VW8MvnUtSILOIvJ0GIakLipYqdQA3Ql3Vum+yJU0aDi0bQ==
X-Received: by 2002:a05:6871:6b90:b0:1fa:ff63:2d3b with SMTP id zh16-20020a0568716b9000b001faff632d3bmr7032507oab.44.1702484029822;
        Wed, 13 Dec 2023 08:13:49 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zl10-20020a0568716d8a00b001fb42001fa7sm3978002oab.36.2023.12.13.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:13:49 -0800 (PST)
Received: (nullmailer pid 1207750 invoked by uid 1000);
        Wed, 13 Dec 2023 16:13:47 -0000
Date:   Wed, 13 Dec 2023 10:13:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com,
        lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <20231213161347.GA1204384-robh@kernel.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>
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

On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Add a dt schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> This includes descriptions for the Nuvoton and Infineon devices.

This is incomplete and conflicts with this series[1]. Please help 
review and make sure it works for the cases you care about.

Rob

[1] https://lore.kernel.org/all/cover.1701093036.git.lukas@wunner.de/
