Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41280CA24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjLKMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:47:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC93B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:47:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DCAC433C9;
        Mon, 11 Dec 2023 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702298853;
        bh=h93HF6RRAegCLvVse8r0eU7pTOKa/Pg1hLeWvROiAYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mdcVWn5+HL6So0byxHJ3o2z96cnxvv0vvapgsXh1/CScYp9DsNQQTlHzphF0K/So0
         NG2hXpNjBssHSXtJ/OuC34LBQBB9+cP5WJ7IXYaWhnYPK6rc3xSpokQoOvrG3xkmwc
         QmJBdpzEuFKXUr0kyoFwz+lue86zfD8PsUsbMeR8HJ2x6IXO3Iis+NgWa9iXj1sHYg
         9SlBHnd6BetpWFrM7YIDGrSEmC1YY6HlrvRAMG5WCz2y5iVqw8MYFjxsjcUcSgHmR1
         /bK3vKzKq7drl4Qd/eqqww6ACG2DZgFVT2yT0FBIXMFcm0c22Kd9IqbNAtFfaA8OA1
         Op+f1epjAKB4w==
Message-ID: <1274b111-09f7-4d90-ae4d-cf7865fa8550@kernel.org>
Date:   Mon, 11 Dec 2023 14:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: phy: cadence-torrent: Add a separate
 compatible for TI J7200
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, s-vadapalli@ti.com
References: <20230724150002.5645-1-sjakhade@cadence.com>
 <20230724150002.5645-5-sjakhade@cadence.com>
 <20230724-shampoo-junior-f9e0bb095668@spud>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230724-shampoo-junior-f9e0bb095668@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2023 20:56, Conor Dooley wrote:
> On Mon, Jul 24, 2023 at 05:00:01PM +0200, Swapnil Jakhade wrote:
>> TI J7200 uses Torrent SD0805 version which is a special version
>> derived from SD0801 that has an additional input reference clock.
>> Add a separate compatible for TI J7200 platforms.
>>
>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>> ---
>>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> index ddb86ee0cebf..e3a1efd61033 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> @@ -20,6 +20,7 @@ properties:
>>    compatible:
>>      enum:
>>        - cdns,torrent-phy
>> +      - ti,j7200-serdes-10g
>>        - ti,j721e-serdes-10g
> 
> Should the number of clocks not be restricted dynamically based on the
> compatible, since only the 7200 requires the extra refclk?
> 

Yes, this is a good idea.

-- 
cheers,
-roger
