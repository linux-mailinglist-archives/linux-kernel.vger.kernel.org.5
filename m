Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074027754D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHIINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHIINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:13:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE71736;
        Wed,  9 Aug 2023 01:12:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc7e65ea44so4844985ad.1;
        Wed, 09 Aug 2023 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691568779; x=1692173579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGi+I0X98yYTQWfLVJqeABIuTLMwNChc7qAz4vbozrE=;
        b=IL9596BVQqIVfbjlbPd34w3eRFt3rh4Kv+NvcuWWW26YXruQiRqRMMUgQh1WyajqCt
         U40St3d3Dje6oVKKTO2YZnnuy4bmCzm0duvZdRES93hAe1w6N5RdZa7inChx2Zav+4DA
         OTMM+OCx87fG+PFM2osD7oOvC8yYukAp9mXpT5+/Mtr6sf4jqsCjnp/MYoKxRtCl3KjO
         Sl7NESq922ku7SfjfSa8ComEcGucHm3Awbw7fL+/pTAia5/3Quq9KP6pgOvvSq0hra/J
         veyh4m7071BR00S3Y6tQZ7U7OCGQqbQSOQUORyIhsMUmOZHe0Khzz2YRTknBsrHZ8zwY
         f5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568779; x=1692173579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGi+I0X98yYTQWfLVJqeABIuTLMwNChc7qAz4vbozrE=;
        b=NgdXuFDonuIX3vHq0W8urNySTUeCaLyfxCA+vhcAf1H3qojXt3ZB01Rb9mO6sHcBlA
         zJMLJrIOPAFrvXZ7oCejEi9fVy+KA7MHfOhmH7nZJ1LaUnfqx85FElE4mWla3d4L18tL
         OA06+OZR/kpVOfRshYEVwBBMfOcPg8X7qz5LEaKFARqUROV7unZhNYO7lA9w71ayzuTu
         UT9d4TICU237LBR3eLKHcbKgp5M2tBbSph3B/XgPLsY6oq55S9Pq+0KuUU4E6g07QjiV
         2WeumXlkPKp4i/QlBXp4UlSOL/IRhX1o+v9qQFFWXA8Cl1f/qa1T8TBYl+Bavae89BSU
         bJ8w==
X-Gm-Message-State: AOJu0YxTUe1IRXA43PqrxpGBDvZ/x4TNTa6Qy4n10ABGFszQJ3nFQvSj
        POOg4vkd2Zl5UzCYWAlxepc=
X-Google-Smtp-Source: AGHT+IFDcLD09vqfO+TJnS2tTZ6ux/nNDoNRIxEJ7PROsKAlQQyu8im4YuAi7ttOxBqcdhKLWZ6xIg==
X-Received: by 2002:a17:903:32c6:b0:1ae:6947:e63b with SMTP id i6-20020a17090332c600b001ae6947e63bmr2817181plr.16.1691568778702;
        Wed, 09 Aug 2023 01:12:58 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001bb9b87ac95sm10472777plg.103.2023.08.09.01.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:12:58 -0700 (PDT)
Message-ID: <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
Date:   Wed, 9 Aug 2023 16:12:54 +0800
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
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230809021025a7c0daec@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/9 上午 10:10, Alexandre Belloni wrote:
> Hello,
>
> On 09/08/2023 01:15:42+0000, Jacky Huang wrote:
>> +
>> +struct ma35_bcd_time {
>> +	int bcd_sec;
>> +	int bcd_min;
>> +	int bcd_hour;
>> +	int bcd_mday;
>> +	int bcd_mon;
>> +	int bcd_year;
>> +};
> I don't get why this struct is useful.

I will remove this and modify code.


>> +
>> +static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
>> +{
>> +	struct ma35_rtc *rtc = (struct ma35_rtc *)data;
>> +	unsigned long events = 0, rtc_irq;
>> +
>> +	rtc_irq = rtc_reg_read(rtc, MA35_REG_RTC_INTSTS);
>> +
>> +	if (rtc_irq & RTC_INTSTS_ALMIF) {
>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_ALMIF);
>> +		events |= RTC_AF | RTC_IRQF;
>> +	}
>> +
>> +	if (rtc_irq & RTC_INTSTS_TICKIF) {
>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_TICKIF);
>> +		events |= RTC_UF | RTC_IRQF;
> How did you test this path?

