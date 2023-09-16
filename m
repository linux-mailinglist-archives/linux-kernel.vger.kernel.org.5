Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1FB7A2E03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbjIPFAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjIPFAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:00:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1041BE3;
        Fri, 15 Sep 2023 22:00:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D3C5B5C01EC;
        Sat, 16 Sep 2023 01:00:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 16 Sep 2023 01:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1694840401; x=1694926801; bh=AiiRLsWmSd5omTSsVWE7/nPP8xSFayX8bsX
        WXu59V40=; b=Kqw/d/2w3S28QiXRFwkxvePDrM8dFhz74RMTQQJakHkL8DctgJ8
        MbJivKPiMXpIntW2cRIZmdLHwIHzrwyU7pBbxsUOzZmNZCp3gMUOS/SlvXHVgq1d
        po6bsMlGMANNr6c5OOTivp2hQCOJK1NZlVHyUyXzkpgonPH87kvxHeCkEDpOK2Cp
        qWaDbCUojHmtbQQeexcMlMHmA/YhrbWhyvGc+o00OpEzzH5hTrRMeG8HrAqebiXT
        3xXxvB1lp9/1x/xxInYe/DfRdsxVmCpHkY/xAaGhPSTmT2M45lor8uEx92QzAZb9
        kMnC3bo/CkNvKeHUJ/E1rkplLGHx6IS5Miw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694840401; x=1694926801; bh=AiiRLsWmSd5omTSsVWE7/nPP8xSFayX8bsX
        WXu59V40=; b=oQNWFgitw5weXS+KA0QECq8DgO+ECRW0F//RIDseWzy3uqP/PEv
        gLmIyQ/T/0y371VAET/dY3LjoJmRaFiAK8lJhzYyeCIKCdTGpJmBOf0Xf0HGZTFx
        fYM0h/lzhi9ZbH3E1yrVDm/ZxxpAGAcKdWxewpmr3G7bz759oWhj1BdmeRvWfdCV
        iy/zwKMpfc8XwIw1AlPv7tZyUcKoqCHtuTcKlJfvooiJiPzML5Dy6ae5sos6igDd
        MzxwViTTBew0hv18+PxHTJkGxkuZLT3pXDLqKOlSke881D3dbewfrkNw2iHlGvVJ
        NDpNAwaTDz8Az0X0ZONzwSpfiH/jz+pjCeA==
X-ME-Sender: <xms:UTYFZczVCVNsIIaRQZ7gYqFsCbmY4MI4bddOIPcgUeAdPABqSm_yMQ>
    <xme:UTYFZQRsS3n6ALnljNFzyQGDQQP8wo8DswbXMcFjWQXId6BhceQxhhVvaVqjQbjOT
    VR1TCxTsH7HPCXl5w>
X-ME-Received: <xmr:UTYFZeXtOGuiCwzI3B8nHWyR8f3E6_qRobN0VSQ4we5uiMFVvqyxHPX-Zd544Rnfr1EOTerSTygT499P_pQPAkSnzN8NLq2plOSaOh2cxvU2Bwpls-H3TODGPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefgtdfgleffkeevledvueetteefgfellefhjeetieeuhfehteeu
    feefgfehfeevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:UTYFZah0-PaqvA4nj4ZY_O8HMUeG1W7ePMRBi4K3cZF_uFXWtszXgw>
    <xmx:UTYFZeBfvNdBgb9TfUIUiBVKpOnla51SXXfp63mDEpQe26BG0epXcQ>
    <xmx:UTYFZbKuvjzgZBANrb4FC7uXKki538ESCh5PH_LMc9bS2R7beDmIhQ>
    <xmx:UTYFZUSz3iE_RY_bA7j4H0TUn4gupbpOGnduN4TX_TTs_zrl3SIIDA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Sep 2023 01:00:00 -0400 (EDT)
Message-ID: <367a8ee4-2047-879d-22ae-a0082a04f92f@sholland.org>
Date:   Fri, 15 Sep 2023 23:59:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain
 dependency
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
 <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 15:48, Saravana Kannan wrote:
> On Tue, Sep 12, 2023 at 11:58 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
>>> On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>
>>>> Top posting to bring Saravana Kannan into this discussion.
>>>>
>>>> This looks like a big hack to me, Saravana has been working
>>>> tirelessly to make the device tree probe order "sort itself out"
>>>> and I am pretty sure this issue needs to be fixed at the DT
>>>> core level and not in a driver.
>>>
>>> We could merge all the IO domain stuff into the pinctrl node/driver,
>>> like is done for Allwinner? Maybe that would simplify things a bit?
>>
>> I thought about this as well. On Rockchip the pinctrl driver and the IO
>> domain driver even work on the same register space, so putting these
>> into a single node/driver would even feel more natural than what we have
>> now.
> 
> Then we should try to do this and fix any issues blocking us.
> 
>> However, with that the pinctrl node would get the supplies that the IO
>> domain node now has and we would never get into the probe of the pinctrl
>> driver due to the circular dependencies.
> 
> From a fw_devlink perspective, the circular dependency shouldn't be a
> problem. It's smart enough to recognize all cycle possibilities (since
> 6.3) and not enforce ordering between nodes in a cycle.
> 
> So, this is really only a matter of pinctrl not trying to do
> regulator_get() in its probe function. You need to do the
> regulator_get() when the pins that depend on the io-domain are
> requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?
> 
> Is there something that prevents us from doing that?

Calling regulator_get() from the pin request function does not solve the
problem on its own. We already do that in the Allwinner driver (in
sunxi_pmx_request()), and we still have the circular dependency:

  __driver_probe_device(I2C/RSB controller)
    pinctrl_bind_pins(I2C/RSB controller)
      pinctrl_select_state(I2C/RSB controller default pins)
        pinmux_enable_setting()
          pin_request()
            sunxi_pmx_request()
              regulator_get(vcc-pl)
                [depends on the PMIC/regulator driver]
                  [depends on the I2C/RSB controller driver]

To break the cycle, you need to defer the regulator_get() call during
this specific call to the pin request function, then come back later and
call regulator_get() once the regulator is actually registered.

If we have a DT property somewhere that provides an initial voltage for
the I/O domain, then regulator_get() returning -EPROBE_DEFER would not
be an error. Instead, we would configure the I/O domain based on the DT
property, and add the pair (IO domain, regulator OF node) to a list.
Then register a notifier for new regulator class devices. Check each new
 device's OF node against the list; if it is found, hook up the voltage
notifier and remove the list entry. When the list is empty, remove the
regulator class notifier.

I thought about (ab)using the pinctrl "init" state so pin_request() gets
called a second time inside pinctrl_init_done() after the PMIC's bus
controller gets probed, but that would rely on the regulator getting
registered synchronously by some recursive call inside the bus
controller probe function. So it would break if probing the
PMIC/regulator driver got deferred for any reason.

So the suggestion from my perspective ends up being the same as what
Robin just suggested elsewhere in the thread. :)

Regards,
Samuel

