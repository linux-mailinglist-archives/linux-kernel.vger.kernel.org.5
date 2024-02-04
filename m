Return-Path: <linux-kernel+bounces-51639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294A848DC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C20C1F21D29
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CFD224D1;
	Sun,  4 Feb 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpssMelk"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F037219FF;
	Sun,  4 Feb 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707050313; cv=none; b=iRerOzcIRVZDFbEpFsL0B83BzSyR7r2VsWF78chSDI3gJFArjz2rSrYaUw9hWikjg9iZX558xaClEH8TEWdhgGqt6Y9U8PSSLHT8279yFVCzrSAhR9cMM69mIgUllS+4IFZM4mahrdqAl9Y5KGFaL0Lb8ugiEkBBRDMPenAzvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707050313; c=relaxed/simple;
	bh=j+ToRiFZpvnLu9Ht1tTMEMUSBVsacitkWJKTnRiDMNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8VvttihpyRmh9IE4QFwo6qdBgbEW3WUEf0xBIVECWDry+g3c0PPxssgO7oxSiDBxbJdKbpyp7h6gXT5q7v9WYS1kkudMiacrP8oejnZkrzSW4XzZ14EY1RGtTav1M4in96BoJ4gRy6r9ezKm0YOxePlAC/LXUU9rzd8x/jYJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpssMelk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so2049777a12.1;
        Sun, 04 Feb 2024 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707050310; x=1707655110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32Q6YTS5ws6raYaIT2GcHgl2b3PwHkFzIfRPKAaxQHg=;
        b=gpssMelk0nGq2waJR8Vz0VYps5x1/KwZL6GqDLMhAW8e/Dw9t86b59jQa7OU0m+7uP
         iSSt2qqrTr2qFsd0dRgYksfHQG4wtJ8Qm1GuTozAOtTJwEjF3I/W2r4ugy6BPMANctuT
         Zy2hH+hmmW76IofdbVuHK4amzNW53QlhPpO1dXWcj4q8Xk48HUVBqidRMqHau0Y4tQa3
         N05wGO6H320JErFoLECSP/SgeSnJ8WuI/JP6lWLPXVO32Qw9xKqptwq+LNt0vCG5rMgX
         JrNFt9XrH71t8jq1v+GvjNHR6Z4pvI6DaXijHHU3oyc7OikwPseQLz0L5NZeUCtwgtAv
         Jeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707050310; x=1707655110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32Q6YTS5ws6raYaIT2GcHgl2b3PwHkFzIfRPKAaxQHg=;
        b=oOzuvHGI54aCLymvmHt6KjibgHW1UTmz8EtyiOWCcTVhUzc1JPzZ5RwggR6lxNa0wT
         kAtWcFFJP5kxVWYSMXQnnW42SHyrX9WEOc9/mwWp8+PXm5ch8gPWamurc1L2C6QaC2hL
         GHpI2MslybAt+BKz26Yo/qYqwda3ZE818KN0ynGdXFA4txnESoxRzCDUo/lxkBu7DrxI
         17ulI4V6I77pej8WauJzeRp0Q4R6iQChZzWYTTMAghpTs2CJG2EEH/gJI1AWyNvC5w5J
         /QsssTO3wFjugt623a2UU7WMIHhR4n5t+Hf52ZqtaJfjjEgLH8ADsfiTgWmiu6bzMixO
         92/g==
X-Gm-Message-State: AOJu0YzBnaisVB2++QEDRETFL4NckPnkfiB+RuFADibB1YywhKNzEdlz
	WCizHKn1zRl4VuI8vSXTHy1bXx4FUKE9qGHW1+gGy1MjpFojLBPlUAGQkKOY