We use BusyBox 'date' command to observe the time changed.
In addition, we wrote a simple code to test it.
(https://github.com/OpenNuvoton/MA35D1_Linux_Applications/tree/master/examples/rtc)

>> +	}
>> +
>> +	rtc_update_irq(rtc->rtcdev, 1, events);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int ma35d1_rtc_init(struct ma35_rtc *rtc, u32 ms_timeout)
>> +{
>> +	const unsigned long timeout = jiffies + msecs_to_jiffies(ms_timeout);
>> +
>> +	do {
>> +		if (rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)
>> +			return 0;
>> +
>> +		rtc_reg_write(rtc, MA35_REG_RTC_INIT, RTC_INIT_MAGIC_CODE);
>> +
>> +		mdelay(1);
>> +
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int ma35d1_rtc_bcd2bin(u32 time, u32 cal, u32 wday, struct rtc_time *tm)
>> +{
>> +	tm->tm_mday	= bcd2bin(cal >> 0);
>> +	tm->tm_mon	= bcd2bin(cal >> 8);
>> +	tm->tm_mon	= tm->tm_mon - 1;
>> +	tm->tm_year	= bcd2bin(cal >> 16) + 100;
>> +
>> +	tm->tm_sec	= bcd2bin(time >> 0);
>> +	tm->tm_min	= bcd2bin(time >> 8);
>> +	tm->tm_hour	= bcd2bin(time >> 16);
>> +
>> +	tm->tm_wday = wday;
>> +
>> +	return rtc_valid_tm(tm);
>> +}
>> +
>> +static int ma35d1_rtc_alarm_bcd2bin(u32 talm, u32 calm, struct rtc_time *tm)
>> +{
>> +	tm->tm_mday	= bcd2bin(calm >> 0);
>> +	tm->tm_mon	= bcd2bin(calm >> 8);
>> +	tm->tm_mon	= tm->tm_mon - 1;
>> +	tm->tm_year	= bcd2bin(calm >> 16) + 100;
>> +
>> +	tm->tm_sec	= bcd2bin(talm >> 0);
>> +	tm->tm_min	= bcd2bin(talm >> 8);
>> +	tm->tm_hour	= bcd2bin(talm >> 16);
>> +
>> +	return rtc_valid_tm(tm);
>> +}
>> +
>> +static void ma35d1_rtc_bin2bcd(struct device *dev, struct rtc_time *settm,
>> +			       struct ma35_bcd_time *gettm)
>> +{
>> +	gettm->bcd_mday = bin2bcd(settm->tm_mday) << 0;
>> +	gettm->bcd_mon  = bin2bcd((settm->tm_mon + 1)) << 8;
>> +
>> +	if (settm->tm_year < 100) {
>> +		dev_warn(dev, "The year will be between 1970-1999, right?\n");
> No, don't do that, properly set the rtc hardware range and let the user
> choose their time offset/window.

We will modify the code as:

#define MA35_BASE_YEAR 2000 /* assume 20YY not 19YY */

int year;

year = tm->tm_year + 1900 – MA35_BASE_YEAR;
if (year < 0) {
     dev_err(dev, "invalid year: %d\n", year);
     return -EINVAL;
}


>> +		gettm->bcd_year = bin2bcd(settm->tm_year) << 16;
>> +	} else {
>> +		gettm->bcd_year = bin2bcd(settm->tm_year - 100) << 16;
>> +	}
>> +
>> +	gettm->bcd_sec  = bin2bcd(settm->tm_sec) << 0;
>> +	gettm->bcd_min  = bin2bcd(settm->tm_min) << 8;
>> +	gettm->bcd_hour = bin2bcd(settm->tm_hour) << 16;
>> +}
> Those functions are only used once, simply put them in their call site.

Sure, I will remove this function and put the code in their call site


>> +
>> +static int ma35d1_alarm_irq_enable(struct device *dev, u32 enabled)
>> +{
>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>> +	u32 reg_ien;
>> +
>> +	reg_ien = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>> +
>> +	if (enabled)
>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien | RTC_INTEN_ALMIEN);
>> +	else
>> +		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien & ~RTC_INTEN_ALMIEN);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>> +	u32 time, cal, wday;
>> +
>> +	time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
>> +	cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
>> +	wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
> Are the registers properly latched when reading? How do you ensure that
> MA35_REG_RTC_TIME didn't change before reading MA35_REG_RTC_CAL ?

We will update the code as

do {
     time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
     cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
     wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
} while ((time != rtc_reg_read(rtc, MA35_REG_RTC_TIME)) ||
          (cal != rtc_reg_read(rtc, MA35_REG_RTC_CAL)) ||
          (wday != = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY)) );


>> +
>> +	return ma35d1_rtc_bcd2bin(time, cal, wday, tm);
>> +}
>> +
>> +static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>> +	struct ma35_bcd_time gettm;
>> +	u32 val;
>> +
>> +	ma35d1_rtc_bin2bcd(dev, tm, &gettm);
>> +
>> +	val = gettm.bcd_mday | gettm.bcd_mon | gettm.bcd_year;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
>> +
>> +	val = gettm.bcd_sec | gettm.bcd_min | gettm.bcd_hour;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_TIME, val);
>> +
> Same question about latching, shouldn't you stop the rtc while doing
> this?

