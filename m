Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A6778F66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjHKM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjHKM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:26:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC17E60
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:26:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so267059066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756786; x=1692361586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vdqh1j8JAPz1LHpKjBs3uau5+KzBYyjfVagjd0AiC08=;
        b=Jb5d4JzU3Bje7gwpSWTBCXmII/hBWWugU7WqAnUy6nxiyHgx7mmq8YKZz6Wbm6BDum
         bVZEwk0pBHpALi4YY+bUZmavQ/pFkWD5LGnx540gPTt7pYCdAEIt31qjV5Xp/qJlsQE0
         cL33RuVWGCUtCRPJKBVpGZwocssh78Vj1fKFYqnO+IsDZ2EXMGIo6d8s1IEDs9IKPBhF
         qhCKHO5+MNeq3EDbN3y0UBsXr63KaIDWItKvdguKrX6lk0gyhpOislnob7LhsNGIIw/O
         tnyMgleW27OGDrPoMJEWKznqF7xGWbMiFJbWBFbxVs9tfGJW/8ej3DbVSUHseVgX5jxu
         diGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756786; x=1692361586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdqh1j8JAPz1LHpKjBs3uau5+KzBYyjfVagjd0AiC08=;
        b=JJpAlzvnwwE2k5j2njSdUqTmDWiiebjyCCb3q96DvI8M/OZuzJwr+zOcidW8+hrrdG
         0MJl8Re02I5jFyAu8UaFdfpuedz0rChvihFzy6NyQPQG1aXAyVWkCHLZODPv2wV1LMYf
         LPymd6TjQHoJLHs1S5/DVyMTfIa3EsDqrOdFCk/d3o0oKkenA1TXJP6uMbPYb37PMJqB
         o5EaEngYc1wpgAvPMLp7xUyKAsULc//trNH07R4X1k7mnaZKRLfbw3fftFTfJ2IFXtTQ
         x62S5DMv0EGKmP0199CW3gbf3URd69vfoNs0EAmmFzpUzBnwsUzLAacqeAy++VpTdQ+m
         /pFg==
X-Gm-Message-State: AOJu0YytNRJeZGOE2El+dzveCaLxr457wmaonf6smnrcaY0dsqEGnbMB
        jd/cHixKYzwz5Shxly7OZRfwUA==
X-Google-Smtp-Source: AGHT+IGtRNijAA7U4wUCk2dV+46vIyOclD6tm2LEYb2r+aYDjHJ4CA34kbXIQRtRVMmyfcyleoVqyw==
X-Received: by 2002:a17:906:535d:b0:99c:a65a:c4b7 with SMTP id j29-20020a170906535d00b0099ca65ac4b7mr1525427ejo.43.1691756785813;
        Fri, 11 Aug 2023 05:26:25 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id os5-20020a170906af6500b00993a37aebc5sm2187401ejb.50.2023.08.11.05.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 05:26:25 -0700 (PDT)
Message-ID: <154883fc-a6bc-01a9-b044-dac8848e9963@linaro.org>
Date:   Fri, 11 Aug 2023 13:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-2-miquel.raynal@bootlin.com>
 <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
 <20230808092433.039e2f48@xps-13>
 <05aea50f-6692-962e-abe7-765197815f03@linaro.org>
 <20230811141122.7921df1d@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230811141122.7921df1d@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/08/2023 13:11, Miquel Raynal wrote:

>>
>>
> 
> nvmem_register() calls device_initialize() and later device_add(),
> which is exactly the content of device_register(). Upon error
> after device_add(), we currently call device_put(), whereas
> device_unregister would call both device_del() and device_put().
> 
> I would expect device_del() to be first called upon error before
> device_put() *after* device_add() has succeded, no?

That is correct afaiu, if device_add is succeed we need to call 
device_del(). As the patch now moved the device_add to end of function 
we really do not need device_del() in err path.

> 
>>> I also see the layout_np below should be freed before jumping in the
>>> error section.
>>
>> you mean missing of_node_put()?
> 
> Yes, I need to call of_node_put() before jumping into the error path.

Are we not already doing it in nvmem_layout_get() and 
nvmem_add_cells_from_fixed_layout() ?


> 
> Thanks,
> Miquèl
