Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA076BF70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHAVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHAVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:44:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E61FFC;
        Tue,  1 Aug 2023 14:44:00 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 658938697D;
        Tue,  1 Aug 2023 23:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690926238;
        bh=+c2KmqoYIBq1SO1uRer1RdmeIEeeTNx+vtJwEYoJl6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IolQ3ahTQgDKF0qHimOzB7oyH2pzZ+yiduak00q5NkeZwnGRxkMkWl8E/ZSbE3Ry2
         on2q1nnM9XVGsRT43t7jjDEflmLGQkP/xOufDfsvw3Is3tHwDLRe9srqB6cQuBUJdM
         XGWFDsLk5d+esIPV62eQBIJXG1H0G6GBnusigpFHCZGSRiGzsrxWXW1SX54bprPnVD
         lP0okK7nkNbm/zQ3gYTTe1CWW8nkXUylMLhFatXXbn5W5EwkVs68GkkSZUaxcHCVLl
         xhh2cZc1xdaH5TQXlQDrUfpwKLqF5wPEUvrCsGyrlvtLtmS7l/PSX9D128ika8Mu88
         2N5fB5fq7luPw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Aug 2023 18:43:58 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
In-Reply-To: <20230801-selective-strife-b595804cdb27@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
 <f9ab7525f048f3ce814d89f106947c34@denx.de>
 <20230801-selective-strife-b595804cdb27@spud>
Message-ID: <deb6a4e60f37e9764d24e25b8a6d1d97@denx.de>
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

Hi Conor,

On 01/08/2023 18:28, Conor Dooley wrote:

> I never said it was chief. Please re-read the quoted text.

trivial-devices.yaml throws the following warning:

imx6q-sabrelite.dtb: camera@42: 'clock-names', 'clocks', 'gp-gpios', 
'port', 'powerdown-gpios', 'reset-gpios' do not match any of the 
regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

Would it make sense to remove ovti,ov5642 from the trivial-devices 
bindings as well as from the
following devicetrees?

arch/arm/boot/dts/nxp/imx/imx53-smd.dts
arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi

Please advise.
