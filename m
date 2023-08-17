Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569677FC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351905AbjHQQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353817AbjHQQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:28:16 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E976DE2;
        Thu, 17 Aug 2023 09:28:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:279e:0:640:5630:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 7DFF16003C;
        Thu, 17 Aug 2023 19:28:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4SkSj81DcGk0-2do1PkPv;
        Thu, 17 Aug 2023 19:28:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692289690;
        bh=56lyF/L7Pca1cRntKqS68quCI9pqvOzEkgY3GwjxTXk=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=A9eaZPoSIPP8zBFeqjUjqtgJCxpYwpou89+MWE0oEESvKXt8aLyNJIgIyGS1v7gpO
         A3h1pF7k2i7KoMjVsXf5KVt6/9rdtbBqsjQyvNJIgb+VnUJ3lbmvWheb44yehYws+W
         RpRkQ9XE47vHH7krlSLQkiFxALST/kPSxCkW+Cc0=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     megi@xff.cz
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, efectn@6tel.net,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Date:   Thu, 17 Aug 2023 19:28:01 +0300
Message-ID: <20230817162803.17990-1-efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <qqx5tay4etbepyyy7hqdp2prtw4t3m57esulruevggw2yi4xqf@63a7v5vzodhs>
References: <qqx5tay4etbepyyy7hqdp2prtw4t3m57esulruevggw2yi4xqf@63a7v5vzodhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ondřej

On 17.08.2023 18:32, Ondřej Jirman wrote:
> On Thu, Aug 17, 2023 at 05:30:04PM +0200, megi xff wrote:
>>
>> On Thu, Aug 17, 2023 at 05:57:55PM +0300, Muhammed Efe Cetin wrote:
>>>
>>> Hi, Ondřej
>>>
>>> On 17.08.2023 16:57, Ondřej Jirman wrote:
>>>> Hi Muhammed,
>>>>
>>>>>>> [...]
>>>>>>
>>>>>>> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
>>>>>>> +		compatible = "regulator-fixed";
>>>>>>> +		regulator-name = "vcc_1v1_nldo_s3";
>>>>>>> +		regulator-always-on;
>>>>>>> +		regulator-boot-on;
>>>>>>> +		regulator-min-microvolt = <1100000>;
>>>>>>> +		regulator-max-microvolt = <1100000>;
>>>>>>> +		vin-supply = <&vcc5v0_sys>;
>>>>>>> +	};
>>>>>>
>>>>>> There's no such regulator on the board.
>>>>>
>>>>> It's connected to PMIC https://i.imgur.com/sVJdC5K.png
>>>>
>>>> It's not a separate fixed regulator. It's a PMIC output from buck6 https://megous.com/dl/tmp/8630fa17407c75b9.png
>>>>
>>>
>>> I think it should be fixed regulator. It's used as vcc13-supply and
>>> vcc14-supply regulator on PMIC and it's same as other rk3588 boards.
>>
>> Yes, BUCK6 output is input to some LDOs. If you make this a regulator-fixed,
>> BUCK6 will not get enabled when those LDOs are enabled, and the LDOs will not
>> work because they'll lack input power.
>>
>> Your regulator-fixed does nothing to enable BUCK6 which is where vcc_1v1_nldo_s3
>> power rail is connected.
>>
>> It only works for you now, because dcdc-reg6 is marked as regulator-always-on,
>> so it's already enabled when you need those dependent LDOs.
> 
> And if other boards have this same HW setup and user separate DT node with
> regulator-fixed for this, they're broken, too.

As i've seen on upstream and Rockchip SDK; boards have dual RK806, have vcc_1v1_nldo_s3 node inside of pmic (rk3588-evb1-v10) and boards have single RK806, have separated vcc_1v1_nldo_s3 node. I don't know why they preferred this way.

> 
> regards,
> 	o.
> 
>> regards,
>> 	o.
>>
>>>> So this is VDD2_DDR_S3. If you want to keep the alias, just add extra alias to
>>>> dcdc-reg6 like this:
>>>>
>>>> 		...
>>>> 	vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
>>>> 		...
>>>>
>>>>>>

Regards,
Efe
