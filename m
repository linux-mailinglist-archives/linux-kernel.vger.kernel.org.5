Return-Path: <linux-kernel+bounces-164889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2C8B8486
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451E2283670
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0172D600;
	Wed,  1 May 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="BQNwc9Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+wv/eDR"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BE33E1;
	Wed,  1 May 2024 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714535955; cv=none; b=k7nz2ar80dQlHcmzWSgQzEwwWcdINyKEdV0K/eFngKqrn2EAAGnCrjTArRdK8B+WaOumEgZGNToxI4rI35D/1V4mlqTXfWbQAinvzX8XK4DQ1aaB8RlRD8qbEYqedLNoOept5uJA4q0g6l4Hcc6JfgKHm2FlLSSlh5UEPh8bt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714535955; c=relaxed/simple;
	bh=g53EUZnPoleQYZoGVba6GtPupLNKqic+X8XgcUdlWlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG511MU/stkyD4SVgory7e/D9HMXqmXZWIPkKFYyJlWOVD5a8ECD9jOjatRBLkAF7MV9Y9DxPTs6jeoLxVk9bMFs5k3SDN/yX6B+RZ5mD8pE+nCOrOkW2UuGernZABOU/x+0+I3bXhqu1cK6OGSJuqCHQcI/G7Y29YuaW6wc+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=BQNwc9Dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+wv/eDR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8BF7511400F4;
	Tue, 30 Apr 2024 23:59:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 23:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714535951; x=1714622351; bh=1QJiUDERsQ
	1+7nZjjKjLtvPkmbxwyGdRevg+VTCIKl8=; b=BQNwc9DqjU5zct1+3fv5nuErp5
	WJcW31TK+8rgGKkHTPHkrAqBTIylk5ZwTBj/SfS/At6kQbhB9uZa73DkGX3haHMP
	XwQJpgyRUSSd6NZjUPpFEBKI9a7XbqCvsrRhs5CYvRgEvYnXYLlrAf2TeAL2r+iX
	ZD1a1Q4JB/KfJ4eGkqOZ1ZA+nPPJ+zKRarptHfpeAq2uVLdbdxQCb8y0o9K6O36+
	bOxpTLkLiFatHwU+uLmWgm/gCnHyTFMWuAmbueE8A4lTYoc6JWM3PcTA0iFF+qkt
	fjLPa026WkKjWb+j1zG37zXridzDNVhxn5fmu4f6AnZpSBJ8km3fjOAIQoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714535951; x=1714622351; bh=1QJiUDERsQ1+7nZjjKjLtvPkmbxw
	yGdRevg+VTCIKl8=; b=d+wv/eDRuJ7N9R+C1q6W8BVPbFgpp4SKxDXTzbhSakoV
	0e4KCJX5fK6Mvu6EjP1mpKJyCNuId6ypLbZQtfJ65y3akR0YlfKSZUskYHvPPmXs
	HujiLxh3nSJN6+X3MViw6NAwMIRQv0aZbq02CjokU4JP/pFRj6RTTsaJe+VNKzqR
	361Z/0DNdbWXCMbEPRrjfSNei5wL+ufbtb1XbhJrae5/iLsuY9CnUrl+maLhoIOM
	alpysekyQRcp+W877H09oO971qGYUrlqTEW9z2hDEjXuEP2GD/ykB0fb2ws4Quvc
	g4qkkiEiLOR4WzSnGjm3J6EFHR926gJZ6lC23q6LGg==
X-ME-Sender: <xms:D74xZq7qSTzPAG3N2sU73FRXcJ8XfPQZHRXBemmVDg3uvlDo2LDf4g>
    <xme:D74xZj5cr5haGhzRv2A1b12aGdHQnS0l-fC7TuKgU9fRvhe8GHoEXBHPyFlvxb-tv
    X13CHoAeavzd6C4AVE>
