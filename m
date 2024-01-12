Return-Path: <linux-kernel+bounces-24509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2AF82BD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F32D1C2542D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344860B87;
	Fri, 12 Jan 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3A+iseE"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9B5FEE5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28e0786edb3so313819a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705052809; x=1705657609; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bUc2o+rZA86Fo0/CtpYeZ5xSfMhRE1RobEkrrUZeOAs=;
        b=N3A+iseE4hoBmzsOKR7FEjMlUMjeu8dGOtVrCFVbd7qG+DrUrp89DEBqgaz/bsBA4A
         HRC3PK/aJRjDM/AXjjclg7jzPQtEDLHve6B6F1Z16oIsKja9ib3FLZKo8PlL0fzAqn/Z
         InFDsqhlHzq8Rx9okWK9Alfymknple7EzTmx2NW1JmUxUcoP43n4z016i7PI3lTXZ7PB
         CuvlMxemOTP51q6/2NVperTD5EDHCtgwGCEyjQjNfTtLPG3f7jHFBU+LB0fZpfexQV4W
         pcsJSe+t0l+9LI7MD26pcdHS9Yd2GpKmyOtemHWdvG1gkQmM2/tc9KJ2jZwFV+R9jX9Q
         CK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052809; x=1705657609;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUc2o+rZA86Fo0/CtpYeZ5xSfMhRE1RobEkrrUZeOAs=;
        b=XMMGdX4AWEONfvlbZuAAreSShcPLgU2Z9YY52M5RyDOYUWcdZrR1nOw1Y2Hyknxp9K
         qJ5ed9QRsG/izndKwI4C8A10cpJ2C843L8EwA1+uSZCv6wyvrR/jpNYDeL+Em3fwOb7y
         E7b7qjcoT+ec/zshh4rgCiDkhvSh8oLQWKHVORgSHEOwZpu8uDnOxqMvHga1IbL6HO+x
         HsShsynTmErFlDtIyPtZtITEG0k8UdcC1aXq41QTIZ2aimJQDMeRpq3qtKuUE8Lk09+j
         26Mlrej0ztr/eu+3lQsI8yWHKHEh8J9MXjxlwYn8X+AdFLGJhSVJGodkrDmh+NxyMAwF
         YX9A==
X-Gm-Message-State: AOJu0YwBoagdlE36nydsy5Kgwa+7FBOgHbJ/jjcr6I0Jhf6M4wF3GIz5
	pNxCA5nhP9gUpxITwVbGsstgPwuIC9GpZJvaJmVo9Yvq
X-Google-Smtp-Source: AGHT+IE8ZEWnQjMuyR79qpKZMBj9/Vr90x0dSkOlsccgmJMF5hwKvykQvR+TrOZzrB00TvmmasR4n8woqKHnNP4H6Mo=
X-Received: by 2002:a17:90b:17d0:b0:28d:c998:8935 with SMTP id
 me16-20020a17090b17d000b0028dc9988935mr1130258pjb.37.1705052809158; Fri, 12
 Jan 2024 01:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dwayne RIght <rightd942@gmail.com>
Date: Fri, 12 Jan 2024 01:46:37 -0800
Message-ID: <CAAZfa0h=8Lo5rxvjrycL_61+y71Vr7FzQoYeENTy4HF2mAEURg@mail.gmail.com>
Subject: hi, i have a suggestion if the community cares to narriate: essays
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

we can have a page where people can try to submit essays on the linux
kernel and unix development and it could be like a cool thing, we can
even hook it up to nntp

and im slowly learning kernel stuff through your patches, slowly, cant
wait to tackle on 2.6

