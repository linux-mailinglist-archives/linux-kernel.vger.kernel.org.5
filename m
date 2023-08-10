Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F794777136
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHJHV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHJHVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:21:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D210C;
        Thu, 10 Aug 2023 00:21:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc65360648so5844665ad.1;
        Thu, 10 Aug 2023 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691652112; x=1692256912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMXI6kTVHPxuRl+9l/keZ7XvudCxl6pTTJO/Mk4iK5I=;
        b=PMtCNdYX/cUbPbFvOJNQorAyZG8d+0gVK0ec85K7ToAj9D7wEMyo8aIYvWKdFMMRTO
         DIKdzAF5L1uMK351ZC5QV9WDr5PeZQi6/l6+9iRlZDsRZgSJOm51Bwrp6xB6DofqW+DL
         KrSVk5lME250ueWWkdLydJCjNL8wry1I1/9T0IpUYHsTo12JEpiQmYqL66gfbhChEUAw
         HO10Xq4ttk30ndwx0e6angG4MxrmtFOYe7R3BumOCJHo2o/GqMN6Vgi9xRO9fbbYAd9N
         1r+I8vTL07CAHLlBnVeS4od3XUkWqLQ6LJotTw3YqNAcw0mJEC5EQj+KEN0X6LoVTI8r
         9Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691652112; x=1692256912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMXI6kTVHPxuRl+9l/keZ7XvudCxl6pTTJO/Mk4iK5I=;
        b=EXyC4xScIVCK5yzJWSfcaYKgAm6U+Y7NrDeZCt0EMzHW1vHGdQyfNYNpNwGujt3FOS
         /7AZ/7Z8nsPsn4e4aT6ptlsgEMoanqTf4xaLnGrIMDhJHn7YZ4qI29PYGnwOa4c08+05
         kyqHvtulnA9+YxwnoQiFSX7bRu7zV9zYmkd7r3BL2GXMxp3C5QX6dNz80MmfTlO+cdhZ
         Yal9FsfLUBeZ1yT3LlCyf+GOEA4HGssKPXH64kU3X4/Rc9KwsaKJfDS1YJxbvKeBNWUV
         1aLxagrpJY1vu81yBGBBWwS/9D8sXwyLqbH0KIPiaiA3PKghHKD/vBLnb/+MZxFLQzCS
         2s5A==
X-Gm-Message-State: AOJu0Ywgs6AyI4TLtAaARGj8ELbgbvQypMDawMCWYhceXNzZol177oHT
        YRAEhblLhrhcDCBTcvFou+M=
X-Google-Smtp-Source: AGHT+IFW163EGmWvkpVnmKqAq23ut6gjOXWOT/PTXKFunpEYWbUnnsyG8OtoKetxK9h+JY8mIdRrkA==
X-Received: by 2002:a17:902:f7ce:b0:1bd:a50a:e32d with SMTP id h14-20020a170902f7ce00b001bda50ae32dmr527359plw.68.1691652112361;
        Thu, 10 Aug 2023 00:21:52 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bc445e249asm877783plg.124.2023.08.10.00.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 00:21:51 -0700 (PDT)
Message-ID: <347cf148-bda8-852b-768c-fa2b57ce5bcb@gmail.com>
Date:   Thu, 10 Aug 2023 15:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v2 3/3] rtc: Add driver for Nuvoton ma35d1 rtc
 controller
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
 <20230809021025a7c0daec@mail.local>
 <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
 <2023080922515326db190e@mail.local>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023080922515326db190e@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 上午 06:51, Alexandre Belloni wrote:
