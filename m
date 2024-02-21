Return-Path: <linux-kernel+bounces-74342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4685D300
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A5282107
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3523D0C5;
	Wed, 21 Feb 2024 09:02:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA103A269;
	Wed, 21 Feb 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506127; cv=none; b=ZNpK7IrL07xO85GdmEKN+hmNCr9mOI22XU7qp6PEx3i4J324SVbUGyvJGAcyQGyNw7lgSh2eApTpBHWrEC8LbQ/QjgBfo3RNYzKQrrZKSz+8TY8wZjMlb2vD0tDoz74vuB95DIPe7bT9nlidTWf8yb9X8fhQG5fRdlGBcCiRv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506127; c=relaxed/simple;
	bh=DG6+fpNdY1Tug+hDsUyTbjuti0AppTqFewpkJHzY90I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtuoDhjgHK90i7yfj1oL+arT3TMFr8c5nlPrdAYmJOb4e0Ewwy3+D4Z/ySWZB827A59kwO1FqCHgZCA43/rzVb80dkXheMaOn3y6fmvJGzuV9rlqtPadgYa9ZbsHDwTZaEALIgf5R9tNkaJQa845EuCDOEa6XsUOt+8tVE/+9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D60CC433F1;
	Wed, 21 Feb 2024 09:02:05 +0000 (UTC)
Message-ID: <852dea56-336a-4484-8754-ee735af7bdaf@xs4all.nl>
Date: Wed, 21 Feb 2024 10:02:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: cec: core: remove length check of Timer Status
To: =?UTF-8?B?TmluaSBTb25nICjlrovlrpvlpq4p?= <Nini.Song@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 =?UTF-8?B?Q0kgV3UgKOS8jeWAieWEhCk=?= <ci.wu@mediatek.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "jani.nikula@intel.com" <jani.nikula@intel.com>
References: <20240125132850.10430-1-nini.song@mediatek.com>
 <8a4447ba-d4ac-40ac-9d6b-796db37f3100@xs4all.nl>
 <089a5abf85fb3aaa57cb9436193b09eea47a03d2.camel@mediatek.com>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <089a5abf85fb3aaa57cb9436193b09eea47a03d2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Nini,

Unfortunately I forgot to add a 'Fixes' tag to the patch, if I had, then it would
have happened automatically.

Please remind me of this once kernel 6.9-rc1 is released since that will contain
the fix. Then I can post the same patch to the stable mailinglist for inclusion in
older kernels.

It has to wait until 6.9-rc1 is release though, patches need to be in mainline first
before they can be backported.

Regards,

	Hans

On 21/02/2024 07:30, Nini Song (宋宛妮) wrote:
> Dear Hans,
> 
> Thank your reply.
> Could you also help to marge solution into v5.15? Our customer used v5.15 for MP production, which requires this solution.
> 
> 
> BR,
> Nini Song
> On Mon, 2024-02-05 at 13:00 +0100, Hans Verkuil wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>> On 25/01/2024 14:28, nini.song@mediatek.com wrote:
>> > From: "nini.song" <nini.song@mediatek.com>
>> > 
>> > The valid_la is used to check the length requirements,
>> > including special cases of Timer Status. If the length is
>> > shorter than 5, that means no Duration Available is returned,
>> > the message will be forced to be invalid.
>> > 
>> > However, the description of Duration Available in the spec
>> > is that this parameter may be returned when these cases, or
>> > that it can be optionally return when these cases. The key
>> > words in the spec description are flexible choices.
>>
>> Good catch, the spec indeed says 'may', so dropping the check
>> in this patch is the correct thing to do.
>>
>> It's merged in our staging tree and it will appear in v6.9.
>>
>> Regards,
>>
>> Hans
>>
>> > 
>> > Remove the special length check of Timer Status to fit the
>> > spec which is not compulsory about that.
>> > 
>> > Signed-off-by: Nini Song <nini.song@mediatek.com>
>> > ---
>> >  drivers/media/cec/core/cec-adap.c | 14 --------------
>> >  1 file changed, 14 deletions(-)
>> > 
>> > diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
>> > index 5741adf09a2e..559a172ebc6c 100644
>> > --- a/drivers/media/cec/core/cec-adap.c
>> > +++ b/drivers/media/cec/core/cec-adap.c
>> > @@ -1151,20 +1151,6 @@ void cec_received_msg_ts(struct cec_adapter *adap,
>> >  if (valid_la && min_len) {
>> >  /* These messages have special length requirements */
>> >  switch (cmd) {
>> > -case CEC_MSG_TIMER_STATUS:
>> > -if (msg->msg[2] & 0x10) {
>> > -switch (msg->msg[2] & 0xf) {
>> > -case CEC_OP_PROG_INFO_NOT_ENOUGH_SPACE:
>> > -case CEC_OP_PROG_INFO_MIGHT_NOT_BE_ENOUGH_SPACE:
>> > -if (msg->len < 5)
>> > -valid_la = false;
>> > -break;
>> > -}
>> > -} else if ((msg->msg[2] & 0xf) == CEC_OP_PROG_ERROR_DUPLICATE) {
>> > -if (msg->len < 5)
>> > -valid_la = false;
>> > -}
>> > -break;
>> >  case CEC_MSG_RECORD_ON:
>> >  switch (msg->msg[2]) {
>> >  case CEC_OP_RECORD_SRC_OWN:
>>
>>


