Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93041811529
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjLMOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjLMOqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:46:08 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599631BFE;
        Wed, 13 Dec 2023 06:45:32 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 25BDF3C0063;
        Wed, 13 Dec 2023 14:45:27 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.113.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5A6FA13C2B0;
        Wed, 13 Dec 2023 06:45:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5A6FA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1702478724;
        bh=CyzNsGLkg4WlGdYLD0CORyHCimqERrevF4Jayf7AZrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FtctL3XfK12CbRTl5KHhn9cT9j3FXr5yCvhS9Xeakwq9IcOq7UGhZok9Zp5wfhEBH
         /iRLEzUwz012MLtiuCU3BMuCtLx75xTl22OG5aq3TxxGAvt3BOSitdlbPoGODFuQwW
         YVntLFUGLNlf+XLJAtZ7c8uNqHUPgHSp8a9lhY3Y=
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org> <ZXmxD1foASMaCDIe@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d92c081e-47dd-5c57-a6f1-bd72b2748141@candelatech.com>
Date:   Wed, 13 Dec 2023 06:45:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZXmxD1foASMaCDIe@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1702478729-Q2nO4rVjVD1u
X-MDID-O: us5;at1;1702478729;Q2nO4rVjVD1u;<greearb@candelatech.com>;0636e1de1030682809d49efeedd0cda8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 5:26 AM, Lorenzo Bianconi wrote:
>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>
>>> Several users have reported awful latency when powersaving is enabled
>>> with certain access point combinations.
>>
>> What APs are these exactly? In the past 802.11 Power Save Mode was
>> challenging due to badly behaving APs. But nowadays with so many mobile
>> devices in the market I would assume that APs work a lot better. It
>> would be best to investigate the issues in detail and try to fix them in
>> mt76, assuming the bugs are in mt76 driver or firmware.
>>
>>> It's also reported that the powersaving feature doesn't provide an
>>> ample enough savings to justify being enabled by default with these
>>> issues.
>>
>> Any numbers or how was this concluded?
>>
>>> Introduce a module parameter that would control the power saving
>>> behavior.  Set it to default as disabled. This mirrors what some other
>>> WLAN drivers like iwlwifi do.
>>
>> We have already several ways to control 802.11 power save mode:
>>
>> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')
>>
>> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
>>
>> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default setting)
>>
>> Adding module parameters as a fourth method sounds confusing so not
>> really a fan of this. And the bar is quite high for adding new module
>> parameters anyway.
> 
> agree, I think we do not need a new parameter for this, just use the current
> APIs.

Is there a convenient way for a user to make any of those options above stick through
reboots?

To me, the ability to set system defaults through reboots is a nice feature of
module options.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
