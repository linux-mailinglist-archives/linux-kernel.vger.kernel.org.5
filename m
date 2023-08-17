Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9C77F977
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbjHQOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352172AbjHQOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:43:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099235AE;
        Thu, 17 Aug 2023 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OMiKI4jtk8FwBYZzbzFjDcviyDfvdzucEUBtGpJRLB4=; b=qAMyom96AiG8ofa8Ebw1mhwCqm
        P17CRDTepnjeUt7spFbn10pkXOniSXLiu9Tq8RjiswKShLCZWbV6bNaGxTvq00C1GHe/EuTrv2lSk
        NLwdyx4ERt/hpp/wwtwLck4NSMfhJ2hET2l9dCs3HQxo5heE2rPYYFN2oL9IastoAvDHpdu+AfysD
        Dnxol59HyWKE+QwvQMSSahpBfWp4JWZtecml7C1jE6DM+k75YOeev6+l2aDo9zQ+mHqjgBcaxU9g3
        Lr/SNkUfOxJyC3FbayP0P8DDiYhvXLR82Hzggv9LaT5e49x6s2YtZSndI37QKmYtRSwnp6to1Ax5a
        Ip+u00FQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWeCO-006ZJL-0T;
        Thu, 17 Aug 2023 14:42:08 +0000
Message-ID: <a04507b2-f732-65cb-d69a-9da0400d3a4d@infradead.org>
Date:   Thu, 17 Aug 2023 07:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] hid-mcp2200: added driver for GPIOs of MCP2200
Content-Language: en-US
To:     johannes@gnu-linux.rocks, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, andi.shyti@kernel.org,
        christophe.jaillet@wanadoo.fr, ak@it-klinger.de
References: <20230817091505.213318-1-johannes@gnu-linux.rocks>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230817091505.213318-1-johannes@gnu-linux.rocks>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/17/23 02:15, johannes@gnu-linux.rocks wrote:
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e11c1c803676..791cc5c8fa0d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1301,6 +1301,16 @@ config HID_MCP2221
>  	To compile this driver as a module, choose M here: the module
>  	will be called hid-mcp2221.ko.
>  
> +config HID_MCP2200
> +   tristate "Microchip MCP2200 HID USB-to-GPIO bridge"
> +   depends on USB_HID
> +   imply GPIOLIB
> +   help
> +   Provides GPIO functionality over USB-HID through MCP2200 device.
> +
> +   To compile this driver as a module, choose M here: the module
> +   will be called hid-mcp2200.ko.
> +

Please follow coding-style.rst for Kconfig files, copied here with
an example:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.  Example::

  config AUDIT
	bool "Auditing support"
	depends on NET
	help
	  Enable auditing infrastructure that can be used with another
	  kernel subsystem, such as SELinux (which requires this for
	  logging of avc messages output).  Does not do system-call
	  auditing without CONFIG_AUDITSYSCALL.


>  config HID_KUNIT_TEST
>  	tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
>  	depends on KUNIT

thanks.
-- 
~Randy
