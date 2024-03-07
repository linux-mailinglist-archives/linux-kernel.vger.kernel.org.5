Return-Path: <linux-kernel+bounces-95652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB78750BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95221F248CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549212D212;
	Thu,  7 Mar 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/pf71CK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989D12D740;
	Thu,  7 Mar 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818933; cv=none; b=Ak5dyLkwEf/Hp97xhGMNN5zVZsFr2pRDICAh7rmHtPs1gwvhVf++uDdJK97VHjtTuBgjAN4dAYUa965lOQIq/jKBzXkc9cAq6XnrQJcEBW0L5tgJd4jUfXL90cBHdHUUy3fIZvkTQ/Jd7hJtVT+FlcKA8biaYqvAU0R8t0V/MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818933; c=relaxed/simple;
	bh=eerM3hiqwqeDIiaLPjjDKrALxrDo2REmYNtR6GjmEjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3V9tsxBU5zMn09Hn2hMa5p6PzggJn/CpZ++tK43OneOWm8k5tbp3MAFB+fDqs7miVAAOmAWmIHG1bSjQSfhzokhcUTfkcB/XI73DQQtKTXoqq9a3upps3eW8lrg55OAG2omn/m2R6XuBGyy3dAots8/TOq04ZAgmUOSTrhExF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/pf71CK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51320ca689aso918443e87.2;
        Thu, 07 Mar 2024 05:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818930; x=1710423730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qnF8BPNjxJ8K/TF3RMW7rPF5KtBEwyGXkbhBH+pChQ=;
        b=X/pf71CK6DRqD2yTxs00G1FZIfiDLzJUtA5EUfi0C0rRCgtuf1oIwHNQCUO6egvwRz
         mLq/gxmuPw7g00dHx1mVYK5dZq8HKjTuu1S1YxggVhCvHXlwE+Ww1+3Wtq4XvhN/QqCx
         JkGe/wSa6EGdrBLSEYxJqDC5t/b1F+ZviAD2cTJjdi69WwZlIAyRjHDLajFkjPEvTj3A
         jdN3hFdWz8tdcGUHVHKUNUHCoUv0Jr4EOa7h1qj9URLj+Er6KCTCahUHpHf0eT5ya5tz
         WzmidayrksUw79TSIr/6NBcmxcYhGkZUIc6j50ltWYjbJJGdk2ly28ONnx+LJGIX/DJI
         XnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818930; x=1710423730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qnF8BPNjxJ8K/TF3RMW7rPF5KtBEwyGXkbhBH+pChQ=;
        b=xLpBNlJgMa/msDUKdFaT7cJGl3odthsI0TR9Au9h/IhiCSRsnd98n3vAiFHIIVu9Yz
         qoi63hB0yNrGiv5+PawAyT3GkP+gueEnvW1pMU5DyvKApy6Is8iV0y5jRaK51ac35yGK
         TzPwDvgnDin41GEANDYKeltO3hFk7mJVKDtSPq8q1oaPXjR8qp1uGSDGkmuH/5zsuKE1
         NhkBoLP/RiRU3T1xh/2BqaH0n4KvR5cB0CwmUdRjt0oi8yOafgbftL8bsWk9Sl3F2owd
         swQ1yVNPv9L8M1WTe8m7FOUKpLCIqPgUYQhw5Mbj5aUgweQlPnlVNSXC+87VkaRO1Tq+
         py0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+1kslRMWr3NirBcpbBiwigbnhsOSyZzH9Exi9l9//nl5MSVy5MUKmC69Dygg98C5QedRCX9IJJRFGQKxBN6PNWsDiTtieADAxTJeuZGzkFn0mvcsZPagMW2KEgHvXXjNhPxXbOwZcSDbJeXE=
X-Gm-Message-State: AOJu0YzfEVBI0aWkF/YIrNgTxzR/lmKzzYNtao7M38KaMRpjY8KychHI
	CNqEVjMjlNRbooi7Ob2yNSjYsw76gtxsCZhjUGdZjjnQYKl+Qd5S
X-Google-Smtp-Source: AGHT+IHbkPRl1kCxLX77oo2TcdE33qOWzJsDdD/rToFKNCZJKYc9M90wyto9BSmCoMfxZnkY6t2oTQ==
X-Received: by 2002:ac2:511b:0:b0:513:116d:4d9b with SMTP id q27-20020ac2511b000000b00513116d4d9bmr1401300lfb.60.1709818930079;
        Thu, 07 Mar 2024 05:42:10 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id l10-20020ac24a8a000000b0051321a5b0b8sm3062665lfp.201.2024.03.07.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:42:09 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: jonas.gorski@gmail.com
Cc: deeb.rand@confident.ru,
	khoroshilov@ispras.ru,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	m@bues.ch,
	rand.sec96@gmail.com,
	voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Thu,  7 Mar 2024 16:41:42 +0300
Message-Id: <20240307134142.169523-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAOiHx==HHd3Nu=p5192=tOP-kAzJZUg2iRO2j8UCtcpfGT13nw@mail.gmail.com>
References: <CAOiHx==HHd3Nu=p5192=tOP-kAzJZUg2iRO2j8UCtcpfGT13nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Mar 6, 2024 at 10:51 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> Hi
>
> The NULL check is what needs to be fixed/removed, not the code
> surrounding it. This function will be called from dev_uevent() [1]
> where dev cannot be NULL. So a NULL dereference cannot happen.
>
> Most other implementors of bus_type::uevent have no NULL check. To be
> precise, there is only one other implementor with a NULL check,
> rio_uevent(), and none of the other ones have one. See e.g.
> bcma_device_uevent(), memstick_uevent(), mips_cdmm_uevent(), or
> fsl_mc_bus_uevent().


Hi Jonas,

Thank you for the feedback. To be precise there are actually 8 other 
implementors (and potentially more) with a NULL check not just one 
(parisc_uevent, serio_uevent, ipack_uevent, pci_uevent, pcmcia_bus_uevent, 
rio_uevent, zorro_uevent, and soundbus_ueven).

After a second review, I totally concur with your observations. I quickly 
judged, I believed there might be an alternative way to call the function 
because it's not the only one with a null check, and actually the patch 
version 1 got accknowleded, that's why i'm confused. 

Given that null is improbable in this context due to the calls being made 
through uevent, we should eliminate the redundant condition. In light of 
this, would you recommend sending a new version (v4) of the patch with the 
correct title and info, or do you think it would be more appropriate to 
submit an entirely fresh patch? i'll also send patches to all of the 
implementors.

Best regards.

