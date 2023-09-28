Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E67B26BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjI1UmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:42:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DDC180;
        Thu, 28 Sep 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=uohcHr7u7pMqM2o2/Gx8STvthCVsA+nnKExQdSb2SQA=; b=Jbd1Wr9A2d72D1He73iGyRdglY
        w5qbirxdbvXC5fM+xibzmTrblxHY9GH6BEP/AaDrvPFqlJr/I7+lMN9+NZOdkKCjBurK7wnAxV264
        0uZk1B1QndRMTADHIwU8Su/zr6Q6VtfXPYH1nj4/H8f3QFvUcsaSf6T54JXe+joFOrYPfZJDW75cO
        lF785VE2gWN9EeaAs4LAtN7IEmYXUwqHdwa6ONXrDQYYjG2eAdXMBZ6UHyiCT8giKJAwDAFeh9axT
        Hg2snf7rnfZPgVemOW5W8nIDsVCmcSAxIVTA9hhsv4fMCoAG3CSYE97tPPCbBsZs+zNLXMAR7wybj
        rxT61bvg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlxpi-006eoe-19;
        Thu, 28 Sep 2023 20:42:02 +0000
Message-ID: <830fb2f0-7965-4156-82e4-5328df0c612c@infradead.org>
Date:   Thu, 28 Sep 2023 13:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] Documentation: dpll: wrap
 DPLL_CMD_PIN_GET output in a code block
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
References: <20230928052708.44820-1-bagasdotme@gmail.com>
 <20230928052708.44820-3-bagasdotme@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230928052708.44820-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 22:27, Bagas Sanjaya wrote:
> DPLL_CMD_PIN_GET netlink command output for mux-type pins looks ugly
> with normal paragraph formatting. Format it as a code block instead.
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/dpll.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index 01eb4de867036f..69670deb8c4e09 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -119,19 +119,19 @@ with.
>  If a pin was registered with multiple parent pins, they behave like a
>  multiple output multiplexer. In this case output of a
>  ``DPLL_CMD_PIN_GET`` would contain multiple pin-parent nested
> -attributes with current state related to each parent, like:
> +attributes with current state related to each parent, like::
>  
> -'pin': [{{
> -  'clock-id': 282574471561216,
> -  'module-name': 'ice',
> -  'capabilities': 4,
> -  'id': 13,
> -  'parent-pin': [
> -  {'parent-id': 2, 'state': 'connected'},
> -  {'parent-id': 3, 'state': 'disconnected'}
> -  ],
> -  'type': 'synce-eth-port'
> -  }}]
> +        'pin': [{{
> +          'clock-id': 282574471561216,
> +          'module-name': 'ice',
> +          'capabilities': 4,
> +          'id': 13,
> +          'parent-pin': [
> +          {'parent-id': 2, 'state': 'connected'},
> +          {'parent-id': 3, 'state': 'disconnected'}
> +          ],
> +          'type': 'synce-eth-port'
> +          }}]
>  
>  Only one child pin can provide its signal to the parent MUX-type pin at
>  a time, the selection is done by requesting change of a child pin state

-- 
~Randy
