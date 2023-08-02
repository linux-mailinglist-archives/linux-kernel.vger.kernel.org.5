Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86A076C875
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHBIif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjHBIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:38:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD2A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:38:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso4263195e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690965510; x=1691570310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ+lNL4fO4KPGrAzOlHkF7rrOY5ykF3mAwSuq0Z7KDY=;
        b=jG2a6Y0+LcpsZztlW3jLfV8otpGZE1pKMJwRzNrp8SnY2R6Z0ZENBBc/9oQEqoq2En
         zPMyVR21fD0lT9udPLrQduGfiz7/6BA0/TzkbAAmhOQbn+wQMj7Hj6t76f3EIE48vS46
         N93IJ67ZG1Etk41/Qe8PPBsDyaz5eQM6HFHCjJDu/yoEHD4ou8VSQE/H/sSNtbM9Bqba
         xeOV9jsH6kL5LOpyi2I0Cqd1ScyhXSS6vh8hw8AAQRleBWeTinKT0zxCkrbbo5U/zPBs
         3hpPPJBncaapQo+H0RTLAKlcAilN1YyIRP6e1NZARI1VD9htnp4Z8n9ZCO5b/9OesPTA
         FgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690965510; x=1691570310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ+lNL4fO4KPGrAzOlHkF7rrOY5ykF3mAwSuq0Z7KDY=;
        b=CAcnj5CCbMBuAEMQNTS3ti4+390nlBtUmko9kuhsyA3NFUfB4tsNYDOaNniyvkPfhM
         X6eDSAxLj5pZ5wTyrbKl3aIK7Zjbudv/fFOWMS0rJtkXHpBE1MAaM29t8o/Y6x/3TxKH
         +FTPmQBANhQmqWV7uZYxpxzR8DK8kFG6vHtMTOcyIeBGBGvtfAw8gYCcs2X2MPieE1Gf
         EDPmkHBHWeMsDm76YaoMKeCNq7HXXBtVMd+o6qiicoEU0Mfg3w2I3dQn1t6cS6MRBXaz
         ZG9Aq39559Jkgd+nrhIuUzjgUbJYfYFe1viSAPkI8hBxgM5nleKOXllsPxCbA/9yMJ+Y
         WEjw==
X-Gm-Message-State: ABy/qLbNupMr15Nk/ZJbRGK3wIPxvZYVfK/Dh/DnDDK9u5RJ6DfjLjLg
        NbmJnDMXlMJwqtJfzjh9UVxaiA8Oitw=
X-Google-Smtp-Source: APBJJlEsy3ACQgE6lOUDSPn2tWv/oqAwyKEEpzaXCPVzqCTaqyZrq4EbhQfMCaLBMl5F/rx45fe0rg==
X-Received: by 2002:a2e:2e0c:0:b0:2b7:33a6:f2c0 with SMTP id u12-20020a2e2e0c000000b002b733a6f2c0mr4643236lju.4.1690965509637;
        Wed, 02 Aug 2023 01:38:29 -0700 (PDT)
Received: from [192.168.0.124] (ip-37-248-152-247.multi.internet.cyfrowypolsat.pl. [37.248.152.247])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e3e05000000b002b9fec8961bsm457240lja.123.2023.08.02.01.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 01:38:28 -0700 (PDT)
Message-ID: <08258243-863b-62b4-bff6-71e28c3208c3@gmail.com>
Date:   Wed, 2 Aug 2023 10:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.08.2023 08:41, Nikita Travkin wrote:
> The driver can be built as a module, however the lack of the
> MODULE_DEVICE_TABLE macro prevents it from being automatically probed
> from the DT in such case.
> 
> Add the missed macro to make sure the module can load automatically.
> 
> Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 1 +
>   1 file changed, 1 insertion(+)

Acked-by: Artur Weber <aweber.kernel@gmail.com>

Best regards
Artur
