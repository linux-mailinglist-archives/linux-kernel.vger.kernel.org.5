Return-Path: <linux-kernel+bounces-75777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09B85EEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96570284E85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F55134CD;
	Thu, 22 Feb 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WviGeUDy"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9A80C;
	Thu, 22 Feb 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708566748; cv=none; b=lQCKTyRFfGSVocVVMydgaNRKR0RKyiNOIhyBmsU0gP43ZOXelSf28AjliFf+IXPVUKTyhQ8AwA6mvtgOpC0LOXw0yRd+0Oien9ABLkP6UNWXxzqLwOvvyxlp3YclM9FD1Fq8c1VP4glzfWF4I2BjMsd9065+QsKIdrS+HRDxkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708566748; c=relaxed/simple;
	bh=HfikugucBiz+mFSGLjwANbX0NZhAAMQYJMToeenA2Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrOwxZs5AEYWsSQfSKyRiN0zbhk/w19TqU+0580gV12V0TwQo6Q8qWGr/m63P1glYbpJ7lbR+mXex3M0w3BSo8yw34H48EUM7/8S8cR/YKxcw74oN9qu4MqV2IF/QNqPIZ39/wGQqiiPNzu+s8DlJEaOSe7RrxVf/a+4f08paAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WviGeUDy; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e45ef83c54so1441979a34.2;
        Wed, 21 Feb 2024 17:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708566746; x=1709171546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfikugucBiz+mFSGLjwANbX0NZhAAMQYJMToeenA2Ek=;
        b=WviGeUDyb26DQRSj8Gl9aitumgeLJch+JujZAYXi8NqaIqoIdD5sFixymtFLPrGaUM
         uWq/b+59muuwvxVgyw1hvATpikSYIVevSe4LNPEruNj8EKCekIu0sz3fPzLU51b+GTFw
         gE5E5Xtj9ddyeiZDT4M8leEonzm9j2/mRxlpgEQF71TOcb/SVhJQim4PUGVzgu7YNcFc
         qsgjNfDD4RbjMrr7sO1+NwonCcGRKihY29Mdf40YmUC26Sj1hXME46rfIhjC3Xu5Psy5
         TTxGh+/V0hYDuAWHWpJZTS9jGxm4bmgSAqMKCj/bFfEZrXApZDpk7775623vPrwqzrYd
         F1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708566746; x=1709171546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfikugucBiz+mFSGLjwANbX0NZhAAMQYJMToeenA2Ek=;
        b=c8kMar5Djam3e4ARN28UADr9MWYaa3zYPyb2/4EvINeXzfZMbQ/F03oH+3G+KL7jD4
         P62YfU0GPrOFr+uYFf+wScsGXu2dsq8S5cTPSwTTeFYS7T8okuZ7D6kOO8rdqHz1k36R
         Zy9+ttVdkOpTW64xQl0a0YT9903T+l0LEDSeL2MggWOefntORUWtQHgx/Fr8MxHkAwDZ
         pM0KVTnjvfWCRLpVXjP5e6aaHVbIEdGPolGXbMifE1tTp5Ti/KeH44jSwQ+R8xndvXqD
         mbuemNd9P7iXS/9ow050OUD4rHB7SxeZq8EDONIJ642FYTt/kdMnmdoG88jLEZt9Q+6I
         M9DA==
X-Forwarded-Encrypted: i=1; AJvYcCW9rd78ifdRmnru+ehOrDmJ9ah4MZpHSEOCWNtTwIj8dXjlDu9Jh5ZbCz+e9lVX3bLd7pBH5EX+cV+5T1V7maaV1W/ONLn/wsyqNHHfRIfL0ynlCYkuuG7fTBm+rt0AaRqK+cO0N/DV
X-Gm-Message-State: AOJu0YzdwlbUvDTBI1OZFCdTrl567p7mNghzqOvwDPE/0QfImWT1pNK2
	NBNiCBy6Gokw8w0MuXR6fOyWacnaXzhCSIK0JMAQfHu6nUJX5ZgYi7A6X9JIM2jHtPVAe6eEt2p
	+YDdku8xo9CmOrWPy65GGLGPjDlo=
X-Google-Smtp-Source: AGHT+IGl6O2bvxEb6i+n3qN7lg0Ih5ZnjR+6GTWCaKStMtkwZGXMHk4HkYtPdZw/sVFQOtCT9VM8yAs9uY+SU/SoWsU=
X-Received: by 2002:a05:6870:831e:b0:21e:f7cc:24e2 with SMTP id
 p30-20020a056870831e00b0021ef7cc24e2mr9503826oae.40.1708566746387; Wed, 21
 Feb 2024 17:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219074634.2039-1-xuewen.yan@unisoc.com> <ZdTXWrB8dascOIM_@slm.duckdns.org>
 <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com>
 <ZdWNvolkfPCyMNj9@slm.duckdns.org> <CAB8ipk9FtgYh5Ho-nFQCwUO8zOPEk73VS0KHFDuRS9yxDRpe4A@mail.gmail.com>
 <ZdY2htJ5D0FisH1M@slm.duckdns.org>
In-Reply-To: <ZdY2htJ5D0FisH1M@slm.duckdns.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 22 Feb 2024 09:52:15 +0800
Message-ID: <CAB8ipk_JyiuVrFCXQJieA96WpxhwG+MxBXsfoUB2HML37O_YUw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
To: Tejun Heo <tj@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jiangshanlai@gmail.com, corbet@lwn.net, 
	paulmck@kernel.org, rdunlap@infradead.org, peterz@infradead.org, 
	yanjiewtw@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun

On Thu, Feb 22, 2024 at 1:44=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Feb 21, 2024 at 07:00:55PM +0800, Xuewen Yan wrote:
> > This way looks simpler, but it could not disable the warnings, but I
>
> Yeah, I meant that it'd make sense if the value 0 disables the warning.

Okay, I will add it.

Thanks!

--
xuewen