X-Google-Smtp-Source: AGHT+IFaQ/5Y44l2RFYN8PfQKsVAI97M6RYbaDK+cpf46WDGaFjZnmSmxWaHi+SGGwHJnOuYFs0ckg==
X-Received: by 2002:a05:6402:180a:b0:560:5fc:9f10 with SMTP id g10-20020a056402180a00b0056005fc9f10mr2964665edy.28.1707050310003;
        Sun, 04 Feb 2024 04:38:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQpZz8xGBntVIkRZfxhKsmZbs5QSxcb9XSMW5PeHNB68RjLVTcV8maTn6dYAmYqrjpAKlAqlMg70nxireZLoeGRMcsTGIyOAHdtyPAWac2EqLfXgUGpyHPtB7i0M7NXw4lH6bjsFS687T/CxBR/1tYMbJjEOqCg39tNMYcqIqKzPPRDOwYBc9yvgU=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id b99-20020a509f6c000000b0055fdaf9ceb2sm2846043edf.91.2024.02.04.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:38:29 -0800 (PST)
Date: Sun, 4 Feb 2024 13:38:27 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240204123827.GA19525@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
 <194ed4ce-bb2e-404e-a716-ec2e9876c740@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <194ed4ce-bb2e-404e-a716-ec2e9876c740@gmail.com>

Am Sun, Feb 04, 2024 at 12:26:53PM +0100 schrieb Javier Carrasco:
> Hi Dimitri,
>
Hi Javier,
> On 04.02.24 11:37, Dimitri Fedrau wrote:
> >  
> > +static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	struct hdc3020_data *data = iio_priv(indio_dev);
> > +	u16 *thresh;
> > +	u8 buf[5];
> > +	int ret;
> > +
> I tested your patch right now and I noticed that you are only writing
> integer values, which means that for example 19.9999 turns into 18.9169.
> It seems that you are not using val2 (the decimal part).
> 
> Is there any reason for that? The displayed thresholds are decimal, though.
thanks for testing. I wanted to allow only integers because of the
truncated threshold values.(Still there is the resolution loss) On the other
side I missed to return integers. I think you are right, have to evaluate
val2. It's better to be as accurate as possible. I will fix this.

> > +	/* Supported temperature range is from –40 to 125 degree celsius */
> > +	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
> > +		return -EINVAL;
> > +
> > +	/* Select threshold and associated register */
> > +	if (info == IIO_EV_INFO_VALUE) {
> > +		if (dir == IIO_EV_DIR_RISING) {
> > +			thresh = &data->t_rh_thresh_high;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH, 2);
> > +		} else {
> > +			thresh = &data->t_rh_thresh_low;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW, 2);
> > +		}
> > +	} else {
> > +		if (dir == IIO_EV_DIR_RISING) {
> > +			thresh = &data->t_rh_thresh_high_clr;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH_CLR, 2);
> > +		} else {
> > +			thresh = &data->t_rh_thresh_low_clr;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW_CLR, 2);
> > +		}
> > +	}
> > +
> > +	guard(mutex)(&data->lock);
> > +	switch (chan->type) {
> > +	case IIO_TEMP:
> > +		/*
> > +		 * Store truncated temperature threshold into 9 LSBs while
> > +		 * keeping the old humidity threshold in the 7 MSBs.
> > +		 */
> > +		val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
> > +		val &= HDC3020_THRESH_TEMP_MASK;
> > +		val |= (*thresh & HDC3020_THRESH_HUM_MASK);
> > +		break;
> > +	case IIO_HUMIDITYRELATIVE:
> > +		/*
> > +		 * Store truncated humidity threshold into 7 MSBs while
> > +		 * keeping the old temperature threshold in the 9 LSBs.
> > +		 */
> > +		val = ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
> > +		val |= (*thresh & HDC3020_THRESH_TEMP_MASK);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	put_unaligned_be16(val, &buf[2]);
> > +	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> > +	ret = hdc3020_write_bytes(data, buf, 5);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Update threshold */
> > +	*thresh = val;
> > +
> > +	return 0;
> > +}
> 
> Best regards,
> Javier Carrasco

Best regards,
Dimitri Fedrau

