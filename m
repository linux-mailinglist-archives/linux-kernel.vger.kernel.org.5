Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D077632FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGZJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGZJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:58:42 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F960173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:58:14 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9923833737eso948222566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365493; x=1690970293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oufL7wWG1MerYrzFYIRjx8PPiE5kUXSb0z30EGCO7XU=;
        b=WFj45v/sSGI0B0QRZCJwcy7UTGRQe21782WPgJ5H2eEdrNl59iRQhkrmezQp7bdRJQ
         8gioBtbODXpfHQGpIhWABkD8y1TtEK9u6CO9ClFU765MUvWikBGz8IFEfRUZzcEgQz2j
         5lCXhHjIkgxGbd3kOPTfdfqTwWAboT8CRop7micT25IjFbHyiPX+BJpuflybIa+AJhNF
         XQ5bmtlb4qSmsE0gDmV7kWCg6GzzJbPd3J51xckTYHoWDwaOdN20xrcGnp9/Sorx6dZ+
         8btOotDc4tCd+TEms8O65uFcV/WO2ZIVaJaTxjeIwKIIsCEWD7nvkguHEpMUFxaybrQs
         IUiA==
X-Gm-Message-State: ABy/qLa0rIo/IWiWiMfiH3Crvdym7qCH+hQ2kFez+N3b3SWMLLUo8de+
        hTgTLyp3z/Mffw70zZ/JfKqBfEtB9v0=
X-Google-Smtp-Source: APBJJlHaR9tHoskx8FHw1Yw7KJht2mKpV1UAgfDVncj7nj01c6Z6R5FRE7R9nkH8HL4oBZn8Rp1cow==
X-Received: by 2002:a17:906:53d7:b0:99b:4ce9:c27e with SMTP id p23-20020a17090653d700b0099b4ce9c27emr1104529ejo.44.1690365492496;
        Wed, 26 Jul 2023 02:58:12 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id kf24-20020a17090776d800b00988e953a586sm714466ejc.61.2023.07.26.02.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:58:12 -0700 (PDT)
Message-ID: <4fb1c846-2439-84b4-3423-223103878413@kernel.org>
Date:   Wed, 26 Jul 2023 11:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] tty: vt: Fix spelling typo in comment
Content-Language: en-US
To:     oushixiong <oushixiong@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
References: <20230726091044.705393-1-oushixiong@kylinos.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230726091044.705393-1-oushixiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 07. 23, 11:10, oushixiong wrote:
> Signed-off-by: oushixiong <oushixiong@kylinos.cn>
> ---
>   drivers/tty/vt/vt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 1e8e57b45688..bcdd249e47a0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3473,7 +3473,7 @@ static int __init con_init(void)
>   		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   		tty_port_init(&vc->port);
>   		visual_init(vc, currcons, 1);
> -		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
> +		/* Assuming vc->vc_{cols,rows,screenbuf_size} are same here. */

NACK for many reasons, incl. this is _wrong_.

Please read SubmittingPatches first.

-- 
js

