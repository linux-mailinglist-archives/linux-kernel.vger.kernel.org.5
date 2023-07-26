Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB4764062
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGZURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGZURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D3BF;
        Wed, 26 Jul 2023 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yuiiWkOyokMmy3oNcsrkE13yvDt/eiHy47siwX5h/e0=; b=T7EqR7rCntzT+liauuhq3uFE2O
        LOCiRppR1NF9LZysSbvjZ68NsyLgO83t8nRdu34zEnOoncng+BTRA5TpxaLWeIzFSLdSfjfBPZXMC
        4f+OmJ18QaZ2KwSaEeOYkOVsIAl8GY22JUnk3qgnDPOzQ8f6gARk77jIeaX9kpGh1nmZuIqtUMv3J
        bUxsazqKuuDFGxBxuw4QpHbSbaxUWTK4dXY0lXggA0dwevcdZYRlYWpY897zo/7+Vn0q7IqAq+J0D
        KKneTZGLjQK1HonaBABw4ka6AlF0r0kwD9u4lU7K9BfRAPOITHfohHalBhVIXbrCs/KypSzN4VZVE
        AZ/TwVTA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOkwD-00BT2f-0C;
        Wed, 26 Jul 2023 20:16:49 +0000
Message-ID: <96275adc-c047-2e0c-5748-366c3e867b27@infradead.org>
Date:   Wed, 26 Jul 2023 13:16:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Content-Language: en-US
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-2-mail@carsten-spiess.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230726152235.249569-2-mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 08:22, Carsten Spieß wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7abb5710e1bb..c61aa688cd11 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11072,6 +11072,13 @@ S:	Maintained
>  F:	Documentation/filesystems/isofs.rst
>  F:	fs/isofs/
>  

New entry is not quite in the correct place for alphabetical order.
It should be just before the ISOFS entry, not just after it.

> +ISL28022 HARDWARE MONITORING DRIVER
> +M:	Carsten Spieß <mail@carsten-spiess.de>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/isl28022.rst
> +F:	drivers/hwmon/isl28022.c
> +
>  IT87 HARDWARE MONITORING DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
>  L:	linux-hwmon@vger.kernel.org

-- 
~Randy
