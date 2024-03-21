Return-Path: <linux-kernel+bounces-109916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB58857BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F4F283F69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117957877;
	Thu, 21 Mar 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qA42Oku4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2617F7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019053; cv=none; b=XBRZhkp9qMYO2mGDnCDYN8/46qsCTGUc57t4QddJYmR4Y8huj/A4o4nI/pCMHnoRjQJiG/QpBFMrFFqsnNMQq5GfoFtxE2gCc0zTp6+fGmoF79mEpRYYQ6MlwJ3afMMONf7OhZgfSA8urcly9Qe4wY4SAYB9U6XDwU+Z/nu4u7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019053; c=relaxed/simple;
	bh=byi2AR2z6WKqvWWijQ8qSi+D5IrNykDN7WeRnTWUSgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCstI7TQrXWZSEpqm9IWfdJF10+EcsMhRpktMF+SKxlqoxBOffrkyDbkXqFE+H/4DaJIYkLZMM39NLewsxR0yvuvhGvTZSkLj5ZWy/BBhSFozYKovGANadyKyHF/f+n7ugb1++LvBybsVh6JRVOqhnQgmg/QouldVzwNFFhaI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qA42Oku4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e39226efso719965e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019049; x=1711623849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0TlLN0BMwnJ+UpSK4jvuBdM2+J+Dj1/xcdLP2bxFwM=;
        b=qA42Oku4iPuJAVXG2+RsUvXj2Qh/wGXKrMrYYHPzA5oKoOQ9Aw1qZzVsPikyE5ZsjA
         FZzMeCf6pUR382eXD7Qd34VOQH2fUi/4sRxWQxFwl2ErjMB47OCM+rzhtGKv2YcfHF3m
         EXT5aHxysNotwp3d+b3kBGDDrnG3aGa16jMfpkWFmcnTpjj9M2kozO25bmlBd8L2ngqw
         oo7heyTunOsZAKOORmxsMKNTthzYg1Y2r4nxonoZHbi7cebcau/wPYu+uTg3eRVGH0FL
         t5/n9v8EnpnbkU9R35xFS3cVFC3e/BNJkJlK0keKj6vF9EYPdMxqdUygCl3asVC8GoHp
         54nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019049; x=1711623849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0TlLN0BMwnJ+UpSK4jvuBdM2+J+Dj1/xcdLP2bxFwM=;
        b=AaXDnXoCe7BM0w69aH3N9fbHsqUChxYW+AcKriKIWP8f6PTI0Rew0Axkj1q43+OWZ7
         NrcMhQbmdMgO4ysvXpNM8BrYPthMMfIC8HPhlwpjM3slahKYU09QZHFaodK87wF61rUY
         Ij3RKykyCsLFIcdbbnIOacWToV2kUu/fmYOCxtelxZy65u9hlIdhDo8jeohcPxIUh4eg
         LGZ4hV0bUCeRSkw9uV/eoZ1E/EOCP1YPV4BEQlM99bnyojigi9Z5UowVWjT+AYGyF4tU
         z0agWPuds/Izu5o74W2qG3p8+3I/LeHZiU8n2tqO3uBhBqenD1MWk4KhnZh4/2bLlue5
         6h8g==
X-Forwarded-Encrypted: i=1; AJvYcCVkIFqffssxc8Z43NWoCSOH7DVd5cbUI7s8xBbnvsa6UahzefNDGMucNmQynYsAQ45yBqgmdzcBHfZB2C2gagA96u7X1aq+dVGBgjY9
X-Gm-Message-State: AOJu0YzwlgIr3mXfG1SLAc9UnW2yCWWH+ueOF1yofhm8/lf6QWtC/BC7
	HRHgF3hBkZakizJT0gWAEzO9IM62IlvvbQ3wGxXwIEnTMXZ4mj18gg0gbw6HS7I=
X-Google-Smtp-Source: AGHT+IEqisjMLI8hi5BcvMJ9JSYdKJ4s9qTck9CnSoGjSt4euGRQ1UsKn6uxN86qyPFuWIy/k85Umg==
X-Received: by 2002:ac2:5a0a:0:b0:513:cf73:d8d2 with SMTP id q10-20020ac25a0a000000b00513cf73d8d2mr11555976lfn.54.1711019049329;
        Thu, 21 Mar 2024 04:04:09 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c4ec800b0041408451874sm5225401wmq.17.2024.03.21.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:04:08 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:04:07 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH V3] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <20240321110407.GB7342@aspen.lan>
References: <20240320162802.GA22198@aspen.lan>
 <20240321022604.4088438-1-liu.yec@h3c.com>
 <2024032137-parrot-sandbank-ab29@gregkh>
 <3cb0b32b8b4946efb93ce68729d4c321@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb0b32b8b4946efb93ce68729d4c321@h3c.com>

On Thu, Mar 21, 2024 at 07:57:28AM +0000, Liuye wrote:
>
> > The stack trace below shows an example of the problem. In this case
> > the master cpu is not running from NMI but it has parked the slave
> > CPUs using an NMI and the parked CPUs is holding spinlocks needed by
> > schedule_work().
>
> Add description information
>
> > Signed-off-by: LiuYe <liu.yeC@h3c.com>
> > Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Add
> Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

I assume this reply is summarizing what changed between the previous
version and v3?

The best way to add the changelog requested by Greg's bot is to send
a corrected v4 version. If you follow the example in
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
then you'll see that what is expected.

You can use git-notes to handle this. If you add a note containing
something like the following:
~~~
Changes in v4:
* Provide these changelogs.

Changes in v3:
* <please describe changes>

Changes in v2:
* <please describe changes>
~~~

Once you have the note than git-format-patch --notes will automatically
included the changelog with the patch.


Daniel.


PS I know that v2 was circulated with an incorrect subject line but I
   think it is probably OK to call it v2 anyway... it makes the
   changelog clearer!

