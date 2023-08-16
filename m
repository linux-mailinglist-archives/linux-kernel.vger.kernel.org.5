Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA777DE62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbjHPKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbjHPKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:18:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F681990
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:18:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so59761585e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181117; x=1692785917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/clY/dRW1xIHeRIxZxe1CCICvaVCPAzy02zhvzR3a8=;
        b=TSzgzVTJUl1fWL09M1YvugYA7/4Jvd3vZ2D+VuPfos/0AqPx3UGohziKzqIuD5U2le
         dkk/F3CVBrtSFwUs+/Q229MyfCq2F/pSetQdFWbh6tEOseCv/cjAYfY3pnLo7y5/lWJm
         1PiN5UGdAvY6CtT5ufUKcRzmif3VDU92qRay8b7d9aw/FDj7TncIZaWMiqOc/AAKQ1A8
         8Jb7Wh3JA4jowbNVrQ7lrEf3gC2CO4qjQ5PJepyXO6G1zaQxFzUCDEMSEwH9tXyC+vux
         4mO0obfH7cNCUVOqMVDDDQ9EoaK8MRAoBObskQCyUgAVWQlAm+3gFosgnQRKcE9vAQGx
         c6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181117; x=1692785917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/clY/dRW1xIHeRIxZxe1CCICvaVCPAzy02zhvzR3a8=;
        b=W9WgzKmJRBXS55MjCjtn6Q0fsZQoYXACd45OL0ypCHpoBxaFm88V/0jUYwHpr1p4Sl
         MtBaxSfm4AsO/Nx02epKisPg5A83DTTLMG2bNUDat3+LXIEZLiabvZfPISYz0lDgJGTS
         rocPyFqeF5u7By8Etl0BXarFNV1F/ZoeqHEqKFRBG1gFIAssEwf/xrjFxu3MLg4WpfOa
         3MSa3UBJJV9VSgfLd043UMoqwyGYkyCuZHDyviSygzJgdB8uUEcrHv8Kwmqjh8Cyp7Zy
         oPprBNWUXeFggPfyiyphfWOgTvrQ6fo8uNzvS00riGxpsKvyqRhL5EsLtCyXPhi4zvi5
         e8qQ==
X-Gm-Message-State: AOJu0Yz0B81Ez7mIK4kEF9gzPW5u1Q1yeBvcCxLLESoyb5fzEUxsZrpH
        5jKWqCk6XLEyd+Vd8WLX39KAmHC8a1b5J506Drg=
X-Google-Smtp-Source: AGHT+IGSAcO4vvHBg5CZaQLs9ZmCtlKhhEMI+nYCq411MHuYciX17G3u31bOFeatoypWnqfRoF5UWA==
X-Received: by 2002:adf:fcc8:0:b0:317:71bb:7ccd with SMTP id f8-20020adffcc8000000b0031771bb7ccdmr950387wrs.52.1692181117335;
        Wed, 16 Aug 2023 03:18:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h1-20020adffd41000000b0030ae499da59sm20896988wrs.111.2023.08.16.03.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:18:37 -0700 (PDT)
Message-ID: <cecec127-5494-297f-9be0-51a76ce9f149@linaro.org>
Date:   Wed, 16 Aug 2023 12:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: broadcom: sr-thermal: removed call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     hayashi.kunihiko@socionext.com, bchihi@baylibre.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        alex@shruggie.ro
References: <20230810111330.3248-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230810111330.3248-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 13:13, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