X-ME-Received: <xmr:D74xZpdSElTtTCuApXuD07he-Mlz3PqgwPpGlRpJ97w3YHDcBoZVD1noHQe00mM4qhJ-M0aklnppqRF3rjnhJahH8ZXvMtsMO4wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:D74xZnJAGJxuc19DjHQeViO0HNxXrYZYgfR7RCOZUo4Ww16DBEO2hw>
    <xmx:D74xZuKglcFWJ_amV62jRt_kKYy6CwFYBJj03OGP55sGu1HFuRG1KQ>
    <xmx:D74xZowof6g5KjDKNMgIByDSCN1Uu1iC1bXz8-qTo9bLw_FXEckkxQ>
    <xmx:D74xZiKdPzgZ_OKnt6L0fFCYg1Bln1VXLQFt1aIRwG2A7r-vBW0gpw>
    <xmx:D74xZm9X3yTfqkWKBUEI8W2oHH5X0PUOFmZek-jkAllsw_jebrF5i1sn>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 23:59:08 -0400 (EDT)
Date: Wed, 1 May 2024 13:59:02 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jason Andryuk <jandryuk@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: try trimming too long modalias strings
Message-ID: <20240501035902.GA219581@quokka>
References: <ZjAWMQCJdrxZkvkB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjAWMQCJdrxZkvkB@google.com>

On Mon, Apr 29, 2024 at 02:50:41PM -0700, Dmitry Torokhov wrote:
> If an input device declares too many capability bits then modalias
> string for such device may become too long and not fit into uevent
> buffer, resulting in failure of sending said uevent. This, in turn,
> may prevent userspace from recognizing existence of such devices.
> 
> This is typically not a concern for real hardware devices as they have
> limited number of keys, but happen with synthetic devices such as
> ones created by xen-kbdfront driver, which creates devices as being
> capable of delivering all possible keys, since it doesn't know what
> keys the backend may produce.
> 
> To deal with such devices input core will attempt to trim key data,
> in the hope that the rest of modalias string will fit in the given
> buffer. When trimming key data it will indicate that it is not
> complete by placing "+," sign, resulting in conversions like this:
> 
> old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> new: k71,72,73,74,78,7A,7B,7C,+,
> 
> This should allow existing udev rules continue to work with existing
> devices, and will also allow writing more complex rules that would
> recognize trimmed modalias and check input device characteristics by
> other means (for example by parsing KEY= data in uevent or parsing
> input device sysfs attributes).
> 
> Note that the driver core may try adding more uevent environment
> variables once input core is done adding its own, so when forming
> modalias we can not use the entire available buffer, so we reduce
> it by somewhat an arbitrary amount (96 bytes).
> 
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: do not use entire available buffer when formatting modalias, leave
>     some space for driver core to add more data.

ftr, there's nothing in the projects I maintain that require those bits
of the modalias, so I'm good :) I'm not aware of any parsers that would
struggle with the + sign here. git grep of systemd doesn't show anything
either, so I think we're good.

Took me an embarrassingly long time to wrap my head around the code but 
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter

