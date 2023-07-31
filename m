Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A72768C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGaGjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGaGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:39:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C211BE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:39:39 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQMYs-0001Vc-CZ; Mon, 31 Jul 2023 08:39:22 +0200
Message-ID: <0be7d390-f2dc-85ea-6a54-35919bc03047@pengutronix.de>
Date:   Mon, 31 Jul 2023 08:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 2/3] dt-bindings: display: simple: support non-default
 data-mapping
Content-Language: en-US, de-DE
To:     Conor Dooley <conor@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dan Carpenter <error27@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        patchwork-jzi@pengutronix.de, David Airlie <airlied@gmail.com>,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230523-simplepanel_support_nondefault_datamapping-v4-0-e6e7011f34b5@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v4-2-e6e7011f34b5@pengutronix.de>
 <20230729-tinker-provolone-a88d55c07cad@spud>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230729-tinker-provolone-a88d55c07cad@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 7/29/23 12:19, Conor Dooley wrote:
> On Fri, Jul 28, 2023 at 04:16:56PM +0200, Johannes Zink wrote:
>> Some Displays support more than just a single default LVDS data mapping,
>> which can be used to run displays on only 3 LVDS lanes in the jeida-18
>> data-mapping mode.
>>
>> Add an optional data-mapping property to allow overriding the default
>> data mapping. As it does not generally apply to any display and bus, use
>> it selectively on the innolux,g101ice-l01, which supports changing the
>> data mapping via a strapping pin.
>>
>> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
>>
>> ---
>>
>> Changes:
>>
>> v3 -> v4: none
>>
>> v2 -> v3: - worked in Laurent's review findings (thanks for reviewing
>> 	    my work): fix typos in commit message
> 
> I gave you one for this patch too, no? > https://lore.kernel.org/all/20230523-jaywalker-modify-500ec1d79223@spud/
> Any reason in particular you didn't pick up the tags? Here it is
> against, since all that appears to have changed is some typos.

sorry, I forgot to add the Tags, There is no functional changes in patch 1-3 of 4.

Johannes

> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