In fact, once enabled, the RTC hardware of MA35D1 cannot be stopped; 
this is how the hardware is designed.
Inside the MA35D1 RTC, there's an internal counter that advances by 128 
counts per second.
When the time or date register is updated, the internal counter of the 
RTC hardware will automatically reset to 0,
so there is no need to worry about memory latch issues.


>> +	val = tm->tm_wday;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_WEEKDAY, val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
>> +	struct ma35_bcd_time tm;
>> +	unsigned long val;
>> +
>> +	ma35d1_rtc_bin2bcd(dev, &alrm->time, &tm);
>> +
>> +	val = tm.bcd_mday | tm.bcd_mon | tm.bcd_year;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
>> +
>> +	val = tm.bcd_sec | tm.bcd_min | tm.bcd_hour;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
>> +
> What about handling alrm.enabled here?

The MA35D1 RTC hardware design does not have an alarm enable/disable bit.
The decision to utilize the alarm can only be made through enabling or 
disabling the alarm interrupt.

>> +	return 0;
>> +}
>> +
>> +static const struct rtc_class_ops ma35d1_rtc_ops = {
>> +	.read_time = ma35d1_rtc_read_time,
>> +	.set_time = ma35d1_rtc_set_time,
>> +	.read_alarm = ma35d1_rtc_read_alarm,
>> +	.set_alarm = ma35d1_rtc_set_alarm,
>> +	.alarm_irq_enable = ma35d1_alarm_irq_enable,
>> +};
>> +
>> +static int ma35d1_rtc_probe(struct platform_device *pdev)
>> +{
>> +	struct ma35_rtc *rtc;
>> +	struct clk *clk;
>> +	u32 regval;
>> +	int err;
>> +
>> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>> +	if (!rtc)
>> +		return -ENOMEM;
>> +
>> +	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(rtc->rtc_reg))
>> +		return PTR_ERR(rtc->rtc_reg);
>> +
>> +	clk = of_clk_get(pdev->dev.of_node, 0);
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
>> +
>> +	err = clk_prepare_enable(clk);
>> +	if (err)
>> +		return -ENOENT;
>> +
>> +	platform_set_drvdata(pdev, rtc);
>> +
>> +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
>> +					       &ma35d1_rtc_ops, THIS_MODULE);
>> +	if (IS_ERR(rtc->rtcdev))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
>> +				     "failed to register rtc device\n");
> This MUST be done last in probe, else you open a race with userspace.
>

Yes, I will moved it to last in probe.


>> +
>> +	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
>> +	if (err)
>> +		return err;
>> +
> I don't believe you should do this on every probe but only when this
> hasn't been done yet.
>
>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
>> +	regval |= RTC_CLKFMT_24HEN;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);
>> +
> ditto

I will modify them as:

If (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACK)) {
     err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
     if (err)
         return err;
     regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
     regval |= RTC_CLKFMT_24HEN;
     rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);}
}


>> +	rtc->irq_num = platform_get_irq(pdev, 0);
>> +
>> +	err = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
>> +			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
>> +	if (err)
>> +		return dev_err_probe(&pdev->dev, err, "Failed to request rtc irq\n");
>> +
>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>> +	regval |= RTC_INTEN_TICKIEN;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>> +
>> +	device_init_wakeup(&pdev->dev, true);
>> +
> You must set the rtc range here.

I will add:
ma35d1_rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
ma35d1_rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;


>> +	return 0;
>> +}
>> +
>> +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
>> +	u32 regval;
>> +
>> +	if (device_may_wakeup(&pdev->dev))
>> +		enable_irq_wake(rtc->irq_num);
>> +
>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>> +	regval &= ~RTC_INTEN_TICKIEN;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> This is not what the user is asking, don't do this. Also, how was this
> tested?

Sure, I will remove these three lines of code.

We test it with "echo mem > /sys/power/state".

>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_rtc_resume(struct platform_device *pdev)
>> +{
>> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
>> +	u32 regval;
>> +
>> +	if (device_may_wakeup(&pdev->dev))
>> +		disable_irq_wake(rtc->irq_num);
>> +
>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>> +	regval |= RTC_INTEN_TICKIEN;
>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id ma35d1_rtc_of_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-rtc", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
>> +
>> +static struct platform_driver ma35d1_rtc_driver = {
>> +	.suspend    = ma35d1_rtc_suspend,
>> +	.resume     = ma35d1_rtc_resume,
>> +	.probe      = ma35d1_rtc_probe,
>> +	.driver		= {
>> +		.name	= "rtc-ma35d1",
>> +		.of_match_table = ma35d1_rtc_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(ma35d1_rtc_driver);
>> +
>> +MODULE_AUTHOR("Min-Jen Chen <mjchen@nuvoton.com>");
>> +MODULE_DESCRIPTION("MA35D1 RTC driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.34.1
>>


Best Regards,
Jacky Huang