> 
>  drivers/input/input.c | 108 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index b04bcdeee557..045f4b62088a 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1338,19 +1338,19 @@ static int input_print_modalias_bits(char *buf, int size,
>  				     char name, const unsigned long *bm,
>  				     unsigned int min_bit, unsigned int max_bit)
>  {
> -	int len = 0, i;
> +	int bit = min_bit;
> +	int len = 0;
>  
>  	len += snprintf(buf, max(size, 0), "%c", name);
> -	for (i = min_bit; i < max_bit; i++)
> -		if (bm[BIT_WORD(i)] & BIT_MASK(i))
> -			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
> +	for_each_set_bit_from(bit, bm, max_bit)
> +		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
>  	return len;
>  }
>  
> -static int input_print_modalias(char *buf, int size, const struct input_dev *id,
> -				int add_cr)
> +static int input_print_modalias_parts(char *buf, int size, int full_len,
> +				      const struct input_dev *id)
>  {
> -	int len;
> +	int len, klen, remainder, space;
>  
>  	len = snprintf(buf, max(size, 0),
>  		       "input:b%04Xv%04Xp%04Xe%04X-",
> @@ -1359,8 +1359,48 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
>  
>  	len += input_print_modalias_bits(buf + len, size - len,
>  				'e', id->evbit, 0, EV_MAX);
> -	len += input_print_modalias_bits(buf + len, size - len,
> +
> +	/*
> +	 * Calculate the remaining space in the buffer making sure we
> +	 * have place for the terminating 0.
> +	 */
> +	space = max(size - (len + 1), 0);
> +
> +	klen = input_print_modalias_bits(buf + len, size - len,
>  				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
> +	len += klen;
> +
> +	/*
> +	 * If we have more data than we can fit in the buffer, check
> +	 * if we can trim key data to fit in the rest. We will indicate
> +	 * that key data is incomplete by adding "+" sign at the end, like
> +	 * this: * "k1,2,3,45,+,".
> +	 *
> +	 * Note that we shortest key info (if present) is "k+," so we
> +	 * can only try to trim if key data is longer than that.
> +	 */
> +	if (full_len && size < full_len + 1 && klen > 3) {
> +		remainder = full_len - len;
> +		/*
> +		 * We can only trim if we have space for the remainder
> +		 * and also for at least "k+," which is 3 more characters.
> +		 */
> +		if (remainder <= space - 3) {
> +			/*
> +			 * We are guaranteed to have 'k' in the buffer, so
> +			 * we need at least 3 additional bytes for storing
> +			 * "+," in addition to the remainder.
> +			 */
> +			for (int i = size - 1 - remainder - 3; i >= 0; i--) {
> +				if (buf[i] == 'k' || buf[i] == ',') {
> +					strcpy(buf + i + 1, "+,");
> +					len = i + 3; /* Not counting '\0' */
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
>  	len += input_print_modalias_bits(buf + len, size - len,
>  				'r', id->relbit, 0, REL_MAX);
>  	len += input_print_modalias_bits(buf + len, size - len,
> @@ -1376,22 +1416,37 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
>  	len += input_print_modalias_bits(buf + len, size - len,
>  				'w', id->swbit, 0, SW_MAX);
>  
> -	if (add_cr)
> -		len += snprintf(buf + len, max(size - len, 0), "\n");
> -
>  	return len;
>  }
>  
> +static int input_print_modalias(char *buf, int size, const struct input_dev *id)
> +{
> +	int full_len;
> +
> +	/*
> +	 * Printing is done in 2 passes: first one figures out total length
> +	 * needed for the modalias string, second one will try to trim key
> +	 * data in case when buffer is too small for the entire modalias.
> +	 * If the buffer is too small regardless, it will fill as much as it
> +	 * can (without trimming key data) into the buffer and leave it to
> +	 * the caller to figure out what to do with the result.
> +	 */
> +	full_len = input_print_modalias_parts(NULL, 0, 0, id);
> +	return input_print_modalias_parts(buf, size, full_len, id);
> +}
> +
>  static ssize_t input_dev_show_modalias(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
>  {
>  	struct input_dev *id = to_input_dev(dev);
> -	ssize_t len;
> +	size_t len;
>  
> -	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
> +	len = input_print_modalias(buf, PAGE_SIZE, id);
> +	if (len < PAGE_SIZE - 2)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>  
> -	return min_t(int, len, PAGE_SIZE);
> +	return min(len, PAGE_SIZE);
>  }
>  static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
>  
> @@ -1601,6 +1656,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
>  	return 0;
>  }
>  
> +/*
> + * This is a pretty gross hack. When building uevent data the driver core
> + * may try adding more environment variables to kobj_uevent_env without
> + * telling us, so we have no idea how much of the buffer we can use to
> + * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
> + * reduce amount of memory we will use for the modalias environment variable.
> + *
> + * The potential additions are:
> + *
> + * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
> + * HOME=/ (6 bytes)
> + * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
> + *
> + * 68 bytes total. Allow extra buffer - 96 bytes
> + */
> +#define UEVENT_ENV_EXTRA_LEN	96
> +
>  static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
>  					 const struct input_dev *dev)
>  {
> @@ -1610,9 +1682,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
>  		return -ENOMEM;
>  
>  	len = input_print_modalias(&env->buf[env->buflen - 1],
> -				   sizeof(env->buf) - env->buflen,
> -				   dev, 0);
> -	if (len >= (sizeof(env->buf) - env->buflen))
> +				   (int)sizeof(env->buf) - env->buflen -
> +					UEVENT_ENV_EXTRA_LEN,
> +				   dev);
> +	if (len >= ((int)sizeof(env->buf) - env->buflen -
> +					UEVENT_ENV_EXTRA_LEN))
>  		return -ENOMEM;
>  
>  	env->buflen += len;
> -- 
> 2.44.0.769.g3c40516874-goog
> 
> 
> -- 
> Dmitry