> On 09/08/2023 16:12:54+0800, Jacky Huang wrote:
>>
>> On 2023/8/9 上午 10:10, Alexandre Belloni wrote:
>>> Hello,
>>>
>>> On 09/08/2023 01:15:42+0000, Jacky Huang wrote:
>>>> +
>>>> +struct ma35_bcd_time {
>>>> +	int bcd_sec;
>>>> +	int bcd_min;
>>>> +	int bcd_hour;
>>>> +	int bcd_mday;
>>>> +	int bcd_mon;
>>>> +	int bcd_year;
>>>> +};
>>> I don't get why this struct is useful.
>> I will remove this and modify code.
>>
>>
>>>> +
>>>> +static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
>>>> +{
>>>> +	struct ma35_rtc *rtc = (struct ma35_rtc *)data;
>>>> +	unsigned long events = 0, rtc_irq;
>>>> +
>>>> +	rtc_irq = rtc_reg_read(rtc, MA35_REG_RTC_INTSTS);
>>>> +
>>>> +	if (rtc_irq & RTC_INTSTS_ALMIF) {
>>>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_ALMIF);
>>>> +		events |= RTC_AF | RTC_IRQF;
>>>> +	}
>>>> +
>>>> +	if (rtc_irq & RTC_INTSTS_TICKIF) {
>>>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_TICKIF);
>>>> +		events |= RTC_UF | RTC_IRQF;
>>> How did you test this path?
>> We use BusyBox 'date' command to observe the time changed.
>> In addition, we wrote a simple code to test it.
>> (https://github.com/OpenNuvoton/MA35D1_Linux_Applications/tree/master/examples/rtc)
>>
> You should probably run rtctest:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/rtc/rtctest.c

Thank you for providing this information.
We will run this test before submitting the next version.

>
>>>> +	if (settm->tm_year < 100) {
>>>> +		dev_warn(dev, "The year will be between 1970-1999, right?\n");
>>> No, don't do that, properly set the rtc hardware range and let the user
>>> choose their time offset/window.
>> We will modify the code as:
>>
>> #define MA35_BASE_YEAR 2000 /* assume 20YY not 19YY */
>>
>> int year;
>>
>> year = tm->tm_year + 1900 – MA35_BASE_YEAR;
>> if (year < 0) {
>>      dev_err(dev, "invalid year: %d\n", year);
>>      return -EINVAL;
>> }
> This is not needed as the rtc core is going to check the value is in the
> range once you set it.

OK, I will drop the "if (year < 0)" check.

>>>> +	time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
>>>> +	cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
>>>> +	wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
>>> Are the registers properly latched when reading? How do you ensure that
>>> MA35_REG_RTC_TIME didn't change before reading MA35_REG_RTC_CAL ?
>> We will update the code as
>>
>> do {
>>      time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
>>      cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
>>      wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
>> } while ((time != rtc_reg_read(rtc, MA35_REG_RTC_TIME)) ||
>>           (cal != rtc_reg_read(rtc, MA35_REG_RTC_CAL)) ||
>>           (wday != = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY)) );
> Ok, so this mean your hardware doesn't do latching. I don't think it is
> necessary to check MA35_REG_RTC_WEEKDAY.

OK, I will remove the MA35_REG_RTC_WEEKDAY check.
>>
>>>> +
>>>> +	return ma35d1_rtc_bcd2bin(time, cal, wday, tm);
>>>> +}
>>>> +
>>>> +static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>> +{
>>>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>>>> +	struct ma35_bcd_time gettm;
>>>> +	u32 val;
>>>> +
>>>> +	ma35d1_rtc_bin2bcd(dev, tm, &gettm);
>>>> +
>>>> +	val = gettm.bcd_mday | gettm.bcd_mon | gettm.bcd_year;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
>>>> +
>>>> +	val = gettm.bcd_sec | gettm.bcd_min | gettm.bcd_hour;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_TIME, val);
>>>> +
>>> Same question about latching, shouldn't you stop the rtc while doing
>>> this?
>> In fact, once enabled, the RTC hardware of MA35D1 cannot be stopped; this is
>> how the hardware is designed.
>> Inside the MA35D1 RTC, there's an internal counter that advances by 128
>> counts per second.
>> When the time or date register is updated, the internal counter of the RTC
>> hardware will automatically reset to 0,
>> so there is no need to worry about memory latch issues.
> Ok, great
>
>>
>>>> +	val = tm->tm_wday;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_WEEKDAY, val);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>>> +{
>>>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>>>> +	struct ma35_bcd_time tm;
>>>> +	unsigned long val;
>>>> +
>>>> +	ma35d1_rtc_bin2bcd(dev, &alrm->time, &tm);
>>>> +
>>>> +	val = tm.bcd_mday | tm.bcd_mon | tm.bcd_year;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
>>>> +
>>>> +	val = tm.bcd_sec | tm.bcd_min | tm.bcd_hour;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
>>>> +
>>> What about handling alrm.enabled here?
>> The MA35D1 RTC hardware design does not have an alarm enable/disable bit.
>> The decision to utilize the alarm can only be made through enabling or
>> disabling the alarm interrupt.
> Exactly, you should use alrm.enabled to enable or disable the alarm
> interrupt. You can simply call ma35d1_alarm_irq_enable, many drivers are
> doing this.

OK, we will use irq enable/disable to support alrm.enabled.

>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct rtc_class_ops ma35d1_rtc_ops = {
>>>> +	.read_time = ma35d1_rtc_read_time,
>>>> +	.set_time = ma35d1_rtc_set_time,
>>>> +	.read_alarm = ma35d1_rtc_read_alarm,
>>>> +	.set_alarm = ma35d1_rtc_set_alarm,
>>>> +	.alarm_irq_enable = ma35d1_alarm_irq_enable,
>>>> +};
>>>> +
>>>> +static int ma35d1_rtc_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct ma35_rtc *rtc;
>>>> +	struct clk *clk;
>>>> +	u32 regval;
>>>> +	int err;
>>>> +
>>>> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>>>> +	if (!rtc)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
>>>> +	if (IS_ERR(rtc->rtc_reg))
>>>> +		return PTR_ERR(rtc->rtc_reg);
>>>> +
>>>> +	clk = of_clk_get(pdev->dev.of_node, 0);
>>>> +	if (IS_ERR(clk))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
>>>> +
>>>> +	err = clk_prepare_enable(clk);
>>>> +	if (err)
>>>> +		return -ENOENT;
>>>> +
>>>> +	platform_set_drvdata(pdev, rtc);
>>>> +
>>>> +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
>>>> +					       &ma35d1_rtc_ops, THIS_MODULE);
>>>> +	if (IS_ERR(rtc->rtcdev))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
>>>> +				     "failed to register rtc device\n");
>>> This MUST be done last in probe, else you open a race with userspace.
>>>
>> Yes, I will moved it to last in probe.
>>
>>
>>>> +
>>>> +	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>> I don't believe you should do this on every probe but only when this
>>> hasn't been done yet.
>>>
>>>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
>>>> +	regval |= RTC_CLKFMT_24HEN;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);
>>>> +
>>> ditto
>> I will modify them as:
>>
>> If (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACK)) {
>>      err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
>>      if (err)
>>          return err;
>>      regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
>>      regval |= RTC_CLKFMT_24HEN;
>>      rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);}
>> }
>>
>>
>>>> +	rtc->irq_num = platform_get_irq(pdev, 0);
>>>> +
>>>> +	err = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
>>>> +			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
>>>> +	if (err)
>>>> +		return dev_err_probe(&pdev->dev, err, "Failed to request rtc irq\n");
>>>> +
>>>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>>>> +	regval |= RTC_INTEN_TICKIEN;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>>>> +
>>>> +	device_init_wakeup(&pdev->dev, true);
>>>> +
>>> You must set the rtc range here.
>> I will add:
>> ma35d1_rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
>> ma35d1_rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
>>
> Perfect. Maybe you should run rtc-range to check for proper operation in
> the range:
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c

