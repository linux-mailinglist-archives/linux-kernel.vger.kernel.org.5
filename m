Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0E765FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjG0Wv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG0Wvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:51:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50932126;
        Thu, 27 Jul 2023 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gxst0MV95XkxjAxP5vu3jd+SGLllfaqP4uTfI0i8aYU=; b=hTokEEYXZn8ySLNVTv4Ah4W896
        WcN2W0pLQjkOkrFkJzHC7mPxvaeG4HBjhy7vR6oFWlzVGiBawqKGErNRIFcbdWTFuxqlodgYow/SO
        6b2MxyciEmSe2H3JQvQsZHa5bfXA4o9Gw+O/oenTcZPeNDfBHYhajGazcf7tHPpgyYVnGtWPdleQL
        ZZnUHNsxR2krZZZ/IkFaNtA/YOnfdUTxevTujg3Qq+Qs4zMFGYHoyLraE1b792NsYSmEthrTcROAD
        qe+EokPkjf2lLZvDy4B4U5JX2zp4kS1+hEb3OA3icNlZO1ojFY31KFXowqJlt2SCE0WnpvtWlQ28t
        b0KyLvIQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qP9pe-000mOj-0l;
        Thu, 27 Jul 2023 22:51:42 +0000
Message-ID: <c1f6344f-1b5d-15cc-f692-b5d036d8ad20@infradead.org>
Date:   Thu, 27 Jul 2023 15:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230727163132.745099-1-leitao@debian.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727163132.745099-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 09:31, Breno Leitao wrote:
> +config NETCONSOLE_APPEND_RELEASE
> +	bool "Enable kernel release version in the message"
> +	depends on NETCONSOLE_EXTENDED_LOG
> +	default n
> +	help
> +	  Enable kernel release to be prepended to each netcons message. The
> +	  kernel version is prepended to the first message, so, the peer knows what
> +	  kernel version is send the messages.

	                 is sending
or
	                 sends

> +	  See <file:Documentation/networking/netconsole.rst> for details.

-- 
~Randy
