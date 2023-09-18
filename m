Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B87A4996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbjIRM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbjIRM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:27:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185699
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:27:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5460350a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695040020; x=1695644820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am3ITFqyqHvAOasQFG8ffUFXROr9lenVSsvirLHr2XM=;
        b=v+ZRHVMFTaN2GuH8JJZTITWpceMfKlr6IPGaLrE+YzfsNVWIkwWt2aF78FUIYKPjeK
         EEoWgLcbZmYJjIaIGnQ5lllJ/rHYrnhlSQ4fXTWQb3e/PFu79GylAeKh9KWG+9j+/bbY
         0n0HoOiJvht8hOlQTIoSdjaTKQWXKibLKzLkm0qtiFuTHyLcQAOrmO6Bz9t92mZ+BPHW
         yRkCZVozegF07j5yP/gx4d6JYw49YQ2+R9ThgFKI8Oh2YIJGVZieBn4VquNMcqQMdnTA
         QLJbet5rmMWB/ePsbjNKXkFR3MZRJS0yK++25nynut+7Hfo3LiQbEd7b7GMLQeW21EQW
         5SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040020; x=1695644820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am3ITFqyqHvAOasQFG8ffUFXROr9lenVSsvirLHr2XM=;
        b=T8gfaeCwx+k2DVp0MK3Kgp1TQGNlnGjr7fUxrnnn0vjw63fMWe6YkHFpf1yJm+nUvw
         b1vhH9I9M+YbyBVH6uQsnMmJ9ptSs+S6ZpA6mK2SCpXI3eitr88wbdqyluVoQovHqEJ2
         SiTvlaTZdqLAq3zJYgstsx1MRDHn1dfscKUmbcgZ7CSlA0+8F+b+MGVvtWDR4g/EnTnc
         JRdBgph8KyN4Rhqmv/opwGGYldWy1rP7SKhhU56NjtFYOsdb1NWWH8Cw26PkJddIV7rm
         Ll5oCGwv25ZhDaDgd8XR5UrV5i5ycALKVQ6cEnynRDEXVX7kTOWNNKZnrliA82jAR2P9
         O16A==
X-Gm-Message-State: AOJu0YxPqYNFwugO+AWS0fraFt50UnPdSkzbJ2ZbjJEaCxlMvaTgPH4v
        +fK1SWJyxlJzDWAphezwNCSnMA==
X-Google-Smtp-Source: AGHT+IGu+xED07hiZ0cuzgue+jBzEz+Yo7PoCuycymv2ln873HHx7cZFFWxCeasLd2FZJIaRvVVsmw==
X-Received: by 2002:aa7:d394:0:b0:51e:309:2e11 with SMTP id x20-20020aa7d394000000b0051e03092e11mr7229931edq.36.1695040020012;
        Mon, 18 Sep 2023 05:27:00 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id t16-20020a508d50000000b0053112d6a40esm1546588edt.82.2023.09.18.05.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:26:59 -0700 (PDT)
Message-ID: <c54a070f-692c-b45d-6170-c52b0d33ba51@linaro.org>
Date:   Mon, 18 Sep 2023 14:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: fsl,mu: add new tx doorbell
 channel
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
 <20230917-imx95-mbox-v1-1-440245287356@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230917-imx95-mbox-v1-1-440245287356@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 14:43, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add new tx doorbell channel for i.MX95 SCMI mailbox usage.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

