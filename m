Return-Path: <linux-kernel+bounces-54428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24584AF1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D6F284BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7470129A62;
	Tue,  6 Feb 2024 07:39:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F70128833;
	Tue,  6 Feb 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205143; cv=none; b=fQbflNArZq8GQpvfTmYenptEMegOLFhfNkSNZZmleY1157PPgGUn8JJBkLmYMhj5k79CvoiyUFRubGuq/LiWJhXSnS9FMFA1CvaFKPXLJZhB0erXJngPeho6kSwFCXt2s4spc7Mod42TIXc9893jIyBG/VQiXm4aLVLAGC3/kcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205143; c=relaxed/simple;
	bh=CLBSsXpLFwXgVGHcFk5IYEud4mRKbYRtZ92O1B4ULrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WasiwR50wMDcljc1/3e0fnGOYICBaREU0QSNQg5lhrILwn0QapSkqy2EXFLolQHbZGiCJFbZRGW35LRThkxleOR/b8ZG2uup2rv7xk9zRzppYjqaX+/E3PMlriOs6x4ZgAIssbj4hC8MdLvZfBGIruF2WuUAJuqjCnWQUYxLIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12340C433F1;
	Tue,  6 Feb 2024 07:39:00 +0000 (UTC)
Message-ID: <ae539786-f73a-41ba-97a4-ea409fb88e2f@xs4all.nl>
Date: Tue, 6 Feb 2024 08:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: adv7180: Fix cppcheck warnings
Content-Language: en-US, nl
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240102142729.1743421-1-bhavin.sharma@siliconsignals.io>
 <16ef7746-d038-4607-8e2f-8f7cef5a8b48@xs4all.nl>
 <MAZPR01MB695711E70CEDFC41DE5C2C8DF2462@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 xsFNBFQ84W0BEAC7EF1iL4s3tY8cRTVkJT/297h0Hz0ypA+ByVM4CdU9sN6ua/YoFlr9k0K4
 BFUlg7JzJoUuRbKxkYb8mmqOe722j7N3HO8+ofnio5cAP5W0WwDpM0kM84BeHU0aPSTsWiGR
 yw55SOK2JBSq7hueotWLfJLobMWhQii0Zd83hGT9SIt9uHaHjgwmtTH7MSTIiaY6N14nw2Ud
 C6Uykc1va0Wqqc2ov5ihgk/2k2SKa02ookQI3e79laOrbZl5BOXNKR9LguuOZdX4XYR3Zi6/
 BsJ7pVCK9xkiVf8svlEl94IHb+sa1KrlgGv3fn5xgzDw8Z222TfFceDL/2EzUyTdWc4GaPMC
 E/c1B4UOle6ZHg02+I8tZicjzj5+yffv1lB5A1btG+AmoZrgf0X2O1B96fqgHx8w9PIpVERN
 YsmkfxvhfP3MO3oHh8UY1OLKdlKamMneCLk2up1Zlli347KMjHAVjBAiy8qOguKF9k7HOjif
 JCLYTkggrRiEiE1xg4tblBNj8WGyKH+u/hwwwBqCd/Px2HvhAsJQ7DwuuB3vBAp845BJYUU3
 06kRihFqbO0vEt4QmcQDcbWINeZ2zX5TK7QQ91ldHdqJn6MhXulPKcM8tCkdD8YNXXKyKqNl
 UVqXnarz8m2JCbHgjEkUlAJCNd6m3pfESLZwSWsLYL49R5yxIwARAQABzSFIYW5zIFZlcmt1
 aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD7CwZUEEwECACgFAlQ84W0CGwMFCRLMAwAGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAACEJEL0tYUhmFDtMFiEEBSzee8IVBTtonxvKvS1hSGYUO0wT
 7w//frEmPBAwu3OdvAk9VDkH7X+7RcFpiuUcJxs3Xl6jpaA+SdwtZra6W1uMrs2RW8eXXiq/
 80HXJtYnal1Y8MKUBoUVhT/+5+KcMyfVQK3VFRHnNxCmC9HZV+qdyxAGwIscUd4hSlweuU6L
 6tI7Dls6NzKRSTFbbGNZCRgl8OrF01TBH+CZrcFIoDgpcJA5Pw84mxo+wd2BZjPA4TNyq1od
 +slSRbDqFug1EqQaMVtUOdgaUgdlmjV0+GfBHoyCGedDE0knv+tRb8v5gNgv7M3hJO3Nrl+O
 OJVoiW0G6OWVyq92NNCKJeDy8XCB1yHCKpBd4evO2bkJNV9xcgHtLrVqozqxZAiCRKN1elWF
 1fyG8KNquqItYedUr+wZZacqW+uzpVr9pZmUqpVCk9s92fzTzDZcGAxnyqkaO2QTgdhPJT2m
 wpG2UwIKzzi13tmwakY7OAbXm76bGWVZCO3QTHVnNV8ku9wgeMc/ZGSLUT8hMDZlwEsW7u/D
 qt+NlTKiOIQsSW7u7h3SFm7sMQo03X/taK9PJhS2BhhgnXg8mOa6U+yNaJy+eU0Lf5hEUiDC
 vDOI5x++LD3pdrJVr/6ZB0Qg3/YzZ0dk+phQ+KlP6HyeO4LG662toMbFbeLcBjcC/ceEclII
 90QNEFSZKM6NVloM+NaZRYVO3ApxWkFu+1mrVTXOwU0EVDzhbQEQANzLiI6gHkIhBQKeQaYs
 p2SSqF9c++9LOy5x6nbQ4s0X3oTKaMGfBZuiKkkU6NnHCSa0Az5ScRWLaRGu1PzjgcVwzl5O
 sDawR1BtOG/XoPRNB2351PRp++W8TWo2viYYY0uJHKFHML+ku9q0P+NkdTzFGJLP+hn7x0RT
 DMbhKTHO3H2xJz5TXNE9zTJuIfGAz3ShDpijvzYieY330BzZYfpgvCllDVM5E4XgfF4F/N90
 wWKu50fMA01ufwu+99GEwTFVG2az5T9SXd7vfSgRSkzXy7hcnxj4IhOfM6Ts85/BjMeIpeqy
 TDdsuetBgX9DMMWxMWl7BLeiMzMGrfkJ4tvlof0sVjurXibTibZyfyGR2ricg8iTbHyFaAzX
 2uFVoZaPxrp7udDfQ96sfz0hesF9Zi8d7NnNnMYbUmUtaS083L/l2EDKvCIkhSjd48XF+aO8
 VhrCfbXWpGRaLcY/gxi2TXRYG9xCa7PINgz9SyO34sL6TeFPSZn4bPQV5O1j85Dj4jBecB1k
 z2arzwlWWKMZUbR04HTeAuuvYvCKEMnfW3ABzdonh70QdqJbpQGfAF2p4/iCETKWuqefiOYn
 pR8PqoQA1DYv3t7y9DIN5Jw/8Oj5wOeEybw6vTMB0rrnx+JaXvxeHSlFzHiD6il/ChDDkJ9J
 /ejCHUQIl40wLSDRABEBAAHCwXwEGAECAA8FAlQ84W0CGwwFCRLMAwAAIQkQvS1hSGYUO0wW
 IQQFLN57whUFO2ifG8q9LWFIZhQ7TA1WD/9yxJvQrpf6LcNrr8uMlQWCg2iz2q1LGt1Itkuu
 KaavEF9nqHmoqhSfZeAIKAPn6xuYbGxXDrpN7dXCOH92fscLodZqZtK5FtbLvO572EPfxneY
 UT7JzDc/5LT9cFFugTMOhq1BG62vUm/F6V91+unyp4dRlyryAeqEuISykhvjZCVHk/woaMZv
 c1Dm4Uvkv0Ilelt3Pb9J7zhcx6sm5T7v16VceF96jG61bnJ2GFS+QZerZp3PY27XgtPxRxYj
 AmFUeF486PHx/2Yi4u1rQpIpC5inPxIgR1+ZFvQrAV36SvLFfuMhyCAxV6WBlQc85ArOiQZB
 Wm7L0repwr7zEJFEkdy8C81WRhMdPvHkAIh3RoY1SGcdB7rB3wCzfYkAuCBqaF7Zgfw8xkad
 KEiQTexRbM1sc/I8ACpla3N26SfQwrfg6V7TIoweP0RwDrcf5PVvwSWsRQp2LxFCkwnCXOra
 gYmkrmv0duG1FStpY+IIQn1TOkuXrciTVfZY1cZD0aVxwlxXBnUNZZNslldvXFtndxR0SFat
 sflovhDxKyhFwXOP0Rv8H378/+14TaykknRBIKEc0+lcr+EMOSUR5eg4aURb8Gc3Uc7fgQ6q
 UssTXzHPyj1hAyDpfu8DzAwlh4kKFTodxSsKAjI45SLjadSc94/5Gy8645Y1KgBzBPTH7Q==