We will run this test.
Thanks for providing this information.

>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>>>> +{
>>>> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
>>>> +	u32 regval;
>>>> +
>>>> +	if (device_may_wakeup(&pdev->dev))
>>>> +		enable_irq_wake(rtc->irq_num);
>>>> +
>>>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>>>> +	regval &= ~RTC_INTEN_TICKIEN;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>>> This is not what the user is asking, don't do this. Also, how was this
>>> tested?
>> Sure, I will remove these three lines of code.
>>
>> We test it with "echo mem > /sys/power/state".
>>
> Yes, my point is that if UIE is enabled, then the user wants to be woken
> up every second. If this is not what is wanted, then UIE has to be
> disabled before going to suspend.
>
> My question is why are you enabling RTC_INTEN_TICKIEN in probe? I don't
> expect anyone to use an actual hardware tick interrupt, unless the alarm
> is broken and can't be set every second. This is why I questioned the
> RTC_UF path because I don't expect it to be taken at all.

Yes, we will remove TICKIEN from probe and modify ma35d1_alarm_irq_enable().
TICKIEN will be enabled only if UIE is enabled.

static int ma35d1_alarm_irq_enable(struct device *dev, unsigned int enabled)
{
     struct ma35d1_rtc *rtc = dev_get_drvdata(dev);

     if (enabled) {
         if (rtc->rtc->uie_rtctimer.enabled)
             rtc_reg_write(rtc, NVT_RTC_INTEN,
                       (rtc_reg_read(rtc, 
NVT_RTC_INTEN)|(RTC_INTEN_TICKIEN)));
         if (rtc->rtc->aie_timer.enabled)
             rtc_reg_write(rtc, NVT_RTC_INTEN,
                       (rtc_reg_read(rtc, 
NVT_RTC_INTEN)|(RTC_INTEN_ALMIEN)));
     } else {
         if (rtc->rtc->uie_rtctimer.enabled)
             rtc_reg_write(rtc, NVT_RTC_INTEN,
                       (rtc_reg_read(rtc, NVT_RTC_INTEN) & 
(~RTC_INTEN_TICKIEN)));
         if (rtc->rtc->aie_timer.enabled)
             rtc_reg_write(rtc, NVT_RTC_INTEN,
                       (rtc_reg_read(rtc, NVT_RTC_INTEN) & 
(~RTC_INTEN_ALMIEN)));
     }
     return 0;
}



>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ma35d1_rtc_resume(struct platform_device *pdev)
>>>> +{
>>>> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
>>>> +	u32 regval;
>>>> +
>>>> +	if (device_may_wakeup(&pdev->dev))
>>>> +		disable_irq_wake(rtc->irq_num);
>>>> +
>>>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>>>> +	regval |= RTC_INTEN_TICKIEN;
>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id ma35d1_rtc_of_match[] = {
>>>> +	{ .compatible = "nuvoton,ma35d1-rtc", },
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
>>>> +
>>>> +static struct platform_driver ma35d1_rtc_driver = {
>>>> +	.suspend    = ma35d1_rtc_suspend,
>>>> +	.resume     = ma35d1_rtc_resume,
>>>> +	.probe      = ma35d1_rtc_probe,
>>>> +	.driver		= {
>>>> +		.name	= "rtc-ma35d1",
>>>> +		.of_match_table = ma35d1_rtc_of_match,
>>>> +	},
>>>> +};
>>>> +
>>>> +module_platform_driver(ma35d1_rtc_driver);
>>>> +
>>>> +MODULE_AUTHOR("Min-Jen Chen <mjchen@nuvoton.com>");
>>>> +MODULE_DESCRIPTION("MA35D1 RTC driver");
>>>> +MODULE_LICENSE("GPL");
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> Best Regards,
>> Jacky Huang
>>

Best Regards,
Jacky Huang

