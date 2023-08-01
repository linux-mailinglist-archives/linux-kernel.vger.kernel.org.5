Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011FD76BF16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHAVSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjHAVSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:18:32 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E6FF;
        Tue,  1 Aug 2023 14:18:30 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 150AE86B4C;
        Tue,  1 Aug 2023 23:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690924709;
        bh=M3Z6x7CHpVM/a8WXXradH0+WQby6irQwE6MdTeYOtns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTAjp/N7IOZw7ZYeszNejk47xtv41tkYz7ZCff0nhatH6K/bJG1uWcSygF5kDXiiH
         9Iw3BMVoB9CPHtfN/2iudDF6mCy06Kb8YSZzchOc4ikHm5Y+XWl8zs9X6UetidwLST
         DdkLJ7DsQgB/Ne4QeMyk6A3OZrY9itWBOZjWBtExk5V8xeFpPfB8BcVzfYhI2noV/N
         yyBNRxoUujNJSDGDpSTC9tHaJjnaSc2NwJwg8J6ulFT7rF1HJSiuMeb10FATfuYykp
         fybkcaRVdtv0SpvLXl8yxHKWaCuIthNPZRqs0TNxcaI7I94bDCibi0P4pYVPnOvOxB
         uW2jVCh3PpW/A==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Aug 2023 18:18:29 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
In-Reply-To: <20230801-dividers-chooser-bd0df9b72d91@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
Message-ID: <f9ab7525f048f3ce814d89f106947c34@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 18:13, Conor Dooley wrote:
> On Tue, Aug 01, 2023 at 06:10:52PM -0300, Fabio Estevam wrote:
>> On 01/08/2023 17:47, Conor Dooley wrote:
>> 
>> > Removing it without re-adding it elsewhere does not seem right, since
>> > there'll now be some undocumented compatibles in the tree, no?
>> 
>> Currently, there is no ov5642 support in the kernel.
> 
> It is present in devicetrees.

Yes, and none of them have the ov5642 camera functional:

arch/arm/boot/dts/nxp/imx/imx53-smd.dts
arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi

>> If someone adds the support for the ov5642 camera, then a specific 
>> binding
>> will have to be created.
>> 
>> I prefer to remove it from trivial-devices to avoid confusion.
>> 
>> As is, it gives a false impression that ov5642 is supported and that 
>> it
>> is a trivial device.
> 
> The latter only do I agree with.

Care to explain how ov5642 is supported by the current mainline kernel?
