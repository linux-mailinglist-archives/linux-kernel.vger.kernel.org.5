Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675107745DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHHSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjHHSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:46:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1918851
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:53:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55bac17b442so4347607a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691513600; x=1692118400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=5kLaOvMqnlNmeIpacSpIa2NWJbpOYlZESfjtUwCQv19yf4oL/5SP94VAl/CfSyHNHk
         usbySMXbEwrMgGSjrZ54UkTiy5yKiPN4M5HyKMMaHqoHVLt+VNOmKL3nKJV6G7hcitJk
         s2mEQX3UUmdUqs2xGt2JF1xxkNyNcOc5G3NZMaHcKrX1893BWny0ypKIGd9EMCRuboJu
         Rjm48FDrn9Saxwnv/Z0UCwaTntJbmiIqplHAlnXthvd8+EjVbuEmJaYz1eJUO5vCyCSl
         zvvX1a5EFKF3y1I5mWdE8rJPpU7tOly/LzuegSXd2aaVJvCm18ktBWQI0KLql9kiehW9
         rq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513600; x=1692118400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=kMHUcXWLP58e3NCyfwkXMz5Z45SgRjkcV91pW/UJVD2w44FnNkXG6cvWu9JtbwDN/5
         chIcqd6/F9tglnGhutyJ64kKtWXtbMhGg1I7rNfQpVILSA31W5DZQMQquqLAlPvpiXs3
         Kmre27RP+9++gHx1pTGIzbiMC+Pj4NCUa30B382MovFWMrszRONRlZ4KpXbVAQSxR0YB
         +PWs+taYvIz5LvfD6CjaFBlJwMfgYmXNDJw1gw0AydHxc3etiJTlNzUwYnv5qgQd4XV2
         d6i2e2VKxXEOb+rhpN2sYbbWgqaqx1VyOh8vO/Nz2eDeupZvlBrd6gr83xywX5/BRxqi
         XbWQ==
X-Gm-Message-State: AOJu0Yx3hSFnz2rQruhN7SCVC/tklI3jU2A/XLBV3VrHbqJRFV9cwY6u
        kxR8ebZL1/37POgP79Y8TH3VLcdPCb/JoIx6fE0=
X-Google-Smtp-Source: AGHT+IFAVyiXcimI9tXWuEj4R9mV4WwBOWaAXHFFMihxNpDn6eurFOXPD6dXxTtApytWiEcQwiKdmw==
X-Received: by 2002:a17:902:e546:b0:1b8:a697:3719 with SMTP id n6-20020a170902e54600b001b8a6973719mr14036571plf.25.1691481003938;
        Tue, 08 Aug 2023 00:50:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001bba7aab822sm8261067plh.5.2023.08.08.00.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:50:03 -0700 (PDT)
Message-ID: <bbf345f8-3476-4b0f-ab79-0cab3db73472@daynix.com>
Date:   Tue, 8 Aug 2023 16:50:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not
 detecting Line Out
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20230805162216.441410-1-alpernebiyasak@gmail.com>
Content-Language: en-US
In-Reply-To: <20230805162216.441410-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/06 1:22, Alper Nebi Yasak wrote:
> The RT5682, RT1015 and RT1015p codecs used in this driver do not seem
> capable of distinguishing Line Out connections from Headphone, but
> the driver configures its jack object as if it can. Remove the wrong
> value from the jack creation call to avoid any confusion.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
