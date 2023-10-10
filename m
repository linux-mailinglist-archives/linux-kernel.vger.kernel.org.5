Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA57BFB76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjJJMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:31:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36216AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:31:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1018627866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696941109; x=1697545909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CYZ+/+DyhZ52BIz8QU22nLu1za05uFMUaEH4Bw/fqc=;
        b=jA1ZfbbwHFi/221nnKcBzWJ1nDGHJVDss9/TBghYOwUe/25ozgCa6N5JYDpT+IrDR0
         juFFOPqdqkNzfzNvJZHszC7N3jeKpO5RizCYMhqBKC7XZTlM+PKC+c2ZycAyOxuW0L6t
         dpPxjC9z8+zc4RicA8jB7wD54+o0FFRlCGpISldS8Sf574IYd1NYrSfP3fiylefzpcS4
         Gvt/2t8sKlOuZ5+ZlB3/KvRVXI66DL4ICorBwdGXfF/a+ymy61VE95PwFv4AgrsaaQCb
         WyVJFRaEA4+Ki/UuoTYfQvMWoqLye+QHto4hVAE4MZD3KVNDKkkSaXCbN1VLaTNAeQS5
         RbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941109; x=1697545909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CYZ+/+DyhZ52BIz8QU22nLu1za05uFMUaEH4Bw/fqc=;
        b=MV9+d91j1lZadp+xMEJVpQP5L2TdrmTOIfp7Lxo3/pZvSWY+0yeNhRFDggFnXNFErT
         RQLjPe5giLtcEA9nn0o0EzZg+ecitzPY3r1fhvrU/2vDAUoChEBCWffiwrma4l9vFdFg
         bU+SwvZVo1tvZrqDF/ybFht6zMwC4ZEAbsplhItYth87GvA6fjAmhJbANcAlw/erSc9u
         u0QnOMB72pKA5aDGdWtgIYfOYSXE8mGiWJuIr8KdHne6iRjHqYmxqvlSujAPOztaFj3V
         AEQ+emdpTWbPaXwD7OXkGG2mykCTvvAV3oKnEtYBGrU0dFN4qvMx+AzmpA07C9qiktO5
         UJsw==
X-Gm-Message-State: AOJu0YybnZmVW+oSuErpebG10RT3fzhGtBzjEE+GuZSGkVasM5QnfJBa
        hELbm+kn4VHmd2sB3z53ABGZRw==
X-Google-Smtp-Source: AGHT+IGrJz2OZy7bjQItLxH2CVQ0LtUM1928DgKjvDvFMaoCllpF2bQB9OvuQc+61e+7xUGcp/crSw==
X-Received: by 2002:a17:907:7613:b0:9ae:55ae:587f with SMTP id jx19-20020a170907761300b009ae55ae587fmr14973981ejc.37.1696941109625;
        Tue, 10 Oct 2023 05:31:49 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906560500b009b8dbdd5203sm8394159ejq.107.2023.10.10.05.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 05:31:49 -0700 (PDT)
Message-ID: <ea2b3e42-9bf8-489c-b2d9-584ee2d909f4@baylibre.com>
Date:   Tue, 10 Oct 2023 14:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: fix clock names for power
 domains
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231005103041.352478-1-eugen.hristev@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231005103041.352478-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 05/10/2023 12:30, Eugen Hristev wrote:
> Clocks for each power domain are split into big categories: pd clocks 
> and subsys clocks. According to the binding, all clocks which have a 
> dash '-' in their name are treated as subsys clocks, and must be placed 
> at the end of the list. The other clocks which are pd clocks must come 
> first. Fixed the naming and the placing of all clocks in the power 
> domains. For the avoidance of doubt, prefixed all subsys clocks with the 
> 'subsys' prefix. The binding does not enforce strict clock names, the 
> driver uses them in bulk, only making a difference for pd clocks vs 
> subsys clocks. The above problem appears to be trivial, however, it 
> leads to incorrect power up and power down sequence of the power 
> domains, because some clocks will be mistakenly taken for subsys clocks 
> and viceversa. One consequence is the fact that if the DIS power domain 
> goes power down and power back up during the boot process, when it comes 
> back up, there are still transactions left on the bus which makes the 
> display inoperable. Some of the clocks for the DIS power domain were 
> wrongly using '_' instead of '-', which again made these clocks being 
> treated as pd clocks instead of subsys clocks.

-- 
Regards,
Alexandre
