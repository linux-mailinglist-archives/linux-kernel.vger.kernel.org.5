Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708B75AA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGTJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:26:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FE0C066;
        Thu, 20 Jul 2023 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689844290; x=1721380290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SsEtYYmV/1eLHlybJHI/seABvXep05IVE2Gm/J96eWU=;
  b=CdfLuukalyTBaQIOJbg2hem06IVVCVKaI9t1Ijg34uR4EE7vNcypIY45
   kN6O7fdGL5Ox7QX0RkVlKbJ63L7uWJCIFE76lUSZ8yCe/eO8yZBtzaSfX
   FTwZC1o5c4m+6GvxoScHs1dt7LAMGOLCIl8l6EDp5BuABjRvUkEF/h/RB
   d1MgYtL4MWpLoP+L+Wh9XDPgK+UZVB820imrPwyp5we+a09I0EfuuNmSz
   PaProaci0/W9/Bqzi1tTRT6tx9lhDOGulSRAk+xOXk1blNmRej5xYsCkS
   cCrdBT6T5GcBkm210w1qnARKC7mjX3uWKXFDe+9mdwxnsYSLBKw9/m5sD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369334596"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="369334596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898216732"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898216732"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:11:26 -0700
Message-ID: <827f7e97-369d-5f1a-44bb-49a76981f801@intel.com>
Date:   Thu, 20 Jul 2023 12:11:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: core: Remove FW revision from CID check
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
 <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
 <CA+Da2qxOhK7Uc8_ONVgkR=3pTnTo7KgcJi-yS3Cv730+J0pAxA@mail.gmail.com>
 <ff06bd46-bf43-d2dc-751f-47f41ccc1821@intel.com>
 <CA+Da2qx+mQ1N-7OnQh0ed6_diXgTadKMzJ+9rkqVZv0rhXYTFQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qx+mQ1N-7OnQh0ed6_diXgTadKMzJ+9rkqVZv0rhXYTFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/23 11:38, Wenchao Chen wrote:
> On Thu, Jul 20, 2023 at 2:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 19/07/23 05:46, Wenchao Chen wrote:
>>> On Tue, Jul 18, 2023 at 2:13 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 18/07/23 04:15, Wenchao Chen wrote:
>>>>> When the card is reset, mmc_card_init() will check if this
>>>>> card is the previous card by comparing the CID.
>>>>>
>>>>> If the firmware is upgraded, the product version may change,
>>>>> so we remove the product version from the CID check.
>>>>
>>>> What is the use-case for this?  I would have thought it is safer
>>>> not to assume anything about the card after the firmware has been
>>>> upgraded.
>>>>
>>> Hi adrian
>>>     Understood, but we have case:
>>>     1.Before the firmware upgrade
>>>         [T5745@C0] mmc0 oldcard raw->cid[2]: 32691160, raw->cid[3]: d9241800
>>>         PRV=69
>>>     2.After the firmware upgrade
>>>         [T5745@C0] mmc0 cid[2]: 32011160 cid[3]: d9241800
>>>         PRV=01
>>>     If the PRV is not excluded in the CID check, then the mmc
>>> initialization will fail after the mmc reset.
>>>     In addition, CRC is excluded because some controllers support
>>> SDHCI_QUIRK2_RSP_136_HAS_CRC.
>>
>> I do not know what others are doing in this regard, nor what
>> circumstances are leading to the re-initialization.
>>
> There is a way: reboot the machine, but we don't want to do that.
> 
> When the firmware is upgraded, we need to complete the firmware
> update by reset card, and the card will be initialized by mmc_init_card
> after mmc reset.
> 
>> Presumably a clean re-initialization could be done by
>> unbinding and rebinding the host controller.
>>
> Could you tell me how to do that?
> Thanks.

It depends on the name of the device and where the host
controller driver is in sysfs, but here is an example for
sdhci-pci with eMMC:

# ls /sys/bus/pci/drivers/sdhci-pci/
0000:00:1a.0/  new_id         uevent
bind           remove_id      unbind
# echo "0000:00:1a.0" > /sys/bus/pci/drivers/sdhci-pci/unbind 
[  484.853761] mmc0: card 0001 removed

# echo "0000:00:1a.0" > /sys/bus/pci/drivers/sdhci-pci/bind 
[  490.621524] sdhci-pci 0000:00:1a.0: SDHCI controller found [8086:4b47] (rev 11)
[  490.638520] mmc0: CQHCI version 5.10
[  490.643630] mmc0: SDHCI controller on PCI [0000:00:1a.0] using ADMA 64-bit
[  490.651837] sdhci-pci 0000:00:1a.1: SDHCI controller found [8086:4b48] (rev 11)
[  490.780139] mmc0: Command Queue Engine enabled
[  490.785132] mmc0: new HS400 MMC card at address 0001
[  490.791171] mmcblk0: mmc0:0001 S0J57X 29.6 GiB 
[  490.796320] mmcblk0boot0: mmc0:0001 S0J57X partition 1 31.5 MiB
[  490.803121] mmcblk0boot1: mmc0:0001 S0J57X partition 2 31.5 MiB
[  490.809918] mmcblk0rpmb: mmc0:0001 S0J57X partition 3 4.00 MiB, chardev (240:0)
[  490.821390] sdhci-pci 0000:00:1a.1: SDHCI controller found [8086:4b48] (rev 11)

> 
>>>
>>>>>
>>>>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>>>>> ---
>>>>>  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
>>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 89cd48fcec79..32a73378d5c3 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -32,6 +32,9 @@
>>>>>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
>>>>>  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
>>>>>
>>>>> +#define MMC_CID_PRV_MASK GENMASK(23, 16)
>>>>> +#define MMC_CID_CRC_MASK GENMASK(7, 0)
>>>>> +
>>>>>  static const unsigned int tran_exp[] = {
>>>>>       10000,          100000,         1000000,        10000000,
>>>>>       0,              0,              0,              0
>>>>> @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
>>>>> +{
>>>>> +     /*
>>>>> +      * When comparing CID, we need to remove the product
>>>>> +      * version (Field PRV, offset 55:48) and CRC. Because
>>>>> +      * the product version will change when the firmware
>>>>> +      * is upgraded. Also, the new CRC is different.
>>>>> +      */
>>>>> +     return cid[0] != raw_cid[0] || cid[1] != raw_cid[1] ||
>>>>> +             (cid[2] & ~MMC_CID_PRV_MASK) != (raw_cid[2] & ~MMC_CID_PRV_MASK) ||
>>>>> +             (cid[3] & ~MMC_CID_CRC_MASK) != (raw_cid[3] & ~MMC_CID_CRC_MASK);
>>>>> +}
>>>>> +
>>>>>  static void mmc_set_erase_size(struct mmc_card *card)
>>>>>  {
>>>>>       if (card->ext_csd.erase_group_def & 1)
>>>>> @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>>>               goto err;
>>>>>
>>>>>       if (oldcard) {
>>>>> -             if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
>>>>> +             if (mmc_check_cid(cid, oldcard->raw_cid)) {
>>>>>                       pr_debug("%s: Perhaps the card was replaced\n",
>>>>>                               mmc_hostname(host));
>>>>>                       err = -ENOENT;
>>>>
>>

