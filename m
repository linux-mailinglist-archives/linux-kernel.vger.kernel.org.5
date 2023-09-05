Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76F792BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjIEQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353037AbjIEGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:03:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B765B1B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:03:45 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qdPA7-0004b9-NU; Tue, 05 Sep 2023 08:03:43 +0200
Message-ID: <c552d202-4c1e-a561-aac6-1f4a257faff9@pengutronix.de>
Date:   Tue, 5 Sep 2023 08:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH AUTOSEL 6.4 18/54] thermal: core: constify params in
 thermal_zone_device_register
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, linux-pm@vger.kernel.org
References: <20230813154934.1067569-1-sashal@kernel.org>
 <20230813154934.1067569-18-sashal@kernel.org> <ZOSRPJxpVfCiyUWb@duo.ucw.cz>
 <2023082232-anaerobic-smashing-42d3@gregkh>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <2023082232-anaerobic-smashing-42d3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 13:31, Greg KH wrote:
> On Tue, Aug 22, 2023 at 12:43:08PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> [ Upstream commit 80ddce5f2dbd0e83eadc9f9d373439180d599fe5 ]
>>>
>>> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
>>> parameters structure"), thermal_zone_device_register() allocates a copy
>>> of the tzp argument and callers need not explicitly manage its lifetime.
>>>
>>> This means the function no longer cares about the parameter being
>>> mutable, so constify it.
>>>
>>> No functional change.
>>
>> Not a bugfix, should not be in stable.
>>
>> 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
>> parameters structure") is not in 6.1, so this is not correct patch for
>> 6.1.

[Sidenote: this is AUTOSEL for 6.4, where the patch is applicable, unlike 6.1]


>> Why was this selected for AUTOSEL? Can you make sure patches marked
>> "No functional change." are not selected in future?
> 
> No, because sometimes they are needed in later patches.  And marking
> things const is good :)

The patch used to have a Fixes: trailer[1], but Rafael disagreed that it
constitutes a fix. In future, I'll insist on keeping the Fixes: tag to
prevent such issues. But maybe AUTOSEL could also take lines like "Since
commit $(some commit hash not existing in the stable kernel)" into consideration.

[1]: https://lore.kernel.org/all/20230708112720.2897484-1-a.fatoum@pengutronix.de/

Cheers,
Ahmad


> 
> thanks,
> 
> greg k-h
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