In-Reply-To: <MAZPR01MB695711E70CEDFC41DE5C2C8DF2462@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/02/2024 06:05, Bhavin Sharma wrote:
> Hi Hans,
> 
>> Hi Bhavin,
> 
>> On 02/01/2024 15:27, Bhavin Sharma wrote:
>>> WARNING: Missing a blank line after declarations
>>>
>>> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
>>> ---
>>>   drivers/media/i2c/adv7180.c | 27 ++++++++++++++++++---------
>>>   1 file changed, 18 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
>>> index 54134473186b..0023a546b3c9 100644
>>> --- a/drivers/media/i2c/adv7180.c
>>> +++ b/drivers/media/i2c/adv7180.c
>>> @@ -335,8 +335,9 @@ static u32 adv7180_status_to_v4l2(u8 status1)
>>>   static int __adv7180_status(struct adv7180_state *state, u32 *status,
>>>                            v4l2_std_id *std)
>>>   {
>>> -     int status1 = adv7180_read(state, ADV7180_REG_STATUS1);
>>> +     int status1;
>>>
>>> +     status1 = adv7180_read(state, ADV7180_REG_STATUS1);
>>>        if (status1 < 0)
>>>                return status1;
>>>
>>> @@ -356,7 +357,9 @@ static inline struct adv7180_state *to_state(struct v4l2_subdev *sd)
>>>   static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
>>>   {
>>>        struct adv7180_state *state = to_state(sd);
>>> -     int err = mutex_lock_interruptible(&state->mutex);
>>> +     int err;
>>> +
>>> +     err = mutex_lock_interruptible(&state->mutex);
> 
>> The problem here is the missing empty line, not that 'int err = <something>;' part.
>> So just add the empty line and don't split up the variable assignment.
> 
> Yes, the error is of missing empty line and I only resolved that particular error in the first version
> of this patch.
> 
> But I was recommended to keep the conditional statement close to the line it is associated with
> and to make changes in the code wherever similar format is followed. 
> 
> So I followed the advise of Kieran Bingham and made changes accordingly. 
> 
> Below is the link of the full discussion : https://lore.kernel.org/lkml/MAZPR01MB695752E4ADB0110443EA695CF2432@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM/T/

Kieran said this:

>> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
>>  {
>>         struct adv7180_state *state = to_state(sd);
> 
> Personally, I would keep the if (err) hugging the line it's associated
> with.
> 
> 
>>         int err = mutex_lock_interruptible(&state->mutex);
>> +
>>         if (err)
>>                 return err;
>>  

which I interpret as saying that he doesn't like adding the extra empty line.

> 
>>>        if (err)
>>>                return err;
>>>
>>> @@ -388,8 +391,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
>>>                             u32 output, u32 config)
>>>   {
>>>        struct adv7180_state *state = to_state(sd);
>>> -     int ret = mutex_lock_interruptible(&state->mutex);
>>> +     int ret;
>>>
>>> +     ret = mutex_lock_interruptible(&state->mutex);

I don't believe he meant doing this.

In any case, none of this is worth the effort, just leave this driver as-is.

Regards,

	Hans

>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -399,7 +403,6 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
>>>        }
>>>
>>>        ret = state->chip_info->select_input(state, input);
>>> -
> 
>> Why remove this empty line? It has nothing to do with what you are trying
>> to fix.
> 
>>>        if (ret == 0)
>>>                state->input = input;
>>>   out:
>>> @@ -410,7 +413,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
>>>   static int adv7180_g_input_status(struct v4l2_subdev *sd, u32 *status)
>>>   {
>>>        struct adv7180_state *state = to_state(sd);
>>> -     int ret = mutex_lock_interruptible(&state->mutex);
>>> +     int ret;
>>> +
>>> +     ret = mutex_lock_interruptible(&state->mutex);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -436,8 +441,9 @@ static int adv7180_program_std(struct adv7180_state *state)
>>>   static int adv7180_s_std(struct v4l2_subdev *sd, v4l2_std_id std)
>>>   {
>>>        struct adv7180_state *state = to_state(sd);
>>> -     int ret = mutex_lock_interruptible(&state->mutex);
>>> +     int ret;
>>>
>>> +     ret = mutex_lock_interruptible(&state->mutex);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -466,8 +472,9 @@ static int adv7180_g_std(struct v4l2_subdev *sd, v4l2_std_id *norm)
>>>   static int adv7180_g_frame_interval(struct v4l2_subdev *sd,
>>>                                    struct v4l2_subdev_frame_interval *fi)
>>>   {
>>> -     struct adv7180_state *state = to_state(sd);
>>> +     struct adv7180_state *state;
>>>
>>> +     state = to_state(sd);
> 
>> And I am sure this never produced a cppcheck warning since there is an
>> empty line. If cppcheck DOES produce a warning on this, then it is a
>> useless application.
> 
>>>        if (state->curr_norm & V4L2_STD_525_60) {
>>>                fi->interval.numerator = 1001;
>>>                fi->interval.denominator = 30000;
>>> @@ -828,8 +835,9 @@ static int adv7180_get_mbus_config(struct v4l2_subdev *sd,
>>>                                   unsigned int pad,
>>>                                   struct v4l2_mbus_config *cfg)
>>>   {
>>> -     struct adv7180_state *state = to_state(sd);
>>> +     struct adv7180_state *state;
>>>
>>> +     state = to_state(sd);
>>>        if (state->chip_info->flags & ADV7180_FLAG_MIPI_CSI2) {
>>>                cfg->type = V4L2_MBUS_CSI2_DPHY;
>>>                cfg->bus.mipi_csi2.num_data_lanes = 1;
>>> @@ -857,8 +865,9 @@ static int adv7180_get_skip_frames(struct v4l2_subdev *sd, u32 *frames)
>>>
>>>   static int adv7180_g_pixelaspect(struct v4l2_subdev *sd, struct v4l2_fract *aspect)
>>>   {
>>> -     struct adv7180_state *state = to_state(sd);
>>> +     struct adv7180_state *state;
>>>
>>> +     state = to_state(sd);
>>>        if (state->curr_norm & V4L2_STD_525_60) {
>>>                aspect->numerator = 11;
>>>                aspect->denominator = 10;
> 
>> Honestly, none of these changes are worth the effort, so I just reject this.
> 
> Kindly give your suggestions.
> 
> Regards,
> Bhavin Sharma


