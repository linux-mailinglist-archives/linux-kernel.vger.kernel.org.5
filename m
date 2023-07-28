Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200A7678B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjG1WyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1WyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:54:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DEA4227;
        Fri, 28 Jul 2023 15:54:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbc87ded50so16851325ad.1;
        Fri, 28 Jul 2023 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584851; x=1691189651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zc8+sGWhbpOdXVIwzE3ScTJ7Zz2Q0Ibxyt5Y9kdOrRQ=;
        b=F9DnRzMcKLeBLp9H9vzyTwLLbPSGmqJMY+saux76gXcrxoquPK1KlnKfoqFHBA02fc
         yQpMktQgoMNa7NkBisArNKgePhAARuUVhWYBg9xhvaIwJ76TyQVWWJnFcjUSqQ7Y1wnt
         gaZYD1Y3Edn1RBLGa3ZoCSuoaCbTU2RYqu3sAaX7OSL93HTQp+nr8fvN9uH7Nh3/W92v
         8eMcwB1MZTF2Ajal3PVZyooPDHL2bSWHPjxIlGoRndSG+nzswsbMRWPAg6TtL9UMEX+P
         Cf2uu232fjUuagMvVLppLSeQ+/p9glLU8WxlPfZ8MWfo7cGswn2k6muQF/CVT3fDj4rk
         s5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584851; x=1691189651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zc8+sGWhbpOdXVIwzE3ScTJ7Zz2Q0Ibxyt5Y9kdOrRQ=;
        b=A12loALfeVJ5WoXmlV0E9+hAOFJgsYYOz8kgqwMNRixOFIt96s/SMVpXvHE5E1c4Iz
         7hd+fImOVeUFPitrxOYN9XBbuvVaE5dD1Z1wVTiNAYv7x+JbD7te5bSYrnmRxFFoVvwV
         +Raphp5evtSbSpTaTOS5nZZipMyjovrXZkssXCCyHgUijpxIwuYwKgD7Oei7EjBUg2kO
         EOMWP5ZStTQAfiUIZWyqhj/mWmInfhdZzJuOiYgc+7g0eeIYJOjQvPq4LeZGWi0sYY1K
         zrTJEjr8OoYIGA0aM1z8DmFh5rpMR3hOrfzM8K+B61HewJN5IxhL1WcqRwEGnQebSTyi
         l2OA==
X-Gm-Message-State: ABy/qLaTtwKDynCpHb0+zNEIclHBI5muXSGq8/Wx9JP/wI4epgjtPHzB
        z3ypK81K//IRcVryeWBReXE=
X-Google-Smtp-Source: APBJJlFZT/vkJrVA0QkpIDS3NkcH9+t0rqUMG50xkzbm86rck4ax8a36SYFhbGr/Yg3l4tNgD/lx+Q==
X-Received: by 2002:a17:902:b108:b0:1b6:8863:8c9f with SMTP id q8-20020a170902b10800b001b688638c9fmr2743877plr.6.1690584850941;
        Fri, 28 Jul 2023 15:54:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ij22-20020a170902ab5600b001bb0b1a93dfsm4138649plb.126.2023.07.28.15.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 15:54:10 -0700 (PDT)
Message-ID: <0a208142-1c71-f997-4d77-961d3bc91343@gmail.com>
Date:   Fri, 28 Jul 2023 15:54:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 15:51, Mark Brown wrote:
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX commits. 

Did you mean to write "delays" instead of "commits" here?

> Since
> bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> this has caused misconfiguration of the PHY, rendering the network
> unusable.
> 
> This was worked around for ACPI by ignoring the phy-mode property but
> the system is also used with DT.  For DT instead if we're running on a
> SynQuacer force a working PHY mode, as well as the standard EDK2
> firmware with DT there are also some of these systems that use u-boot
> and might not initialise the PHY if not netbooting.  Newer firmware
> imagaes for at least EDK2 are available from Linaro so print a warning
> when doing this.
> 
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Signed-off-by: Mark Brown <broonie@kernel.org>
-- 
Florian

