Return-Path: <linux-kernel+bounces-96533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB81875DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21441C21707
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B432C9C;
	Fri,  8 Mar 2024 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g8VviZX3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2A1E4AE;
	Fri,  8 Mar 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876249; cv=none; b=DVD4csRtAHYLLMzcNRi79BgZhAx9G0aneK1MPnklEVGtFaXonqUF8wcd3o9Ti0IR6/ZDWVehyAP5CsghQJ3Zsm9AdwtJnu72lBGMb4nUqeOt3yZF29/CkPZK1tqbkwfhMLJFn0cZ5eAXY3SEcraVY+Liff/MSBC5o5/kzSAFD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876249; c=relaxed/simple;
	bh=pA30PD9ao8YE5foGBh05uYpzAzeO2NEFV6KJ7h9RX6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBjlM56LDBCrk7FnuzALWbppkAFVpy8oHBR+h6uL3T7dDHgABGzDIf8X2sqySPwE2ll5cTXw+9s1QNUzNqJvp8mfMj5DVKfBG8lAdd2x3RCSRUDQ6z2BfV/Ejcme6xfAqJSfUepiYiypXN3GYiLiAMVQCiKor34kowi1YyIGSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g8VviZX3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.102] (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 414FEBEB;
	Fri,  8 Mar 2024 06:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709876225;
	bh=pA30PD9ao8YE5foGBh05uYpzAzeO2NEFV6KJ7h9RX6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g8VviZX3q4rZL7qQ5OA9CJkETDg/eW0FYARZLzYXwf+6IZz9EidLPngl5w/WjSOJm
	 tkr4bKD3orgrdhqbZEoAXmtravb1m/qWD/AC5zdhHO0J51zxOq5P7Ov5CgssblgUSc
	 zZnWw9D6tVBbpOJoxUTY1eWN0It9honeNs1ur52o=
Message-ID: <72903fa4-be78-48e1-88e1-7c6b2146bc1b@ideasonboard.com>
Date: Fri, 8 Mar 2024 11:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: linux-media@vger.kernel.org,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com>
 <20240306081038.212412-2-umang.jain@ideasonboard.com>
 <CAPY8ntAv2XCgMoA7N6Wj72jOX4rRt4b-HRUr1WXR1diH1bHx8A@mail.gmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <CAPY8ntAv2XCgMoA7N6Wj72jOX4rRt4b-HRUr1WXR1diH1bHx8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave

On 06/03/24 10:12 pm, Dave Stevenson wrote:
> Hi Umang and Kieran
>
> On Wed, 6 Mar 2024 at 08:11, Umang Jain <umang.jain@ideasonboard.com> wrote:
>> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> The IMX335 can support both 2 and 4 lane configurations.
>> Extend the driver to configure the lane mode accordingly.
>> Update the pixel rate depending on the number of lanes in use.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx335.c | 46 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>> index dab6d080bc4c..a42f48823515 100644
>> --- a/drivers/media/i2c/imx335.c
>> +++ b/drivers/media/i2c/imx335.c
>> @@ -21,6 +21,11 @@
>>   #define IMX335_MODE_STANDBY    0x01
>>   #define IMX335_MODE_STREAMING  0x00
>>
>> +/* Data Lanes */
>> +#define IMX335_LANEMODE                0x3a01
>> +#define IMX335_2LANE           1
>> +#define IMX335_4LANE           3
>> +
>>   /* Lines per frame */
>>   #define IMX335_REG_LPFR                0x3030
>>
>> @@ -67,8 +72,6 @@
>>   #define IMX335_LINK_FREQ_594MHz                594000000LL
>>   #define IMX335_LINK_FREQ_445MHz                445500000LL
>>
>> -#define IMX335_NUM_DATA_LANES  4
>> -
>>   #define IMX335_REG_MIN         0x00
>>   #define IMX335_REG_MAX         0xfffff
>>
>> @@ -115,7 +118,6 @@ static const char * const imx335_supply_name[] = {
>>    * @vblank: Vertical blanking in lines
>>    * @vblank_min: Minimum vertical blanking in lines
>>    * @vblank_max: Maximum vertical blanking in lines
>> - * @pclk: Sensor pixel clock
>>    * @reg_list: Register list for sensor mode
>>    */
>>   struct imx335_mode {
>> @@ -126,7 +128,6 @@ struct imx335_mode {
>>          u32 vblank;
>>          u32 vblank_min;
>>          u32 vblank_max;
>> -       u64 pclk;
>>          struct imx335_reg_list reg_list;
>>   };
>>
>> @@ -147,6 +148,7 @@ struct imx335_mode {
>>    * @exp_ctrl: Pointer to exposure control
>>    * @again_ctrl: Pointer to analog gain control
>>    * @vblank: Vertical blanking in lines
>> + * @lane_mode Mode for number of connected data lanes
>>    * @cur_mode: Pointer to current selected sensor mode
>>    * @mutex: Mutex for serializing sensor controls
>>    * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
>> @@ -171,6 +173,7 @@ struct imx335 {
>>                  struct v4l2_ctrl *again_ctrl;
>>          };
>>          u32 vblank;
>> +       u32 lane_mode;
>>          const struct imx335_mode *cur_mode;
>>          struct mutex mutex;
>>          unsigned long link_freq_bitmap;
>> @@ -377,7 +380,6 @@ static const struct imx335_mode supported_mode = {
>>          .vblank = 2560,
>>          .vblank_min = 2560,
>>          .vblank_max = 133060,
>> -       .pclk = 396000000,
>>          .reg_list = {
>>                  .num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
>>                  .regs = mode_2592x1940_regs,
>> @@ -936,6 +938,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
>>                  return ret;
>>          }
>>
>> +       /* Configure lanes */
>> +       ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
>> +       if (ret)
>> +               return ret;
>> +
>>          /* Setup handler will write actual exposure and gain */
>>          ret =  __v4l2_ctrl_handler_setup(imx335->sd.ctrl_handler);
>>          if (ret) {
>> @@ -1096,7 +1103,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>>          if (ret)
>>                  return ret;
>>
>> -       if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX335_NUM_DATA_LANES) {
>> +       switch (bus_cfg.bus.mipi_csi2.num_data_lanes) {
>> +       case 2:
>> +               imx335->lane_mode = IMX335_2LANE;
>> +               break;
>> +       case 4:
>> +               imx335->lane_mode = IMX335_4LANE;
>> +               break;
>> +       default:
>>                  dev_err(imx335->dev,
>>                          "number of CSI2 data lanes %d is not supported\n",
>>                          bus_cfg.bus.mipi_csi2.num_data_lanes);
>> @@ -1209,6 +1223,9 @@ static int imx335_init_controls(struct imx335 *imx335)
>>          struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>>          const struct imx335_mode *mode = imx335->cur_mode;
>>          u32 lpfr;
>> +       u64 pclk;
>> +       s64 link_freq_in_use;
>> +       u8 bpp;
>>          int ret;
>>
>>          ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>> @@ -1252,11 +1269,24 @@ static int imx335_init_controls(struct imx335 *imx335)
>>                                       0, 0, imx335_tpg_menu);
>>
>>          /* Read only controls */
>> +
>> +       /* pixel rate = link frequency * lanes * 2 / bits_per_pixel */
>> +       switch (imx335->cur_mbus_code) {
>> +       case MEDIA_BUS_FMT_SRGGB10_1X10:
>> +               bpp = 10;
>> +               break;
>> +       case MEDIA_BUS_FMT_SRGGB12_1X12:
>> +               bpp = 12;
>> +               break;
>> +       }
>> +
>> +       link_freq_in_use = link_freq[__ffs(imx335->link_freq_bitmap)];
>> +       pclk = link_freq_in_use * (imx335->lane_mode + 1) * 2 / bpp;
>>          imx335->pclk_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>>                                                &imx335_ctrl_ops,
>>                                                V4L2_CID_PIXEL_RATE,
>> -                                             mode->pclk, mode->pclk,
>> -                                             1, mode->pclk);
>> +                                             pclk, pclk,
>> +                                             1, pclk);
> Is this actually correct?
> A fair number of the sensors I've encountered have 2 PLL paths - one
> for the pixel array, and one for the CSI block. The bpp will generally
> be fed into the CSI block PLL path, but not into the pixel array one.
> The link frequency will therefore vary with bit depth, but
> V4L2_CID_PIXEL_RATE doesn't change.
>
> imx290 certainly has a disjoin between pixel rate and link freq
> (cropping reduces link freq, but not pixel rate), and we run imx477 in
> 2 lane mode with the pixel array at full tilt (840MPix/s) but large
> horizontal blanking to allow CSI2 enough time to send the data.
>
> If you've validated that for a range of frame rates you get the
> correct output from the sensor in both 10 and 12 bit modes, then I

I've not validated in such cases. Computing from pixel rate from the 
link_freq and lane mode came out to be the same as the value currently 
hardcoded in the mode structure hence I introduced this change. However, 
I am inclined to dropping it after reading your review  ;-)
> don't object. I just have an instinctive tick whenever I see drivers
> computing PIXEL_RATE from LINK_FREQ or vice versa :)

Having said that, I do know, the reporting is not perfect since the bpp 
can be changed and it would change the link-frequency.
> If you get the right frame rate it may also imply that the link
> frequency isn't as configured, but that rarely has any negative

Indeed ;-)
> effects. You need a reasonably good oscilloscope to be able to measure
> the link frequency.

AH, I see.
>
>    Dave
>
>>          imx335->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>>                                                          &imx335_ctrl_ops,
>> --
>> 2.43.0
>>
>>


