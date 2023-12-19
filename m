Return-Path: <linux-kernel+bounces-6037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7E819366
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B1EB257A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8A3D0AC;
	Tue, 19 Dec 2023 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbgAFucS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED43D0A2;
	Tue, 19 Dec 2023 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e2bd8c396so4315376e87.0;
        Tue, 19 Dec 2023 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024165; x=1703628965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpXY5hYmX0qfZxaaRZ2hbLsbfa0QJNMCX/B4+utVEqE=;
        b=NbgAFucSE66H6QmKfjsVKB4arUmg6nGTps15MM5sR7p/67c/OjW5/s21wUvEvdpIwe
         0YXVGR9knvg1C7eA8AAKLahOrTZi8XoZSNgqW5aluRZ7OL2PrygHuvpfhcwDhkvu2ZNu
         /x6BW+lhEif9y5PwFJ4yT9ue0iTqZjRTO+uytaNkvzOnbe0qoZuKeg4/USvQO0Et9oZN
         AYBw2eWg1USgoyE3Mm0gEJCCkozSzawo+7kJJ722cdFAfGOsKe7Z59VCNO8eOpl3e1Za
         TAmltFTaq4Tp/lpGZA9ue1ft18RmZgy8jlMDDZYzAGkr/Xiu0BgVQdbf3VJ9Lm0m4IyM
         lPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024165; x=1703628965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpXY5hYmX0qfZxaaRZ2hbLsbfa0QJNMCX/B4+utVEqE=;
        b=xMSsIHbqk9amUcc6mPg8leO0F0gwepD+GFSsWzoYo1oCcQ4qYPz8LzvLycBujiuwTj
         WIk0FfHFcC+9gHctIO852Mu8x3D96wGKRCUL/b7nxcOvtEUOzzNkaB8NDK1MeUNFk0EI
         E9rUiyK+d8vlIDrTGF1ZPSy9OwzTF1yQGhpAqoA17ZLpg/0WJ4gNrsvsYRGu264gFZa+
         7B+RYQaTfaNfcSpnkr01a6xI7Z2mpNxDu3Jh2eDqzPZhr+y8Pr/8gB2NPFG7a3JB7xAW
         ZJXm0FGOO4KhBa/QwEIgbf4OCtjE6flJpwidhvyccMHA7ZQ6P9dXZdvsed05yjTDSQZi
         jN/w==
X-Gm-Message-State: AOJu0YztuygP9+CQ0cNhLPbKNXkyLIx+oTwnUaQkVQ4bblJfeXOfEpIk
	Cvy8cikYvZbm4URzWIUCsmA=
X-Google-Smtp-Source: AGHT+IFBo7Yg9h7ls15O6tkpIx5j3Mp2CgGeRXnr3DznPPjsgogxAHyDZOD9jrg8dYGvrnsS9ykWzA==
X-Received: by 2002:a05:6512:b84:b0:50e:3b0b:8cd1 with SMTP id b4-20020a0565120b8400b0050e3b0b8cd1mr2421659lfv.95.1703024165047;
        Tue, 19 Dec 2023 14:16:05 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id s25-20020a056512315900b0050bf8ddb1c3sm1085234lfi.272.2023.12.19.14.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:16:04 -0800 (PST)
Date: Wed, 20 Dec 2023 01:16:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <kj6r7ovlim3nd22rvkpfgmssl3vhef4qfo4kxguxbfrtdsgaly@ir3bjtayl7pn>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
 <20231219-whispering-independent-bonobo-d14a04@lemur>
 <yko4bwzrnlvncljpgyxlsvioqeyf3zxb255qexlawooqjxvedn@dkr7i7fame3n>
 <20231219-fluffy-labrador-of-inquire-fafb28@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-fluffy-labrador-of-inquire-fafb28@lemur>

On Tue, Dec 19, 2023 at 05:10:02PM -0500, Konstantin Ryabitsev wrote:
> On Wed, Dec 20, 2023 at 12:58:16AM +0300, Serge Semin wrote:
> > > It's a known limitation at this time, but it will be improved in the near
> > > future and we'll be able to grab trailers across revisions as long as the
> > > patch-id remains the same.
> > 
> > Ok. Thanks for the note.
> > 
> > I am sure you are well aware of that, but in some cases the tags are
> > intentionally omitted in the new patch revisions for instance due to
> > significant patch body change. How are you going to handle that?
> 

> The patch-id (generated with `git patch-id --stable`), would change if the
> patch body is changed (except things like whitespace). This is exactly the
> behaviour that we need -- if a tag was sent to a different version of the
> patch, then we no longer want to retrieve it.
> 
> > Just make the tags picking up optional? Perhaps making the tags handling
> > interactive with printing a text/context around the tag?
> 
> We may indeed be able to do --interactive for some of the commands in the
> future, but the goal is to automate things away.

Got it. Thanks. Can't wait to see that in action.

-Serge(y)

> 
> -K

