Return-Path: <linux-kernel+bounces-131120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B289834E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4128A302
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5671B24;
	Thu,  4 Apr 2024 08:40:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9576027D;
	Thu,  4 Apr 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220049; cv=none; b=cy5eZn6pyYvu1LBEuBmHCynKM44Xvzp6Ni7ZXIoFpNOaPOOxoJ9kzfkr7Nfe74ORpphU278Qhi/fbUvvGv2JvTi4WP9tOhFug66qNFLpE+P429MRnITvpImrWuHTEAdqfMdUHZIO7oMRXYyAAN6DRIroGn40CztCt61GGy8wjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220049; c=relaxed/simple;
	bh=wn7xtsjaTkXfKIzw5gjpPwLITNNhyQ7OfsOpriiQNiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkrpu4sauoCffvnZeJUto/zSm9RP3IH6wPJihpqHRFcy0R3FCMCh1QEXHc13xhuo2ecfW2TcU1hIfgj7qe2Y5mec+ZhfuygHBHlJffFfyHHKwmIFl/5tPEM80rgI+w1JI6de3bKfTiZ4gswqWaohGjbB8mzq4/+xTXBD96e6+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91EC433C7;
	Thu,  4 Apr 2024 08:40:46 +0000 (UTC)
Message-ID: <1caa6a4c-d4c1-474a-abf2-63384dba3cbb@xs4all.nl>
Date: Thu, 4 Apr 2024 10:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: cec: core: remove length check of Timer Status
Content-Language: en-US, nl
To: nini.song@mediatek.com
Cc: ci.wu@mediatek.com, mchehab@kernel.org, nicolas@fjasle.eu,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
References: <20240125132850.10430-1-nini.song@mediatek.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240125132850.10430-1-nini.song@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nini,

This patch has now been merged in mainline as commit ce5d241c3ad45
("media: cec: core: remove length check of Timer Status").

To get this into older kernels please post this patch to
stable@vger.kernel.org, CC the linux-media mailinglist, and mention the
mainline commit that I provided above.

Also mention that this patch applies to 5.10 and up. You can mention
that the patch applies to 5.4 and 4.19 as well after removing the '/core'
directory from the pathnames.

Since you are the author of the patch, you should be the one to post
the patch.

Regards,

	Hans


On 25/01/2024 14:28, nini.song@mediatek.com wrote:
> From: "nini.song" <nini.song@mediatek.com>
> 
> The valid_la is used to check the length requirements,
> including special cases of Timer Status. If the length is
> shorter than 5, that means no Duration Available is returned,
> the message will be forced to be invalid.
> 
> However, the description of Duration Available in the spec
> is that this parameter may be returned when these cases, or
> that it can be optionally return when these cases. The key
> words in the spec description are flexible choices.
> 
> Remove the special length check of Timer Status to fit the
> spec which is not compulsory about that.
> 
> Signed-off-by: Nini Song <nini.song@mediatek.com>
> ---
>  drivers/media/cec/core/cec-adap.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 5741adf09a2e..559a172ebc6c 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -1151,20 +1151,6 @@ void cec_received_msg_ts(struct cec_adapter *adap,
>  	if (valid_la && min_len) {
>  		/* These messages have special length requirements */
>  		switch (cmd) {
> -		case CEC_MSG_TIMER_STATUS:
> -			if (msg->msg[2] & 0x10) {
> -				switch (msg->msg[2] & 0xf) {
> -				case CEC_OP_PROG_INFO_NOT_ENOUGH_SPACE:
> -				case CEC_OP_PROG_INFO_MIGHT_NOT_BE_ENOUGH_SPACE:
> -					if (msg->len < 5)
> -						valid_la = false;
> -					break;
> -				}
> -			} else if ((msg->msg[2] & 0xf) == CEC_OP_PROG_ERROR_DUPLICATE) {
> -				if (msg->len < 5)
> -					valid_la = false;
> -			}
> -			break;
>  		case CEC_MSG_RECORD_ON:
>  			switch (msg->msg[2]) {
>  			case CEC_OP_RECORD_SRC_OWN:


