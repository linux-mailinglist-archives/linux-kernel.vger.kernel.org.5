Return-Path: <linux-kernel+bounces-49985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E553C847299
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A127529772B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25970145B05;
	Fri,  2 Feb 2024 15:06:16 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4077145328;
	Fri,  2 Feb 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886375; cv=none; b=MlsoA89tQG9bRJwIUAdXIfTh2ch9fKpIOUPFDAK3etuVGzcOSMyRFOGbvsLA2dzquwEUX0fBq18835QyEnY7cXo1HiwyREG14Ka4rEEvctypyAllkqZf0bZKat5nhF2ZpukbihiersDdclhj9Td9jZGCJsBfaHRtkk/G4QuW5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886375; c=relaxed/simple;
	bh=r9oRtGj/+8aZLvVfehjr7KiW7ukMiB5gxSbtmpOmMBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJIffwdBjXuX4cuU7QUvCqaX/ot2lNBDPh99q0PTwWe97gnxbXR/3s9oi1nZHBH7tIkR8EHdX7IONMZz2/0v00+qmzkc2YlmnFW5Lv7d9RTJwSKnZ2lhaN1FXej2/deBahmRP+80AKZWxQsXiqVdyMwPRDYCheala0VQ/C3OQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso6386681a12.1;
        Fri, 02 Feb 2024 07:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886372; x=1707491172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dy6xsG+V8b8gXKselPRYjvb8k200RV2mccv1oGl2LE=;
        b=Hzy0lRwmfNIwkPDyBC1OaRDLvQes9U08Du1MOPZUDWYI1pagMshDNlbUUAnAk8twzw
         xITwv259LFYzzklhnTxQyfS8Y1BbayEmrhO1mK5C2wWsOV6vNh1QWmXVN5dXUmtLPYMZ
         uGOVJ1bJUZu8uAfxIxURMt4I5U57QUannL9+oPJnoX9SQ16haDIG8UasTE1ztkHqPwBN
         ctOhJQNk9tAaD2PSguC/XPJ5gkBEy/Ram2GxsWVvLWeeGYTDkT3om3tHQKdrahvqq1D0
         raxhJ3ePqSoDnbjyqSXkTbzfAGnW6RL8LzeQqBPRVB/IlrlaI3D9tYaESV/73wJ99XlF
         YV5Q==
X-Gm-Message-State: AOJu0YymJq+QOaXRNHlTmPvdmEQuQCCwtR46LoByseKpl0kwUR/ZHzay
	dmE39+1moruUj5aXlQgb63nKry7JdEwB5T2WPIatyHtrptFUwZk8
X-Google-Smtp-Source: AGHT+IE8n5KTQY5SyVsgub6XSdEUObBjCmVWKcFwKFwC3lLR4ut//ApkA0ZEIEmKaiok3AAQk4DOPA==
X-Received: by 2002:aa7:d757:0:b0:560:7f1:9b27 with SMTP id a23-20020aa7d757000000b0056007f19b27mr578865eds.6.1706886372002;
        Fri, 02 Feb 2024 07:06:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXnsHetWBPy+LEx1gFH41LDg1hj64YGURysryaxzIUct6ZMicMkTdEWf8rz+3WWtLEfUTxo6Hz0YcCymyrTV6NBad4zMeEbqdQ7BgahEOZUuZBtH/Jbv4GmTHBDKXXgui6wc+0y2ATEtvaE3+vdB71iteA39rPBZe+6efVaiSnWozj70dDz5rbFjvs4MA==
Received: from gmail.com (fwdproxy-cln-024.fbsv.net. [2a03:2880:31ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7d411000000b0055c97f940fcsm865657edq.81.2024.02.02.07.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:06:11 -0800 (PST)
Date: Fri, 2 Feb 2024 07:06:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dqs: NIC stall detector
Message-ID: <Zb0E4RQzoNDGL2AE@gmail.com>
References: <20240131102150.728960-1-leitao@debian.org>
 <20240201081432.3fa70c6c@kernel.org>
 <ZbvnTNT28EpoGSdU@gmail.com>
 <20240201114318.72eb52e1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201114318.72eb52e1@kernel.org>

On Thu, Feb 01, 2024 at 11:43:18AM -0800, Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 10:47:40 -0800 Breno Leitao wrote:
> > > Let me take this on in, but the other one is not a fix,
> > > so it has to go to net-next.  
> > 
> > Sure. I didn't know how to split the dependencies. Maybe I should have
> > sent both of them to net-next, and you would cherry-pick the fix to net?
> > Is this a better approach for next time?
> 
> You gotta send the net part and then wait until Thu afternoon Pacific
> time when Linus pulls from us. We then pull net (and Linus's tree into
> net-next).

Thanks for the clarification. I will wait for that before sending the
second patch against net-next.

