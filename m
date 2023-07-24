Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D075FFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGXT17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGXT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:27:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B010F4;
        Mon, 24 Jul 2023 12:27:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso46653645e9.1;
        Mon, 24 Jul 2023 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690226869; x=1690831669;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzswZ7cvZqrKthquKsOzOGQ8wcPf/nilKJg12BcexjI=;
        b=dazVC8afqKs6Rjp40IaV5AyNJvHn4lDBmpb4ioYlS6ttazog3VTVHkc2bHODCQZ0KR
         Uy4D6OsKn0GIqQJfSUalyR1xg//8aMWnibNV2hV8NDJl/g3DRr83YJMhMlFhaDwfgE0r
         BYxFxyey2H4liGzaliJ+a/s5PGF32uuedQLz9d81JjvT2h7anCM34GcajTru/5YetLJC
         vV1Tto9RPBLMbkT5mD6pRNGbfDlLoi+ML3RzK9a+iX5+iXD3VwTPFw4L7iUcE6IP37YG
         xNkzDFKaricnn2FPZOD1jtz/gR0b7Po7ovbLnApN9lOO1EOMzi/QBtBjtTWbdAeTMsgw
         UXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690226869; x=1690831669;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzswZ7cvZqrKthquKsOzOGQ8wcPf/nilKJg12BcexjI=;
        b=Y8if0m88H9bFxXElHsZLpdRh1RuP0wT2pegDcHay3n5+kqwtCXWsf6Fbj1ol1bHwiO
         rFp8yH8WXfPXMLr2UzkOh/H2H608Ka42ETSOXtZ6MRktQlj/nCGoSsLgQjf0his60FAT
         6MYtuaOBELhWS7/sbJjX20Nu7QvPDsGOfSw/mVnL4MTljrZ8LUPaXCSCAK6mrYd4E1/H
         nPRN1vXgdussH/1SKLrOwYJ2dCbRQIWGhVDq/vI4UXUOdzlQNIFyMgGzEOfXL3zQSOrD
         3pKM9yhDXw//ifa17mEh/wUVudL8NV5vBe24hAZVuSY2+vTKXmwAikL0apu/fsVztI4Z
         XZ0A==
X-Gm-Message-State: ABy/qLYipx9Q8VPwod+mnHTVxEEg36Nm/PUaQKuZuqXHrDCUrL1B9CXY
        Lwl6DvQ3YIHmEn8Hz0acY+8fj8e1jR4=
X-Google-Smtp-Source: APBJJlGlTtrDwM+5RbUqV7cYNdSOCdnc+y/Kw20LGTdn51rVc5lAO2eXQaTvORdG0E22PAHT3KJDlQ==
X-Received: by 2002:a05:600c:40c:b0:3fb:dd9c:72d2 with SMTP id q12-20020a05600c040c00b003fbdd9c72d2mr8471512wmb.31.1690226868679;
        Mon, 24 Jul 2023 12:27:48 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003fbb5506e54sm11047530wmj.29.2023.07.24.12.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:27:48 -0700 (PDT)
Subject: Re: [net 1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
To:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        leon@kernel.org, pabeni@redhat.com, bhutchings@solarflare.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org
References: <20230723150658.241597-1-jdamato@fastly.com>
 <20230723150658.241597-2-jdamato@fastly.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6f7e5c45-9961-3ac2-69ae-434191c9e11c@gmail.com>
Date:   Mon, 24 Jul 2023 20:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230723150658.241597-2-jdamato@fastly.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 16:06, Joe Damato wrote:
> ETHTOOL_GRXFH correctly copies in the full struct ethtool_rxnfc when
> FLOW_RSS is set; ETHTOOL_SRXFH needs a similar code path to handle the
> FLOW_RSS case so that ethtool can set the flow hash for custom RSS
> contexts (if supported by the driver).
> 
> The copy code from ETHTOOL_GRXFH has been pulled out in to a helper so
> that it can be called in both ETHTOOL_{G,S}RXFH code paths.
> 
> Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
