Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF3812402
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442856AbjLNAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjLNAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:43:38 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F37E0;
        Wed, 13 Dec 2023 16:43:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a22deb95d21so369148366b.3;
        Wed, 13 Dec 2023 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1702514622; x=1703119422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLpB5md1tEE7IuK+B3sruEQW7P8lycC54rVRstoSoLw=;
        b=Hi8bRobkZd38MwIzsqox+5Fcdlmia96Suk8wc1VIHEWj9K2IBhKp0X34q5X7N+Blbw
         AXPXhYgY0MYjl9zgSGcv40HYSnMPMuJ7wr4AJRlbItQNTGcwdBN+c9AuOGoTWRj4+/Rw
         aTHm1flvFdLq+wpQfjPISiltbvpR1eLba8FYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514622; x=1703119422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLpB5md1tEE7IuK+B3sruEQW7P8lycC54rVRstoSoLw=;
        b=c4HspHSEBFpSJ3phKJCF+4B8m0K7qjzJqEIGSrBBe/YgPDMI2Va6H/aCwqRnXpPN8L
         1zgLXPvefR5OpA5tawoduxxZrBYGyMVzxTYtOgA2Llgg9p7XMFKYPM74ajNfds3XTZAn
         YrzDQsn6GDIceZk6XOw/c0mU5e1hbEdPhfX2VdiDw1VeLxJInGVBcyILiqcfnLFqiqtW
         gHFxrTys936d9Xc0MhSNMSTHclwAvGWbgHn9O2SZn4qAi3CbMMVkfAJoAYaeC4WCYupj
         v66jc4QtUdcV/sv4XMWg2eqa9pDdigAlAl3lbst0aQmdaE1v9v5A2TFwA2U/nhrxGIRR
         /+oA==
X-Gm-Message-State: AOJu0YxtfUZbW1e44d6dQxjUSyWcXa5/tHV6MK7y+x+3XodmlitHpMIf
        pdapfqDqpy7cmROvBpuAcnFBUCLMv2FDyhDVVBw=
X-Google-Smtp-Source: AGHT+IFa9Zm+LfMZFPUZavztuLcHzT2Ycn1Vj82hIrX/b4xCeE4xJgbmsr48xQ/aHgS2Y86FFkv1fdkhWTwCmE5Nadc=
X-Received: by 2002:a17:906:1750:b0:a19:a19b:c746 with SMTP id
 d16-20020a170906175000b00a19a19bc746mr3703966eje.150.1702514622267; Wed, 13
 Dec 2023 16:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 14 Dec 2023 11:13:30 +1030
Message-ID: <CACPK8Xc7XjgBj-SQH45=omjEXd-BpXgcQDp6s8UkJ8QsbnYSPg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Modify DTS of META Minerva CMM BMC(AST2600)
To:     Yang Chen <yangchen.openbmc@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 18:24, Yang Chen <yangchen.openbmc@gmail.com> wrote:
>
> This series modifies the DTS of the Minerva CMM which is the board on the
> META platform that uses the ASPEED SoC(AST2600).

Looks good. I've merged this for submission in v6.8.

Reviewed-by: Joel Stanley <joel@jms.id.au>
