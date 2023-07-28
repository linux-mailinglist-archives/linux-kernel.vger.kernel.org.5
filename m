Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD97673B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjG1Rpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjG1Rpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:45:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3F3C22;
        Fri, 28 Jul 2023 10:45:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9bd59d465so36014151fa.3;
        Fri, 28 Jul 2023 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566331; x=1691171131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHaK57LxhXb0XMcQdqZ+DIRhkGspagwLdLAL4yH6+xQ=;
        b=FPpH0jTlXyY0Yu3gf/e8IVnqXUgQaFXPMN1WT8RIxByHkBeiuqzGSmJFjEQGD+i8tk
         SGYpkGguwIiCnqVA7T3m3eWa3sDnGdmzGxb5riTGlnITL/ShbvyqwEeUREbLlM99IJ0j
         AJas4nYw8Ez3xfUkHeZVK4vzCKfQ86eMxcvUUnT3ifOAcItjzdGlj8AF3iGtQow/84XL
         SIEmQt3rKt3l19P0kljAusTq/Im6L1rJKZ7a/n6AuDHat5VBTHG4e1obF1QD9093T2Fx
         WR5i8pQ59Pg6ZPAdLis1VJkj+eXPQ9ff+PnBTaeUuytqjtk7kJcsoePeCy3ZMeAXqHlH
         q+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566331; x=1691171131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHaK57LxhXb0XMcQdqZ+DIRhkGspagwLdLAL4yH6+xQ=;
        b=jzyGoAVQo0EugSE6Eix/4z0TqoLYuwd4in9BpciDpjrwFP9UQ0gxrt+qLpOTszxzPD
         o7ui2QdcAMmhEDtlmz0bhmMDzqDhqgLlk1HmyY1CZo4EhIQTCGZlS+QULVbvXvJV8vtr
         uN5xbQLQYRz8A2oRBzXJDjF0fZ16o8O0zV/G1eII0tRSOiJ5URhzIw/kU9BwxExOSZaL
         8BUoJpiHzCmrG8Xv5Owm687jFbTPFC47A+iG88UqjTyNY5JUusMBSPGISq33FJU5PiMd
         alS21yz4yRFiv6UqV5WAhj4ZSxz2VZQx3iAgSYolj37y4j8eq6qGFjzhpQdPU3G8ZqY8
         /tfg==
X-Gm-Message-State: ABy/qLYCLZP1ciPVE7yL/GAAR4Uk2zj2gPBIxgN3hmv4LCpTcdaxh661
        BWi6VtMXDiRRZUUGleChQAg=
X-Google-Smtp-Source: APBJJlGFCZzgHC45HD9Rruz/yfE5TvbPMb8kX13jmBgkKPJxoaeO0akqQ+UAf6aee7iBi6HjVSLnKA==
X-Received: by 2002:a2e:9587:0:b0:2b9:cd3d:4127 with SMTP id w7-20020a2e9587000000b002b9cd3d4127mr2457636ljh.6.1690566330576;
        Fri, 28 Jul 2023 10:45:30 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id x11-20020a05651c104b00b002b6e15ccf88sm1047299ljm.135.2023.07.28.10.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:45:30 -0700 (PDT)
Message-ID: <659eaf13-e6f6-85cc-2e71-f936b9a23bf5@gmail.com>
Date:   Fri, 28 Jul 2023 19:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] wifi: mt76: split get_of_eeprom in subfunction
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230708182936.24469-1-ansuelsmth@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230708182936.24469-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.07.2023 20:29, Christian Marangi wrote:
> In preparation for NVMEM support, split get_of_eeprom() in subfunction
> to tidy the code and facilitate the addition of alternative method to
> get eeprom data. No behaviour change intended.
> 
> While at it also drop OF ifdef checks as OF have stubs and calling
> of_get_property would result in the same error returned.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Rafał Miłecki <rafal@milecki.pl>
